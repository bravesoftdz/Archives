<?php

class model_auth extends model {

    public function getstate() {

        if (!empty($_SESSION['user_id']))
            $data['is_signed'] = true;
        else
            $data['is_signed'] = false;
        return $data;
    }

    public function signin($login, $password) {

        $sql = "SELECT";
        $sql.= " *";
        $sql.= " FROM users";
        $sql.= " WHERE login=" . $this->str_shield($login);
        $result = $this->select($sql);
        $row = $result->fetch_assoc();

        //$salt = '$2a$10$'.substr(str_replace('+', '.', base64_encode(pack('N4', mt_rand(), mt_rand(), mt_rand(),mt_rand()))), 0, 22) . '$';    
        // password check
        //if ($row['Password'] == crypt($password, $row['Salt'])) {
        if ($row['password'] == $password && $row['Id']>0) {            
            $_SESSION['user_id'] = $row['Id'];
            //$_SESSION['first_name'] = $row['first_name'];
            //$_SESSION['login'] = $row['login'];
            //if (!isset($_SESSION['lang_code']))
            //    $_SESSION['lang_code'] = $row['def_lang_code'];
            $data['auth'] = true;
        } else {
            $data['auth'] = false;
            //$data['fail_message'] = 'Authorization Fail.';
        }

        return $data;
    }

    public function logoff() {
        unset($_SESSION['user_id']);
        unset($_SESSION['first_name']);
        unset($_SESSION['login']);
        //unset($_SESSION['lang_code']);
    }

}

?>
