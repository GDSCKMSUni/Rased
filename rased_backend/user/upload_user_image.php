<?php

include "../connect.php";
include "../functions.php";

$id = filterRequest('id');
$name = filterRequest('name');


$imageName = imageUpload("image");

if ($imageName != "FAILED") {
    $stmt = $con->prepare("UPDATE `users` SET
     `image_url` = ? ,`name` = ? where `user_id` = ?;");

    $stmt->execute(array($imageName,$name,$id));

    $count = $stmt->rowCount();
    if ($count > 0)
        echo json_encode(array("operator" => "done"));
    else
        echo json_encode(array("operator" => "error"));
} else {
    echo json_encode(array("operator" => "image_error"));
}
?>
