<?php
session_start();
  //Ваш хост 
  $host = "127.0.0.1"; 
  //Имя пользователя БД
  $user = "mts_user";   
  //Пароль пользователя БД
  $password = "mts_user"; 
  //База данных
  $db = "mts_dbase"; 
  //Функция соединения с сервером
  @mysql_connect($host,$user,$password) or die (mysql_error()); 
  //Функция соединения с базой данных
  @mysql_select_db($db) or die(mysql_error());

mysql_query("SET NAMES cp1251");
date_default_timezone_set('Europe/Minsk');
?>