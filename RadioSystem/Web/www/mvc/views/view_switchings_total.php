<b>
    <? if(!empty($data['categories_notes'])): ?>
    Категории:<?= $data['categories_notes'] ?>
    <? endif; ?>
    <? if(!empty($data['filters_notes'])): ?>
    <br>Фильтры:<?= $data['filters_notes'] ?>
    <? endif; ?>
</b>

<div>
    <table id='result_table'>
        <tr align='center'>
            <td id='rs_td'>регион</td>
            <td id='rs_td'>gsm</td>
            <td id='rs_td'>dcs</td>
            <td id='rs_td'>umts 2100</td>
            <td id='rs_td'>umts 900</td>
            <td id='rs_td'>lte 1800</td>
            <td id='rs_td'>Площадки 2g only</td>
            <td id='rs_td'>Площадки 2g/3g</td>
            <td id='rs_td'>Площадки 3g only</td>
            <td id='rs_td'>Площадки всего</td>
            <td id='rs_td'>Демонтаж</td>
        </tr>

        <? foreach ($data['total'] as $row): ?>
        <tr>
            <td id='rs_td'><?= $row['region'] ?></td>
            <td id='rs_td'><?= $row['conf_gsm'] ?></td>
            <td id='rs_td'><?= $row['conf_dcs'] ?></td>
            <td id='rs_td'><?= $row['conf_umts'] ?></td>
            <td id='rs_td'><?= $row['conf_umts9'] ?></td>
            <td id='rs_td'><?= $row['conf_lte'] ?></td>  
            <td id='rs_td'><?= $row['2g_only'] ?></td> 
            <td id='rs_td'><?= $row['2g/3g'] ?></td>
            <td id='rs_td'><?= $row['3g_only'] ?></td> 
            <td id='rs_td'><?= $row['sites'] ?></td>
            <td id='rs_td'><?= $row['uninstall'] ?></td>
        </tr>
        <? endforeach; ?>
        
        <tr>
            <td id='rs_td'><b>Итого</b></td>
            <td id='rs_td'><b><?= $data['conf_gsm_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['conf_dcs_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['conf_umts_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['conf_umts9_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['conf_lte_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['2g_only_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['2g/3g_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['3g_only_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['sites_total'] ?></b></td>
            <td id='rs_td'><b><?= $data['uninstall_total'] ?></b></td>
        </tr>    
    </table>
</div>