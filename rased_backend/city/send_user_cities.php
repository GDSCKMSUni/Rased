<?php
// this file for get all user information

include "../connect.php";
include "../functions.php";


$cities = explode("&",filterRequest('cities'));
$id = filterRequest('user_id');
$defualtCityId = filterRequest('city_id');
$error = false;
// print_r($cities);
foreach($cities as $c ){
    $c = str_replace('amp;','',$c);
    $stmt = $con->prepare("INSERT INTO `user_cities`(`user_id`, `city_id`, `is_default`)
    VALUES (? , ? , ? )");
    if($c == $defualtCityId){
        $stmt->execute(array($id,$c,1));
    }
    else{
        $stmt->execute(array($id,$c,0));
    }
    $count = $stmt->rowCount();
    if($count < 1){
        $error = true;
        break;
    }
}
if($error){
    echo json_encode(array("result" => "error"));
}
else{
    echo json_encode(array("result" => "done" ));
}
?>