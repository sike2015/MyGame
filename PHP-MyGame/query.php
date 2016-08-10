<?php

include 'conn.php'; 


$sql = "select * from userinfo ORDER BY `userinfo`.`score` DESC";

//执行sql语句
$result = mysql_query($sql);
$array= array();  //创建一个数组 用来接受 
while ($row = mysql_fetch_array($result)){
	
	//自定义输出 数组 
	$array[] = ["username"=>$row['name'],"score"=>$row['score'],"type"=>$row['type'],"udid"=>$row['udid']];
// $array[] = ["username"=>"test"];
//echo $row['name']."</br>";
}
  mysql_query("set names utf8;"); //**设置字符集***/

echo json_encode($array);




//关闭数据库
mysql_close($conn);

?>
