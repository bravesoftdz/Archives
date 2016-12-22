unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    btn1: TButton;
    btn2: TButton;
    wb1: TWebBrowser;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
   API_Files
  ,API_Parse;

procedure TForm1.btn1Click(Sender: TObject);
var
  ParserModel: TParserModel;
begin
  ParserModel:=TParserModel.Create;
  try
    ParserModel.Execute(1);
  finally
    ParserModel.Free;
  end;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  wb1.Navigate('https://ru.wikipedia.org/wiki/%D0%9A%D0%B0%D1%82%D0%B5%D0%B3%D0%BE%D1%80%D0%B8%D1%8F:%D0%90%D0%BA%D1%82%D1%91%D1%80%D1%8B_%D0%BF%D0%BE_%D0%B0%D0%BB%D1%84%D0%B0%D0%B2%D0%B8%D1%82%D1%83');
end;

end.
