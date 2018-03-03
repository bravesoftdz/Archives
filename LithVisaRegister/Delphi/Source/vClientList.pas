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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RenderClientList(aClientList: TClientList);
  end;

var
  ViewClientList: TViewClientList;

implementation

{$R *.fmx}

procedure TViewClientList.RenderClientList(aClientList: TClientList);
var
  Client: TClient;
begin
  for Client in aClientList do
    lstClients.Items.AddObject(Client.FullName, Client);
end;

end.
