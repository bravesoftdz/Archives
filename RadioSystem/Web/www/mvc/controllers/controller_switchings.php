<?php

class controller_switchings extends controller {

    private function set_cat_values($categories, $post, $is_default) {
             
      foreach ($categories as $key => $value) {
        if (isset($post[$value]) || $is_default) {$categories[$key] = 1;
          } else $categories[$key] = 0;
      }
      return $categories; 
    }

    public function action_list() {
        
        $last_index = get_curr_section_indx();
        $post = set_array_type($_SESSION['sections'][$last_index]['form']);
        if (count($post) == 0) $is_default = true;
        
        // задаём категории статуса и их отношения к полям формы
        $stat_categories = array (
           'is_on' => 'isOn'
          ,'is_uninst' => 'is_uninst'  
          ,'is_ready' => 'is_ready'
          ,'is_not_ready' => 'is_not_ready'
        );
        
        // задаём категории технологии и их отношения к полям формы
        $tech_categories = array (
           'is_2g_only' => 'is2Gonly'  
          ,'is_2g' => 'is2G'
          ,'is_3g_only' => 'is3Gonly'  
          ,'is_3g' => 'is3G'
          ,'is_3g9' => 'is3G9'
          ,'is_4g' => 'is4G'    
        );
        
        // фильтры
        foreach ($post as $key => $value) {
          if (!array_search($key, $stat_categories) && !array_search($key, $tech_categories)) $filters[$key] = $value;
        }
        
        // установка значений категорий 
        $stat_categories = $this->set_cat_values($stat_categories, $post, $is_default);  
        $tech_categories = $this->set_cat_values($tech_categories, $post, $is_default);
                                            
        // сортировка
        $sort = $_GET['sort'];
        if (isset($_GET['offset']))
            $offset = $_GET['offset'];
        else
            $offset = 0;

        // вызов модели -> передача данных в представление
        $model = new model_switchings();                  
        $data = $model->get_list(set_array_type($stat_categories), set_array_type($tech_categories), set_array_type($filters), $sort, $offset, 500);
        $_SESSION['transfer_sql'] = $data['transfer_sql'];
        $_SESSION['categories_notes'] = $data['categories_notes'];
        $_SESSION['filters_notes'] = $data['filters_notes'];
        $this->create_view('switchings_list', $data);
    }

    public function action_total() {
    
      $base_sql = $_SESSION['transfer_sql'];
      
      // вызов модели -> передача данных в представление
      $model = new model_switchings();
      $data = $model->get_total($base_sql); 
      $data['categories_notes'] = $_SESSION['categories_notes'];
      $data['filters_notes'] = $_SESSION['filters_notes'];
      $this->create_view('switchings_total', $data);
    }
}

?>