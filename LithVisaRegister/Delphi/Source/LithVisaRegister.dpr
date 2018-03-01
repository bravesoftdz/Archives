program LithVisaRegister;

uses
  System.StartUpCopy,
  FMX.Forms,
  cController in 'cController.pas',
  vMain in 'vMain.pas' {ViewMain},
  eCommon in 'eCommon.pas',
  API_DB in '..\..\..\..\Libs\Delphi\API_DB.pas',
  API_MVC_FMXDB in '..\..\..\..\Libs\Delphi\API_MVC_FMXDB.pas',
  API_MVC_DB in '..\..\..\..\Libs\Delphi\API_MVC_DB.pas',
  API_MVC in '..\..\..\..\Libs\Delphi\API_MVC.pas',
  API_MVC_FMX in '..\..\..\..\Libs\Delphi\API_MVC_FMX.pas' {ViewFMXBase},
  API_ORM in '..\..\..\..\Libs\Delphi\API_ORM.pas',
  API_DB_SQLite in '..\..\..\..\Libs\Delphi\API_DB_SQLite.pas',
  eClient in 'eClient.pas',
  eRegister in 'eRegister.pas',
  eContact in 'eContact.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF DEBUG}

  Application.Initialize;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
