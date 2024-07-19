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
// 選模式
const chooseMode = ref('list')
// 放資料
const eventModeData = ref()

// 處理側欄點擊後的參數
onMounted(async () => {
  if (route.path === '/event') {
    await router.isReady()
    updateRouteParams(route.query)
    getArticleEventMode()
  }
})

// 更新路由參數
function updateRouteParams(query) {
  routeParamsName.value = query.name || ''
  routeParamsLevel.value = query.level || ''
  routeParamsId.value = query.id || ''
}
// 取得資料
function getArticleEventMode() {
  console.log(`Calling getArticleEventMode in ${route.path} route`)
  axios({
    method: 'post',
    url: '/api/handle_select.php',
    params: {
      action: 'getArticleEventMode'
    }
  }).then((res) => {
    eventModeData.value = res.data
    console.log(res.data)
  })
}
// @click 導航用
function routerSubArticle(id, name, level) {
  router.push({
    path: '/eventarticle',
    query: {
      name: name,
      level: level,
      id: id
    }
  })
}

// 監聽路由參數
onBeforeRouteLeave(() => {
  stopWatchRoute()
})
const stopWatchRoute = watch(
  () => route.query,
  (newQuery) => {
    if (route.path === '/event') {
      updateRouteParams(newQuery)
      getArticleEventMode()
    }
  },
  { flush: 'post' } // 使用 flush: 'post'
)
</script>
<template>
  <el-container class="h-screen overflow-y-auto bg-stone-200">
    <el-header class="flex items-center justify-between font-black text-xl shadow-sm">
      <div class="m-4">
        <span>事件時間軸</span>
      </div>
      <el-radio-group v-model="chooseMode" class="m-4">
        <el-radio-button label="list">事件列表</el-radio-button>
        <el-radio-button label="timeline">世界時間軸</el-radio-button>
      </el-radio-group>
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
    <div v-if="chooseMode === 'list'" class="m-2 p-2 flex flex-wrap justify-around md:flex-row">
      <div
        class="flex min-w-0 w-full md:w-2/5 m-2 items-center justify-evenly hover:cursor-pointer bg-blue-50 shadow-md rounded-lg p-6"
        v-for="item in eventModeData"
        :key="item.a_id"
        @click="routerSubArticle(item.a_id, item.a_sidebar_name, item.a_level)"
      >
        <div class="w-24 h-24 mr-4 overflow-hidden rounded">
          <img
            :src="item.a_image_url"
            alt="cover image"
            class="object-cover w-full h-full"
            loading="lazy"
          />
        </div>
        <div class="flex flex-col flex-1">
          <div class="flex flex-wrap items-center mb-2">
            <el-tag
              v-for="tag in JSON.parse(item.a_tagName).slice(0, 3)"
              :key="tag"
              size="large"
              class="mx-1 text-lg"
              :disable-transitions="false"
            >
              {{ tag }}
            </el-tag>
          </div>
          <div class="text-lg font-bold mb-2">{{ item.a_title }}</div>
          <div class="text-gray-500">{{ item.a_datetime }}</div>
        </div>
      </div>
    </div>
    <div v-else class="p-4 m-4">
      <el-timeline>
        <el-timeline-item
          v-for="item in eventModeData"
          :key="item.a_id"
          color="#F2FFFF"
          :timestamp="item.a_datetime"
          placement="top"
          center
        >
          <el-card>
            <h4 class="text-xl mb-2">{{ item.a_title }}</h4>
            <el-tag
              v-for="tag in JSON.parse(item.a_tagName).slice(0, 3)"
              :key="tag"
              class="mr-2"
              :disable-transitions="false"
            >
              {{ tag }}
            </el-tag>
          </el-card>
        </el-timeline-item>
      </el-timeline>
    </div>
    <!-- </el-scrollbar>
    </el-main> -->
  </el-container>
</template>
<style>
.el-timeline-item__tail {
  border-color: #f2ffff;
}
</style>
