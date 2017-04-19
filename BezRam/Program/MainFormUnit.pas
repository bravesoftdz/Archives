unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.Menus, Data.DB, Data.Win.ADODB, ShellAPI
  ,API_MVC
  ,Controllers, FireDAC.UI.Intf, FireDAC.VCLUI.Async, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Stan.Intf, Vcl.ComCtrls, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP;

type
  TMainForm = class(TViewAbstract)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    DBGrid1: TDBGrid;
    Button5: TButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Euro1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N7: TMenuItem;
    Excel1: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N6: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    statConnectInfo: TStatusBar;
    N23: TMenuItem;
    N24: TMenuItem;
    FDQuery: TFDQuery;
    sourceOrders: TDataSource;
    dsOrders: TFDQuery;
    IdFTP: TIdFTP;
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Euro1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
    FConnection: TFDConnection;
    procedure InitMVC; override;
  public
    { Public declarations }
    procedure LockControls;
    procedure UnlockControls;
    property Connection: TFDConnection read FConnection write FConnection;
  end;

var
  MainForm: TMainForm;
  mode: string;
  view_only: string;
  order_id:integer;

implementation

{$R *.dfm}

uses OrderFormUnit, ExchangeFormUnit, AddMatForm
  ,MigrateFormUnit
  ,AuthFormUnit
  ,PriceListAkrUnit
  ,PriceListAMUnit
  ,PriceListASUnit
  ,CalcGlassFormUnit
  ,CalcCompFormUnit
  ,CalcComp2FormUnit
  ,UsersUnit;

procedure TMainForm.LockControls;
begin
  self.Button1.Enabled:=False;
  self.Button2.Enabled:=False;
  self.Button3.Enabled:=False;
  Self.Button4.Enabled:=False;
  MainMenu1.Items[0].Enabled:=False;
  MainMenu1.Items[2].Enabled:=False;
  MainMenu1.Items[3].Enabled:=False;
  MainMenu1.Items[4].Items[1].Enabled:=False;
end;

procedure TMainForm.UnlockControls;
begin
  self.Button1.Enabled:=True;
  self.Button2.Enabled:=True;
  self.Button3.Enabled:=True;
  Self.Button4.Enabled:=True;
  MainMenu1.Items[0].Enabled:=True;
  MainMenu1.Items[2].Enabled:=True;
  MainMenu1.Items[3].Enabled:=True;
end;

procedure TMainForm.InitMVC;
begin
  FControllerClass:=TController;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
mode:='append';
view_only:='no';
order:=torder.Create(Self);
order.ShowModal;
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
mode:='edit';
view_only:='yes';
order:=torder.Create(Self);
order.ShowModal;
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
mode:='edit';
view_only:='no';
order:=torder.Create(self);
order.ShowModal;
end;

procedure TMainForm.Button4Click(Sender: TObject);
var
buttonSelected : Integer;
sql:string;
begin
buttonSelected := MessageDlg('Вы уверены?',mtConfirmation, mbOKCancel, 0);

if buttonSelected = mrOK then
  begin
  sql:='DELETE FROM as_orders WHERE order_id='+dsOrders.FieldByName('id').AsString;
  TController(Self.FController).DBEngine.SetData(sql);

  dsOrders.Edit;
  dsOrders.Delete;
  end;

end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
MainForm.Close;
MainForm.Release;
end;

procedure TMainForm.DBGrid1TitleClick(Column: TColumn);
begin
  dsOrders.IndexFieldNames:=Column.FieldName;
end;

procedure TMainForm.Euro1Click(Sender: TObject);
begin
Exchange:=tExchange.Create(Self);
Exchange.ShowModal;
end;

procedure TMainForm.Excel1Click(Sender: TObject);
begin
CompCalc:=tCompCalc.Create(Self);
CompCalc.ShowModal;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  statConnectInfo.Panels.Items[0].Text:='Connected to '+TController(FController).DBEngine.Connection.Params.Values['Server'];
  Self.FormResize(Self);
  Self.LockControls;
  Self.N23Click(Self);
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  i: Integer;
begin
  i:=DBGrid1.Width;
  DBGrid1.Columns[0].Width:=Trunc(i*0.09);
  DBGrid1.Columns[1].Width:=Trunc(i*0.1);
  DBGrid1.Columns[2].Width:=Trunc(i*0.1);
  DBGrid1.Columns[3].Width:=Trunc(i*0.22);
  DBGrid1.Columns[4].Width:=Trunc(i*0.22);
  DBGrid1.Columns[5].Width:=Trunc(i*0.11);
  DBGrid1.Columns[6].Width:=Trunc(i*0.1);
end;

procedure TMainForm.N10Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\договор_юр.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N11Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\приложение_1.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N12Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\акт_поставки_товара.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N13Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\акт_приёма_передачи.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N14Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\акт_приёма_работ.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N15Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.xlsx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\счёт.xlsx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N16Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.xlsx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\приходной ордер.xlsx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N17Click(Sender: TObject);
begin
CompPrice:=tCompPrice.Create(Self);
CompPrice.ShowModal;
end;

procedure TMainForm.N18Click(Sender: TObject);
begin
GlassCalc:=tGlassCalc.Create(Self);
GlassCalc.ShowModal;
end;

procedure TMainForm.N20Click(Sender: TObject);
var
buttonSelected,i: Integer;
sql:string;
begin
{buttonSelected := MessageDlg('Провести сервис БД компоненты?',mtConfirmation, mbOKCancel, 0);
if buttonSelected = mrOK then
  begin
  try
    sql:='SELECT id FROM component_price WHERE id=1';
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add(sql);
    FDQuery.Open;
    except
    sql:='CREATE TABLE component_price (id COUNTER NOT NULL PRIMARY KEY, c_code CHAR(255), component_en CHAR(255), component_ru CHAR(255), Mill_Finish FLOAT, White FLOAT, Dark_Oak FLOAT, Anod_Inox FLOAT, Anod_Silver FLOAT, Unit FLOAT, price FLOAT)';
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add(sql);
    FDQuery.ExecSQL;

    adoconnection2.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=сервис/component_price.mdb;Persist Security Info=False';
    adoconnection2.Connected:=true;
    sql:='SELECT * FROM component_price';
    adoquery3.Close;
    adoquery3.SQL.Clear;
    adoquery3.SQL.Add(sql);
    adoquery3.Open;

    sql:='SELECT * FROM component_price';
    FDQuery.Close;
    FDQuery.SQL.Clear;
    FDQuery.SQL.Add(sql);
    FDQuery.Open;

    while adoquery3.Eof=false do
      begin
      FDQuery.Append;
      for i:=1 to adoquery3.FieldCount-1 do
        begin
        FDQuery.Fields[i]:=adoquery3.Fields[i];
        end;
      FDQuery.Post;
      adoquery3.Next;
      end;


    end;
  end; }
end;

procedure TMainForm.N21Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\приложение_2.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N22Click(Sender: TObject);
var
buttonSelected,i: Integer;
sql:string;
begin
{buttonSelected := MessageDlg('Провести сервис БД доп.материалы?',mtConfirmation, mbOKCancel, 0);
if buttonSelected = mrOK then
  begin
  adoconnection2.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=сервис/am.mdb;Persist Security Info=False';
  adoconnection2.Connected:=true;
  sql:='SELECT * FROM am_categories';
  adoquery3.Close;
  adoquery3.SQL.Clear;
  adoquery3.SQL.Add(sql);
  adoquery3.Open;

  sql:='ALTER TABLE am_categories ALTER COLUMN id INTEGER';
  FDQuery.Close;
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(sql);
  FDQuery.ExecSQL;
  sql:='DELETE FROM am_categories';
  FDQuery.Close;
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(sql);
  FDQuery.ExecSQL;
  sql:='SELECT * FROM am_categories';
  FDQuery.Close;
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(sql);
  FDQuery.Open;

  while adoquery3.Eof=false do
    begin
    FDQuery.Append;
    for i:=0 to adoquery3.FieldCount-1 do
      begin
      FDQuery.Fields[i]:=adoquery3.Fields[i];
      end;
    FDQuery.Post;
    adoquery3.Next;
    end;

  sql:='SELECT * FROM additional_materials';
  adoquery3.Close;
  adoquery3.SQL.Clear;
  adoquery3.SQL.Add(sql);
  adoquery3.Open;
  sql:='ALTER TABLE additional_materials ALTER COLUMN id INTEGER';
  FDQuery.Close;
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(sql);
  FDQuery.ExecSQL;
  sql:='DELETE FROM additional_materials';
  FDQuery.Close;
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(sql);
  FDQuery.ExecSQL;
  sql:='SELECT * FROM additional_materials';
  FDQuery.Close;
  FDQuery.SQL.Clear;
  FDQuery.SQL.Add(sql);
  FDQuery.Open;

  while adoquery3.Eof=false do
    begin
    FDQuery.Append;
    for i:=0 to adoquery3.FieldCount-1 do
      begin
      FDQuery.Fields[i]:=adoquery3.Fields[i];
      end;
    FDQuery.Post;
    adoquery3.Next;
    end;

  end; }
end;

procedure TMainForm.N23Click(Sender: TObject);
begin
  AuthForm:=TAuthForm.Create(MainForm);
  AuthForm.ShowModal;
end;

procedure TMainForm.N24Click(Sender: TObject);
begin
  frmUsers:=TfrmUsers.Create(Self);
  frmUsers.ShowModal;
end;

procedure TMainForm.N31Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\приложение_3.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N3Click(Sender: TObject);
begin
mode:='retail';
PL_Akr:=tPL_Akr.Create(Self);
PL_Akr.ShowModal;
end;

procedure TMainForm.N4Click(Sender: TObject);
begin
PL_AM:=tPL_AM.Create(Self);
PL_AM.ShowModal;
end;

procedure TMainForm.N5Click(Sender: TObject);
begin
AS_PL:=tAS_PL.Create(Self);
AS_PL.ShowModal;
end;

procedure TMainForm.N6Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\коммерческое предложение.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

procedure TMainForm.N8Click(Sender: TObject);
begin
mode:='dealer';
PL_Akr:=tPL_Akr.Create(Self);
PL_Akr.ShowModal;
end;

procedure TMainForm.N9Click(Sender: TObject);
var
s:string;
begin
  s:='TempFiles\TempTemplate.docx';
  if FileExists(s) then DeleteFile(s);
  IdFTP.Get('\шаблоны\договор_физ.docx', s);
  ShellExecute(Handle,nil,Pchar(s),nil,nil,SW_SHOW);
end;

end.
