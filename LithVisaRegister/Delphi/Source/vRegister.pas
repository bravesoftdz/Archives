unit vRegister;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  API_MVC_FMX, FMX.WebBrowser, IdBaseComponent, IdComponent,
  FMX.Controls.Presentation;

type
  TViewRegister = class(TViewFMXBase)
    wbBrowser: TWebBrowser;
    btnFill: TButton;
    procedure btnFillClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewRegister: TViewRegister;

implementation

{$R *.fmx}

procedure TViewRegister.btnFillClick(Sender: TObject);
begin
  inherited;

  SendMessage('FillForm');
end;

end.
