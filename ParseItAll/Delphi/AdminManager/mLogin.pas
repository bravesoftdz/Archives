unit mLogin;

interface

uses
  API_MVC_DB;

type
  TModelLogin = class(TModelDB)
  private
    procedure LoginOK;
    procedure LoginFail;
  public
    procedure Execute; override;
  end;

implementation

uses
  FireDAC.Comp.Client;

procedure TModelLogin.LoginOK;
begin
end;

procedure TModelLogin.LoginFail;
begin

end;

procedure TModelLogin.Execute;
var
  dsQuery: TFDQuery;
begin
  dsQuery:=TFDQuery.Create(nil);
  try
    dsQuery.SQL.Text := 'select * from users where login = :login';
    dsQuery.ParamByName('login').AsString := FData.Items['login'];
    FDBEngine.OpenQuery(dsQuery);

    if dsQuery.FieldByName('password').AsString = FData.Items['password'] then
      CreateEvent('LoginOK')
    else
      CreateEvent('LoginFail');
  finally
    dsQuery.Free;
  end;
end;

end.
