# 🗺️ blackNwhite
這是一個類似於紀錄遊戲世界觀的作品。該作品基於從朋友處獲取的真實需求而製作，主要目的是提供一個後台介面，用於新增、修改和刪除文章。功能主要圍繞編輯器（**tinymce**）的使用和 UI 庫（**element-plus**）的練習。由於沒有伺服器部署，下面將用圖片介紹。

網站資料建置使用了 **PHP** 作為後端服務，並使用 **MySQL** 作為資料庫。

## ✨ 主要功能

**後端**
- **📝 側欄管理**：用戶可以自定義側欄的標題和子標題，並支持新增、修改和刪除操作。（見圖 1）
- **📝 文章管理**：用戶可以通過 **TinyMCE** 編輯器新增、修改和刪除文章資訊。（見圖 2）

**前端**
- **📄 文章顯示**：主頁展示文章，包括一般文章記錄和重大事件紀錄，並支持時間軸顯示。（見圖 3 和圖 4）


## 🖼️ 畫面介紹
**圖 1：側欄管理**
<table><tr><td align="center">
    <img src="https://github.com/user-attachments/assets/326a4a36-fcee-4de3-997a-2c0fb0c0cdda" alt="Sidebar Management" />
</td></tr></table>

**圖 2：文章管理**
<table><tr><td align="center">
    <img src="https://github.com/user-attachments/assets/1081e6e6-6113-4001-b806-39d31e709ed3" alt="Article Management" />
</td></tr></table>

**圖 3：文章顯示 - 一般文章**
<table><tr><td align="center">
    <img src="https://github.com/user-attachments/assets/1dcfb575-ffd5-48f9-b92a-e2c03570bb09" alt="Article Display - Regular" />
</td></tr></table>

**圖 4：文章顯示 - 重大事件（時間軸）**
<table><tr><td align="center">
    <img src="https://github.com/user-attachments/assets/933b82a6-7251-4cfb-b269-e68c742e62e8" alt="Article Display - Timeline" />
</td></tr></table>

## 🛠 技能

- **前端**：
  - **Vue 3**：用於構建前端界面和管理組件。
  - **Vue Router**：負責前端路由管理。
  - **Pinia**：進行狀態管理。
  - **Axios**：用於從 PHP 伺服器獲取數據。
  - **TinyMCE**：提供強大的富文本編輯功能。
  - **Element Plus**：使用於 UI 元素的設計和組件庫。

- **後端**：
  - **XAMPP**：提供 PHP 和 MySQL 的本地開發環境。
  - **Apache**：Web 伺服器，用於處理 HTTP 請求。
  - **PHP**：用於服務端邏輯處理。
  - **MySQL**：關聯式資料庫管理系統，用於數據存儲。

## 🗃️ ERD (Entity Relationship Diagram)
<table><tr><td align="center">
    <img src="https://github.com/user-attachments/assets/887565da-f388-41f0-abe6-18a5c8980ad8" alt="ERD" />
</td></tr></table>
