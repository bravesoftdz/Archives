unit mRegister;

interface

uses
  API_MVC_DB,
  FMX.WebBrowser;

type
  TModelRegister = class(TModelDB)
  private
    FURL: string;
    procedure OnLoadEnd(ASender: TObject);
  public
    inBrowser: TWebBrowser;
    procedure Start; override;
  end;

const
  urlStartPage = 'https://evas2.urm.lt/ru/';
  urlVisitPage = 'https://evas2.urm.lt/ru/visit/';

implementation

procedure TModelRegister.OnLoadEnd(ASender: TObject);
begin
  if FURL = urlStartPage then
    begin
      inBrowser.EvaluateJavaScript('document.getElementsByTagName("a")[2].click();');
      FURL := urlVisitPage;
      Exit;
    end;

  if FURL = urlVisitPage then
    begin
      inBrowser.EvaluateJavaScript('document.getElementsByTagName("a")[2].click();');
      FURL := '';
      Exit;
    end;
end;

procedure TModelRegister.Start;
begin
  inBrowser.OnDidFinishLoad := OnLoadEnd;

  FURL := urlStartPage;
  inBrowser.Navigate(FURL);
end;

end.
