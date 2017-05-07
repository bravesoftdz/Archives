unit cController;

interface

uses
  API_MVC,
  API_MVC_DB,
  API_DB_MySQL;

type
  TController = class(TControllerDB)
  protected
    procedure InitDB; override;
    procedure PerfomViewMessage(aMsg: string; aViewSender: TViewAbstract); override;
    procedure EventListener(aEventMsg: string); override;
  end;

implementation

uses
  vLogin,
  mLogin;

procedure TController.EventListener(aEventMsg: string);
begin

end;

procedure TController.PerfomViewMessage(aMsg: string; aViewSender: TViewAbstract);
begin
  if aMsg = 'ShowViewLogin' then CallView(TViewLogin, True);

  if aMsg = 'PerfomLoggining' then
    begin
      FData.Add('login', TViewLogin(aViewSender).edtLogin.Text);
      FData.Add('password', TViewLogin(aViewSender).edtPassword.Text);
      CallModel(TModelLogin);
    end;
end;

procedure TController.InitDB;
begin
  FConnectOnCreate := True;
  FConnectParams := Self.GetConnectParams('Settings\MySQL.ini');
  FDBEngineClass := TMySQLEngine;
end;

end.
