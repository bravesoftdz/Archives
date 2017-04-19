<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>MoneyRuller</title>
        <link rel="stylesheet" type="text/css" href="/css/Atlassian-icons.css">
        <link rel="stylesheet" type="text/css" href="/css/styles.css">
        <script type="text/javascript" src="/js/jquery-2.2.1.js"></script>
        <script type="text/javascript" src="/js/scripts.js"></script>
    </head>
    <body>
        <div id="header" class="header">
            <?php if (isset($_SESSION['user_id'])) $this->include_view("view_header.php");
                  else $this->include_view("view_login.php");
            ?>
        </div>
        <div id="content" class="content">
            <?php $this->include_view($this->content_view); ?>
        </div>
    </body>
</html>