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
  eEntities,
  System.SysUtils,
  Vcl.Dialogs;

procedure TModelJobs.CreateJob;
var
  Job: TJob;
begin
  Job := TJob.Create(FDBEngine, 0);
  Job.ZeroLink := 'https://ru.wikipedia.org/';

  FObjData.AddOrSetValue('Job', Job);
  CreateEvent('CreateJobOK');
end;

end.
