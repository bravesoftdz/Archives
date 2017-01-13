unit Model;

interface

uses
   System.SysUtils
  ,Vcl.Forms
  ,SHDocVw
  ,MSHTML
  ,cefvcl
  ,CefLib
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

  ENoElementFind = class(Exception)
  private
    FJobNodeID: Integer;
  public
    constructor Create(aJobNodeID: integer);
    property JobNodeID: Integer read FJobNodeID;
  end;

  TPIAModel = class
  private
    FMySQLEngine: TMySQLEngine;
    FDBService: TPIADBService;
    FWebBrowser: TWebBrowser;
    FChromium: TChromium;
    FForm: TForm;
    FJob: TJob;
    FCurrLink: TCurrLink;
    procedure WebBrowserInit;
    procedure ChromiumInit;
    procedure ProcessNextLink;
    procedure GetDocumentByCurrLink;
    procedure WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure ChromiumLoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
    procedure ProcessDOM(aDocument: IHTMLDocument2); overload;
    procedure ProcessDOM(aDocument: ICefDomDocument); overload;
    procedure OnNoElementFind(E: ENoElementFind; aCriticalType: Integer);
    function GetHTMLElementsByRuleNodes(aDocument: IHTMLDocument2; aNodes: TJobNodes; aContainerOffset: Integer): THTMLElements;
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
   Variants
  ,Vcl.Controls
  ,API_Parse;

procedure TPIAModel.ProcessDOM(aDocument: ICefDomDocument);
begin

end;

procedure TPIAModel.ChromiumLoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
begin
  if Assigned(frame) and frame.IsMain then browser.MainFrame.VisitDomProc(
    procedure(const document: ICefDomDocument)
      begin
        ProcessDOM(document);
      end
  );
end;

procedure TPIAModel.OnNoElementFind(E: ENoElementFind; aCriticalType: Integer);
begin
  case aCriticalType of
    1: begin
         FDBService.AddJobMessage(FCurrLink.ID, E.JobNodeID);
         raise Exception.Create(E.Message+' Critical Error. Thread Stopped.');
       end;
    2:  FDBService.AddJobMessage(FCurrLink.ID, E.JobNodeID);
  end;
end;

constructor ENoElementFind.Create(aJobNodeID: integer);
begin
  inherited Create('No HTML Elements Find!');
  FJobNodeID:=aJobNodeID;
end;

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
end;

function TPIAModel.GetHTMLElementsByRuleNodes(aDocument: IHTMLDocument2; aNodes: TJobNodes; aContainerOffset: Integer): THTMLElements;
var
  i, j, z: Integer;
  Node: TJobNode;
  iCollection, ContainerCollection: IHTMLElementCollection;
  iElement: IHTMLElement;
  Elements, SubElements: THTMLElements;
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

      // не найден элемент - генерируем исключение
      if iElement=nil then raise ENoElementFind.Create(Node.ID);

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
                      SubElements:=SubElements+[iElement]
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
  // links
  JobLinksRules:=FJob.GetLinksRulesByLevel(FCurrLink.Level);
  if Assigned(JobLinksRules) then
    for JobLinkRule in JobLinksRules do
      begin
        try
          HTMLElements:=GetHTMLElementsByRuleNodes(aDocument, JobLinkRule.Nodes, JobLinkRule.ContainerOffset);
        except
          On E : ENoElementFind do OnNoElementFind(E, JobLinkRule.CriticalType);
        end;

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
        try
          HTMLElements:=GetHTMLElementsByRuleNodes(aDocument, JobRecordRule.Nodes, JobRecordRule.ContainerOffset);
        except
          On E : ENoElementFind do OnNoElementFind(E, JobRecordRule.CriticalType);
        end;

        i:=0;
        for iElement in HTMLElements do
          begin
            inc(i);
            FDBService.AddRecord(FCurrLink.Id, i, JobRecordRule.Key, iElement.outerText);
          end;
      end;

  ProcessNextLink;
end;

procedure TPIAModel.WebBrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
var
  iDocument: IHtmlDocument2;
begin
  try
    if URL=FCurrLink.Link then
      begin
        if Assigned(FWebBrowser.ControlInterface.Document) then
          FWebBrowser.ControlInterface.Document.QueryInterface(IHtmlDocument2, iDocument);
        ProcessDOM(iDocument);
      end;
  finally
    //iDocument.Close;
    //iDocument._Release;
  end;
end;

procedure TPIAModel.ChromiumInit;
begin
  FForm:=TForm.Create(nil);
  FChromium:=TChromium.Create(nil);
  FChromium.Parent:=FForm;
  FChromium.OnLoadEnd:=ChromiumLoadEnd;

  FForm.Height:=600;
  FForm.Width:=800;
  FChromium.Align:=alClient;
  FForm.Show;
end;

procedure TPIAModel.WebBrowserInit;
begin
  FForm:=TForm.Create(nil);
  FWebBrowser:=TWebBrowser.Create(FForm);
  TWinControl(FWebBrowser).Parent:=FForm;
  FWebBrowser.Silent:=True;
  FWebBrowser.OnDocumentComplete:=WebBrowserDocumentComplete;

  FForm.Height:=600;
  FForm.Width:=800;
  FWebBrowser.Align := alClient;
  FForm.Show;
end;

procedure TPIAModel.GetDocumentByCurrLink;
begin
  //FWebBrowser.Navigate2(FCurrLink.Link);
  FChromium.Load(FCurrLink.Link);
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
  //WebBrowserInit;
  ChromiumInit;

  // инициализация первого запуска парсера
  if FDBService.CheckFirstRun then FDBService.AddLink(FJob.ZeroLink, 1);
end;

procedure TPIAModel.StartJob;
begin
  ProcessNextLink;
end;

end.
