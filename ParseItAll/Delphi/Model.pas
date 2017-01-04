unit Model;

interface

type
  TPIAModel = class
  public
    procedure StartJob(aJobID: integer);
  end;

implementation

procedure TPIAModel.StartJob(aJobID: integer);
var
  MySQLEngine: TMySQLEngine;
begin
  MySQLEngine:=TMySQLEngine.Create;
  MySQLEngine.OpenConnection('MySQL.ini');
  FJob:=TJob.Create(aJobID, MySQLEngine);
  FParser:=TParser.Create(FJob, MySQLEngine);
  GetNextLink;
end;

end.
