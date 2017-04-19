unit Controller;

interface

uses
   IdHTTP
  ,IdSSLOpenSSL
  ,System.JSON
  ,System.Classes
  ,FMX.Forms;

type
  THandlerProc = procedure(aJSNRequest: TJSONObject) of object;

  TMControllerAbstract = class abstract
  private
    procedure HTTPInit;
  protected
    FHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FDomen: string;
    FMainForm: TForm;
    function GetRequest(aURL: string; aPostData: TStringList = nil): string;
    procedure ProcessRequest(aURL: string; aHandlerProc: THandlerProc; aPostData: TStringList = nil);
    procedure ControllerInit; virtual;
  public
    procedure ProcessViewMessage(aMessage: string); virtual; abstract;
    constructor Create(aMainForm: TForm);
    destructor Destroy; override;
  end;

  TMControllerAbstractClass = class of TMControllerAbstract;

implementation

uses
   System.SysUtils;

procedure TMControllerAbstract.ControllerInit;
begin
end;

procedure TMControllerAbstract.ProcessRequest(aURL: string; aHandlerProc: THandlerProc; aPostData: TStringList = nil);
var
  Request: string;
  jsnRequest: TJSONObject;
begin
  if not FDomen.IsEmpty then aURL:=FDomen+aURL;

  Request:=GetRequest(aURL, aPostData);
  jsnRequest:=TJSONObject.ParseJSONValue(Request) as TJSONObject;
  if jsnRequest<>nil then
    try
      if Assigned(aHandlerProc) then aHandlerProc(jsnRequest);
    finally
      jsnRequest.Free;
    end;
end;

constructor TMControllerAbstract.Create(aMainForm: TForm);
begin
  FMainForm:=aMainForm;
  ControllerInit;
  HTTPInit;
end;

procedure TMControllerAbstract.HTTPInit;
begin
  if Assigned(FHTTP) then FreeAndNil(FHTTP);
  if Assigned(FIdSSLIOHandlerSocketOpenSSL) then FreeAndNil(FIdSSLIOHandlerSocketOpenSSL);

  FHTTP := TIdHTTP.Create;
  FHTTP.HandleRedirects:=True;
  FHTTP.Request.UserAgent:='Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.62 Safari/537.36';

  FIdSSLIOHandlerSocketOpenSSL:=TIdSSLIOHandlerSocketOpenSSL.Create;
  FHTTP.IOHandler:=FIdSSLIOHandlerSocketOpenSSL;
end;

destructor TMControllerAbstract.Destroy;
begin
  FHTTP.Free;
  FIdSSLIOHandlerSocketOpenSSL.Free;
  inherited;
end;

function TMControllerAbstract.GetRequest(aURL: string; aPostData: TStringList = nil): string;
var
  i: integer;
begin
  i:=0;
  while i<11 do
    begin
      try
        Inc(i);
        if aPostData<>nil then Result := FHTTP.Post(aURL, aPostData)
        else  Result := FHTTP.Get(aURL);
        Exit(Result);
      except
        On E : Exception do
          begin
            HTTPInit;
          end;
      end;
    end;
  Result:='HTTP_READ_ERROR';
end;

end.
