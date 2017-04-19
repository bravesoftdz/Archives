<?php

class controller_accounts extends controller {

    function action_index() {
    
      $this->create_model('model_accounts');
      $data = $this->model->get_accounts();
      $this->set_output($data);    
    }
}

?>