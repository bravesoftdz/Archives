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
    constructor Create(aJobID: Integer; aMySQLEngine: TMySQLEngine);
  end;

implementation

uses
  FireDAC.Comp.Client;

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
