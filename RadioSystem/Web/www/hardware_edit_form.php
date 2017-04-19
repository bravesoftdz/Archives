<?php
// входные параметры
$id=$_GET['id'];

// основной запрос
$sql="SELECT * FROM hardware WHERE bts_id='$id'"; 
$query=mysql_query($sql) or die(mysql_error());

$row_count=PrvFill('row_count',mysql_num_rows($query));

// формируем элементы
$info[] = $info1 = array (
   'el_type' => 'break'
);

for ($i=0; $i<$row_count; $i++) {
  $row = mysql_fetch_array($query);
  
  $info[] = $info1 = array (
     'value' => PrvFill("Id_$i",$row['Id'])
    ,'el_type' => 'text'
    ,'id' => 'select_field_small'
    ,'name' => "Id_$i"
    ,'hidden' => true
  );
  $list = array (
     array ('value'=>'', 'display'=>'')
    ,array ('value'=>'Mobile Backhaul CX600', 'display'=>'Mobile Backhaul CX600')
    ,array ('value'=>'Mobile Backhaul Q9300', 'display'=>'Mobile Backhaul Q9300')
    ,array ('value'=>'Mobile Backhaul S9300', 'display'=>'Mobile Backhaul S9300')
    ,array ('value'=>'Mobile Backhaul OptiX PTN 910', 'display'=>'Mobile Backhaul OptiX PTN 910')
    ,array ('value'=>'SDH', 'display'=>'SDH')
    ,array ('value'=>'КНО 12U', 'display'=>'КНО 12U')
  );
  $info[] = $info1 = array (
     'field' => 'Название оборудования'
    ,'value' => PrvFill("equipment_$i",$row['equipment'])
    ,'el_type' => 'select'
    ,'id' => 'select_field'
    ,'name' => "equipment_$i"
    ,'list' => $list
    ,'show_field' => true
    ,'required' => true
    ,'ad_delete' => "confirmDelete(&#039;redirect.php?f=18&rn=$i&del&#039;,&#039;hardware_edit_form&#039;);"
  );
  $info[] = $info1 = array (
     'field' => 'Количество'
    ,'value' => PrvFill("quantity_$i",$row['quantity'])
    ,'el_type' => 'text'
    ,'id' => 'select_field_small'
    ,'name' => "quantity_$i"
    ,'show_field' => true
    ,'required' => true
    ,'pattern' => '[0-9]*'
  );
  $info[] = $info1 = array (
     'el_type' => 'break'
  );
  
}

// блок списка кнопок действий

// вывод элементов интерфейса
echo "<form action='hardware_edit.php?id=$id' method='post' id='hardware_edit_form'>";
echo "<input type='button' value='добавить новое оборудование' onclick='ad_edit(&#039;redirect.php?f=18&add&#039;,&#039;hardware_edit_form&#039;);'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "<p><button type='submit'>сохранить</button></p>";
echo "</form>";
?>