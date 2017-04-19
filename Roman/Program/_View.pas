unit _View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls
  ,API_MVC, IdBaseComponent, IdComponent, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL
  ,API_Controls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids
  ,API_Parse;

type
  TfrmView = class(TViewParse)
    procedure FormActivate(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure ParsersGridClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure tmrGridUpdateTimer(Sender: TObject);
  private
    { Private declarations }
    procedure InitMVC; override;
  public
    { Public declarations }
  end;

var
  frmView: TfrmView;

implementation

{$R *.dfm}

uses
   Controller;

procedure TfrmView.btnStartClick(Sender: TObject);
begin
  btnStart.Enabled:=False;
  btnStop.Enabled:=True;
  //ParsersGrid.Cells[1, ParsersGrid.Row]:='процесс';
  if ParsersGrid.Row=1 then SendViewMessage('start 2gis');
  if ParsersGrid.Row=2 then SendViewMessage('start tripadvisor');
  if ParsersGrid.Row=3 then SendViewMessage('start wiki');
end;

procedure TfrmView.btnStopClick(Sender: TObject);
begin
  btnStart.Enabled:=True;
  btnStop.Enabled:=False;
  ParsersGrid.Cells[1, ParsersGrid.Row]:='Остановлено';
  if ParsersGrid.Row=1 then SendViewMessage('stop 2gis');
end;

procedure TfrmView.FormActivate(Sender: TObject);
begin
  ParsersGrid.Cells[1,0]:='статус';
  ParsersGrid.Cells[2,0]:='всего ссылок';
  ParsersGrid.Cells[3,0]:='обраб. ссылок';
  ParsersGrid.Cells[4,0]:='';

  ParsersGrid.Cells[0,1]:='2gis.ru';
  ParsersGrid.Cells[0,2]:='tripadvisor.ru';
  ParsersGrid.Cells[0,3]:='wikipedia.org';
  ParsersGrid.Cells[0,4]:='fl.ru';
end;

procedure TfrmView.InitMVC;
begin
  // указываем основной класс контроллера
  FControllerClass := TController;
end;

procedure TfrmView.ParsersGridClick(Sender: TObject);
begin
  if ParsersGrid.Cells[1, ParsersGrid.Row]<>'процесс' then
    begin
      btnStart.Enabled:=True;
      btnStop.Enabled:=False;
    end
  else
    begin
      btnStart.Enabled:=False;
      btnStop.Enabled:=True;
    end;
end;

procedure TfrmView.tmrGridUpdateTimer(Sender: TObject);
begin
  SendViewMessage('grid update');
end;

end.
