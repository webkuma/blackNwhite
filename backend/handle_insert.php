<?php
session_start();
include("./connect_setting.php");
include("./utilities.php");
include("./handle_verification_token.php");

$action = $_REQUEST["action"];
if (!empty($_REQUEST["data"])) {
  $data = $_REQUEST["data"];
}

switch ($action) {
  case "insertCategory":
    insertCategory($PDO, $data);
    break;
  case "insertLevel":
    insertLevel($PDO, $data);
    break;
}

// 新增類別(側欄名稱)
function insertCategory($PDO, $data)
{
  $isVerification =  verificationToken($PDO, $data);
  if (!$isVerification) {
    http_response_code(401);
    echo "Unauthorized: Invalid token";
  }
  // INSERT INTO articlecontents 
  // (`a_sidebar_name`, `a_level`, `a_parent`, `a_title`, `a_content`, `a_account`) 
  // VALUES ('天界', '1', null, 'title', 'content', 'et')
  $sql = '
  INSERT INTO articlecontents (a_sidebar_name, a_account) 
  VALUES (:categoryName, :account)';
  $stmt = $PDO->prepare($sql);
  try {
    if ($stmt->execute($data)) {
      echo '成功';
    } else {
      echo '失敗';
    }
  } catch (PDOException $e) {
    // Integrity constraint violation: 1062 Duplicate entry ...
    $error = $e->errorInfo[1];
    echo $error;
  }
}

// 新增層級
// 1. 判斷 selectedParent = null ? 查selectedCategory : 查selectedParent
// 2. get_articlecontents_id() -> get aid
// 3. insert  
function insertLevel($PDO, $data)
{
  // ??意思 if(前者 && !null) else回傳後者
  $args = $data['selectedParent'] ?? $data['selectedCategory'];
  $a_id = get_articlecontents_id($PDO, $args);
  $data['a_id'] = $a_id;
  unset($data['selectedCategory']);
  unset($data['selectedParent']);

  // insert 
  $sql = "
    INSERT INTO articlecontents 
    (a_sidebar_name, a_level, a_parent, a_account)
    VALUES (:newTopicName, :level, :a_id, :account)";
    print_r ($data);
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
