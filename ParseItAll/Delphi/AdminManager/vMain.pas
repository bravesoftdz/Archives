unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  API_MVC, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons;

type
  TViewMain = class(TViewAbstract)
    statBar: TStatusBar;
    pnlJobs: TPanel;
    stgdJobs: TStringGrid;
    pnlButtons: TPanel;
    btnNewJob: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure btnNewJobClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure InitMVC; override;
    procedure InitView; override;
  public
    { Public declarations }
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

uses
  cController;

procedure TViewMain.InitView;
begin
  ViewMain := Self;
end;

procedure TViewMain.btnNewJobClick(Sender: TObject);
begin
  SendMessage('AddJob');
end;

procedure TViewMain.FormActivate(Sender: TObject);
begin
  Self.SendMessage('ShowViewLogin');
end;

procedure TViewMain.InitMVC;
begin
  FControllerClass := TController;
end;

end.
