unit cController;

interface

uses
  API_MVC,
  API_MVC_DB,
  API_DB_MySQL;

type
  {$M+}

  TController = class(TControllerDB)
  protected
    procedure InitDB; override;
    procedure PerfomViewMessage(aMsg: string); override;
    procedure EventListener(aEventMsg: string); override;
  published
    procedure GetJobList;

    procedure EditJobRules;
    procedure StoreJobRules;

    procedure TreeNodeSelected;

    procedure CreateGroup;
    procedure DeleteGroup;

    procedure CreateLink;
    procedure DeleteLink;

    procedure CreateRecord;
    procedure DeleteRecord;
  end;

  // FObjData Item Keys
  // Job
  // LevelList
  // Level

implementation

uses
  System.SysUtils,
  API_ORM,
  API_MVC_Bind,
  vMain,
  vLogin,
  vJob,
  vRules,
  mLogin,
  mJobs,
  mRules,
  eEntities;

procedure TController.CreateRecord;
var
  Level: TJobLevel;
  Group: TJobGroup;
  JobRecord: TJobRecord;
begin
  Level := FObjData.Items['Level'] as TJobLevel;
  Group := Level.Groups[ViewRules.tvTree.Selected.Index];

  JobRecord := TJobRecord.Create(FDBEngine);
  Group.Records.Add(JobRecord);

  ViewRules.SetControlTree(Level.Groups);
end;

procedure TController.DeleteRecord;
var
  Level: TJobLevel;
  Group: TJobGroup;
begin
  Level := FObjData.Items['Level'] as TJobLevel;
  Group := Level.Groups[ViewRules.tvTree.Selected.Parent.Index];

  Group.Records.DeleteByIndex(ViewRules.tvTree.Selected.Index - Group.Links.Count);
  ViewRules.SetControlTree(Level.Groups);
  ViewRules.pnlEntityFields.ClearControls;
end;

procedure TController.DeleteLink;
var
  Level: TJobLevel;
  Group: TJobGroup;
begin
  Level := FObjData.Items['Level'] as TJobLevel;
  Group := Level.Groups[ViewRules.tvTree.Selected.Parent.Index];

  Group.Links.DeleteByIndex(ViewRules.tvTree.Selected.Index);
  ViewRules.SetControlTree(Level.Groups);
  ViewRules.pnlEntityFields.ClearControls;
end;

procedure TController.CreateLink;
var
  Level: TJobLevel;
  Group: TJobGroup;
  Link: TJobLink;
begin
  Level := FObjData.Items['Level'] as TJobLevel;
  Group := Level.Groups[ViewRules.tvTree.Selected.Index];

  Link := TJobLink.Create(FDBEngine);
  Group.Links.Add(Link);

  ViewRules.SetControlTree(Level.Groups);
end;

procedure TController.GetJobList;
var
  JobList: TJobList;
begin
  JobList := TJobList.Create(FDBEngine, [], []);
  try
    ViewMain.SetJobsGrid(JobList);
  finally
    FreeAndNil(JobList);
  end;
end;

procedure TController.DeleteGroup;
var
  Groups: TGroupList;
begin
  Groups := (FObjData.Items['Level'] as TJobLevel).Groups;
  Groups.DeleteByIndex(ViewRules.tvTree.Selected.Index);

  ViewRules.SetControlTree(Groups);
  ViewRules.pnlEntityFields.ClearControls;
end;

procedure TController.TreeNodeSelected;
var
  GroupIndex: Integer;
  LinkIndex: Integer;
  RecordIndex: Integer;
  LinkCount, RecordCount: Integer;
  Entity: TEntityAbstract;
  Level: TJobLevel;
begin
  GroupIndex := 0;
  LinkIndex := 0;
  RecordIndex := 0;
  Level := (FObjData.Items['Level'] as TJobLevel);

  with ViewRules do
    begin
      case tvTree.Selected.Level of
        0:
          begin
            GroupIndex := tvTree.Selected.Index;
            Entity := Level.Groups.Items[GroupIndex];
          end;
        1:
          begin
            GroupIndex := tvTree.Selected.Parent.Index;

            LinkCount := Level.Groups.Items[GroupIndex].Links.Count;
            RecordCount := Level.Groups.Items[GroupIndex].Records.Count;

            if tvTree.Selected.Index <= LinkCount - 1 then
              begin
                LinkIndex := tvTree.Selected.Index;
                Entity := Level.Groups.Items[GroupIndex].Links.Items[LinkIndex];
              end
            else
              begin
                RecordIndex := tvTree.Selected.Index - LinkCount;
                Entity := Level.Groups.Items[GroupIndex].Records.Items[RecordIndex];
              end;
          end;
      end;

      pnlEntityFields.ClearControls;
      pnlEntityFields.BuildControls(Entity);
    end;
end;

procedure TController.EditJobRules;
var
  Job: TJob;
  Levels: TEntityList<TJobLevel>;
  Level: TJobLevel;
begin
  Job := TJob.Create(FDBEngine, ViewMain.SelectedJobID);
  FObjData.AddOrSetValue('Job', Job);

  Levels := Job.Levels;
  if Levels.Count = 0 then
    begin
      Level := TJobLevel.Create(FDBEngine, 0);
      Level.Level := 1;
      Level.BaseLink := Job.ZeroLink;
      Levels.Add(Level);
    end;
  FObjData.AddOrSetValue('Level', Levels[0]);

  CallView(TViewRules);
  ViewRules.SetLevels(Levels);
  ViewRules.SetControlTree(Levels[0].Groups);
end;

procedure TController.StoreJobRules;
var
  Job: TJob;
begin
  Job := FObjData.Items['Job'] as TJob;
  Job.SaveAll;
  ViewRules.Close;
end;

procedure TController.CreateGroup;
var
  Level: TJobLevel;
  Group: TJobGroup;
begin
  Level := FObjData.Items['Level'] as TJobLevel;

  Group := TJobGroup.Create(FDBEngine, 0);
  Group.Notes := 'New Group';

  Level.Groups.Add(Group);
  ViewRules.SetControlTree(Level.Groups);
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
      GetJobList;
    end;

  if aEventMsg = 'GetJobDone' then
    begin
      CallView(TViewJob);
      Job := FObjData.Items['Job'] as TJob;
      ViewJob.CRUDPanel.BuildCRUD(Job);
      ViewJob.SetBrowserLinks;
    end;
end;

procedure TController.PerfomViewMessage(aMsg: string);
begin
  if aMsg = 'ViewRulesClosed' then
    begin
      FObjData.Items['Job'].Free;
      //FObjData.
    end;

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
