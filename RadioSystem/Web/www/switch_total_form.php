<?php

// входные параметры

// основной запрос
$sql = $_SESSION['transfer_sql'].' ORDER BY region';      echo $sql;
$query = mysql_query($sql) or die(mysql_error());

function fill_data($region, $row, $data){
    if (!empty($row['gsm'])) $data[$region]['gsm']++;
    if (!empty($row['dcs'])) $data[$region]['dcs']++;
    if (!empty($row['umts900'])) $data[$region]['umts900']++;
    if (!empty($row['umts2100'])) $data[$region]['umts2100']++;
    if (!empty($row['lte'])) $data[$region]['lte']++;
    if (!empty($row['uninstall'])) $data[$region]['uninstall']++;
    if ($row['is2g']==1 && $row['is3g']==0 && $row['is3g9']==0 && $row['is4g']==0) $data[$region]['2g']++;
    if ($row['is2g']==1 && ($row['is3g']==1 || $row['is3g9']==1)) $data[$region]['2g/3g']++;
    if ($row['is2g']==0 && ($row['is3g']==1 || $row['is3g9']==1) && $row['is4g']==0) $data[$region]['3g']++;
    if ($row['is3g9']==1) $data[$region]['3g9']++;
    $data[$region]['total']=$data[$region]['2g']+$data[$region]['2g/3g']+$data[$region]['3g']+$data[$region]['3g9'];
    return $data;
}

// подсчёт
for ($i=0; $i<mysql_num_rows($query); $i++) {
    $row = mysql_fetch_array($query);

    $region = '';
    if ($row['region']=='Брестская') $data = fill_data('Брестская обл.', $row, $data);
    if ($row['settlement']=='Брест') $data = fill_data('Брест', $row, $data);
    if ($row['region']=='Витебская') $data = fill_data('Витебская обл.', $row, $data);
    if ($row['settlement']=='Витебск') $data = fill_data('Витебск', $row, $data);
    if ($row['region']=='Гомельская') $data = fill_data('Гомельская обл.', $row, $data);
    if ($row['settlement']=='Гомель') $data = fill_data('Гомель', $row, $data);
    if ($row['region']=='Гродненская') $data = fill_data('Гродненская обл.', $row, $data);
    if ($row['settlement']=='Гродно') $data = fill_data('Гродно', $row, $data);
    if ($row['region']=='Минская') $data = fill_data('Минская обл.', $row, $data);
    if ($row['settlement']=='Минск') $data = fill_data('Минск', $row, $data);
    if ($row['region']=='Могилёвская') $data = fill_data('Могилёвская обл.', $row, $data);
    if ($row['settlement']=='Могилёв') $data = fill_data('Могилёв', $row, $data);
}

// формируем элементы
echo "<b>".$_SESSION['transfer_description']."</b><br>";

echo "<div>";
echo "<table id='result_table'>";
echo "<tr align='center'>";
echo "<td id='rs_td'>";
echo "регион";
echo "</td>";
echo "<td id='rs_td'>";
echo "gsm";
echo "</td>";
echo "<td id='rs_td'>";
echo "dcs";
echo "</td>";
echo "<td id='rs_td'>";
echo "umts 900";
echo "</td>";
echo "<td id='rs_td'>umts 2100</td>";
echo "<td id='rs_td'>lte 1800</td>";
echo "<td id='rs_td'>Площадки 2g</td>";
echo "<td id='rs_td'>Площадки 2g/3g</td>";
echo "<td id='rs_td'>Площадки 3g</td>";
echo "<td id='rs_td'>Площадки 3g 900</td>";
echo "<td id='rs_td'>Площадки всего</td>";
echo "<td id='rs_td'>Демонтаж всего</td>";
echo "</tr>";


foreach ($data as $region => $counter)  {
    echo "<tr>";
    echo "<td id='rs_td'>$region</td>";
    echo "<td id='rs_td'>".$counter['gsm']."</td>";
    echo "<td id='rs_td'>".$counter['dcs']."</td>";
    echo "<td id='rs_td'>".$counter['umts900']."</td>";
    echo "<td id='rs_td'>".$counter['umts2100']."</td>";
    echo "<td id='rs_td'>".$counter['lte']."</td>";
    echo "<td id='rs_td'>".$counter['2g']."</td>";
    echo "<td id='rs_td'>".$counter['2g/3g']."</td>";
    echo "<td id='rs_td'>".$counter['3g']."</td>";
    echo "<td id='rs_td'>".$counter['3g9']."</td>";
    echo "<td id='rs_td'>".$counter['total']."</td>";
    echo "<td id='rs_td'>".$counter['uninstall']."</td>";
    echo "</tr>";
}

echo "</table>";
echo "</div>";
?>