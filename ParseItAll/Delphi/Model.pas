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
  public
    constructor Create(aJobID: integer);
    procedure StartJob;
  end;

implementation

uses
  Vcl.Controls;

procedure TPIAModel.ProcessDOM(aDocument: IHTMLDocument2);
var
  JobRules: TJobRules;
  JobRule: TJobRule;
begin
  JobRules:=FJob.GetRulesByLevel(FCurrLink.Level);
  for JobRule in JobRules do
    begin

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
