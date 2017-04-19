unit OrderFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB, Data.Win.ADODB, math, Vcl.Mask,
  Vcl.DBGrids, ComObj, ShellAPI, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client
  ,API_MVC, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TOrder = class(TViewAbstract)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBComboBox1: TDBComboBox;
    Label14: TLabel;
    Label15: TLabel;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    DBEdit1: TDBEdit;
    DBComboBox2: TDBComboBox;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBGrid1: TDBGrid;
    GroupBox4: TGroupBox;
    DataSource2: TDataSource;
    Label2: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    Label23: TLabel;
    DBGrid2: TDBGrid;
    GroupBox5: TGroupBox;
    Label24: TLabel;
    DBEdit16: TDBEdit;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    DataSource3: TDataSource;
    TabSheet6: TTabSheet;
    GroupBox6: TGroupBox;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    GroupBox7: TGroupBox;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    GroupBox8: TGroupBox;
    Label38: TLabel;
    DBComboBox3: TDBComboBox;
    DBEdit27: TDBEdit;
    Label39: TLabel;
    Label40: TLabel;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    Label41: TLabel;
    GroupBox9: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    DateTimePicker1: TDateTimePicker;
    GroupBox10: TGroupBox;
    Label48: TLabel;
    DBGrid3: TDBGrid;
    DataSource4: TDataSource;
    Label49: TLabel;
    Label50: TLabel;
    GroupBox11: TGroupBox;
    DBEdit34: TDBEdit;
    Label46: TLabel;
    DBEdit33: TDBEdit;
    Label45: TLabel;
    DBEdit32: TDBEdit;
    Label44: TLabel;
    GroupBox12: TGroupBox;
    DBEdit35: TDBEdit;
    Label47: TLabel;
    Label51: TLabel;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBMemo1: TDBMemo;
    Label59: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    DBEdit38: TDBEdit;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    DBEdit39: TDBEdit;
    Label65: TLabel;
    dsOrder: TFDQuery;
    dsAddMat: TFDQuery;
    dsAddServ: TFDQuery;
    dsOrderDocNum: TFDQuery;
    dsOrderDoc: TFDQuery;
    lblChooseCustomer: TLabel;
    dsCustomer: TFDQuery;
    DataSource5: TDataSource;
    lblNewCustomer: TLabel;
    lblId: TLabel;
    dbtxtCustomerId: TDBText;
    FDUpdateSQL1: TFDUpdateSQL;
    TabSheet7: TTabSheet;
    dbgrdHistory: TDBGrid;
    dsHistory: TFDQuery;
    dsrHistory: TDataSource;
    lblEuroRate: TLabel;
    dbtxtEuroRate: TDBText;
    lblRateUpdate: TLabel;
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure Label14Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure DBComboBox2Change(Sender: TObject);
    procedure DBEdit4Change(Sender: TObject);
    procedure DBEdit7Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label16MouseEnter(Sender: TObject);
    procedure Label16MouseLeave(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label17MouseEnter(Sender: TObject);
    procedure Label17MouseLeave(Sender: TObject);
    procedure Label17Click(Sender: TObject);
    procedure Label23Click(Sender: TObject);
    procedure DBEdit12Change(Sender: TObject);
    procedure Label25MouseEnter(Sender: TObject);
    procedure Label25MouseLeave(Sender: TObject);
    procedure Label25Click(Sender: TObject);
    procedure Label26MouseEnter(Sender: TObject);
    procedure Label26MouseLeave(Sender: TObject);
    procedure Label26Click(Sender: TObject);
    procedure Label27Click(Sender: TObject);
    procedure Label27MouseEnter(Sender: TObject);
    procedure Label27MouseLeave(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure Label48MouseEnter(Sender: TObject);
    procedure Label48MouseLeave(Sender: TObject);
    procedure Label48Click(Sender: TObject);
    procedure Label49MouseEnter(Sender: TObject);
    procedure Label49MouseLeave(Sender: TObject);
    procedure Label50MouseEnter(Sender: TObject);
    procedure Label50MouseLeave(Sender: TObject);
    procedure Label50Click(Sender: TObject);
    procedure Label49Click(Sender: TObject);
    procedure Label53MouseEnter(Sender: TObject);
    procedure Label53MouseLeave(Sender: TObject);
    procedure Label53Click(Sender: TObject);
    procedure Label54Click(Sender: TObject);
    procedure Label54MouseEnter(Sender: TObject);
    procedure Label54MouseLeave(Sender: TObject);
    procedure Label55MouseEnter(Sender: TObject);
    procedure Label55MouseLeave(Sender: TObject);
    procedure Label55Click(Sender: TObject);
    procedure Label56MouseEnter(Sender: TObject);
    procedure Label56MouseLeave(Sender: TObject);
    procedure Label56Click(Sender: TObject);
    procedure Label57MouseEnter(Sender: TObject);
    procedure Label57MouseLeave(Sender: TObject);
    procedure Label57Click(Sender: TObject);
    procedure Label58MouseEnter(Sender: TObject);
    procedure Label58MouseLeave(Sender: TObject);
    procedure Label58Click(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure DBCheckBox2Click(Sender: TObject);
    procedure DBCheckBox3Click(Sender: TObject);
    procedure Label60MouseEnter(Sender: TObject);
    procedure Label60MouseLeave(Sender: TObject);
    procedure Label60Click(Sender: TObject);
    procedure Label61MouseEnter(Sender: TObject);
    procedure Label61MouseLeave(Sender: TObject);
    procedure Label61Click(Sender: TObject);
    procedure Label62MouseEnter(Sender: TObject);
    procedure Label62MouseLeave(Sender: TObject);
    procedure Label62Click(Sender: TObject);
    procedure Label63MouseEnter(Sender: TObject);
    procedure Label63MouseLeave(Sender: TObject);
    procedure Label63Click(Sender: TObject);
    procedure Label64MouseEnter(Sender: TObject);
    procedure Label64MouseLeave(Sender: TObject);
    procedure Label64Click(Sender: TObject);
    procedure lblChooseCustomerMouseEnter(Sender: TObject);
    procedure lblChooseCustomerMouseLeave(Sender: TObject);
    procedure lblChooseCustomerClick(Sender: TObject);
    procedure dsAddServAfterOpen(DataSet: TDataSet);
    procedure lblNewCustomerMouseEnter(Sender: TObject);
    procedure lblNewCustomerMouseLeave(Sender: TObject);
    procedure lblNewCustomerClick(Sender: TObject);
    procedure dbgrdHistoryTitleClick(Column: TColumn);
    procedure lblRateUpdateMouseEnter(Sender: TObject);
    procedure lblRateUpdateMouseLeave(Sender: TObject);
    procedure lblRateUpdateClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitMVC; override;
    procedure CheckEuroRateForControl;
    procedure PutDocToServer(aTempFileName, aFileName: String);
    function SetTempFileName(aFileName: String): string;
    function SetDocFileName(aFileName, aExt: String): string;
    function GetDocTemplate(aTemplateFileName: string): string;
    function GetCurrentEuroRate: Currency;
  public
    { Public declarations }
    function GetSumBySum(dsQuery: TFDQuery): Currency;
  end;

var
  Order: TOrder;
  MSWord: variant;


implementation

{$R *.dfm}

uses MainFormUnit, AddMatForm, AddServForm, FullSum
  ,CustomersFormUnit
  ,PriceListASUnit
  ,Controllers;

procedure TOrder.PutDocToServer(aTempFileName, aFileName: String);
begin
  MainForm.IdFTP.Put(aTempFileName, '���������\'+aFileName);
end;

function TOrder.SetDocFileName(aFileName, aExt: string): string;
var
  sql: string;
begin
  aFileName:=aFileName+'_';
  sql:='SELECT id FROM documents WHERE doc_type LIKE "'+aFileName+'%"';
  dsOrderDocNum.Close;
  dsOrderDocNum.SQL.Clear;
  dsOrderDocNum.SQL.Add(sql);
  dsOrderDocNum.Open;
  dsOrderDocNum.FetchAll;
  Result:=aFileName+(dsOrderDocNum.RecordCount+1).ToString+aExt;
end;

function TOrder.SetTempFileName(aFileName: string): string;
var
  s: string;
begin
  s:=GetCurrentDir+'\TempFiles\'+aFileName;
  if FileExists(s) then DeleteFile(s);
  Result:=s;
end;

function TOrder.GetDocTemplate(aTemplateFileName: string): string;
begin
  Result:='TempFiles\TempTemplate'+ExtractFileExt(aTemplateFileName);
  if FileExists(Result) then DeleteFile(Result);
  MainForm.IdFTP.Get('\�������\'+aTemplateFileName, Result);
  Result:=GetCurrentDir+'\'+Result;
end;

function TOrder.GetCurrentEuroRate: Currency;
var
  sql: String;
begin
  sql:='SELECT eur_rur FROM currency_exchange ORDER BY id DESC';
  dsOrderDocNum.Close;
  dsOrderDocNum.SQL.Clear;
  dsOrderDocNum.SQL.Add(sql);
  dsOrderDocNum.Open;
  Result:=dsOrderDocNum.FieldByName('eur_rur').AsCurrency;
end;

procedure TOrder.CheckEuroRateForControl;
begin
  if dsOrder.FieldByName('ce_on_calc_day').AsCurrency<>Self.GetCurrentEuroRate then
    lblRateUpdate.Visible:=True
  else lblRateUpdate.Visible:=False;
end;

procedure TOrder.InitMVC;
begin
  FControllerClass:=TController;
end;

function TOrder.GetSumBySum(dsQuery: TFDQuery): Currency;
var
  dsMemTable: TFDMemTable;
begin
  Result:=0;
  dsMemTable:=TFDMemTable.Create(nil);
  try
    if dsQuery.Active then
      begin
        dsMemTable.CloneCursor(dsQuery, True, False);
        While not dsMemTable.Eof do
          begin
            Result:=Result + dsMemTable.FieldByName('sum').AsCurrency;
            dsMemTable.Next;
          end;
      end;
  finally
    dsMemTable.Free;
  end;
end;

function FindAndReplace(const FindText,ReplaceText:string):boolean;
  const wdReplaceAll = 2;
begin
  MSWord.Selection.Find.MatchSoundsLike := False;
  MSWord.Selection.Find.MatchAllWordForms := False;
  MSWord.Selection.Find.MatchWholeWord := False;
  MSWord.Selection.Find.Format := False;
  MSWord.Selection.Find.Forward := True;
  MSWord.Selection.Find.ClearFormatting;
  MSWord.Selection.Find.Text:=FindText;
  MSWord.Selection.Find.Replacement.Text:=ReplaceText;
  FindAndReplace:=MSWord.Selection.Find.Execute(Replace:=wdReplaceAll);
end;

procedure TOrder.dbgrdHistoryTitleClick(Column: TColumn);
begin
  dsHistory.IndexFieldNames:=Column.FieldName;
end;

procedure TOrder.dsAddServAfterOpen(DataSet: TDataSet);
var
sql:string;
begin
if view_only='no' then
begin
dsOrder.Edit;

// ����� �����
dsOrder.FieldByName('order_total_cost').AsFloat:=dsOrder.FieldByName('cost_w_discount').AsFloat+dsOrder.FieldByName('install_cost').AsFloat+dsOrder.FieldByName('am_cost_w_discount').AsFloat+dsOrder.FieldByName('am_install_cost').AsFloat+dsOrder.FieldByName('as_total_cost').AsFloat;
dsOrder.FieldByName('m_for_contract').AsFloat:=dsOrder.FieldByName('cost_w_discount').AsFloat+dsOrder.FieldByName('am_cost_w_discount').AsFloat+dsOrder.FieldByName('as_total_cost').AsFloat;
dsOrder.FieldByName('vat_m_for_contract').AsFloat:=roundto(dsOrder.FieldByName('m_for_contract').AsFloat/118*18,-2);
dsOrder.FieldByName('w_for_contract').AsFloat:=dsOrder.FieldByName('install_cost').AsFloat+dsOrder.FieldByName('am_install_cost').AsFloat;
dsOrder.FieldByName('vat_w_for_contract').AsFloat:=roundto(dsOrder.FieldByName('w_for_contract').AsFloat/118*18,-2);
end;
end;

procedure TOrder.Button1Click(Sender: TObject);
var
id,sql:string;
i:integer;
begin
dsCustomer.Edit;
dsOrder.Edit;

dsCustomer.Post;
dsOrder.FieldByName('customer_id').AsInteger:=dsCustomer.FieldByName('id').AsInteger;
if mode='append' then dsOrder.FieldByName('user_id').AsInteger:=TController(Self.FController).UserId;
dsOrder.Post;

id:=dsOrder.FieldByName('id').AsString;
mainForm.dsOrders.Close;
mainForm.dsOrders.Open;
mainForm.dsOrders.Locate('id',id,[]);

// ���������� ������� constructions
sql:='DELETE FROM constructions WHERE order_id='+id;
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ExecSQL;
for i:=1 to stringgrid1.ColCount-1 do
  begin
  sql:='INSERT INTO constructions (order_id, con_id, flap_count, width, height) VALUES ('+id+','+inttostr(strtointdef(stringgrid1.Cells[i,0],0))+','+inttostr(strtointdef(stringgrid1.Cells[i,3],0))+','+inttostr(strtointdef(stringgrid1.Cells[i,1],0))+','+inttostr(strtointdef(stringgrid1.Cells[i,2],0))+')';
  dsOrderDocNum.Close;
  dsOrderDocNum.SQL.Clear;
  dsOrderDocNum.SQL.Add(sql);
  dsOrderDocNum.ExecSQL;
  end;

// ���������� ���. ����������
if mode='append' then
  begin
    dsAddMat.Edit;
    dsAddMat.First;
    while not dsAddMat.Eof do
      begin
        dsAddMat.Edit;
        dsAddMat.FieldByName('order_id').AsInteger:=id.ToInteger;
        dsAddMat.Post;
        dsAddMat.Next;
      end;
  end;
sql:='INSERT INTO am_orders (order_id, am_id, quantity, sum) VALUES ('+id+', :new_am_id, :new_quantity, :new_sum)';
FDUpdateSQL1.InsertSQL.Text:=sql;
sql:='UPDATE am_orders SET order_id = '+id+', am_id = :new_am_id, quantity = :new_quantity, sum = :new_sum WHERE id = :old_id';
FDUpdateSQL1.ModifySQL.Text:=sql;
sql:='DELETE FROM am_orders WHERE id = :old_id';
FDUpdateSQL1.DeleteSQL.Text:=sql;
dsAddMat.UpdateOptions.UpdateNonBaseFields:=False;
dsAddMat.ApplyUpdates(0);

// ���������� ������ ������ � ������ ���. �����
if mode='append' then
  begin
    dsAddServ.Edit;
    dsAddServ.First;
    while not dsAddServ.Eof do
      begin
        dsAddServ.Edit;
        dsAddServ.FieldByName('order_id').AsInteger:=id.ToInteger;
        dsAddServ.Post;
        dsAddServ.Next;
      end;
  end;
sql:='INSERT INTO bezram.as_orders (order_id, as_id, quantity, sum) VALUES ('+id+', :new_as_id, :new_quantity, :new_sum)';
FDUpdateSQL1.InsertSQL.Text:=sql;
sql:='UPDATE bezram.as_orders SET order_id = '+id+', as_id = :new_as_id, quantity = :new_quantity, sum = :new_sum WHERE id = :old_id';
FDUpdateSQL1.ModifySQL.Text:=sql;
sql:='DELETE FROM bezram.as_orders WHERE id = :old_id';
FDUpdateSQL1.DeleteSQL.Text:=sql;
dsAddServ.UpdateOptions.UpdateNonBaseFields:=False;
dsAddServ.ApplyUpdates(0);

// ���������� ������ ������ � ���������
sql:='UPDATE documents SET order_id='+id+' WHERE order_id=0';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ExecSQL;

// ����� �������
sql:='INSERT INTO order_history SET order_id=:order_id, user_id=:user_id, date=:date, operation=:operation';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('order_id').AsInteger:=id.ToInteger;
dsOrderDocNum.ParamByName('user_id').AsInteger:=TController(Self.FController).UserId;
dsOrderDocNum.ParamByName('date').AsDateTime:=Now;
if mode='append' then dsOrderDocNum.ParamByName('operation').AsString:='��������';
if mode='edit' then dsOrderDocNum.ParamByName('operation').AsString:='��������������';
dsOrderDocNum.ExecSQL;

button2.Click;
end;

procedure TOrder.Button2Click(Sender: TObject);
begin
dsOrder.Cancel;
Order.Close;
Order.Release;
end;

procedure TOrder.CheckBox2Click(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.CheckBox3Click(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.CheckBox4Click(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.CheckBox5Click(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.ComboBox2Change(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.DateTimePicker1Change(Sender: TObject);
begin
if dsOrder.State=dsbrowse then dsOrder.Edit;
dsOrder.FieldByName('order_date').AsDateTime:=datetimepicker1.DateTime;
end;

procedure TOrder.DBCheckBox1Click(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TOrder.DBCheckBox2Click(Sender: TObject);
begin
label14.OnClick(nil);
end;

procedure TOrder.DBCheckBox3Click(Sender: TObject);
begin
label23.OnClick(nil);
end;

procedure TOrder.DBComboBox1Change(Sender: TObject);
var
i,delta,sp,stv_count:integer;
w,sq:real;
begin
stringgrid1.ColCount:=strtointdef(dbcombobox1.Text,1)+1;

stv_count:=0;
for i:=1 to stringgrid1.ColCount-1 do
  begin
  stringgrid1.Cells[i,0]:=inttostr(i);
  stringgrid1.Cells[i,3]:=floattostr(round(strtofloatdef(stringgrid1.Cells[i,1],0)/1000/0.75));
  stv_count:=stv_count+round(strtofloatdef(stringgrid1.Cells[i,3],0));
  end;
stringgrid1.RowCount:=4;
stringgrid1.FixedCols:=1;
stringgrid1.FixedRows:=1;
stringgrid1.ColWidths[0]:=80;
stringgrid1.Cells[0,0]:='�����������';
stringgrid1.Cells[0,1]:='�����, ��.';
stringgrid1.Cells[0,2]:='������, ��.';
stringgrid1.Cells[0,3]:='�������';

// ����������
image1.Canvas.FillRect(canvas.ClipRect);
delta:=round(270/strtointdef(dbcombobox1.Text,1));
sp:=10;
for i:=1 to strtointdef(dbcombobox1.Text,1) do
  begin
  image1.Canvas.Pen.Width:=3;
  image1.Canvas.Brush.Color:=clskyblue;
  image1.Canvas.Polygon([point(sp,30),point(sp,200),point(sp+delta,200),point(sp+delta,30)]);

  image1.Canvas.Pen.Width:=1;
  image1.Canvas.Polyline([point(sp,200),point(sp,230)]);
  image1.Canvas.Polyline([point(sp+delta,200),point(sp+delta,230)]);

  image1.Canvas.Polyline([point(sp+delta,200),point(sp+delta+30,200)]);
  image1.Canvas.Polyline([point(sp+delta,30),point(sp+delta+30,30)]);

  image1.Canvas.Polyline([point(sp,228),point(sp+delta,228)]);
  image1.Canvas.Polyline([point(sp,228),point(sp+8,222)]);
  image1.Canvas.Polyline([point(sp,228),point(sp+8,234)]);

  image1.Canvas.Polyline([point(sp+delta,228),point(sp-8+delta,222)]);
  image1.Canvas.Polyline([point(sp+delta,228),point(sp-8+delta,234)]);

  image1.Canvas.Polyline([point(sp+delta+28,30),point(sp+delta+28,200)]);
  image1.Canvas.Polyline([point(sp+delta+28,30),point(sp+delta+22,38)]);
  image1.Canvas.Polyline([point(sp+delta+28,30),point(sp+delta+34,38)]);

  image1.Canvas.Polyline([point(sp+delta+28,200),point(sp+delta+22,192)]);
  image1.Canvas.Polyline([point(sp+delta+28,200),point(sp+delta+34,192)]);

  image1.Canvas.TextOut(sp-20+round(delta/2),110,'������.'+inttostr(i));
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.TextOut(sp-8+round(delta/2),210,stringgrid1.Cells[i,1]);
  image1.Canvas.TextOut(sp+3+round(delta),110,stringgrid1.Cells[i,2]);

  sp:=sp+delta+40;
  end;

// ����� ����� � �������
w:=0;
sq:=0;
for i:=1 to stringgrid1.ColCount-1 do
  begin
  if strtofloatdef(stringgrid1.Cells[i,1],0)>0 then w:=w+strtofloatdef(stringgrid1.Cells[i,1],0);
  sq:=sq+strtofloatdef(stringgrid1.Cells[i,1],0)*strtofloatdef(stringgrid1.Cells[i,2],0);
  end;

if dsOrder.State=dsbrowse then dsOrder.Edit;
dsOrder.FieldByName('width').AsFloat:=w;
dsOrder.FieldByName('square').AsFloat:=sq/1000000;

// �������
dsOrder.FieldByName('glass_count').AsInteger:=stv_count;
dsOrder.FieldByName('mov_count').AsInteger:=dsOrder.FieldByName('glass_count').AsInteger-strtointdef(dbedit4.Text,0);

if (mode='edit') or (mode='append') then label14.OnClick(nil);
end;

procedure TOrder.DBComboBox2Change(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.DBEdit12Change(Sender: TObject);
begin
label23.OnClick(nil);
end;

procedure TOrder.DBEdit4Change(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.DBEdit7Change(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.Edit1Change(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.Edit3Change(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.Edit7Change(Sender: TObject);
begin
dbcombobox1.OnChange(nil);
end;

procedure TOrder.FormActivate(Sender: TObject);
var
sql:string;
i:integer;
begin
dsOrder.Connection:=MainForm.Connection;
dsAddMat.Connection:=MainForm.Connection;
dsAddServ.Connection:=MainForm.Connection;
dsOrderDocNum.Connection:=MainForm.Connection;
dsOrderDoc.Connection:=MainForm.Connection;
dsCustomer.Connection:=MainForm.Connection;
dsHistory.Connection:=MainForm.Connection;
FDUpdateSQL1.Connection:=MainForm.Connection;

if mode='append' then
  begin
  order_id:=0;

  sql:='SELECT * FROM orders WHERE id='+inttostr(order_id);
  dsOrder.Close;
  dsOrder.SQL.Clear;
  dsOrder.SQL.Add(sql);
  dsOrder.Open;
  dsOrder.Edit;
  dsOrder.FieldByName('glass_thick').AsInteger:=10;

  // ������
  sql:='SELECT * FROM customers WHERE id=0';
  dsCustomer.Close;
  dsCustomer.SQL.Clear;
  dsCustomer.SQL.Add(sql);
  dsCustomer.Open;
  dsCustomer.Edit;

  // ��� ���������
  sql:='SELECT * FROM am_orders, additional_materials, am_categories WHERE additional_materials.am_category_id=am_categories.id AND am_orders.am_id=additional_materials.id AND am_orders.id=0';
  dsAddMat.Close;
  dsAddMat.SQL.Clear;
  dsAddMat.SQL.Add(sql);
  dsAddMat.Open;
  Label23.OnClick(nil);

  // ��� �������
  sql:='SELECT * FROM as_orders, additional_services WHERE as_orders.as_id=additional_services.id AND order_id='+inttostr(order_id);
  dsAddServ.Close;
  dsAddServ.SQL.Clear;
  dsAddServ.SQL.Add(sql);
  dsAddServ.Open;

  // ����� �������� � ����
  sql:='SELECT max(id) FROM orders';
  dsOrderDocNum.Close;
  dsOrderDocNum.SQL.Clear;
  dsOrderDocNum.SQL.Add(sql);
  dsOrderDocNum.Open;
  dsOrder.FieldByName('contract_num').AsString:=inttostr(dsOrderDocNum.Fields[0].AsInteger+1);
  datetimepicker1.DateTime:=date;
  dsOrder.FieldByName('order_date').AsDateTime:=datetimepicker1.Date;

  // ���������
  sql:='SELECT * FROM documents WHERE order_id='+inttostr(order_id);
  dsOrderDoc.Close;
  dsOrderDoc.SQL.Clear;
  dsOrderDoc.SQL.Add(sql);
  dsOrderDoc.Open;

  // �������
  dsOrder.FieldByName('is_no_install').AsBoolean:=false;
  dsOrder.FieldByName('is_no_am_install').AsBoolean:=false;
  dsCustomer.FieldByName('is_dealer').AsBoolean:=false;
  dsOrder.FieldByName('system_type').AsString:='STANDART';
  radiobutton1.Checked:=true;
  end;

if mode='edit' then
  begin
  order_id:=mainForm.dsOrders.FieldByName('id').AsInteger;

  sql:='SELECT * FROM orders WHERE id='+inttostr(order_id);
  dsOrder.Close;
  dsOrder.SQL.Clear;
  dsOrder.SQL.Add(sql);
  dsOrder.Open;
  dsOrder.Edit;

  // ������
  sql:='SELECT * FROM customers WHERE id='+dsOrder.FieldByName('customer_id').AsString;
  dsCustomer.Close;
  dsCustomer.SQL.Clear;
  dsCustomer.SQL.Add(sql);
  dsCustomer.Open;

  sql:='SELECT * FROM constructions WHERE order_id='+inttostr(order_id);
  dsOrderDocNum.Close;
  dsOrderDocNum.SQL.Clear;
  dsOrderDocNum.SQL.Add(sql);
  dsOrderDocNum.Open;

  for i:=1 to dsOrderDocNum.RecordCount do
    begin
    stringgrid1.ColCount:=dsOrderDocNum.RecordCount+1;
    stringgrid1.Cells[i,0]:=dsOrderDocNum.FieldByName('con_id').AsString;
    stringgrid1.Cells[i,3]:=dsOrderDocNum.FieldByName('flap_count').AsString;
    stringgrid1.Cells[i,1]:=dsOrderDocNum.FieldByName('width').AsString;
    stringgrid1.Cells[i,2]:=dsOrderDocNum.FieldByName('height').AsString;
    dsOrderDocNum.Next;
    end;
  dbcombobox1.OnChange(nil);

  // ��� ���������
  sql:='SELECT * FROM am_orders, additional_materials, am_categories WHERE additional_materials.am_category_id=am_categories.id AND am_orders.am_id=additional_materials.id AND order_id='+inttostr(order_id);
  dsAddMat.Close;
  dsAddMat.SQL.Clear;
  dsAddMat.SQL.Add(sql);
  dsAddMat.Open;
  Label23.OnClick(nil);

  // ��� �������
  sql:='SELECT * FROM as_orders, additional_services WHERE as_orders.as_id=additional_services.id AND order_id='+inttostr(order_id);
  dsAddServ.Close;
  dsAddServ.SQL.Clear;
  dsAddServ.SQL.Add(sql);
  dsAddServ.Open;

    // ���������
  sql:='SELECT * FROM documents WHERE order_id='+inttostr(order_id);
  dsOrderDoc.Close;
  dsOrderDoc.SQL.Clear;
  dsOrderDoc.SQL.Add(sql);
  dsOrderDoc.Open;

  datetimepicker1.DateTime:=dsOrder.FieldByName('order_date').AsDateTime;

  // �������
  if dsOrder.FieldByName('system_type').AsString='STANDART' then radiobutton1.Checked:=true
  else radiobutton2.Checked:=true;

  end;

// �������
sql:='SELECT * FROM order_history JOIN users ON order_history.user_id=users.id WHERE order_id='+inttostr(order_id);
dsHistory.Close;
dsHistory.SQL.Clear;
dsHistory.SQL.Add(sql);
dsHistory.Open;

if view_only='yes' then
  begin
  button1.Enabled:=false;
  groupbox1.Enabled:=false;
  groupbox3.Enabled:=false;
  groupbox4.Enabled:=false;
  label2.Visible:=false;
  label16.Visible:=false;
  label17.Visible:=false;
  label25.Visible:=false;
  label26.Visible:=false;
  label27.Visible:=false;
  groupbox9.Enabled:=false;
  groupbox8.Enabled:=false;
  label50.Visible:=false;
  label48.Visible:=false;
  label53.Visible:=false;
  label54.Visible:=false;
  label55.Visible:=false;
  label56.Visible:=false;
  label57.Visible:=false;
  label58.Visible:=false;
  label60.Visible:=false;
  label61.Visible:=false;
  label62.Visible:=false;
  label63.Visible:=false;
  label64.Visible:=false;
  lblChooseCustomer.Visible:=false;
  lblNewCustomer.Visible:=false;
  dbcheckbox1.Enabled:=false;
  dbcheckbox2.Enabled:=false;
  dbcheckbox3.Enabled:=false;
  dbmemo1.Enabled:=false;
  lblRateUpdate.Visible:=False;
  end
else CheckEuroRateForControl;
end;

procedure TOrder.Label14Click(Sender: TObject);
var
h,w,pmp,pmp_sum,price,eur:real;
sql:string;
i,j:integer;
begin
if view_only='no' then
begin

if dbcheckbox1.Checked=false then sql:='SELECT * FROM glass_price ORDER BY height_meters';
if dbcheckbox1.Checked=true then sql:='SELECT * FROM glass_price_dealer ORDER BY height_meters';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.Open;

pmp_sum:=0;
for j:=1 to stringgrid1.ColCount-1 do
  begin
  h:=strtofloatdef(stringgrid1.Cells[j,2],0)/1000;
  w:=strtofloatdef(stringgrid1.Cells[j,1],0)/1000;

  dsOrderDocNum.First;
  for i:=1 to dsOrderDocNum.RecordCount do
    begin
    if ((h<=dsOrderDocNum.FieldByName('height_meters').AsFloat)) and (h<>0) then
      begin
      if dbcombobox2.Text='6' then pmp:=dsOrderDocNum.FieldByName('thick_6').AsFloat;
      if dbcombobox2.Text='8' then pmp:=dsOrderDocNum.FieldByName('thick_8').AsFloat;
      if dbcombobox2.Text='10' then pmp:=dsOrderDocNum.FieldByName('thick_10').AsFloat;
      break;
      end;
    if i=dsOrderDocNum.RecordCount then pmp:=0;
    dsOrderDocNum.Next;
    end;

  pmp_sum:=pmp_sum+pmp*w;
  end;

// ���� ����
if dsOrder.FieldByName('ce_on_calc_day').AsFloat>0 then eur:=dsOrder.FieldByName('ce_on_calc_day').AsFloat
else
  begin
  eur:=GetCurrentEuroRate;
  dsOrder.FieldByName('ce_on_calc_day').AsFloat:=eur;
  end;

dsOrder.Edit;
// ����
price:=pmp_sum;
dsOrder.FieldByName('cost').AsFloat:=roundto(price*eur,-2);

// ������
dsOrder.FieldByName('cost_w_discount').AsFloat:=roundto((100-strtointdef(dbedit7.Text,0))*dsOrder.FieldByName('cost').AsFloat/100,-2);

// ������
if dbcheckbox2.Checked=False then dsOrder.FieldByName('install_cost').AsFloat:=roundto(dsOrder.FieldByName('cost').AsFloat*0.1,-2)
else dsOrder.FieldByName('install_cost').AsFloat:=0;

// �����
dsOrder.FieldByName('total_cost').AsFloat:=roundto(dsOrder.FieldByName('install_cost').AsFloat+dsOrder.FieldByName('cost_w_discount').AsFloat,-2);

// ����� �����
dsOrder.FieldByName('order_total_cost').AsFloat:=dsOrder.FieldByName('cost_w_discount').AsFloat+dsOrder.FieldByName('install_cost').AsFloat+dsOrder.FieldByName('am_cost_w_discount').AsFloat+dsOrder.FieldByName('am_install_cost').AsFloat+dsOrder.FieldByName('as_total_cost').AsFloat;
dsOrder.FieldByName('m_for_contract').AsFloat:=dsOrder.FieldByName('cost_w_discount').AsFloat+dsOrder.FieldByName('am_cost_w_discount').AsFloat+dsOrder.FieldByName('as_total_cost').AsFloat;
dsOrder.FieldByName('vat_m_for_contract').AsFloat:=roundto(dsOrder.FieldByName('m_for_contract').AsFloat/118*18,-2);
dsOrder.FieldByName('w_for_contract').AsFloat:=dsOrder.FieldByName('install_cost').AsFloat+dsOrder.FieldByName('am_install_cost').AsFloat;
dsOrder.FieldByName('vat_w_for_contract').AsFloat:=roundto(dsOrder.FieldByName('w_for_contract').AsFloat/118*18,-2);
end;
end;

procedure TOrder.Label16Click(Sender: TObject);
begin
mode:='edit';
Order.dsAddMat.Edit;
AM_Edit:=tAM_Edit.Create(nil);
AM_Edit.ShowModal;
end;

procedure TOrder.Label16MouseEnter(Sender: TObject);
begin
Label16.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label16MouseLeave(Sender: TObject);
begin
Label16.Font.Style:=[];
end;

procedure TOrder.Label17Click(Sender: TObject);
var
buttonSelected : Integer;
sql:string;
begin
buttonSelected := MessageDlg('�� �������?',mtConfirmation, mbOKCancel, 0);

if buttonSelected = mrOK then
  begin
    dsAddMat.Edit;
    dsAddMat.Delete;
    Label23.OnClick(nil);
  end;

end;

procedure TOrder.Label17MouseEnter(Sender: TObject);
begin
Label17.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label17MouseLeave(Sender: TObject);
begin
Label17.Font.Style:=[];
end;

procedure TOrder.Label23Click(Sender: TObject);
begin
if view_only='no' then
begin
dsOrder.Edit;
dsOrder.FieldByName('am_cost').AsFloat:=Self.GetSumBySum(Self.dsAddMat);
dsOrder.FieldByName('am_cost_w_discount').AsFloat:=dsOrder.FieldByName('am_cost').AsFloat-dsOrder.FieldByName('am_cost').AsFloat*strtofloatdef(dbedit12.Text,0)/100;
if dbcheckbox3.Checked=false then dsOrder.FieldByName('am_install_cost').AsFloat:=0.1*dsOrder.FieldByName('am_cost').AsFloat
else dsOrder.FieldByName('am_install_cost').AsFloat:=0;
dsOrder.FieldByName('am_total_cost').AsFloat:=dsOrder.FieldByName('am_install_cost').AsFloat+dsOrder.FieldByName('am_cost_w_discount').AsFloat;

// ����� �����
dsOrder.FieldByName('order_total_cost').AsFloat:=dsOrder.FieldByName('cost_w_discount').AsFloat+dsOrder.FieldByName('install_cost').AsFloat+dsOrder.FieldByName('am_cost_w_discount').AsFloat+dsOrder.FieldByName('am_install_cost').AsFloat+dsOrder.FieldByName('as_total_cost').AsFloat;
dsOrder.FieldByName('m_for_contract').AsFloat:=dsOrder.FieldByName('cost_w_discount').AsFloat+dsOrder.FieldByName('am_cost_w_discount').AsFloat+dsOrder.FieldByName('as_total_cost').AsFloat;
dsOrder.FieldByName('vat_m_for_contract').AsFloat:=roundto(dsOrder.FieldByName('m_for_contract').AsFloat/118*18,-2);
dsOrder.FieldByName('w_for_contract').AsFloat:=dsOrder.FieldByName('install_cost').AsFloat+dsOrder.FieldByName('am_install_cost').AsFloat;
dsOrder.FieldByName('vat_w_for_contract').AsFloat:=roundto(dsOrder.FieldByName('w_for_contract').AsFloat/118*18,-2);
end;
end;

procedure TOrder.Label25Click(Sender: TObject);
begin
mode:='append';
Order.dsAddServ.Append;
AS_Edit:=tAS_Edit.Create(nil);
AS_Edit.ShowModal;
end;

procedure TOrder.Label25MouseEnter(Sender: TObject);
begin
Label25.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label25MouseLeave(Sender: TObject);
begin
Label25.Font.Style:=[];
end;

procedure TOrder.Label26Click(Sender: TObject);
begin
mode:='edit';
Order.dsAddServ.Edit;
AS_Edit:=tAS_Edit.Create(nil);
AS_Edit.ShowModal;
end;

procedure TOrder.Label26MouseEnter(Sender: TObject);
begin
Label26.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label26MouseLeave(Sender: TObject);
begin
Label26.Font.Style:=[];
end;

procedure TOrder.Label27Click(Sender: TObject);
var
buttonSelected : Integer;
begin
buttonSelected := MessageDlg('�� �������?',mtConfirmation, mbOKCancel, 0);

if buttonSelected = mrOK then
  begin
    dsAddServ.Edit;
    dsAddServ.Delete;
    dsOrder.Edit;
    dsOrder.FieldByName('as_total_cost').AsFloat:=Self.GetSumBySum(Self.dsAddServ);
    Label14.OnClick(nil);
  end;
end;

procedure TOrder.Label27MouseEnter(Sender: TObject);
begin
Label27.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label27MouseLeave(Sender: TObject);
begin
Label27.Font.Style:=[];
end;

procedure TOrder.Label2Click(Sender: TObject);
begin
mode:='append';
Order.dsAddMat.Append;
AM_Edit:=tAM_Edit.Create(nil);
AM_Edit.ShowModal;
end;

procedure TOrder.Label2MouseEnter(Sender: TObject);
begin
Label2.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label2MouseLeave(Sender: TObject);
begin
Label2.Font.Style:=[];
end;

procedure TOrder.Label48Click(Sender: TObject);
var
tx,tx1,sql,order_id,fn,tfn:string;
ost:real;
sr:TSearchRec;
i:integer;
begin
MSWord := CreateOleObject('Word.Application');
if dsCustomer.FieldByName('type').AsString='���. ����' then MSWord.Documents.Open(Self.GetDocTemplate('�������_���.docx'));
if dsCustomer.FieldByName('type').AsString='��. ����' then MSWord.Documents.Open(Self.GetDocTemplate('�������_��.docx'));
MSWord.Visible := false;

FindAndReplace('{����� ��������}',dsOrder.FieldByName('contract_num').AsString);

tx:=dsOrder.FieldByName('order_date').AsString;
tx1:=copy(tx,1,pos('.',tx)-1);
FindAndReplace('{d}',tx1);
delete(tx,1,pos('.',tx));
tx1:=copy(tx,1,pos('.',tx)-1);
if tx1='01' then tx1:='������';
if tx1='02' then tx1:='�������';
if tx1='03' then tx1:='�����';
if tx1='04' then tx1:='������';
if tx1='05' then tx1:='���';
if tx1='06' then tx1:='����';
if tx1='07' then tx1:='����';
if tx1='08' then tx1:='�������';
if tx1='09' then tx1:='��������';
if tx1='10' then tx1:='�������';
if tx1='11' then tx1:='������';
if tx1='12' then tx1:='�������';
FindAndReplace('{m}',tx1);
delete(tx,1,pos('.',tx));
FindAndReplace('{y}',tx);

FindAndReplace('{��� ���������}',dsCustomer.FieldByName('name').AsString);

tx:='- ��������� ���������� ���������� - '+dsOrder.FieldByName('cost_w_discount').AsString+'�. ('+SumNumToFull(dsOrder.FieldByName('cost_w_discount').AsFloat)+'), � �.�. ��� - ('+floattostr(roundto(dsOrder.FieldByName('cost_w_discount').AsFloat/118*18,-2))+'�);';
FindAndReplace('{��������}',tx);

if dsOrder.FieldByName('am_cost_w_discount').AsString<>'' then
  tx:='- �������������� ���������  - '+dsOrder.FieldByName('am_cost_w_discount').AsString+'�. ('+SumNumToFull(dsOrder.FieldByName('am_cost_w_discount').AsFloat)+'), � �.�. ��� - ('+floattostr(roundto(dsOrder.FieldByName('am_cost_w_discount').AsFloat/118*18,-2))+'�.);'
else
  tx:='';
FindAndReplace('{�������� ���}',tx);

if dsOrder.FieldByName('as_total_cost').AsString<>'' then
  tx:='- �������������� ������ - '+dsOrder.FieldByName('as_total_cost').AsString+'�. ('+SumNumToFull(dsOrder.FieldByName('as_total_cost').AsFloat)+'), � �.�. ��� - ('+floattostr(roundto(dsOrder.FieldByName('as_total_cost').AsFloat/118*18,-2))+'�.);'
else
  tx:='';
FindAndReplace('{��� ������}',tx);

tx:='- ������ ���������� ���������� ����������-'+dsOrder.FieldByName('system_type').AsString+' � '+dsOrder.FieldByName('install_cost').AsString+'�. ('+SumNumToFull(dsOrder.FieldByName('install_cost').AsFloat)+'), � �.�. ��� - ('+floattostr(roundto(dsOrder.FieldByName('install_cost').AsFloat/118*18,-2))+'�.);';
FindAndReplace('{������}',tx);

FindAndReplace('{���� �������}',dsOrder.FieldByName('order_total_cost').AsString);
FindAndReplace('{���� ������� �������}',SumNumToFull(dsOrder.FieldByName('order_total_cost').AsFloat));
FindAndReplace('{��� �������}',floattostr(roundto(dsOrder.FieldByName('order_total_cost').AsFloat/118*18,-2)));


if dsOrder.FieldByName('am_install_cost').AsString<>'' then
  tx:='- ������ �������������� ���������� � '+dsOrder.FieldByName('am_install_cost').AsString+'�. ('+SumNumToFull(dsOrder.FieldByName('am_install_cost').AsFloat)+'), � �.�. ��� - ('+floattostr(roundto(dsOrder.FieldByName('am_install_cost').AsFloat/118*18,-2))+'�.);'
else
  tx:='';
FindAndReplace('{������ ���}',tx);

FindAndReplace('{�����}',floattostr(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2)));
FindAndReplace('{����� �������}',SumNumToFull(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2)));
FindAndReplace('{����� ���}',floattostr(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8/118*18,-2)));
ost:=dsOrder.FieldByName('m_for_contract').AsFloat-roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2);
FindAndReplace('{�������}',floattostr(ost));
FindAndReplace('{������� �������}',SumNumToFull(ost));
FindAndReplace('{������� ���}',floattostr(roundto(ost/118*18,-2)));
FindAndReplace('{������}',dsOrder.FieldByName('w_for_contract').AsString);
FindAndReplace('{������ �������}',SumNumToFull(dsOrder.FieldByName('w_for_contract').AsFloat));
FindAndReplace('{������ ���}',dsOrder.FieldByName('vat_w_for_contract').AsString);

FindAndReplace('{����}',datetostr(dsOrder.FieldByName('order_date').AsDateTime+47));
FindAndReplace('{�����}',dsCustomer.FieldByName('address').AsString);
FindAndReplace('{����� ��������}',dsCustomer.FieldByName('passport').AsString);
FindAndReplace('{�����}',dsCustomer.FieldByName('passport_date').AsString+' '+dsCustomer.FieldByName('passport_out').AsString);
FindAndReplace('{�������}',dsCustomer.FieldByName('phone').AsString);

if dsCustomer.FieldByName('type').AsString='��. ����' then
  begin
  FindAndReplace('{���.����}',dsCustomer.FieldByName('attorney_name').AsString);
  FindAndReplace('{������������}',dsCustomer.FieldByName('attorney_doc').AsString);
  FindAndReplace('{����}',dsCustomer.FieldByName('customer_bank').AsString);
  end;

tfn:=Self.SetTempFileName('Doc.docx');
MSWord.NormalTemplate.Saved:=True;
MSWord.ActiveDocument.SaveAs(tfn);
MSWord.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString, '.docx');
Self.PutDocToServer(tfn, fn);

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=dsOrder.FieldByName('order_date').AsDateTime;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label48MouseEnter(Sender: TObject);
begin
Label48.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label48MouseLeave(Sender: TObject);
begin
Label48.Font.Style:=[];
end;

procedure TOrder.Label49Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\Doc'+ExtractFileExt(dsOrderDoc.FieldByName('doc_type').AsString);
  if FileExists(s) then DeleteFile(s);
  MainForm.IdFTP.Get('\���������\'+dsOrderDoc.FieldByName('doc_type').AsString, s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TOrder.Label49MouseEnter(Sender: TObject);
begin
Label49.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label49MouseLeave(Sender: TObject);
begin
Label49.Font.Style:=[];
end;

procedure TOrder.Label50Click(Sender: TObject);
var
buttonSelected : Integer;
begin
buttonSelected := MessageDlg('�� �������?',mtConfirmation, mbOKCancel, 0);
if buttonSelected = mrOK then
  begin
  dsOrderDoc.Edit;
  dsOrderDoc.Delete;
  end;
end;

procedure TOrder.Label50MouseEnter(Sender: TObject);
begin
Label50.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label50MouseLeave(Sender: TObject);
begin
Label50.Font.Style:=[];
end;

procedure TOrder.Label53Click(Sender: TObject);
var
sql,order_id,fn,tx,tfn:string;
i:integer;
sr:TSearchRec;
begin
MSWord := CreateOleObject('Word.Application');
MSWord.Documents.Open(Self.GetDocTemplate('����������_1.docx'));
MSWord.Visible := false;

FindAndReplace('{����� ��������}',dsOrder.FieldByName('contract_num').AsString);
FindAndReplace('{���� ��������}',dsOrder.FieldByName('order_date').AsString);
FindAndReplace('{�������}',dsOrder.FieldByName('system_type').AsString);

if stringgrid1.Cells[1,3]<>'' then FindAndReplace('{s1}',stringgrid1.Cells[1,3]) else FindAndReplace('{s1}','');
if stringgrid1.Cells[2,3]<>'' then FindAndReplace('{s2}',stringgrid1.Cells[2,3]) else FindAndReplace('{s2}','');
if stringgrid1.Cells[3,3]<>'' then FindAndReplace('{s3}',stringgrid1.Cells[3,3]) else FindAndReplace('{s3}','');
if stringgrid1.Cells[4,3]<>'' then FindAndReplace('{s4}',stringgrid1.Cells[4,3]) else FindAndReplace('{s4}','');
if stringgrid1.Cells[5,3]<>'' then FindAndReplace('{s5}',stringgrid1.Cells[5,3]) else FindAndReplace('{s5}','');
FindAndReplace('{stv}',dsOrder.FieldByName('glass_count').AsString);

if stringgrid1.Cells[1,1]<>'' then FindAndReplace('{L1}',stringgrid1.Cells[1,1]) else FindAndReplace('{L1}','');
if stringgrid1.Cells[2,1]<>'' then FindAndReplace('{L2}',stringgrid1.Cells[2,1]) else FindAndReplace('{L2}','');
if stringgrid1.Cells[3,1]<>'' then FindAndReplace('{L3}',stringgrid1.Cells[3,1]) else FindAndReplace('{L3}','');
if stringgrid1.Cells[4,1]<>'' then FindAndReplace('{L4}',stringgrid1.Cells[4,1]) else FindAndReplace('{L4}','');
if stringgrid1.Cells[5,1]<>'' then FindAndReplace('{L5}',stringgrid1.Cells[5,1]) else FindAndReplace('{L5}','');
FindAndReplace('{L}',dsOrder.FieldByName('width').AsString);

if stringgrid1.Cells[1,2]<>'' then FindAndReplace('{H1}',stringgrid1.Cells[1,2]) else FindAndReplace('{H1}','');
if stringgrid1.Cells[2,2]<>'' then FindAndReplace('{H2}',stringgrid1.Cells[2,2]) else FindAndReplace('{H2}','');
if stringgrid1.Cells[3,2]<>'' then FindAndReplace('{H3}',stringgrid1.Cells[3,2]) else FindAndReplace('{H3}','');
if stringgrid1.Cells[4,2]<>'' then FindAndReplace('{H4}',stringgrid1.Cells[4,2]) else FindAndReplace('{H4}','');
if stringgrid1.Cells[5,2]<>'' then FindAndReplace('{H5}',stringgrid1.Cells[5,2]) else FindAndReplace('{H5}','');

FindAndReplace('{S}',dsOrder.FieldByName('square').AsString);
FindAndReplace('{fix}',dsOrder.FieldByName('fix_count').AsString);
FindAndReplace('{mov}',dsOrder.FieldByName('mov_count').AsString);
FindAndReplace('{thick}',dsOrder.FieldByName('glass_thick').AsString);
FindAndReplace('{cost}',dsOrder.FieldByName('cost').AsString);
FindAndReplace('{disc}',dsOrder.FieldByName('discount').AsString);
FindAndReplace('{cost_d}',floattostr(roundto(dsOrder.FieldByName('cost').AsFloat/100*dsOrder.FieldByName('discount').AsFloat,-2)));
FindAndReplace('{cost_wd}',dsOrder.FieldByName('cost_w_discount').AsString);
FindAndReplace('{cost_inst}',dsOrder.FieldByName('install_cost').AsString);
FindAndReplace('{total}',dsOrder.FieldByName('total_cost').AsString);

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

sql:='SELECT * FROM am_orders, additional_materials WHERE am_orders.am_id=additional_materials.id AND order_id='+order_id;
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.Open;
if dsOrderDocNum.RecordCount>1 then for i := 1 to dsOrderDocNum.RecordCount do
  begin
  MSWord.ActiveDocument.Tables.Item(2).rows.add(MSWord.ActiveDocument.Tables.Item(2).rows.item(2));
  dsOrderDocNum.Next;
  end;
dsOrderDocNum.First;
for i := 1 to dsOrderDocNum.RecordCount do
  begin
  MSWord.ActiveDocument.Tables.Item(2).Cell(i+1,1).Range.text:=inttostr(i);
  MSWord.ActiveDocument.Tables.Item(2).Cell(i+1,2).Range.text:=dsOrderDocNum.fieldbyname('am_name').asstring;
  MSWord.ActiveDocument.Tables.Item(2).Cell(i+1,3).Range.text:=dsOrderDocNum.fieldbyname('measure').asstring;
  MSWord.ActiveDocument.Tables.Item(2).Cell(i+1,4).Range.text:=dsOrderDocNum.fieldbyname('cost').asstring;
  MSWord.ActiveDocument.Tables.Item(2).Cell(i+1,5).Range.text:=dsOrderDocNum.fieldbyname('quantity').asstring;
  MSWord.ActiveDocument.Tables.Item(2).Cell(i+1,6).Range.text:=dsOrderDocNum.fieldbyname('sum').asstring;
  dsOrderDocNum.Next;
  end;

sql:='SELECT * FROM as_orders, additional_services WHERE as_orders.as_id=additional_services.id AND order_id='+order_id;
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.Open;
if dsOrderDocNum.RecordCount>1 then for i := 1 to dsOrderDocNum.RecordCount do
  begin
  MSWord.ActiveDocument.Tables.Item(3).rows.add(MSWord.ActiveDocument.Tables.Item(3).rows.item(2));
  dsOrderDocNum.Next;
  end;
dsOrderDocNum.First;
for i := 1 to dsOrderDocNum.RecordCount do
  begin
  MSWord.ActiveDocument.Tables.Item(3).Cell(i+1,1).Range.text:=inttostr(i);
  MSWord.ActiveDocument.Tables.Item(3).Cell(i+1,2).Range.text:=dsOrderDocNum.fieldbyname('as_name').asstring;
  MSWord.ActiveDocument.Tables.Item(3).Cell(i+1,3).Range.text:=dsOrderDocNum.fieldbyname('mesuare').asstring;
  MSWord.ActiveDocument.Tables.Item(3).Cell(i+1,4).Range.text:=dsOrderDocNum.fieldbyname('cost').asstring;
  MSWord.ActiveDocument.Tables.Item(3).Cell(i+1,5).Range.text:=dsOrderDocNum.fieldbyname('quantity').asstring;
  MSWord.ActiveDocument.Tables.Item(3).Cell(i+1,6).Range.text:=dsOrderDocNum.fieldbyname('sum').asstring;
  dsOrderDocNum.Next;
  end;

FindAndReplace('{am}',dsOrder.FieldByName('am_cost').AsString);
FindAndReplace('{amd}',dsOrder.FieldByName('am_discount').AsString);
FindAndReplace('{amcd}',floattostr(roundto(dsOrder.FieldByName('am_cost').AsFloat/100*dsOrder.FieldByName('am_discount').AsFloat,-2)));
FindAndReplace('{amcwd}',dsOrder.FieldByName('am_cost_w_discount').AsString);
FindAndReplace('{aminst}',dsOrder.FieldByName('am_install_cost').AsString);
FindAndReplace('{total_am}',dsOrder.FieldByName('am_total_cost').AsString);
FindAndReplace('{as}',dsOrder.FieldByName('as_total_cost').AsString);
FindAndReplace('{order_total}',dsOrder.FieldByName('order_total_cost').AsString);

tfn:=Self.SetTempFileName('Doc.docx');
MSWord.NormalTemplate.Saved:=True;
MSWord.ActiveDocument.SaveAs(tfn);
MSWord.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_����������_1', '.docx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=dsOrder.FieldByName('order_date').AsDateTime;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label53MouseEnter(Sender: TObject);
begin
Label53.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label53MouseLeave(Sender: TObject);
begin
Label53.Font.Style:=[];
end;

procedure TOrder.Label54Click(Sender: TObject);
var
sql,order_id,fn,tx,tfn:string;
sr:TSearchRec;
i:integer;
begin
MSWord := CreateOleObject('Word.Application');
MSWord.Documents.Open(Self.GetDocTemplate('����������_2.docx'));
MSWord.Visible := false;

FindAndReplace('{����� ��������}',dsOrder.FieldByName('contract_num').AsString);
FindAndReplace('{���� ��������}',dsOrder.FieldByName('order_date').AsString);

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

tfn:=Self.SetTempFileName('Doc.docx');
MSWord.NormalTemplate.Saved:=True;
MSWord.ActiveDocument.SaveAs(tfn);
MSWord.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_����������_2', '.docx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=dsOrder.FieldByName('order_date').AsDateTime;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label54MouseEnter(Sender: TObject);
begin
Label54.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label54MouseLeave(Sender: TObject);
begin
Label54.Font.Style:=[];
end;

procedure TOrder.Label55Click(Sender: TObject);
var
sql, order_id,fn,tx,tfn:string;
sr:TSearchRec;
i:integer;
begin
MSWord := CreateOleObject('Word.Application');
MSWord.Documents.Open(Self.GetDocTemplate('����������_3.docx'));
MSWord.Visible := false;

FindAndReplace('{����� ��������}',dsOrder.FieldByName('contract_num').AsString);
FindAndReplace('{���� ��������}',dsOrder.FieldByName('order_date').AsString);

if dsOrder.FieldByName('cost').AsFloat>0 then
  begin
  MSWord.ActiveDocument.Tables.Item(1).Cell(2,2).Range.text:='������������ ����������� ���������� ���������� ����������-STANDARD';
  MSWord.ActiveDocument.Tables.Item(1).Cell(2,3).Range.text:='30 ������� ����';
  MSWord.ActiveDocument.Tables.Item(1).Cell(3,2).Range.text:='������ ���������� ���������� ����������-STANDARD';
  MSWord.ActiveDocument.Tables.Item(1).Cell(3,3).Range.text:='5 ������� ����';
  end;

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

sql:='SELECT * FROM am_orders, additional_materials WHERE am_orders.am_id=additional_materials.id AND order_id='+order_id+' AND am_name LIKE "%PROVEDAL%"';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.Open;

if dsOrderDocNum.RecordCount>0 then
  begin
  MSWord.ActiveDocument.Tables.Item(1).Cell(4,2).Range.text:='������������ ������� Provedal';
  MSWord.ActiveDocument.Tables.Item(1).Cell(4,3).Range.text:='20 ������� ����';
  MSWord.ActiveDocument.Tables.Item(1).Cell(5,2).Range.text:='������ ������� Provedal';
  MSWord.ActiveDocument.Tables.Item(1).Cell(5,3).Range.text:='5 ������� ����';
  end;

tfn:=Self.SetTempFileName('Doc.docx');
MSWord.NormalTemplate.Saved:=True;
MSWord.ActiveDocument.SaveAs(tfn);
MSWord.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_����������_3', '.docx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=dsOrder.FieldByName('order_date').AsDateTime;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;

end;

procedure TOrder.Label55MouseEnter(Sender: TObject);
begin
Label55.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label55MouseLeave(Sender: TObject);
begin
Label55.Font.Style:=[];
end;

procedure TOrder.Label56Click(Sender: TObject);
var
order_id,sql,tx, tx1,fn, tfn:string;
ost:real;
sr:TSearchRec;
i:integer;
begin
MSWord := CreateOleObject('Word.Application');
MSWord.Documents.Open(Self.GetDocTemplate('���_��������_������.docx'));
MSWord.Visible := false;

FindAndReplace('{����� ��������}',dsOrder.FieldByName('contract_num').AsString);

tx:=dsOrder.FieldByName('order_date').AsString;
tx1:=copy(tx,1,pos('.',tx)-1);
FindAndReplace('{d}',tx1);
delete(tx,1,pos('.',tx));
tx1:=copy(tx,1,pos('.',tx)-1);
if tx1='01' then tx1:='������';
if tx1='02' then tx1:='�������';
if tx1='03' then tx1:='�����';
if tx1='04' then tx1:='������';
if tx1='05' then tx1:='���';
if tx1='06' then tx1:='����';
if tx1='07' then tx1:='����';
if tx1='08' then tx1:='�������';
if tx1='09' then tx1:='��������';
if tx1='10' then tx1:='�������';
if tx1='11' then tx1:='������';
if tx1='12' then tx1:='�������';
FindAndReplace('{m}',tx1);
delete(tx,1,pos('.',tx));
FindAndReplace('{y}',tx);

tx:=datetostr(now);
tx1:=copy(tx,1,pos('.',tx)-1);
FindAndReplace('{cd}',tx1);
delete(tx,1,pos('.',tx));
tx1:=copy(tx,1,pos('.',tx)-1);
if tx1='01' then tx1:='������';
if tx1='02' then tx1:='�������';
if tx1='03' then tx1:='�����';
if tx1='04' then tx1:='������';
if tx1='05' then tx1:='���';
if tx1='06' then tx1:='����';
if tx1='07' then tx1:='����';
if tx1='08' then tx1:='�������';
if tx1='09' then tx1:='��������';
if tx1='10' then tx1:='�������';
if tx1='11' then tx1:='������';
if tx1='12' then tx1:='�������';
FindAndReplace('{cm}',tx1);
delete(tx,1,pos('.',tx));
FindAndReplace('{cy}',tx);

FindAndReplace('{��� ���������}',dsCustomer.FieldByName('name').AsString);
FindAndReplace('{���. ����}',dsCustomer.FieldByName('attorney_name').AsString);
FindAndReplace('{������������}',dsCustomer.FieldByName('attorney_doc').AsString);
ost:=dsOrder.FieldByName('m_for_contract').AsFloat-roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2);
FindAndReplace('{�����}',floattostr(ost));
FindAndReplace('{����� ��������}',SumNumToFull(ost));

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

tfn:=Self.SetTempFileName('Doc.docx');
MSWord.NormalTemplate.Saved:=True;
MSWord.ActiveDocument.SaveAs(tfn);
MSWord.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_���_��������_������.docx', '.docx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=now;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label56MouseEnter(Sender: TObject);
begin
Label56.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label56MouseLeave(Sender: TObject);
begin
Label56.Font.Style:=[];
end;

procedure TOrder.Label57Click(Sender: TObject);
var
sql,order_id,tx,tx1,fn,tfn:string;
sr:TSearchRec;
i:integer;
begin
MSWord := CreateOleObject('Word.Application');
MSWord.Documents.Open(Self.GetDocTemplate('���_�����_��������.docx'));
MSWord.Visible := false;

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

FindAndReplace('{����� ��������}',dsOrder.FieldByName('contract_num').AsString);

tx:=dsOrder.FieldByName('order_date').AsString;
tx1:=copy(tx,1,pos('.',tx)-1);
FindAndReplace('{d}',tx1);
delete(tx,1,pos('.',tx));
tx1:=copy(tx,1,pos('.',tx)-1);
if tx1='01' then tx1:='������';
if tx1='02' then tx1:='�������';
if tx1='03' then tx1:='�����';
if tx1='04' then tx1:='������';
if tx1='05' then tx1:='���';
if tx1='06' then tx1:='����';
if tx1='07' then tx1:='����';
if tx1='08' then tx1:='�������';
if tx1='09' then tx1:='��������';
if tx1='10' then tx1:='�������';
if tx1='11' then tx1:='������';
if tx1='12' then tx1:='�������';
FindAndReplace('{m}',tx1);
delete(tx,1,pos('.',tx));
FindAndReplace('{y}',tx);

FindAndReplace('{��� ���������}',dsCustomer.FieldByName('name').AsString);
FindAndReplace('{�����}',dsCustomer.FieldByName('address').AsString);

tfn:=Self.SetTempFileName('Doc.docx');
MSWord.NormalTemplate.Saved:=True;
MSWord.ActiveDocument.SaveAs(tfn);
MSWord.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_���_�����_��������', '.docx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=now;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label57MouseEnter(Sender: TObject);
begin
Label57.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label57MouseLeave(Sender: TObject);
begin
Label57.Font.Style:=[];
end;

procedure TOrder.Label58Click(Sender: TObject);
var
sql,order_id,tx,tx1,fn,tfn:string;
sr:TSearchRec;
i:integer;
begin
MSWord := CreateOleObject('Word.Application');
MSWord.Documents.Open(Self.GetDocTemplate('���_�����_�����.docx'));
MSWord.Visible := false;

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

FindAndReplace('{����� ��������}',dsOrder.FieldByName('contract_num').AsString);
FindAndReplace('{���� ��������}',dsOrder.FieldByName('order_date').AsString);

tx:=datetostr(now);
tx1:=copy(tx,1,pos('.',tx)-1);
FindAndReplace('{d}',tx1);
delete(tx,1,pos('.',tx));
tx1:=copy(tx,1,pos('.',tx)-1);
if tx1='01' then tx1:='������';
if tx1='02' then tx1:='�������';
if tx1='03' then tx1:='�����';
if tx1='04' then tx1:='������';
if tx1='05' then tx1:='���';
if tx1='06' then tx1:='����';
if tx1='07' then tx1:='����';
if tx1='08' then tx1:='�������';
if tx1='09' then tx1:='��������';
if tx1='10' then tx1:='�������';
if tx1='11' then tx1:='������';
if tx1='12' then tx1:='�������';
FindAndReplace('{m}',tx1);
delete(tx,1,pos('.',tx));
FindAndReplace('{y}',tx);

FindAndReplace('{��� ���������}',dsCustomer.FieldByName('name').AsString);
FindAndReplace('{��� ����}',dsCustomer.FieldByName('attorney_name').AsString);
FindAndReplace('{������������}',dsCustomer.FieldByName('attorney_doc').AsString);
FindAndReplace('{����� �����}',dsOrder.FieldByName('w_for_contract').AsString);
FindAndReplace('{����� ����� ��������}',SumNumToFull(dsOrder.FieldByName('w_for_contract').AsFloat));

tfn:=Self.SetTempFileName('Doc.docx');
MSWord.NormalTemplate.Saved:=True;
MSWord.ActiveDocument.SaveAs(tfn);
MSWord.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_���_�����_�����', '.docx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=Now;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label58MouseEnter(Sender: TObject);
begin
Label58.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label58MouseLeave(Sender: TObject);
begin
Label58.Font.Style:=[];
end;

procedure TOrder.Label60Click(Sender: TObject);
var
sql,order_id,client,fn,tfn,tx:string;
i,h:integer;
sr:TSearchRec;
begin
MSWord := CreateOleObject('Word.Application');
MSWord.Documents.Open(Self.GetDocTemplate('������������ �����������.docx'));
MSWord.Visible := false;

FindAndReplace('{����}',dsOrder.FieldByName('order_date').AsString);

client:=dsCustomer.FieldByName('name').AsString;
for i := 1 to length(client) do
  begin
  if client[i]=' ' then break;
  end;
client:=copy(client,1,i);
client:='���������(��) '+client;
FindAndReplace('{���������}',client);

FindAndReplace('{���������}',dsOrder.FieldByName('order_total_cost').AsString);
FindAndReplace('{�����}',floattostr(dsOrder.FieldByName('width').AsInteger/1000));

h:=0;
for I := 1 to stringgrid1.ColCount-1 do
  begin
  if strtointdef(stringgrid1.Cells[i,2],0)>h then h:=strtointdef(stringgrid1.Cells[i,2],0);
  end;
FindAndReplace('{������}',floattostr(h/1000));
FindAndReplace('{����}',dsOrder.FieldByName('glass_thick').AsString);

tfn:=Self.SetTempFileName('Doc.docx');
MSWord.NormalTemplate.Saved:=True;
MSWord.ActiveDocument.SaveAs(tfn);
MSWord.Application.Quit;
fn:=Self.SetDocFileName('���_�����������_'+dsOrder.FieldByName('contract_num').AsString, '.docx');
Self.PutDocToServer(tfn, fn);

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=dsOrder.FieldByName('order_date').AsDateTime;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label60MouseEnter(Sender: TObject);
begin
Label60.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label60MouseLeave(Sender: TObject);
begin
Label60.Font.Style:=[];
end;

procedure TOrder.Label61Click(Sender: TObject);
var
Excel:variant;
order_id,sql,tx,tx1,d,y,m,fn,tfn:string;
sr:TSearchRec;
i:integer;
begin
Excel := CreateOleObject('Excel.Application');
Excel.Workbooks.Open(Self.GetDocTemplate('����.xlsx'));
Excel.Visible := false;

tx:=dsOrder.FieldByName('order_date').AsString;
tx1:=copy(tx,1,pos('.',tx)-1);
d:=tx1;
delete(tx,1,pos('.',tx));
tx1:=copy(tx,1,pos('.',tx)-1);
if tx1='01' then tx1:='������';
if tx1='02' then tx1:='�������';
if tx1='03' then tx1:='�����';
if tx1='04' then tx1:='������';
if tx1='05' then tx1:='���';
if tx1='06' then tx1:='����';
if tx1='07' then tx1:='����';
if tx1='08' then tx1:='�������';
if tx1='09' then tx1:='��������';
if tx1='10' then tx1:='�������';
if tx1='11' then tx1:='������';
if tx1='12' then tx1:='�������';
m:=tx1;
delete(tx,1,pos('.',tx));
y:=tx;

Excel.Cells[10,1].value:='���� � '+dsOrder.FieldByName('contract_num').AsString+' �� '+d+' '+tx1+' '+y+' �.';
Excel.Cells[13,3].value:=dsCustomer.FieldByName('name').AsString;
Excel.Cells[14,3].value:=dsCustomer.FieldByName('address').AsString;
Excel.Cells[15,3].value:=dsCustomer.FieldByName('customer_inn').AsString;

Excel.Cells[18,2].value:='������ �� �������� '+dsOrder.FieldByName('contract_num').AsString+' �� '+dsOrder.FieldByName('order_date').AsString+'�. �� ����������� ����������';
Excel.Cells[18,16].value:=dsOrder.FieldByName('order_total_cost').AsFloat;
Excel.Cells[19,16].value:=dsOrder.FieldByName('order_total_cost').AsFloat;
Excel.Cells[18,15].value:=roundto(dsOrder.FieldByName('order_total_cost').AsFloat/118*18,-2);
Excel.Cells[19,15].value:=roundto(dsOrder.FieldByName('order_total_cost').AsFloat/118*18,-2);
Excel.Cells[18,9].value:=roundto(dsOrder.FieldByName('order_total_cost').AsFloat-dsOrder.FieldByName('order_total_cost').AsFloat/118*18,-2);
Excel.Cells[19,9].value:=roundto(dsOrder.FieldByName('order_total_cost').AsFloat-dsOrder.FieldByName('order_total_cost').AsFloat/118*18,-2);
Excel.Cells[18,11].value:=roundto(dsOrder.FieldByName('order_total_cost').AsFloat-dsOrder.FieldByName('order_total_cost').AsFloat/118*18,-2);
Excel.Cells[19,11].value:=roundto(dsOrder.FieldByName('order_total_cost').AsFloat-dsOrder.FieldByName('order_total_cost').AsFloat/118*18,-2);

Excel.Cells[21,1].value:='����� ������������ 1, �� ����� '+dsOrder.FieldByName('order_total_cost').AsString+' ������.';
Excel.Cells[22,1].value:='����� ��������: '+SumNumToFull(dsOrder.FieldByName('order_total_cost').AsFloat)+', � �. �. ��� 18% - '+SumNumToFull(roundto(dsOrder.FieldByName('order_total_cost').AsFloat/118*18,-2));

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

tfn:=Self.SetTempFileName('Doc.xlsx');
Excel.ActiveSheet.SaveAs(tfn);
Excel.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_����', '.xlsx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=now;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label61MouseEnter(Sender: TObject);
begin
Label61.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label61MouseLeave(Sender: TObject);
begin
Label61.Font.Style:=[];
end;

procedure TOrder.Label62Click(Sender: TObject);
var
Excel:variant;
sql,order_id,tx,tx1,fn,tfn:string;
sr:TSearchRec;
i:integer;
begin
Excel := CreateOleObject('Excel.Application');
Excel.Workbooks.Open(Self.GetDocTemplate('��������� �����.xlsx'));
Excel.Visible := false;

Excel.Cells[19,11].value:='1_'+dsOrder.FieldByName('contract_num').AsString;

tx:=floattostr(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2));
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[27,9].value:=tx+' ���. '+tx1+' ���.';

Excel.Cells[30,5].value:=dsCustomer.FieldByName('name').AsString;

Excel.Cells[31,5].value:='����� �� �������� '+dsOrder.FieldByName('contract_num').AsString+' �� '+dsOrder.FieldByName('order_date').AsString+'�.';
Excel.Cells[33,5].value:=SumNumToFull(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2));

tx:=floattostr(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8/118*18,-2));
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[35,5].value:='��� 18% - '+tx+' ���. '+tx1+' ���.';

Excel.Cells[7,19].value:='� ���������� ��������� ������ � '+'1_'+dsOrder.FieldByName('contract_num').AsString;
Excel.Cells[9,19].value:='������� ��: '+dsCustomer.FieldByName('name').AsString;
Excel.Cells[15,19].value:='���������: ����� �� �������� '+dsOrder.FieldByName('contract_num').AsString+' �� '+dsOrder.FieldByName('order_date').AsString+'�.';
tx:=floattostr(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2));
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[24,19].value:='����� : '+tx+' ���. '+tx1+' ���.';
Excel.Cells[25,19].value:=SumNumToFull(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2));
tx:=floattostr(roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8/118*18,-2));
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[31,19].value:='� ��� ����� : ��� 18% - '+tx+' ���. '+tx1+' ���.';

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

tfn:=Self.SetTempFileName('Doc.xlsx');
Excel.ActiveSheet.SaveAs(tfn);
Excel.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_��������� �����_�����', '.xlsx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=Now;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;

end;

procedure TOrder.Label62MouseEnter(Sender: TObject);
begin
Label62.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label62MouseLeave(Sender: TObject);
begin
Label62.Font.Style:=[];
end;

procedure TOrder.Label63Click(Sender: TObject);
var
Excel:variant;
sql,order_id,tx,tx1,fn,tfn:string;
sr:TSearchRec;
ost:real;
i:integer;
begin
Excel := CreateOleObject('Excel.Application');
Excel.Workbooks.Open(Self.GetDocTemplate('��������� �����.xlsx'));
Excel.Visible := false;

Excel.Cells[19,11].value:='2_'+dsOrder.FieldByName('contract_num').AsString;

ost:=dsOrder.FieldByName('m_for_contract').AsFloat-roundto(dsOrder.FieldByName('m_for_contract').AsFloat*0.8,-2);

tx:=floattostr(ost);
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[27,9].value:=tx+' ���. '+tx1+' ���.';

Excel.Cells[30,5].value:=dsCustomer.FieldByName('name').AsString;

Excel.Cells[31,5].value:='������� �� �������� '+dsOrder.FieldByName('contract_num').AsString+' �� '+dsOrder.FieldByName('order_date').AsString+'�.';
Excel.Cells[33,5].value:=SumNumToFull(ost);

tx:=floattostr(roundto(ost/118*18,-2));
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[35,5].value:='��� 18% - '+tx+' ���. '+tx1+' ���.';

Excel.Cells[7,19].value:='� ���������� ��������� ������ � '+'2_'+dsOrder.FieldByName('contract_num').AsString;
Excel.Cells[9,19].value:='������� ��: '+dsCustomer.FieldByName('name').AsString;
Excel.Cells[15,19].value:='���������: ������� �� �������� '+dsOrder.FieldByName('contract_num').AsString+' �� '+dsOrder.FieldByName('order_date').AsString+'�.';
tx:=floattostr(ost);
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[24,19].value:='����� : '+tx+' ���. '+tx1+' ���.';
Excel.Cells[25,19].value:=SumNumToFull(ost);
tx:=floattostr(roundto(ost/118*18,-2));
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[31,19].value:='� ��� ����� : ��� 18% - '+tx+' ���. '+tx1+' ���.';

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

tfn:=Self.SetTempFileName('Doc.xlsx');
Excel.ActiveSheet.SaveAs(tfn);
Excel.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_��������� �����_�������_1', '.xlsx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=now;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label63MouseEnter(Sender: TObject);
begin
Label63.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label63MouseLeave(Sender: TObject);
begin
Label63.Font.Style:=[];
end;

procedure TOrder.Label64Click(Sender: TObject);
var
Excel:variant;
sql,order_id,tx,tx1,fn,tfn:string;
ost:real;
sr:TSearchRec;
i:integer;
begin
Excel := CreateOleObject('Excel.Application');
Excel.Workbooks.Open(Self.GetDocTemplate('��������� �����.xlsx'));
Excel.Visible := false;

Excel.Cells[19,11].value:='3_'+dsOrder.FieldByName('contract_num').AsString;

ost:=dsOrder.FieldByName('w_for_contract').asfloat;

tx:=floattostr(ost);
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[27,9].value:=tx+' ���. '+tx1+' ���.';

Excel.Cells[30,5].value:=dsCustomer.FieldByName('name').AsString;

Excel.Cells[31,5].value:='������� �� �������� '+dsOrder.FieldByName('contract_num').AsString+' �� '+dsOrder.FieldByName('order_date').AsString+'�.';
Excel.Cells[33,5].value:=SumNumToFull(ost);

tx:=floattostr(roundto(ost/118*18,-2));
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[35,5].value:='��� 18% - '+tx+' ���. '+tx1+' ���.';

Excel.Cells[7,19].value:='� ���������� ��������� ������ � '+'3_'+dsOrder.FieldByName('contract_num').AsString;
Excel.Cells[9,19].value:='������� ��: '+dsCustomer.FieldByName('name').AsString;
Excel.Cells[15,19].value:='���������: ������� �� �������� '+dsOrder.FieldByName('contract_num').AsString+' �� '+dsOrder.FieldByName('order_date').AsString+'�.';
tx:=floattostr(ost);
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[24,19].value:='����� : '+tx+' ���. '+tx1+' ���.';
Excel.Cells[25,19].value:=SumNumToFull(ost);
tx:=floattostr(roundto(ost/118*18,-2));
tx1:=copy(tx,pos(',',tx)+1,length(tx));
tx:=copy(tx,1,pos(',',tx)-1);
Excel.Cells[31,19].value:='� ��� ����� : ��� 18% - '+tx+' ���. '+tx1+' ���.';

order_id:=dsOrder.FieldByName('id').AsString;
if order_id='' then order_id:='0';

tfn:=Self.SetTempFileName('Doc.xlsx');
Excel.ActiveSheet.SaveAs(tfn);
Excel.Application.Quit;
fn:=Self.SetDocFileName('�������_'+dsOrder.FieldByName('contract_num').AsString+'_��������� �����_�������_2', '.xlsx');
Self.PutDocToServer(tfn, fn);

sql:='INSERT INTO documents (order_id, doc_type, doc_date, link) VALUES ('+order_id+',"'+fn+'",:doc_date,"")';
dsOrderDocNum.Close;
dsOrderDocNum.SQL.Clear;
dsOrderDocNum.SQL.Add(sql);
dsOrderDocNum.ParamByName('doc_date').AsDateTime:=now;
dsOrderDocNum.ExecSQL;

dsOrderDoc.Close;
dsOrderDoc.Open;
end;

procedure TOrder.Label64MouseEnter(Sender: TObject);
begin
Label64.Font.Style:=[fsUnderline];
end;

procedure TOrder.Label64MouseLeave(Sender: TObject);
begin
Label64.Font.Style:=[];
end;

procedure TOrder.lblChooseCustomerClick(Sender: TObject);
var
  sql: string;
begin
  // ����� ����� ������ �������
  frmCustomers:=TfrmCustomers.Create(Self);
  try
    if frmCustomers.ShowModal = mrOK then
      begin
        sql:='SELECT * FROM customers WHERE id='+frmCustomers.dsCustomers.FieldByName('Id').AsString;
        dsCustomer.Close;
        dsCustomer.SQL.Clear;
        dsCustomer.SQL.Add(sql);
        dsCustomer.Open;
      end;
  finally
    frmCustomers.Free;
  end;
end;

procedure TOrder.lblChooseCustomerMouseEnter(Sender: TObject);
begin
lblChooseCustomer.Font.Style:=[fsUnderline];
end;

procedure TOrder.lblChooseCustomerMouseLeave(Sender: TObject);
begin
lblChooseCustomer.Font.Style:=[];
end;

procedure TOrder.lblNewCustomerClick(Sender: TObject);
var
  sql: string;
begin
  if dsCustomer.FieldByName('id').AsInteger>0 then
    begin
      sql:='SELECT * FROM customers WHERE id=0';
      dsCustomer.Close;
      dsCustomer.SQL.Clear;
      dsCustomer.SQL.Add(sql);
      dsCustomer.Open;
    end;
end;

procedure TOrder.lblNewCustomerMouseEnter(Sender: TObject);
begin
lblNewCustomer.Font.Style:=[fsUnderline];
end;

procedure TOrder.lblNewCustomerMouseLeave(Sender: TObject);
begin
lblNewCustomer.Font.Style:=[];
end;

procedure TOrder.lblRateUpdateClick(Sender: TObject);
begin
  dsOrder.Edit;
  dsOrder.FieldByName('ce_on_calc_day').AsCurrency:=GetCurrentEuroRate;
  CheckEuroRateForControl;
  Label14.OnClick(Self);
end;

procedure TOrder.lblRateUpdateMouseEnter(Sender: TObject);
begin
  lblRateUpdate.Font.Style:=[fsUnderline];
end;

procedure TOrder.lblRateUpdateMouseLeave(Sender: TObject);
begin
  lblRateUpdate.Font.Style:=[];
end;

procedure TOrder.RadioButton1Click(Sender: TObject);
begin
if RadioButton1.Checked=true then dsOrder.FieldByName('system_type').AsString:='STANDART';
end;

procedure TOrder.RadioButton2Click(Sender: TObject);
begin
if RadioButton2.Checked=true then dsOrder.FieldByName('system_type').AsString:='BASIC-PRO';
end;

procedure TOrder.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
dbcombobox1.OnChange(nil);
end;

end.
