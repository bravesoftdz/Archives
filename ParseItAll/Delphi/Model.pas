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
    function GetHTMLElementsByRuleNodes(aDocument: IHTMLDocument2; aNodes: TJobNodes; aContainerOffset: Integer): THTMLElements;
    function GetElementOfCollectionByIndex(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
    function GetElementOfCollectionByID(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
    function GetElementOfCollectionByClass(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
    function GetElementOfCollectionByName(aNode: TJobNode; iCollection: IHTMLElementCollection; out aMatches: TMatches): IHTMLElement;
    function CheckNodeMatches(aNode: TJobNode; aElement: IHTMLElement): TMatches;
    function GetHTMLElementByRuleNode(aNode: TJobNode; iCollection: IHTMLElementCollection): IHTMLElement;
  public
    constructor Create(aJobID: integer);
    procedure StartJob;
  end;

implementation

uses
   Variants
  ,Vcl.Controls
  ,Vcl.Dialogs
  ,API_Files;

function TPIAModel.GetHTMLElementByRuleNode(aNode: TJobNode; iCollection: IHTMLElementCollection): IHTMLElement;
var
  Matches: TMatches;
begin
  Result:=nil;

  // элемент по индексу
  Result:=GetElementOfCollectionByIndex(aNode, iCollection, Matches);

  // приоритет атрибута "ID"
  if (Result=nil) or (not Matches.isIDMatch) then
    Result:=GetElementOfCollectionByID(aNode, iCollection, Matches);

  // приоритет атрибута "class"
  if  Result=nil then
    Result:=GetElementOfCollectionByClass(aNode, iCollection, Matches);

  // приоритет атрибута "name"
  if Result=nil then
    Result:=GetElementOfCollectionByName(aNode, iCollection, Matches);
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
  if aElement.getAttribute('className', 0)<>null then ClassAttr:=aElement.getAttribute('className', 0)
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
begin

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
begin
  Result:=iCollection.Item(aNode.Index-1, 0) as IHTMLElement;
  aMatches:=CheckNodeMatches(aNode, Result);
end;

function TPIAModel.GetHTMLElementsByRuleNodes(aDocument: IHTMLDocument2; aNodes: TJobNodes; aContainerOffset: Integer): THTMLElements;
var
  i, j: Integer;
  Node: TJobNode;
  iCollection, ContainerCollection: IHTMLElementCollection;
  iElement: IHTMLElement;
begin
  i:=0;
  Result:=[];
  iCollection:=aDocument.All as IHTMLElementCollection;

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
      ContainerCollection := iCollection;
      // перебираем коллекцию - контейнер
      for i := 0 to ContainerCollection.Length - 1 do
        begin
          iCollection := ContainerCollection;

          for j := Length(aNodes) - aContainerOffset to Length(aNodes) - 1 do
            begin
              Node:=aNodes[j];
              if j = Length(aNodes) - aContainerOffset then Node.Index := i + 1;

              iElement:=GetHTMLElementByRuleNode(Node, iCollection);

              iCollection:=iElement.Children as IHTMLElementCollection;

              if j = Length(aNodes) - 1 then Result := Result + [iElement];
            end;
        end;
    end;
end;

procedure TPIAModel.ProcessDOM(aDocument: IHTMLDocument2);
var
  JobLinksRules: TJobLinksRules;
  JobRule: TJobRule;
  HTMLElements: THTMLElements;
begin
  JobLinksRules:=FJob.GetLinksRulesByLevel(FCurrLink.Level);
  for JobRule in JobLinksRules do
    begin
      HTMLElements:=GetHTMLElementsByRuleNodes(aDocument, JobRule.Nodes, JobRule.ContainerOffset);
    end;
end;

procedure TPIAModel.WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
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
