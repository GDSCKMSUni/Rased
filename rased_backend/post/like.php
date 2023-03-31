<?php

include "../connect.php";
include "../functions.php";

$post_id = filterRequest('post_id');
$user_id = filterRequest('user_id');
$type = filterRequest('type');


if ($type == "insert") {
    $stmt = $con->prepare("INSERT INTO `post_likes`
    (`user_id`, `post_id`) VALUES (? , ? )");

    $stmt->execute(array($user_id,$post_id));

    $count = $stmt->rowCount();
    if ($count > 0)
        echo json_encode(array("operator" => "done"));
    else
        echo json_encode(array("operator" => "error"));
} else if ($type == "delete")  {
    $stmt = $con->prepare("DELETE FROM `post_likes` WHERE 
    `user_id` = ? AND `post_id` =  ? ");

    $stmt->execute(array($user_id,$post_id));

    $count = $stmt->rowCount();
    if ($count > 0)
        echo json_encode(array("operator" => "done"));
    else
        echo json_encode(array("operator" => "error"));
}

?>
