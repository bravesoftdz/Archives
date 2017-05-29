unit vRules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cefvcl, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ImgList,
  API_MVC,
  API_ORM_Cntrls,
  eEntities;

type
  TEntityPanel = class(TEntityPanelAbstract)
  protected
    procedure InitPanel; override;
    procedure AfterEditChange(aEdit: TEdit);
  end;

  TViewRules = class(TViewAbstract)
    pnlBrowser: TPanel;
    pnlControls: TPanel;
    chrmBrowser: TChromium;
    pnlLevel: TPanel;
    cbbLevel: TComboBox;
    lbllevel: TLabel;
    btnAddLevel: TBitBtn;
    pnlTree: TPanel;
    pnlFields: TPanel;
    tvTree: TTreeView;
    btnAG: TBitBtn;
    ilIcons: TImageList;
    btnAR: TBitBtn;
    btnApply: TButton;
    btnCancel: TButton;
    btnDG: TBitBtn;
    procedure btnAGClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvTreeChange(Sender: TObject; Node: TTreeNode);
    procedure btnDGClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitView; override;
  public
    { Public declarations }
    pnlEntityFields: TEntityPanel;
    procedure SetLevels(aLevelList: TLevelList);
    procedure SetControlTree(aJobGroupList: TGroupList);
  end;

  // FBindData Item Keys
  // GroupNodes

var
  ViewRules: TViewRules;

implementation

{$R *.dfm}

uses
  System.UITypes,
  API_MVC_Bind;

procedure TEntityPanel.AfterEditChange(aEdit: TEdit);
begin
  ViewRules.tvTree.Selected.Text := aEdit.Text;
end;

procedure TEntityPanel.InitPanel;
begin
  OnAfterEditChange := AfterEditChange;
end;

procedure TViewRules.SetControlTree(aJobGroupList: TGroupList);
var
  Group: TJobGroup;
  Link: TJobLink;
  GroupNode, LinkNode: TTreeNode;
begin
  ViewRules.tvTree.Items.Clear;

  for Group in aJobGroupList do
    begin
      GroupNode := tvTree.Items.Add(nil, Group.Notes);
      GroupNode.ImageIndex := 0;

      for Link in Group.Links do
        begin
          LinkNode := tvTree.Items.AddChild(GroupNode, Link.Level.ToString);
          LinkNode.ImageIndex := 1;
        end;

      //FBindData.AddBind('GroupNodes', TreeNodes.Count - 1, Group.ID);
    end;
end;

procedure TViewRules.SetLevels(aLevelList: TLevelList);
var
  Level: TJobLevel;
begin
  for Level in aLevelList  do
    begin
      cbbLevel.Items.Add(Level.Level.ToString);
    end;

  cbbLevel.ItemIndex := 0;
  chrmBrowser.Load(Level.BaseLink);
end;

procedure TViewRules.tvTreeChange(Sender: TObject; Node: TTreeNode);
begin
  SendMessage('TreeNodeSelected');
end;

procedure TViewRules.btnAGClick(Sender: TObject);
begin
  SendMessage('CreateGroup');
end;

procedure TViewRules.btnApplyClick(Sender: TObject);
begin
  SendMessage('StoreJobRules');
end;

procedure TViewRules.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TViewRules.btnDGClick(Sender: TObject);
begin
  if MessageDlg('Are you sure?', mtConfirmation, [mbYes, mbCancel], 0) = mrYes then
    SendMessage('DeleteGroup');
end;

procedure TViewRules.FormCreate(Sender: TObject);
begin
  pnlEntityFields := TEntityPanel.Create(pnlFields);
end;

procedure TViewRules.InitView;
begin
  ViewRules := Self;
end;

end.
