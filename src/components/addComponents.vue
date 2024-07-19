<script lang="ts" setup>
import { ref, onMounted, watch } from 'vue'
import { Plus as Plus } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'
import { useVerificationToken } from '../stores/counter.js'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const store = useVerificationToken()
// 新增層級的
let selectedCategory = ref('')
let selectedParent = ref('')
let newTopicName = ref('')
// 新增類別的
let newCategoryName = ref('')
// 切換顯示用的
let isTreeVisible = ref(0)
let isCategoryVisible = ref(0)
let isLevelVisible = ref(0)
// 預覽新增結果用
const treeData = ref()
// onMounted get 全部類別資料
const selectedCategoryData = ref()
// watch 「新增層級」的類別 => 放子層的資料
const level1TopicData = ref()

// 獲取全部類別資料
onMounted(() => {
  getSelectedCategoryData()
})
function getSelectedCategoryData() {
  axios({
    method: 'post',
    url: '/api/handle_select.php',
    params: {
      action: 'getSelectedCategoryData'
    }
  }).then((res) => {
    selectedCategoryData.value = res.data
    // console.log(res.data)
  })
}

// 新增類別、新增層級顯示區塊切換
function handleCategoryClick() {
  isCategoryVisible.value = 1
  isLevelVisible.value = 0
}
function handleLevelClick() {
  isCategoryVisible.value = 0
  isLevelVisible.value = 1
}

// 新增類別、新增層級 axios
function insertCategory() {
  const headers = store.getAuthHeaders()
  if (!newCategoryName.value) {
    ElMessage({
      message: '請填寫類別名稱再新增唷！',
      type: 'warning',
      showClose: true
    })
    return false
  }
  axios({
    method: 'post',
    url: '/api/handle_insert.php',
    headers,
    params: {
      action: 'insertCategory',
      data: {
        categoryName: newCategoryName.value,
        account: JSON.parse(localStorage.getItem('token')).account
      }
    }
  })
    .then(() => {
      ElMessage({
        message: '新增成功！',
        type: 'success',
        showClose: true
      })
      newCategoryName.value = ''
    })
    .catch((err) => {
      if (err.response.status === 401) router.push('/login')
    })
}
function insertLevel() {
  // 不選擇代表建立是層級一
  if (!selectedCategory.value || !selectedParent.value || !newTopicName.value) {
    ElMessage({
      message: '請填寫完整後再新增唷！',
      type: 'warning',
      showClose: true
    })
    return false
  }
  let data = {
    selectedCategory: selectedParent.value !== '不選擇' ? null : selectedCategory.value,
    selectedParent: selectedParent.value === '不選擇' ? null : selectedParent.value,
    newTopicName: newTopicName.value,
    level: selectedParent.value === '不選擇' ? '1' : '2',
    account: JSON.parse(localStorage.getItem('token')).account || ''
  }
  Object.keys(data).forEach((k) => data[k] == null && delete data[k])
  console.log(data)
  const headers = store.getAuthHeaders()
  axios({
    method: 'post',
    url: '/api/handle_insert.php',
    headers,
    params: {
      action: 'insertLevel',
      data
    }
  })
    .then(() => {
      ElMessage({
        message: '新增成功！',
        type: 'success',
        showClose: true
      })
      newCategoryName.value = ''
    })
    .catch((err) => {
      if (err.response.status === 401) router.push('/login')
    })
}
/**
 * 預覽新增結果的函數。
 * 根據選擇的類別、層級一主題和新的主題名稱，更新 TreeData 中的數據結構，
 * 並根據特定條件添加或移除子節點。
 */
function previewResult() {
  isTreeVisible.value = 1
  // 重新設定 TreeData 結構
  treeData.value = [
    {
      id: 1,
      label: 'Item 1',
      children: [
        {
          id: 2,
          label: 'Item 1-1',
          children: [
            {
              id: 3,
              label: 'Item 1-1-1'
            }
          ]
        }
      ]
    }
  ]

  // 更新選中的類別
  treeData.value[0].label = selectedCategory.value

  // 檢查是否選擇了層級一主題
  if (selectedParent.value && selectedParent.value === '不選擇') {
    // 移除原有的子節點
    treeData.value[0].children[0].children.splice(0, 1)
    // 設定新的層級一主題
    treeData.value[0].children[0].label = newTopicName.value
  } else {
    // 更新選中的層級一主題
    treeData.value[0].children[0].label = selectedParent.value
    // 更新或新增層級二主題
    treeData.value[0].children[0].children[0].label = newTopicName.value
  }
}
// 監聽『新增層級』的類別，獲取該類別的子層級 axios
watch(
  () => selectedCategory.value,
  async () => {
    axios({
      method: 'post',
      url: '/api/handle_select.php',
      params: {
        action: 'getLevelTopic',
        data: selectedCategory.value
      }
    }).then((res) => {
      selectedParent.value = ''
      level1TopicData.value = res.data
      level1TopicData.value.push({ a_sidebar_name: '不選擇' })
      console.log(level1TopicData.value)
    })
  }
)
</script>
<template>
  <el-container class="h-screen overflow-y-auto bg-blue-50">
    <el-header class="flex items-center justify-between font-black text-xl shadow-sm">
      <div class="m-4"><span>新增項目</span></div>
      <div class="m-4">
        <el-button plain :icon="Plus" @click="handleCategoryClick">新增類別</el-button>
        <el-button plain :icon="Plus" @click="handleLevelClick">新增層級</el-button>
      </div>
    </el-header>

    <el-main>
      <el-scrollbar>
        <!-- 未選擇時的提示文字 -->
        <div v-if="!isCategoryVisible && !isLevelVisible" class="m-4 font-bold text-center">
          <el-empty description="從右上角選擇你想新增的項目吧～" />
        </div>

        <!-- 新增類別的區塊 -->
        <div v-show="isCategoryVisible" class="steps-content m-4 p-4 bg-white rounded shadow-md">
          <div class="mb-4">
            <h1 class="text-lg m-2"><strong>新增類別</strong></h1>
            <el-divider></el-divider>
            <h2 class="m-2">
              <span class="text-red-600">*</span>
              <strong> 類別名稱</strong>
            </h2>
            <el-input
              v-model="newCategoryName"
              class="p-2"
              size="large"
              placeholder="輸入新的類別名稱"
            />
          </div>
          <div class="grid justify-items-end" v-show="1">
            <el-divider />
            <el-button color="#626aef" @click="insertCategory">確認新增</el-button>
          </div>
        </div>

        <!-- 新增層級的區塊 -->
        <div v-show="isLevelVisible" class="steps-content m-4 p-4 bg-white rounded shadow-md">
          <h1 class="text-lg m-2"><strong>新增層級</strong></h1>
          <el-divider></el-divider>
          <h2 class="m-2">
            <span class="text-red-600">*</span>
            <strong> 類別</strong>
          </h2>

          <el-select
            v-model="selectedCategory"
            class="m-2"
            placeholder="Select Category"
            size="large"
          >
            <el-option
              v-for="item in selectedCategoryData"
              :key="item.a_id"
              :value="item.a_sidebar_name"
            />
          </el-select>
          <div v-show="selectedCategory">
            <el-divider />
            <h2 class="m-2">
              <span class="text-red-600">*</span>
              <strong> 層級一主題</strong>
            </h2>

            <!-- 選擇現有層級一主題的下拉菜單 -->
            <div class="mb-4">
              <el-select
                v-model="selectedParent"
                class="m-2"
                placeholder="選擇現有層級一主題"
                size="large"
              >
                <el-option
                  v-for="parentTopic in level1TopicData"
                  :key="parentTopic.a_id"
                  :value="parentTopic.a_sidebar_name"
                />
              </el-select>
            </div>
            <!-- 新增層級一主題的輸入框和按鈕 -->
            <div class="mb-4">
              <h2 class="m-2">
                <span class="text-red-600">*</span>
                <strong> 主題名稱</strong>
              </h2>
              <el-input
                v-model="newTopicName"
                class="p-2"
                size="large"
                placeholder="輸入新的層級一主題名稱"
              />
              <!-- <el-button @click="NewTopicName">新增主題</el-button> -->
            </div>

            <div v-show="selectedCategory && selectedParent && newTopicName">
              <el-divider />
              <el-button class="m-2" color="#626aef" @click="previewResult">預覽新增結果</el-button>
            </div>

            <div v-show="isTreeVisible"><el-tree :data="treeData" default-expand-all /></div>

            <div class="grid justify-items-end" v-show="1">
              <el-divider />
              <el-button color="#626aef" @click="insertLevel">確認新增</el-button>
            </div>
          </div>
        </div>
      </el-scrollbar>
    </el-main>
  </el-container>
</template>
