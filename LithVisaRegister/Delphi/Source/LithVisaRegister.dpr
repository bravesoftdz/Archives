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
  eContact in 'eContact.pas',
  API_ORM_Bind in '..\..\..\..\Libs\Delphi\API_ORM_Bind.pas',
  API_ORM_BindFMX in '..\..\..\..\Libs\Delphi\API_ORM_BindFMX.pas',
  vClientList in 'vClientList.pas' {ViewClientList},
  vClient in 'vClient.pas' {ViewClent},
  mRegister in 'mRegister.pas',
  vRegister in 'vRegister.pas' {ViewRegister},
  API_Files in '..\..\..\..\Libs\Delphi\API_Files.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF DEBUG}

  Application.Initialize;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
