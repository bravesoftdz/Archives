<?php
session_start();
$_SESSION['user_id'] =0;
unset($_SESSION['user_name']);
unset($_SESSION['user_middle_name']);
unset($_SESSION['user_surname']);
unset($_SESSION['user_login']);
?>
<script>document.location.href="index.php"</script>