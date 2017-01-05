unit Entities;

interface

uses
  API_DBases;

type
  TJobNode = record
    Tag: string;
    Index: integer;
    TagID: string;
    ClassName: string;
    Name: string;
  end;

  TJobNodes = TArray<TJobNode>;

  TJobRuleLink = record
    Level: integer;
  end;

  TJobRuleRecord = record
    Key: string;
  end;

  TJobRule = record
    RuleLink: TJobRuleLink;
    RuleRecord: TJobRuleRecord;
    Nodes: TJobNodes;
    ContainerOffset: Integer;
  end;

  TJobRules = TArray<TJobRule>;

  TJobLevel = record
    Level: Integer;
    JobRules: TJobRules;
  end;

  TJobLevels = TArray<TJobLevel>;

  TJob = class
    FId: Integer;
    FZeroLink: string;
    FLevels: TJobLevels;
  public
    constructor Create(aJobID: integer; aMySQLEngine: TMySQLEngine);
    function GetRulesByLevel(aLevel: integer): TJobRules;
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
  FireDAC.Comp.Client;

function TJob.GetRulesByLevel(aLevel: integer): TJobRules;
var
  JobLevel: TJobLevel;
begin
  for JobLevel in FLevels do
    if JobLevel.Level=aLevel then
      begin
        Result:=JobLevel.JobRules;
        Break;
      end;
end;

constructor TJob.Create(aJobID: Integer; aMySQLEngine: TMySQLEngine);
var
  dsJob, dsLevels, dsRules, dsLink, dsRecord, dsNodes: TFDQuery;
  JobLevel: TJobLevel;
  JobRule: TJobRule;
  Node: TJobNode;
begin
  FId:=aJobID;

  dsJob:=TFDQuery.Create(nil);
  dsLevels:=TFDQuery.Create(nil);
  dsRules:=TFDQuery.Create(nil);
  dsLink:=TFDQuery.Create(nil);
  dsRecord:=TFDQuery.Create(nil);
  dsNodes:=TFDQuery.Create(nil);
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

        dsRules.Close;
        dsRules.SQL.Text:='select * from job_rules where job_level_id=:JobLevel order by id';
        dsRules.ParamByName('JobLevel').AsInteger:=dsLevels.FieldByName('Id').AsInteger;
        aMySQLEngine.OpenQuery(dsRules);
        JobLevel.JobRules:=[];
        while not dsRules.EOF do
          begin
            JobRule.ContainerOffset:=dsRules.FieldByName('container_offset').AsInteger;

            dsLink.Close;
            dsLink.SQL.Text:='select * from job_rule_links where job_rule_id=:JobRuleID';
            dsLink.ParamByName('JobRuleID').AsInteger:=dsRules.FieldByName('Id').AsInteger;
            aMySQLEngine.OpenQuery(dsLink);
            JobRule.RuleLink.Level:=dsLink.FieldByName('level').AsInteger;

            dsRecord.Close;
            dsRecord.SQL.Text:='select * from job_rule_records where job_rule_id=:JobRuleID';
            dsRecord.ParamByName('JobRuleID').AsInteger:=dsRules.FieldByName('Id').AsInteger;
            aMySQLEngine.OpenQuery(dsRecord);
            JobRule.RuleRecord.Key:=dsRecord.FieldByName('key').AsString;

            dsNodes.Close;
            dsNodes.SQL.Text:='select * from job_nodes where job_rule_id=:JobRuleID order by id';
            dsNodes.ParamByName('JobRuleID').AsInteger:=dsRules.FieldByName('Id').AsInteger;
            aMySQLEngine.OpenQuery(dsNodes);
            JobRule.Nodes:=[];
            while not dsNodes.EOF do
              begin
                Node.Tag:=dsNodes.FieldByName('tag').AsString;
                Node.Index:=dsNodes.FieldByName('index').AsInteger;
                Node.TagID:=dsNodes.FieldByName('tag_id').AsString;
                Node.ClassName:=dsNodes.FieldByName('class').AsString;
                Node.Name:=dsNodes.FieldByName('name').AsString;

                JobRule.Nodes := JobRule.Nodes + [Node];
                dsNodes.Next;
              end;

            JobLevel.JobRules := JobLevel.JobRules + [JobRule];
            dsRules.Next;
          end;

        Self.FLevels:=Self.FLevels + [JobLevel];
        dsLevels.Next;
      end;
  finally
    dsJob.Free;
    dsLevels.Free;
    dsRules.Free;
    dsLink.Free;
    dsRecord.Free;
    dsNodes.Free;
  end;

end;

end.
