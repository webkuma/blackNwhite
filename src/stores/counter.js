import { ref } from 'vue'
import { defineStore } from 'pinia'
import { useRouter } from 'vue-router'

export const useRouterStore = defineStore('router', () => {
  const router = useRouter()
  const sidebarName = ref(null)
  const level = ref(null)
  const id = ref(null)
  const editMode = ref(null)

  function doRouterPush(){
    // console.log(editMode.value+'&'+sidebarName.value+'&'+level.value+'&'+id.value)
    router.push({
      path: editMode.value,
      query: {
        name: sidebarName.value,
        level: level.value,
        id: id.value
      }
    })
  }
  function resetRouterQuery(){
    sidebarName.value = null
    level.value = null
    id.value = null
    editMode.value = null
  }
  function setRouterQuery(item) {
    // resetRouterQuery()
    sidebarName.value = item.a_sidebar_name
    level.value = item.a_level ?? 0
    id.value = item.a_id
    editMode.value = getRouterPath(item)
    // console.log(editMode.value+'&'+sidebarName.value+'&'+level.value+'&'+id.value)
    if(sidebarName.value && id.value && editMode.value){
      doRouterPush()
    }
  }
  function getRouterPath(item){
      let hasChild = item.children.length > 0;
      if (item.a_editMode === 'event') {
        return hasChild ? '/event' : '/eventarticle';
      } else {
        return '/article';
      }
  }

  return { sidebarName, level, id, editMode, setRouterQuery }
})
// export const useRouterStore = defineStore('router', {
//   state: () => {
//     return {
//       sidebarName: null,
//       level: null,
//       id: null,
//       editMode: null,
//     }
//   },
//   actions: {
//     doRouterPush(){
//       const routerPush = () => {
//         router.push({
//           path: this.editMode,
//           query: {
//             name: this.sidebarName,
//             level: this.level,
//             id: this.id
//           }
//         })
//       }
//     },
//     resetRouterQuery(){
//       this.sidebarName = null
//       this.level = null
//       this.id = null
//       this.editMode = null
//     },
//     setRouterQuery(item) {
//       this.resetRouterQuery()
//       this.sidebarName = item.a_sidebar_name
//       this.level = item.a_level ?? 0
//       this.id = item.a_id
//       this.editMode = this.getRouterPath(item)
//       if(this.sidebarName && this.level && this.id && this.editMode){
//         this.doRouterPush()
//       }
//     },
//     getRouterPath(item){
//         let hasChild = item.children.length > 0;
//         if (item.a_editMode === 'event') {
//           return hasChild ? '/event' : '/eventarticle';
//         } else {
//           return '/article';
//         }
//     },
//   },
// })


export const useVerificationToken = defineStore('verificationToken', () => {
  const getAuthHeaders = () => {
    const token = JSON.parse(localStorage.getItem('token')).token
    const account = JSON.parse(localStorage.getItem('token')).account
    return {
      Authorization: `Bearer ${token}`,
      account: account
    }
  }

  return { getAuthHeaders }
})
