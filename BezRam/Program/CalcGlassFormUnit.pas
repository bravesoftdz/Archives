unit CalcGlassFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, math, Vcl.Grids;

type
  TGlassCalc = class(TForm)
    GroupBox1: TGroupBox;
    Label13: TLabel;
    Label6: TLabel;
    Label15: TLabel;
    ComboBox9: TComboBox;
    ComboBox8: TComboBox;
    ComboBox7: TComboBox;
    Label14: TLabel;
    ComboBox6: TComboBox;
    ComboBox5: TComboBox;
    ComboBox4: TComboBox;
    ComboBox3: TComboBox;
    ComboBox2: TComboBox;
    Edit5: TEdit;
    Edit4: TEdit;
    ComboBox1: TComboBox;
    Edit3: TEdit;
    Edit2: TEdit;
    Edit1: TEdit;
    Label12: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label16: TLabel;
    Memo1: TMemo;
    Edit6: TEdit;
    GroupBox2: TGroupBox;
    StringGrid1: TStringGrid;
    GroupBox3: TGroupBox;
    StringGrid2: TStringGrid;
    GroupBox4: TGroupBox;
    StringGrid3: TStringGrid;
    Button1: TButton;
    procedure Label16Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure ComboBox6Change(Sender: TObject);
    procedure ComboBox7Change(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure ComboBox8Change(Sender: TObject);
    procedure ComboBox9Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure ComboBox5Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GlassCalc: TGlassCalc;

implementation

{$R *.dfm}

procedure TGlassCalc.Button1Click(Sender: TObject);
begin
GlassCalc.Close;
GlassCalc.Release;
end;

procedure TGlassCalc.ComboBox1Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.ComboBox2Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.ComboBox3Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.ComboBox4Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.ComboBox5Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.ComboBox6Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.ComboBox7Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.ComboBox8Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.ComboBox9Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.Edit1Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.Edit2Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.Edit3Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.Edit4Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.Edit5Change(Sender: TObject);
begin
label16.OnClick(nil);
end;

procedure TGlassCalc.FormActivate(Sender: TObject);
begin
stringgrid1.ColWidths[0]:=242;
stringgrid1.ColWidths[1]:=53;
stringgrid1.ColWidths[2]:=53;
stringgrid1.Cells[1,0]:='Профиль';
stringgrid1.Cells[2,0]:='Cтекло';
stringgrid1.Cells[0,1]:='Ширина листа правого крыла';
stringgrid1.Cells[0,2]:='Ширина листа левого крыла';
stringgrid1.Cells[0,3]:='Ширина внутренних листов';
stringgrid1.Cells[0,4]:='Ширина единственный лист (участки 1 листа)';

stringgrid2.ColWidths[0]:=180;
stringgrid2.Cells[0,1]:='Компенсирующий профиль';
stringgrid2.Cells[0,2]:='Верхний профиль';
stringgrid2.Cells[0,3]:='Нижний профиль';
stringgrid2.Cells[0,4]:='Боковая рамка';
stringgrid2.Cells[0,5]:='Профиль полотна (правая панель)';
stringgrid2.Cells[0,6]:='Профиль полотна (левое панель)';
stringgrid2.Cells[0,7]:='Профиль полотна (внутренние панели)';
stringgrid2.Cells[0,8]:='Профиль полотна (секция 1 панель)';
stringgrid2.ColWidths[1]:=35;
stringgrid2.Cells[1,0]:='mm';
stringgrid2.ColWidths[2]:=35;
stringgrid2.Cells[2,0]:='левое';
stringgrid2.ColWidths[3]:=37;
stringgrid2.Cells[3,0]:='правая';
stringgrid2.ColWidths[4]:=15;
stringgrid2.ColWidths[5]:=15;
stringgrid2.ColWidths[6]:=72;
stringgrid2.Cells[6,0]:='профиль [mm]';

stringgrid3.ColWidths[0]:=120;
stringgrid3.Cells[0,1]:='правая панель';
stringgrid3.Cells[0,2]:='левое панель';
stringgrid3.Cells[0,3]:='внутренние панели';
stringgrid3.Cells[0,4]:='Единственный лист';

stringgrid3.ColWidths[1]:=60;
stringgrid3.Cells[1,0]:='шириной';
stringgrid3.ColWidths[2]:=60;
stringgrid3.Cells[2,0]:='высокий';
stringgrid3.ColWidths[3]:=30;
stringgrid3.ColWidths[4]:=60;
stringgrid3.Cells[4,0]:='Ud';
end;

procedure TGlassCalc.Label16Click(Sender: TObject);
var
tx:string;
h1,h2,i2,d1,a4,d4,f4,a7,d7,f7,a10,c10,h12,i12,h13,i13,h14,i14,l15,l16,l17,l18:real;
h15,i15,h16,i16,h17,i17,h18,c14,i18,d14,h19,i19,i21,h21,l12,m12,l13,m13,c17,d17,c15,d15:real;
c16,d16,e10,i_d33,i_e33,i_d34,i_d35,i_d37,i_e34,i_e35,i_e37,s_c4,s_c5,s_c6,s_c7,s_c8,s_c9,s_c10,s_c11:real;
s_d4,s_d5,s_d6,s_d7,s_d8,s_d9,s_d10,s_d11:real;
s_e4,s_e5,s_e6,s_e7,s_e8,s_e9,s_e10,s_e11:real;
s_f4,s_f5,s_f6,s_f7,s_f8,s_f9,s_f10,s_f11:real;
s_g4,s_g5,s_g6,s_g7,s_g8,s_g9,s_g10,s_g11:real;
s_h8,s_h9,s_h10,s_h11:real;
z_b4,z_b5,z_b6,z_b8:real;
z_c4,z_c5,z_c6,z_c8:real;
z_f4,z_f5,z_f6,z_f8:real;
begin
memo1.Clear;
edit6.Text:='';

try
if length(edit3.Text)=0 then
  begin
  h1:=strtofloatdef(edit1.Text,0)/700-int(strtofloatdef(edit1.Text,0)/700);
  if h1>0.5 then h2:=ceil(strtofloatdef(edit1.Text,0)/700)
    else h2:=int(strtofloatdef(edit1.Text,0)/700);
  if strtofloatdef(edit1.Text,0)/h2>800 then i2:=h2+1 else i2:=h2;
  d1:=i2;
  end
  else
  d1:=strtofloatdef(edit3.Text,0);
tx:='№ of panles suggested by the system '+floattostr(d1);
memo1.Lines.Add(tx);

if combobox2.Text='внешний' then a4:=360-strtofloatdef(edit4.Text,0) else a4:=strtofloatdef(edit4.Text,0);
if (a4=180) and (combobox6.Text='постоянный') then d4:=45 else d4:=a4/2;
if combobox6.Text='Точка открытия в углу' then f4:=1 else f4:=sin(degtorad(d4));
tx:='Conversion right angle from external to internal '+floattostr(a4)+' Cutting angle '+floattostr(d4)+' Sin (a) '+floattostr(f4);
memo1.Lines.Add(tx);

if combobox2.Text='внешний' then a7:=360-strtofloatdef(edit5.Text,0) else a7:=strtofloatdef(edit5.Text,0);
if (a7=180) and (combobox8.Text='постоянный') then d7:=45 else d7:=a7/2;
if combobox8.Text='Точка открытия в углу' then f7:=1 else f7:=sin(degtorad(d7));
tx:='Conversion left angle from external to internal '+floattostr(a7)+' Cutting angle '+floattostr(d7)+' Sin (a) '+floattostr(f7);
memo1.Lines.Add(tx);
memo1.Lines.Add('');
//Tangent
c14:=tan(degtorad(d4));
d14:=tan(degtorad(d7));

tx:='Extreme logic            dx     sx';
memo1.Lines.Add(tx);
if combobox6.Text='постоянный' then h12:=1 else h12:=0;
if combobox8.Text='постоянный' then i12:=1 else i12:=0;
tx:='Continuous                '+floattostr(h12)+'      '+floattostr(i12);
memo1.Lines.Add(tx);

if combobox6.Text='крайний' then h13:=1 else h13:=0;
if combobox8.Text='крайний' then i13:=1 else i13:=0;
tx:='Extreme                    '+floattostr(h13)+'      '+floattostr(i13);
memo1.Lines.Add(tx);

if combobox6.Text='лацкан' then h14:=1 else h14:=0;
if combobox8.Text='лацкан' then i14:=1 else i14:=0;
tx:='Overlaps                   '+floattostr(h14)+'      '+floattostr(i14);
memo1.Lines.Add(tx);

if combobox6.Text='закулисный' then h15:=1 else h15:=0;
if combobox8.Text='закулисный' then i15:=1 else i15:=0;
tx:='Overlapped               '+floattostr(h15)+'      '+floattostr(i15);
memo1.Lines.Add(tx);

if combobox6.Text='Точка открытия вуглу' then h16:=1 else h16:=0;
if combobox8.Text='Точка открытия в углу' then i16:=1 else i16:=0;
tx:='Angle point opening    '+floattostr(h16)+'       '+floattostr(i16);
memo1.Lines.Add(tx);

if combobox6.Text='открытие в углу 90' then h17:=1 else h17:=0;
if combobox8.Text='открытие в углу 90' then i17:=1 else i17:=0;
tx:='Square opening          '+floattostr(h17)+'       '+floattostr(i17);
memo1.Lines.Add(tx);

if h12=1 then h18:=0
else if h13=1 then
        if combobox4.Text='да' then h18:=-32 else h18:=-12
     else if h14=1 then h18:=-9.5
          else if h15=1 then h18:=-34.5
               else if h16=1 then h18:=(-32.5/c14)-2
                    else if h17=1 then h18:=-40 else h18:=0;
if i12=1 then i18:=0
else if i13=1 then
        if combobox4.Text='да' then i18:=-32 else i18:=-12
     else if i14=1 then i18:=-9.5
          else if i15=1 then i18:=-34.5
               else if i16=1 then i18:=(-32.5/d14)-2
                    else if i17=1 then i18:=-40 else i18:=0;
tx:='Modif for extreme     '+floattostr(h18)+'  '+floattostr(i18);
memo1.Lines.Add(tx);

if combobox7.Text='да' then h19:=-100 else h19:=0;
if combobox9.Text='да' then i19:=-100 else i19:=0;
tx:='Handle/knob               '+floattostr(h19)+'       '+floattostr(i19);
memo1.Lines.Add(tx);

h21:=h19+h18;
i21:=i19+i18;
tx:='Total modified length '+floattostr(h21)+'  '+floattostr(i21);
memo1.Lines.Add(tx);
memo1.Lines.Add('');

tx:='Angles conversion int->ext profiles 40mm      Right      Left';
memo1.Lines.Add(tx);

if strtofloatdef(edit4.Text,0)=180 then
  if combobox6.Text='крайний' then l12:=d4
  else if combobox6.Text='постоянный' then l12:=d4 else l12:=45
else l12:=d4;
if strtofloatdef(edit5.Text,0)=180 then
  if combobox8.Text='крайний' then m12:=d7
  else if combobox8.Text='постоянный' then m12:=d7 else m12:=45
else m12:=d7;
tx:='Angle                                                         '+floattostr(l12)+'        '+floattostr(m12);
l13:=tan(degtorad(l12));
m13:=tan(degtorad(m12));
memo1.Lines.Add(tx);
tx:='Tang                                                           '+floattostr(l13)+'         '+floattostr(m13);
memo1.Lines.Add(tx);

//Nodes discount for taps
a10:=(d1-1)*4;
if combobox2.Text='внутренний' then c10:=strtofloatdef(edit1.Text,0)+40/l13+40/m13 else c10:=strtofloatdef(edit1.Text,0);

if combobox4.Text='да' then
                            if h13=1 then
                                         if i13=1 then l15:=c10-40 else l15:=c10-20
                                         else if i13=1 then l15:=c10-20 else l15:=c10
                            else if i13=1 then l15:=c10-3 else l15:=c10;
tx:='Upper profile '+floattostr(l15);
memo1.Lines.Add(tx);

if combobox4.Text='да' then
                            if h13=1 then
                                         if i13=1 then l16:=c10-40 else l16:=c10-20
                                         else if i13=1 then l16:=c10-20 else l16:=c10
                            else if i13=1 then l16:=c10-3 else l16:=c10;
tx:='Lower profile '+floattostr(l16);
memo1.Lines.Add(tx);

if combobox5.Text='да' then l17:=c10+2.5/l13+2.5/m13 else l17:=0;
tx:='Comp. Profile '+floattostr(l17);
memo1.Lines.Add(tx);

if h13+i13=0 then l18:=0
                  else if combobox4.Text='да' then
                                                  if combobox5.Text='да' then l18:=strtofloatdef(edit2.Text,0)-31 else l18:=strtofloatdef(edit2.Text,0)
                                                  else l18:=0;
tx:='Lateral frame '+floattostr(l18);
memo1.Lines.Add(tx);
memo1.Lines.Add('');

//New angle tap discount
if f4=1 then c17:=0 else c17:=1.5/f4;
if f7=1 then d17:=0 else d17:=1.5/f7;

//Discount
if combobox6.Text='Точка открытия в углу' then c15:=0-h18 else c15:=7.5/c14+c17;
if combobox8.Text='Точка открытия в углу' then d15:=0-i18 else d15:=7.5/d14+d17;

//Glass discount
if c17=0 then c16:=0
         else if combobox3.Text='6' then if d4>90 then c16:=9.5/c14 else c16:=16/c14
                                    else if combobox3.Text='8' then if d4>90 then c16:=8.5/c14 else c16:=17/c14
                                                               else if d4>90 then c16:=7.5/c14 else c16:=18/c14;
if d17=0 then d16:=0
         else if combobox3.Text='6' then if d7>90 then d16:=9.5/d14 else d16:=16/d14
                                    else if combobox3.Text='8' then if d7>90 then d16:=8.5/d14 else d16:=17/d14
                                                               else if d7>90 then d16:=7.5/d14 else d16:=18/d14;

//Final length
if (a4=180) and (d4=90) then if (a7=180) and (d7=90) then e10:=c10-a10+h21+i21 else e10:=c10-a10-d15+h21
                        else if (a7=180) and (d7=90) then e10:=c10-a10+i21-c15 else e10:=c10-a10-c15-d15;

tx:='Nodes discount for taps '+floattostr(a10)+' External profile length '+floattostr(c10)+' Final length '+floattostr(e10);
memo1.Lines.Add(tx);
memo1.Lines.Add('                                        right                                 left');
tx:='Tangent                               '+floattostr(c14)+'       '+floattostr(d14);
memo1.Lines.Add(tx);
tx:='Discount                               '+floattostr(c15)+'      '+floattostr(d15);
memo1.Lines.Add(tx);
tx:='Glass discount                       '+floattostr(c16)+'                                     '+floattostr(d16);
memo1.Lines.Add(tx);
tx:='New angle tap discount          '+floattostr(c17)+'                                     '+floattostr(d17);
memo1.Lines.Add(tx);
if strtofloatdef(edit3.Text,0)=0 then edit6.Text:=floattostr(d1);

// результат
if d1=1 then i_d33:=0
        else if combobox7.Text='да' then i_d33:=roundto(e10/d1,-1)+100
                                    else if d1=1 then i_d33:=0 else i_d33:=roundto(e10/d1,-1);
stringgrid1.Cells[1,1]:=floattostr(i_d33);

if d1=1 then i_d34:=0
        else if combobox9.Text='да' then i_d34:=roundto(e10/d1,-1)+100
                                    else if d1=1 then i_d34:=0 else i_d34:=roundto(e10/d1,-1);
stringgrid1.Cells[1,2]:=floattostr(i_d34);

if d1=1 then i_d35:=0 else if d1=2 then i_d35:=0 else i_d35:=roundto(e10/D1,-1);
stringgrid1.Cells[1,3]:=floattostr(i_d35);

if d1=1 then if h19+i19=0 then i_d37:=roundto(e10,-1) else i_d37:=roundto(e10+100,-1)
        else i_d37:=0;
stringgrid1.Cells[1,4]:=floattostr(i_d37);

if d1=1 then i_e33:=0
        else if (edit4.Text='180') and (combobox6.Text='постоянный') then i_e33:=roundto(i_d33-c16-1,0)
                                                                     else if edit4.Text='180' then i_e33:=roundto(i_d33-1,0)
                                                                                              else i_e33:=roundto(i_d33-c16-1,0);
stringgrid1.Cells[2,1]:=floattostr(i_e33);

if d1=1 then i_e33:=0
        else if (edit4.Text='180') and (combobox6.Text='постоянный') then i_e33:=roundto(i_d33-c16-1,0)
                                                                     else if edit4.Text='180' then i_e33:=roundto(i_d33-1,0)
                                                                                              else i_e33:=roundto(i_d33-c16-1,0);
stringgrid1.Cells[2,1]:=floattostr(i_e33);

if d1=1 then i_e34:=0
        else if (edit5.Text='180') and (combobox8.Text='постоянный') then i_e34:=roundto(i_d34-d16-1,0)
                                                                     else if edit5.Text='180' then i_e34:=roundto(i_d34-1,0)
                                                                                              else i_e34:=roundto(i_d34-d16-1,0);
stringgrid1.Cells[2,2]:=floattostr(i_e34);

if i_d35=0 then i_e35:=0
           else i_e35:=roundto(i_d35-1,0);
stringgrid1.Cells[2,3]:=floattostr(i_e35);

if d1=1 then i_e37:=roundto(i_d37-c16-d16-1,0)
        else i_e37:=0;
stringgrid1.Cells[2,4]:=floattostr(i_e37);

if l17=0 then s_c4:=0
         else s_c4:=roundto(l17,-1);
stringgrid2.Cells[1,1]:=floattostr(s_c4);

s_c5:=roundto(l15,-1);
stringgrid2.Cells[1,2]:=floattostr(s_c5);

s_c6:=roundto(l16,-1);
stringgrid2.Cells[1,3]:=floattostr(s_c6);

s_c7:=l18;
stringgrid2.Cells[1,4]:=floattostr(s_c7);

s_c8:=i_d33;
stringgrid2.Cells[1,5]:=floattostr(s_c8);

s_c9:=i_d34;
stringgrid2.Cells[1,6]:=floattostr(s_c9);

s_c10:=i_d35;
stringgrid2.Cells[1,7]:=floattostr(s_c10);

s_c11:=i_d37;
stringgrid2.Cells[1,8]:=floattostr(s_c11);

if combobox5.Text='да' then s_d4:=m12 else s_d4:=0;
stringgrid2.Cells[2,1]:=floattostr(s_d4);

s_d5:=m12;
stringgrid2.Cells[2,2]:=floattostr(s_d5);

s_d6:=m12;
stringgrid2.Cells[2,3]:=floattostr(s_d6);

if s_c7=0 then s_d7:=0 else s_d7:=90;
stringgrid2.Cells[2,4]:=floattostr(s_d7);

if s_c8=0 then s_d8:=0 else s_d8:=90;
stringgrid2.Cells[2,5]:=floattostr(s_d8);

if s_c9=0 then s_d9:=0
           else if combobox8.Text='постоянный' then s_d9:=d7 else s_d9:=90;
stringgrid2.Cells[2,6]:=floattostr(s_d9);

if s_c10=0 then s_d10:=0 else s_d10:=90;
stringgrid2.Cells[2,7]:=floattostr(s_d10);

if d1=1 then if (combobox8.Text='Точка открытия в углу') or (a7=180) then s_d11:=90 else s_d11:=d7
                   else s_d11:=0;
stringgrid2.Cells[2,8]:=floattostr(s_d11);

if combobox5.Text='да' then s_e4:=l12 else s_e4:=0;
stringgrid2.Cells[3,1]:=floattostr(s_e4);

s_e5:=l12;
stringgrid2.Cells[3,2]:=floattostr(s_e5);

s_e6:=l12;
stringgrid2.Cells[3,3]:=floattostr(s_e6);

if s_c7=0 then s_e7:=0 else s_e7:=90;
stringgrid2.Cells[3,4]:=floattostr(s_e7);

if s_c8=0 then s_e8:=0
          else if combobox6.Text='постоянный' then s_e8:=d4 else s_e8:=90;
stringgrid2.Cells[3,5]:=floattostr(s_e8);

if s_c9=0 then s_e9:=0 else s_e9:=90;
stringgrid2.Cells[3,6]:=floattostr(s_e9);

if s_c10=0 then s_e10:=0 else s_e10:=90;
stringgrid2.Cells[3,7]:=floattostr(s_e10);

if d1=1 then if (combobox6.Text='Точка открытия в углу') or (a4=180) then s_e11:=90 else s_e11:=d4
   else s_e11:=0;
stringgrid2.Cells[3,8]:=floattostr(s_e11);

stringgrid2.Cells[4,1]:='x';
stringgrid2.Cells[4,2]:='x';
stringgrid2.Cells[4,3]:='x';
stringgrid2.Cells[4,4]:='x';
stringgrid2.Cells[4,5]:='x';
stringgrid2.Cells[4,6]:='x';
stringgrid2.Cells[4,7]:='x';
stringgrid2.Cells[4,8]:='x';

if combobox5.Text='да' then s_g4:=1 else s_g4:=0;
stringgrid2.Cells[5,1]:=floattostr(s_g4);

s_g5:=1;
stringgrid2.Cells[5,2]:=floattostr(s_g5);

s_g6:=1;
stringgrid2.Cells[5,3]:=floattostr(s_g6);

if s_c7=0 then s_g7:=0 else s_g7:=h13+i13;
stringgrid2.Cells[5,4]:=floattostr(s_g7);

if d1=1 then s_g8:=0 else s_g8:=2;
stringgrid2.Cells[5,5]:=floattostr(s_g8);

if d1=1 then s_g9:=0 else s_g9:=2;
stringgrid2.Cells[5,6]:=floattostr(s_g9);

if d1=1 then s_g10:=0 else if d1=2 then s_g10:=0 else s_g10:=(d1-2)*2;
stringgrid2.Cells[5,7]:=floattostr(s_g10);

if d1=1 then s_g11:=2 else s_g11:=0;
stringgrid2.Cells[5,8]:=floattostr(s_g11);

if i_d33=0 then s_h8:=0 else s_h8:=strtofloatdef(combobox3.Text,0);
stringgrid2.Cells[6,5]:=floattostr(s_h8);

if i_d34=0 then s_h9:=0 else s_h9:=strtofloatdef(combobox3.Text,0);
stringgrid2.Cells[6,6]:=floattostr(s_h9);

if i_d35=0 then s_h10:=0 else s_h10:=strtofloatdef(combobox3.Text,0);
stringgrid2.Cells[6,7]:=floattostr(s_h10);

if i_d37=0 then s_h11:=0 else s_h11:=strtofloatdef(combobox3.Text,0);
stringgrid2.Cells[6,8]:=floattostr(s_h11);

z_b4:=i_e33;
stringgrid3.Cells[1,1]:=floattostr(z_b4);

z_b5:=i_e34;
stringgrid3.Cells[1,2]:=floattostr(z_b5);

z_b6:=i_e35;
stringgrid3.Cells[1,3]:=floattostr(z_b6);

z_b8:=i_e37;
stringgrid3.Cells[1,4]:=floattostr(z_b8);

if z_b4=0 then z_c4:=0
   else if combobox5.Text='да' then z_c4:=strtofloatdef(edit2.Text,0)-191 else z_c4:=strtofloatdef(edit2.Text,0)-160;
stringgrid3.Cells[2,1]:=floattostr(z_c4);

if z_b5=0 then z_c5:=0
   else if combobox5.Text='да' then z_c5:=strtofloatdef(edit2.Text,0)-191 else z_c5:=strtofloatdef(edit2.Text,0)-160;
stringgrid3.Cells[2,2]:=floattostr(z_c5);

if z_b6=0 then z_c6:=0
   else if combobox5.Text='да' then z_c6:=strtofloatdef(edit2.Text,0)-191 else z_c6:=strtofloatdef(edit2.Text,0)-160;
stringgrid3.Cells[2,3]:=floattostr(z_c6);

if d1=1 then if combobox5.Text='да' then z_c8:=strtofloatdef(edit2.Text,0)-191 else z_c8:=strtofloatdef(edit2.Text,0)-160
        else z_c8:=0;
stringgrid3.Cells[2,4]:=floattostr(z_c8);

stringgrid3.Cells[3,1]:='x';
stringgrid3.Cells[3,2]:='x';
stringgrid3.Cells[3,3]:='x';
stringgrid3.Cells[3,4]:='x';

if d1=1 then z_f4:=0 else z_f4:=1;
stringgrid3.Cells[4,1]:=floattostr(z_f4);

if d1=1 then z_f5:=0 else z_f5:=1;
stringgrid3.Cells[4,2]:=floattostr(z_f5);

if d1=1 then z_f6:=0 else if d1=2 then z_f6:=0 else z_f6:=d1-2;
stringgrid3.Cells[4,3]:=floattostr(z_f6);

if d1=1 then z_f8:=1 else z_f8:=0;
stringgrid3.Cells[4,4]:=floattostr(z_f8);
except

end;
end;
end.
