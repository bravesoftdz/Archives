unit Unit2;

interface

uses
  Classes,ComObj,ActiveX,ADODB,SysUtils,Windows,ComCtrls;

type
  milayers = class(TThread)
  private
    { Private declarations }
    trunc:integer;
  protected
    procedure Execute; override;
    procedure UpdateTrunc;
    procedure UpdateLastTime;
  end;

implementation

uses alezzle, Unit1;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure milayers.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ milayers }
procedure milayers.UpdateTrunc;
var
itm:TListItem;
begin
itm:=form1.ListView1.Items.Item[0];
itm.SubItems[1]:=inttostr(trunc);
end;

procedure milayers.UpdateLastTime;
var
itm:TListItem;
begin
itm:=form1.ListView1.Items.Item[0];
itm.SubItems[0]:=datetimetostr(now);
end;

procedure milayers.Execute;
var
FServer:Variant;
sql:string;
ADOMySqlConnection:TADOConnection;
mysqlquery,oldquery:tadoquery;
i,j:integer;
a1,a2,a3,d,s,s1,d1,d2,s2,x,y,sw1,sw2,sw3,load,load_without_demontation,tx:string;
SL,ER:TStringList;
PointType,PointColor,PointSize,LineType,LineSize,LineColor:string;
sr :TSearchRec;
begin
  { Place thread code here }
While mythread.Terminated=false do
  begin
////////////////////////////////////////////////////////////////
////       ИНИЦИАЛИЗАЦИЯ
///////////////
trunc:=0;
Sl:=TStringList.Create;
ER:=TStringList.Create;
CoInitialize(nil);
FServer := CreateOleObject('MapInfo.Application');
FServer.Application.Visible := true;
Synchronize(UpdateLastTime);

ADOMySqlConnection:=TADOConnection.Create(nil);
ADOMySqlConnection.ConnectionString:='Provider=MSDASQL.1;Password=123;Persist Security Info=True;User ID=anekrash;Data Source=mts_dbase;Initial Catalog=mts_dbase';
ADOMySqlConnection.LoginPrompt:=false;
mysqlquery:=tadoquery.Create(nil);
mysqlquery.Connection:=ADOMySqlConnection;
mysqlquery.Close;
oldquery:=tadoquery.Create(nil);
oldquery.Connection:=ADOMySqlConnection;
oldquery.Close;

mysqlquery.SQL.Clear;
mysqlquery.SQL.Add('SET NAMES cp1251');
mysqlquery.ExecSQL;

oldquery.SQL.Clear;
oldquery.SQL.Add('SET NAMES cp1251');
oldquery.ExecSQL;

/////////////////////////////////////////////////////////////////
//       Создаём слой   BTS                          ////////////
sql:='Create table BTS (';
sql:=sql+' bts_number char(7)';
sql:=sql+',site_type char(4)';
sql:=sql+',address char(100)';
sql:=sql+',place_owner char(100)';
sql:=sql+',cooperative char(30)';
sql:=sql+',info_2G char(100)';
sql:=sql+',config_GSM char(50)';
sql:=sql+',config_DCS char(50)';
sql:=sql+',info_3G char(100)';
sql:=sql+',config_UMTS char(50)';
sql:=sql+',powerment char(50)';
sql:=sql+',longitudel_s char(50)';
sql:=sql+',longitudel_d char(50)';
sql:=sql+',notes char(150)';
sql:=sql+',BSC char(8)';
sql:=sql+',lac_2g char(4)';
sql:=sql+',RNC char(8)';
sql:=sql+',lac_3g char(4)';
sql:=sql+',switching_gsm char(20)';
sql:=sql+',switching_dcs char(20)';
sql:=sql+',switching_3g char(20)';
sql:=sql+') File "C:\mts_dbase\Programs\Scheduler\MILayers\BTS"';
FServer.do(sql);
FServer.do('Create map for BTS');

/////////////////////////////////////////////////////////////////
//      Основной запрос к базе MySQL                /////////////

sql:='SELECT';
sql:=sql+' bts_number';
sql:=sql+',site_type';
sql:=sql+',street_type';
sql:=sql+',street_name';
sql:=sql+',house_type';
sql:=sql+',house_number';
sql:=sql+',settlements.type as set_type';
sql:=sql+',settlements.settlement';
sql:=sql+',area';
sql:=sql+',region';
sql:=sql+',place_owner';
sql:=sql+',cooperative';
sql:=sql+',CONCAT(IFNULL(construction_2g_types.construction_type,""),IF(IFNULL(container_type,"")<>"" AND IFNULL(construction_2g_types.construction_type,"")<>""," + ",""),';
sql:=sql+'        IFNULL(container_type,""),IF(model_type_2g IS NOT NULL AND (IFNULL(construction_2g_types.construction_type,"")<>"" OR IFNULL(container_type,"")<>"")," + ",""),IFNULL(model_type_2g,"")) as info_2G';
sql:=sql+',CONCAT("plan_gsm:",IFNULL(plan_gsm.gsm_config,"")," work_gsm:",IFNULL(work_gsm.gsm_config,"") ) as config_GSM';
sql:=sql+',CONCAT("plan_dcs:",IFNULL(plan_dcs.dcs_config,"")," work_dcs:",IFNULL(work_dcs.dcs_config,"") ) as config_DCS';
sql:=sql+',CONCAT(IFNULL(construction_3g_types.construction_type,""),IF(IFNULL(model_type_3g,"")<>"" AND IFNULL(construction_3g_types.construction_type,"")<>""," + ",""),';
sql:=sql+'        IFNULL(model_type_3g,"") ) as info_3G';
sql:=sql+',CONCAT("plan_umts:",IFNULL(plan_umts.umts_config,"")," work_umts:",IFNULL(work_umts.umts_config,"") ) as config_UMTS';
sql:=sql+',IFNULL(power_type,"") as powerment';
sql:=sql+',longitudel_s';
sql:=sql+',longitudel_d';
sql:=sql+',bts.notes';
sql:=sql+',cross_map.bsc as bsc';
sql:=sql+',cross_map.lac as lac_2g';
sql:=sql+',rnc_number as rnc';
sql:=sql+',lac_3g';
sql:=sql+' FROM bts';
sql:=sql+' LEFT JOIN settlements';
sql:=sql+' ON bts.settlement_id=settlements.id';
sql:=sql+' LEFT JOIN areas';
sql:=sql+' ON settlements.area_id=areas.id';
sql:=sql+' LEFT JOIN regions';
sql:=sql+' ON areas.region_id=regions.id';
sql:=sql+' LEFT JOIN construction_2g_types';
sql:=sql+' ON bts.construction_2g_type_id=construction_2g_types.id';
sql:=sql+' LEFT JOIN gsm_configs plan_gsm';
sql:=sql+' ON bts.plan_gsm_config_id=plan_gsm.id';
sql:=sql+' LEFT JOIN dcs_configs plan_dcs';
sql:=sql+' ON bts.plan_dcs_config_id=plan_dcs.id';
sql:=sql+' LEFT JOIN gsm_configs work_gsm';
sql:=sql+' ON bts.work_gsm_config_id=work_gsm.id';
sql:=sql+' LEFT JOIN dcs_configs work_dcs';
sql:=sql+' ON bts.work_dcs_config_id=work_dcs.id';
sql:=sql+' LEFT JOIN construction_3g_types';
sql:=sql+' ON bts.construction_3g_type_id=construction_3g_types.id';
sql:=sql+' LEFT JOIN umts_configs plan_umts';
sql:=sql+' ON bts.plan_umts_config_id=plan_umts.id';
sql:=sql+' LEFT JOIN umts_configs work_umts';
sql:=sql+' ON bts.work_umts_config_id=work_umts.id';
sql:=sql+' LEFT JOIN power_types';
sql:=sql+' ON bts.power_type_id=power_types.id';
sql:=sql+' LEFT JOIN (SELECT * FROM mtssqlnet.bsc_mapping WHERE bsc LIKE "BSC%" GROUP BY bts_cav) cross_map';
sql:=sql+' ON cross_map.bts_cav=(SELECT bts_cav FROM mtssqlnet.bsc_mapping WHERE bts_cav=bts.bts_number LIMIT 1)';
sql:=sql+' LEFT JOIN rnc';
sql:=sql+' ON bts.rnc_id=rnc.id';

mysqlquery.Close;
mysqlquery.SQL.Clear;
mysqlquery.SQL.Add(sql);
mysqlquery.Open;

//    цикл по датасету запроса
for i:=1 to mysqlquery.RecordCount do
  begin
  inc(trunc);
  Synchronize(UpdateTrunc);

  sql:='(SELECT * FROM mtssqlnet.switching WHERE object="'+mysqlquery.fieldbyname('bts_number').AsString+'" AND category="BTS" ORDER BY -id LIMIT 1)';
  sql:=sql+'UNION';
  sql:=sql+'(SELECT * FROM mtssqlnet.switching WHERE object="'+mysqlquery.fieldbyname('bts_number').AsString+'" AND category="DCS" ORDER BY -id LIMIT 1)';
  sql:=sql+'UNION';
  sql:=sql+'(SELECT * FROM mtssqlnet.switching WHERE object="'+mysqlquery.fieldbyname('bts_number').AsString+'" AND category="3G" ORDER BY -id LIMIT 1)';
  oldquery.Close;
  oldquery.SQL.Clear;
  oldquery.SQL.Add(sql);
  oldquery.Open;
  sw1:='';
  sw2:='';
  sw3:='';
  if oldquery.FieldByName('operation').AsString='switching on' then sw1:='вкл. '+oldquery.FieldByName('date').AsString;
  if oldquery.FieldByName('operation').AsString='switching off' then sw1:='выкл. '+oldquery.FieldByName('date').AsString;
  oldquery.Next;
  if oldquery.FieldByName('operation').AsString='switching on' then sw2:='вкл. '+oldquery.FieldByName('date').AsString;
  if oldquery.FieldByName('operation').AsString='switching off' then sw2:='выкл. '+oldquery.FieldByName('date').AsString;
  oldquery.Next;
  if oldquery.FieldByName('operation').AsString='switching on' then sw3:='вкл. '+oldquery.FieldByName('date').AsString;
  if oldquery.FieldByName('operation').AsString='switching off' then sw3:='выкл. '+oldquery.FieldByName('date').AsString;

  PointType:= '34';
  PointSize:= '6';

  PointColor:= 'RGB(0,0,0)';
  if (pos('вкл.',sw1)>0) or (pos('вкл.',sw2)>0) or (pos('вкл.',sw3)>0) then PointColor:= 'RGB(0,204,0)';
  if (pos('выкл.',sw1)>0) and (pos('выкл.',sw2)>0) and (pos('выкл.',sw3)>0) then PointColor:= 'RGB(204,0,0)';

  sql:= 'Set Style Symbol MakeSymbol('+PointType+','+PointColor+','+PointSize+')';
  fserver.do(sql);

  try
  d:=mysqlquery.fieldbyname('longitudel_d').AsString;
  d:=StringReplace(d,'.',',',[rfReplaceAll, rfIgnoreCase]);
  j:=pos(' ',d);
  a1:=copy(d,1,j-1);
  d:=copy(d,j+1,length(d));
  j:=pos(' ',d);
  a2:=copy(d,1,j-1);
  d:=copy(d,j+1,length(d)-j);
  a3:=d;
  y:=floattostr((strtoint(a1)+strtoint(a2)/60+strtofloat(a3)/3600));
  y:=StringReplace(y,',','.',[rfReplaceAll, rfIgnoreCase]);

  s:=mysqlquery.fieldbyname('longitudel_s').AsString;
  s:=StringReplace(s,'.',',',[rfReplaceAll, rfIgnoreCase]);
  j:=pos(' ',s);
  a1:=copy(s,1,j-1);
  s:=copy(s,j+1,length(s));
  j:=pos(' ',s);
  a2:=copy(s,1,j-1);
  s:=copy(s,j+1,length(s)-1);
  a3:=s;
  x:=floattostr((strtoint(a1)+strtoint(a2)/60+strtofloat(a3)/3600));
  x:=StringReplace(x,',','.',[rfReplaceAll, rfIgnoreCase]);

  if (length(x)>0) and (length(y)>0) then
    begin
    sql:='INSERT INTO BTS (';
    sql:=sql+' obj';
    sql:=sql+',bts_number';
    sql:=sql+',site_type';
    sql:=sql+',address';
    sql:=sql+',place_owner';
    sql:=sql+',cooperative';
    sql:=sql+',info_2G';
    sql:=sql+',config_GSM';
    sql:=sql+',config_DCS';
    sql:=sql+',info_3G';
    sql:=sql+',config_UMTS';
    sql:=sql+',powerment';
    sql:=sql+',longitudel_d';
    sql:=sql+',longitudel_s';
    sql:=sql+',notes';
    sql:=sql+',BSC';
    sql:=sql+',lac_2g';
    sql:=sql+',RNC';
    sql:=sql+',lac_3g';
    sql:=sql+',switching_gsm';
    sql:=sql+',switching_dcs';
    sql:=sql+',switching_3g';
    sql:=sql+') VALUES (';
    sql:=sql+' CreatePoint('+y+','+x+')';
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('bts_number').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('site_type').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(FormatAddress(mysqlquery.fieldbyname('set_type').AsString,mysqlquery.fieldbyname('settlement').AsString,mysqlquery.fieldbyname('street_type').AsString,mysqlquery.fieldbyname('street_name').AsString,mysqlquery.fieldbyname('house_type').AsString,mysqlquery.fieldbyname('house_number').AsString,mysqlquery.fieldbyname('area').AsString,mysqlquery.fieldbyname('region').AsString),'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('place_owner').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('cooperative').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('info_2g').AsString,'"');
    if not empty(mysqlquery.fieldbyname('info_2g').AsString) then sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('config_GSM').AsString,'"') else sql:=sql+',""';
    if not empty(mysqlquery.fieldbyname('info_2g').AsString) then sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('config_DCS').AsString,'"') else sql:=sql+',""';
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('info_3g').AsString,'"');
    if not empty(mysqlquery.fieldbyname('info_3g').AsString) then sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('config_UMTS').AsString,'"') else sql:=sql+',""';
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('powerment').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('longitudel_s').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('longitudel_d').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('notes').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('BSC').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('lac_2g').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('RNC').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('lac_3g').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(sw1,'"');
    sql:=sql+','+AnsiQuotedStr(sw2,'"');
    sql:=sql+','+AnsiQuotedStr(sw3,'"');
    sql:=sql+')';

    fserver.do(sql);

    end;
  except
  SL.Add(mysqlquery.fieldbyname('bts_number').AsString);
  SL.SaveToFile('errors.txt');
  end;
  SL.Add(inttostr(trunc));
  SL.SaveToFile('bts.txt');
  mysqlquery.Next;
  end;

//////////////////////////////////////////////////////////////////
//       Завершение работы  BTS
sql:='Commit Table BTS';
fserver.do(sql);
sql:='Create Index on BTS(bts_number)';
fserver.do(sql);
sql:='Pack Table BTS Graphic Data';
fserver.do(sql);
//////////

/////////////////////////////////////////////////////////////////
//       Создаём слой RRL                            ////////////
sql:='Create table RRL (';
sql:=sql+' direction char(10)';
sql:=sql+',bts_1 char(100)';
sql:=sql+',height_point1 char(10)';
sql:=sql+',diam_point1 char(10)';
sql:=sql+',azimuth_point1 char(10)';
sql:=sql+',bts_2 char(100)';
sql:=sql+',height_point2 char(10)';
sql:=sql+',diam_point2 char(10)';
sql:=sql+',azimuth_point2 char(10)';
sql:=sql+',fr_range char(10)';
sql:=sql+',equipment char(20)';
sql:=sql+',stream_work char(10)';
sql:=sql+',reserve char(10)';
sql:=sql+',notes char(100)';
sql:=sql+',switching char(20)';
sql:=sql+',load char(10)';
sql:=sql+',load_without_demontation char(10)';
sql:=sql+') File "C:\mts_dbase\Programs\Scheduler\MILayers\RRL"';
FServer.do(sql);
FServer.do('Create map for RRL');

/////////////////////////////////////////////////////////////////
//      Основной запрос к базе MySQL                /////////////
sql:='SELECT';
sql:=sql+' CONCAT(bts_1.bts_number,"-",bts_2.bts_number) as direction';
sql:=sql+',bts_1.bts_number as bts_number_1';
sql:=sql+',settlements_1.type type_1';
sql:=sql+',settlements_1.settlement settlement_1';
sql:=sql+',areas_1.area area_1';
sql:=sql+',regions_1.region region_1';
sql:=sql+',bts_1.street_type as street_type_1';
sql:=sql+',bts_1.street_name as street_name_1';
sql:=sql+',bts_1.house_type as house_type_1';
sql:=sql+',bts_1.house_number as house_number_1';
sql:=sql+',height_point1';
sql:=sql+',diam_point1';
sql:=sql+',azimuth_point1';
sql:=sql+',bts_1.longitudel_s as longitudel_s_1';
sql:=sql+',bts_1.longitudel_d as longitudel_d_1';
sql:=sql+',bts_2.bts_number as bts_number_2';
sql:=sql+',settlements_2.type type_2';
sql:=sql+',settlements_2.settlement settlement_2';
sql:=sql+',areas_2.area area_2';
sql:=sql+',regions_2.region region_2';
sql:=sql+',bts_2.street_type as street_type_2';
sql:=sql+',bts_2.street_name as street_name_2';
sql:=sql+',bts_2.house_type as house_type_2';
sql:=sql+',bts_2.house_number as house_number_2';
sql:=sql+',height_point2';
sql:=sql+',diam_point2';
sql:=sql+',azimuth_point2';
sql:=sql+',bts_2.longitudel_s as longitudel_s_2';
sql:=sql+',bts_2.longitudel_d as longitudel_d_2';
sql:=sql+',fr_range';
sql:=sql+',equipment';
sql:=sql+',stream_work';
sql:=sql+',reserve';
sql:=sql+',rrl.notes';
sql:=sql+',num';
sql:=sql+' FROM rrl';
sql:=sql+' LEFT JOIN bts bts_1';
sql:=sql+' ON bts_1.id=rrl.bts_id_point1';
sql:=sql+' LEFT JOIN settlements settlements_1';
sql:=sql+' ON bts_1.settlement_id=settlements_1.id';
sql:=sql+' LEFT JOIN areas areas_1';
sql:=sql+' ON settlements_1.area_id=areas_1.id';
sql:=sql+' LEFT JOIN regions regions_1';
sql:=sql+' ON areas_1.region_id=regions_1.id';
sql:=sql+' LEFT JOIN bts bts_2';
sql:=sql+' ON bts_2.id=rrl.bts_id_point2';
sql:=sql+' LEFT JOIN settlements settlements_2';
sql:=sql+' ON bts_2.settlement_id=settlements_2.id';
sql:=sql+' LEFT JOIN areas areas_2';
sql:=sql+' ON settlements_2.area_id=areas_2.id';
sql:=sql+' LEFT JOIN regions regions_2';
sql:=sql+' ON areas_2.region_id=regions_2.id';

sql:=sql+' WHERE length(bts_1.longitudel_s)>0 AND length(bts_2.longitudel_s)>0';

mysqlquery.Close;
mysqlquery.SQL.Clear;
mysqlquery.SQL.Add(sql);
mysqlquery.Open;

//    цикл по датасету запроса
for i:=1 to mysqlquery.RecordCount do
  begin
  inc(trunc);
  Synchronize(UpdateTrunc);

  sql:='SELECT * FROM mtssqlnet.switching WHERE (object="'+mysqlquery.fieldbyname('bts_number_1').AsString+'-'+mysqlquery.fieldbyname('bts_number_2').AsString+'" OR object="'+mysqlquery.fieldbyname('bts_number_2').AsString+'-'+mysqlquery.fieldbyname('bts_number_1').AsString+'") AND rrl_num="'+mysqlquery.fieldbyname('num').AsString+'" ORDER BY -id LIMIT 1';
  oldquery.Close;
  oldquery.SQL.Clear;
  oldquery.SQL.Add(sql);
  oldquery.Open;
  sw1:='';
  if oldquery.FieldByName('operation').AsString='switching on' then sw1:='вкл. '+oldquery.FieldByName('date').AsString;
  if oldquery.FieldByName('operation').AsString='switching off' then sw1:='выкл. '+oldquery.FieldByName('date').AsString;

  if pos('б/c',mysqlquery.fieldbyname('stream_work').AsString)>0 then LineSize:= '2'
    else LineSize:= '1';
  LineType:= '2';

  LineColor:= 'RGB(0,0,0)';

  if pos('вкл.',sw1)>0 then LineColor:= 'RGB(0,204,0)';
  if pos('выкл.',sw1)>0 then LineColor:= 'RGB(204,0,0)';

  sql:= 'Set Style Pen MakePen('+LineSize+','+LineType+','+LineColor+')';
  fserver.do(sql);

  sql:='(SELECT';
  sql:=sql+' point_1';
  sql:=sql+',point_2';
  sql:=sql+',channel';
  sql:=sql+',ch_type';
  sql:=sql+' FROM mtssqlnet.bsc_bts_crossing';
  sql:=sql+' WHERE';
  sql:=sql+' ((point_1="'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_2="'+mysqlquery.fieldbyname('bts_number_2').AsString+'") OR (point_2="'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_1="'+mysqlquery.fieldbyname('bts_number_2').AsString+'"))';
  sql:=sql+' AND ch_type="rrl" AND num_rrl="'+mysqlquery.fieldbyname('num').AsString+'")';
  sql:=sql+' UNION';
  sql:=sql+' (SELECT';
  sql:=sql+' point_1';
  sql:=sql+',point_2';
  sql:=sql+',channel';
  sql:=sql+',ch_type';
  sql:=sql+' FROM mtssqlnet.mpls_crossing';
  sql:=sql+' WHERE';
  sql:=sql+' ((point_1 LIKE "'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_2 LIKE "'+mysqlquery.fieldbyname('bts_number_2').AsString+'") OR (point_2 LIKE "'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_1 LIKE "'+mysqlquery.fieldbyname('bts_number_2').AsString+'"))';
  sql:=sql+' AND ch_type="rrl" AND num_rrl="'+mysqlquery.fieldbyname('num').AsString+'")';
  sql:=sql+' UNION';
  sql:=sql+'(SELECT';
  sql:=sql+' point_1';
  sql:=sql+',point_2';
  sql:=sql+',channel';
  sql:=sql+',ch_type';
  sql:=sql+' FROM mtssqlnet.msc_crossing';
  sql:=sql+' WHERE';
  sql:=sql+' ((point_1 LIKE "'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_2 LIKE "'+mysqlquery.fieldbyname('bts_number_2').AsString+'") OR (point_2 LIKE "'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_1 LIKE "'+mysqlquery.fieldbyname('bts_number_2').AsString+'"))';
  sql:=sql+' AND ch_type="rrl" AND num_rrl="'+mysqlquery.fieldbyname('num').AsString+'")';
  oldquery.Close;
  oldquery.SQL.Clear;
  oldquery.SQL.Add(sql);
  oldquery.Open;
  load:=inttostr(oldquery.RecordCount);

  sql:='(SELECT';
  sql:=sql+' point_1';
  sql:=sql+',point_2';
  sql:=sql+',channel';
  sql:=sql+',ch_type';
  sql:=sql+',notes';
  sql:=sql+' FROM mtssqlnet.bsc_bts_crossing, mtssqlnet.bsc_mapping';
  sql:=sql+' WHERE';
  sql:=sql+' mtssqlnet.bsc_bts_crossing.mapport_id=mtssqlnet.bsc_mapping.id';
  sql:=sql+' AND ((point_1="'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_2="'+mysqlquery.fieldbyname('bts_number_2').AsString+'") OR (point_2="'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_1="'+mysqlquery.fieldbyname('bts_number_2').AsString+'"))';
  sql:=sql+' AND ch_type="rrl" AND num_rrl="'+mysqlquery.fieldbyname('num').AsString+'" AND (notes NOT LIKE "%демонтаж%" OR notes IS NULL))';
  sql:=sql+' UNION';
  sql:=sql+' (SELECT';
  sql:=sql+' point_1';
  sql:=sql+',point_2';
  sql:=sql+',channel';
  sql:=sql+',ch_type';
  sql:=sql+',ch_type as notes';
  sql:=sql+' FROM mtssqlnet.mpls_crossing';
  sql:=sql+' WHERE';
  sql:=sql+' ((point_1 LIKE "'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_2 LIKE "'+mysqlquery.fieldbyname('bts_number_2').AsString+'") OR (point_2 LIKE "'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_1 LIKE "'+mysqlquery.fieldbyname('bts_number_2').AsString+'"))';
  sql:=sql+' AND ch_type="rrl" AND num_rrl="'+mysqlquery.fieldbyname('num').AsString+'")';
  sql:=sql+' UNION';
  sql:=sql+'(SELECT';
  sql:=sql+' point_1';
  sql:=sql+',point_2';
  sql:=sql+',channel';
  sql:=sql+',ch_type';
  sql:=sql+',ch_type as notes';
  sql:=sql+' FROM mtssqlnet.msc_crossing';
  sql:=sql+' WHERE';
  sql:=sql+' ((point_1 LIKE "'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_2 LIKE "'+mysqlquery.fieldbyname('bts_number_2').AsString+'") OR (point_2 LIKE "'+mysqlquery.fieldbyname('bts_number_1').AsString+'" AND point_1 LIKE "'+mysqlquery.fieldbyname('bts_number_2').AsString+'"))';
  sql:=sql+' AND ch_type="rrl" AND num_rrl="'+mysqlquery.fieldbyname('num').AsString+'")';

  oldquery.Close;
  oldquery.SQL.Clear;
  oldquery.SQL.Add(sql);
  oldquery.Open;
  load_without_demontation:=inttostr(oldquery.RecordCount);

  try
  d1:=mysqlquery.fieldbyname('longitudel_d_1').AsString;
  s1:=mysqlquery.fieldbyname('longitudel_s_1').AsString;
  d2:=mysqlquery.fieldbyname('longitudel_d_2').AsString;
  s2:=mysqlquery.fieldbyname('longitudel_s_2').AsString;
  d1:=StringReplace(d1,'.',',',[rfReplaceAll, rfIgnoreCase]);
  s1:=StringReplace(s1,'.',',',[rfReplaceAll, rfIgnoreCase]);
  d2:=StringReplace(d2,'.',',',[rfReplaceAll, rfIgnoreCase]);
  s2:=StringReplace(s2,'.',',',[rfReplaceAll, rfIgnoreCase]);

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

  // смещение дельта
  if mysqlquery.fieldbyname('num').AsString='2' then
    begin
    d1:=floattostr(strtofloat(d1)+0.000456/2);
    d2:=floattostr(strtofloat(d2)+0.000456/2);
    s1:=floattostr(strtofloat(s1)+0.000758/2);
    s2:=floattostr(strtofloat(s2)+0.000758/2);
    end;
  if mysqlquery.fieldbyname('num').AsString='3' then
    begin
    d1:=floattostr(strtofloat(d1)+0.000456*2/2);
    d2:=floattostr(strtofloat(d2)+0.000456*2/2);
    s1:=floattostr(strtofloat(s1)+0.000758*2/2);
    s2:=floattostr(strtofloat(s2)+0.000758*2/2);
    end;
  if mysqlquery.fieldbyname('num').AsString='4' then
    begin
    d1:=floattostr(strtofloat(d1)+0.000456*3/2);
    d2:=floattostr(strtofloat(d2)+0.000456*3/2);
    s1:=floattostr(strtofloat(s1)+0.000758*3/2);
    s2:=floattostr(strtofloat(s2)+0.000758*3/2);
    end;

  d1:=StringReplace(d1,',','.',[rfReplaceAll, rfIgnoreCase]);
  s1:=StringReplace(s1,',','.',[rfReplaceAll, rfIgnoreCase]);
  d2:=StringReplace(d2,',','.',[rfReplaceAll, rfIgnoreCase]);
  s2:=StringReplace(s2,',','.',[rfReplaceAll, rfIgnoreCase]);


  if (length(s1)>0) and (length(d1)>0) and (length(s2)>0) and (length(d2)>0) then
    begin
    sql:='INSERT INTO RRL (';
    sql:=sql+' obj';
    sql:=sql+',direction';
    sql:=sql+',bts_1';
    sql:=sql+',height_point1';
    sql:=sql+',diam_point1';
    sql:=sql+',azimuth_point1';
    sql:=sql+',bts_2';
    sql:=sql+',height_point2';
    sql:=sql+',diam_point2';
    sql:=sql+',azimuth_point2';
    sql:=sql+',fr_range';
    sql:=sql+',equipment';
    sql:=sql+',stream_work';
    sql:=sql+',reserve';
    sql:=sql+',notes';
    sql:=sql+',switching';
    sql:=sql+',load';
    sql:=sql+',load_without_demontation';
    sql:=sql+') VALUES (';
    sql:=sql+' CreateLine('+d1+','+s1+','+d2+','+s2+')';
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('direction').AsString,'"');
    sql:=sql+','+AnsiQuotedStr('БС'+mysqlquery.fieldbyname('bts_number_1').AsString+' '+FormatAddress(mysqlquery.fieldbyname('type_1').AsString,mysqlquery.fieldbyname('settlement_1').AsString,mysqlquery.fieldbyname('street_type_1').AsString,mysqlquery.fieldbyname('street_name_1').AsString,mysqlquery.fieldbyname('house_type_1').AsString,mysqlquery.fieldbyname('house_number_1').AsString,mysqlquery.fieldbyname('area_1').AsString,mysqlquery.fieldbyname('region_1').AsString),'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('height_point1').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('diam_point1').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('azimuth_point1').AsString,'"');
    sql:=sql+','+AnsiQuotedStr('БС'+mysqlquery.fieldbyname('bts_number_2').AsString+' '+FormatAddress(mysqlquery.fieldbyname('type_2').AsString,mysqlquery.fieldbyname('settlement_2').AsString,mysqlquery.fieldbyname('street_type_2').AsString,mysqlquery.fieldbyname('street_name_2').AsString,mysqlquery.fieldbyname('house_type_2').AsString,mysqlquery.fieldbyname('house_number_2').AsString,mysqlquery.fieldbyname('area_2').AsString,mysqlquery.fieldbyname('region_2').AsString),'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('height_point2').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('diam_point2').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('azimuth_point2').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('fr_range').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('equipment').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('stream_work').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('reserve').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(mysqlquery.fieldbyname('notes').AsString,'"');
    sql:=sql+','+AnsiQuotedStr(sw1,'"');
    sql:=sql+','+AnsiQuotedStr(load,'"');
    sql:=sql+','+AnsiQuotedStr(load_without_demontation,'"');

    sql:=sql+')';

    fserver.do(sql);

    end;
  except
  SL.Add(mysqlquery.fieldbyname('direction').AsString);
  SL.SaveToFile('errors.txt');
  end;
  mysqlquery.Next;
  end;

//////////////////////////////////////////////////////////////////
//       Завершение работы RRL
sql:='Commit Table RRL';
fserver.do(sql);
//sql:='Create Index on RRL(bts_number)';
//fserver.do(sql);
sql:='Pack Table RRL Graphic Data';
fserver.do(sql);
//////////

//   копирование слоёв
Sl.LoadFromFile('coping.txt');
for i:=0 to sl.Count-1 do
  begin
  tx:=sl.Strings[i];
  delete(tx,1,pos(':',tx));

  if findfirst ('C:\mts_dbase\Programs\Scheduler\MILayers\*.*', faAnyFile, sr)=0 then
    repeat

    try
    CopyFile(Pchar('C:\mts_dbase\Programs\Scheduler\MILayers\'+sr.Name), Pchar(tx+sr.Name), false);
    except
    ER.Add(tx+sr.Name);
    ER.SaveToFile('errors.txt');
    end;

    until FindNext(sr) <> 0;
    sysutils.FindClose(sr);
  end;

FServer.do('end mapinfo');
CoUninitialize;
mysqlquery.Free;
oldquery.free;
ADOMysqlConnection.Free;
Sl.Free;
ER.Free;

sleep(3600000); // пауза 2 часа  }
end;

end;

end.
