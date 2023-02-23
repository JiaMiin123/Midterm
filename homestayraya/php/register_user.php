<?php
error_reporting(0);
if (!isset($_POST['register'])) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$image = $_POST['image'];


$sqlregister = "INSERT INTO `tbl_user`(`user_email`,`user_name`,`user_password`,`user_phone`) VALUES ('$email','$name','$password','$phone')";
if ($conn->query($sqlregister) === TRUE) {
    $encoded_string = $_POST['image'];
    $filename = mysqli_insert_id($conn);
    $path = 'C:/xampp/htdocs/homestayraya/assets/profileimages/'.$filename.'.png';
    $is_written = file_put_contents($path, $decoded_string);
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($response)
{
    header('Content-Type: application/json');
    echo json_encode($response);
}

?>