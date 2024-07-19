<script setup>
import { ElMessageBox } from 'element-plus'
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()
const account = ref()
const password = ref()

// 處理登入邏輯，若有輸入就加密密碼，然後判斷使用者存在否
function handleLogin() {
  if (account.value && password.value) {
    digestMessage(password.value).then((hashedPassword) => {
      axios({
        method: 'post',
        url: '/api/handle_login.php',
        params: {
          action: 'login',
          data: {
            account: account.value,
            password: hashedPassword
          }
        }
      }).then((res) => {
        res.data === '帳號或密碼錯誤' ? alert(res.data) : router.push('/admin/add')
        localStorage.removeItem('token')
        const jsonString = JSON.stringify(res.data)
        console.log('res.data', res.data)
        localStorage.setItem('token', jsonString)
      })
    })
  } else {
    ElMessageBox.alert('有欄位沒填！', {
      confirmButtonText: 'OK',
      type: 'warning',
      draggable: true,
      closeOnPressEscape: true,
      closeOnClickModal: true
    })
  }
}

/* 參考 MDN（https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto/digest）
   加密一下密碼，避免明碼 */
async function digestMessage(message) {
  const encoder = new TextEncoder()
  const data = encoder.encode(message)
  const hash = await crypto.subtle.digest('SHA-256', data)
  // 將 ArrayBuffer 轉換為 Uint8Array
  const hashArray = new Uint8Array(hash)

  // 將 Uint8Array 轉換為十六進位字符串
  const hashHex = Array.from(hashArray)
    .map((byte) => byte.toString(16).padStart(2, '0'))
    .join('')
  return hashHex
}
</script>

<template>
  <main class="board container" id="app">
    <section class="bg-gray-50 dark:bg-gray-900">
      <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
        <a
          href="#"
          class="flex items-center mb-6 text-2xl font-semibold text-gray-900 dark:text-white"
        >
          <img
            class="w-8 h-8 mr-2"
            src="https://igiyou.com/xdogs/view/data/image/dog/4_m.jpg"
            alt="logo"
          />
          ET Login
        </a>
        <div
          class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700"
        >
          <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
            <h1
              class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white"
            >
              登入
            </h1>
            <div class="space-y-4 md:space-y-6">
              <div>
                <label
                  for="email"
                  class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                  >Your Account</label
                >
                <input
                  type="email"
                  name="email"
                  id="email"
                  class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                  placeholder="Your account"
                  v-model="account"
                />
              </div>
              <div>
                <label
                  for="password"
                  class="block mb-2 text-sm font-medium text-gray-900 dark:text-white"
                  >Password</label
                >
                <input
                  type="password"
                  name="password"
                  id="password"
                  placeholder="••••••••"
                  class="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-blue-600 focus:border-blue-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                  v-model="password"
                />
              </div>
              <div class="flex items-center justify-between">
                <div class="flex items-start">
                  <div class="flex items-center h-5">
                    <input
                      id="remember"
                      aria-describedby="remember"
                      type="checkbox"
                      class="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-blue-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-blue-600 dark:ring-offset-gray-800"
                      required=""
                    />
                  </div>
                  <div class="ml-3 text-sm">
                    <label for="remember" class="text-gray-500 dark:text-gray-300"
                      >Remember me</label
                    >
                  </div>
                </div>
                <a
                  href="#"
                  class="text-sm font-medium text-blue-600 hover:underline dark:text-blue-500"
                  >Forgot password?</a
                >
              </div>
              <button
                class="w-full text-white bg-blue-600 hover:bg-blue-700 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                @click="handleLogin()"
              >
                Sign in
              </button>
              <p class="font-light text-gray-500 dark:text-gray-400">
                Don’t have an account yet?
                <router-link to="/register">
                  <a href="#" class="font-medium text-blue-600 hover:underline dark:text-blue-500">
                    Sign up
                  </a>
                </router-link>
              </p>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>
