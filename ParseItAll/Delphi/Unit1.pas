unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

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
  ,API;

procedure TForm1.btn1Click(Sender: TObject);
var
  ParserModel: TParserModel;
begin
  ParserModel:=TParserModel.Create(1);
  try
    ParserModel.Execute;
  finally
    ParserModel.Free;
  end;
end;

end.
