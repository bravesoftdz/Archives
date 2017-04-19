unit unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, alezzle, ShellAPI;

type
  Thread = class(TThread)
   private
        { Private declarations }
   protected
     procedure Execute; override;
   end;

  TForm1 = class(TForm)
    Button1: TButton;
    Database1: TDatabase;
    Query1: TQuery;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button2: TButton;
    Query2: TQuery;
    Database2: TDatabase;
    Query3: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MyThread: Thread;

implementation

{$R *.dfm}
procedure Thread.Execute;
var
Excel:variant;
sql,id,bts_number,f_type,category,contr,mask,signature_date,last_signature_date,modern:string;
i,row,j,s,sheet,sheet_num:integer;
sr :TSearchRec;
c_date,last_date,fud_date:tdatetime;
budget_type,budget_number,budget_source,model_type,config,lac,construction_types,confjoin,cntr,gen,construction_type_id:string;
begin
Excel:=Excel_Open('templates\template_graphic.xls');

with form1 do
  begin
  for sheet:=1 to 4 do // цикл заполнения листов
  begin
  if sheet<=3 then sheet_num:=sheet else sheet_num:=sheet+2;
  Excel.Workbooks[1].Worksheets.Item[sheet_num].activate;
  if sheet=1 then  //2G
    begin
    budget_type:='budget_type_2g';
    budget_number:='budget_number_2g';
    budget_source:='budget_source_2g';
    model_type:='model_type_2g';
    config:='CONCAT(IFNULL(gsm_configs.gsm_config,"none")," ; ",IFNULL(dcs_configs.dcs_config,"none"))';
    lac:='lac_2g';
    construction_types:='construction_2g_types';
    construction_type_id:='construction_2g_type_id';
    confjoin:=         ' LEFT JOIN gsm_configs';
    confjoin:=confjoin+' ON budget.gsm_config_id=gsm_configs.id';
    confjoin:=confjoin+' LEFT JOIN dcs_configs';
    confjoin:=confjoin+' ON budget.dcs_config_id=dcs_configs.id';
    cntr:='bsc';
    gen:='2g';
    modern:='AND IFNULL('+budget_type+',"") NOT LIKE "%модерн%"';
    end;

  if sheet=2 then  //3G
    begin
    budget_type:='budget_type_3g';
    budget_number:='budget_number_3g';
    budget_source:='budget_source_3g';
    model_type:='model_type_3g';
    config:='umts_configs.umts_config';
    lac:='lac_3g';
    construction_types:='construction_3g_types';
    construction_type_id:='construction_3g_type_id';
    confjoin:=         ' LEFT JOIN umts_configs';
    confjoin:=confjoin+' ON budget.umts_config_id=umts_configs.id';
    cntr:='rnc';
    gen:='3g';
    modern:='AND IFNULL('+budget_type+',"") NOT LIKE "%модерн%"';
    end;

  if sheet=3 then  // модерн 2G
    begin
    budget_type:='budget_type_2g';
    budget_number:='budget_number_2g';
    budget_source:='budget_source_2g';
    model_type:='model_type_2g';
    config:='CONCAT(IFNULL(gsm_configs.gsm_config,"none")," ; ",IFNULL(dcs_configs.dcs_config,"none"))';
    lac:='lac_2g';
    construction_types:='construction_2g_types';
    construction_type_id:='construction_2g_type_id';
    confjoin:=         ' LEFT JOIN gsm_configs';
    confjoin:=confjoin+' ON budget.gsm_config_id=gsm_configs.id';
    confjoin:=confjoin+' LEFT JOIN dcs_configs';
    confjoin:=confjoin+' ON budget.dcs_config_id=dcs_configs.id';
    cntr:='bsc';
    gen:='2g';
    modern:='AND IFNULL('+budget_type+',"") LIKE "%модерн%"';
    end;

  if sheet=4 then  // модерн 3G
    begin
    budget_type:='budget_type_3g';
    budget_number:='budget_number_3g';
    budget_source:='budget_source_3g';
    model_type:='model_type_3g';
    config:='umts_configs.umts_config';
    lac:='lac_3g';
    construction_types:='construction_3g_types';
    construction_type_id:='construction_3g_type_id';
    confjoin:=         ' LEFT JOIN umts_configs';
    confjoin:=confjoin+' ON budget.umts_config_id=umts_configs.id';
    cntr:='rnc';
    gen:='3g';
    modern:='AND IFNULL('+budget_type+',"") LIKE "%модерн%"';
    end;

  sql:='SELECT  ';
  sql:=sql+' budget.id as id';
  sql:=sql+','+budget_type;
  sql:=sql+','+budget_number;
  sql:=sql+',demon.bts_number as demon_bts';
  sql:=sql+','+budget_source;
  sql:=sql+',bts.bts_number as bts_number';
  sql:=sql+',budget.site_type as site_type';
  sql:=sql+',technology_generation';
  sql:=sql+',construction_type';
  sql:=sql+',existing_object';
  sql:=sql+',budget_year';
  sql:=sql+',outside_id';
  sql:=sql+',budget.'+model_type;
  sql:=sql+','+config+' as config';
  sql:=sql+',transport_type';
  sql:=sql+',transport_technology';
  sql:=sql+',budget_month';
  sql:=sql+',budget.notes';
  sql:=sql+',equipment_delivered';
  sql:=sql+','+cntr+'_number';
  sql:=sql+',budget.'+lac+' as lac';
  sql:=sql+',formulars.id';
  sql:=sql+',signed_date';
  sql:=sql+',create_date';
  sql:=sql+',to_lotus_date';
  sql:=sql+',d1.action_date as act1';
  sql:=sql+',d2.action_date as act2';
  sql:=sql+',d3.action_date as act3';
  sql:=sql+',d4.action_date as act4';
  sql:=sql+' FROM budget';
  sql:=sql+' LEFT JOIN bts demon';
  sql:=sql+' ON budget.demontation_bts_id=demon.id';
  sql:=sql+' LEFT JOIN bts';
  sql:=sql+' ON budget.bts_id=bts.id';
  sql:=sql+' LEFT JOIN '+construction_types;
  sql:=sql+' ON budget.'+construction_type_id+'='+construction_types+'.id';
  sql:=sql+confjoin;
  sql:=sql+' LEFT JOIN '+cntr;
  sql:=sql+' ON budget.'+cntr+'_id='+cntr+'.id';
  sql:=sql+' LEFT JOIN formulars';
  sql:=sql+' ON budget.id=formulars.budget_id';

  sql:=sql+' LEFT JOIN formular_actions d1';
  sql:=sql+' ON d1.id=(SELECT id FROM formular_actions WHERE formular_id=formulars.id AND department="ОСПСД" AND action="sign" ORDER BY -id LIMIT 1)';

  sql:=sql+' LEFT JOIN formular_actions d2';
  sql:=sql+' ON d2.id=(SELECT id FROM formular_actions WHERE formular_id=formulars.id AND department="ОЧПиОС" AND action="sign" ORDER BY -id LIMIT 1)';

  sql:=sql+' LEFT JOIN formular_actions d3';
  sql:=sql+' ON d3.id=(SELECT id FROM formular_actions WHERE formular_id=formulars.id AND department="ОРТР" AND action="sign" ORDER BY -id LIMIT 1)';

  sql:=sql+' LEFT JOIN formular_actions d4';
  sql:=sql+' ON d4.id=(SELECT id FROM formular_actions WHERE formular_id=formulars.id AND department="ОРРП" AND action="sign" ORDER BY -id LIMIT 1)';

  sql:=sql+' WHERE technology_generation in ("'+gen+'","2g/3g") '+modern+' AND budget_year='+ComboBox1.Text+' ORDER BY budget.id';
  query1.Close;
  query1.SQL.Clear;
  query1.SQL.Add(sql);
  query1.Open;
  query1.Last;
  query1.First;

  for i:=1 to query1.RecordCount do
    begin
    row:=i+5;

    id:=query1.FieldByName('id').AsString;
    Excel.Cells[row,1].value:=inttostr(i);  // п.п
    if not empty(query1.FieldByName(budget_type).AsString) then Excel.Cells[row,3].value:=query1.FieldByName(budget_type).AsString+'_'+query1.FieldByName(budget_number).AsString;  // номер по бюджету
    Excel.Cells[row,4].value:=query1.FieldByName('demon_bts').AsString;  // номер демонт.
    Excel.Cells[row,5].value:=query1.FieldByName(budget_source).AsString;

    // адрес бюджета
    sql:='SELECT';
    sql:=sql+' region';
    sql:=sql+',area';
    sql:=sql+',settlements.type as set_type';
    sql:=sql+',settlement';
    sql:=sql+',street_type';
    sql:=sql+',street_name';
    sql:=sql+',house_type';
    sql:=sql+',house_number';
    sql:=sql+',doc_date';
    sql:=sql+' FROM budget_addresses';
    sql:=sql+' LEFT JOIN settlements';
    sql:=sql+' ON budget_addresses.settlement_id=settlements.id';
    sql:=sql+' LEFT JOIN areas';
    sql:=sql+' ON settlements.area_id=areas.id';
    sql:=sql+' LEFT JOIN regions';
    sql:=sql+' ON areas.region_id=regions.id';
    sql:=sql+' WHERE budget_id='+id;
    query2.Close;
    query2.SQL.Clear;
    query2.SQL.Add(sql);
    query2.Open;
    query2.Last;
    query2.First;

    Excel.Cells[row,6].value:=query2.FieldByName('region').AsString;
    Excel.Cells[row,7].value:=query2.FieldByName('area').AsString;
    Excel.Cells[row,8].value:=query2.FieldByName('settlement').AsString;
    Excel.Cells[row,9].value:=FormatAddress(query2.FieldByName('set_type').AsString,query2.FieldByName('settlement').AsString,query2.FieldByName('street_type').AsString,query2.FieldByName('street_name').AsString,query2.FieldByName('house_type').AsString,query2.FieldByName('house_number').AsString,query2.FieldByName('area').AsString,query2.FieldByName('region').AsString);

    bts_number:=query1.FieldByName('bts_number').AsString;
    Excel.Cells[row,10].value:=bts_number;
    Excel.Cells[row,11].value:=query1.FieldByName('site_type').AsString;

    if query2.RecordCount>1 then query2.Last;
    Excel.Cells[row,12].value:=query2.FieldByName('region').AsString;
    Excel.Cells[row,13].value:=query2.FieldByName('area').AsString;
    Excel.Cells[row,14].value:=query2.FieldByName('settlement').AsString;
    Excel.Cells[row,15].value:=FormatAddress(query2.FieldByName('set_type').AsString,query2.FieldByName('settlement').AsString,query2.FieldByName('street_type').AsString,query2.FieldByName('street_name').AsString,query2.FieldByName('house_type').AsString,query2.FieldByName('house_number').AsString,query2.FieldByName('area').AsString,query2.FieldByName('region').AsString);

    Excel.Cells[row,16].value:=query1.FieldByName('technology_generation').AsString;
    Excel.Cells[row,17].value:=query1.FieldByName('construction_type').AsString;
    if not empty(query1.FieldByName('existing_object').AsString) then Excel.Cells[row,18].value:='да';
    Excel.Cells[row,19].value:=query1.FieldByName('budget_year').AsString;
    Excel.Cells[row,2].value:=query1.FieldByName('outside_id').AsString;

    if query2.RecordCount>1 then
      begin
      query2.Last;
      s:=0;
      for j:=query2.RecordCount downto 2 do
        begin
        Excel.Cells[row,20+s].value:=FormatAddress(query2.FieldByName('set_type').AsString,query2.FieldByName('settlement').AsString,query2.FieldByName('street_type').AsString,query2.FieldByName('street_name').AsString,query2.FieldByName('house_type').AsString,query2.FieldByName('house_number').AsString,query2.FieldByName('area').AsString,query2.FieldByName('region').AsString)+' '+query2.FieldByName('doc_date').AsString;
        inc(s);
        if s=4 then break;
        query2.Prior;
        end;
      end;

    Excel.Cells[row,24].value:=query1.FieldByName(model_type).AsString;
    Excel.Cells[row,26].value:=query1.FieldByName('config').AsString;

    // даты
    Excel.Cells[row,27].value:=query1.FieldByName('create_date').AsString;
    Excel.Cells[row,38].value:=query1.FieldByName('act1').AsString;
    Excel.Cells[row,39].value:=query1.FieldByName('act2').AsString;
    Excel.Cells[row,40].value:=query1.FieldByName('act3').AsString;
    Excel.Cells[row,41].value:=query1.FieldByName('act4').AsString;
    Excel.Cells[row,42].value:=query1.FieldByName('to_lotus_date').AsString;

    if not empty(query1.FieldByName('to_lotus_date').AsString) then
      begin
      if empty(query1.FieldByName('act1').AsString) then Excel.Cells[row,38].value:=query1.FieldByName('create_date').AsString;
      if empty(query1.FieldByName('act2').AsString) then Excel.Cells[row,39].value:=query1.FieldByName('create_date').AsString;
      if empty(query1.FieldByName('act3').AsString) then Excel.Cells[row,40].value:=query1.FieldByName('create_date').AsString;
      if empty(query1.FieldByName('act4').AsString) then Excel.Cells[row,41].value:=query1.FieldByName('create_date').AsString;
      end;

    Excel.Cells[row,43].value:=query1.FieldByName('signed_date').AsString;

    /////////////////////////////////////////////////////////////////
    // запрос в старую базу

    if (query1.FieldByName('technology_generation').AsString='2g') or (query1.FieldByName('technology_generation').AsString='2g/3g') then category:='BTS';
    if query1.FieldByName('technology_generation').AsString='3g' then category:='3G';
    sql:='SELECT date FROM switching WHERE category="'+category+'" AND object="'+query1.FieldByName('bts_number').AsString+'" AND operation="switching on"';
    query3.Close;
    query3.SQL.Clear;
    query3.SQL.Add(sql);
    query3.Open;
    Excel.Cells[row,32].value:=query3.Fields[0].AsString;

    if (query1.FieldByName('technology_generation').AsString='2g') or (query1.FieldByName('technology_generation').AsString='2g/3g') then contr:='BSC';
    if (query1.FieldByName('technology_generation').AsString='3g') or (query1.FieldByName('technology_generation').AsString='2g/3g') then contr:='RNC';
    sql:='SELECT cros_date FROM bsc_mapping WHERE bts_cav="'+query1.FieldByName('bts_number').AsString+'" AND bsc LIKE "'+contr+'%"';
    query3.Close;
    query3.SQL.Clear;
    query3.SQL.Add(sql);
    query3.Open;
    Excel.Cells[row,33].value:=query3.Fields[0].AsString;
    /////////////////////////////////////////////////////////////////////

    Excel.Cells[row,29].value:=query1.FieldByName('transport_type').AsString;
    Excel.Cells[row,30].value:=query1.FieldByName('transport_technology').AsString;
    Excel.Cells[row,31].value:=query1.FieldByName('budget_month').AsString;
    Excel.Cells[row,34].value:=query1.FieldByName('notes').AsString;
    Excel.Cells[row,35].value:=query1.FieldByName(cntr+'_number').AsString;
    Excel.Cells[row,36].value:=query1.FieldByName('lac').AsString;
    if not empty(query1.FieldByName('equipment_delivered').AsString) then Excel.Cells[row,37].value:='развезено';

    if (sheet=1) or (sheet=3) then
      begin
      Excel.Cells[row,44].value:=copy(query1.FieldByName('config').AsString,1,pos(';',query1.FieldByName('config').AsString)-1);
      Excel.Cells[row,45].value:=copy(query1.FieldByName('config').AsString,pos(';',query1.FieldByName('config').AsString)+1,length(query1.FieldByName('config').AsString));
      end;

    query1.Next;
    end;
  end;
  end;

try
  Excel_Save(Excel,'\\store3\rps-develop\График вкл объектов МТС\График_вкл_объектов_МТС_'+form1.ComboBox1.Text+'.xls');
  Excel_Save(Excel,'\\store3\rps-develop\График вкл объектов МТС\Архив\График_вкл_объектов_МТС_'+form1.ComboBox1.Text+'_'+datetostr(date)+'.xls');
  except
  end;

Excel_Close(Excel);

form1.button1.Enabled:=true;
form1.ComboBox1.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
sql:string;
i:integer;
begin
database1.Connected:=true;
query1.Close;
query1.SQL.Clear;
query1.SQL.Add('SET NAMES cp1251');
query1.ExecSQL;
query3.Close;
query3.SQL.Clear;
query3.SQL.Add('SET NAMES cp1251');
query3.ExecSQL;

sql:='SELECT budget_year FROM budget GROUP BY budget_year ORDER BY budget_year DESC';
query1.Close;
query1.SQL.Clear;
query1.SQL.Add(sql);
query1.Open;

for i:=1 to query1.RecordCount do
  begin
  combobox1.Items.Add(query1.Fields[0].asstring);
  query1.Next;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
form1.Close;
form1.Release;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
if combobox1.Text<>'' then button1.Enabled:=true else button1.Enabled:=false;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
button1.Enabled:=false;
combobox1.Enabled:=false;

MyThread:= Thread.Create(False);
MyThread.Priority:=tpNormal;
//MyThread.FreeOnTerminate:=true;
end;

procedure TForm1.FormActivate(Sender: TObject);
var
s:string;
begin
// запуск с командной строки
s:=ParamStr(1);
if not empty(s) then
  begin
  combobox1.Style:=csDropDown;
  combobox1.Text:=s;
  button1.Click;
  MyThread.WaitFor;
  button2.Click;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if assigned(MyThread) then MyThread.Free;
end;

end.
