unit vMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  API_MVC,
  API_MVC_FMX, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  FMX.Edit;

type
  TViewMain = class(TViewFMXBase)
    edtEmail: TEdit;
    edtPhone: TEdit;
    lstClients: TListBox;
    btnStart: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitMVC(var aControllerClass: TControllerClass); override;
  public
    { Public declarations }
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.fmx}

uses
  cController;

procedure TViewMain.btn1Click(Sender: TObject);
begin
  inherited;

  SendMessage('Test');
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
  inherited;

  SendMessage('LoadRegister');
end;

procedure TViewMain.InitMVC(var aControllerClass: TControllerClass);
begin
  aControllerClass := TController;
  ViewMain := Self;
end;

end.
