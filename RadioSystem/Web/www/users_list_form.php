<?php
// входные параметры
if (isset($_GET['sort'])) {$sort = ' ORDER BY '.$_GET['sort'];}

// основной запрос
$sql = "SELECT * FROM users"; 
$sql.= $sort; 
$query=mysql_query($sql) or die(mysql_error());

// формируем элементы

// блок списка кнопок действий
if ($admin == 'w') {
  $info=array (
     'Ќовый ѕользователь' => "index.php?f=22&id=0"
  );
  ActionBlock($info);
}

// вывод элементов интерфейса
echo "<form action='redirect.php?f=21' method='post' id='users_list'>";
echo "</form>";

if (mysql_num_rows($query)>0) {
  echo "<table id='result_table'>";
  echo "<tr align='center'>";  // заголовки
  echo "<td id='rs_td'></td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=21&sort=surname&#039;,&#039;users_list&#039;);');'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;пользователь</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=21&sort=login&#039;,&#039;users_list&#039;);');'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;логин</td>";
  echo "<td id='rs_td'><a href='#' title='сортировать' onclick='ad_edit(&#039;index.php?f=21&sort=department&#039;,&#039;users_list&#039;);');'><img src='pics/sort_pic.png' width='16' height='16'></a>&nbsp;подразделение</td>";
  echo "<td id='rs_td'></td>";
  echo "</tr>";
  for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);
    echo "<tr>";
    echo "<td id='rs_td'><a href='#' title='редактировать' onclick='ad_edit(&#039;index.php?f=22&id=".$row['Id']."&#039;,&#039;users_list&#039;);'><img src='pics/edit_pic.jpg' width='16' height='16'></a></td>";
    echo "<td id='rs_td'>".NameFormat('fio',$row['surname'],$row['name'],$row['middle_name'])."</td>";
    echo "<td id='rs_td'>".$row['login']."</td>";
    echo "<td id='rs_td'>".$row['department']."</td>";
    echo "<td id='rs_td'><a href='#' title='удалить' onclick='confirmDelete(&#039;redirect.php?f=21&id=".$row['Id']."&del&#039;,&#039;users_list&#039;);'><img src='pics/delete_pic.png' width='16' height='16'></a></td>";
    echo "</tr>";
  } 
  echo "</table>";
}

?>