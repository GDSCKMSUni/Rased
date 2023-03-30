<?php
// this file for get all user information

include "../connect.php";
include "../functions.php";


$id = filterRequest('id');


if($id!=null){
    $stmt = $con->prepare("SELECT * FROM `cities` WHERE `city_id` = ?");

    $stmt->execute(array($id));
    
    $count = $stmt->rowCount();
    
    
    $data = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if($count > 0)
        echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
    else
        echo json_encode(array("result" => "error"));
}else{
    $stmt = $con->prepare("SELECT * FROM `cities`");

    $stmt->execute();
    
    $count = $stmt->rowCount();
    
    
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if($count > 0)
        echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
    else
        echo json_encode(array("result" => "error"));
}



?>