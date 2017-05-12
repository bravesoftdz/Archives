unit mJobs;

interface

uses
  API_MVC_DB;

type
  TModelJobs = class(TModelDB)
  published
    procedure CreateJob;
  end;

implementation

uses
  eEntities;

procedure TModelJobs.CreateJob;
var
  Job: TJob;
begin
  Job := GetEntity<TJob>;
end;

end.
