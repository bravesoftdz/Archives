unit vMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox, FMX.Edit,
  API_MVC,
  API_MVC_FMX,
  API_ORM_BindFMX,
  eClient;

type
  TViewMain = class(TViewFMXBase)
    bcEmail: TEdit;
    bcPhone: TEdit;
    lstClients: TListBox;
    btnStart: TButton;
    btnSelectClient: TButton;
    btnUnselectClient: TButton;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSelectClientClick(Sender: TObject);
    procedure btnUnselectClientClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
    FBind: TORMBindFMX;
    function GetSelectedClientRel: TClientRel;
  protected
    procedure InitMVC(var aControllerClass: TControllerClass); override;
  public
    { Public declarations }
    procedure RenderRegisterClients(aClientRelList: TClientRelList);
    property Bind: TORMBindFMX read FBind;
    property SelectedClientRel: TClientRel read GetSelectedClientRel;
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.fmx}

uses
  cController;

function TViewMain.GetSelectedClientRel: TClientRel;
begin
  Result := lstClients.Selected.Data as TClientRel;
end;

procedure TViewMain.RenderRegisterClients(aClientRelList: TClientRelList);
var
  ClientRel: TClientRel;
  ClientText: string;
begin
  lstClients.Items.Clear;

  for ClientRel in aClientRelList do
    begin
      ClientText := Format('%s (%s)', [ClientRel.Client.FullName, ClientRel.Client.PassportNumber]);

      lstClients.Items.AddObject(ClientText, ClientRel);
    end;
end;

procedure TViewMain.btn1Click(Sender: TObject);
begin
  inherited;

  SendMessage('Test');
end;

procedure TViewMain.btnSelectClientClick(Sender: TObject);
begin
  inherited;

  SendMessage('SelectClient');
end;

procedure TViewMain.btnStartClick(Sender: TObject);
begin
  inherited;

  SendMessage('StartRegister');
end;

procedure TViewMain.btnUnselectClientClick(Sender: TObject);
begin
  inherited;

  SendMessage('UnselectClient');
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
