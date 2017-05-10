unit eEntities;

interface

uses
  System.Generics.Collections;

type
  TJob = class
  public
    constructor Create(aID: integer = 0);
  end;

  TJobList = TObjectList<TJob>;

implementation

constructor TJob.Create(aID: Integer = 0);
begin

end;

end.
