<?php 
// определ€ем список дл€ редактировани€
if ($_GET['obj']=='regions') 
  {
  $table='regions';
  $field='region';
  $field_title='область';
  }
if ($_GET['obj']=='areas') 
  {
  $table='areas';
  $field='area';
  $field_title='район';
  $cond="WHERE region_id=".$_SESSION['sections'][$_GET['ff']-1]['form']['select'];
  }  
if ($_GET['obj']=='settlements') 
  {
  $table='settlements';
  $field='CONCAT(type," ",settlement)';
  $field_title='населЄнный пункт';
  $cond="WHERE area_id=".$_SESSION['sections'][$_GET['ff']-1]['form']['select'];
  }    
if ($_GET['obj']=='construction_2g_types') 
  {
  $table='construction_2g_types';
  $field='construction_type';
  $field_title='тип металлоконструкций 2G';
  } 
if ($_GET['obj']=='construction_3g_types') 
  {
  $table='construction_3g_types';
  $field='construction_type';
  $field_title='тип металлоконструкций 3G';
  }   
if ($_GET['obj']=='construction_4g_types') 
  {
  $table='construction_4g_types';
  $field='construction_type';
  $field_title='тип металлоконструкций 4G';
  }    
if ($_GET['obj']=='power_types') 
  {
  $table='power_types';
  $field='power_type';
  $field_title='тип питани€';
  }     
if ($_GET['obj']=='gsm_configs') 
  {
  $table='gsm_configs';
  $field='gsm_config';
  $field_title='тип конфигурации gsm';
  }    
if ($_GET['obj']=='dcs_configs') 
  {
  $table='dcs_configs';
  $field='dcs_config';
  $field_title='тип конфигурации dcs';
  } 
if ($_GET['obj']=='umts_configs') 
  {
  $table='umts_configs';
  $field='umts_config';
  $field_title='тип конфигурации umts';
  }  
if ($_GET['obj']=='lte_configs') 
  {
  $table='lte_configs';
  $field='lte_config';
  $field_title='тип конфигурации lte';
  }   
if ($_GET['obj']=='antenna_types_2g') 
  {
  $table='antenna_types';
  $field='antenna_type';
  $field_title='тип антенны';
  $cond="WHERE tech_type in ('2g','gsm','dcs')";
  }  
if ($_GET['obj']=='antenna_types_3g') 
  {
  $table='antenna_types';
  $field='antenna_type';
  $field_title='тип антенны';
  $cond="WHERE tech_type in ('3g')";
  }  
if ($_GET['obj']=='antenna_types_4g') 
  {
  $table='antenna_types';
  $field='antenna_type';
  $field_title='тип антенны';
  $cond="WHERE tech_type in ('4g')";
  }    
if ($_GET['obj']=='antenna_types') 
  {
  $table='antenna_types';
  $field='antenna_type';
  $field_title='тип антенны';
  }      
if ($_GET['obj']=='agreement_persons') 
  {
  $table='agreement_persons';
  $field='name';
  $field_title='ответственные за договора';
  } 
if ($_GET['obj']=='build_persons') 
  {
  $table='build_persons';
  $field='name';
  $field_title='ответственные за строительство';
  } 
if ($_GET['obj']=='build_organizations') 
  {
  $table='build_organizations';
  $field='title';
  $field_title='строительные организации';
  } 
if ($_GET['obj']=='project_organizations') 
  {
  $table='project_organizations';
  $field='title';
  $field_title='проектные организации';
  } 
if ($_GET['obj']=='repeater_types') 
  {
  $table='repeater_types';
  $field='repeater_type';
  $field_title='тип репитерного оборудовани€';
  }               

// блок списка кнопок действий
if ($bg == 'w' || $bm == 'w' || $fm == 'w') {
  $info=array (
    'Ќова€ «апись' => "index.php?f=6&obj=$table&id=new"
  );
  ActionBlock($info);
}

$sql="SELECT $field, id FROM $table $cond ORDER BY $field";
$query=mysql_query($sql) or die(mysql_error());

// вывод элементов интерфейса
echo "<div><table id='result_table' bordercolor='#333' cellpadding='3' cellspacing='0' border='1'>";
echo "<tr align='center'><td></td><td>$field_title</td><td></td></tr>";                                                                                                                       
for ($i=0; $i<mysql_num_rows($query); $i++)
  {
  $row = mysql_fetch_array($query);
  echo "<tr><td><a href='index.php?f=6&obj=$table&id=$row[1]' title='редактировать'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td><td>$row[0]</td><td><a href='values_edit.php?f=6&obj=$table&id=$row[1]&del' title='удалить'><img src='pics/delete_pic.png' width='16' height='16'></a></td></tr>";
  }
echo "</table></div>";
echo "<p><a href='".$_SESSION['sections'][$_GET['ff']]['link']."'>¬ернутьс€ к выбору из списка</a></p>";
?>