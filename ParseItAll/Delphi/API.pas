unit API;

interface

uses
   System.JSON
  ,Vcl.Dialogs;

type
  TParserModel=class
  public
    procedure SetJob(ajsnJobData: TJSONObject);
  end;

implementation

procedure TParserModel.SetJob(ajsnJobData: TJSONObject);
begin
  ShowMessage('q');
end;

end.
