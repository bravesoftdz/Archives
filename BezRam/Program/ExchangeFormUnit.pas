unit ExchangeFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Data.Win.ADODB,
  Vcl.ComCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TExchange = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    DateTimePicker1: TDateTimePicker;
    Edit1: TEdit;
    FDQuery1: TFDQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Exchange: TExchange;

implementation

{$R *.dfm}

uses OrderFormUnit, MainFormUnit;

procedure TExchange.Button1Click(Sender: TObject);
var
sql,val:string;
begin
if (edit1.Text<>FDQuery1.FieldByName('eur_rur').AsString) and (strtofloatdef(edit1.Text,0)>0) then
  begin
  val:=edit1.Text;
  while pos(',',val)>0 do
  val[pos(',',val)]:='.';
  sql:='INSERT INTO currency_exchange (actual_date, eur_rur) VALUES ("'+datetostr(datetimepicker1.Date)+'",'+val+')';
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add(sql);
  FDQuery1.ExecSQL;
  end;
button2.Click;
end;

procedure TExchange.Button2Click(Sender: TObject);
begin
Exchange.Close;
Exchange.Release;
end;

procedure TExchange.FormActivate(Sender: TObject);
var
sql:string;
begin
  FDQuery1.Connection:=MainForm.Connection;

sql:='SELECT * FROM currency_exchange ORDER BY id DESC';
FDQuery1.Close;
FDQuery1.SQL.Clear;
FDQuery1.SQL.Add(sql);
FDQuery1.Open;

edit1.Text:=FDQuery1.FieldByName('eur_rur').AsString;
datetimepicker1.Date:=now;
end;

end.
