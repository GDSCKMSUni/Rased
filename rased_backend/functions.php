<?php

define("MB",1048576);

function filterRequest($requestName){

    if(isset($_POST[$requestName]))
    return htmlspecialchars(strip_tags($_POST[$requestName]));
    else return null;
}

function imageUpload($imageRequest){
    global $msgError ; 
    $imageName = rand(1000,10000).$_FILES[$imageRequest]['name'];
    $imageTmp  = $_FILES[$imageRequest]['tmp_name'];
    $imageSize = $_FILES[$imageRequest]['size'];
    $allowExtention = array("jpg","jpeg","png","gif");
    $strToArray = explode(".",$imageName);
    $ext = end($strToArray);
    $ext = strtolower($ext);
    if(!empty($imageName) && !in_array($ext,$allowExtention)){
        $msgError['error'] = "Extention";
    }
    if($imageSize > 10 * MB){
        $msgError['error'] = "Size";
    }
    if(empty($msgError)){
        if(move_uploaded_file($imageTmp,"../upload/".$imageName)){
            return $imageName;
        }

    }else{
        return "FAILED"; 
    }
}


function deleteFile($dir,$imageName){
    if(file_exists($dir.'/'.$imageName)){
        unlink($dir.'/'.$imageName);
    }
}
        ?>

    