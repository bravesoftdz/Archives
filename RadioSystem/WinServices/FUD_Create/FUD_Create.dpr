program FUD_Create;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  API_DBases in '..\..\..\Libraries\API_DBases.pas',
  API_Files in '..\..\..\Libraries\API_Files.pas',
  alezzle in 'alezzle.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
