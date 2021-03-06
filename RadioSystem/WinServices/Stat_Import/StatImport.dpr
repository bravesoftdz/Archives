program StatImport;

uses
  Vcl.Forms,
  View in 'View.pas' {frmView},
  API_MVC in '..\..\..\Libraries\API_MVC.pas',
  API_DBases in '..\..\..\Libraries\API_DBases.pas',
  API_Files in '..\..\..\Libraries\API_Files.pas',
  Controller in 'Controller.pas',
  Model in 'Model.pas',
  API_RS in '..\..\..\Libraries\API_RS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmView, frmView);
  Application.Run;
end.
