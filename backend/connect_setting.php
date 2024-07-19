<?php
// PDO 連線設定
$options = [
  PDO::ATTR_PERSISTENT => false,
  PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
  PDO::ATTR_EMULATE_PREPARES => false,
  PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8mb4'
];
//資料庫連線
try {
  $PDO = new PDO('mysql:host=127.0.0.1;port=3306;dbname=blacknwhite', 'root', '', $options);
  $PDO->exec('SET CHARACTER SET utf8mb4');
} catch (PDOException $e) {
  throw new PDOException($e->getMessage());
}
