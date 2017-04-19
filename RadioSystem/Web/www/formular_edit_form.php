<?php
// входные параметры
$id=$_GET['id'];
if (isset($_GET['fud'])) $getfud = "&fud";
if (isset($_GET['rep'])) $getfud = "&rep";
if (isset($_GET['rfud'])) $getfud = "&rfud";

// основной запрос
$sql = "SELECT";
$sql.= " *";
$sql.= " FROM formulars";
$sql.= " WHERE id=".NumOrNull($id);
$query = mysql_query($sql) or die(mysql_error());
$row = mysql_fetch_array($query); 

// формируем элементы
$projector_user_id = PrvFill('projector_user_id',$row['projector_user_id']);

if (!isset($_GET['fud']) && !isset($_GET['rfud'])) {    // обычный ФПД
  if (empty($projector_user_id)) $projector_user_id = $user_id;
  $info[] = $info1 = array (
    'value' => $projector_user_id
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'projector_user_id'
    ,'hidden' => true
  );

  $sql = "SELECT CONCAT(name,' ',surname) as projector_name FROM users WHERE id=$projector_user_id";
  $query = mysql_query($sql) or die(mysql_error());
  $row2 = mysql_fetch_array($query);
  $info[] = $info1 = array (
     'field' => 'Ответственный за проектирование'
    ,'value' => $row2[0]
    ,'el_type' => 'text'
    ,'id' => 'select_field'
    ,'name' => 'projector_name'
    ,'disabled' => true
  );
}

if (isset($_GET['fud']) || isset($_GET['rfud'])) {    // ФУД  - пропуск согласования ФПД

  $sql = "SELECT CONCAT(name,' ',surname) as pn, Id FROM users WHERE CONCAT(name,' ',surname) IS NOT NULL ORDER BY pn";
  $query = mysql_query($sql) or die(mysql_error());
  $list = array(array('value'=>'', 'display'=>''));
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row2 = mysql_fetch_array($query);
    $list[] = array('value' => $row2[1], 'display' => $row2[0]);
  } 
  $row2 = mysql_fetch_array($query);
  $info[] = $info1 = array (
     'field' => 'Ответственный за проектирование'
    ,'value' => $projector_user_id
    ,'el_type' => 'select'
    ,'id' => 'select_field'
    ,'name' => 'projector_user_id'
    ,'list' => $list
  );
}

$sql = "SELECT name,Id FROM agreement_persons ORDER BY name";
$query = mysql_query($sql) or die(mysql_error());
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $list[] = array('value' => $row2[1], 'display' => $row2[0]);
} 
$info[] = $info1 = array (
   'field' => 'Ответственный за заключение договора'
  ,'value' => PrvFill('agreem_person_id',$row['agreem_person_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'agreem_person_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=agreement_persons&#039;,&#039;formular_edit_form&#039;);"
);
$sql = "SELECT name,Id FROM build_persons ORDER BY name";
$query = mysql_query($sql) or die(mysql_error());
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $list[] = array('value' => $row2[1], 'display' => $row2[0]);
} 
$info[] = $info1 = array (
   'field' => 'Ответственный за строительство'
  ,'value' => PrvFill('build_person_id',$row['build_person_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'build_person_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=build_persons&#039;,&#039;formular_edit_form&#039;);"
);
$info[] = $info1 = array (
   'el_type' => 'break'
);
$sql = "SELECT title,Id FROM project_organizations ORDER BY title";
$query = mysql_query($sql) or die(mysql_error());
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $list[] = array('value' => $row2[1], 'display' => $row2[0]);
} 
$info[] = $info1 = array (
   'field' => 'Проектная организация'
  ,'value' => PrvFill('project_organization_id',$row['project_organization_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'project_organization_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=project_organizations&#039;,&#039;formular_edit_form&#039;);"
);
$sql = "SELECT title,Id FROM build_organizations ORDER BY title";
$query = mysql_query($sql) or die(mysql_error());
$list = array(array('value'=>'', 'display'=>''));
for ($i=0; $i<mysql_num_rows($query); $i++) {
  $row2 = mysql_fetch_array($query);
  $list[] = array('value' => $row2[1], 'display' => $row2[0]);
} 
$info[] = $info1 = array (
   'field' => 'Строительная организация'
  ,'value' => PrvFill('build_organization_id',$row['build_organization_id'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'build_organization_id'
  ,'list' => $list
  ,'ad_edit' => "ad_edit(&#039;redirect.php?f=5&ff=$section_index&obj=build_organizations&#039;,&#039;formular_edit_form&#039;);"
);
$info[] = $info1 = array (
   'el_type' => 'break'
);
$create_date = PrvFill('create_date',$row['create_date']);
if (empty($create_date)) $create_date = date('Y-m-d');
$info[] = $info1 = array (
   'field' => 'Дата создания ФПД'
  ,'value' => $create_date
  ,'el_type' => 'date'
  ,'id' => 'date_field'
  ,'name' => 'create_date'
  ,'disabled' => true
);
$info[] = $info1 = array (
   'field' => 'Дата обследования'
  ,'value' => PrvFill('inspect_date',$row['inspect_date'])
  ,'el_type' => 'date'
  ,'id' => 'date_field'
  ,'name' => 'inspect_date'
  ,'required' => true
);
$info[] = $info1 = array (
   'el_type' => 'break'
);
$list = array (
   array ('value'=>'', 'display'=>'')
  ,array ('value'=>'Новое строительство', 'Новое строительство')
  ,array ('value'=>'Модернизация под 3G', 'Модернизация под 3G')
  ,array ('value'=>'Модернизация', 'display'=>'Модернизация')
);
if ($id>0) {$disabled = true;} else {$disabled = false;}
$info[] = $info1 = array (
   'field' => 'Тип ФПД'
  ,'value' => PrvFill('type',$row['type'])
  ,'el_type' => 'select'
  ,'id' => 'select_field'
  ,'name' => 'type'
  ,'list' => $list
  ,'required' => true
  ,'disabled' => $disabled
);          
if (!isset($_GET['rep']) && !isset($_GET['rfud']) && empty($row['repeater_id'])) {
  $sql = "SELECT";
  $sql.= " budget.Id";
  $sql.= ",budget_type_2g";
  $sql.= ",budget_number_2g";
  $sql.= ",budget_type_3g";
  $sql.= ",budget_number_3g";
  $sql.= ",outside_id";
  $sql.= ",max(budget_addresses.Id)";
  $sql.= ",budget_addresses.settlement_id";
  $sql.= ",settlement";
  $sql.= ",budget_addresses.street_type";
  $sql.= ",budget_addresses.street_name";
  $sql.= ",budget_addresses.house_type";
  $sql.= ",budget_addresses.house_number";
  $sql.= ",bts_number";
  $sql.= " FROM budget";
  $sql.= " LEFT JOIN budget_addresses";
  $sql.= " ON budget_addresses.id= (SELECT id FROM budget_addresses WHERE budget_id=budget.id ORDER BY -id LIMIT 1)";
  $sql.= " LEFT JOIN settlements";
  $sql.= " ON budget_addresses.settlement_id=settlements.id";
  $sql.= " LEFT JOIN bts";
  $sql.= " ON budget.bts_id=bts.id";
  $sql.= " LEFT JOIN formulars";
  $sql.= " ON formulars.budget_id=budget.id";
  $sql.= " WHERE budget_year>=".date('Y');
  $sql.= " AND (formulars.budget_id is NULL) OR (formulars.budget_id = '".$row['budget_id']."')";
  $sql.= " GROUP BY budget.Id";
  $sql.= " ORDER BY settlement_id, street_name";
  $query = mysql_query($sql) or die(mysql_error());
  $list = array(array('value'=>'', 'display'=>''));
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row2 = mysql_fetch_array($query);
  
    $budget = "(";
    if (!empty($row2['settlement'])) $budget.= $row2['settlement'];
    if (!empty($row2['street_type'])) $budget.= " ".$row2['street_type'];
    if (!empty($row2['street_name'])) $budget.= " ".$row2['street_name'];
    if (!empty($row2['house_type'])) $budget.= " ".$row2['house_type'];
    if (!empty($row2['house_number'])) $budget.= " ".$row2['house_number'];
    $budget.= ") ";
  
    $budget.= "id:".$row2['outside_id'];
    if (!empty($row2['budget_type_2g'])) $budget.= " 2G:".$row2['budget_type_2g']."_".$row2['budget_number_2g'];
    if (!empty($row2['budget_type_3g'])) $budget.= " 3G:".$row2['budget_type_3g']."_".$row2['budget_number_3g'];
    if (!empty($row2['bts_number'])) $budget.= " БС".$row2['bts_number'];
  
    $list[] = array('value' => $row2[0], 'display' => $budget);
  } 
  if ($id>0) {$disabled = true;} else {$disabled = false;}
  $info[] = $info1 = array (
     'field' => 'Связь с бюджетом'
    ,'value' => PrvFill('budget_id',$row['budget_id'])
    ,'el_type' => 'select'
    ,'id' => 'select_field'
    ,'name' => 'budget_id'
    ,'list' => $list
    ,'required' => true
    ,'disabled' => $disabled
    ,'ad_search' => "ad_edit(&#039;redirect.php?f=25&ff=$section_index&obj=budget&#039;,&#039;formular_edit_form&#039;);"
  );
  $info[] = $info1 = array (
     'el_type' => 'break'
  );

  $info[] = $info1 = array (
     'field' => 'Документ форма "1БС"'
    ,'value' => PrvFill('form_1bs_link',$row['form_1bs_link'])
    ,'el_type' => 'link'
    ,'id' => 'text_field_medium'
    ,'name' => 'form_1bs_link'
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=4&ff=$section_index&obj=form_1bs_link&#039;,&#039;formular_edit_form&#039;);"
  );
  $info[] = $info1 = array (
     'value' => PrvFill('form_1bs_link',$row['form_1bs_link'])
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'form_1bs_link'
    ,'hidden' => true
  );
  $info[] = $info1 = array (
     'field' => 'Документ лист согласования'
    ,'value' => PrvFill('agreem_link',$row['agreem_link'])
    ,'el_type' => 'link'
    ,'id' => 'text_field_medium'
    ,'name' => 'agreem_link'
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=4&ff=$section_index&obj=agreem_link&#039;,&#039;formular_edit_form&#039;);"
  );
  $info[] = $info1 = array (
     'value' => PrvFill('agreem_link',$row['agreem_link'])
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'agreem_link'
    ,'hidden' => true
  );
  $info[] = $info1 = array (
     'field' => 'Документ форма РРЛ'
    ,'value' => PrvFill('form_rrl_link',$row['form_rrl_link'])
    ,'el_type' => 'link'
    ,'id' => 'text_field_medium'
    ,'name' => 'form_rrl_link'
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=4&ff=$section_index&obj=form_rrl_link&#039;,&#039;formular_edit_form&#039;);"
  );
  $info[] = $info1 = array (
     'value' => PrvFill('form_rrl_link',$row['form_rrl_link'])
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'form_rrl_link'
    ,'hidden' => true
  );
}

if (isset($_GET['rep']) || isset($_GET['rfud']) || $row['repeater_id']>0) {
  $sql = "SELECT repeater_number,Id FROM repeaters WHERE repeater_number IS NOT NULL ORDER BY repeater_number";
  $query = mysql_query($sql) or die(mysql_error());
  array_splice ($list,0);
  $list[] = array ('value'=>'', 'display'=>'');
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row2 = mysql_fetch_array($query);
    $list[] = array ('value'=>$row2[1], 'display'=>$row2[0]);
  }
  if ($row['repeater_id']>0) {$disabled = true;} else {$disabled = false;}
  $info[] = array (
     'field' => 'Номер репитера'
    ,'value' => PrvFill('repeater_id',$row['repeater_id'])
    ,'el_type' => 'select'
    ,'id' => 'select_field_small'
    ,'name' => 'repeater_id'
    ,'list' => $list
    ,'disabled' => $disabled
  ); 
  $info[] = $info1 = array (
   'el_type' => 'break'
  );
  $info[] = $info1 = array (
     'field' => 'Скан документа'
    ,'value' => PrvFill('agreem_link',$row['agreem_link'])
    ,'el_type' => 'link'
    ,'id' => 'text_field_medium'
    ,'name' => 'agreem_link'
    ,'ad_edit' => "ad_edit(&#039;redirect.php?f=4&ff=$section_index&obj=agreem_link&#039;,&#039;formular_edit_form&#039;);"
  );
  $info[] = $info1 = array (
     'value' => PrvFill('agreem_link',$row['agreem_link'])
    ,'el_type' => 'text'
    ,'id' => 'text_field_small'
    ,'name' => 'agreem_link'
    ,'hidden' => true
  );
}

$info[] = $info1 = array (
   'el_type' => 'break'
);
$info[] = $info1 = array (
 'field' => 'Примечания'
,'value' => PrvFill('notes',$row['notes'])
,'el_type' => 'textarea'
,'id' => 'note_edit'
,'name' => 'notes'
);

// блок списка кнопок действий

// вывод элементов интерфейса
echo "<div id='left_indent'>";
for ($i=0;$i<count($info);$i++) {
  FieldName($info[$i]);
}
echo "</div>";
echo "<div id='right_indent'>";
echo "<form action='formular_edit.php?id=$id$getfud' method='post' id='formular_edit_form'>";
for ($i=0;$i<count($info);$i++) {
  FieldEdit($info[$i]);
}
echo "<p><button type='submit'>сохранить</button></p>";
echo "</form>";
echo "</div>";
?>