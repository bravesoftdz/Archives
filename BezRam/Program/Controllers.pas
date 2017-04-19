unit Controllers;

interface

uses
   API_MVC
  ,API_DBases
  ,API_DBModels
  ,System.Classes
  ,System.SysUtils
  ,System.Generics.Collections
  ,Vcl.Forms
  ,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP;

type
  TController = class(TControllerAbstract)
  private
    procedure InitController; override;
    procedure PrepareModel(aMessage: string); override;
    procedure EventListener(EventName: string; EventData: TDictionary<string,variant>); override;
    procedure FTPOpenConnection(aIdFTP: TIdFTP; aFileName: String);
    function GetUserId: Integer;
  public
    property UserId: Integer read GetUserId;
    property DBEngine: TDBEngine read FDBEngine;
    property Settings: TStringList read FSettings;
  end;

implementation

uses
   Vcl.Dialogs
  ,Models
  ,MigrateFormUnit
  ,AuthFormUnit
  ,MainFormUnit
  ,OrderFormUnit
  ,CustomersFormUnit
  ,UsersUnit;

procedure TController.FTPOpenConnection(aIdFTP: TIdFTP; aFileName: String);
var
  ConnectParams: TStringList;
begin
  ConnectParams:=TStringList.Create;
  try
    ConnectParams.LoadFromFile(aFileName);
    aIdFTP.Host:=ConnectParams.Values['Host'];
    aIdFTP.Port:=ConnectParams.Values['Port'].ToInteger;
    aIdFTP.Username:=ConnectParams.Values['Username'];
    aIdFTP.Password:=ConnectParams.Values['Password'];
    try
      aIdFTP.Connect;
    except
      On E : Exception do
        begin
          ShowMessage('Не удалось подключиться с серверу FTP');
        end;
    end;
  finally
    ConnectParams.Free;
  end;
end;

function TController.GetUserId: Integer;
begin
  Result:=FGlobals['user_id'];
end;

procedure TController.EventListener(EventName: string; EventData: TDictionary<System.string,System.Variant>);
var
  sql: string;
begin
  if EventName='AuthFail' then
    begin
      ShowMessage('Ошибка авторизации');
    end;

  if EventName='AuthOK' then
    begin
      MainForm.statConnectInfo.Panels.Items[1].Text:='Пользователь: ' + EventData.Items['user_name'];
      MainForm.UnlockControls;
      if EventData.Items['access_type']=1 then MainForm.MainMenu1.Items[4].Items[1].Enabled:=True
      else MainForm.MainMenu1.Items[4].Items[1].Enabled:=False;

      FGlobals.AddOrSetValue('user_id',EventData.Items['user_id']);
      AuthForm.isReleased:=True;
      sql:='SELECT * FROM orders JOIN customers ON orders.customer_id=customers.id LEFT JOIN users ON orders.user_id=users.id ORDER BY orders.id DESC';
      FDBEngine.GetData(MainForm.dsOrders,sql);
    end;

  Application.ProcessMessages;
end;

procedure TController.InitController;
var
  ConnectFileName: string;
begin
  // указываем файл настроек
  FSettingFileName:='Settings\Settings.ini';

  // подключаемся к БД MySQL
  ConnectFileName:='Settings\MySQL.ini';
  FDBEngine:=TMySQLEngine.Create;
  TMySQLEngine(FDBEngine).OpenConnection(ConnectFileName);

  MainForm.Connection:=FDBEngine.Connection;

  // подключаемся к FTP
  ConnectFileName:='Settings\FTP.ini';
  Self.FTPOpenConnection(MainForm.IdFTP, ConnectFileName);
end;

procedure TController.PrepareModel(aMessage: string);
var
  MSAccessEngine: TAccessEngine;
begin
  if aMessage='SetAuth' then
    begin
      Self.FData.Add('login',AuthForm.edtLogin.Text);
      Self.FData.Add('password',AuthForm.edtPasw.Text);
      Self.CallModel(TAuthModel);
    end;

  if aMessage='vmGetCustomers' then
    begin
      Self.FObjData.Add('FDQuery',frmCustomers.dsCustomers);
      Self.CallModel(TCustomersModel);
    end;

  if aMessage='vmGetUsers' then
    begin
      Self.FObjData.Add('FDQuery',frmUsers.dsUsers);
      Self.CallModel(TUsersModel);
    end;
end;

end.
