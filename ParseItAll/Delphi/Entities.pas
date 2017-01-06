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

  TJobRuleLink = record
    Level: integer;
  end;

  TJobRuleRecord = record
    Key: string;
  end;

  TJobRule = class abstract (TObject)
  private
    FNodes: TJobNodes;
    FContainerOffset: Integer;
  public
    constructor Create(aRuleID: integer; aMySQLEngine: TMySQLEngine); virtual;
    property Nodes: TJobNodes read FNodes write FNodes;
    property ContainerOffset: Integer read FContainerOffset write FContainerOffset;
  end;

  TJobLinksRule = class(TJobRule)
  private
    FRuleLink: TJobRuleLink;
  public
    constructor Create(aRuleID: integer; aMySQLEngine: TMySQLEngine); override;
    property RuleLink: TJobRuleLink read FRuleLink write FRuleLink;
  end;

  TJobLinksRules = TObjectList<TJobLinksRule>;

  TJobRecordsRule = class(TJobRule)
  private
    FRuleRecord: TJobRuleRecord;
  public
    property RuleRecord: TJobRuleRecord read FRuleRecord write FRuleRecord;
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

constructor TJobLinksRule.Create(aRuleID: integer; aMySQLEngine: TMySQLEngine);
begin

end;

constructor TJobRule.Create(aRuleID: integer; aMySQLEngine: TMySQLEngine);
var
  dsRule, dsNodes: TFDQuery;
  Node: TJobNode;
begin
  dsRule:=TFDQuery.Create(nil);
  dsNodes:=TFDQuery.Create(nil);
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
        Node.ClassName:=dsNodes.FieldByName('class').AsString;
        Node.Name:=dsNodes.FieldByName('name').AsString;

        FNodes := FNodes + [Node];
        dsNodes.Next;
      end;
  finally
    dsRule.Free;
    dsNodes.Free;
  end;
end;

function TJob.GetLinksRulesByLevel(aLevel: integer): TJobLinksRules;
var
  JobLevel: TJobLevel;
begin
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
        dsRules.Close;
        dsRules.SQL.Text:='select * from job_rules where job_level_id=:JobLevel order by id';
        dsRules.ParamByName('JobLevel').AsInteger:=dsLevels.FieldByName('Id').AsInteger;
        aMySQLEngine.OpenQuery(dsRules);
        while not dsRules.EOF do
          begin

            JobLinksRule:=TJobLinksRule.Create(dsRules.FieldByName('Id').AsInteger, aMySQLEngine);
            if JobLinksRule<>nil then JobLevel.JobLinksRules.Add(JobLinksRule);

            JobRecordsRule:=TJobRecordsRule.Create(dsRules.FieldByName('Id').AsInteger, aMySQLEngine);
            if JobRecordsRule<>nil then JobLevel.JobRecordsRules.Add(JobRecordsRule);


            {

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

            JobLevel.JobRules := JobLevel.JobRules + [JobRule]; }
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
