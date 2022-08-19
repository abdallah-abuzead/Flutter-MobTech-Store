<?php 

include "connect.php" ; 

$post = $_POST['post'] ; 
$postuser = $_POST['post_user'];
$imagename = $_POST['image_name'];
$image = base64_decode($_POST['base64']);

$sql = "INSERT INTO `post`( `post`, `post_user`, `post_image`) 
        VALUES             ( :post ,:postuser, :pi )" ;

$stmt = $con->prepare($sql) ; 
$stmt->execute(array(
	":post" => $post , 
	":postuser"   => $postuser ,
	":pi"   => $imagename
));

$count = $stmt->rowCount() ; 

if ($count > 0) {
    file_put_contents('upload\\' . $imagename, $image);
	echo json_encode(array("status" => "success")) ;
}