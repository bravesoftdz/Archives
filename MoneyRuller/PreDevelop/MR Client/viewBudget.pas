unit viewBudget;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs
  ,View, System.Rtti, FMX.Grid, FMX.Layouts, FMX.StdCtrls
  ,cntrMoneyRuller;

type
  TfrmBudget = class(TMViewAbstract)
    pnlLeftCol: TPanel;
    lbl1: TLabel;
    expndr1: TExpander;
    strngrd1: TStringGrid;
    StringGrid1: TStringGrid;
    scrlbx1: TScrollBox;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure LoadCategories;
  public
    { Public declarations }
    Categories: TArray<TCategory>;
    CatExpanders: TArray<TExpander>;
  end;

var
  frmBudget: TfrmBudget;

implementation

{$R *.fmx}

procedure TfrmBudget.FormShow(Sender: TObject);
begin
  LoadCategories;
end;

procedure TfrmBudget.LoadCategories;
var
  Expander: TExpander;
  Category: TCategory;
begin
  for Category in Categories do
    begin
      Expander:=TExpander.Create(Self);
      Expander.Parent:=Self.scrlbx1;
      Expander.Align:=TAlignLayout.Top;

      Expander.Text:=Category.Title;

      CatExpanders := CatExpanders + [Expander];
    end;
end;

end.
