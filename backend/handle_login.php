<?php
session_start();
include("./connect_setting.php");
$action = $_REQUEST["action"];
$data = $_REQUEST["data"];
switch ($action) {
  case "login":
    register($PDO, $data);
    break;
}


function register($PDO, $data)
{
  // 登入查帳號密碼 1=有資料
  $stmt = $PDO->prepare
  ("SELECT * FROM users WHERE u_account= ? and u_password = ?");
  $stmt->execute([$data['account'],$data['password']]); 
  $result = $stmt->fetch(PDO::FETCH_ASSOC); // 關聯陣列
    if($result) {
      $response = [
        'token' => $result['u_token'],
          // 'message' => '登入成功',
          'account' => $data['account']
      ];
      echo json_encode($response);
    } else {
      echo '帳號或密碼錯誤';
    }
}

function generateToken($PDO,$length = 32) {
  return bin2hex(random_bytes($length / 2));
}