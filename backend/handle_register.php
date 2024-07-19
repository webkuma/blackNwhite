<?php
session_start();
include("./connect_setting.php");
$action = $_REQUEST["action"];
$data = $_REQUEST["data"];
switch ($action) {
  case "register":
    register($PDO, $data);
    break;
}


function register($PDO, $data)
{
  // 查帳號重複 1=重複
  $stmt = $PDO->prepare("SELECT count(*) as count FROM users WHERE u_account= ?");
    $stmt->execute([$data['account']]); 
    $result = $stmt->fetch(PDO::FETCH_ASSOC);
  
    if($result['count']) {
      echo '帳號已存在';
    } else {
      $token = generateToken($PDO);
      $data['token'] = $token;
      $sql = 'INSERT INTO users (u_account, u_password, u_token) 
      VALUES (:account, :password, :token)';
      $stmt = $PDO->prepare($sql);
      try {
        if ($stmt->execute($data)) {
          $response = [
            'token' => $token,
            // 'message' => '登入成功',
            'account' => $data['account']
          ];
          echo json_encode($response);
        } else {
          echo '失敗';
        }
      } catch (PDOException $e) {
        // Integrity constraint violation: 1062 Duplicate entry ...
        $error = $e->errorInfo[1];
        echo $error;
      }
    }
}

function generateToken($PDO,$length = 32) {
  return bin2hex(random_bytes($length / 2));
}