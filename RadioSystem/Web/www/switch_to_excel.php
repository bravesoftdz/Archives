<?php
include_once('config.php');
include_once('functions.php');
session_start();


if (!isset($_GET['done']) ) {
  echo "<div style='display: table; height: 80%; width: 100%;  text-align: center;'>";
  echo "  <div style='display: table-cell; vertical-align: middle;'>";
  echo "    <div>Выгружается данные в файл stat...ждите</div>";
  echo "  <img src='pics/loading.gif' width='60' height='60'>";
  echo "  </div>";
  echo "</div>";
  $link='switch_to_excel.php?done';
}

if (isset($_GET['done']) ) {
  set_time_limit(60*10);
  exec("bats\stat_export.bat auto"); 
  $link='index.php?f=34';
}

?> 
<script type="text/javascript" src="flot/jquery.js"></script>

<script>
$(document).ready(function (){
  setTimeout(function () {
    var param = '<?php echo $link;?>';
    document.location.href=param;
  } , 1000)
});
</script> 