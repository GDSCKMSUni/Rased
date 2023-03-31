<?php

include "../connect.php";
include "../functions.php";

$id = filterRequest('id');
$name = filterRequest('name');
$date = filterRequest('date');
$address = filterRequest('address');
$phone = filterRequest('phone');
$details = filterRequest('details');


$imageName = imageUpload("image");

if ($imageName != "FAILED") {
    $stmt = $con->prepare("INSERT INTO `posts` 
    ( `user_id`, `user_name`, `date`, `address`,
     `phone`, `details`, `image_url`) 
     VALUES (? , ? , ? , ? , ? , ? , ?)");

    $stmt->execute(array($id,$name,$date,$address,$phone,$details, $imageName));

    $count = $stmt->rowCount();
    if ($count > 0)
        echo json_encode(array("operator" => "done"));
    else
        echo json_encode(array("operator" => "error"));
} else {
    echo json_encode(array("operator" => "image_error"));
}

?>
