function getXPath( element )
{
    var xpath = '';
    for ( ; element && element.nodeType == 1; element = element.parentNode )
    {
        var id = $(element.parentNode).children(element.tagName).index(element) + 1;
        id > 1 ? (id = '[' + id + ']') : (id = '');
        xpath = '/' + element.tagName.toLowerCase() + id + xpath;
    }
    return xpath;
}

$(document).ready(function () {

    // загрузка iframe
    $('#btn').click(function () {
        var url = $('#panel-edit').val();
        $('#frame').attr('src', 'proxy.php?url=' + url);
    });
    
    // iframe загружен - доступ к контенту 
    $('#frame').on('load', function (){ 
        var frame = $('#frame').contents();
        var selectedObj;
                
        // клик по объекту
        $(frame).find('body').click(function(e){
            $('#field-value').text($(e.target).text());
            $(e.target).css('background', 'buttonshadow');
            
            window.selectedObj = e.target;        
        });
            
        // выбор объекта
        $('#btn-apply').click(function(e){    
          var xpath = getXPath(window.selectedObj);
          console.log(xpath);
        });
        
    });      

});
