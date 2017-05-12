unit eEntities;

interface

uses
  System.Generics.Collections,
  API_ORM;

type
  TJob = class(TEntityAbstract)
  end;

  TJobList = TObjectList<TJob>;

implementation

end.
