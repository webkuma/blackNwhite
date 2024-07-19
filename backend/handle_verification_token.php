<?php
session_start();
include("./connect_setting.php");

$action = $_REQUEST["action"];
if (!empty($_REQUEST["data"])) {
  $data = $_REQUEST["data"];
}

switch ($action) {
  case "verificationToken":
    verificationToken($PDO, $data);
    break;
}

function verificationToken($PDO, $data){
  $headers = getallheaders();
  if (isset($headers['authorization'])) {
    $token = trim(str_replace("Bearer", "", $headers['authorization']));
    $account = $headers['account'];
    $stmt = $PDO->prepare
    ("SELECT count(*) as count FROM users where u_token = :token and u_account = :account");
    $stmt->execute([$token, $account]);
    $result = $stmt->fetchColumn();
    echo json_encode($result);
    return true;
  } else {
    // 如果沒有 Authorization 標頭，表示請求未被授權，可以返回相應的錯誤訊息或 HTTP 狀態碼
    http_response_code(401);
    echo "Unauthorized";
    return false;
    // exit();
  }
}

