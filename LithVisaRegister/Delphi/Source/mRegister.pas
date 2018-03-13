unit mRegister;

interface

uses
  API_MVC_DB,
  FMX.WebBrowser;

type
  TModelLoadPage = class(TModelDB)
  private
    procedure OnLoadEnd(ASender: TObject);
  public
    inBrowser: TWebBrowser;
    procedure Start; override;
  end;

  TModelFillForm = class(TModelDB)
  private
    function GetJSCode(const aFile: string): string;
  public
    inBrowser: TWebBrowser;
    inJSFile: string;
    procedure Start; override;
  end;

const
  cStartPageURL = 'https://evas2.urm.lt/ru/';

implementation

uses
  API_Files,
  System.SysUtils;

procedure TModelFillForm.Start;
var
  JSCode: string;
begin
  JSCode := GetJSCode(inJSFile);

  inBrowser.EvaluateJavaScript(JSCode);
end;

function TModelFillForm.GetJSCode(const aFile: string): string;
begin
  Result := TFilesEngine.GetTextFromFile(aFile);
end;

procedure TModelLoadPage.OnLoadEnd(ASender: TObject);
begin
  if inBrowser.URL.Contains('visit/rct77') then
    begin
      inBrowser.OnDidFinishLoad := nil;
      SendMessage(EndMessage);
    end;
end;

procedure TModelLoadPage.Start;
begin
  inBrowser.OnDidFinishLoad := OnLoadEnd;
  inBrowser.Navigate(cStartPageURL);
end;

end.
