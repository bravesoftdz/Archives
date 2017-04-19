unit CalcCompFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Data.DB, Data.Win.ADODB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TCompPrice = class(TForm)
    DBGrid1: TDBGrid;
    Button2: TButton;
    Button1: TButton;
    DataSource1: TDataSource;
    Label1: TLabel;
    FDQuery1: TFDQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompPrice: TCompPrice;

implementation

{$R *.dfm}

uses MainFormUnit;

procedure TCompPrice.Button1Click(Sender: TObject);
begin
FDQuery1.Edit;
FDQuery1.Post;
button2.Click;
end;

procedure TCompPrice.Button2Click(Sender: TObject);
begin
CompPrice.Close;
CompPrice.Release;
end;

procedure TCompPrice.DBGrid1TitleClick(Column: TColumn);
begin
  FDQuery1.IndexFieldNames:=Column.FieldName;
end;

procedure TCompPrice.FormActivate(Sender: TObject);
var
sql:string;
begin
  FDQuery1.Connection:=MainForm.Connection;

sql:='SELECT * FROM component_price';
FDQuery1.Close;
FDQuery1.SQL.Clear;
FDQuery1.SQL.Add(sql);
FDQuery1.Open;
end;

procedure TCompPrice.Label1Click(Sender: TObject);
var
buttonSelected : Integer;
begin
buttonSelected := MessageDlg('Вы уверены?',mtConfirmation, mbOKCancel, 0);

if buttonSelected = mrOK then
  begin
  FDQuery1.Edit;
  FDQuery1.Delete;
  end;
end;

procedure TCompPrice.Label1MouseEnter(Sender: TObject);
begin
Label1.Font.Style:=[fsUnderline];
end;

procedure TCompPrice.Label1MouseLeave(Sender: TObject);
begin
Label1.Font.Style:=[];
end;

end.
