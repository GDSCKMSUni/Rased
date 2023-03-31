<?php
// this file for get all user information

include "../../connect.php";
include "../../functions.php";

$title = filterRequest('title');
$userId = filterRequest('user_id');
$postId = filterRequest('post_id');
$date = filterRequest('date');

$stmt = $con->prepare("INSERT INTO `post_comments`
(`comment_title`, `user_id`, `post_id`, `date`)
 VALUES ( ? , ? , ? , ?)");

$stmt->execute(array($title,$userId,$postId,$date));
  
$count = $stmt->rowCount();


if($count > 0)
    echo json_encode(array("result" => "done"));
else
    echo json_encode(array("result" => "error"));

?>