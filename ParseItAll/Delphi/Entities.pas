unit Entities;

interface

uses
   System.Generics.Collections
  ,API_DBases;

type
  TJobNode = record
    Tag: string;
    Index: integer;
    TagID: string;
    ClassName: string;
    Name: string;
  end;

  TJobNodes = TArray<TJobNode>;

  TJobRegExp = record
    RegExp: string;
  end;

  TJobRegExps = TArray<TJobRegExp>;

  TJobRule = class abstract (TObject)
  private
    FNodes: TJobNodes;
    FRegExps: TJobRegExps;
    FContainerOffset: Integer;
  public
    constructor Create(aRuleID: integer; aMySQLEngine: TMySQLEngine); virtual;
    property Nodes: TJobNodes read FNodes;
    property RegExps: TJobRegExps read FRegExps;
    property ContainerOffset: Integer read FContainerOffset;
  end;

  TJobLinksRule = class(TJobRule)
  private
    FLevel: Integer;
  public
    constructor Create(aRuleID: integer; aMySQLEngine: TMySQLEngine); override;
    property Level: Integer read FLevel;
  end;

  TJobLinksRules = TObjectList<TJobLinksRule>;

  TJobRecordsRule = class(TJobRule)
  private
    FKey: string;
  public
    constructor Create(aRuleID: integer; aMySQLEngine: TMySQLEngine); override;
    property Key: string read FKey;
  end;

  TJobRecordsRules = TObjectList<TJobRecordsRule>;

  TJobLevel = record
    Level: Integer;
    JobLinksRules: TJobLinksRules;
    JobRecordsRules: TJobRecordsRules;
  end;

  TJobLevels = TArray<TJobLevel>;

  TJob = class
    FId: Integer;
    FZeroLink: string;
    FLevels: TJobLevels;
  public
    constructor Create(aJobID: integer; aMySQLEngine: TMySQLEngine);
    function GetLinksRulesByLevel(aLevel: integer): TJobLinksRules;
    function GetRecordsRulesByLevel(aLevel: integer): TJobRecordsRules;
    property Id: Integer read FId;
    property ZeroLink: string read FZeroLink;
    property Levels: TJobLevels read FLevels;
  end;

  TCurrLink = record
    Id: Integer;
    Link: string;
    Level: Integer;
  end;

implementation

uses
   FireDAC.Comp.Client
  ,API_Parse;

constructor TJobRecordsRule.Create(aRuleID: integer; aMySQLEngine: TMySQLEngine);
var
  dsRecord: TFDQuery;
begin
  inherited;

  dsRecord:=TFDQuery.Create(nil);
  try
    dsRecord.SQL.Text:='select * from job_rule_records where job_rule_id=:JobRuleID';
    dsRecord.ParamByName('JobRuleID').AsInteger:=aRuleID;
    aMySQLEngine.OpenQuery(dsRecord);
    FKey:=dsRecord.FieldByName('key').AsString;
  finally
    dsRecord.Free;
  end;
end;

constructor TJobLinksRule.Create(aRuleID: integer; aMySQLEngine: TMySQLEngine);
var
  dsLink: TFDQuery;
begin
  inherited;

  dsLink:=TFDQuery.Create(nil);
  try
    dsLink.SQL.Text:='select * from job_rule_links where job_rule_id=:JobRuleID';
    dsLink.ParamByName('JobRuleID').AsInteger:=aRuleID;
    aMySQLEngine.OpenQuery(dsLink);
    FLevel:=dsLink.FieldByName('level').AsInteger;
  finally
    dsLink.Free;
  end;
end;

constructor TJobRule.Create(aRuleID: integer; aMySQLEngine: TMySQLEngine);
var
  dsRule, dsNodes, dsRegExps: TFDQuery;
  Node: TJobNode;
  RegExp: TJobRegExp;
begin
  dsRule:=TFDQuery.Create(nil);
  dsNodes:=TFDQuery.Create(nil);
  dsRegExps:=TFDQuery.Create(nil);
  try
    dsRule.SQL.Text:='select * from job_rules where id=:ID';
    dsRule.ParamByName('ID').AsInteger:=aRuleID;
    aMySQLEngine.OpenQuery(dsRule);
    FContainerOffset:=dsRule.FieldByName('container_offset').AsInteger;

    FNodes:=[];
    dsNodes.SQL.Text:='select * from job_nodes where job_rule_id=:JobRuleID order by id';
    dsNodes.ParamByName('JobRuleID').AsInteger:=aRuleID;
    aMySQLEngine.OpenQuery(dsNodes);
    while not dsNodes.EOF do
      begin
        Node.Tag:=dsNodes.FieldByName('tag').AsString;
        Node.Index:=dsNodes.FieldByName('index').AsInteger;
        Node.TagID:=dsNodes.FieldByName('tag_id').AsString;
        Node.ClassName:=TParseTools.GetNormalizeString(dsNodes.FieldByName('class').AsString);
        Node.Name:=dsNodes.FieldByName('name').AsString;

        FNodes := FNodes + [Node];
        dsNodes.Next;
      end;

    FRegExps:=[];
    dsRegExps.SQL.Text:='select * from job_regexp where job_rule_id=:JobRuleID order by id';
    dsRegExps.ParamByName('JobRuleID').AsInteger:=aRuleID;
    aMySQLEngine.OpenQuery(dsRegExps);
    while not dsRegExps.EOF do
      begin
        RegExp.RegExp:=dsRegExps.FieldByName('regexp').AsString;

        FRegExps := FRegExps + [RegExp];
        dsRegExps.Next;
      end;
  finally
    dsRule.Free;
    dsNodes.Free;
    dsRegExps.Free;
  end;
end;

function TJob.GetRecordsRulesByLevel(aLevel: integer): TJobRecordsRules;
var
  JobLevel: TJobLevel;
begin
  Result:=nil;
  for JobLevel in FLevels do
    if JobLevel.Level=aLevel then
      begin
        Result:=JobLevel.JobRecordsRules;
        Break;
      end;
end;

function TJob.GetLinksRulesByLevel(aLevel: integer): TJobLinksRules;
var
  JobLevel: TJobLevel;
begin
  Result:=nil;
  for JobLevel in FLevels do
    if JobLevel.Level=aLevel then
      begin
        Result:=JobLevel.JobLinksRules;
        Break;
      end;
end;

constructor TJob.Create(aJobID: Integer; aMySQLEngine: TMySQLEngine);
var
  dsJob, dsLevels, dsRules: TFDQuery;
  JobLevel: TJobLevel;
  JobLinksRule: TJobLinksRule;
  JobRecordsRule: TJobRecordsRule;
  sql: string;
begin
  FId:=aJobID;

  dsJob:=TFDQuery.Create(nil);
  dsLevels:=TFDQuery.Create(nil);
  dsRules:=TFDQuery.Create(nil);
  try
    dsJob.SQL.Text:='select * from jobs where id=:JobID';
    dsJob.ParamByName('JobID').AsInteger:=aJobID;
    aMySQLEngine.OpenQuery(dsJob);
    FZeroLink:=dsJob.FieldByName('zero_link').AsString;

    dsLevels.Close;
    dsLevels.SQL.Text:='select * from job_levels where job_id=:JobID order by level';
    dsLevels.ParamByName('JobID').AsInteger:=aJobID;
    aMySQLEngine.OpenQuery(dsLevels);
    Self.FLevels:=[];
    while not dsLevels.EOF do
      begin
        JobLevel.Level:=dsLevels.FieldByName('level').AsInteger;

        JobLevel.JobLinksRules:=TJobLinksRules.Create;
        JobLevel.JobRecordsRules:=TJobRecordsRules.Create;

        sql:='select j.id, jl.id as jlid, jr.id as jrid from job_rules j';
        sql:=sql+' left join job_rule_links jl on jl.job_rule_id=j.id';
        sql:=sql+' left join job_rule_records jr on jr.job_rule_id=j.id';
        sql:=sql+' where job_level_id=:JobLevel order by j.id';
        dsRules.Close;
        dsRules.SQL.Text:=sql;
        dsRules.ParamByName('JobLevel').AsInteger:=dsLevels.FieldByName('Id').AsInteger;
        aMySQLEngine.OpenQuery(dsRules);
        while not dsRules.EOF do
          begin
            if not dsRules.FieldByName('jlid').IsNull then
              begin
                JobLinksRule:=TJobLinksRule.Create(dsRules.FieldByName('Id').AsInteger, aMySQLEngine);
                JobLevel.JobLinksRules.Add(JobLinksRule);
              end;

            if not dsRules.FieldByName('jrid').IsNull then
              begin
                JobRecordsRule:=TJobRecordsRule.Create(dsRules.FieldByName('Id').AsInteger, aMySQLEngine);
                JobLevel.JobRecordsRules.Add(JobRecordsRule);
              end;

            dsRules.Next;
          end;

        Self.FLevels:=Self.FLevels + [JobLevel];
        dsLevels.Next;
      end;
  finally
    dsJob.Free;
    dsLevels.Free;
    dsRules.Free;
  end;

end;

end.
