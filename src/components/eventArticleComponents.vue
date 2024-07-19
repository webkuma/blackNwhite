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
// editor params
const editorTitleName = ref()
const editorContent = ref()
const editorImgUrl = ref()
const editorDatetime = ref()
const dynamicTags = ref([])

const eventModeData = ref()
// 處理側欄點擊後的參數
onMounted(async () => {
  if (route.path === '/eventarticle') {
    await router.isReady()
    updateRouteParams(route.query)
    getEventTitleAndContent()
  }
})

// 更新路由參數
function updateRouteParams(query) {
  routeParamsName.value = query.name || ''
  routeParamsLevel.value = query.level || ''
  routeParamsId.value = query.id || ''
}

// 監聽路由參數
onBeforeRouteLeave(() => {
  stopWatchRoute()
})
const stopWatchRoute = watch(
  () => route.query,
  (newQuery) => {
    if (route.path === '/eventarticle') {
      updateRouteParams(newQuery)
      getEventTitleAndContent()
    }
  },
  { flush: 'post' } // 使用 flush: 'post'
)

// 取得資料
function getEventTitleAndContent() {
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
    eventModeData.value = res.data
    editorTitleName.value = res.data[0].a_title
    editorContent.value = res.data[0].a_content
    editorImgUrl.value = res.data[0].a_image_url
    editorDatetime.value = res.data[0].a_datetime
    dynamicTags.value = JSON.parse(res.data[0].a_tagName)
    console.log(eventModeData.value)
  })
}
</script>
<template>
  <el-container class="h-screen max-w-4xl w-full m-auto">
    <el-header class="flex items-center justify-between font-black text-xl shadow-sm">
      <div class="m-4 w-full flex justify-around">
        <div>
          <el-tag v-for="tag in dynamicTags" :key="tag" class="mx-1" :disable-transitions="false">
            {{ tag }}
          </el-tag>
        </div>
      </div>
    </el-header>
    <!-- 未選擇時的提示文字 -->
    <div v-if="!eventModeData" class="m-4 font-bold text-center">
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
    <div class="mx-4 p-4">
      <p class="text-3xl">{{ editorTitleName }}</p>
      <p>{{ editorDatetime }}</p>
    </div>

    <div class="mx-4 p-4">
      <div v-html="editorContent"></div>
      <div class="overflow-hidden rounded">
        <img
          :src="editorImgUrl"
          alt="cover image"
          class="object-cover w-full h-full"
          loading="lazy"
        />
      </div>
    </div>
  </el-container>
</template>
