unit API;

interface

uses
  Vcl.Dialogs;

type
  TParserModel=class
  public
    constructor Create(aJobID: integer);
  end;

implementation

constructor TParserModel.Create(aJobID: integer);
begin
  ShowMessage('q');
end;

end.
