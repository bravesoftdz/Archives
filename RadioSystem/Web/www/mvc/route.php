<?php

require_once 'mvc/core/controller.php';

// роутер
class route {

    public static function start($controller_name, $action_name) {
    
        // полные имена модели, контроллера, метода
        $model_name = 'model_' . $controller_name;
        $controller_name = 'controller_' . $controller_name;
        $action_name = 'action_' . $action_name;
    
        // подключаем файл модели
        $model_file = strtolower($model_name) . '.php';
        $model_path = "mvc/models/" . $model_file;
        if (file_exists($model_path)) {
            include "mvc/models/" . $model_file;
        }
    
        // подключаем файл контроллера
        $controller_file = strtolower($controller_name) . '.php';
        $controller_path = "mvc/controllers/" . $controller_file;
        if (file_exists($controller_path)) {
            include "mvc/controllers/" . $controller_file;
        } else {
            //Route::ErrorPage404();
            echo ('didn`t find controller');
            exit();
        }
    
        // создаЄм экземпл€р класса контроллера
        $controller = new $controller_name;
        $action = $action_name;
    
        // если существует метод - вызываем
        if (method_exists($controller, $action)) {
            $controller->$action();
        } else {
            //Route::ErrorPage404();
            echo ('didn`t find method');
            exit();
        }      
    }
}

?>