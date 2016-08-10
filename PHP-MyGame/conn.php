<?php
$mysql_server_name='localhost'; //改成自己的mysql数据库服务器

$mysql_username='root'; //改成自己的mysql数据库用户名

$mysql_password='123'; //改成自己的mysql数据库密码

$mysql_database = 'Game'; //选择Game数据库


//连接数据库
$conn = mysql_connect($mysql_server_name,$mysql_username,$mysql_password,$mysql_database) or die("连接数据库服务器失败！".mysqli_error()); //连接MySQL服务器，选择数据库
mysql_query("set names utf8;"); //**设置字符集***

mysql_select_db("Game",$conn);