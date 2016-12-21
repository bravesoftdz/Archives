unit API;

interface

uses
  Vcl.Dialogs;

type
  TParserModel=class
  public
    procedure Execute;
    constructor Create(aJobID: integer);
  end;

implementation

procedure TParserModel.Execute;
begin
  //
end;

constructor TParserModel.Create(aJobID: integer);
begin

end;

end.
