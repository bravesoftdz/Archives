unit View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs
  ,API_MVC, Vcl.StdCtrls;

type
  TfrmView = class(TViewAbstract)
    btnStart: TButton;
    lblNum: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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
  Self.FController.SendViewMessage('vmStartExport');
end;

procedure TfrmView.FormActivate(Sender: TObject);
var
  s:string;
begin
  // запуск с командной строки
  s:=ParamStr(1);
  if not s.IsEmpty then
    begin
      btnStart.Click;
      Self.Close;
      Self.Release;
    end;
end;

procedure TfrmView.InitMVC;
begin
  Self.FControllerClass:=TController;
end;

end.
