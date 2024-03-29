
<?php

include "../connect.php";
include "../functions.php";

$name = filterRequest('name');
$userName = filterRequest('username');
$phone = filterRequest('phone');
$password = filterRequest('password');
$email = filterRequest('email');


$stmt2 = $con->prepare("SELECT `username` FROM `users` WHERE `username`=? ");

$stmt2->execute(array($userName));

$stmt3 = $con->prepare("SELECT `phone` FROM `users` WHERE `phone`=? ");

$stmt3->execute(array($phone));

$stmt4 = $con->prepare("SELECT `email` FROM `users` WHERE `email`=? ");

$stmt4->execute(array($email));

$count = $stmt2->rowCount();
$count2 = $stmt3->rowCount();
$count3 = $stmt4->rowCount();

if($count > 0 ){
    echo json_encode(array("result" => "username-error"));
}else if($count2 > 0 ){
    echo json_encode(array("result" => "phone-error"));
}else if($count3 > 0 ){
    echo json_encode(array("result" => "email-error"));
}
else{
    $stmt = $con->prepare("INSERT INTO `users`(`phone`, `name`, `username`, `email`, `password`)
    VALUES (? , ? , ? , ? , ? )");

    $stmt->execute(array($phone,$name,$userName,$email,$password));
    $count = $stmt->rowCount();
    if($count > 0){
        $stmt = $con->prepare("SELECT * FROM `users` WHERE `phone` = ?");

        $stmt->execute(array($phone));
        
        $count = $stmt->rowCount();
        
        
        $data = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if($count > 0)
            echo json_encode(array("result" => "done" , "data" => $data),JSON_UNESCAPED_UNICODE);
        else
            echo json_encode(array("result" => "error"));
    }
    else
        echo json_encode(array("result" => "error"));
}
?>
