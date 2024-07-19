<script setup>
import { ref, onMounted, reactive, nextTick } from 'vue'
import { Menu } from '@element-plus/icons-vue'
import { useRouterStore } from '@/stores/counter'
import axios from 'axios'

// Pinia Store Variable
const routerStore = useRouterStore()
const { setRouterQuery } = routerStore

const sidebarData = ref()
const hierarchy = reactive([])
const isCollapse = ref(false)

// when onMounted, 取得側欄資料
onMounted(async () => {
  await getSidebarData()
})

// 取得側邊已建立的，因為只有一人使用，沒有針對"user"取資料
async function getSidebarData() {
  axios({
    method: 'post',
    url: '/api/handle_select.php',
    params: {
      action: 'getSidebarData'
    }
  }).then((res) => {
    // console.log(res.data)
    sidebarData.value = res.data
    buildHierarchy(sidebarData)
    // console.log(sidebarData.value)
    // console.log(hierarchy)
    attachRouterToElements()
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
/* 往取得的 DOM 父元素添加 ID，判斷 ID => 監聽 DOM 
   懶人包：監聽該 DOM 的父元素，並添加 Router push */
async function attachRouterToElements() {
  await nextTick()
  const elements = document.querySelectorAll('[id]')
  elements.forEach((element) => {
    const id = element.id
    if (!isNaN(id)) {
      const dataset = element.dataset.router
      if (dataset) {
        const parsedRouterData = JSON.parse(dataset)
        const item =
          parsedRouterData.item || parsedRouterData.childItem || parsedRouterData.grandchildItem
        let el = element.parentNode
        el.id = item.a_id + '_parentNode'
        const parentNodeID = document.getElementById(el.id)
        parentNodeID.addEventListener('click', function () {
          setRouterQuery(item)
        })
      }
    }
  })
}
</script>
<template>
  <div class="app-container flex flex-row bg-stone-300 bg-opacity-50 h-screen">
    <!-- 左側顯示區域 -->
    <div class="bg-blue-50 shadow border-gray-300 box-border overflow-x-hidden overflow-y-auto">
      <el-radio-group v-model="isCollapse" class="m-0 p-0 border-0 border-box">
        <div v-if="isCollapse">
          <el-radio-button :label="false">
            <el-icon><Menu /></el-icon>
          </el-radio-button>
        </div>
        <div v-else>
          <el-radio-button :label="true">
            <el-icon><Menu /></el-icon>
          </el-radio-button>
        </div>
      </el-radio-group>
      <el-aside
        :class="{
          'z-0': isCollapse,
          transition: isCollapse,
          'pr-12': true,
          position_style: isCollapse
        }"
      >
        <el-menu>
          <!-- MENU -->
          <template v-for="(item, index) in hierarchy" :key="item.a_id">
            <el-menu-item-group v-if="index == 0">
              <template #title>
                <!-- <el-icon><Edit /></el-icon> -->
                <span class="align-bottom"> 已建立的主題</span>
              </template>
            </el-menu-item-group>
            <!-- Category has children -->
            <template v-if="item.children && item.children.length > 0">
              <el-sub-menu :index="item.a_id.toString()" :key="item.a_id">
                <!-- Category title -->
                <template #title>
                  <!-- <router-link
                      :to="{
                        path: isModeEvent(item),
                        query: {
                          name: item.a_sidebar_name,
                          level: 0,
                          id: item.a_id
                        }
                      }"
                    >
                      <span @click="ale()">{{ item.a_sidebar_name }}</span>
                    </router-link> -->
                  <div
                    :id="item.a_id"
                    :data-router="
                      JSON.stringify({
                        item
                      })
                    "
                  >
                    {{ item.a_sidebar_name }}
                  </div>
                </template>
                <!-- level1 has children -->
                <template v-for="childItem in item.children" :key="childItem.a_id">
                  <template v-if="childItem.children && childItem.children.length > 0">
                    <el-sub-menu :index="childItem.a_id.toString()">
                      <template #title>
                        <i :class="childItem.iconClass"></i>
                        <!-- <router-link
                            :to="{
                              path: isModeEvent(childItem),
                              query: {
                                name: childItem.a_sidebar_name,
                                level: childItem.a_level,
                                id: childItem.a_id
                              }
                            }"
                          > -->
                        <div
                          :id="childItem.a_id"
                          :data-router="
                            JSON.stringify({
                              childItem
                            })
                          "
                        >
                          {{ childItem.a_sidebar_name }}
                        </div>
                        <!-- </router-link> -->
                      </template>
                      <!-- level2 -->
                      <template
                        v-for="grandchildItem in childItem.children"
                        :key="grandchildItem.a_id"
                      >
                        <el-menu-item :index="grandchildItem.a_id.toString()">
                          <i :class="grandchildItem.iconClass"></i>
                          <!-- <router-link
                              :to="{
                                path: isModeEvent(grandchildItem),
                                query: {
                                  name: grandchildItem.a_sidebar_name,
                                  level: grandchildItem.a_level,
                                  id: grandchildItem.a_id
                                }
                              }"
                            > -->
                          <div
                            :id="grandchildItem.a_id"
                            :data-router="
                              JSON.stringify({
                                grandchildItem
                              })
                            "
                          >
                            {{ grandchildItem.a_sidebar_name }}
                          </div>

                          <!-- </router-link> -->
                        </el-menu-item>
                      </template>
                    </el-sub-menu>
                  </template>
                  <!-- level1 hasn't children -->
                  <template v-else>
                    <el-menu-item :index="childItem.a_id.toString()">
                      <template #title>
                        <i :class="childItem.iconClass"></i>
                        <!-- v-if="childItem.a_editMode === 'event'" -->
                        <!-- <router-link
                            :to="{
                              path: isModeEvent(childItem),
                              query: {
                                name: childItem.a_sidebar_name,
                                level: childItem.a_level,
                                id: childItem.a_id
                              }
                            }"
                          > -->
                        <div
                          :id="childItem.a_id"
                          :data-router="
                            JSON.stringify({
                              childItem
                            })
                          "
                        >
                          {{ childItem.a_sidebar_name }}
                        </div>

                        <!-- </router-link> -->
                      </template>
                    </el-menu-item>
                  </template>
                </template>
              </el-sub-menu>
            </template>
            <!-- Category hasn't children -->
            <template v-else>
              <!-- <router-link
                  :to="{
                    path: isModeEvent(item),
                    query: {
                      name: item.a_sidebar_name,
                      level: 0,
                      id: item.a_id
                    }
                  }"
                > -->
              <el-menu-item :index="item.a_id.toString()" :key="item.a_id">
                <div
                  :id="item.a_id"
                  :data-router="
                    JSON.stringify({
                      item
                    })
                  "
                >
                  {{ item.a_sidebar_name }}
                </div>
              </el-menu-item>
              <!-- </router-link> -->
            </template>
          </template>
        </el-menu>
      </el-aside>
    </div>
    <!-- 右側顯示區域 -->
    <div id="rightSidebar" class="w-full overflow-auto">
      <router-view name="rightSidebar"></router-view>
    </div>
  </div>
</template>

<style scoped>
:deep #rightSidebar a {
  color: blue;
}
:deep blockquote {
  margin: 20px;
  padding: 10px;
  background-color: #fefebf;
  border-left: 5px solid #63b9ff;
  margin: 15px 0px;
  padding-left: 20px;
  border-radius: 3px;
}

:deep #rightSidebar ol {
  list-style: decimal !important;
  margin: 10px 0;
  padding-left: 25px;
  line-height: 200%;
}

:deep #rightSidebar ul {
  list-style: disc !important;
  margin: 10px 0;
  padding-left: 25px;
  line-height: 200%;
}
.position_style {
  position: absolute;
  left: -100%;
}

:deep h1 {
  font-size: 32px;
}

:deep h2 {
  font-size: 24px;
}

:deep h3 {
  font-size: 18.72px;
}

:deep h4 {
  font-size: 16px;
}

:deep h5 {
  font-size: 13.28px;
}

:deep h6 {
  font-size: 10.72px;
}
</style>
