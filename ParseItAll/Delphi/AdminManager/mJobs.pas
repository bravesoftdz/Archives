unit mJobs;

interface

uses
  API_MVC_DB;

type
  TModelJobs = class(TModelDB)
  published
    procedure GetJob;
    procedure GetJobList;
  end;

implementation

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  eEntities;

procedure TModelJobs.GetJobList;
var
  JobList: TJobList;
begin
  JobList := TJobList.Create(FDBEngine, [], []);
  FObjData.AddOrSetValue('JobList', JobList);
  CreateEvent('GetJobListDone');
end;

procedure TModelJobs.GetJob;
var
  Job: TJob;
begin
  Job := TJob.Create(FDBEngine, FData.Items['JobID']);

  FObjData.AddOrSetValue('Job', Job);
  CreateEvent('GetJobDone');
end;

end.
