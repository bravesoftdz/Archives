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

function getResultObject(element) {
    if (rule.ruletype === 'link')
        return {
            href: element.href,
        };
    if (rule.ruletype === 'record')
        return {
            text: element.outerText
        };
}

function getDataFromDOMbyRule(rule) {
    var element = document;
    var result = [];

    // получаем коллекцию - контейнер спускаясь по дереву DOM
    rule.nodes.map(function (node, i) {
        if (i >= rule.nodes.length - rule.offset)
            return false;

        // коллекция узлов по тегу
        var collection = getCollectionByTag(element, node.tag);

        // выбор узла 
        element = getElementByRuleNode(node, collection, true);
    });

    if (rule.offset === 0)
        return result.push(getResultObject(element));

    // перебираем коллекцию - контейнер
    var elements = [element];
    for (var i = rule.nodes.length - rule.offset; i < rule.nodes.length; i++) {
        var node = rule.nodes[i];
        var subElements = [];

        for (var j = 0; j < elements.length; j++) {
            collection = getCollectionByTag(elements[j], node.tag);

            for (var z = 0; z < collection.length; z++) {
                node.index = z + 1;
                element = getElementByRuleNode(node, collection, false);
                if (element !== undefined) {
                    if (i < rule.nodes.length - 1)
                        subElements.push(element);
                    else
                        result.push(getResultObject(element));
                }
            }
        }
        elements = subElements;
    }

    if (rule.ruletype === 'link')
        result = {level: rule.level, links: result};
    if (rule.ruletype === 'record')
        result = {key: rule.key, records: result};
    return JSON.stringify(result);
}

app.databack(getDataFromDOMbyRule(rule));