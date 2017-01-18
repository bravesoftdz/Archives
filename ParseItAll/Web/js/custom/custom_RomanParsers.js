var customFuncs = {
    
    procWikiContent: function(element) {
    
        var child = element.firstElementChild;
        while (child.tagName != 'P') {
            var delChild = child;
            child = child.nextElementSibling;
            delChild.remove(); 
        }
        
        var collection = element.querySelectorAll('#toc');
        for (var i=0; i<collection.length; i++) {
            collection[i].remove();
        } 
        collection = element.querySelectorAll('table');
        for (var i=0; i<collection.length; i++) {
            if (collection[i].style.float == 'right') 
                  collection[i].remove();
        } 
        collection = element.querySelectorAll('.thumbinner');
        for (var i=0; i<collection.length; i++) {
            collection[i].remove();
        } 
        collection = element.querySelectorAll('div.dablink');
        for (var i=0; i<collection.length; i++) {
            collection[i].remove();
        } 
        
        var killEl = false;
        child = element.firstElementChild;
        while (child != null) {
            
            if (   child.innerText === 'Примечания'
                || child.innerText === 'Ссылки')
            ) killEl = true; 
            
            if (killEl) {
                delChild = child;
                delChild.remove(); 
            }
            
            child = child.nextElementSibling;
        }
       
        return element; 
    }  
};