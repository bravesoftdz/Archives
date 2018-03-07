unit mRegister;

interface

uses
  API_MVC_DB,
  FMX.Types,
  FMX.WebBrowser;

type
  TModelRegister = class(TModelDB)
  private
    FTimer: TTimer;
    FURL: string;
    function GetJSCode(const aFile: string): string;
    procedure OnLoadEnd(ASender: TObject);
    procedure OnShouldStartLoadWithRequest(ASender: TObject; const URL: string);
    procedure OnTimer(ASender: TObject);
  public
    inBrowser: TWebBrowser;
    inReadyListenerFile: string;
    procedure Start; override;
  end;

const
  urlStartPage = 'https://evas2.urm.lt/ru/';
  urlVisitPage = 'https://evas2.urm.lt/ru/visit/';

implementation

uses
  API_Files;

procedure TModelRegister.OnShouldStartLoadWithRequest(ASender: TObject; const URL: string);
begin

end;

procedure TModelRegister.OnTimer(ASender: TObject);
begin
  if FURL = urlStartPage then
    begin
      inBrowser.EvaluateJavaScript(GetJSCode(inReadyListenerFile));
    end;
end;

function TModelRegister.GetJSCode(const aFile: string): string;
begin
  Result := TFilesEngine.GetTextFromFile(aFile);
end;

procedure TModelRegister.OnLoadEnd(ASender: TObject);
begin
  FTimer.Enabled := True;
end;

procedure TModelRegister.Start;
begin
  inBrowser.OnDidFinishLoad := OnLoadEnd;
  inBrowser.OnShouldStartLoadWithRequest := OnShouldStartLoadWithRequest;

  FTimer := TTimer.Create(nil);
  FTimer.Interval := 1000;
  FTimer.Enabled := False;
  FTimer.OnTimer := OnTimer;

  FURL := urlStartPage;
  inBrowser.Navigate(FURL);
end;

end.
