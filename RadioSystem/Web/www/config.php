<?php
session_start();
  //��� ���� 
  $host = "127.0.0.1"; 
  //��� ������������ ��
  $user = "mts_user";   
  //������ ������������ ��
  $password = "mts_user"; 
  //���� ������
  $db = "mts_dbase"; 
  //������� ���������� � ��������
  @mysql_connect($host,$user,$password) or die (mysql_error()); 
  //������� ���������� � ����� ������
  @mysql_select_db($db) or die(mysql_error());

mysql_query("SET NAMES cp1251");
date_default_timezone_set('Europe/Minsk');
?>