unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj, DB, DBTables, RegExpr, alezzle;

type
  ArrayOfString = array of String;

  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Query1: TQuery;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    ComboBox6: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  extfilename:string;

implementation

{$R *.dfm}
function csv_line(line:string):ArrayOfString;
var
v:ArrayOfString;
i:integer;
tx:string;
begin
tx:='';
for i:=1 to length(line) do
  begin
  if (line[i]<>';') and (line[i]<>'"') then tx:=tx+line[i];
  if (line[i]=';') or (i=length(line)) then
    begin
    setlength(v,length(v)+1);
    v[length(v)-1]:=tx;
    tx:='';
    end;
  end;
csv_line:=v;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
FServer:Variant;
SL,SLerrors:TStringList;
i,j:integer;
sql,mysql,d1,s1,d2,s2,bts_number,a1,a2,a3,y,x:string;
fields,values:ArrayOfString;
RegExp: TRegExpr;
begin
query1.SQL.Clear;
query1.SQL.Add('SET NAMES cp1251');
query1.ExecSQL;

FServer := CreateOleObject('MapInfo.Application');
FServer.Application.Visible := true;
SL:=TStringList.Create;
SLerrors:=TStringList.Create;
RegExp := TRegExpr.Create;
SL.LoadFromFile(edit1.Text);

// создаём таблицу
sql:='Create table Custom_Layer (';
fields:=csv_line(SL.Strings[0]);
for i:=0 to length(fields)-1 do
  begin
  if i=16 then break;
  fields[i]:=StringReplace(fields[i],' ','_',[rfReplaceAll, rfIgnoreCase]);
  if i>0 then sql:=sql+',';
  sql:=sql+fields[i]+' char(250)';
  end;
sql:=sql+') File "C:\mts_dbase\Programs\MI_Create\result\Custom_Layer"';
FServer.do(sql);
FServer.do('Create map for Custom_Layer');

// заполняем слой
for i:=1 to SL.Count-1 do
  begin
  values:=csv_line(SL.Strings[i]);

  //координаты
  try
  if (length(combobox1.Text)>0) then
    begin
    RegExp.InputString := values[strtoint(combobox1.Text)];
    RegExp.Expression := '\d+';
    if RegExp.Exec then
      begin
      bts_number:=RegExp.Match[0];
      end;
    if length(bts_number)=1 then bts_number:='00'+bts_number;
    if length(bts_number)=2 then bts_number:='0'+bts_number;

    mysql:='SELECT longitudel_s, longitudel_d FROM bts WHERE bts_number='+bts_number;
    query1.Close;
    query1.SQL.Clear;
    query1.SQL.Add(mysql);
    query1.Open;
    d1:=query1.fieldbyname('longitudel_d').AsString;
    s1:=query1.fieldbyname('longitudel_s').AsString;
    end;
  if length(combobox3.Text)>0 then d1:=values[strtoint(combobox3.Text)];
  if length(combobox4.Text)>0 then s1:=values[strtoint(combobox4.Text)];

  d1:=StringReplace(d1,'.',',',[rfReplaceAll, rfIgnoreCase]);
  s1:=StringReplace(s1,'.',',',[rfReplaceAll, rfIgnoreCase]);

  if radiobutton2.Checked=true then
    begin
    if (length(combobox2.Text)>0) then
      begin
      RegExp.InputString := values[strtoint(combobox2.Text)];
      RegExp.Expression := '\d+';
      if RegExp.Exec then
        begin
        bts_number:=RegExp.Match[0];
        end;

      if length(bts_number)=1 then bts_number:='00'+bts_number;
      if length(bts_number)=2 then bts_number:='0'+bts_number;

      mysql:='SELECT longitudel_s, longitudel_d FROM bts WHERE bts_number='+bts_number;
      query1.Close;
      query1.SQL.Clear;
      query1.SQL.Add(mysql);
      query1.Open;
      d2:=query1.fieldbyname('longitudel_d').AsString;
      s2:=query1.fieldbyname('longitudel_s').AsString;
      end;

    if length(combobox5.Text)>0 then d2:=values[strtoint(combobox5.Text)];
    if length(combobox6.Text)>0 then s2:=values[strtoint(combobox6.Text)];

    d2:=StringReplace(d2,'.',',',[rfReplaceAll, rfIgnoreCase]);
    s2:=StringReplace(s2,'.',',',[rfReplaceAll, rfIgnoreCase]);
    end;

  j:=pos(' ',d1);
  a1:=copy(d1,1,j-1);
  d1:=copy(d1,j+1,length(d1));
  j:=pos(' ',d1);
  a2:=copy(d1,1,j-1);
  d1:=copy(d1,j+1,length(d1)-j);
  a3:=d1;
  y:=floattostr((strtoint(a1)+strtoint(a2)/60+strtofloat(a3)/3600));
  d1:=y;

  j:=pos(' ',s1);
  a1:=copy(s1,1,j-1);
  s1:=copy(s1,j+1,length(s1));
  j:=pos(' ',s1);
  a2:=copy(s1,1,j-1);
  s1:=copy(s1,j+1,length(s1)-1);
  a3:=s1;
  x:=floattostr((strtoint(a1)+strtoint(a2)/60+strtofloat(a3)/3600));
  s1:=x;

  d1:=StringReplace(d1,',','.',[rfReplaceAll, rfIgnoreCase]);
  s1:=StringReplace(s1,',','.',[rfReplaceAll, rfIgnoreCase]);

  if radiobutton2.Checked=true then
    begin
    j:=pos(' ',d2);
    a1:=copy(d2,1,j-1);
    d2:=copy(d2,j+1,length(d2));
    j:=pos(' ',d2);
    a2:=copy(d2,1,j-1);
    d2:=copy(d2,j+1,length(d2)-j);
    a3:=d2;
    y:=floattostr((strtoint(a1)+strtoint(a2)/60+strtofloat(a3)/3600));
    d2:=y;

    j:=pos(' ',s2);
    a1:=copy(s2,1,j-1);
    s2:=copy(s2,j+1,length(s2));
    j:=pos(' ',s2);
    a2:=copy(s2,1,j-1);
    s2:=copy(s2,j+1,length(s2)-1);
    a3:=s2;
    x:=floattostr((strtoint(a1)+strtoint(a2)/60+strtofloat(a3)/3600));
    s2:=x;

    d2:=StringReplace(d2,',','.',[rfReplaceAll, rfIgnoreCase]);
    s2:=StringReplace(s2,',','.',[rfReplaceAll, rfIgnoreCase]);
    end;

  sql:='INSERT INTO Custom_Layer (';
    sql:=sql+'obj';

  for j:=0 to length(fields)-1 do
    begin
    if j=16 then break;
    sql:=sql+','+fields[j];
    end;
  sql:=sql+') VALUES (';
  if radiobutton2.Checked=true then sql:=sql+' CreateLine('+d1+','+s1+','+d2+','+s2+')';
  if radiobutton1.Checked=true then sql:=sql+' CreatePoint('+d1+','+s1+')';
  for j:=0 to length(values)-1 do
    begin
    if j=16 then break;
    sql:=sql+','+AnsiQuotedStr(values[j],'"');
    end;
  sql:=sql+')';

  fserver.do(sql);
    except
    SLerrors.Add(inttostr(i));
    SLerrors.SaveToFile('errors.txt');
    end;

  end;

//////////////////////////////////////////////////////////////////
//       Сохраняем слой
sql:='Commit Table Custom_Layer';
fserver.do(sql);
//sql:='Create Index on RRL(bts_number)';
//fserver.do(sql);
sql:='Pack Table Custom_Layer Graphic Data';
fserver.do(sql);

RegExp.Free;
SL.Free;
SLerrors.Free;
FServer.do('end mapinfo');

sleep(3000);
WinExec(PChar('rar.exe a -r -ep Y:\home\radiosystem\www\files\tasks\'+extfilename+'.rar C:\mts_dbase\Programs\MI_Create\result\*.*'),SW_SHOW);
end;

procedure TForm1.FormActivate(Sender: TObject);
var
tx,p:string;
begin
// запуск с командной строки
extfilename:=ParamStr(1);
if not empty(extfilename) then
  begin
  edit1.Text:=extfilename;

  // имя файла
  delete(extfilename,1,pos('temp/',extfilename)+4);
  delete(extfilename,pos('.',extfilename),length(extfilename));

  // номера столбцов бс
  tx:=ParamStr(2);
  delete(tx,1,pos(':',tx));
  p:=copy(tx,1,pos(':',tx)-1);
  combobox1.Text:=p;
  delete(tx,1,pos(':',tx));
  p:=copy(tx,1,pos(':',tx)-1);
  combobox2.Text:=p;

  // номера столбцов координат
  tx:=ParamStr(3);
  delete(tx,1,pos(':',tx));
  p:=copy(tx,1,pos(':',tx)-1);
  combobox3.Text:=p;
  delete(tx,1,pos(':',tx));
  p:=copy(tx,1,pos(':',tx)-1);
  combobox4.Text:=p;
  delete(tx,1,pos(':',tx));
  p:=copy(tx,1,pos(':',tx)-1);
  combobox5.Text:=p;
  delete(tx,1,pos(':',tx));
  p:=copy(tx,1,pos(':',tx)-1);
  combobox6.Text:=p;

  // тип слоя
  if ParamStr(4)='line' then radiobutton2.Checked:=true;
  if ParamStr(4)='point' then radiobutton1.Checked:=true;

  button1.Click;
  button2.Click;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
form1.Close;
form1.Release;
end;

end.
