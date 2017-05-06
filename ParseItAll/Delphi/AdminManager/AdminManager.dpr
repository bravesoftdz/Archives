program AdminManager;

uses
  Vcl.Forms,
  vMain in 'vMain.pas' {ViewMain},
  API_MVC in '..\..\..\..\Libraries\Delphi\API_MVC.pas',
  cController in 'cController.pas',
  API_MVC_DB in '..\..\..\..\Libraries\Delphi\API_MVC_DB.pas',
  API_DB in '..\..\..\..\Libraries\Delphi\API_DB.pas',
  API_DB_MySQL in '..\..\..\..\Libraries\Delphi\API_DB_MySQL.pas',
  API_Files in '..\..\..\..\Libraries\Delphi\API_Files.pas',
  vLogin in 'vLogin.pas' {ViewLogin},
  mLogin in 'mLogin.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
