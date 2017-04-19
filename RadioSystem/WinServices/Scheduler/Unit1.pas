unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Unit2, Unit3;

type
  TForm1 = class(TForm)
    ListView1: TListView;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mythread:milayers;
  mythread2:fudcheck;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
if listview1.Items[0].Checked=true then
  begin
  mythread:=milayers.Create(False);
  mythread.Priority:=tpNormal;
  mythread.FreeOnTerminate:=true;
  end;
if listview1.Items[1].Checked=true then
  begin
  mythread2:=fudcheck.Create(False);
  mythread2.Priority:=tpNormal;
  mythread2.FreeOnTerminate:=true;
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
var
i:integer;
begin
for i:=0 to listview1.Items.Count-1 do
  begin
  listview1.Items[i].Checked:=true;
  end;
end;

end.
