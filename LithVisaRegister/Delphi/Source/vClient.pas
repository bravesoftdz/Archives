unit vClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  API_MVC_FMX,
  API_ORM_BindFMX, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation;

type
  TViewClent = class(TViewFMXBase)
    lblFirstName: TLabel;
    bcFirstName: TEdit;
    lblLastName: TLabel;
    bcLastName: TEdit;
    lblPassportNumber: TLabel;
    bcPassportNumber: TEdit;
    lblRepresentedBy: TLabel;
    bcRepresentedBy: TComboBox;
    btnBack: TButton;
    btnSave: TButton;
    btnDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FBind: TORMBindFMX;
  public
    { Public declarations }
    property Bind: TORMBindFMX read FBind;
  end;

var
  ViewClent: TViewClent;

implementation

{$R *.fmx}

uses
  API_ORM;

procedure TViewClent.btnDeleteClick(Sender: TObject);
begin
  inherited;

  Close;
  SendMessage('RemoveClient');
end;

procedure TViewClent.FormCreate(Sender: TObject);
begin
  inherited;

  FBind := TORMBindFMX.Create(Self);
end;

procedure TViewClent.FormDestroy(Sender: TObject);
begin
  inherited;

  FBind.Free;
end;

procedure TViewClent.FormShow(Sender: TObject);
var
  Entity: TEntityAbstract;
begin
  inherited;

  Entity := Bind.Entity[bcFirstName];
  if not Entity.IsNewInstance then
    btnDelete.Enabled := True;
end;

end.
