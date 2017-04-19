unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  Tpl_pas = class(TForm)
    labelededit1: TLabeledEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pl_pas: Tpl_pas;

implementation

{$R *.dfm}

uses
   OrderFormUnit
  ,PriceListAMUnit
  ,MainFormUnit
  ,PriceListAkrUnit
  ,PriceListASUnit;

procedure Tpl_pas.Button1Click(Sender: TObject);
begin
if labelededit1.Text='kazzann' then
  begin
  if mode='PL_AKR' then PL_AKR.DBGrid1.ReadOnly:=false;
  if mode='PL_AM' then
    begin
    //PL_AM.ComboBox1.Enabled:=true;
    //PL_AM.DBEdit1.Enabled:=true;
    //PL_AM.DBComboBox2.Enabled:=true;
    //PL_AM.DBEdit2.Enabled:=true;
    //PL_AM.DBEdit3.Enabled:=true;
    PL_AM.Label5.Enabled:=true;
    PL_AM.Label6.Enabled:=true;
    PL_AM.Label10.Enabled:=true;
    end;
  if mode='AS_PL' then
    begin
    AS_PL.DBGrid1.ReadOnly:=false;
    AS_PL.Label1.Enabled:=true;
    AS_PL.Label2.Enabled:=true;
    end;
  end
  else
  begin
  MessageDlg('Пароль не верный',mtError, [mbClose], 0);
  end;
button2.Click;
end;

procedure Tpl_pas.Button2Click(Sender: TObject);
begin
pl_pas.Close;
pl_pas.Release;
end;

end.
