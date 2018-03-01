unit cController;

interface

uses
  API_DB,
  API_MVC_FMXDB,
  eRegister;

type
  TController = class(TControllerFMXDB)
  private
    FCurrRegister: TRegister;
    function GetCurrentRegister: TRegister;
  protected
    procedure AfterCreate; override;
    procedure BeforeDestroy; override;
    procedure InitDB(var aDBEngineClass: TDBEngineClass; out aConnectParams: TConnectParams;
      out aConnectOnCreate: Boolean); override;
  published
    procedure LoadRegister;
    procedure Test;
  end;

var
  DBEngine: TDBEngine;

implementation

uses
  API_DB_SQLite,
  eClient;

procedure TController.BeforeDestroy;
begin
  if Assigned(FCurrRegister) then
    begin
      FCurrRegister.StoreAll;
      FCurrRegister.Free;
    end;
end;

function TController.GetCurrentRegister: TRegister;
var
  RegisterList: TRegisterList;
begin
  RegisterList := TRegisterList.Create(['STATE=1'], []);
  try
    if RegisterList.Count = 1 then
      Result := RegisterList.Extract(RegisterList[0])
    else
      begin
        Result := TRegister.Create;
        Result.State := 1;
      end;
  finally
    RegisterList.Free;
  end;
end;

procedure TController.LoadRegister;
begin
  FCurrRegister := GetCurrentRegister;
end;

procedure TController.Test;
var
  Client: TClient;
begin
  Client := TClient.Create;
  try
    Client.FirstName := 'VASIA';
    Client.LastName := 'PUPKIN';
    Client.PassportNumber := 'MC34345345';
    Client.RepresentedBy := rtPersonally;

    Client.Store;
  finally
    Client.Free;
  end;
end;

procedure TController.AfterCreate;
begin
  cController.DBEngine := Self.DBEngine;
end;

procedure TController.InitDB(var aDBEngineClass: TDBEngineClass;
  out aConnectParams: TConnectParams; out aConnectOnCreate: Boolean);
begin
  aDBEngineClass := TSQLiteEngine;
  aConnectOnCreate := True;
  aConnectParams.DataBase := 'D:\Git\Archives\LithVisaRegister\DB\local.db';
end;

end.
