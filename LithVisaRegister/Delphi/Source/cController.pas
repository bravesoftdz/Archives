unit cController;

interface

uses
  API_DB,
  API_MVC_FMXDB,
  eClient,
  eRegister;

type
  TController = class(TControllerFMXDB)
  private
    FClientList: TClientList;
    FCurrRegister: TRegister;
    function FillClient(aClient: TClient): Boolean;
    function GetCurrentRegister: TRegister;
  protected
    procedure AfterCreate; override;
    procedure BeforeDestroy; override;
    procedure InitDB(var aDBEngineClass: TDBEngineClass; out aConnectParams: TConnectParams;
      out aConnectOnCreate: Boolean); override;
  published
    procedure AddClient;
    procedure ClientSelected;
    procedure EditClient;
    procedure LoadRegister;
    procedure RemoveClient;
    procedure SelectClient;
    procedure Test;
    procedure ViewClientListClosed;
  end;

var
  DBEngine: TDBEngine;

implementation

uses
  API_DB_SQLite,
  eContact,
  System.SysUtils,
  System.UITypes,
  vClient,
  vClientList,
  vMain;

procedure TController.ClientSelected;
var
  AlreadyInList: Boolean;
  Client: TClient;
  ClientRel: TClientRel;
begin
  Client := ViewClientList.SelectedClient;
  ViewClientList.Close;

  AlreadyInList := False;
  for ClientRel in FCurrRegister.ClRelList do
    if ClientRel.ClientID = Client.ID then
      AlreadyInList := True;

  if not AlreadyInList then
    begin
      ClientRel := TClientRel.Create;
      ClientRel.ClientID := Client.ID;
      ClientRel.Num := FCurrRegister.ClRelList.Count + 1;

      FCurrRegister.ClRelList.Add(ClientRel);
      FCurrRegister.StoreAll;
    end;
end;

procedure TController.RemoveClient;
var
  Client: TClient;
begin
  Client := ViewClientList.SelectedClient;

  Client.Delete;
  FClientList.Remove(Client);
  ViewClientList.RemoveClient(Client);
end;

function TController.FillClient(aClient: TClient): Boolean;
begin
  ViewClent := FMX.CreateView<TViewClent>(False);
  ViewClent.Bind.BindEntity(aClient);

  if ViewClent.ShowModal = mrOK then
    Result := True
  else
    Result := False;
end;

procedure TController.EditClient;
var
  Client: TClient;
begin
  Client := ViewClientList.SelectedClient;

  if FillClient(Client) then
    begin
      Client.Store;
      ViewClientList.RenderClient(Client);
    end
  else
    Client.Revert;
end;

procedure TController.ViewClientListClosed;
begin
  FClientList.Free;
end;

procedure TController.AddClient;
var
  Client: TClient;
begin
  Client := TClient.Create;

  if FillClient(Client) then
    begin
      FClientList.Add(Client);
      Client.Store;
      ViewClientList.RenderClient(Client);
    end
  else
    Client.Free;
end;

procedure TController.SelectClient;
begin
  FClientList := TClientList.Create(['*'], ['FIRST_NAME']);

  ViewClientList := FMX.CreateView<TViewClientList>;
  ViewClientList.RenderClientList(FClientList);

  ViewClientList.Show;
end;

procedure TController.BeforeDestroy;
begin
  if Assigned(FCurrRegister) then
    begin
      if (FCurrRegister.Contact <> nil) and
          FCurrRegister.Contact.Email.IsEmpty and
          FCurrRegister.Contact.Phone.IsEmpty
      then
        begin
          FCurrRegister.Contact.Free;
          FCurrRegister.Contact := nil;
        end;

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

  if Result.Contact = nil then
    Result.Contact := TContact.Create;
end;

procedure TController.LoadRegister;
begin
  FCurrRegister := GetCurrentRegister;
  ViewMain.Bind.BindEntity(FCurrRegister.Contact);
  ViewMain.RenderRegisterClients(FCurrRegister.ClRelList);
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
