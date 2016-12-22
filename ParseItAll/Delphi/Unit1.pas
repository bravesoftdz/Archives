unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
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
    ParserModel.StartJob(1);
  finally
    //ParserModel.Free;
  end;
end;

end.
