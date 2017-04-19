<?php
// блок списка кнопок действий
if ($admin == 'w') {
  $info=array (
     'Пользователи' => "index.php?f=21"
    ,'Персональные Инструменты' => "index.php?f=28"
    ,'Импорт Данных' => "index.php?f=15&step1"
    ,'Update Данных' => "index.php?f=15&update&step1"
  );
  ActionBlock($info);
}
?> 