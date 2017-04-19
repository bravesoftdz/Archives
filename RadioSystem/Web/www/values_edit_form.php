<?php 
$editlist=$_GET['obj'];
    
if ($editlist=='regions')
  {
  $table='regions';
  $field='region';
  $field_title='область';
  $cond='';
  }
if ($editlist=='areas')
  {
  $table='areas';
  $field='area';
  $field_title='район';
  $cond='';
  }  
if ($editlist=='settlements')
  {
  $table='settlements';
  $field='settlement';
  $field_title='населённый пункт';
  $cond='';
  }   
if ($editlist=='construction_2g_types')
  {
  $table='construction_2g_types';
  $field='construction_type';
  $field_title='тип металлоконструкции 2G';
  }   
if ($editlist=='construction_3g_types')
  {
  $table='construction_3g_types';
  $field='construction_type';
  $field_title='тип металлоконструкции 3G';
  }   
if ($editlist=='construction_4g_types')
  {
  $table='construction_4g_types';
  $field='construction_type';
  $field_title='тип металлоконструкции 4G';
  }    
if ($editlist=='power_types')
  {
  $table='power_types';
  $field='power_type';
  $field_title='тип питания';
  }       
if ($editlist=='gsm_configs')
  {
  $table='gsm_configs';
  $field='gsm_config';
  $field_title='тип конфигурации gsm';
  }      
if ($editlist=='dcs_configs')
  {
  $table='dcs_configs';
  $field='dcs_config';
  $field_title='тип конфигурации dcs';
  }  
if ($editlist=='umts_configs')
  {
  $table='umts_configs';
  $field='umts_config';
  $field_title='тип конфигурации umts';
  }    
if ($editlist=='lte_configs')
  {
  $table='lte_configs';
  $field='lte_config';
  $field_title='тип конфигурации lte';
  }    
if ($editlist=='antenna_types')
  {
  $table='antenna_types';
  $field='antenna_type';
  $field_title='тип антенны';
  $cond='';
  }
if ($editlist=='build_organizations')
  {
  $table='build_organizations';
  $field='title';
  $field_title='строительная организация';
  $cond='';
  }   
if ($editlist=='project_organizations')
  {
  $table='project_organizations';
  $field='title';
  $field_title='проектная организация';
  $cond='';
  }   
if ($editlist=='agreement_persons')
  {
  $table='agreement_persons';
  $field='name';
  $field_title='ответсвенный за договора';
  $cond='';
  }       
if ($editlist=='build_persons')
  {
  $table='build_persons';
  $field='name';
  $field_title='ответсвенный за строительство';
  $cond='';
  }   
if ($editlist=='repeater_types')
  {
  $table='repeater_types';
  $field='repeater_type';
  $field_title='тип репитерного оборудования';
  }        
  
echo "<div id='object_edit'><div id='left_indent'>";
if ($editlist=='settlements') {echo "<div align='right'>тип&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>";$field='settlement,type';}
if ($editlist=='antenna_types') {echo "<div align='right'>тип&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>";$field='antenna_type,tech_type';}
echo "<div align='right'>$field_title&nbsp;&nbsp;&nbsp;&nbsp;</div>";
echo "</div>";

echo "<div id='right_indent'>";
echo "<form action='values_edit.php?obj=$table&id=".$_GET['id']."' method='post'>";

if ($_GET['id']>0)
  {
  $sql="SELECT $field FROM $table WHERE id=".$_GET['id'];
  $query=mysql_query($sql) or die(mysql_error());
  $row = mysql_fetch_array($query);
  $value=$row[0];
  $caption="сохранить";
  }
  else
  {
  $caption="добавить";
  }
  
if ($editlist=='settlements')
  {
  echo "<div><select size='1' id='select_field_small' name='type'>";
  if ($row[1]=='город') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='город'>город</option>";
  if ($row[1]=='посёлок') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='посёлок'>посёлок</option>";
  if ($row[1]=='село') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='село'>село</option>";
  if ($row[1]=='санаторий') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='санаторий'>санаторий</option>";
  if ($row[1]=='трасса') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='трасса'>трасса</option>";
  if ($row[1]=='урочище') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='урочище'>урочище</option>";
  echo "</select></div>";
  } 
if ($editlist=='antenna_types')
  {
  echo "<div><select size='1' id='select_field_small' name='type' required>";
  if ($row[1]=='') {$selected='selected';} else {$selected='';}
  echo "<option $selected value=''></option>";
  if ($row[1]=='gsm') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='gsm'>gsm</option>";
  if ($row[1]=='dcs') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='dcs'>dcs</option>";
  if ($row[1]=='2g') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='2g'>2g</option>";
  if ($row[1]=='3g') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='3g'>3g</option>";
  if ($row[1]=='4g') {$selected='selected';} else {$selected='';}
  echo "<option $selected value='4g'>4g</option>";
  echo "</select></div>";
  }   
         
echo "<div><input type='text' value='$value' size='40' name='record'></div>";
echo "<p><button type='submit'>$caption</button></p>";
echo "</form></div></div>";
?>