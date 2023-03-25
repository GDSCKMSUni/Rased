<?php
// this file for get all user information

include "../connect.php";
include "../functions.php";

$username = filterRequest('username');
$password = filterRequest('password');



$stmt = $con->prepare("SELECT * FROM `users` WHERE `username` = ? and `password` = ?");

$stmt->execute(array($username,$password));

$count = $stmt->rowCount();


$data = $stmt->fetch(PDO::FETCH_ASSOC);

if($count > 0)
    echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
else
    echo json_encode(array("result" => "error"));


?>