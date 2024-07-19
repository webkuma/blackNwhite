import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import AdminView from '../views/AdminView.vue'
import addComponents from '../components/addComponents.vue'
import editComponents from '../components/editComponents.vue'
import settingComponents from '../components/settingComponents.vue'
import LoginView from '../views/LoginView.vue'
import RegisterView from '../views/RegisterView.vue'
// home/article 
import articleComponents from '../components/articleComponents.vue'
import eventComponents from '../components/eventComponents.vue'
import eventArticleComponents from '../components/eventArticleComponents.vue'
import HeroImageComponents from '../components/HeroImageComponents.vue'

const router = createRouter({
  // history: createWebHistory('/dist/'), // 調整為實際的應用程式部署位置
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
      children: [
        {
          path: 'article',
          components: {
            rightSidebar: articleComponents, // 右侧栏命名视图组件 A
          },
        },
        {
          path: 'event',
          components: {
            rightSidebar: eventComponents, // 右侧栏命名视图组件 A
          },
        },
        {
          path: 'eventarticle',
          components: {
            rightSidebar: eventArticleComponents, // 右侧栏命名视图组件 B
          },
        },
      ]
    },
    {
      path: '/admin',
      component: AdminView,
      children: [
        {
          path: 'add',
          components: {
            rightSidebar: addComponents, // 右侧栏命名视图组件 A
          },
        },
        {
          path: 'edit',
          components: {
            rightSidebar: editComponents, // 右侧栏命名视图组件 A
          },
        },
        {
          path: 'setting',
          components: {
            rightSidebar: settingComponents, // 右侧栏命名视图组件 A
          },
        },
      ],
    },
    {
      path: '/heroimage',
      name: 'HeroImage',
      component: HeroImageComponents,
    },
    {
      path: '/login',
      component: LoginView,
    },
    {
      path: '/register',
      component: RegisterView,
    },
  ]
})

export default router
