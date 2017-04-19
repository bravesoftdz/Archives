program Migrate;

uses
  Vcl.Forms,
  MigrateFormUnit in 'MigrateFormUnit.pas' {Form1},
  API_MVC in '..\..\Libraries\API_MVC.pas',
  API_DBases in '..\..\Libraries\API_DBases.pas',
  API_Files in '..\..\Libraries\API_Files.pas',
  Controllers in 'Controllers.pas',
  API_DBModels in '..\..\Libraries\API_DBModels.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMigrate, frmMigrate);
  Application.Run;
end.
