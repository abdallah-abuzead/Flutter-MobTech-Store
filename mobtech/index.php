<?php

include "connect.php" ;
 $cat = $_POST['cat'] ;
 $sql  = "SELECT * FROM mobiles WHERE mob_cat = ?  " ;

//$sql  = "SELECT * FROM mobiles" ;
$stm = $con->prepare($sql);
 $stm->execute(array($cat)) ;
//$stm->execute() ;
$mobiles = $stm->fetchAll(PDO::FETCH_ASSOC) ;

 echo json_encode($mobiles) ; 
