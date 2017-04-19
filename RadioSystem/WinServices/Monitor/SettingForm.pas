unit SettingForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, System.JSON;

type
  TfrmSettings = class(TForm)
    pnlJSONTree: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
  private
    { Private declarations }
    FjsnSettings: TJSONObject;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; SettingFile: String); overload;
    property jsnSettings: TJSONObject read FjsnSettings;
  end;

implementation

{$R *.dfm}
uses
   Model
  ,API_Controls;

constructor TfrmSettings.Create(AOwner: TComponent; SettingFile: string);
var
  JSNTreeView: TJSNTreeView;
begin
  Self.Create(AOwner);
  Self.Caption:=SettingFile;

  // програмно создаём и грузим дерево JSON
  JSNTreeView:=TJSNTreeView.Create(Self);
  JSNTreeView.Parent:=Self.pnlJSONTree;
  JSNTreeView.Align:=alClient;
  FjsnSettings:=TStatEngine.GetSettings(SettingFile);
  JSNTreeView.LoadJSN(FjsnSettings);
  JSNTreeView.FullExpand;
end;

end.
