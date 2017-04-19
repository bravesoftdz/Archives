<h2 class="header_title"><a href="/index.php">MoneyRuller</a></h2>
<div id="auth" class="login">
  <form  method="post" action="/auth/logon">
    <input type="text" name="login" placeholder="<? $this->put("login_placeholder"); ?>">
    <input type="password" name="password" placeholder="<? $this->put("password_placeholder"); ?>">
    <input type="submit" value="<? $this->put("submit_value"); ?>">
  </form>
</div>
<ul class="menu">
    <?  $i = 0;
        foreach ($this->data['languages'] as $value):
        $url = $value['url'];
        $value = strtoupper($value['lang_code']).' ('.$value['self_name'].')';
        if ($i==0) $class = "menu_top"; else $class = "menu_inside";
        $i++;
    ?>
    <li class="<? echo $class; ?>"><a href="<? echo $url; ?>"><? echo $value; ?></a></li>
    <? endforeach; ?>
</ul>
