<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRoute, useRouter, onBeforeRouteLeave } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()
// 路由參數
const routeParamsLevel = ref()
const routeParamsName = ref()
const routeParamsId = ref()
// 編輯器 v-model
const editorTitleName = ref()
const editorContent = ref()

// 處理側欄點擊後的參數
onMounted(async () => {
  if (route.path === '/article') {
    await router.isReady()
    updateRouteParams(route.query)
    getTitleAndContent()
  }
})

// 更新參數，用以獲取資料（axios）
function updateRouteParams(query) {
  routeParamsName.value = query.name || ''
  routeParamsLevel.value = query.level || ''
  routeParamsId.value = query.id || ''
}

// 以 RouteParams 取得資料
function getTitleAndContent() {
  editorTitleName.value = ''
  editorContent.value = ''
  axios({
    method: 'post',
    url: '/api/handle_select.php',
    params: {
      action: 'getTitleAndContent',
      data: {
        id: routeParamsId.value,
        name: routeParamsName.value,
        level: routeParamsLevel.value
      }
    }
  }).then((res) => {
    editorTitleName.value = res.data[0].a_title
    editorContent.value = res.data[0].a_content
    console.log(editorTitleName.value)
    console.log(res.data)
  })
}

onBeforeRouteLeave(() => {
  stopWatchRoute()
})
const stopWatchRoute = watch(
  () => route.query,
  (newQuery) => {
    if (route.path === '/article') {
      updateRouteParams(newQuery)
      getTitleAndContent()
    }
  },
  { flush: 'post' } // 使用 flush: 'post'
)
</script>
<template>
  <el-container class="h-screen max-w-4xl w-full m-auto">
    <el-main>
      <el-scrollbar>
        <!-- title -->
        <div class="mx-4 p-4">
          <p class="text-3xl">{{ editorTitleName }}</p>
        </div>
        <div class="m-4 p-4">
          <!-- 未選擇時的提示文字 -->
          <div v-if="!editorContent || !editorTitleName" class="m-4 font-bold text-center">
            <el-empty description="還沒建立資料，去後台建立吧" />
            <router-link
              :to="{
                path: '/admin/edit',
                query: {
                  name: $route.query.name,
                  level: $route.query.level,
                  id: $route.query.id
                }
              }"
            >
              <el-button plain>Go to Admin</el-button>
            </router-link>
          </div>
          <div v-html="editorContent"></div>
        </div>
      </el-scrollbar>
    </el-main>
  </el-container>
</template>
