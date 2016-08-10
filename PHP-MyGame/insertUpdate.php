<?php
header('Content-type:text/json');
//得到的数据  
$name = $_GET['name'];
$score = $_GET['score'];
$udid = $_GET['udid'];
$type = $_GET['type'];


// $name = "suxiaoyu";
// $score = "98";
// $udid = "URYHFHJIOWW";
// $type = "1";

include 'conn.php'; //导入数据库


//先查找 当前的udid 是否存在
$searchSQL = "select * from userinfo where udid = '$udid' ";

// echo $searchSQL."</br>";

$res = mysql_query($searchSQL);

//判断用户名是否存在!
if(mysql_num_rows($res)>0){
// 	echo "current account is exit!";
	
	
	$sql = "update userinfo set score='$score', name='$name' where udid ='$udid'";
// 	echo $sql."<br>";
	$result = mysql_query($sql);
	
	
	if ($result) {
	
		$array = array("message"=>"success");
		echo json_encode($array);
	
	}else {
		$array = array("message"=>"fail");
		echo json_encode($array);
	}

}else {
// 	echo "current account not is exit!";
	
	
	$sql = "insert into userinfo (name,score,udid,type) value ('$name','$score','$udid','$type') ";
	mysql_query("SET NAMES UTF8");
	$result = mysql_query($sql);
	if ($result) {
		$array = array("message"=>"success");
		echo json_encode($array);
	
	}else {
		$array = array("message"=>"fail");
	
		echo json_encode($array);
	}
}


// 关闭连接
mysql_close($conn);




?>