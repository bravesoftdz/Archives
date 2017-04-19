function settlment_edit(ff) 
  {
  var form = document.getElementById("bts_edit_form");
  form.action = "redirect.php?f=4&ff="+ff+"&obj=region";
  form.submit();
  }
function settl_list_edit(ff) 
  {
  var form = document.getElementById("setllement_edit_form");
  form.action = ff;
  form.submit();
  }  
function bts_lists_edit(ff) 
  {
  var form = document.getElementById("bts_edit_form");
  form.action = ff;
  form.submit();
  }  
function config_lists_edit(ff) 
  {
  var form = document.getElementById("config_edit_form");
  form.action = ff;
  form.submit();
  }   
function sectors_lists_edit(ff) 
  {
  var form = document.getElementById("sectors_edit_form");
  form.action = ff;
  form.submit();
  }
function transport_rrl_edit(ff) 
  {
  var form = document.getElementById("transport_edit_form");
  form.action = ff;
  form.submit();
  } 
function on_graph_select() 
  {
  var form = document.getElementById("stat_params");
  form.submit();
  }  

// новая редакция 
function ad_edit(link,form_name) {
  var form = document.getElementById(form_name);
  form.action = link;
  form.submit();
}  

function confirmDelete(link,form_name) {
  if (confirm("Вы подтверждаете удаление?")) {
        if (form_name != '') {ad_edit(link,form_name); }
          else {document.location.href=link; } 
    } else {
        return false;
    }
}
 
function reloadBySelect(selectName, link) {
  var select = document.getElementsByName(selectName);
  var tempParam = selectName+'='+'fltval';
  var getParam = selectName + '=' + select[0].value; 
  link = link.replace(tempParam, getParam);  
  document.location.href = link;
}  

function setInterface() { 
    if ($("[name='belgei_2g_got']").prop("checked")) $("[name='belgei_2g_date']").prop("disabled",false);
    else $("[name='belgei_2g_date']").prop("disabled",true);

    if ($("[name='act_2g_got']").prop("checked")) $("[name='act_2g_date']").prop("disabled",false);
    else $("[name='act_2g_date']").prop("disabled",true);

    if ($("[name='gsm_on']").prop("checked")) $("[name='gsm_date']").prop("disabled",false);
    else $("[name='gsm_date']").prop("disabled",true);

    if ($("[name='dcs_on']").prop("checked")) $("[name='dcs_date']").prop("disabled",false);
    else $("[name='dcs_date']").prop("disabled",true);

    if ($("[name='belgei_3g_got']").prop("checked")) $("[name='belgei_3g_date']").prop("disabled",false);
    else $("[name='belgei_3g_date']").prop("disabled",true);

    if ($("[name='act_3g_got']").prop("checked")) $("[name='act_3g_date']").prop("disabled",false);
    else $("[name='act_3g_date']").prop("disabled",true);

    if ($("[name='umts2100_on']").prop("checked")) $("[name='umts2100_date']").prop("disabled",false);
    else $("[name='umts2100_date']").prop("disabled",true);
    
    if ($("[name='belgei_3g9_got']").prop("checked")) $("[name='belgei_3g9_date']").prop("disabled",false);
    else $("[name='belgei_3g9_date']").prop("disabled",true);

    if ($("[name='act_3g9_got']").prop("checked")) $("[name='act_3g9_date']").prop("disabled",false);
    else $("[name='act_3g9_date']").prop("disabled",true);    

    if ($("[name='umts900_on']").prop("checked")) $("[name='umts900_date']").prop("disabled",false);
    else $("[name='umts900_date']").prop("disabled",true);

    if ($("[name='lte_on']").prop("checked")) $("[name='lte_date']").prop("disabled",false);
    else $("[name='lte_date']").prop("disabled",true);

    if ($("[name='stat_got']").prop("checked")) $("[name='stat_date']").prop("disabled",false);
    else $("[name='stat_date']").prop("disabled",true);

    if ($("[name='uninstall_got']").prop("checked")) $("[name='uninstall_date']").prop("disabled",false);
    else $("[name='uninstall_date']").prop("disabled",true);

    if ($("[name='belgei_2g_got']").prop("checked") && $("[name='act_2g_got']").prop("checked")) {
        $("[name='gsm_on']").parent().css("display","block");
        $("[name='label_gsm_date']").css("display","block");
        $("[name='dcs_on']").parent().css("display","block");
        $("[name='label_dcs_date']").css("display","block");
    } else {
        $("[name='gsm_on']").parent().css("display","none");
        $("[name='label_gsm_date']").css("display","none");
        $("[name='dcs_on']").parent().css("display","none");
        $("[name='label_dcs_date']").css("display","none");
    }

    if ($("[name='belgei_3g_got']").prop("checked") && $("[name='act_3g_got']").prop("checked")) {
        $("[name='umts2100_on']").parent().css("display","block");
        $("[name='label_umts2100_date']").css("display","block");
    } else {
        $("[name='umts2100_on']").parent().css("display","none");
        $("[name='label_umts2100_date']").css("display","none");
    }
    
    if ($("[name='belgei_3g9_got']").prop("checked") && $("[name='act_3g9_got']").prop("checked")) {
        $("[name='umts900_on']").parent().css("display","block");
        $("[name='label_umts900_date']").css("display","block");
    } else {
        $("[name='umts900_on']").parent().css("display","none");
        $("[name='label_umts900_date']").css("display","none");
    }
    
    if ((    $("[name='gsm_on']").prop("checked")
          || $("[name='dcs_on']").prop("checked")
          || $("[name='umts2100_on']").prop("checked")
          || $("[name='umts900_on']").prop("checked")
          || $("[name='lte_on']").prop("checked")
        ) && $("[name='stat_got']").prop("checked")
    ) {
      $("[name='is_on']").parent().css("display","block");
      $("[name='label_is_on']").css("display","block");
    } else {
      $("[name='is_on']").parent().css("display","none");
      $("[name='label_is_on']").css("display","none");
    }
    
    if ($("[name='is_on']").prop("checked")) $("[name='is_on']").val(1);
    else $("[name='is_on']").val(0);
}    

// вешаем на контролы функции обработчики событий
$(function(){
    $("[name='belgei_2g_got']").click(function(event){
        setInterface();
    });

    $("[name='act_2g_got']").click(function(event){
        setInterface();
    });

    $("[name='gsm_on']").click(function(event){
        setInterface();
    });

    $("[name='dcs_on']").click(function(event){
        setInterface();
    });

    $("[name='belgei_3g_got']").click(function(event){
        setInterface();
    });

    $("[name='act_3g_got']").click(function(event){
        setInterface();
    });

    $("[name='umts2100_on']").click(function(event){
        setInterface();
    });
    
    $("[name='belgei_3g9_got']").click(function(event){
        setInterface();
    });

    $("[name='act_3g9_got']").click(function(event){
        setInterface();
    });

    $("[name='umts900_on']").click(function(event){
        setInterface();
    });

    $("[name='lte_on']").click(function(event){
        setInterface();
    });

    $("[name='stat_got']").click(function(event){
        setInterface();
    });

    $("[name='uninstall_got']").click(function(event){
        setInterface();
    });
    
    $("[name='is_on']").click(function(event){
        setInterface();
    });
    
    // фильтры
    $("[name='filters_show']").click(function(event){
        $("#filters_form").css("display","block");
    });
    $("[name='filters_close']").click(function(event){
        $("#filters_form").css("display","none");
    });
    $("#filters_clear").click(function(event){
        $(":input").attr("value", "");
    });
    $(".checkbox_filters").click(function(event) {
        $("#switch_list").submit();
    });

    setInterface();
});

