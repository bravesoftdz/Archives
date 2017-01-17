unit Model;

interface

uses
   System.SysUtils
  ,System.JSON
  ,Vcl.Forms
  ,cefvcl
  ,CefLib
  ,API_DBases
  ,Entities
  ,DBService;

type
  ENoElementFind = class(Exception)
  private
    FJobNodeID: Integer;
  public
    constructor Create(aJobNodeID: integer);
    property JobNodeID: Integer read FJobNodeID;
  end;

  TJSExtension = class
    class procedure databack(const data: string);
  end;

  TCustomRenderProcessHandler = class(TCefRenderProcessHandlerOwn)
  protected
    procedure OnWebKitInitialized; override;
  end;

  TPIAModel = class
  private
    FMySQLEngine: TMySQLEngine;
    FDBService: TPIADBService;
    FChromium: TChromium;
    FForm: TForm;
    FJob: TJob;
    FCurrLink: TCurrLink;
    FjsScript: string;
    procedure ChromiumInit;
    procedure ProcessNextLink;
    procedure ChromiumLoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
    procedure ProcessRules(aFrame: ICefFrame);
    procedure crmProcessMessageReceived(Sender: TObject;
                const browser: ICefBrowser; sourceProcess: TCefProcessId;
                const message: ICefProcessMessage; out Result: Boolean);
    procedure InsertReceivedData(aData: string);
    procedure OnNoElementFind(E: ENoElementFind; aCriticalType: Integer);
    function GetInjectJSForRulesGroup(aJobRulesGroup: TJobRulesGroup): string;
    function EncodeNodesToJSON(aNodes: TJobNodes): TJSONArray;
    function EncodeRegExpsToJSON(aRegExps: TJobRegExps): TJSONArray;
  public
    constructor Create(aJobID: integer);
    procedure StartJob;
  end;

implementation

uses
   Vcl.Controls
  ,API_Parse
  ,API_Files;

function TPIAModel.EncodeRegExpsToJSON(aRegExps: TJobRegExps): TJSONArray;
var
  RegExp: TJobRegExp;
  jsnRegExp: TJSONObject;
begin
  Result:=TJSONArray.Create;
  for RegExp in aRegExps do
    begin
      jsnRegExp:=TJSONObject.Create;
      jsnRegExp.AddPair('regexp', RegExp.RegExp);
      jsnRegExp.AddPair('type', TJSONNumber.Create(RegExp.TypeRefID));

      Result.AddElement(jsnRegExp);
    end;
end;

function TPIAModel.EncodeNodesToJSON(aNodes: TJobNodes): TJSONArray;
var
  jsnNode: TJSONObject;
  Node: TJobNode;
begin
  Result:=TJSONArray.Create;
  for Node in aNodes do
    begin
      jsnNode:=TJSONObject.Create;
      jsnNode.AddPair('ID', TJSONNumber.Create(Node.ID));
      jsnNode.AddPair('tag', Node.Tag);
      jsnNode.AddPair('index', TJSONNumber.Create(Node.Index));
      jsnNode.AddPair('tagID', Node.TagID);
      jsnNode.AddPair('className', Node.ClassName);
      jsnNode.AddPair('name', Node.Name);
      Result.AddElement(jsnNode);
    end;
end;

procedure TPIAModel.InsertReceivedData(aData: string);
var
  jsnData: TJSONArray;
  jsnObjArray: TJSONArray;
  jsnGroup, jsnValue: TJSONValue;
  jsnObj: TJSONObject;

  Link, Key, Text: string;
  Level, i: Integer;
begin
  jsnData:=TJSONObject.ParseJSONValue(aData) as TJSONArray;
  i:=0;
  for jsnGroup in jsnData do
    begin
      Inc(i);
      jsnObjArray:=jsnGroup as TJSONArray;
      for jsnValue in jsnObjArray do
        begin
          jsnObj:=jsnValue as TJSONObject;

          if jsnObj.GetValue('nomatchruleid')<>nil then Continue;

          if jsnObj.GetValue('href')<>nil then
            begin
              Level:=(jsnObj.GetValue('level') as TJSONNumber).AsInt;
              Link:=jsnObj.GetValue('href').Value;
              FDBService.AddLink(Link, Level);
            end;

          if jsnObj.GetValue('key')<>nil then
            begin
              Key:=jsnObj.GetValue('key').Value;
              Text:=jsnObj.GetValue('value').Value;
              FDBService.AddRecord(FCurrLink.Id, i, Key, Text);
            end;
        end;
    end;
end;

procedure TPIAModel.crmProcessMessageReceived(Sender: TObject;
  const browser: ICefBrowser; sourceProcess: TCefProcessId;
  const message: ICefProcessMessage; out Result: Boolean);
begin
  if message.Name = 'databack' then
      InsertReceivedData(message.ArgumentList.GetString(0));
end;

function TPIAModel.GetInjectJSForRulesGroup(aJobRulesGroup: TJobRulesGroup): string;
var
  JobLinksRule: TJobLinksRule;
  JobRecordsRule: TJobRecordsRule;
  jsnRuleGroup: TJSONObject;
  jsnRules: TJSONArray;
  jsnRule: TJSONObject;
begin
  jsnRuleGroup:=TJSONObject.Create;
  jsnRules:=TJSONArray.Create;
  try
    jsnRuleGroup.AddPair('nodes', EncodeNodesToJSON(aJobRulesGroup.GetContainerNodes));

    for JobLinksRule in aJobRulesGroup.JobLinksRules  do
      begin
        jsnRule:=TJSONObject.Create;
        jsnRule.AddPair('id', TJSONNumber.Create(JobLinksRule.ID));
        jsnRule.AddPair('level', TJSONNumber.Create(JobLinksRule.Level));
        jsnRule.AddPair('nodes', EncodeNodesToJSON(JobLinksRule.GetContainerInsideNodes));
        jsnRule.AddPair('regexps', EncodeRegExpsToJSON(JobLinksRule.RegExps));
        jsnRules.AddElement(jsnRule);
      end;

    for JobRecordsRule in aJobRulesGroup.JobRecordsRules do
      begin
        jsnRule:=TJSONObject.Create;
        jsnRule.AddPair('id', TJSONNumber.Create(JobRecordsRule.ID));
        jsnRule.AddPair('key', JobRecordsRule.Key);
        jsnRule.AddPair('nodes', EncodeNodesToJSON(JobRecordsRule.GetContainerInsideNodes));
        jsnRule.AddPair('regexps', EncodeRegExpsToJSON(JobRecordsRule.RegExps));
        jsnRules.AddElement(jsnRule)
      end;

    jsnRuleGroup.AddPair('rules', jsnRules);

    Result:='var group =';
    Result:=Result+jsnRuleGroup.ToJSON;
    Result:=Result+';'#10#13;
    Result:=Result+FjsScript;
  finally
    TFilesEngine.SaveTextToFile('1.txt', jsnRuleGroup.ToJSON);
    jsnRuleGroup.Free;
  end;
end;

procedure TPIAModel.ProcessRules(aFrame: ICefFrame);
var
  JobRulesGroups: TJobRulesGroups;
  JobRulesGroup: TJobRulesGroup;
  InjectJS: string;
begin
  JobRulesGroups:=FJob.GetRulesGroupsByLevel(FCurrLink.Level);
  for JobRulesGroup in JobRulesGroups do
    begin
      InjectJS:=GetInjectJSForRulesGroup(JobRulesGroup);
      FChromium.Browser.MainFrame.ExecuteJavaScript(InjectJS, 'about:blank', 0);
    end;
end;

procedure TPIAModel.ChromiumLoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
begin
  if FChromium.Browser<>nil then
    if frame.Url = FCurrLink.Link then ProcessRules(frame);
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

procedure TPIAModel.ChromiumInit;
begin
  FForm:=TForm.Create(nil);
  FChromium:=TChromium.Create(nil);
  FChromium.Parent:=FForm;
  FChromium.OnLoadEnd:=ChromiumLoadEnd;
  FChromium.OnProcessMessageReceived:=crmProcessMessageReceived;

  FForm.Height:=600;
  FForm.Width:=800;
  FChromium.Align:=alClient;
  FForm.Show;
end;

procedure TPIAModel.ProcessNextLink;
begin
  FDBService.SetLinkHandle(FCurrLink.Id, 2);
  FCurrLink:=FDBService.GetCurrLink;
  FDBService.SetLinkHandle(FCurrLink.Id, 1);

  FChromium.Load(FCurrLink.Link);
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

  // JS скрипт для парсинга DOM
  FjsScript:=TFilesEngine.GetTextFromFile('D:\Git\Projects-Dev\ParseItAll\Web\js\DOMParser.js');
end;

procedure TPIAModel.StartJob;
begin
  ProcessNextLink;
end;

{ TCustomRenderProcessHandler }
procedure TCustomRenderProcessHandler.OnWebKitInitialized;
begin
{$IFDEF DELPHI14_UP}
  TCefRTTIExtension.Register('app', TJSExtension);
{$ENDIF}
end;

{ TTestExtension }
class procedure TJSExtension.databack(const data: string);
var
  msg: ICefProcessMessage;
begin
  msg := TCefProcessMessageRef.New('databack');
  msg.ArgumentList.SetString(0, data);
  TCefv8ContextRef.Current.Browser.SendProcessMessage(PID_BROWSER, msg);
end;

end.
