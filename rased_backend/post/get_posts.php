<?php
// this file for get all user information

include "../connect.php";
include "../functions.php";

$id = filterRequest('id');
$stmt = $con->prepare("SELECT p.post_id, p.user_id, `user_name`,
`lat`,`long`,
`date`, `address`, `phone`,
 `details`, `image_url`,CASE
   WHEN k.user_id IS Not NULL and k.user_id =? THEN 1
   ELSE 0
END AS `is_like`,count(k.post_id) as `likes`
  from `posts` as `p` left join `post_likes` as `k` on
k.post_id = p.post_id group by k.post_id order by p.post_id desc;");

$stmt->execute(array($id));

$count = $stmt->rowCount();


$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$stmt = $con->prepare("SELECT po.post_id,count(pc.post_id) as `comments` from `post_comments` as `pc` right join `posts` as `po`
on po.post_id = pc.post_id  group by pc.post_id order by po.post_id desc;");

$stmt->execute();

$count = $stmt->rowCount();

$data2 = $stmt->fetchAll(PDO::FETCH_ASSOC);

for($i = 0 ; $i < count($data);$i++){
  $data[$i]['comments'] = $data2[$i]["comments"];
}
if($count > 0)
    echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
else
    echo json_encode(array("result" => "error"));

?>