program BezRam;

uses
  Vcl.Forms,
  OrderFormUnit in 'OrderFormUnit.pas' {Order},
  MainFormUnit in 'MainFormUnit.pas' {MainForm},
  ExchangeFormUnit in 'ExchangeFormUnit.pas' {Exchange},
  PriceListAkrUnit in 'PriceListAkrUnit.pas' {PL_AKR},
  PriceListAMUnit in 'PriceListAMUnit.pas' {PL_AM},
  PriceListASUnit in 'PriceListASUnit.pas' {AS_PL},
  AddMatForm in 'AddMatForm.pas' {AM_Edit},
  AddServForm in 'AddServForm.pas' {AS_Edit},
  Unit9 in 'Unit9.pas' {pl_pas},
  CalcComp2FormUnit in 'CalcComp2FormUnit.pas' {CompCalc},
  CalcCompFormUnit in 'CalcCompFormUnit.pas' {CompPrice},
  CalcGlassFormUnit in 'CalcGlassFormUnit.pas' {GlassCalc},
  API_MVC in '..\..\Libraries\API_MVC.pas',
  Controllers in 'Controllers.pas',
  API_DBases in '..\..\Libraries\API_DBases.pas',
  API_Files in '..\..\Libraries\API_Files.pas',
  API_DBModels in '..\..\Libraries\API_DBModels.pas',
  MigrateFormUnit in 'MigrateFormUnit.pas' {frmMigrate},
  AuthFormUnit in 'AuthFormUnit.pas' {AuthForm},
  Models in 'Models.pas',
  CustomersFormUnit in 'CustomersFormUnit.pas' {frmCustomers},
  UsersUnit in 'UsersUnit.pas' {frmUsers},
  ViewUserData in 'ViewUserData.pas' {frmUser};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
