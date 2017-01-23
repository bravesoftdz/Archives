function getNormalizeString(str) {
    str = str.replace(/\n/g, "");
    str = str.replace(/ {1,}/g, " ");
    return str.trim(str);
}

function checkNodeMatches(matches, node, element) {
    matches.isIDMatch = false;
    matches.isClassMatch = false;
    matches.isNameMatch = false;

    if (element === null)
        return false;

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

function processRegExps(element, regexps) {

    var result = element;
    regexps.map(function (regexp) {
        var HTML = element.innerHTML;
        var matches = HTML.match(regexp.regexp);

        if (regexp.type === 1) {
            if (matches === null)
                result = null;
        }
        if (regexp.type === 3) {
            var re = new RegExp(regexp.regexp, "g");
            HTML = HTML.replace(re, "");
            result.innerHTML = HTML;
        }
    });

    return result;
}

function getElementByRuleNode(node, collection, keepSearch) {
    var matches = {
        isIDMatch: false,
        isClassMatch: false,
        isNameMatch: false
    };
    // элемент по индексу (по умолчанию)
    var element = getElementOfCollectionByIndex(node, collection, matches);

    if (keepSearch) {
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
            collection.map(function (child, i) {

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

function getResultObjByElem(rule, elem, firstGroupResult) {

    // обработка RegExps
    elem = processRegExps(elem, rule.regexps);

    // проверка на наличие ключевой (первой) записи в группе
    if (firstGroupResult !== undefined)
        if (firstGroupResult.nomatchruleid !== undefined)
            elem = null;

    if (elem === null)
        return {
            id: rule.id,
            nomatchruleid: rule.id
        };

    // пользовательская обработка
    if (rule.custom_func !== undefined)
        elem = customFuncs[rule.custom_func](elem);

    if (rule.level !== undefined)
        return {
            id: rule.id,
            level: rule.level,
            href: elem.href
        };
    if (rule.key !== undefined) {

        if (rule.typeid === 1)
            return {
                id: rule.id,
                key: rule.key,
                value: elem.innerText
            };

        if (rule.typeid === 2)
            return {
                id: rule.id,
                key: rule.key,
                value: elem.innerHTML
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
        if (i === 0)
            elements.map(function (elem) {
                result.push([getResultObjByElem(rule, elem)]);
            });
        else
            result.map(function (groupArr, j) {
                var resObj = getResultObjByElem(rule, elements[j], groupArr[0]);
                groupArr.push(resObj);
            });
    });

    var returnObj = {result: result};
    if (group.islast === 1)
        returnObj.islast = 1;
    return JSON.stringify(returnObj);
}

app.databack(getDataFromDOMbyGroup(group));