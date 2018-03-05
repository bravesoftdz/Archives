unit vClientList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  API_MVC_FMX,
  eClient;

type
  TViewClientList = class(TViewFMXBase)
    lstClients: TListBox;
    btnBack: TButton;
    btnAddNew: TButton;
    btnEdit: TButton;
    procedure btnBackClick(Sender: TObject);
    procedure btnAddNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure lstClientsDblClick(Sender: TObject);
  private
    { Private declarations }
    function GetClientItem(aClient: TClient): TListBoxItem;
    function GetSelectedClient: TClient;
  public
    { Public declarations }
    procedure RemoveClient(aClient: TClient);
    procedure RenderClient(aClient: TClient);
    procedure RenderClientList(aClientList: TClientList);
    property SelectedClient: TClient read GetSelectedClient;
  end;

var
  ViewClientList: TViewClientList;

implementation

{$R *.fmx}

function TViewClientList.GetClientItem(aClient: TClient): TListBoxItem;
var
  i: Integer;
begin
  Result := nil;

  for i := 0 to lstClients.Count - 1 do
    if lstClients.ListItems[i].Data = aClient then
      Exit(lstClients.ListItems[i]);
end;

procedure TViewClientList.RemoveClient(aClient: TClient);
var
  ListBoxItem: TListBoxItem;
begin
  ListBoxItem := GetClientItem(aClient);

  if ListBoxItem <> nil then
    lstClients.Items.Delete(ListBoxItem.Index);
end;

function TViewClientList.GetSelectedClient: TClient;
begin
  Result := lstClients.Selected.Data as TClient;
end;

procedure TViewClientList.lstClientsDblClick(Sender: TObject);
begin
  inherited;

  SendMessage('ClientSelected');
end;

procedure TViewClientList.RenderClient(aClient: TClient);
var
  ClientText: string;
  ListBoxItem: TListBoxItem;
begin
  ClientText := Format('%s (%s)', [aClient.FullName, aClient.PassportNumber]);

  ListBoxItem := GetClientItem(aClient);

  if ListBoxItem = nil then
    lstClients.Items.AddObject(ClientText, aClient)
  else
    ListBoxItem.Text := ClientText;
end;

procedure TViewClientList.btnAddNewClick(Sender: TObject);
begin
  inherited;

  SendMessage('AddClient');
end;

procedure TViewClientList.btnBackClick(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure TViewClientList.btnEditClick(Sender: TObject);
begin
  inherited;

  SendMessage('EditClient');
end;

procedure TViewClientList.RenderClientList(aClientList: TClientList);
var
  Client: TClient;
begin
  for Client in aClientList do
    RenderClient(Client);
end;

end.
