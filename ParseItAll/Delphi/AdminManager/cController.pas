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
  System.SysUtils,
  vMain,
  vLogin,
  vJob,
  vRules,
  mLogin,
  mJobs,
  mRules,
  eEntities;

procedure TController.EventListener(aEventMsg: string);
var
  Job: TJob;
  JobList: TJobList;
  i: Integer;
begin
  if aEventMsg = 'LoginDone' then
    begin
      ViewLogin.Close;
      ViewMain.statBar.Panels[0].Text := 'user: ' + FData.Items['user'];
      ViewMain.statBar.Panels[1].Text := 'ip: ' + FData.Items['ip'];
      CallModel(TModelJobs, 'GetJobList');
    end;

  if aEventMsg = 'GetJobDone' then
    begin
      CallView(TViewJob);
      Job := FObjData.Items['Job'] as TJob;
      ViewJob.CRUDPanel.BuildCRUD(Job);
      ViewJob.SetBrowserLinks;
    end;

  if aEventMsg = 'GetJobListDone' then
    begin
      JobList := FObjData.Items['JobList'] as TJobList;
      try
        i := 0;
        ViewMain.stgdJobs.RowCount := 2;
        for Job in JobList do
          begin
            if i > 0 then ViewMain.stgdJobs.RowCount := ViewMain.stgdJobs.RowCount + 1;
            ViewMain.stgdJobs.Cells[0, ViewMain.stgdJobs.RowCount - 1] := IntToStr(Job.ID);
            ViewMain.stgdJobs.Cells[1, ViewMain.stgdJobs.RowCount - 1] := IntToStr(Job.UserID);
            ViewMain.stgdJobs.Cells[2, ViewMain.stgdJobs.RowCount - 1] := Job.Caption;
            Inc(i);
          end;
      finally
        JobList.Free;
      end;
    end;
end;

procedure TController.PerfomViewMessage(aMsg: string);
begin
  if aMsg = 'ShowViewLogin' then CallView(TViewLogin);
  if aMsg = 'PerfomLoggining' then
    begin
      FData.Add('login', ViewLogin.edtLogin.Text);
      FData.Add('password', ViewLogin.edtPassword.Text);
      CallModel(TModelLogin);
    end;

  if aMsg = 'CreateJob' then
    begin
      FData.AddOrSetValue('JobID', 0);
      CallModel(TModelJobs, 'GetJob');
    end;
  if aMsg = 'EditJob' then
    begin
      FData.AddOrSetValue('JobID', ViewMain.SelectedJobID);
      CallModel(TModelJobs, 'GetJob');
    end;
  if aMsg = 'StoreJob' then
    begin
      ViewJob.Close;
      ViewJob.CRUDPanel.UpdateEntity;
      ViewJob.CRUDPanel.Entity.SaveEntity;
      CallModel(TModelJobs, 'GetJobList');
    end;

  if aMsg = 'EditRules' then
    begin
      FData.AddOrSetValue('JobID', ViewMain.SelectedJobID);
      CallModel(TModelRules, 'GetLevels');
      //CallView(TViewRules);
    end;
end;

procedure TController.InitDB;
begin
  FConnectOnCreate := True;
  FConnectParams := Self.GetConnectParams('Settings\MySQL.ini');
  FDBEngineClass := TMySQLEngine;
end;

end.
