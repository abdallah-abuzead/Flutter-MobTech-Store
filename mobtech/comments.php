 <?php

include "connect.php" ;

$postid = $_POST['post_id'] ;

 $sql  = "SELECT comments.* , users.*  FROM comments
 INNER JOIN users ON
 comments.comment_user = users.id
 WHERE comment_post = ?
 " ;
 $stmt = $con->prepare($sql);
 $stmt->execute(array($postid)) ;
 $mobiles = $stmt->fetchAll(PDO::FETCH_ASSOC) ;
 //
 //
 //
 //


// $sql  = "SELECT comments.* , users.*  FROM comments
// INNER JOIN users ON
// comments.comment_user = users.id
// " ;
// $stmt = $con->prepare($sql);
// $stmt->execute() ;
// $mobiles = $stmt->fetchAll(PDO::FETCH_ASSOC) ;

 echo json_encode($mobiles) ; 
