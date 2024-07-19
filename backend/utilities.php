<?php
include("./connect_setting.php");

function get_articlecontents_id($PDO, $name){
  $stmt = $PDO->prepare("SELECT a_id FROM articlecontents WHERE a_sidebar_name=?");
  $stmt->execute([$name]); 
  $result = $stmt->fetchColumn(); // 取得結果的第一列（a_id）
  return $result; 
}