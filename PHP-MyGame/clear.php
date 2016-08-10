<?php

include 'conn.php';

$sql = "truncate table userinfo";

$result = mysql_query($sql);



if ($result) {
	$array = array("message"=>"success");

	echo json_encode($array);

}else {
	$array = array("message"=>"fail");

	echo json_encode($array);
}

// 关闭连接
mysql_close($conn);

?>