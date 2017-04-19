unit CalcComp2FormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Data.DB,
  Data.Win.ADODB, math, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TCompCalc = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Edit3: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit4: TEdit;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Edit5: TEdit;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    Label13: TLabel;
    ComboBox7: TComboBox;
    ComboBox8: TComboBox;
    StringGrid1: TStringGrid;
    Label14: TLabel;
    Edit6: TEdit;
    Label15: TLabel;
    FDQuery1: TFDQuery;
    procedure Button1Click(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompCalc: TCompCalc;

implementation

{$R *.dfm}

uses MainFormUnit;

procedure TCompCalc.Button1Click(Sender: TObject);
begin
CompCalc.Close;
CompCalc.Release;
end;

procedure TCompCalc.ComboBox1Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.ComboBox2Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.ComboBox3Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.ComboBox4Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.ComboBox5Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.ComboBox6Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.ComboBox7Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.ComboBox8Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.Edit1Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.Edit2Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.Edit3Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.Edit4Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.Edit5Change(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TCompCalc.FormActivate(Sender: TObject);
begin
  FDQuery1.Connection:=MainForm.Connection;

stringgrid1.ColWidths[0]:=100;
stringgrid1.ColWidths[1]:=190;
stringgrid1.ColWidths[2]:=30;
stringgrid1.ColWidths[3]:=60;
stringgrid1.ColWidths[4]:=35;
stringgrid1.Cells[0,0]:='������';
stringgrid1.Cells[1,0]:='��������';
stringgrid1.Cells[2,0]:='���.';
stringgrid1.Cells[3,0]:='��.';
stringgrid1.Cells[4,0]:='����';
end;

procedure TCompCalc.Label14Click(Sender: TObject);
var
total,vol,cost,c11,c33,c23,c24,c31,c68,c30,c44,c45,c47,c46,c27,c35,c37,c39,c40,c48:real;
sql:string;
begin
sql:='SELECT * FROM component_price';
FDQuery1.Close;
FDQuery1.SQL.Clear;
FDQuery1.SQL.Add(sql);
FDQuery1.Open;
stringgrid1.RowCount:=2;
stringgrid1.Cells[0,1]:='';
total:=0;

FDQuery1.Locate('c_code','PFJ2466',[]);
vol:=ceil(strtofloatdef(edit1.Text,0)/FDQuery1.FieldByName('unit').AsFloat*100)/100;
c11:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[6,32m bars]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PFJ2464',[]);
if combobox4.Text='���' then
  vol:=ceil(strtofloatdef(edit1.Text,0)/FDQuery1.FieldByName('unit').AsFloat*100)/100
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[6,32m bars]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PFJ6072',[]);
if combobox4.Text='��' then
  vol:=ceil(strtofloatdef(edit1.Text,0)/FDQuery1.FieldByName('unit').AsFloat*100)/100
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[6,32m bars]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PFJ2467',[]);
if combobox3.Text='6' then
  vol:=ceil(strtofloatdef(edit1.Text,0)/FDQuery1.FieldByName('unit').AsFloat*2*100)/100
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[6,32m bars]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PFJ2469',[]);
if combobox3.Text='8' then
  vol:=ceil(strtofloatdef(edit1.Text,0)/FDQuery1.FieldByName('unit').AsFloat*2*100)/100
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[6,32m bars]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PFJ2468',[]);
if combobox3.Text='10' then
  vol:=ceil(strtofloatdef(edit1.Text,0)/FDQuery1.FieldByName('unit').AsFloat*2*100)/100
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[6,32m bars]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PFJ2465',[]);
if combobox5.Text='��' then
  vol:=ceil(strtofloatdef(edit1.Text,0)/FDQuery1.FieldByName('unit').AsFloat*100)/100
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[6,32m bars]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PFJ13108000B',[]);
if combobox2.Text='��' then
  vol:=ceil(strtofloatdef(edit2.Text,0)/FDQuery1.FieldByName('unit').AsFloat*2*100)/100
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[6,32m bars]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','CSF47X10-4PBK',[]);
vol:=ceil(4*c11*6320/1000);
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[m]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','CABLEINOX',[]);
if combobox7.Text='����� ������������' then
  vol:=0
else vol:=floor(strtofloatdef(edit2.Text,0)/1000*10)/10;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[m]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','CLICK-MRSP10',[]);
vol:=strtofloatdef(edit4.Text,0);
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1000',[]);
vol:=strtofloatdef(edit4.Text,0);
c23:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1001',[]);
vol:=strtofloatdef(edit4.Text,0);
c24:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1002',[]);
vol:=strtofloatdef(edit4.Text,0);
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1003',[]);
vol:=ceil(strtofloatdef(edit3.Text,0)/10);
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1004',[]);
vol:=strtofloatdef(edit3.Text,0);
c27:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1005',[]);
vol:=strtofloatdef(edit4.Text,0);
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1006',[]);
vol:=ceil(strtofloatdef(edit1.Text,0)/800)+2;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1007',[]);
vol:=strtofloatdef(edit4.Text,0);
c30:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1008',[]);
vol:=strtofloatdef(edit3.Text,0);
c31:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1009',[]);
vol:=strtofloatdef(edit3.Text,0)*4;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1010',[]);
if combobox2.Text='��' then
  vol:=0
else vol:=2;
c33:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1011',[]);
vol:=c33;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1012',[]);
if combobox4.Text='��' then
  vol:=0
else vol:=strtofloatdef(edit4.Text,0);
c35:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1013',[]);
vol:=c23;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1014',[]);
if combobox7.Text='����� ������������' then
  vol:=0
else
  if combobox6.Text='���' then vol:=c24*2 else vol:=0;
c37:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','PLMD1015',[]);
vol:=c31;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���������� ������ ��������',[]);
if combobox4.Text='���' then vol:=0
else vol:=strtofloatdef(edit4.Text,0);
c39:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','����. �������',[]);
if combobox7.Text='����� ������������' then vol:=0
else
  if combobox6.Text='��' then vol:=c24*2 else vol:=0;
c40:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������� 6 MM',[]);
if combobox3.Text='6' then vol:=4*strtofloatdef(edit3.Text,0)
  else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������� 8 MM',[]);
if combobox3.Text='8' then vol:=4*strtofloatdef(edit3.Text,0)
  else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������� 10 MM',[]);
if combobox3.Text='10' then vol:=4*strtofloatdef(edit3.Text,0)
  else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���������� ������',[]);
vol:=3*strtofloatdef(edit3.Text,0);
c44:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','ZMK1001',[]);
vol:=strtofloatdef(edit3.Text,0);
c45:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('c_code','ZMK1002',[]);
vol:=strtofloatdef(edit3.Text,0);
c46:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','�������',[]);
vol:=strtofloatdef(edit3.Text,0);
c47:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������ ��������� ��������',[]);
vol:=strtofloatdef(edit5.Text,0);
c48:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������� ��������� ��������',[]);
vol:=strtofloatdef(edit5.Text,0);
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������',[]);
if strtofloatdef(edit2.Text,0)<1801 then vol:=2*(strtointdef(edit3.Text,0)-1)
  else vol:=4*(strtointdef(edit3.Text,0)-1);
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','��� ����������',[]);
vol:=4*strtofloatdef(edit3.Text,0);
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','�����',[]);
vol:=ceil(strtofloatdef(edit1.Text,0)*2/300000*100)/100;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[litres]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���������� ����',[]);
if combobox3.Text='6' then vol:=strtofloatdef(edit1.Text,0)*2/6000
  else if combobox3.Text='8' then vol:=strtofloatdef(edit1.Text,0)*2/5000 else vol:=strtofloatdef(edit1.Text,0)*2/4000;
vol:=ceil(vol*100)/100;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[tubes]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������� �����',[]);
vol:=1;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','�����-����� ����',[]);
if combobox7.Text='����� ������������' then vol:=strtofloatdef(edit4.Text,0)
  else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���������� ��� �����',[]);
if combobox8.Text='���������� ��� �����' then vol:=strtofloatdef(edit4.Text,0) else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','�����-������ 1',[]);
if combobox7.Text='�����-������ 1' then vol:=strtofloatdef(edit4.Text,0) else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','�����-������ 2',[]);
if combobox7.Text='�����-������ 2' then vol:=strtofloatdef(edit4.Text,0) else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','�����',[]);
if combobox8.Text='�����' then vol:=strtofloatdef(edit4.Text,0) else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������ ���������� 6/8 MM',[]);
if combobox3.Text='10' then vol:=0
  else vol:=strtofloatdef(edit3.Text,0)-1;
cost:=vol*FDQuery1.FieldByName('price').AsFloat*2.5;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[2,5 m long seal]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','������ ���������� 10/12 MM',[]);
if combobox3.Text='10' then vol:=strtofloatdef(edit3.Text,0)-1
  else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat*3;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[3 m long seal]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','����������-�������� 6 MM',[]);
if combobox3.Text='6' then
  if strtofloatdef(edit4.Text,0)=1 then vol:=1 else vol:=0
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat*2.5;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[2,5 m long seal]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','����������-�������� 8 MM',[]);
if combobox3.Text='8' then
  if strtofloatdef(edit4.Text,0)=1 then vol:=1 else vol:=0
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat*2.5;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[2,5 m long seal]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','����������-�������� 10 MM',[]);
if combobox3.Text='10' then
  if strtofloatdef(edit4.Text,0)=1 then vol:=1 else vol:=0
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat*3;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[3 m long seal]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���������� � �������������� �������� 6 MM',[]);
if combobox3.Text='6' then
  if strtofloatdef(edit4.Text,0)=1 then vol:=1 else vol:=2
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat*2.5;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[2,5 m long seal]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���������� � �������������� �������� 8 MM',[]);
if combobox3.Text='8' then
  if strtofloatdef(edit4.Text,0)=1 then vol:=1 else vol:=2
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat*2.5;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[2,5 m long seal]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���������� � �������������� �������� 10 MM',[]);
if combobox3.Text='10' then
  if strtofloatdef(edit4.Text,0)=1 then vol:=1 else vol:=2
else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat*3;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[3 m long seal]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� �����������',[]);
vol:=2+2*strtofloatdef(edit5.text,0)+strtofloatdef(edit4.text,0)+strtofloatdef(edit3.text,0)-1;
c68:=vol;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','����� �����������',[]);
vol:=c68;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 4,2 x 38',[]);
if combobox2.text='��' then vol:=14 else vol:=0;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 4,2 x 13',[]);
vol:=5*c24;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� ��������� ����������',[]);
vol:=2*c23;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 6x12 (��� �������)',[]);
vol:=c44+c30;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 6x65',[]);
vol:=c45+c47;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 6x35',[]);
vol:=c46;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 5x30',[]);
vol:=c31;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 5x8',[]);
vol:=c27;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 2,9 x 6,5',[]);
vol:=2*C37+2*C40;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� 6 x 12',[]);
vol:=4*C48;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

FDQuery1.Locate('component_ru','���� ��� ������ ��������',[]);
vol:=2*C35+4*C39;
cost:=vol*FDQuery1.FieldByName('price').AsFloat;
if vol>0 then
  begin
  if length(stringgrid1.Cells[0,1])>0 then stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid1.Cells[0,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('c_code').AsString;
  stringgrid1.Cells[1,stringgrid1.RowCount-1]:=FDQuery1.FieldByName('component_ru').AsString;
  stringgrid1.Cells[2,stringgrid1.RowCount-1]:=floattostr(vol);
  stringgrid1.Cells[3,stringgrid1.RowCount-1]:='[units]';
  stringgrid1.Cells[4,stringgrid1.RowCount-1]:=floattostr(cost);
  total:=total+cost;
  end;

edit6.Text:=floattostr(total);
end;

end.
