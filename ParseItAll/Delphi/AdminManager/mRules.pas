unit mRules;

interface

uses
  API_MVC_DB;

type
  TModelRules = class(TModelDB)
  published
    procedure GetLevels;
  end;

implementation

uses
  System.SysUtils,
  eEntities;

procedure TModelRules.GetLevels;
var
  JobLevelList: TJobLevelList;
  JobID: integer;
  ListFilter: TArray<string>;
  ListOrder: TArray<string>;
begin
  JobID := FData.Items['JobID'];

  ListFilter := ListFilter + [Format('JOB_ID = "%d"', [JobID])];
  ListOrder := ListOrder + ['LEVEL'];
  JobLevelList := TJobLevelList.Create(FDBEngine, ListFilter, ListOrder);
end;

end.
