<?php

class controller_index extends controller {

    function action_index() {
        $this->view->generate('view_index.php','view_template.php');
    }

}

?>