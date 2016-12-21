unit API_Parse;

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
var
  isProcessing: Boolean;
begin
  isProcessing := True;
  while isProcessing do
    begin

    end;
end;

constructor TParserModel.Create(aJobID: integer);
begin

end;

end.
