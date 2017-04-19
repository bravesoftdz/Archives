<div id='info_list'>
    <a href='#' id='button_info' name='filters_show'>
        <div id='text_in_button_parent'>    
            <div id='text_in_button_child'>Фильтры</div>
        </div>
    </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="index.php?f=37" id="button_info">
        <div id="text_in_button_parent">    
            <div id="text_in_button_child">Сводная Таблица</div>
        </div>
    </a>      
</div>

<div>
    включенные<input type="checkbox" <?= $data['categories']['is_on'] ?> value="1" class="checkbox_filters" name="isOn" form="switch_list">&nbsp;&nbsp;&nbsp;
    готовые к включению<input type="checkbox" <?= $data['categories']['is_ready'] ?> value="1" class="checkbox_filters" name="is_ready" form="switch_list">&nbsp;&nbsp;&nbsp;
    не готовые к включению<input type="checkbox" <?= $data['categories']['is_not_ready'] ?> value="1" class="checkbox_filters" name="is_not_ready" form="switch_list">&nbsp;&nbsp;&nbsp;
    демонтированные<input type="checkbox" <?= $data['categories']['is_uninst'] ?> value="1" class="checkbox_filters" name="is_uninst" form="switch_list">&nbsp;&nbsp;&nbsp; 
    2G only<input type="checkbox" <?= $data['categories']['is_2g_only'] ?> value="1" class="checkbox_filters" name="is2Gonly" form="switch_list">&nbsp;&nbsp;&nbsp;
    2G<input type="checkbox" <?= $data['categories']['is_2g'] ?> value="1" class="checkbox_filters" name="is2G" form="switch_list">&nbsp;&nbsp;&nbsp;
    3G only<input type="checkbox" <?= $data['categories']['is_3g_only'] ?> value="1" class="checkbox_filters" name="is3Gonly" form="switch_list">&nbsp;&nbsp;&nbsp;
    3G<input type="checkbox" <?= $data['categories']['is_3g'] ?> value="1" class="checkbox_filters" name="is3G" form="switch_list">&nbsp;&nbsp;&nbsp;
    3G 900<input type="checkbox" <?= $data['categories']['is_3g9'] ?> value="1" class="checkbox_filters" name="is3G9" form="switch_list">&nbsp;&nbsp;&nbsp;
    4G<input type="checkbox" <?= $data['categories']['is_4g'] ?> value="1" class="checkbox_filters" name="is4G" form="switch_list">&nbsp;&nbsp;&nbsp;
</div>

<div>
    <table id="result_table">

        <tr align="center">
            <? foreach ($data['fields'] as $field): ?>
            <td id="rs_td">
                <a href="<? echo $field['sort_link'] ?>" title="сортировать"><img src="pics/sort_pic.png" width="16" height="16"></a>&nbsp;
                <? if($field['name']==$data['sort']) $is_sort_field = true; else $is_sort_field = false; ?>
                <? if($is_sort_field): ?><b><? endif; ?><?= $field['title'] ?><? if($is_sort_field): ?></b><? endif; ?>
            </td>
            <? endforeach; ?>
        </tr>

        <? foreach ($data['rows'] as $row): ?>
        <? if($row['is_on']==1): ?>
        <tr class="green_row"><? elseif (!empty($row['uninstall'])): ?><tr class="red_row"><? else: ?>
        <tr><? endif; ?>    

            <? foreach ($data['fields'] as $field): ?>
            <td id="rs_td"><?= $row[$field['name']] ?></td>
            <? endforeach; ?>
        </tr>
        <? endforeach; ?>  
    </table>
</div>

<br>
<div>
    <? if(isset($data['previous_page_link'])): ?>
    <a href="<?= $data['previous_page_link'] ?>" title="предыдущее"><< предыдущее</a>
    <? endif; ?>
    <span>отображено: <?= $data['offset_start'] ?> по <?= $data['offset_end'] ?> из <?= $data['all_records_count'] ?></span>
    <? if(isset($data['next_page_link'])): ?>
    <a href="<?= $data['next_page_link'] ?>" title="следующие">следующие >></a>
    <? endif; ?>
</div>

<div id="filters_form">
    <div class="text_center">
        <b>Фильтры</b>
        <div class="text_right"><a href="#" name="filters_close">[X]</a></div>
    </div><br>
    <form action="redirect.php?f=34" method="post" id="switch_list">
        <? foreach ($data['fields'] as $field): ?>
        <div>
            <div id="label">
                <?= $field['title'] ?>
            </div>
            <? $value = $data['filters'][$field['name']] ?>
            <input type="text" id="text_field_medium" name="<?= $field['name'] ?>" value="<?= $value ?>">
        </div>    
        <? endforeach; ?> 
        <br><div id="label"></div>&nbsp;
        <button type="submit">применить</button>&nbsp;&nbsp;&nbsp;
        <button type="reset" id="filters_clear">сброс</button>
    </form>
</div>