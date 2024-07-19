<script setup>
import { ref, nextTick, onMounted, watch } from 'vue'
import { Position, Delete, Check } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { useRoute, useRouter } from 'vue-router'
import { useVerificationToken } from '../stores/counter.js'
import Editor from '@tinymce/tinymce-vue'
import axios from 'axios'

const store = useVerificationToken()
const route = useRoute()
const router = useRouter()
const loading = ref(true) // 載入動畫用
const size = ref('large') // datepicker 用

// 一般/重大
const editMode = ref()
// 編輯器 v-model
const editorTitleName = ref()
const editorContent = ref()
const editorImgUrl = ref()
const editorDatetime = ref()
const editorSidebarName = ref()
// tag input
const inputVisible = ref(false)
const inputValue = ref()
const dynamicTags = ref([])
// 路由參數
const routeParamsLevel = ref()
const routeParamsName = ref()
const routeParamsId = ref()

// 先放著 這是改 彈出視窗的文字大小
let style = document.createElement('style')
let cssContent = document.createTextNode(`
  .el-message-box p { font-size: 1.2em; }
  .el-message__content { font-size: 1.1em; }
`)
style.appendChild(cssContent)
document.head.appendChild(style)

// 處理側欄點擊後的參數
onMounted(async () => {
  await router.isReady()
  updateRouteParams(route.query)
  await getTitleAndContent()
  watchRouteQuery()
  setEditorMode()
})

// 設置編輯模式顯示樣式
function setEditorMode() {
  editMode.value = editMode.value ?? 'normal'
}
// 更新路由參數
function updateRouteParams(query) {
  routeParamsName.value = query.name || ''
  routeParamsLevel.value = query.level || ''
  routeParamsId.value = query.id || ''
}

function watchRouteQuery() {
  watch(
    () => route.query,
    (newQuery) => {
      updateRouteParams(newQuery)
      getTitleAndContent()
    }
  )
}

// 取得文章資料
async function getTitleAndContent() {
  editorTitleName.value = ''
  editorContent.value = ''
  dynamicTags.value = []
  try {
    const res = await axios({
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
    })
    console.log(res.data[0])
    editorTitleName.value = res.data[0].a_title ?? null
    editorContent.value = res.data[0].a_content ?? null
    editorImgUrl.value = res.data[0].a_image_url ?? null
    editorDatetime.value = res.data[0].a_datetime ?? null
    editMode.value = res.data[0].a_editMode ?? 'normal'
    editorSidebarName.value = res.data[0].a_sidebar_name ?? null
    // 改
    if (JSON.parse(res.data[0].a_tagName)) {
      dynamicTags.value = JSON.parse(res.data[0].a_tagName)
    }
    console.log('dynamicTags.value: ' + dynamicTags.value)
    // dynamicTags.value = JSON.parse(res.data[0].a_tagName) ? JSON.parse(res.data[0].a_tagName) : ''
  } catch (error) {
    // 處理錯誤，例如顯示錯誤信息
    console.error('Error fetching data:', error)
  } finally {
    // 這裡可以執行一些無論請求成功還是失敗都需要執行的邏輯
    loading.value = false
  }
}

// 『重大事件』的 Newtag input focus
function showInput() {
  inputVisible.value = true
  nextTick(() => {
    document.getElementById('inputTag').focus()
  })
}
// 『重大事件』的 Newtag input 新增處理
function handleInputConfirm() {
  if (inputValue.value) {
    dynamicTags.value.push(inputValue.value)
    console.log(dynamicTags.value)
  }
  inputVisible.value = false
  inputValue.value = ''
}
// 『重大事件』的 Newtag input 刪除處理
function handleClose(tag) {
  dynamicTags.value.splice(dynamicTags.value.indexOf(tag), 1)
}
// 編輯/儲存文件 （Normal）
function handleNormalMode() {
  const headers = store.getAuthHeaders()
  axios({
    method: 'post',
    url: '/api/handle_update.php',
    headers,
    data: {
      action: 'updateArticleNormalMode',
      data: {
        editorSidebarName: editorSidebarName.value,
        editorTitleName: editorTitleName.value,
        editorContent: editorContent.value,
        editMode: editMode.value,
        routeParamsId: routeParamsId.value,
        routeParamsName: routeParamsName.value,
        routeParamsLevel: routeParamsLevel.value,
        account: JSON.parse(localStorage.getItem('token')).account
      }
    }
  }).then((res) => {
    console.log(res)
    ElMessage({
      type: 'success',
      message: '更新好ㄌ!'
    })
  })
}
// （Event）
function handleEventMode() {
  const headers = store.getAuthHeaders()
  axios({
    method: 'post',
    url: '/api/handle_update.php',
    headers,
    params: {
      action: 'updateArticleEventMode',
      data: {
        editorSidebarName: editorSidebarName.value,
        editorTitleName: editorTitleName.value ?? '',
        editorContent: editorContent.value ?? '',
        editMode: editMode.value ?? '',
        routeParamsId: routeParamsId.value,
        routeParamsName: routeParamsName.value,
        routeParamsLevel: routeParamsLevel.value,
        account: JSON.parse(localStorage.getItem('token')).account,
        editorTags: Object.values(dynamicTags.value).length
          ? JSON.stringify(dynamicTags.value)
          : '',
        editorImgUrl: editorImgUrl.value ?? '',
        editorDatetime: handleDatetime()
      }
    }
  }).then(() => {
    ElMessage({
      type: 'success',
      message: '更新好ㄌ'
    })
  })
}
function handleSaveClick() {
  editMode.value === 'normal' ? handleNormalMode() : handleEventMode()
}
// 刪除文件
const handleDeleteClick = () => {
  ElMessageBox.confirm(`是否確認要刪除文件『${routeParamsName.value}』？`, 'Warning', {
    confirmButtonText: 'OK',
    cancelButtonText: 'Cancel',
    type: 'warning',
    draggable: true
  })
    .then(() => {
      axios({
        method: 'post',
        url: '/api/handle_update.php',
        params: {
          action: 'updateIsDeleted',
          data: {
            routeParamsId: routeParamsId.value,
            routeParamsName: routeParamsName.value,
            routeParamsLevel: routeParamsLevel.value,
            account: JSON.parse(localStorage.getItem('token')).account
          }
        }
      }).then((res) => {
        console.log(res.data)
        ElMessage({
          type: 'success',
          message: 'Delete completed (after 2s reload) 完成後要什麼動作?'
        })
        setTimeout(() => {
          location.reload()
          router.push('/admin/edit')
        }, 3000)
      })
    })
    .catch(() => {
      ElMessage({
        type: 'info',
        message: 'Delete canceled'
      })
    })
}
// 處理顯示的日期格式
const handleDatetime = () => {
  if (!editorDatetime.value) return ''
  const selectedDate = new Date(editorDatetime.value)

  const year = selectedDate.getFullYear()
  const month = String(selectedDate.getMonth() + 1).padStart(2, '0') // 月份是從0開始，需要+1，並補零
  const day = String(selectedDate.getDate()).padStart(2, '0') // 日補零

  const formattedDate = `${year}-${month}-${day}`
  return formattedDate
}
</script>
<template>
  <el-container v-loading="loading" class="h-screen overflow-y-auto bg-blue-50">
    <el-header class="flex items-center justify-between font-black text-xl shadow-sm">
      <div class="m-4"><span>編輯項目</span></div>

      <el-radio-group v-model="editMode" size="large" v-if="route.query.name" class="m-4">
        <el-radio-button label="normal">一般編輯</el-radio-button>
        <el-radio-button label="event">重大事件</el-radio-button>
      </el-radio-group>
    </el-header>

    <el-main>
      <el-scrollbar v-if="route.query.name">
        <div class="steps-content m-4 p-4 bg-white rounded shadow-md">
          <div class="mb-4">
            <!-- 標題的部分 -->
            <div class="flex items-center justify-between">
              <h1 class="text-lg m-2">
                <strong>編輯『 {{ routeParamsName }} 』</strong>
              </h1>
              <div>
                <router-link to="/" class="mr-3">
                  <el-button type="success" plain :icon="Position">去主頁</el-button>
                </router-link>
                <el-button type="danger" plain :icon="Delete" @click="handleDeleteClick"
                  >刪除</el-button
                >
                <el-button type="success" plain :icon="Check" @click="handleSaveClick"
                  >儲存</el-button
                >
              </div>
            </div>
            <el-input
              v-model="editorSidebarName"
              class="p-2"
              size="large"
              placeholder="請輸入佇列名稱"
            >
              <template #prepend>佇列名稱</template>
            </el-input>
            <el-input
              v-model="editorTitleName"
              class="p-2"
              size="large"
              placeholder="請輸入標題名稱"
              ><template #prepend>標題名稱</template>
            </el-input>
            <el-input
              v-show="editMode === 'event'"
              v-model="editorImgUrl"
              class="p-2"
              size="large"
              placeholder="請輸入圖片網址"
              ><template #prepend>圖片網址</template>
            </el-input>
            <div class="block p-2" v-show="editMode === 'event'">
              <el-date-picker
                v-model="editorDatetime"
                type="date"
                placeholder="Pick a day"
                :size="size"
                format="YYYY-MM-DD"
              />
            </div>
            <div class="p-1" v-show="editMode === 'event'">
              <el-tag
                v-for="tag in dynamicTags"
                :key="tag"
                size="large"
                class="mx-1 text-lg"
                closable
                :disable-transitions="false"
                @close="handleClose(tag)"
              >
                {{ tag }}
              </el-tag>
              <el-input
                v-show="inputVisible"
                v-model="inputValue"
                class="ml-1 w-20"
                id="inputTag"
                size="small"
                @keyup.enter="handleInputConfirm"
                @blur="handleInputConfirm"
              />
              <el-button class="button-new-tag ml-1" @click="showInput"> + New Tag </el-button>
            </div>
          </div>
          <img :src="editorImgUrl" alt="" />
          <el-divider />
          <!-- 文字編輯器 -->
          <main id="sample">
            <Editor
              v-model="editorContent"
              api-key="xntgx48udsat0r6j8axkyzsp4f3glsnsf9jmgp353oxcr6fq"
              :init="{
                language: 'zh_TW',
                toolbar_mode: 'sliding',
                plugins: 'link table lists blockquote',
                toolbar:
                  'undo redo | blocks fontfamily fontsize lineheight | bold italic underline strikethrough | blockquote link image media table numlist bullist mergetags | align | tinycomments | checklist indent outdent | emoticons charmap | removeformat',
                tinycomments_mode: 'embedded',
                tinycomments_author: 'Author name',
                mergetags_list: [
                  { value: 'First.Name', title: 'First Name' },
                  { value: 'Email', title: 'Email' }
                ]
              }"
              initial-value="Welcome to TinyMCE!"
            />
          </main>
        </div>
      </el-scrollbar>
      <el-scrollbar v-else>
        <el-empty description="從左側欄選擇你想編輯的項目吧～" />
      </el-scrollbar>
    </el-main>
  </el-container>
</template>
<style scoped>
.el-message {
  font-size: 20px !important;
}
</style>
