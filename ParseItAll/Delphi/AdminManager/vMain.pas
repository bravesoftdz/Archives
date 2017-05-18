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
    btnEditJob: TBitBtn;
    btnEditRules: TBitBtn;
    procedure btnNewJobClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEditJobClick(Sender: TObject);
    procedure btnEditRulesClick(Sender: TObject);
  private
    { Private declarations }
    function GetSelectedJobID: integer;
  protected
    procedure InitMVC; override;
    procedure InitView; override;
  public
    { Public declarations }
    property SelectedJobID: Integer read GetSelectedJobID;
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

uses
  cController;

function TViewMain.GetSelectedJobID: Integer;
begin
  Result := StrToInt(stgdJobs.Cells[0, stgdJobs.Row]);
end;

procedure TViewMain.InitView;
begin
  ViewMain := Self;

  stgdJobs.Cells[0,0] := 'ID';
  stgdJobs.Cells[1,0] := 'UserID';
  stgdJobs.Cells[2,0] := 'Title';
end;

procedure TViewMain.btnEditJobClick(Sender: TObject);
begin
  SendMessage('EditJob');
end;

procedure TViewMain.btnEditRulesClick(Sender: TObject);
begin
  SendMessage('EditJobRules');
end;

procedure TViewMain.btnNewJobClick(Sender: TObject);
begin
  SendMessage('CreateJob');
end;

procedure TViewMain.FormShow(Sender: TObject);
begin
  Self.SendMessage('ShowViewLogin');
end;

procedure TViewMain.InitMVC;
begin
  FControllerClass := TController;
end;

end.
