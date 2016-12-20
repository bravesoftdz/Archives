program ParseItAll;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  API in 'API.pas',
  API_Files in '..\..\..\Libraries\Delphi\API_Files.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
