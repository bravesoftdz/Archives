unit vLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  API_MVC;

type
  TViewLogin = class(TViewAbstract)
    edtLogin: TEdit;
    edtPassword: TEdit;
    lblLogin: TLabel;
    lblPassword: TLabel;
    btnApply: TBitBtn;
    btnCancel: TBitBtn;
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitView; override;
  public
    { Public declarations }
  end;

var
  ViewLogin: TViewLogin;

implementation

{$R *.dfm}

procedure TViewLogin.InitView;
begin
  ViewLogin := Self;
end;

procedure TViewLogin.btnApplyClick(Sender: TObject);
begin
  Self.SendMessage('PerfomLoggining');
end;

procedure TViewLogin.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
