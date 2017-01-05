program ParseItAll;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  API_Files in '..\..\..\Libraries\Delphi\API_Files.pas',
  API_DBases in '..\..\..\Libraries\Delphi\API_DBases.pas',
  Entities in 'Entities.pas',
  Model in 'Model.pas',
  DBService in 'DBService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
