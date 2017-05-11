unit vJob;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  API_MVC, Vcl.ExtCtrls, cefvcl, Vcl.StdCtrls, Vcl.Buttons;

type
  TViewJob = class(TViewAbstract)
    pnlBrowser: TPanel;
    pnlURL: TPanel;
    pnlFields: TPanel;
    chrmBrowser: TChromium;
    edtURL: TEdit;
    lblURL: TLabel;
    btnNavigate: TBitBtn;
    procedure btnNavigateClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitView; override;
  public
    { Public declarations }
  end;

var
  ViewJob: TViewJob;

implementation

{$R *.dfm}

procedure TViewJob.btnNavigateClick(Sender: TObject);
begin
  chrmBrowser.Load(edtURL.Text);
end;

procedure TViewJob.InitView;
begin
  ViewJob := Self;
end;

end.
