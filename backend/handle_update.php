<?php
include("./connect_setting.php");
include("./utilities.php");

if (isset($_REQUEST["action"])) {
  $action = $_REQUEST["action"];
  $data = $_REQUEST["data"];
  print_r(123);
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
  $original_data = json_decode(file_get_contents("php://input"), true);  
  if (isset($original_data["action"])) {
    $action = $original_data["action"];
    // 檢查 $action 是否符合條件
    if ($action === 'updateArticleNormalMode' || $action === 'updateArticleEventMode') {
      // $action 符合條件，繼續處理數據
      $data = $original_data['data'];
      print_r($_SERVER["REQUEST_METHOD"]);
      // 接下來可以使用 $action 和 $data 來處理數據
    } else {
      // 如果 $action 不符合條件，可以採取適當的處理方式，例如給予預設值或返回錯誤信息
    }
  } else {
    // 如果 action 參數不存在，可以採取適當的處理方式，例如給予預設值或返回錯誤信息
  }
}


switch ($action) {
  case "updateArticleNormalMode":
    updateArticleNormalMode($PDO, $data);
    break;
  case "updateArticleEventMode":
    updateArticleEventMode($PDO, $data);
    break;
  case "updateIsDeleted":
    updateIsDeleted($PDO, $data);
    break;
  case "handleImageSave":
    handleImageSave($PDO, $data);
    break;
}

function updateArticleNormalMode($PDO, $data){
  if($data['routeParamsLevel']==0){
    $data['routeParamsLevel'] = null;
  }
  $sql = "
  UPDATE articlecontents 
  SET a_title=:title,
  a_content=:content,
  a_editMode=:editMode,
  a_sidebar_name=:editorSidebarName
  WHERE a_id=:id 
  AND a_sidebar_name=:sidebarName 
  AND (a_level=:level OR a_level IS NULL) 
  AND a_account=:account";
  $stmt = $PDO->prepare($sql);
  $result = $stmt->execute([
      'editorSidebarName' => $data['editorSidebarName'],
      'title' => $data['editorTitleName'],
      'content' => $data['editorContent'],
      'editMode' => $data['editMode'],
      'id' => $data['routeParamsId'],
      'sidebarName' => $data['routeParamsName'],
      'level' => $data['routeParamsLevel'],
      'account' => $data['account']
  ]);
  $str = [
    'editorSidebarName' => $data['editorSidebarName'],
    'id' => $data['routeParamsId'],
    'level' => $data['routeParamsLevel'],
  ];
  if ($result) {
    echo json_encode($str);
  }else{
    echo 0;
  }
}
function updateArticleEventMode($PDO, $data){
    // print_r($data);
    // exit();
  if($data['routeParamsLevel']==0){
    $data['routeParamsLevel'] = null;
  }
  $sql = "
  UPDATE articlecontents 
  SET a_title=:editorTitleName, 
      a_sidebar_name=:editorSidebarName,
      a_content=:editorContent, 
      a_editMode=:editMode, 
      a_tagName=:editorTags, 
      a_image_url=:editorImgUrl, 
      a_datetime=:editorDatetime 
  WHERE a_id=:routeParamsId AND 
        a_sidebar_name=:routeParamsName AND 
        (a_level=:routeParamsLevel OR a_level IS NULL) AND 
        a_account=:account";
  $stmt = $PDO->prepare($sql);
  $result = $stmt->execute([
      'editorSidebarName' => $data['editorSidebarName'],
      'editorTitleName' => $data['editorTitleName'],
      'editorContent' => $data['editorContent'],
      'editMode' => $data['editMode'],
      'editorTags' => $data['editorTags'],
      'editorImgUrl' => $data['editorImgUrl'],
      'editorDatetime' => $data['editorDatetime'],
      'routeParamsId' => $data['routeParamsId'],
      'routeParamsName' => $data['routeParamsName'],
      'routeParamsLevel' => $data['routeParamsLevel'],
      'account' => $data['account']
  ]);

  if ($result) {
    echo 1;
  }else{
    echo 0;
  }
}

function updateIsDeleted($PDO, $data){
  if($data['routeParamsLevel']==0){
    $data['routeParamsLevel'] = null;
  }
  $sql = "
  UPDATE articlecontents 
  SET a_deleted=1
  WHERE a_id=:id AND a_sidebar_name=:sidebarName AND (a_level=:level OR a_level IS NULL) AND a_account=:account";
  $stmt = $PDO->prepare($sql);
  $result = $stmt->execute([
      'id' => $data['routeParamsId'],
      'sidebarName' => $data['routeParamsName'],
      'level' => $data['routeParamsLevel'],
      'account' => $data['account']
  ]);
  if ($result) {
    echo 1;
  }else{
    echo 0;
  }
}

function handleImageSave($PDO, $data)
{
  $stmt = $PDO->prepare("SELECT count(*) as count FROM settingimage WHERE s_account = ?");
  $stmt->execute([$data['account']]); 
  $result = $stmt->fetchColumn();
  if ($result > 0) {
    updateImage($PDO, $data);
  } else {
    insertImage($PDO, $data);
  }
}
function insertImage($PDO, $data){
    // insert 
  $sql = "
    INSERT INTO settingimage 
    (s_url, s_account)
    VALUES (:url, :account)";
  $stmt = $PDO->prepare($sql);
  try {
    if ($stmt->execute($data)) {
      echo '成功';
    } else {
      echo '失敗';
    }
  } catch (PDOException $e) {
    // Integrity constraint violation: 1062 Duplicate entry ...
    // $error = $e->errorInfo[1];
    // echo $e;
  }
}
function updateImage($PDO, $data){
  $sql = "
  UPDATE settingimage 
  SET s_url=:url
  WHERE s_account=:account";

  $stmt = $PDO->prepare($sql);
  $result = $stmt->execute([
      'url' => $data['url'],
      'account' => $data['account']
  ]);
  if ($result) {
    echo 1;
  }else{
    echo 0;
  }
}
