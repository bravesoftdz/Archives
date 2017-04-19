unit View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, API_Parse, Vcl.StdCtrls, Vcl.Grids;

type
  TRomanView = class(TViewParse)
    btnStartConvertor: TButton;
    procedure btnStartConvertorClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitMVC; override;
    procedure SetParsers; override;
    procedure AfterControllerCreate; override;
  public
    { Public declarations }
  end;

var
  RomanView: TRomanView;

implementation

{$R *.dfm}

uses
    Controller
   ,Model_2GIS
   ,Model_TripAdvisor
   ,Model_Wiki;

procedure TRomanView.AfterControllerCreate;
begin
  SendViewMessage('GetParsersLastState');
end;

procedure TRomanView.SetParsers;
var
 Parser: TParserInfo;
begin
  Parser.Name:='2gis.ru';
  Parser.Num:=1;
  Parser.StartMessage:='start 2gis';
  FParsersList:=FParsersList+[Parser];

  Parser.Name:='tripadvisor.ru';
  Parser.Num:=2;
  Parser.StartMessage:='start tripadvisor';
  FParsersList:=FParsersList+[Parser];

  Parser.Name:='wikipedia.org';
  Parser.Num:=3;
  FParsersList:=FParsersList+[Parser];
end;

procedure TRomanView.btnStartConvertorClick(Sender: TObject);
begin
  inherited;
  Self.SendViewMessage('start convertor');
end;

procedure TRomanView.InitMVC;
begin
  // указываем основной класс контроллера
  FControllerClass := TController;
end;

end.
