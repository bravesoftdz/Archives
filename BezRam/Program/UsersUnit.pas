unit UsersUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs
  ,API_MVC, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TfrmUsers = class(TViewAbstract)
    dbgrdUsers: TDBGrid;
    dsrUsers: TDataSource;
    dsUsers: TFDQuery;
    lblAppend: TLabel;
    lblEdit: TLabel;
    lblDelete: TLabel;
    btnApply: TButton;
    btnCancel: TButton;
    FDUpdateSQL: TFDUpdateSQL;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure lblAppendMouseEnter(Sender: TObject);
    procedure lblAppendMouseLeave(Sender: TObject);
    procedure lblAppendClick(Sender: TObject);
    procedure lblEditMouseEnter(Sender: TObject);
    procedure lblEditMouseLeave(Sender: TObject);
    procedure lblEditClick(Sender: TObject);
    procedure lblDeleteMouseEnter(Sender: TObject);
    procedure lblDeleteMouseLeave(Sender: TObject);
    procedure lblDeleteClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure dbgrdUsersTitleClick(Column: TColumn);
  private
    { Private declarations }
    procedure InitMVC; override;
    procedure CallUserForm;
  public
    { Public declarations }
  end;

var
  frmUsers: TfrmUsers;

implementation

{$R *.dfm}

uses
   Controllers
  ,ViewUserData
  ,MainFormUnit;

procedure TfrmUsers.CallUserForm;
begin
  frmUser:=TfrmUser.Create(Self);
  try
    if frmUser.ShowModal=mrOk then dsUsers.Post
    else dsUsers.Cancel;
  finally
    frmUser.Close;
    frmUser.Release;
  end;
end;

procedure TfrmUsers.dbgrdUsersTitleClick(Column: TColumn);
begin
  dsUsers.IndexFieldNames:=Column.FieldName;
end;

procedure TfrmUsers.btnApplyClick(Sender: TObject);
var
  sql: string;
begin
  sql:='INSERT INTO users (login, password, name, access_type) VALUES (:new_login, :new_password, :new_name, :new_access_type)';
  FDUpdateSQL.InsertSQL.Text:=sql;
  sql:='UPDATE users SET login = :new_login, password = :new_password, name = :new_name, access_type = :new_access_type WHERE id = :old_id';
  FDUpdateSQL.ModifySQL.Text:=sql;
  sql:='DELETE FROM users WHERE id = :old_id';
  FDUpdateSQL.DeleteSQL.Text:=sql;
  dsUsers.UpdateOptions.UpdateNonBaseFields:=False;
  dsUsers.ApplyUpdates(0);
  btnCancel.Click;
end;

procedure TfrmUsers.btnCancelClick(Sender: TObject);
begin
  Self.Close;
  Self.Release;
end;

procedure TfrmUsers.FormActivate(Sender: TObject);
begin
  dsUsers.Connection:=MainForm.Connection;
  FDUpdateSQL.Connection:=MainForm.Connection;
  Self.FController.SendViewMessage('vmGetUsers');
end;

procedure TfrmUsers.InitMVC;
begin
  FControllerClass:=TController;
end;

procedure TfrmUsers.lblAppendClick(Sender: TObject);
begin
  dsUsers.Append;
  Self.CallUserForm;
end;

procedure TfrmUsers.lblAppendMouseEnter(Sender: TObject);
begin
  lblAppend.Font.Style:=[fsUnderline];
end;

procedure TfrmUsers.lblAppendMouseLeave(Sender: TObject);
begin
  lblAppend.Font.Style:=[];
end;

procedure TfrmUsers.lblDeleteClick(Sender: TObject);
var
  buttonSelected : Integer;
begin
  buttonSelected := MessageDlg('Вы уверены?',mtConfirmation, mbOKCancel, 0);

  if buttonSelected = mrOK then
    begin
      dsUsers.Edit;
      dsUsers.Delete;
    end;
end;

procedure TfrmUsers.lblDeleteMouseEnter(Sender: TObject);
begin
  lblDelete.Font.Style:=[fsUnderline];
end;

procedure TfrmUsers.lblDeleteMouseLeave(Sender: TObject);
begin
  lblDelete.Font.Style:=[];
end;

procedure TfrmUsers.lblEditClick(Sender: TObject);
begin
  dsUsers.Edit;
  Self.CallUserForm;
end;

procedure TfrmUsers.lblEditMouseEnter(Sender: TObject);
begin
  lblEdit.Font.Style:=[fsUnderline];
end;

procedure TfrmUsers.lblEditMouseLeave(Sender: TObject);
begin
  lblEdit.Font.Style:=[];
end;

end.
