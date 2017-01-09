unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw
  ,API_DBases, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.ExtCtrls;

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
    lbl1: TLabel;
    fdtblLevels: TFDTable;
    dsLevels: TDataSource;
    dbgrdRules: TDBGrid;
    lblRules: TLabel;
    bvl1: TBevel;
    fdtblRules: TFDTable;
    dsRules: TDataSource;
    lblLinks: TLabel;
    fdtblLink: TFDTable;
    dslink: TDataSource;
    lblRecords: TLabel;
    fdtblRecord: TFDTable;
    dsRecord: TDataSource;
    lblNodes: TLabel;
    dsNodes: TDataSource;
    fdtblNodes: TFDTable;
    mmo1: TMemo;
    btnParseNodes: TButton;
    dbgrdRegExps: TDBGrid;
    dsRegExps: TDataSource;
    fdtblRegExps: TFDTable;
    lblRegExps: TLabel;
    procedure btnStartJobClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnParseNodesClick(Sender: TObject);
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
   Model
  ,System.JSON;

procedure TForm1.btnParseNodesClick(Sender: TObject);
var
  jsnNodes: TJSONArray;
  jsnNode: TJSONObject;
  jsnValue: TJSONValue;
  dsQuery: TFDQuery;
  sql: string;
begin
  dsQuery:=TFDQuery.Create(nil);
  jsnNodes:=TJSONObject.ParseJSONValue(mmo1.Text) as TJSONArray;
  try
    for jsnValue in jsnNodes do
      begin
        jsnNode:=jsnValue as TJSONObject;
        sql:='insert into job_nodes set';

        sql:=sql + ' job_rule_id=' + AnsiQuotedStr(fdtblRules.FieldByName('Id').AsString, #34);
        sql:=sql + ',tag=' + AnsiQuotedStr(jsnNode.GetValue('tag').Value, #34);
        sql:=sql + ',job_nodes.index=' + AnsiQuotedStr(jsnNode.GetValue('index').Value, #34);
        if Assigned(jsnNode.GetValue('tagID')) then
          sql:=sql + ',tag_id=' + AnsiQuotedStr(jsnNode.GetValue('tagID').Value, #34);
        if Assigned(jsnNode.GetValue('className')) then
          sql:=sql + ',class=' + AnsiQuotedStr(jsnNode.GetValue('className').Value, #34);
        if Assigned(jsnNode.GetValue('name')) then
          sql:=sql + ',name=' + AnsiQuotedStr(jsnNode.GetValue('name').Value, #34);

        dsQuery.Close;
        dsQuery.SQL.Text:=sql;
        FMySQLEngine.ExecQuery(dsQuery);

        fdtblNodes.Active:=False;
        fdtblNodes.Active:=True;
      end;
  finally
    dsQuery.Free;
    jsnNodes.Free;
  end;
end;

procedure TForm1.btnStartJobClick(Sender: TObject);
var
  Model: TPIAModel;
begin
  Model:=TPIAModel.Create(fdtblJobs.FieldByName('Id').AsInteger);
  Model.StartJob;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FMySQLEngine:=TMySQLEngine.Create;
  FMySQLEngine.OpenConnection('MySQL.ini');

  fdtblJobs.Connection:=FMySQLEngine.Connection;
  fdtblLevels.Connection:=FMySQLEngine.Connection;
  fdtblRules.Connection:=FMySQLEngine.Connection;
  fdtblLink.Connection:=FMySQLEngine.Connection;
  fdtblRecord.Connection:=FMySQLEngine.Connection;
  fdtblNodes.Connection:=FMySQLEngine.Connection;
  fdtblRegExps.Connection:=FMySQLEngine.Connection;

  fdtblJobs.Open('jobs');
  fdtblLevels.Open('job_levels');
  fdtblRules.Open('job_rules');
  fdtblLink.Open('job_rule_links');
  fdtblRecord.Open('job_rule_records');
  fdtblNodes.Open('job_nodes');
  fdtblRegExps.Open('job_regexp');
end;

end.
