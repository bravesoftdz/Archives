unit alezzle;

interface

uses
SysUtils, ComObj, ActiveX, Excel2000;

function  Excel_Open(filename:string):variant;
function  Excel_Close(Excel:variant):boolean;
function  Excel_Save(Excel:variant;filename:string):boolean;

function  empty(tx:string):boolean;  // проверка на пустое значение
function  FormatAddress(set_type:string;settlement:string;street_type:string;street_name:string;house_type:string;house_number:string;area:string;region:string):string; // форматируем данные к виду адреса
function  mysqldatetype(dat:string):string;
function  strtype(tx:string):string;

implementation

function strtype(tx:string):string;
begin
tx:=trim(tx);
if length(tx)=0 then tx:='NULL' else tx:=quotedstr(tx);
strtype:=tx;
end;

function Excel_Open(filename:string):variant;
var
Excel:variant;
xlCalculateManual:variant;
path:string;
begin
path:=GetCurrentDir+'\';
CoInitialize(Nil);
Excel:= CreateOleObject('Excel.Application');
Excel.Workbooks.Open[path+filename];
Excel.Visible := false;
Excel.DisplayAlerts := false;
Excel.Application.Calculation := xlCalculationManual; // это выключает автопересчет формул
Excel_Open:=Excel;
end;

function Excel_Close(Excel:variant): boolean;
begin
Excel.Application.Quit;
CoUninitialize;
end;

function Excel_Save(Excel:variant;filename:string):boolean;
begin
Excel.WorkBooks[1].SaveAs(filename);
end;

function empty(tx:string):boolean;
begin
if length(tx)=0 then empty:=true else empty:=false;
end;

function FormatAddress(set_type:string;settlement:string;street_type:string;street_name:string;house_type:string;house_number:string;area:string;region:string):string;
var
address:string;
begin
if length(settlement)>0 then
  begin
  if (set_type='город') then set_type:='г.';
  if (set_type='село') then set_type:='д.';
  address:=set_type+' '+settlement+',';
  if (length(street_type)>0) then address:=address+' '+street_type;
  if (length(street_name)>0) then address:=address+' '+street_name+',';
  if (length(house_type)>0) then address:=address+' '+house_type;
  if (length(house_number)>0) then address:=address+' '+house_number+',';
  if length(area)>0 then address:=address+' '+area+' р-н';
  if length(region)>0 then address:=address+', '+region+' обл.';
  end;
FormatAddress:=address;
end;

function mysqldatetype(dat:string):string;
begin
// для типа DATE
while Pos('.',dat) > 0 do
dat[Pos('.', dat)] := ' ';
mysqldatetype:=quotedstr(copy(dat,7,4)+copy(dat,4,2)+copy(dat,1,2));
end;

end.
