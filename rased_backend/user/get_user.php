<?php
// this file for get all user information

include "../connect.php";
include "../functions.php";

$value = filterRequest('value');
$type = filterRequest('type');


if($type=='phone'){
    $stmt = $con->prepare("SELECT * FROM `users` WHERE `phone` = ?");

    $stmt->execute(array($value));
    
    $count = $stmt->rowCount();
    
    
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if($count > 0)
        echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
    else
        echo json_encode(array("result" => "error"));
}else if($type=='id'){
    $stmt = $con->prepare("SELECT * FROM `users` WHERE `user_id` = ?");

    $stmt->execute(array($value));
    
    $count = $stmt->rowCount();
    
    
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if($count > 0)
        echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
    else
        echo json_encode(array("result" => "error"));
}



?>