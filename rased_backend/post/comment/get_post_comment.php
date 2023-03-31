<?php
// this file for get all user information

include "../../connect.php";
include "../../functions.php";

$id = filterRequest('id');

$stmt = $con->prepare("SELECT `comment_id`, `comment_title`,u.user_id as `user_id`,
  `post_id`, `date` ,CASE 
    WHEN `name` is Null Then u.user_id
    else `name`
    END AS `user_name`
 from `post_comments` as `p` INNER JOIN `users` as `u` 
 on u.user_id = p.user_id WHERE `post_id` = ?;");

$stmt->execute(array($id));
  
$count = $stmt->rowCount();

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

if($count > 0)
    echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
else
    echo json_encode(array("result" => "error"));

?>