unit AddMatForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Data.DB, Data.Win.ADODB, math, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TAM_Edit = class(TForm)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DataSource1: TDataSource;
    ComboBox1: TComboBox;
    DBEdit3: TDBEdit;
    ComboBox2: TComboBox;
    Label5: TLabel;
    Edit1: TEdit;
    DBEdit4: TDBEdit;
    ListBox1: TListBox;
    FDQuery2: TFDQuery;
    FDQuery3: TFDQuery;
    FDQuery1: TFDQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AM_Edit: TAM_Edit;
  cost:real;

implementation

{$R *.dfm}

uses MainFormUnit, OrderFormUnit;

procedure TAM_Edit.Button1Click(Sender: TObject);
var
id:integer;
begin
if (combobox2.Text='') or (order.dsAddMat.FieldByName('quantity').AsFloat<=0) then
  begin
    order.dsAddMat.Cancel;
  end
else order.dsAddMat.Post;
AM_Edit.Close;
AM_Edit.Release;
Order.label23.OnClick(nil);
end;

procedure TAM_Edit.Button2Click(Sender: TObject);
begin
order.dsAddMat.Cancel;
AM_Edit.Close;
AM_Edit.Release;
end;

procedure TAM_Edit.ComboBox1Change(Sender: TObject);
var
sql:string;
i:integer;
begin
combobox2.Items.Clear;
listbox1.Items.Clear;
sql:='SELECT am_name, additional_materials.id, am_category_name FROM additional_materials, am_categories WHERE additional_materials.am_category_id=am_categories.id AND am_category_name="'+combobox1.Text+'"';
FDQuery2.Close;
FDQuery2.SQL.Clear;
FDQuery2.SQL.Add(sql);
FDQuery2.Open;
for i:=1 to FDQuery2.RecordCount do
  begin
  combobox2.Items.Add(FDQuery2.FieldByName('am_name').AsString);
  listbox1.Items.Add(FDQuery2.FieldByName('id').AsString);
  FDQuery2.Next;
  end;
Order.dsAddMat.FieldByName('am_category_name').AsString:=FDQuery2.FieldByName('am_category_name').AsString;
end;

procedure TAM_Edit.ComboBox2Change(Sender: TObject);
var
sql,id:string;
  i: Integer;
begin
for i:=0 to combobox2.Items.Count-1 do
  begin
  if combobox2.Items.Strings[i]=combobox2.Text then
    begin
    id:=listbox1.Items.Strings[i];
    break;
    end;
  end;

sql:='SELECT id, cost, cost_euro, measure, am_name FROM additional_materials WHERE id='+id;
FDQuery2.Close;
FDQuery2.SQL.Clear;
FDQuery2.SQL.Add(sql);
FDQuery2.Open;

Order.dsAddMat.Edit;
Order.dsAddMat.FieldByName('am_id').AsInteger:=FDQuery2.FieldByName('id').AsInteger;
Order.dsAddMat.FieldByName('order_id').AsInteger:=Order.dsOrder.FieldByName('id').AsInteger;
Order.dsAddMat.FieldByName('am_name').AsString:=FDQuery2.FieldByName('am_name').AsString;
Order.dsAddMat.FieldByName('measure').AsString:=FDQuery2.FieldByName('measure').AsString;
Order.dsAddMat.FieldByName('am_category_id').AsInteger:=id.ToInteger;

if FDQuery2.FieldByName('cost_euro').AsFloat>0 then cost:=roundto(FDQuery2.FieldByName('cost_euro').AsFloat*FDQuery1.FieldByName('eur_rur').AsFloat,-2)
else cost:=FDQuery2.FieldByName('cost').AsFloat;
Order.dsAddMat.FieldByName('cost').AsCurrency:=cost;

edit1.Text:=FDQuery2.FieldByName('measure').AsString;
if dbedit1.Text<>'' then  dbedit1.OnChange(nil);
end;

procedure TAM_Edit.DBEdit1Change(Sender: TObject);
begin
Order.dsAddMat.Edit;
Order.dsAddMat.FieldByName('sum').AsFloat:=cost*strtofloatdef(dbedit1.Text,0);
end;

procedure TAM_Edit.FormActivate(Sender: TObject);
var
sql:string;
i:integer;
begin
FDQuery1.Connection:=MainForm.Connection;
FDQuery2.Connection:=MainForm.Connection;
FDQuery3.Connection:=MainForm.Connection;

// курс евро
sql:='SELECT eur_rur FROM currency_exchange ORDER BY id DESC';
FDQuery1.Close;
FDQuery1.SQL.Clear;
FDQuery1.SQL.Add(sql);
FDQuery1.Open;

// список категорий
sql:='SELECT am_category_name FROM am_categories';
FDQuery2.Close;
FDQuery2.SQL.Clear;
FDQuery2.SQL.Add(sql);
FDQuery2.Open;
for i:=1 to FDQuery2.RecordCount do
  begin
  combobox1.Items.Add(FDQuery2.FieldByName('am_category_name').AsString);
  FDQuery2.Next;
  end;

if mode='edit' then
  begin
    combobox1.Text:=order.dsAddMat.FieldByName('am_category_name').AsString;
    combobox1.OnChange(nil);
    combobox2.Text:=order.dsAddMat.FieldByName('am_name').AsString;
    combobox2.OnChange(nil);
  end;

end;

end.
