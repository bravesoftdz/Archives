<?php
set_time_limit(60*10);
ini_set("memory_limit", "256M"); 

$path = $_SERVER['DOCUMENT_ROOT'];
include_once($path.'/config.php');
include_once($path.'/functions.php');
session_start();


// анимация
if (!isset($_GET['done']) ) {
  echo "<div style='display: table; height: 80%; width: 100%;  text-align: center;'>";
  echo "  <div style='display: table-cell; vertical-align: middle;'>";
  echo "    <div>Выполняется...ждите</div>";
  echo "  <img src='../../pics/loading.gif' width='60' height='60'>";
  echo "  </div>";
  echo "</div>";
  $link="process.php?alias=".$_GET['alias']."&id=".$_GET['id']."&done";
}  

if (isset($_GET['done']) ) {
  $link = $_SESSION['sections'][count($_SESSION['sections'])-1]['link'];

  $list = BtsFreeNumbers();

  // запись результата в файл
  $file = "/files/tasks/".$_GET['alias']."_".uniqid().".csv";
  $fp = fopen($path.$file, 'w');
  foreach ($list as $arr) {
    $line = array($arr['display']);
    fputcsv($fp, $line, ';');
  }
  fclose($fp);
  
  // обновление БД
  $data = array (
    'last_date' => date('Y-m-d H:i:s')
   ,'file_link' => $file
  );
  MySQLAction($data,'tasks',$_GET['id'],'update',true);
}  
  

?> 
<script type="text/javascript" src="../../flot/jquery.js"></script>

<script>
$(document).ready(function (){
  setTimeout(function () {
    var param = '<?php echo $link;?>';
    document.location.href=param;
  } , 1000)
});
</script> 