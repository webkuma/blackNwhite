<?php
session_start();
include("./connect_setting.php");
include("./utilities.php");

$action = $_REQUEST["action"];
if (!empty($_REQUEST["data"])) {
  $data = $_REQUEST["data"];
}

switch ($action) {
  case "getSidebarData":
    getSidebarData($PDO);
    break;
  case "getSelectedCategoryData":
    getSelectedCategoryData($PDO);
    break;
 case "getLevelTopic":
  getLevelTopic($PDO, $data);
    break;
 case "getTitleAndContent":
  getTitleAndContent($PDO, $data);
    break;
 case "getArticleEventMode":
  getArticleEventMode($PDO);
    break;
 case "getSettingImage":
  getSettingImage($PDO, $data);
    break;
}

function getSidebarData($PDO){
    $stmt = $PDO->prepare("
    SELECT a_id ,a_sidebar_name, a_level, a_parent, a_editMode, a_account 
    FROM `articlecontents` 
    WHERE a_deleted=0 ORDER BY `a_id` ASC");
    $stmt->execute(); 
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($result);
}

function getSelectedCategoryData($PDO){
  $stmt = $PDO->prepare("SELECT * FROM `articlecontents` where a_parent IS NULL AND a_deleted=0");
  $stmt->execute(); 
  $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($result);
}

// 取得類別底下的子層
function getLevelTopic($PDO, $data){
  $a_id = get_articlecontents_id($PDO, $data);
  $stmt = $PDO->prepare("SELECT * FROM `articlecontents` where a_parent = ? AND a_deleted=0");
  $stmt->execute([$a_id]); 
  $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($result);
}
// 取得編輯器的文章資料
function getTitleAndContent($PDO, $data){
  if($data['level']==0){
    $data['level'] = null;
  }
  $stmt = $PDO->prepare
  ("SELECT * FROM `articlecontents` 
  where a_id = ? and a_sidebar_name = ? AND (a_level = ? OR a_level IS NULL) AND a_deleted=0");
  $stmt->execute([$data['id'], $data['name'], $data['level']]); 
  $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($result);
}
// 取得所有 a_editMode='event' 的資訊
function getArticleEventMode($PDO){
  $stmt = $PDO->prepare
  ("SELECT * FROM `articlecontents` 
  WHERE a_editMode='event' 
  AND a_level IS NOT NULL 
  AND a_parent IS NOT NULL
  AND a_deleted = 0");
  $stmt->execute(); 
  $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($result);
}

// 取得 setting image 圖片
function getSettingImage($PDO, $data){
  $stmt = $PDO->prepare("SELECT * FROM `settingimage` where s_account = ?");
  $stmt->execute([$data['account']]); 
  $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode($result);
}