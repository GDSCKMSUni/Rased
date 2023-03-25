
<?php

include "../connect.php";
include "../functions.php";

$userId = filterRequest('user_id');

$stmt = $con->prepare("DELETE FROM `users`WHERE `user_id`= ?");

$stmt->execute(array($userId));

$count = $stmt->rowCount();
if($count > 0)
echo json_encode(array("result" => "done"));
else
echo json_encode(array("result" => "error"));



?>
