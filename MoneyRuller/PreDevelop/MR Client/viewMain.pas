unit viewMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs
  ,View, FMX.StdCtrls;

type
  TfrmMain = class(TMViewAbstract)
    btnSignOut: TButton;
    btnBudget: TButton;
    btnAccounts: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSignOutClick(Sender: TObject);
    procedure btnBudgetClick(Sender: TObject);
    procedure btnAccountsClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitView; override;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses
  CntrMoneyRuller;

procedure TfrmMain.btnAccountsClick(Sender: TObject);
begin
  SendViewMessage('ShowAccounts');
end;

procedure TfrmMain.btnBudgetClick(Sender: TObject);
begin
  SendViewMessage('ShowExpenceBudget');
end;

procedure TfrmMain.btnSignOutClick(Sender: TObject);
begin
  SendViewMessage('SignOut');
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SendViewMessage('GetAuthState');
end;

procedure TfrmMain.InitView;
begin
  FControllerClass:=TMController;
end;

end.
