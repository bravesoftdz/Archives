<?php
set_time_limit(60*10);

include_once('config.php');
include_once('functions.php');
session_start();

$link="index.php?f=14";
$table = $_SESSION['import_table'];
$import_params = $_SESSION['$import_params'];
$csv = $_SESSION['csv'];
$post = $_POST;
if (isset($_GET['key'])) {$key_field=$_GET['key']; $mode='update';} else {$mode='insert';}


// изменения на типичные значения и доп таблицы
foreach ($post as $key => $value) {
  $str = explode('_',$key);
  $col = end($str);
  $row = prev($str);
  $old_value = $csv[$row][$col];

  for ($i=0; $i<count($import_params); $i++ ) {
    if ($import_params[$i]['col_num'] == $col) {
      
      $field = $import_params[$i]['field'];
      $col_num = $import_params[$i]['col_num'];
      $adtable = $import_params[$i]['adtable'];
      $adfield = $import_params[$i]['adfield'];
      
      if (empty($adfield)) {$change_type = 'typic';} else {$change_type = 'id_table';};
    }
  }
  
  if ($change_type == 'typic') {
    if ($value == 'добавить значение') $value = $old_value;
  }
  
  if ($change_type == 'id_table') {
    if ($value == 'добавить значение') {
      $sql = "INSERT INTO $adtable SET $adfield=".StrOrNull($old_value);
      $query = mysql_query($sql) or die(mysql_error());
      $value = $old_value;
    }
    if ($value == 'не заносить') {
      $value = '';
    }
  }
  
  for ($j=0; $j<count($csv); $j++) {
    if ($csv[$j][$col] == $old_value) $csv[$j][$col] = $value;
  }
  
}

for ($i=1; $i<count($csv); $i++ ) {
  $id = 0;
  $data = array();
  for ($j=0; $j<count($import_params); $j++ ) {
    $field = $import_params[$j]['field'];
    $col_num = $import_params[$j]['col_num'];
    $adtable = $import_params[$j]['adtable'];
    $adfield = $import_params[$j]['adfield'];
    if (empty($adfield)) {$change_type = 'typic';} else {$change_type = 'id_table';};
    
    $value = $csv[$i][$col_num];
    if ($value == 'NULL') $value = '';
    if ($value == 'не найден') $value = '';
    if ($change_type == 'id_table') {
      $sql = "SELECT Id FROM $adtable WHERE $adfield=".StrOrNull($value);
      $query = mysql_query($sql) or die(mysql_error());
      $row = mysql_fetch_array($query);
      $value = $row[0];
    }
    if ($field != $key_field)
      $data[$field] = $value;
    
    if ($field == $key_field)
      $key_value = $value;  
  } 
  if ($mode == 'update') {
      $sql = "SELECT Id FROM $table WHERE $key_field=".StrOrNull($key_value);
      $query = mysql_query($sql) or die(mysql_error());
      $row = mysql_fetch_array($query);
      if (!empty($row[0])) {$id = $row[0];} else {$id = 0;}  
  }
  MySQLAction($data,$table,$id,$mode,true);
}
unset($_SESSION['$import_params']);
unset($_SESSION['$csv']);

?>
<script>
var param = '<?php echo $link;?>';
document.location.href=param</script>  