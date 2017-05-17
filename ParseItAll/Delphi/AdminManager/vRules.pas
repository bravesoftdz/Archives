unit vRules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cefvcl, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  API_MVC,
  eEntities, Vcl.ImgList;

type
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
    procedure btnAGClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitView; override;
  public
    { Public declarations }
    procedure SetLevels(aLevelList: TJobLevelList);
    procedure SetControlTree(aJobGroupList: TJobGroupList);
  end;

  TGroupNode = class(TTreeNode)
  public
    Group: TJobGroup;
  end;

var
  ViewRules: TViewRules;

implementation

{$R *.dfm}

procedure TViewRules.SetControlTree(aJobGroupList: TJobGroupList);
var
  Group: TJobGroup;
  GroupNode: TGroupNode;
  TreeNodes: TTreeNodes;
begin
  ViewRules.tvTree.Items.Clear;
  TreeNodes := TTreeNodes.Create(ViewRules.tvTree);

  for Group in aJobGroupList do
    begin
      GroupNode := TGroupNode.Create(TreeNodes);
      GroupNode.ImageIndex := 0;
      GroupNode.ExpandedImageIndex := 1;
      GroupNode.Group := Group;

      TreeNodes.AddChild(GroupNode, Group.Notes);
    end;
end;

procedure TViewRules.SetLevels(aLevelList: TJobLevelList);
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

procedure TViewRules.btnAGClick(Sender: TObject);
begin
  SendMessage('CreateGroup');
end;

procedure TViewRules.InitView;
begin
  ViewRules := Self;
end;

end.
