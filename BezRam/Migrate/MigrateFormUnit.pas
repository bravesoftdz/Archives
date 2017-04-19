unit MigrateFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls
  ,API_MVC;

type
  TfrmMigrate = class(TViewAbstract)
    ProgressBar: TProgressBar;
    lblTableName: TLabel;
    lblTableNameValue: TLabel;
    lblProcessed: TLabel;
    lblRecNum: TLabel;
    lblFrom: TLabel;
    lblRecCount: TLabel;
    btnClose: TButton;
    btnStart: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitMVC; override;
  public
    { Public declarations }
  end;

var
  frmMigrate: TfrmMigrate;

implementation

{$R *.dfm}

uses Controllers;

procedure TfrmMigrate.InitMVC;
begin
  FControllerClass:=TController;
end;

procedure TfrmMigrate.btnCloseClick(Sender: TObject);
begin
  Self.Close;
  Self.Release;
end;

procedure TfrmMigrate.btnStartClick(Sender: TObject);
begin
  Self.btnStart.Enabled:=False;
  Self.btnClose.Enabled:=False;
  Application.ProcessMessages;
  Self.FController.SendViewMessage('MigrateData');
  Self.btnStart.Enabled:=True;
  Self.btnClose.Enabled:=True;
end;

end.
