unit vMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Edit,
  API_MVC,
  API_MVC_FMX,
  API_ORM_BindFMX;

type
  TViewMain = class(TViewFMXBase)
    bcEmail: TEdit;
    bcPhone: TEdit;
    lstClients: TListBox;
    btnStart: TButton;
    btnAddClient: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddClientClick(Sender: TObject);
  private
    { Private declarations }
    FBind: TORMBindFMX;
  protected
    procedure InitMVC(var aControllerClass: TControllerClass); override;
  public
    { Public declarations }
    property Bind: TORMBindFMX read FBind;
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

procedure TViewMain.btnAddClientClick(Sender: TObject);
begin
  inherited;

  SendMessage('AddClient');
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
  inherited;

  FBind := TORMBindFMX.Create(Self);

  SendMessage('LoadRegister');
end;

procedure TViewMain.FormDestroy(Sender: TObject);
begin
  inherited;

  FBind.Free;
end;

procedure TViewMain.InitMVC(var aControllerClass: TControllerClass);
begin
  aControllerClass := TController;
  ViewMain := Self;
end;

end.
