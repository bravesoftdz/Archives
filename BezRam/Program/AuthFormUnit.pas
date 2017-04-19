unit AuthFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls
  ,API_MVC;

type
  TAuthForm = class(TViewAbstract)
    edtLogin: TEdit;
    edtPasw: TEdit;
    lblLogin: TLabel;
    lblPasw: TLabel;
    btnApply: TButton;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AuthForm: TAuthForm;

implementation

{$R *.dfm}

procedure TAuthForm.btnApplyClick(Sender: TObject);
begin
  FController.SendViewMessage('SetAuth');
  if FisReleased then Self.btnClose.Click;
end;

procedure TAuthForm.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.Release;
end;

end.
