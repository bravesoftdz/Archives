unit viewAuth;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit
  ,View;

type
  TfrmAuth = class(TMViewAbstract)
    edtLogin: TEdit;
    edtPassword: TEdit;
    btnLogIn: TButton;
    lblLabel: TLabel;
    btnRegister: TButton;
    lblForgotPass: TLabel;
    procedure btnLogInClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAuth: TfrmAuth;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}

procedure TfrmAuth.btnLogInClick(Sender: TObject);
begin
  SendViewMessage('SignIn');
end;

end.
