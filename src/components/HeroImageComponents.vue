<template>
  <div class="block text-center z-0 w-full h-full m-auto">
    <el-carousel autoplay>
      <el-carousel-item autoplay v-for="item in imgItem" :key="item">
        <img :src="item" alt="" class="bg-cover1 w-full h-full opacity-70" />
      </el-carousel-item>
      <div class="flex z-10 justify-evenly items-center w-full h-full">
        <router-link to="/">
          <button
            class="absolute bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
          >
            Home Page
          </button></router-link
        >
      </div>
    </el-carousel>
  </div>
</template>
<script setup>
import axios from 'axios'
import { ref, onMounted } from 'vue'

const imgItem = ref([])

onMounted(() => {
  getSettingImage()
})

// 資料庫拿圖片的網址
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
    imgItem.value = res.data[0].s_url.trim().split(/\r?\n/) ?? ''
    console.log(imgItem.value)
    // result.value = imgItem.value.trim().split(/\r?\n/)
    //         loading.value = false
  })
}

let height = window.innerHeight
let style = document.createElement('style')
let cssContent = document.createTextNode(`
  .el-carousel__container {
    height: ${height}px;
  }
`)
style.appendChild(cssContent)
document.head.appendChild(style)
</script>
<style scoped>
.carousel-item {
  color: #475669;
  opacity: 0.75;
  margin: 0;
  text-align: center;
}

.el-carousel__item h3 {
  color: #475669;
  opacity: 0.75;
  display: flex;
  align-items: center;
  margin: 0;
  text-align: center;
  height: 100%;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n + 1) {
  background-color: #d3dce6;
}
</style>
