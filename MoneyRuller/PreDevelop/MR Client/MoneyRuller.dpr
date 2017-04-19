program MoneyRuller;

uses
  System.StartUpCopy,
  FMX.Forms,
  viewAuth in 'viewAuth.pas' {frmAuth},
  viewMain in 'viewMain.pas' {frmMain},
  Controller in 'Controller.pas',
  View in 'View.pas',
  cntrMoneyRuller in 'cntrMoneyRuller.pas',
  viewBudget in 'viewBudget.pas' {frmBudget},
  viewAccounts in 'viewAccounts.pas' {frmAccounts};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmAccounts, frmAccounts);
  Application.Run;
end.
