unit ViewUserData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs
  ,API_MVC, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask;

type
  TfrmUser = class(TViewAbstract)
    dbedtLogin: TDBEdit;
    dbedtName: TDBEdit;
    dbedtPass: TDBEdit;
    dbcbbAccess: TDBComboBox;
    btnApply: TButton;
    btnCancel: TButton;
    lblLogin: TLabel;
    lblName: TLabel;
    lblPass: TLabel;
    lblAccess: TLabel;
    procedure dbcbbAccessChange(Sender: TObject);
  private
    { Private declarations }
    procedure InitMVC; override;
  public
    { Public declarations }
  end;

var
  frmUser: TfrmUser;

implementation

{$R *.dfm}

uses
   Controllers
  ,UsersUnit;

procedure TfrmUser.dbcbbAccessChange(Sender: TObject);
begin
  if dbcbbAccess.Text='Администратор' then frmUsers.dsUsers.FieldByName('access_type').AsInteger:=1
  else frmUsers.dsUsers.FieldByName('access_type').AsInteger:=0;
end;

procedure TfrmUser.InitMVC;
begin
  FControllerClass:=TController;
end;

end.
