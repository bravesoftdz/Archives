unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw
  ,API_DBases, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls;

type
  TForm1 = class(TForm)
    btnStartJob: TButton;
    dbgrdJobs: TDBGrid;
    dbgrdLevels: TDBGrid;
    dbgrdLinks: TDBGrid;
    dbgrdRecords: TDBGrid;
    dbgrdNodes: TDBGrid;
    fdtblJobs: TFDTable;
    dsJobs: TDataSource;
    lblJobs: TLabel;
    lblZeroLink: TLabel;
    dbmmoZeroLink: TDBMemo;
    procedure btnStartJobClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FMySQLEngine: TMySQLEngine;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
   API_Files
  ,API_Parse;

procedure TForm1.btnStartJobClick(Sender: TObject);
var
  ParserModel: TParserModel;
begin
  ParserModel:=TParserModel.Create;
  try
    ParserModel.StartJob(1);
  finally
    //ParserModel.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FMySQLEngine:=TMySQLEngine.Create;
  FMySQLEngine.OpenConnection('MySQL.ini');

  fdtblJobs.Connection:=FMySQLEngine.Connection;
  fdtblJobs.Open('jobs');
end;

end.
