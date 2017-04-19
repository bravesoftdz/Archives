<h2 class="header_title"><a href="/index.php">MoneyRuller</a></h2>
<ul class="menu">
    <li class="menu_top"><a href="/budget"><? $this->put("menu_budget"); ?></a></li>
</ul>
<div id="auth" class="login">
    <b><? $this->put("hello_label"); ?>, <?php echo $_SESSION['first_name'] ?> [<?php echo $_SESSION['login'] ?>]</b>
    <a href="/auth/logoff"> <? $this->put("signout_value"); ?></a>
</div>
<ul class="menu">
    <?
    $i = 0;
    foreach ($this->data['languages'] as $value):
    $url = $value['url'];
    $value = strtoupper($value['lang_code']).' ('.$value['self_name'].')';
    if ($i==0) $class = "menu_top";
    else $class = "menu_inside";
    $i++;
    ?>
    <li class="<? echo $class; ?>"><a href="<? echo $url; ?>"><? echo $value; ?></a></li>
    <? endforeach; ?>
</ul>