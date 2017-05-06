unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  API_MVC;

type
  TViewMain = class(TViewAbstract)
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitMVC; override;
  public
    { Public declarations }
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

uses
  cController;

procedure TViewMain.FormActivate(Sender: TObject);
begin
  Self.SendMessage('ShowViewLogin');
end;

procedure TViewMain.InitMVC;
begin
  FControllerClass := TController;
end;

end.
