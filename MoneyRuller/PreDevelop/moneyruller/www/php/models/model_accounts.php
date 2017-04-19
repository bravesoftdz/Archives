<?php

class model_accounts extends model {

  public function get_accounts() {
  
    $sql = "select";
    $sql.= " fa.id"; 
    $sql.= ",fat.note as acc_type";
    $sql.= ",fa.notes as acc_name";
    $sql.= " from fin_accounts fa";
    $sql.= " join currencies c on c.id=fa.curr_id";
    $sql.= " join fin_account_types fat on fat.id=fa.type_id";
    $sql.= " where user_id=1";
    $sql.= " and state=1";
    $sql.= " order by type_id, acc_name, fa.id";
    $result_accounts = $this->select($sql);
    
    $acc_type = "";
    while ($row = $result_accounts->fetch_assoc()) {
      
      if ($acc_type != $row['acc_type']) {
        $acc_type = $row['acc_type'];
      } 
      
      $data['accounts'][$acc_type][] = $row;  
    }
        
    return $data;                  
  }

}


?>