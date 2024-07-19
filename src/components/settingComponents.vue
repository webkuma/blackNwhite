<script setup>
import { ref, watch, onMounted } from 'vue'
import { onBeforeRouteLeave, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { useVerificationToken } from '../stores/counter.js'
import axios from 'axios'

const router = useRouter
const store = useVerificationToken()
const textarea = ref('')
const lines = ref([]) // 把textarea split > array

onMounted(() => {
  getSettingImage()
})
// 去資料庫拿圖片網址
function getSettingImage() {
  axios({
    method: 'post',
    url: '/api/handle_select.php',
    params: {
      action: 'getSettingImage',
      data: {
        account: JSON.parse(localStorage.getItem('token')).account
      }
    }
  }).then((res) => {
    textarea.value = res.data[0].s_url ?? ''
  })
}
onBeforeRouteLeave(() => {
  stopWatchRoute()
})
const stopWatchRoute = watch(
  () => textarea.value,
  (newQuery) => {
    if (newQuery) {
      lines.value = textarea.value.trim().split(/\r?\n/)
    }
  }
)
/* 簡單講是顯示時前台一排顯示三個 所以設置 imagesPerRow = 3
 * 每三個 push 到陣列，如果要改數量就改它
 */
function groupedLines() {
  // lines 是把圖片網址分割後存成的陣列，陣列數量 <1 就跳出
  if (lines.value.length < 1) return false
  lines.value.forEach((item, index) => {
    if (item === '') {
      lines.value.splice(index, 1)
    }
  })
  // lines 按照每行 imagesPerRow 個數量分组
  const result = []
  const imagesPerRow = 3
  for (let i = 0; i < lines.value.length; i += imagesPerRow) {
    result.push(lines.value.slice(i, i + imagesPerRow))
  }
  return result
}
// 儲存圖片 axios
function handleImageSave() {
  const headers = store.getAuthHeaders()
  console.log(JSON.parse(localStorage.getItem('token')).account)
  axios({
    method: 'post',
    url: '/api/handle_update.php',
    headers,
    params: {
      action: 'handleImageSave',
      data: {
        url: textarea.value,
        account: JSON.parse(localStorage.getItem('token')).account
      }
    }
  })
    .then((res) => {
      console.log(res.data)
      ElMessage({
        message: '存好ㄌ！',
        type: 'success',
        showClose: true
      })
    })
    .catch((err) => {
      if (err.response.status === 401) router.push('/login')
    })
}
</script>
<template>
  <el-container class="h-screen overflow-y-auto bg-blue-50">
    <el-header class="flex items-center justify-between font-black text-xl shadow-sm">
      <div class="m-4"><span>設定圖片</span></div>
      <div class="m-4">
        <el-button plain type="success" @click="handleImageSave()">儲存</el-button>
      </div>
    </el-header>
    <main class="flex m-8">
      <div class="w-1/2 flex-col">
        <h1>預覽圖片</h1>
        <div v-for="(group, index) in groupedLines()" :key="index" class="flex p-4">
          <img :src="item" v-for="item in group" :key="item" class="max-h-[30%] max-w-[33%]" />
        </div>
      </div>
      <div class="w-1/2 h-full">
        <p>網址之間直接用enter隔開就好</p>
        <el-input
          v-model="textarea"
          :rows="2"
          type="textarea"
          placeholder="Please input image url,"
          :autosize="{ minRows: 10 }"
        />
      </div>
    </main>
  </el-container>
</template>
