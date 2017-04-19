unit PriceListAkrUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TPL_AKR = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    dsPriceList: TFDQuery;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PL_AKR: TPL_AKR;

implementation

{$R *.dfm}

uses MainFormUnit, Unit9;

procedure TPL_AKR.Button1Click(Sender: TObject);
begin
if dsPriceList.State<>dsbrowse then dsPriceList.Post;
button2.Click;
end;

procedure TPL_AKR.Button2Click(Sender: TObject);
begin
PL_AKR.Close;
PL_AKR.Release;
end;

procedure TPL_AKR.DBGrid1TitleClick(Column: TColumn);
begin
  dsPriceList.IndexFieldNames:=Column.FieldName;
end;

procedure TPL_AKR.FormActivate(Sender: TObject);
var
sql:string;
begin
  dsPriceList.Connection:=MainForm.Connection;

if mode='retail' then  sql:='SELECT * FROM glass_price ORDER BY height_meters';
if mode='dealer' then  sql:='SELECT * FROM glass_price_dealer ORDER BY height_meters';
dsPriceList.Close;
dsPriceList.SQL.Clear;
dsPriceList.SQL.Add(sql);
dsPriceList.Open;
end;

procedure TPL_AKR.Label1Click(Sender: TObject);
begin
mode:='PL_AKR';
pl_pas:=tpl_pas.Create(nil);
pl_pas.ShowModal;
end;

procedure TPL_AKR.Label1MouseEnter(Sender: TObject);
begin
Label1.Font.Style:=[fsUnderline];
end;

procedure TPL_AKR.Label1MouseLeave(Sender: TObject);
begin
Label1.Font.Style:=[];
end;

end.
