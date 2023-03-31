<?php
// this file for get all user information

include "../connect.php";
include "../functions.php";

$id = filterRequest('id');
$stmt = $con->prepare("SELECT p.post_id, p.user_id, `user_name`,
`date`, `address`, `phone`,
 `details`, `image_url`,CASE
   WHEN k.user_id IS Not NULL and k.user_id =? THEN 1
   ELSE 0
END AS `is_like`
  from `posts` as `p` left join `post_likes` as `k` on
k.post_id = p.post_id;");

$stmt->execute(array($id));

$count = $stmt->rowCount();


$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

if($count > 0)
    echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
else
    echo json_encode(array("result" => "error"));

?>