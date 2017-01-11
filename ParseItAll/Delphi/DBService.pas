unit DBService;

interface

uses
   API_DBases
  ,Entities;

type
  TPIADBService = class
  private
    FMySQLEngine: TMySQLEngine;
    FJobID: Integer;
  public
    function CheckFirstRun: Boolean;
    function GetCurrLink: TCurrLink;
    function AddLink(aLink: string; aLevel: Integer): Integer;
    procedure SetLinkHandle(aLinkID: Integer; aValue: Integer);
    procedure AddRecord(aLinkId, aRecordNum: integer; aKey, aValue: string);
    procedure AddJobMessage(aLinkId, aJobNodeId: integer);
    constructor Create(aJobID: Integer; aMySQLEngine: TMySQLEngine);
  end;

implementation

uses
  FireDAC.Comp.Client;

procedure TPIADBService.AddJobMessage(aLinkId, aJobNodeId: integer);
var
  dsQuery: TFDQuery;
  sql: string;
begin
  dsQuery:=TFDQuery.Create(nil);
  try
    sql:='insert into job_messages set';
    sql:=sql+' link_id=:link_id';
    sql:=sql+',job_node_id=:job_node_id';
    dsQuery.SQL.Text:=sql;
    dsQuery.ParamByName('link_id').AsInteger:=aLinkId;
    dsQuery.ParamByName('job_node_id').AsInteger:=aJobNodeId;
    FMySQLEngine.ExecQuery(dsQuery);
  finally
    dsQuery.Free;
  end;
end;

procedure TPIADBService.AddRecord(aLinkId, aRecordNum: Integer; aKey: string; aValue: string);
var
  sql: string;
  dsQuery: TFDQuery;
begin
  dsQuery:=TFDQuery.Create(nil);
  try
    sql:='insert into records set';
    sql:=sql+' `link_id`=:link_id';
    sql:=sql+',`num`=:num';
    sql:=sql+',`key`=:key';
    sql:=sql+',`value`=:value';
    sql:=sql+',`value_hash`=md5(:value)';
    dsQuery.SQL.Text:=sql;
    dsQuery.ParamByName('link_id').AsInteger:=aLinkId;
    dsQuery.ParamByName('num').AsInteger:=aRecordNum;
    dsQuery.ParamByName('key').AsString:=aKey;
    dsQuery.ParamByName('value').AsWideString:=aValue;

    FMySQLEngine.ExecQuery(dsQuery);
  finally
    dsQuery.Free;
  end;
end;

procedure TPIADBService.SetLinkHandle(aLinkID: Integer; aValue: Integer);
var
  dsQuery: TFDQuery;
begin
  dsQuery:=TFDQuery.Create(nil);
  try
    dsQuery.SQL.Text:='update links set handled=:Value where id=:LinkID';
    dsQuery.ParamByName('Value').AsInteger:=aValue;
    dsQuery.ParamByName('LinkID').AsInteger:=aLinkID;
    FMySQLEngine.ExecQuery(dsQuery);
  finally
    dsQuery.Free;
  end;
end;

function TPIADBService.AddLink(aLink: string; aLevel: Integer): Integer;
var
  dsQuery: TFDQuery;
  sql: string;
begin
  sql:='insert into links set';
  sql:=sql+' job_id=:JobId';
  sql:=sql+',level=:Level';
  sql:=sql+',link=:Link';
  sql:=sql+',link_hash=md5(:Link)';
  dsQuery:=TFDQuery.Create(nil);
  try
    dsQuery.SQL.Text:=sql;
    dsQuery.ParamByName('JobId').AsInteger:=FJobID;
    dsQuery.ParamByName('Level').AsInteger:=aLevel;
    dsQuery.ParamByName('Link').AsString:=aLink;

    FMySQLEngine.ExecQuery(dsQuery);
    Result:=FMySQLEngine.GetLastInsertedID;
  finally
    dsQuery.Free;
  end;
end;

function TPIADBService.CheckFirstRun: Boolean;
var
  dsQuery: TFDQuery;
begin
  dsQuery:=TFDQuery.Create(nil);
  try
    dsQuery.SQL.Text:='select count(*) as LinksCount from links where job_id=:JobID';
    dsQuery.ParamByName('JobID').AsInteger:=FJobID;
    FMySQLEngine.OpenQuery(dsQuery);
    if dsQuery.FieldByName('LinksCount').AsInteger=0 then Result:=True
    else Result:=False;
  finally
    dsQuery.Free
  end;
end;

function TPIADBService.GetCurrLink: TCurrLink;
var
  dsQuery: TFDQuery;
  sql: string;
begin
  dsQuery:=TFDQuery.Create(nil);
  try
    sql:='select links.*';
    sql:=sql+',(select count(*) from links t where t.job_id=links.job_id) links_count';
    sql:=sql+' from links';
    sql:=sql+' where job_id=:JobID';
    sql:=sql+' and handled is null';
    sql:=sql+' order by level desc, id';
    sql:=sql+' limit 1';
    dsQuery.SQL.Text:=sql;
    dsQuery.ParamByName('JobID').AsInteger:=FJobID;
    FMySQLEngine.OpenQuery(dsQuery);

    Result.Id:=dsQuery.FieldByName('Id').AsInteger;
    Result.Link:=dsQuery.FieldByName('link').AsString;
    Result.Level:=dsQuery.FieldByName('level').AsInteger;
  finally
    dsQuery.Free;
  end;
end;

constructor TPIADBService.Create(aJobID: Integer; aMySQLEngine: TMySQLEngine);
begin
  FMySQLEngine:=aMySQLEngine;
  FJobID:=aJobID;
end;

end.
