unit CustomersFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs
  ,API_MVC, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmCustomers = class(TViewAbstract)
    dbgrdCustomers: TDBGrid;
    btnApply: TButton;
    btnCancel: TButton;
    dsCustomers: TFDQuery;
    dsrCustomers: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure dbgrdCustomersTitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustomers: TfrmCustomers;

implementation

{$R *.dfm}

procedure TfrmCustomers.dbgrdCustomersTitleClick(Column: TColumn);
begin
  dsCustomers.IndexFieldNames:=Column.FieldName;
end;

procedure TfrmCustomers.FormActivate(Sender: TObject);
begin
  Self.FController.SendViewMessage('vmGetCustomers');
end;

end.
