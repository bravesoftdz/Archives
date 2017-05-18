unit cController;

interface

uses
  API_MVC,
  API_MVC_DB,
  API_DB_MySQL;

type
  TController = class(TControllerDB)
  private
    procedure GetLevelsDone;
    procedure CreateGroup;
  protected
    procedure InitDB; override;
    procedure PerfomViewMessage(aMsg: string); override;
    procedure EventListener(aEventMsg: string); override;
  published
    procedure EditJobRules;
    procedure StoreJobRules;

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

procedure TController.EditJobRules;
var
  Job: TJob;
begin
  Job := TJob.Create(FDBEngine, ViewMain.SelectedJobID);
  try
    //FData.AddOrSetValue('JobID', Job.ID);
    //FData.AddOrSetValue('ZeroLink', Job.ZeroLink);
    //CallModel(TModelRules, 'GetLevels');
    FObjData.AddOrSetValue('Job', Job);
  finally
    Job.Free;
  end;
end;

procedure TController.StoreJobRules;
begin

end;

procedure TController.CreateGroup;
var
  LevelList: TJobLevelList;
  Group: TJobGroup;
begin
  LevelList := FObjData.Items['JobLevelList'] as TJobLevelList;

  Group := TJobGroup.Create(FDBEngine, 0);
  Group.Notes := 'New Group';

  LevelList.Items[0].Groups.Add(Group);
  ViewRules.SetControlTree(LevelList.Items[0].Groups);
end;

procedure TController.GetLevelsDone;
var
  LevelList: TJobLevelList;
  Level: TJobLevel;
begin
  LevelList := FObjData.Items['JobLevelList'] as TJobLevelList;

  if LevelList.Count = 0 then
    begin
      Level := TJobLevel.Create(FDBEngine, 0);
      Level.Level := 1;
      Level.BaseLink := FData.Items['ZeroLink'];
      LevelList.Add(Level);
    end;

  CallView(TViewRules);
  ViewRules.SetLevels(LevelList);
end;

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

  if aEventMsg = 'GetLevelsDone' then GetLevelsDone;
end;

procedure TController.PerfomViewMessage(aMsg: string);
begin
  if aMsg = 'CreateGroup' then CreateGroup;

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
end;

procedure TController.InitDB;
begin
  FConnectOnCreate := True;
  FConnectParams := Self.GetConnectParams('Settings\MySQL.ini');
  FDBEngineClass := TMySQLEngine;
end;

end.
