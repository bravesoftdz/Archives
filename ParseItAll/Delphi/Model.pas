unit Model;

interface

uses
   Vcl.Forms
  ,SHDocVw
  ,MSHTML
  ,API_DBases
  ,Entities
  ,DBService;

type
  THTMLElements = TArray<IHTMLElement>;

  TMatches = record
    isIDMatch: Boolean;
    isClassMatch: Boolean;
    isNameMatch: Boolean;
  end;

  TPIAModel = class
  private
    FMySQLEngine: TMySQLEngine;
    FDBService: TPIADBService;
    FWebBrowser: TWebBrowser;
    FForm: TForm;
    FJob: TJob;
    FCurrLink: TCurrLink;
    procedure WebBrowserInit;
    procedure ProcessNextLink;
    procedure GetDocumentByCurrLink;
    procedure WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure ProcessDOM(aDocument: IHTMLDocument2);
    function GetHTMLElementsByRuleNodes(aDocument: IHTMLDocument2; aNodes: TJobNodes; aContainerOffset: Integer; IsDebug: Boolean = False): THTMLElements;
    function GetElementOfCollectionByIndex(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
    function GetElementOfCollectionByID(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
    function GetElementOfCollectionByClass(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
    function GetElementOfCollectionByName(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
    function CheckNodeMatches(aNode: TJobNode; aElement: IHTMLElement): TMatches;
    function GetHTMLElementByRuleNode(aNode: TJobNode; iCollection: IHTMLElementCollection; aIsKeepSearch: Boolean = True): IHTMLElement;
    function CheckRegExps(aValue: string; aRegExps: TJobRegExps): Boolean;
  public
    constructor Create(aJobID: integer);
    procedure StartJob;
  end;

implementation

uses
   System.SysUtils
  ,Variants
  ,Vcl.Controls
  ,Vcl.Dialogs
  ,API_Files
  ,API_Parse;

function TPIAModel.CheckRegExps(aValue: string; aRegExps: TJobRegExps): Boolean;
var
  RegExp: TJobRegExp;
begin
  Result:=True;
  for RegExp in aRegExps do
    begin
      if TParseTools.ParseStrByRegEx(aValue, RegExp.RegExp)='' then
        begin
          Result:=False;
          Break;
        end;
    end;
end;

function TPIAModel.GetHTMLElementByRuleNode(aNode: TJobNode; iCollection: IHTMLElementCollection; aIsKeepSearch: Boolean = True): IHTMLElement;
var
  Matches: TMatches;
  MatchElement: IHTMLElement;
begin
  // элемент по индексу (по умолчанию)
  Result:=GetElementOfCollectionByIndex(aNode, iCollection, Matches);

  if aIsKeepSearch then
    begin
      // приоритет атрибута "ID"
      if (Result=nil) or (not Matches.isIDMatch) then
        MatchElement:=GetElementOfCollectionByID(aNode, iCollection, Matches);
      if MatchElement<>nil then Result:=MatchElement;

      // приоритет атрибута "class"
      if  (Result=nil) or (not Matches.isClassMatch and (aNode.TagID='')) then
        MatchElement:=GetElementOfCollectionByClass(aNode, iCollection, Matches);
      if MatchElement<>nil then Result:=MatchElement;

      // приоритет атрибута "name"
      if Result=nil then
        MatchElement:=GetElementOfCollectionByName(aNode, iCollection, Matches);
      if MatchElement<>nil then Result:=MatchElement;
    end;
end;

function TPIAModel.CheckNodeMatches(aNode: TJobNode; aElement: IHTMLElement): TMatches;
var
  ClassAttr, NameAttr: string;
begin
  Result.isIDMatch:=False;
  Result.isClassMatch:=False;
  Result.isNameMatch:=False;

  if aElement=nil then Exit;

  // совпадение ID
  if aElement.Id=aNode.TagID then Result.isIDMatch:=True;

  // совпадение class
  if aElement.getAttribute('className', 0)<>null then ClassAttr:=TParseTools.GetNormalizeString(aElement.getAttribute('className', 0))
  else ClassAttr:='';
  if ClassAttr=aNode.ClassName then Result.isClassMatch:=True;

  // совпадение name
  if aElement.getAttribute('name', 0)<>null then NameAttr:=aElement.getAttribute('name', 0)
  else NameAttr:='';
  if NameAttr=aNode.Name then Result.isNameMatch:=True;
end;

function TPIAModel.GetElementOfCollectionByName(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
begin

end;

function TPIAModel.GetElementOfCollectionByClass(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
var
  i: Integer;
  iElement: IHTMLElement;
  className: string;
begin
  Result:=nil;

  if aNode.ClassName<>'' then
    for i := 0 to iCollection.Length - 1 do
      begin
        iElement := iCollection.item(i, 0) as IHTMLElement;
        if iElement.getAttribute('className', 0)<>null then
          begin
            className:=TParseTools.GetNormalizeString(iElement.getAttribute('className', 0));
            if className = aNode.ClassName then
              begin
                Result := iElement;
                Break;
              end;
          end;
      end;

  aMatches:=CheckNodeMatches(aNode, Result);
end;

function TPIAModel.GetElementOfCollectionByID(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
var
  i: Integer;
  iElement: IHTMLElement;
begin
  Result:=nil;

  if aNode.TagID<>'' then
    for i := 0 to iCollection.Length - 1 do
      begin
        iElement := iCollection.item(i, 0) as IHTMLElement;
        if iElement.Id = aNode.TagID then
          begin
            Result := iElement;
            Break;
          end;
      end;

  aMatches:=CheckNodeMatches(aNode, Result);
end;

function TPIAModel.GetElementOfCollectionByIndex(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
var
  i: integer;
begin
  Result:=iCollection.Item(aNode.Index-1, 0) as IHTMLElement;
  aMatches:=CheckNodeMatches(aNode, Result);

  if Result=nil then
    begin
      TFilesEngine.SaveTextToFile('1.txt', '');
      for i :=0 to iCollection.length-1 do
      TFilesEngine.AppendToFile('1.txt', (iCollection.item(i, 0) as IHTMLElement).outerHTML);
    end;
end;

function TPIAModel.GetHTMLElementsByRuleNodes(aDocument: IHTMLDocument2; aNodes: TJobNodes; aContainerOffset: Integer; IsDebug: Boolean = False): THTMLElements;
var
  i, j, z: Integer;
  Node: TJobNode;
  iCollection, ContainerCollection: IHTMLElementCollection;
  iElement: IHTMLElement;
  Elements, SubElements: THTMLElements;

  function VTS(aV: Variant): string;
  begin
    if aV<>Null then Result:=aV
    else Result:='';
  end;
begin
  i:=0;
  Result:=[];
  iCollection:=aDocument.All as IHTMLElementCollection;
  IsDebug:=True;
  if IsDebug then
    begin
      TFilesEngine.SaveTextToFile('GetNodes.log', '');
      TFilesEngine.SaveTextToFile('All.log', FWebBrowser.LocationURL);
    end;

  // получаем коллекцию - конейнер спускаясь по дереву DOM
  for Node in aNodes do
    begin
      Inc(i);
      if i > Length(aNodes) - aContainerOffset then Break;

      // коллекция детей по тегу
      iCollection:=iCollection.Tags(Node.Tag) as IHTMLElementCollection;

      iElement:=GetHTMLElementByRuleNode(Node, iCollection);

      iCollection:=iElement.Children as IHTMLElementCollection;
    end;

  if aContainerOffset = 0 then Result := Result + [iElement]
  else
    begin
      // перебираем коллекцию - контейнер
      Elements:=[iElement];
      for i := Length(aNodes) - aContainerOffset to Length(aNodes) - 1 do
        begin
          Node:=aNodes[i];
          SubElements:=[];
          if IsDebug then
            begin
              TFilesEngine.AppendToFile('GetNodes.log', '');
              TFilesEngine.AppendToFile('GetNodes.log', 'RULE: ' + Node.Tag + ' ' + Node.TagID + ' ' + Node.ClassName);
            end;
          for j := 0 to Length(Elements)-1 do
            begin
              iCollection:=Elements[j].Children as IHTMLElementCollection;
              iCollection:=iCollection.Tags(Node.Tag) as IHTMLElementCollection;
              for z := 0 to iCollection.length-1 do
                begin
                  Node.Index := z + 1;
                  iElement:=GetHTMLElementByRuleNode(Node, iCollection, False);
                  if iElement<>nil then
                    if i<Length(aNodes) - 1 then
                      begin
                        SubElements:=SubElements+[iElement];
                        if IsDebug then TFilesEngine.AppendToFile('GetNodes.log', iElement.tagName +' ' + iElement.id+ ' ' +VTS(iElement.getAttribute('className', 0)));
                      end
                    else Result := Result + [iElement];
                end;
            end;
          Elements:=SubElements;
        end;
    end;
end;

procedure TPIAModel.ProcessDOM(aDocument: IHTMLDocument2);
var
  JobLinksRules: TJobLinksRules;
  JobLinkRule: TJobLinksRule;
  JobRecordsRules: TJobRecordsRules;
  JobRecordRule: TJobRecordsRule;
  HTMLElements: THTMLElements;
  iElement: IHTMLElement;
  Link: string;
  i: Integer;
begin
try  // links
  JobLinksRules:=FJob.GetLinksRulesByLevel(FCurrLink.Level);
  if Assigned(JobLinksRules) then
    for JobLinkRule in JobLinksRules do
      begin
        HTMLElements:=GetHTMLElementsByRuleNodes(aDocument, JobLinkRule.Nodes, JobLinkRule.ContainerOffset);

        for iElement in HTMLElements do
          if iElement.getAttribute('href', 0)<>null then
            begin
              Link:=iElement.getAttribute('href', 0);
              if CheckRegExps(Link, JobLinkRule.RegExps) then
                FDBService.AddLink(Link, JobLinkRule.Level);
            end;
      end;

  // records
  JobRecordsRules:=FJob.GetRecordsRulesByLevel(FCurrLink.Level);
  if Assigned(JobRecordsRules) then
    for JobRecordRule in JobRecordsRules do
      begin
        HTMLElements:=GetHTMLElementsByRuleNodes(aDocument, JobRecordRule.Nodes, JobRecordRule.ContainerOffset);

        i:=0;
        for iElement in HTMLElements do
          begin
            inc(i);
            FDBService.AddRecord(FCurrLink.Id, i, JobRecordRule.Key, iElement.outerText);
          end;
      end;

  ProcessNextLink;
except
  Abort;
end;
end;

procedure TPIAModel.WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
  if URL=FCurrLink.Link then
    ProcessDOM(FWebBrowser.Document as IHtmlDocument2);
end;

procedure TPIAModel.WebBrowserInit;
begin
  FForm:=TForm.Create(nil);
  FWebBrowser:=TWebBrowser.Create(FForm);
  TWinControl(FWebBrowser).Parent:=FForm;
  FWebBrowser.OnDocumentComplete:=WebBrowserDocumentComplete;

  FForm.Height:=600;
  FForm.Width:=800;
  FWebBrowser.Align := alClient;
  FForm.Show;
end;

procedure TPIAModel.GetDocumentByCurrLink;
begin
  FWebBrowser.Navigate(FCurrLink.Link);
end;

procedure TPIAModel.ProcessNextLink;
begin
  FDBService.SetLinkHandle(FCurrLink.Id, 2);
  FCurrLink:=FDBService.GetCurrLink;
  FDBService.SetLinkHandle(FCurrLink.Id, 1);

  GetDocumentByCurrLink;
end;

constructor TPIAModel.Create(aJobID: Integer);
begin
  inherited Create;

  // подключаем БД
  FMySQLEngine:=TMySQLEngine.Create;
  FMySQLEngine.OpenConnection('MySQL.ini');

  // сущность задания
  FJob:=TJob.Create(aJobID, FMySQLEngine);

  // сервисы работы с БД
  FDBService:=TPIADBService.Create(aJobID, FMySQLEngine);

  // инициализация веббраузера
  WebBrowserInit;

  // инициализация первого запуска парсера
  if FDBService.CheckFirstRun then FDBService.AddLink(FJob.ZeroLink, 1);
end;

procedure TPIAModel.StartJob;
begin
  ProcessNextLink;
end;

end.
