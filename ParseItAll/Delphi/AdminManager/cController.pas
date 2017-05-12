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
    procedure PerfomViewMessage(aMsg: string); override;
    procedure EventListener(aEventMsg: string); override;
  end;

implementation

uses
  vMain,
  vLogin,
  vJob,
  mLogin,
  mJobs;

procedure TController.EventListener(aEventMsg: string);
begin
  if aEventMsg = 'LoginOK' then
    begin
      ViewLogin.Close;
      ViewMain.statBar.Panels[0].Text := 'user: ' + FData.Items['user'];
      ViewMain.statBar.Panels[1].Text := 'ip: ' + FData.Items['ip'];
    end;

end;

procedure TController.PerfomViewMessage(aMsg: string);
begin
  if aMsg = 'ShowViewLogin' then CallView(TViewLogin, True);

  if aMsg = 'PerfomLoggining' then
    begin
      FData.Add('login', ViewLogin.edtLogin.Text);
      FData.Add('password', ViewLogin.edtPassword.Text);
      CallModel(TModelLogin);
    end;

  if aMsg = 'CreateJob' then
    begin
      CallModel(TModelJobs, 'CreateJob');

      //Job := TJob.Create;
      //FObjData.Add('Job', Job);
      //CallView(TViewJob);
      // создать объект
      // вызвать форму объекта
      // сохранить объект
    end;
end;

procedure TController.InitDB;
begin
  FConnectOnCreate := True;
  FConnectParams := Self.GetConnectParams('Settings\MySQL.ini');
  FDBEngineClass := TMySQLEngine;
end;

end.
