<div class="type">Type: <? echo $data['type_title'] ?></div>
<div class="type">Subtype: <? echo $data['subtype_title'] ?></div>

<div class="editble-text" id="<? echo $data['uaid'] ?>">
    <div class="editble-label">Article: </div>
    <div class="editble-field"><? echo $data['article_title'] ?></div>
    <a href="#" class="editble-icon">
        <span class="aui-icon aui-iconfont-edit edit-attrs"></span>
    </a>
</div>

<br>
<div><? echo $data['deb_value'] ?></div>
<div><? echo $data['pr_deb_value'] ?></div>
<div><? echo $data['pr2_deb_value'] ?></div>
<div><? echo $data['pr3_deb_value'] ?></div> 

<script id="text-edit-field" type="text/template"> 
    <div class="editble_text_edit">
    <input type="text">
    </div>
    <a href="#" class="apply-icon">
    <span class="aui-icon  aui-iconfont-success"></span>
    </a>
    <a href="#" class="editble-icon">
    <span class="aui-icon  aui-iconfont-close-dialog"></span>
    </a>
</script>