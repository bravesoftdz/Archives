unit View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs
  ,API_MVC, Vcl.StdCtrls, ExcelXP, Vcl.OleServer;

type
  TfrmView = class(TViewAbstract)
    btnStart: TButton;
    lblNum: TLabel;
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitMVC; override;
  public
    { Public declarations }
  end;

var
  frmView: TfrmView;

implementation

{$R *.dfm}
uses
  Controller;

procedure TfrmView.btnStartClick(Sender: TObject);
begin
  Self.FController.SendViewMessage('vmStartImport');
end;

procedure TfrmView.InitMVC;
begin
  Self.FControllerClass:=TController;
end;

end.
