unit AddServForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TAS_Edit = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DataSource1: TDataSource;
    FDQuery2: TFDQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AS_Edit: TAS_Edit;
  cost:real;

implementation

{$R *.dfm}

uses MainFormUnit, OrderFormUnit;

procedure TAS_Edit.Button1Click(Sender: TObject);
var
id: integer;
sum: Currency;
begin
  if (combobox1.Text='') or (StrToFloatDef(DBEdit1.Text,0)=0) then
    begin
      order.dsAddServ.Cancel;
    end
  else
    begin
      order.dsOrder.FieldByName('as_total_cost').AsFloat:=Order.GetSumBySum(order.dsAddServ);
      order.dsAddServ.Edit;
      order.dsAddServ.Post;
    end;
  Self.Close;
  Self.Release;
  Order.label14.OnClick(nil);
end;

procedure TAS_Edit.Button2Click(Sender: TObject);
begin
Order.dsAddServ.Cancel;
AS_Edit.Close;
AS_Edit.Release;
end;

procedure TAS_Edit.ComboBox1Change(Sender: TObject);
var
sql:string;
begin
sql:='SELECT * FROM additional_services WHERE as_name="'+combobox1.Text+'"';
fdquery2.Close;
fdquery2.SQL.Clear;
fdquery2.SQL.Add(sql);
fdquery2.Open;
Order.dsAddServ.Edit;
Order.dsAddServ.FieldByName('as_id').AsInteger:=fdquery2.FieldByName('id').AsInteger;
cost:=fdquery2.FieldByName('cost').AsFloat;
Order.dsAddServ.FieldByName('order_id').AsInteger:=Order.dsOrder.FieldByName('id').AsInteger;
Order.dsAddServ.FieldByName('as_name').AsString:=FDQuery2.FieldByName('as_name').AsString;
Order.dsAddServ.FieldByName('mesuare').AsString:=FDQuery2.FieldByName('mesuare').AsString;
Order.dsAddServ.FieldByName('cost').AsCurrency:=cost;

edit1.Text:=fdquery2.FieldByName('mesuare').AsString;
if dbedit1.Text<>'' then  dbedit1.OnChange(nil);
end;

procedure TAS_Edit.DBEdit1Change(Sender: TObject);
begin
order.dsAddServ.Edit;
order.dsAddServ.FieldByName('sum').AsFloat:=cost*strtofloatdef(dbedit1.Text,0);
end;

procedure TAS_Edit.FormActivate(Sender: TObject);
var
sql:string;
i:integer;
begin
FDQuery2.Connection:=MainForm.Connection;

sql:='SELECT as_name FROM additional_services';
fdquery2.Close;
fdquery2.SQL.Clear;
fdquery2.SQL.Add(sql);
fdquery2.Open;
for i := 1 to fdquery2.RecordCount do
  begin
  combobox1.Items.Add(fdquery2.FieldByName('as_name').AsString);
  fdquery2.Next;
  end;

if mode='edit' then
  begin
  combobox1.Text:=order.dsAddServ.FieldByName('as_name').AsString;
  combobox1.OnChange(nil);
  end;

end;

end.
