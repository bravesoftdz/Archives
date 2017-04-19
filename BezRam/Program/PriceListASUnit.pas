unit PriceListASUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Data.Win.ADODB, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TAS_PL = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    FDQuery1: TFDQuery;
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label2MouseEnter(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3MouseEnter(Sender: TObject);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Label1Click(Sender: TObject);
    procedure Label1MouseEnter(Sender: TObject);
    procedure Label1MouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AS_PL: TAS_PL;

implementation

{$R *.dfm}

uses MainFormUnit, Unit9;

procedure TAS_PL.Button1Click(Sender: TObject);
begin
if FDQuery1.State<>dsbrowse then FDQuery1.Post;
button2.Click;
end;

procedure TAS_PL.Button2Click(Sender: TObject);
begin
FDQuery1.Cancel;
AS_PL.Close;
AS_PL.Release;
end;

procedure TAS_PL.DBGrid1TitleClick(Column: TColumn);
begin
  FDQuery1.IndexFieldNames:=Column.FieldName;
end;

procedure TAS_PL.FormActivate(Sender: TObject);
var
sql:string;
begin
  FDQuery1.Connection:=MainForm.Connection;

sql:='SELECT * FROM additional_services';
FDQuery1.Close;
FDQuery1.SQL.Clear;
FDQuery1.SQL.Add(sql);
FDQuery1.Open;
end;

procedure TAS_PL.Label1Click(Sender: TObject);
begin
  FDQuery1.Append;
end;

procedure TAS_PL.Label1MouseEnter(Sender: TObject);
begin
  Label1.Font.Style:=[fsUnderline];
end;

procedure TAS_PL.Label1MouseLeave(Sender: TObject);
begin
  Label1.Font.Style:=[];
end;

procedure TAS_PL.Label2Click(Sender: TObject);
var
buttonSelected : Integer;
begin
buttonSelected := MessageDlg('Вы уверены?',mtConfirmation, mbOKCancel, 0);

if buttonSelected = mrOK then
  begin
  FDQuery1.Delete;
  end;
end;

procedure TAS_PL.Label2MouseEnter(Sender: TObject);
begin
Label2.Font.Style:=[fsUnderline];
end;

procedure TAS_PL.Label2MouseLeave(Sender: TObject);
begin
Label2.Font.Style:=[];
end;

procedure TAS_PL.Label3Click(Sender: TObject);
begin
mode:='AS_PL';
pl_pas:=tpl_pas.Create(nil);
pl_pas.ShowModal;
end;

procedure TAS_PL.Label3MouseEnter(Sender: TObject);
begin
Label3.Font.Style:=[fsUnderline];
end;

procedure TAS_PL.Label3MouseLeave(Sender: TObject);
begin
Label3.Font.Style:=[];
end;

end.
