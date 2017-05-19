unit eEntities;

interface

uses
  System.Generics.Collections,
  Data.DB,
  API_ORM;

type
  TJobRule = class(TEntityAbstract)
  protected
    // Getters Setters
    function GetGroupID: Integer;
    procedure SetGroupID(aValue: integer);
    function GetDescription: string;
    procedure SetDescription(aValue: string);
    //////////////////
    procedure InitFields; override;
  public
    class function GetTableName: string; override;
    property GroupID: Integer read GetGroupID write SetGroupID;
    property Description: string read GetDescription write SetDescription;
  end;

  TJobGroup = class(TEntityAbstract)
  protected
    // Getters Setters
    function GetLevelID: Integer;
    procedure SetLevelID(aValue: integer);
    function GetNotes: string;
    procedure SetNotes(aValue: string);
    //////////////////
    procedure InitFields; override;
  public
    class function GetTableName: string; override;
    property LevelID: Integer read GetLevelID write SetLevelID;
    property Notes: string read GetNotes write SetNotes;
  end;

  TJobGroupList = TEntityList<TJobGroup>;

  TJobLevel = class(TEntityAbstract)
  protected
    FGroups: TJobGroupList;
    // Getters Setters
    function GetGroups: TJobGroupList;
    function GetLevel: integer;
    procedure SetLevel(aValue: integer);
    function GetBaseLink: string;
    procedure SetBaseLink(aValue: string);
    //////////////////
    procedure InitFields; override;
  public
    class function GetTableName: string; override;
    property Level: Integer read GetLevel write SetLevel;
    property BaseLink: string read GetBaseLink write SetBaseLink;
    property Groups: TJobGroupList read GetGroups;
  end;

  TJobLevelList = TEntityList<TJobLevel>;

  TJob = class(TEntityAbstract)
  protected
    FLevels: TJobLevelList;
    // Getters Setters
    function GetLevels: TJobLevelList;
    function GetCaption: string;
    procedure SetCaption(aValue: string);
    function GetZeroLink: string;
    procedure SetZeroLink(aValue: string);
    function GetUserID: integer;
    procedure SetUserID(aValue: integer);
    //////////////////
    procedure InitFields; override;
  public
    class function GetTableName: string; override;
    property Caption: string read GetCaption write SetCaption;
    property ZeroLink: string read GetZeroLink write SetZeroLink;
    property UserID: Integer read GetUserID write SetUserID;
    property Levels: TJobLevelList read GetLevels;
  end;

  TJobList = TEntityList<TJob>;

implementation

uses
  System.SysUtils;

function TJob.GetLevels: TJobLevelList;
begin
  if not Assigned(FLevels)  then
    FLevels := TJobLevelList.Create(FDBEngine, 'JOB_ID', Self.ID);

  Result := FLevels;
end;

function TJobRule.GetGroupID: Integer;
begin
  Result := FData.Items['GROUP_ID'];
end;

procedure TJobRule.SetGroupID(aValue: integer);
begin
  FData.AddOrSetValue('GROUP_ID', aValue);
end;

function TJobRule.GetDescription: string;
begin
  Result := FData.Items['DESCRIPTION'];
end;

procedure TJobRule.SetDescription(aValue: string);
begin
  FData.AddOrSetValue('DESCRIPTION', aValue);
end;

procedure TJobRule.InitFields;
begin
  AddField('GROUP_ID', ftInteger);
  AddField('DESCRIPTION', ftString);
end;

class function TJobRule.GetTableName: string;
begin
  Result := 'job_rules';
end;

class function TJobGroup.GetTableName: string;
begin
  Result := 'job_groups';
end;

function TJobLevel.GetGroups: TJobGroupList;
begin
  if not Assigned(FGroups)  then
    FGroups := TJobGroupList.Create(FDBEngine, ['LEVEL_ID='+IntToStr(Self.ID)], []);

  Result := FGroups;
end;

function TJobGroup.GetNotes: string;
begin
  Result := FData.Items['NOTES'];
end;

procedure TJobGroup.SetNotes(aValue: string);
begin
  FData.AddOrSetValue('NOTES', aValue);
end;

function TJobGroup.GetLevelID: Integer;
begin
  Result := FData.Items['LEVEL_ID'];
end;

procedure TJobGroup.SetLevelID(aValue: integer);
begin
  FData.AddOrSetValue('LEVEL_ID', aValue);
end;

procedure TJobGroup.InitFields;
begin
  AddField('LEVEL_ID', ftInteger);
  AddField('NOTES', ftString);
end;

function TJobLevel.GetBaseLink: string;
begin
  Result := FData.Items['BASE_LINK'];
end;

procedure TJobLevel.SetBaseLink(aValue: string);
begin
  FData.AddOrSetValue('BASE_LINK', aValue);
end;

function TJobLevel.GetLevel: integer;
begin
  Result := FData.Items['LEVEL'];
end;

procedure TJobLevel.SetLevel(aValue: integer);
begin
  FData.AddOrSetValue('LEVEL', aValue);
end;

procedure TJobLevel.InitFields;
begin
  AddField('JOB_ID', ftInteger);
  AddField('LEVEL', ftInteger);
  AddField('BASE_LINK', ftString);
end;

class function TJobLevel.GetTableName: string;
begin
  Result := 'job_levels';
end;

function TJob.GetUserID: integer;
begin
  Result := FData.Items['USER_ID'];
end;

procedure TJob.SetUserID(aValue: integer);
begin
  FData.AddOrSetValue('USER_ID', aValue);
end;

procedure TJob.SetZeroLink(aValue: string);
begin
  FData.AddOrSetValue('ZERO_LINK', aValue);
end;

function TJob.GetZeroLink: string;
begin
  Result := FData.Items['ZERO_LINK'];
end;

procedure TJob.SetCaption(aValue: string);
begin
  FData.AddOrSetValue('CAPTION', aValue);
end;

function TJob.GetCaption;
begin
  Result := FData.Items['CAPTION'];
end;

class function TJob.GetTableName: string;
begin
  Result := 'jobs';
end;

procedure TJob.InitFields;
begin
  AddField('user_id', ftInteger);
  AddField('caption', ftString);
  AddField('zero_link', ftString);
end;

end.
