<div class="types_column">
    <? foreach ($data['expense_types'] as $expense_type): ?>
        <div class="type">
            <span class="type">
                <a href="#">
                    <? echo $expense_type['title']; ?>
                </a>    
            </span>  

            <? foreach ($expense_type['subtypes'] as $expense_subtype): ?>
                <table class="subtype">
                    <tr class="head">
                        <td class="subtype_name">
                            <a href="#">
                                <? echo $expense_subtype['type_title']; ?>
                            </a>
                            <a href="/article/add?autid=<? echo $expense_subtype['uat_id']; ?>" class="aui-icon aui-iconfont-add"></a>
                        </td>
                        <td class="quota_val"><? $this->put("label_plan"); ?> <? echo $data['currencies']['main_curr'] ?></td>
                        <td class="val"><? $this->put("label_fact"); ?> <? echo $data['currencies']['main_curr'] ?></td>
                        <td class="empty"></td>
                        <td class="slave_val"><? $this->put("label_plan"); ?> <? echo $data['currencies']['slave_curr'] ?></td>
                        <td class="slave_val"><? $this->put("label_fact"); ?> <? echo $data['currencies']['slave_curr'] ?></td>
                    </tr>

                    <? foreach ($expense_subtype['articles'] as $articles): ?>
                        <tr>
                            <td class="subtype_name">
                                <a href="article?uaid=<? echo $articles['id']; ?>">
                                    <? echo $articles['article_title']; ?>
                                </a> 
                            </td>
                            <td class="quota_val"><? echo $this->curr_format($articles['quota_value'], $this->data['currencies']['main_curr_id']); ?></td>
                            <td class="val"><? echo $this->curr_format($articles['deb_value'], $this->data['currencies']['main_curr_id']); ?></td>
                            <td class="empty"></td>
                            <td class="slave_val"><? echo $this->curr_format($articles['quota2_value'], $this->data['currencies']['slave_curr_id']); ?></td>
                            <td class="slave_val"><? echo $this->curr_format($articles['deb2_value'], $this->data['currencies']['slave_curr_id']); ?></td>
                        </tr>
                    <? endforeach; ?>

                    <tr class="row_total">
                        <td><? $this->put("label_total"); ?></td>
                        <td class="quota_val"><? echo $this->curr_format($this->data['total']['quot_main_curr'][$expense_subtype['uat_id']], $this->data['currencies']['main_curr_id']); ?></td>
                        <td class="val"><? echo $this->curr_format($this->data['total']['deb_main_curr'][$expense_subtype['uat_id']], $this->data['currencies']['main_curr_id']); ?></td>
                        <td class="empty"></td>
                        <td class="slave_val"><? echo $this->curr_format($this->data['total']['quot_second_curr'][$expense_subtype['uat_id']], $this->data['currencies']['slave_curr_id']); ?></td>
                        <td class="slave_val"><? echo $this->curr_format($this->data['total']['deb_second_curr'][$expense_subtype['uat_id']], $this->data['currencies']['slave_curr_id']); ?></td>
                    </tr>
                </table>          
            <? endforeach; ?>

        </div>
    <? endforeach; ?>
</div>
<div class="total_column">
    <div class="type"><? $this->put("label_settings"); ?>
        <div class="setting">
            <span class="setting_element">
                <select id="set_period">
                    <option selected><? $this->put("label_set_period"); ?></option>
                    <option value="current"><? $this->put("option_current"); ?></option>
                    <option value="previous"><? $this->put("option_previous"); ?></option>
                    <option value="next"><? $this->put("option_next"); ?></option>
                    <option value="custom"><? $this->put("option_custom"); ?></option>
                </select>
            </span>
            <span class="setting_element">
                <input id="begin_date" disabled type="date" value="<? echo $this->data['begin'] ?>">
            </span>
            <span class="setting_element">
                <input id="end_date" disabled type="date" value="<? echo $this->data['end'] ?>">
            </span>
        </div>
        <div class="setting_ext"><? $this->put("label_show_sec_currency"); ?>
            <input type="checkbox">
        </div>
    </div>

    <div class="type"><? $this->put("label_summary"); ?>
        <table class="subtype">
            <tr class="head">
                <td class="type_name"><? $this->put("label_expenses"); ?></td>
                <td class="quota_val"><? $this->put("label_plan"); ?> <? echo $data['currencies']['main_curr'] ?></td>
                <td class="val"><? $this->put("label_fact"); ?> <? echo $data['currencies']['main_curr'] ?></td>
                <td class="empty"></td>
                <td class="slave_val"><? $this->put("label_plan"); ?> <? echo $data['currencies']['slave_curr'] ?></td>
                <td class="slave_val"><? $this->put("label_fact"); ?> <? echo $data['currencies']['slave_curr'] ?></td>
            </tr>
            <? foreach ($this->data['expense_types'] as $expense_type): ?>
                <tr>
                    <td class="type_name"><? echo $expense_type['title']; ?></td>
                    <td class="quota_val"><? echo $this->curr_format($this->data['total']['quot_main_curr'][$expense_type['id']], $this->data['currencies']['main_curr_id']); ?></td>
                    <td class="val"><? echo $this->curr_format($this->data['total']['deb_main_curr'][$expense_type['id']], $this->data['currencies']['main_curr_id']); ?></td>
                    <td class="empty"></td>
                    <td class="slave_val"><? echo $this->curr_format($this->data['total']['quot_second_curr'][$expense_type['id']], $this->data['currencies']['slave_curr_id']); ?></td>
                    <td class="slave_val"><? echo $this->curr_format($this->data['total']['deb_second_curr'][$expense_type['id']], $this->data['currencies']['slave_curr_id']); ?></td>
                </tr>
            <? endforeach; ?>
            <tr class="row_total">
                <td><? $this->put("label_total"); ?></td>
                <td class="quota_val"><? echo $this->curr_format($data['total']['expenses']['quot_main_curr'], $data['currencies']['main_curr_id']); ?></td>
                <td class="val"><? echo $this->curr_format($data['total']['expenses']['deb_main_curr'], $data['currencies']['main_curr_id']); ?></td>
                <td class="empty"></td>
                <td class="slave_val"><? echo $this->curr_format($data['total']['expenses']['quot_second_curr'], $data['currencies']['slave_curr_id']); ?></td>
                <td class="slave_val"><? echo $this->curr_format($data['total']['expenses']['deb_second_curr'], $data['currencies']['slave_curr_id']); ?></td>
            </tr>

        </table>
    </div>    
</div>    
