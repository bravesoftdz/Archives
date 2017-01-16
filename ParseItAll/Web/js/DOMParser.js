var group ={"nodes":[{"ID":2,"tag":"HTML","index":1},{"ID":3,"tag":"BODY","index":1,"className":"ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back"},{"ID":4,"tag":"DIV","index":3,"tagID":"PAGE","className":"non_hotels_like desktop scopedSearch"},{"ID":5,"tag":"DIV","index":4,"tagID":"MAINWRAP"},{"ID":6,"tag":"DIV","index":1,"tagID":"MAIN","className":"SiteIndex prodp13n_jfy_overflow_visible"},{"ID":7,"tag":"DIV","index":1,"tagID":"BODYCON","className":"col poolB adjust_padding new_meta_chevron_v2"},{"ID":8,"tag":"DIV","index":2,"className":"sectionCollection"},{"ID":9,"tag":"DIV","index":1,"className":"resizingMargins"},{"ID":10,"tag":"DIV","index":1,"tagID":"taplc_html_sitemap_payload_0","className":"ppr_rup ppr_priv_html_sitemap_payload"},{"ID":11,"tag":"DIV","index":1,"className":"prw_rup prw_links_sitemap_container"},{"ID":12,"tag":"DIV","index":1,"className":"world_destinations container"},{"ID":13,"tag":"UL","index":1}],"rules":[{"level":2,"nodes":[{"ID":14,"tag":"LI","index":1},{"ID":15,"tag":"A","index":1}]},{"key":"ru_country","nodes":[{"ID":202,"tag":"LI","index":1},{"ID":203,"tag":"A","index":1}]}]};

function getNormalizeString(str) {
    str = str.replace(/\n/g, "");
    str = str.replace(/ {1,}/g, " ");
    return str.trim(str);
}

function checkNodeMatches(matches, node, element) {
    matches.isIDMatch = false;
    matches.isClassMatch = false;
    matches.isNameMatch = false;
    // совпадение ID
    if (node.tagID === undefined)
        node.tagID = '';
    if (element.id === node.tagID)
        matches.isIDMatch = true;
    // совпадение class
    if (node.className === undefined)
        node.className = '';
    if (getNormalizeString(element.className) === node.className)
        matches.isClassMatch = true;
    // совпадение name
    if (node.name === undefined)
        node.name = null;
    if (element.getAttribute('name') === node.name)
        matches.isNameMatch = true;
}

function getElementOfCollectionByIndex(node, collection, matches) {
    var element = collection[node.index - 1];
    checkNodeMatches(matches, node, element);
    return element;
}

function getElementOfCollectionByID(node, collection, matches) {
    if (node.tagID !== '') {
        for (var i = 0; i < collection.length; i++) {
            var element = collection[i];
            if (element.id === node.tagID)
                break;
        }
    }
    checkNodeMatches(matches, node, element);
    return element;
}

function getElementOfCollectionByClass(node, collection, matches) {
    if (node.className !== '') {
        for (var i = 0; i < collection.length; i++) {
            var element = collection[i];
            if (getNormalizeString(element.className) === node.className)
                break;
        }
    }
    checkNodeMatches(matches, node, element);
    return element;
}

function getElementOfCollectionByName(node, collection, matches) {
    if (node.name !== '') {
        for (var i = 0; i < collection.length; i++) {
            var element = collection[i];
            if (element.getAttribute('name') === node.name)
                break;
        }
    }
    checkNodeMatches(matches, node, element);
    return element;
}

function getElementByRuleNode(node, collection, keepSearch) {
    var matches = {
        isIDMatch: false,
        isClassMatch: false,
        isNameMatch: false
    };
    // элемент по индексу (по умолчанию)
    var element = getElementOfCollectionByIndex(node, collection, matches);

    if (!(keepSearch))
        return element;

    // приоритет атрибута "ID"
    if (element === undefined || !(matches.isIDMatch)) {
        var matchElement = getElementOfCollectionByID(node, collection, matches);
        if (matchElement !== undefined)
            element = matchElement;
    }

    // приоритет атрибута "class"
    if (element === undefined || (!(matches.isClassMatch) && (node.tagID === ""))) {
        matchElement = getElementOfCollectionByClass(node, collection, matches);
        if (matchElement !== undefined)
            element = matchElement;
    }

    // приоритет атрибута "name"
    if (element === undefined) {
        matchElement = getElementOfCollectionByName(node, collection, matches);
        if (matchElement !== undefined)
            element = matchElement;
    }

    return element;
}

function getCollectionByTag(element, tag) {
    var collection = [];
    for (var i = 0; i < element.children.length; i++) {
        if (element.children[i].tagName === tag)
            collection.push(element.children[i]);
    }
    return collection;
}

function getElementsByNodes(baseElement, nodes) {
  // перебираем узлы внутри контейнера
  var elements = [baseElement];
  nodes.map(function (node) {
        
      // перебираем совпавшие элементы
      var matchElements = [];
      elements.map(function (element) {
  
          var collection = getCollectionByTag(element, node.tag);  
          // перебираем все дочерние узлы по тегу - ищем новое совпадение
          collection.map(function(child, i) {
                
              // ищем элемент
              node.index = i + 1;
              element = getElementByRuleNode(node, collection, false);
                
              if (element === undefined) 
                  matchElements.push(null);
              else 
                  matchElements.push(element);                      
          });
      });
      elements = matchElements;
  });
  return elements;
}

function getResultObjByElem(rule, elem) {
    if (rule.level !== undefined)  
        return {
            level: rule.level,
            href: elem.href  
        };
        
    if (rule.key !== undefined) {  
        return { 
            key: rule.key,
            value: elem.outerText
        };    
    }    
}

function getDataFromDOMbyGroup(group) {
    var element = document;
    var result = [];

    // получаем коллекцию - контейнер спускаясь по дереву DOM
    group.nodes.map(function (node) {

        // коллекция узлов по тегу
        var collection = getCollectionByTag(element, node.tag);

        // выбор узла 
        element = getElementByRuleNode(node, collection, true);
    });

    // перебираем правила группы
    group.rules.map(function (rule, i) {
        var elements = getElementsByNodes(element, rule.nodes);
        if (i===0) 
            elements.map(function(elem){
                result.push([getResultObjByElem(rule, elem)]);
            });    
        else
            result.map(function(groupArr, j) {            
                var resObj = getResultObjByElem(rule, elements[j]);
                groupArr.push(resObj);
            });    
    });
    return JSON.stringify(result);
}

app.databack(getDataFromDOMbyGroup(group));