<template>
  <el-container class="layout-container-demo">
    <el-aside width="200px" class="h-screen overflow-y-auto border-r border-gray-300">
      <el-scrollbar>
        <el-menu>
          <el-menu-item-group title="Group One">
            <template #title>
              <el-icon><UserFilled /></el-icon>
              <span class="pl-2 text-base">Hi {{ accountName }}</span>
            </template>
          </el-menu-item-group>
          <!-- 新增項目 -->
          <router-link to="/admin/add">
            <el-menu-item index="1">
              <template #title>
                <el-icon><DocumentAdd /></el-icon>
                <span class="text-base">新增項目</span>
              </template>
            </el-menu-item>
          </router-link>
          <router-link to="/admin/setting">
            <el-menu-item index="10">
              <template #title>
                <el-icon><Setting /></el-icon>
                <span class="text-base">設定圖片</span>
              </template>
            </el-menu-item>
          </router-link>
          <!-- MENU -->
          <template v-for="(item, index) in hierarchy" :key="item.a_id">
            <el-menu-item-group v-if="index == 0">
              <template #title>
                <el-icon><Edit /></el-icon>
                <span class="align-bottom"> 已建立的主題</span>
              </template>
            </el-menu-item-group>
            <!-- Category has children -->
            <template v-if="item.children && item.children.length > 0">
              <el-sub-menu :index="item.a_id.toString()" :key="item.a_id">
                <!-- Category title -->
                <template #title>
                  <router-link
                    :to="{
                      path: '/admin/edit',
                      query: {
                        name: item.a_sidebar_name,
                        level: 0,
                        id: item.a_id
                      }
                    }"
                  >
                    {{ item.a_sidebar_name }}
                  </router-link>
                </template>
                <!-- level1 has children -->
                <template v-for="childItem in item.children" :key="childItem.a_id">
                  <template v-if="childItem.children && childItem.children.length > 0">
                    <el-sub-menu :index="childItem.a_id.toString()">
                      <template #title>
                        <i :class="childItem.iconClass"></i>
                        <router-link
                          :to="{
                            path: '/admin/edit',
                            query: {
                              name: childItem.a_sidebar_name,
                              level: childItem.a_level,
                              id: childItem.a_id
                            }
                          }"
                        >
                          {{ childItem.a_sidebar_name }}
                        </router-link>
                      </template>
                      <!-- level2 -->
                      <template
                        v-for="grandchildItem in childItem.children"
                        :key="grandchildItem.a_id"
                      >
                        <el-menu-item :index="grandchildItem.a_id.toString()">
                          <i :class="grandchildItem.iconClass"></i>
                          <router-link
                            :to="{
                              path: '/admin/edit',
                              query: {
                                name: grandchildItem.a_sidebar_name,
                                level: grandchildItem.a_level,
                                id: grandchildItem.a_id
                              }
                            }"
                          >
                            {{ grandchildItem.a_sidebar_name }}
                          </router-link>
                        </el-menu-item>
                      </template>
                    </el-sub-menu>
                  </template>
                  <!-- level1 hasn't children -->
                  <template v-else>
                    <el-menu-item :index="childItem.a_id.toString()">
                      <template #title>
                        <i :class="childItem.iconClass"></i>
                        <router-link
                          :to="{
                            path: '/admin/edit',
                            query: {
                              name: childItem.a_sidebar_name,
                              level: childItem.a_level,
                              id: childItem.a_id
                            }
                          }"
                        >
                          {{ childItem.a_sidebar_name }}
                        </router-link>
                      </template>
                    </el-menu-item>
                  </template>
                </template>
              </el-sub-menu>
            </template>
            <!-- Category hasn't children -->
            <template v-else>
              <router-link
                :to="{
                  path: '/admin/edit',
                  query: {
                    name: item.a_sidebar_name,
                    level: 0,
                    id: item.a_id
                  }
                }"
              >
                <el-menu-item :index="item.a_id.toString()" :key="item.a_id">
                  {{ item.a_sidebar_name }}
                </el-menu-item>
              </router-link>
            </template>
          </template>
          <el-menu-item index="99" @click="logout">
            <template #title>
              <el-icon><DocumentAdd /></el-icon>
              <span class="text-base">登出</span>
            </template>
          </el-menu-item>
        </el-menu>
      </el-scrollbar>
    </el-aside>

    <!-- 主区域 -->
    <!-- <router-view></router-view> -->
    <router-view name="rightSidebar"></router-view>
    <!-- <CreateData /> -->
    <!-- <editData /> -->
  </el-container>
</template>

<script setup>
import { DocumentAdd, Edit, UserFilled, Setting } from '@element-plus/icons-vue'
import { ref, onMounted, reactive } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const sidebarData = ref()
const accountName = ref()
const hierarchy = reactive([])

// when onMounted, 取得側欄資料、驗證登入
onMounted(() => {
  getSidebarData()
  verificationToken()
})
// 取得側邊已建立的，因為只有一人使用，沒有針對"user"取資料
function getSidebarData() {
  axios({
    method: 'post',
    url: '/api/handle_select.php',
    params: {
      action: 'getSidebarData'
    }
  }).then((res) => {
    sidebarData.value = res.data
    buildHierarchy(sidebarData)
  })
}
// 簡單來講是把側欄的資料作處理，變成一個階層式的資料型態，用於側欄階層顯示
function buildHierarchy(sidebarData) {
  const lookup = {}

  sidebarData.value.forEach(function (item) {
    item.children = []
    lookup[item.a_id] = item
  })

  sidebarData.value.forEach(function (item) {
    if (item.a_parent !== null) {
      lookup[item.a_parent].children.push(item)
    } else {
      hierarchy.push(item)
    }
  })
}
// if localStorage has token => Authorization
function verificationToken() {
  if (localStorage.getItem('token')) {
    let token = JSON.parse(localStorage.getItem('token')).token
    const headers = {
      Authorization: `Bearer ${token}`
    }
    accountName.value = JSON.parse(localStorage.getItem('token')).account

    axios({
      method: 'post',
      url: '/api/handle_verification_token.php',
      headers,
      params: {
        action: 'verificationToken',
        data: {
          // token: JSON.parse(localStorage.getItem('token')).token,
          account: JSON.parse(localStorage.getItem('token')).account
        }
      }
    })
      .then(() => {
        // alert(1)
      })
      .catch((err) => {
        if (err.response.status === 401) router.push('/login')
      })
  } else {
    router.push('/login')
  }
}
// 登出
function logout() {
  localStorage.removeItem('token')
  router.push('/login')
}
</script>

<style scoped>
.layout-container-demo .el-header {
  position: relative;
  background-color: var(--el-color-primary-light-7);
  color: var(--el-text-color-primary);
}
.layout-container-demo .el-aside {
  color: var(--el-text-color-primary);
  background: var(--el-color-primary-light-8);
}
.layout-container-demo .el-menu {
  border-right: none;
}
.layout-container-demo .el-main {
  padding: 0;
}
.layout-container-demo .toolbar {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  right: 20px;
}
</style>
