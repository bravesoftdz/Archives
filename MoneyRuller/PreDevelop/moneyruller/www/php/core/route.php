<?php

// роутер
class route {

    static function start() {
        // начальные значения контроллера и метода (по умолчанию) 
        $controller_name = 'index';
        $action_name = 'index';

        // парсим url строку в массив слов
        $uri = $_SERVER['REQUEST_URI'];
        if (count($_GET) > 0)
            $uri = substr($uri, 0, stripos($uri, '?'));
        $routes = explode('/', $uri);

        // определяем язык
        $lang_code = $routes[1];

        // определяем режим api - web
        if ($routes[2] == 'api') {
            $is_api = true;
            $controller_pos = 3;
            $action_pos = 4;
        } else {
            $is_api = false;
            $controller_pos = 2;
            $action_pos = 3;
        }

        // задаём имя контроллера
        if (!empty($routes[$controller_pos]))
            $controller_name = $routes[$controller_pos];

        // задаём имя метода
        if (!empty($routes[$action_pos]))
            $action_name = $routes[$action_pos];

        // полные имена модели, контроллера, метода
        $model_name = 'model_' . $controller_name;
        $controller_name = 'controller_' . $controller_name;
        $action_name = 'action_' . $action_name;

        // подключаем файл модели
        $model_file = strtolower($model_name) . '.php';
        $model_path = "php/models/" . $model_file;
        if (file_exists($model_path)) {
            include "php/models/" . $model_file;
        }

        // подключаем файл контроллера
        $controller_file = strtolower($controller_name) . '.php';
        $controller_path = "php/controllers/" . $controller_file;
        if (file_exists($controller_path)) {
            include "php/controllers/" . $controller_file;
        } else {
            //Route::ErrorPage404();
            echo ('didn`t find controller');
            exit();
        }

        // создаём экземпляр класса контроллера
        $controller = new $controller_name($is_api, $lang_code);
        $action = $action_name;

        // если существует метод - вызываем
        if (method_exists($controller, $action)) {
            $controller->$action();
        } else {
            //Route::ErrorPage404();
            echo ('didn`t find method');
            exit();
        }
        // after action redirect
        //if ($controller_name=='Controller_auth' && ($action_name=='action_logon' || $action_name=='action_logoff')) {
        //$host = 'http://'.$_SERVER['HTTP_HOST'].'/';
        //header('Location:'.$host.'main/index');
        //}
    }

    //static function ErrorPage404() {
    //$host = 'http://'.$_SERVER['HTTP_HOST'].'/';
    //header('HTTP/1.1 404 Not Found');
    //header("Status: 404 Not Found");
    //header('Location:'.$host.'404.html');
    //}
}

?>