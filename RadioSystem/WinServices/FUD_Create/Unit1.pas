unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, WordXP, OleServer, ComObj;

type
  TWordReplaceFlags = set of (wrfReplaceAll, wrfMatchCase, wrfMatchWildcards);

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  WordApp, filenameOLE1: OLEVariant;
  pr_bj: Integer;

implementation

{$R *.dfm}
uses
   alezzle
  ,API_DBases
  ,API_Files
  ,FireDAC.Comp.Client;


function Word_SearchSelect(SearchString:string; sec:integer): integer;
var
a, b, vstart, vend: OleVariant;
j, ilengy, c: Integer;
tx:string;
begin_j: Integer;
begin
if empty(SearchString) then Exit;

ilengy:=Length(WordApp.ActiveDocument.Range.Text);
if sec>0 then begin_j:=pr_bj else begin_j:=0;

for begin_j:=begin_j to ilengy-length(SearchString)-1 do
  begin
  a:=j;
  b:=j+length(SearchString);

    try
    if WordApp.ActiveDocument.Range(a,b).Text=SearchString then
      begin
      vstart:=j;
      vend:=j+length(SearchString);
      pr_bj:=j;
      break;
      end;
    except
    end;
  end;

if sec>0 then
  begin
  tx:=WordApp.ActiveDocument.Range(vstart,vend).text;
  vstart:=vstart+pos('(',tx)+sec*2-2;
  end;

if vend>vstart then
  begin
  WordApp.ActiveDocument.Range(vstart,vend).Select;
  WordApp.Selection.Font.Bold := true;
  end;

Word_SearchSelect:=vstart;
end;


function Word_StringReplace(SearchString, ReplaceString: string; Flags: TWordReplaceFlags): Boolean;
const
  wdFindContinue = 1;
  wdReplaceOne = 1;
  wdReplaceAll = 2;
  wdDoNotSaveChanges = 0;
begin
  Result := False;
  with form1 do
  begin
  try
    { Initialize parameters}
    WordApp.Selection.Find.ClearFormatting;
    WordApp.Selection.Find.Text := SearchString;
    WordApp.Selection.Find.Replacement.Text := ReplaceString;
    WordApp.Selection.Find.Forward := True;
    WordApp.Selection.Find.Wrap := wdFindContinue;
    WordApp.Selection.Find.Format := False;
    WordApp.Selection.Find.MatchCase := wrfMatchCase in Flags;
    WordApp.Selection.Find.MatchWholeWord := False;
    WordApp.Selection.Find.MatchWildcards := wrfMatchWildcards in Flags;
    WordApp.Selection.Find.MatchSoundsLike := False;
    WordApp.Selection.Find.MatchAllWordForms := False;
    { Perform the search}
    if wrfReplaceAll in Flags then
      WordApp.Selection.Find.Execute(Replace := wdReplaceAll)
    else
      WordApp.Selection.Find.Execute(Replace := wdReplaceOne);
    { Assume that successful }
    Result := True;
  finally
  end;
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
form1.Close;
form1.Release;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
sql,formular_id,address,container_type,project_person,antenna_type,ftype:string;
exist2g,exist3g,exist3g9,exist4g:boolean;
sectors_count_3g,sectors_count_2g,sectors_count_3g9,sectors_count_4g: Integer;
sector_3g,sector_2g,sector_3g9,sector_4g,tnum,sectors_count:integer;
i:integer;
varcol,FileFormat:olevariant;
azimuth,cable_transport,gsm,dcs,umts,umts9,lte,pw,p_cupboard,tx,dolg,shir:string;
switch,cupboard_2g,cupboard_3g,cupboard_4g,fnotes,accept_list,notes,cooperative:string;
c,c1,c2,c3,j,ad_row_count,gsm_row_count,dcs_row_count,new_build,oldie: Integer;
bolt_sec,bolt_sec_3g,bolt_sec_dcs,bolt_sec_3g9,bolt_sec_4g: array of integer;
MySQLEngine: TMySQLEngine;
query1: TFDQuery;
query2: TFDQuery;
query3: TFDQuery;
query4: TFDQuery;
query5: TFDQuery;
begin
  MySQLEngine:=TMySQLEngine.Create;
  query1:=TFDQuery.Create(Self);
  query2:=TFDQuery.Create(Self);
  query3:=TFDQuery.Create(Self);
  query4:=TFDQuery.Create(Self);
  query5:=TFDQuery.Create(Self);
try
  try
    // лог
    TFilesEngine.SaveTextToFile('log.txt','старт: '+DateTimeToStr(Now));

    MySQLEngine.OpenConnection('MySQL.ini');
    query1.Connection:=MySQLEngine.Connection;
    query2.Connection:=MySQLEngine.Connection;
    query3.Connection:=MySQLEngine.Connection;
    query4.Connection:=MySQLEngine.Connection;
    query5.Connection:=MySQLEngine.Connection;

    formular_id:=edit1.Text;

    sql:='SELECT';
    sql:=sql+' agreement_persons.name as agreem_person';
    sql:=sql+',budget_id';
    sql:=sql+',bts_id';
    sql:=sql+',repeater_id';
    sql:=sql+',formulars.type as formular_type';
    sql:=sql+',users.name as projector_name';
    sql:=sql+',users.middle_name as projector_middle_name';
    sql:=sql+',users.surname as projector_surname';
    sql:=sql+',build_persons.name as build_person';
    sql:=sql+',inspect_date';
    sql:=sql+',create_date';
    sql:=sql+',project_organizations.title as project_organization';
    sql:=sql+',build_organizations.title as build_organization';
    sql:=sql+',formulars.notes';
    sql:=sql+' FROM formulars';
    sql:=sql+' LEFT JOIN agreement_persons';
    sql:=sql+' ON formulars.agreem_person_id=agreement_persons.id';
    sql:=sql+' LEFT JOIN users';
    sql:=sql+' ON formulars.projector_user_id=users.id';
    sql:=sql+' LEFT JOIN build_persons';
    sql:=sql+' ON formulars.build_person_id=build_persons.id';
    sql:=sql+' LEFT JOIN project_organizations';
    sql:=sql+' ON formulars.project_organization_id=project_organizations.id';
    sql:=sql+' LEFT JOIN build_organizations';
    sql:=sql+' ON formulars.build_organization_id=build_organizations.id';
    sql:=sql+' WHERE formulars.id="'+formular_id+'"';
    query1.Close;
    query1.SQL.Clear;
    query1.SQL.Add(sql);
    query1.Open;

    if not query1.fieldbyname('bts_id').IsNull then
      begin
      filenameOLE1:=GetCurrentDir+'\templates\FUD_template.doc';
      ftype:='bts';
      end;
    if not query1.fieldbyname('repeater_id').IsNull then
      begin
      filenameOLE1:=GetCurrentDir+'\templates\FUD_rep_template.doc';
      ftype:='repeater';
      end;

    // лог
    TFilesEngine.AppendToFile('log.txt','тип объекта: '+ftype);
    TFilesEngine.AppendToFile('log.txt','тип фуда: '+query1.fieldbyname('formular_type').AsString);

    try
      WordApp := CreateOLEObject('Word.Application');
      WordApp.Visible := false;
      WordApp.Documents.Open(filenameOLE1);
      // лог
      TFilesEngine.AppendToFile('log.txt','шаблон: '+filenameOLE1+' успешо открыт');
    except
      // лог
      TFilesEngine.AppendToFile('log.txt','шаблон: '+filenameOLE1+' ошибка открытия');
      Exit;
    end;

    sql:='SELECT * FROM budget WHERE id="'+query1.fieldbyname('budget_id').AsString+'"';
    query2.Close;
    query2.SQL.Clear;
    query2.SQL.Add(sql);
    query2.Open;

    if ftype='bts' then
      begin
      sql:='SELECT';
      sql:=sql+' bts_number';
      sql:=sql+',bts.id';
      sql:=sql+',street_type';
      sql:=sql+',street_name';
      sql:=sql+',house_type';
      sql:=sql+',house_number';
      sql:=sql+',type';
      sql:=sql+',settlement';
      sql:=sql+',area';
      sql:=sql+',region';
      sql:=sql+',place_owner';
      sql:=sql+',container_type';
      sql:=sql+',construction_3g_types.construction_type as construction_type_3g';
      sql:=sql+',construction_2g_types.construction_type as construction_type_2g';
      sql:=sql+',construction_4g_types.construction_type as construction_type_4g';
      sql:=sql+',focl_2g';
      sql:=sql+',rent_2g';
      sql:=sql+',focl_3g';
      sql:=sql+',rent_3g';
      sql:=sql+',model_type_2g';
      sql:=sql+',model_type_3g';
      sql:=sql+',model_type_4g';
      sql:=sql+',plangsm.gsm_config as plan_gsm';
      sql:=sql+',installgsm.gsm_config as install_gsm';
      sql:=sql+',plandcs.dcs_config as plan_dcs';
      sql:=sql+',installdcs.dcs_config as install_dcs';
      sql:=sql+',planumts.umts_config as plan_umts';
      sql:=sql+',workumts.umts_config as work_umts';
      sql:=sql+',planumts9.umts_config as plan_umts9';
      sql:=sql+',workumts9.umts_config as work_umts9';
      sql:=sql+',planlte.lte_config as plan_lte';
      sql:=sql+',worklte.lte_config as work_lte';
      sql:=sql+',cupboard_3g_count';
      sql:=sql+',cupboard_4g_count';
      sql:=sql+',power_type';
      sql:=sql+',battery_capacity';
      sql:=sql+',power_cupboard_count';
      sql:=sql+',longitudel_s';
      sql:=sql+',longitudel_d';
      sql:=sql+',cupboard_2g_count';
      sql:=sql+',bts.notes';
      sql:=sql+',cooperative';
      sql:=sql+' FROM bts';
      sql:=sql+' LEFT JOIN settlements';
      sql:=sql+' ON bts.settlement_id=settlements.id';
      sql:=sql+' LEFT JOIN areas';
      sql:=sql+' ON settlements.area_id=areas.id';
      sql:=sql+' LEFT JOIN regions';
      sql:=sql+' ON areas.region_id=regions.id';
      sql:=sql+' LEFT JOIN construction_3g_types';
      sql:=sql+' ON bts.construction_3g_type_id=construction_3g_types.id';
      sql:=sql+' LEFT JOIN construction_4g_types';
      sql:=sql+' ON bts.construction_4g_type_id=construction_4g_types.id';
      sql:=sql+' LEFT JOIN construction_2g_types';
      sql:=sql+' ON bts.construction_2g_type_id=construction_2g_types.id';
      sql:=sql+' LEFT JOIN gsm_configs plangsm';
      sql:=sql+' ON bts.plan_gsm_config_id=plangsm.id';
      sql:=sql+' LEFT JOIN gsm_configs installgsm';
      sql:=sql+' ON bts.install_gsm_config_id=installgsm.id';
      sql:=sql+' LEFT JOIN dcs_configs plandcs';
      sql:=sql+' ON bts.plan_dcs_config_id=plandcs.id';
      sql:=sql+' LEFT JOIN dcs_configs installdcs';
      sql:=sql+' ON bts.install_dcs_config_id=installdcs.id';
      sql:=sql+' LEFT JOIN umts_configs planumts';
      sql:=sql+' ON bts.plan_umts_config_id=planumts.id';
      sql:=sql+' LEFT JOIN umts_configs workumts';
      sql:=sql+' ON bts.work_umts_config_id=workumts.id';
      sql:=sql+' LEFT JOIN umts_configs planumts9';
      sql:=sql+' ON bts.plan_umts9_config_id=planumts9.id';
      sql:=sql+' LEFT JOIN umts_configs workumts9';
      sql:=sql+' ON bts.work_umts9_config_id=workumts9.id';
      sql:=sql+' LEFT JOIN lte_configs planlte';
      sql:=sql+' ON bts.plan_lte_config_id=planlte.id';
      sql:=sql+' LEFT JOIN lte_configs worklte';
      sql:=sql+' ON bts.work_lte_config_id=worklte.id';
      sql:=sql+' LEFT JOIN power_types';
      sql:=sql+' ON bts.power_type_id=power_types.id';
      sql:=sql+' WHERE bts.id="'+query1.fieldbyname('bts_id').AsString+'"';
      end;
    if ftype='repeater' then
      begin
      sql:='SELECT';
      sql:=sql+' repeater_number';
      sql:=sql+',repeaters.id';
      sql:=sql+',street_type';
      sql:=sql+',street_name';
      sql:=sql+',house_type';
      sql:=sql+',house_number';
      sql:=sql+',type';
      sql:=sql+',settlement';
      sql:=sql+',area';
      sql:=sql+',region';
      sql:=sql+',place_owner';
      sql:=sql+',repeater_type';
      sql:=sql+',gsm_config';
      sql:=sql+',dcs_config';
      sql:=sql+',umts_config';
      sql:=sql+',power_type';
      sql:=sql+',longitudel_s';
      sql:=sql+',longitudel_d';
      sql:=sql+',repeaters.notes';
      sql:=sql+' FROM repeaters';
      sql:=sql+' LEFT JOIN settlements';
      sql:=sql+' ON repeaters.settlement_id=settlements.id';
      sql:=sql+' LEFT JOIN areas';
      sql:=sql+' ON settlements.area_id=areas.id';
      sql:=sql+' LEFT JOIN regions';
      sql:=sql+' ON areas.region_id=regions.id';
      sql:=sql+' LEFT JOIN repeater_types';
      sql:=sql+' ON repeaters.repeater_type_id=repeater_types.id';
      sql:=sql+' LEFT JOIN gsm_configs';
      sql:=sql+' ON repeaters.gsm_config_id=gsm_configs.id';
      sql:=sql+' LEFT JOIN dcs_configs';
      sql:=sql+' ON repeaters.dcs_config_id=dcs_configs.id';
      sql:=sql+' LEFT JOIN umts_configs';
      sql:=sql+' ON repeaters.umts_config_id=umts_configs.id';
      sql:=sql+' LEFT JOIN power_types';
      sql:=sql+' ON repeaters.power_type_id=power_types.id';
      sql:=sql+' WHERE repeaters.id="'+query1.fieldbyname('repeater_id').AsString+'"';
      end;
    query3.Close;
    query3.SQL.Clear;
    query3.SQL.Add(sql);
    query3.Open;

    sql:='SELECT * FROM history WHERE table_name IN("sectors","bts","rrl","repeaters") AND (object_id="'+query1.fieldbyname('bts_id').AsString+'" OR object_id="'+query1.fieldbyname('repeater_id').AsString+'") AND act_date>=:d ORDER BY action';
    query5.Close;
    query5.SQL.Clear;
    query5.SQL.Add(sql);
    query5.ParamByName('d').AsDateTime:=query1.fieldbyname('create_date').AsDateTime;
    query5.Open;
    query5.FetchAll;

    Word_StringReplace('{formular_type}',query1.fieldbyname('formular_type').AsString,[wrfReplaceAll]);
    Word_StringReplace('{budget_year}',query2.fieldbyname('budget_year').AsString,[wrfReplaceAll]);

    if query1.fieldbyname('notes').AsString<>'' then fnotes:='('+query1.fieldbyname('notes').AsString+')' else fnotes:='';
    Word_StringReplace('{fnotes}',fnotes,[wrfReplaceAll]);
    Word_SearchSelect(fnotes,0);

    if query1.fieldbyname('formular_type').AsString='Модернизация под 3G' then Word_SearchSelect(query1.fieldbyname('formular_type').AsString,0);
    if query1.fieldbyname('formular_type').AsString='Новое строительство' then new_build:=1;

    if ftype='bts' then address:=query3.fieldbyname('bts_number').AsString+' '+FormatAddress(query3.fieldbyname('type').AsString,query3.fieldbyname('settlement').AsString,query3.fieldbyname('street_type').AsString,query3.fieldbyname('street_name').AsString,query3.fieldbyname('house_type').AsString,query3.fieldbyname('house_number').AsString,query3.fieldbyname('area').AsString,query3.fieldbyname('region').AsString);
    if ftype='repeater' then address:='Р'+query3.fieldbyname('repeater_number').AsString+' '+FormatAddress(query3.fieldbyname('type').AsString,query3.fieldbyname('settlement').AsString,query3.fieldbyname('street_type').AsString,query3.fieldbyname('street_name').AsString,query3.fieldbyname('house_type').AsString,query3.fieldbyname('house_number').AsString,query3.fieldbyname('area').AsString,query3.fieldbyname('region').AsString);

    // лог
    if ftype='bts' then TFilesEngine.AppendToFile('log.txt','номер БС: '+query3.fieldbyname('bts_number').AsString);
    if ftype='repeater' then TFilesEngine.AppendToFile('log.txt','номер Р: '+query3.fieldbyname('repeater_number').AsString);

    Word_StringReplace('{address}',address,[wrfReplaceAll]);

    Word_StringReplace('{place_owner}',query3.fieldbyname('place_owner').AsString,[wrfReplaceAll]);
    if ftype='bts' then
      begin
      if not empty(query3.fieldbyname('cooperative').AsString) then cooperative:=', '+query3.fieldbyname('cooperative').AsString else cooperative:='';
      Word_StringReplace('{cooperative}',cooperative,[wrfReplaceAll]);

      if not empty(query3.fieldbyname('container_type').AsString) then container_type:=' + '+query3.fieldbyname('container_type').AsString else container_type:='';
      Word_StringReplace('{container_type}',container_type,[wrfReplaceAll]);
      end;

    Word_StringReplace('{agreem_person}',query1.fieldbyname('agreem_person').AsString,[wrfReplaceAll]);

    try
      project_person:=query1.fieldbyname('projector_surname').AsString+' '+query1.fieldbyname('projector_name').AsString[1]+'.'+query1.fieldbyname('projector_middle_name').AsString[1]+'.';
    except
      project_person:='';
    end;
    Word_StringReplace('{project_person}',project_person,[wrfReplaceAll]);

    Word_StringReplace('{build_person}',query1.fieldbyname('build_person').AsString,[wrfReplaceAll]);


    Word_StringReplace('{project_organization}',query1.fieldbyname('project_organization').AsString,[wrfReplaceAll]);
    Word_StringReplace('{build_organization}',query1.fieldbyname('build_organization').AsString,[wrfReplaceAll]);
    Word_StringReplace('{inspect_date}',query1.fieldbyname('inspect_date').AsString,[wrfReplaceAll]);

    ///////////////////  сектора BTS ///////////////////////////////////////////////
    if ftype='bts' then
      begin
      sql:='SELECT * FROM sectors WHERE bts_id="'+query1.fieldbyname('bts_id').AsString+'"';
      query4.Close;
      query4.SQL.Clear;
      query4.SQL.Add(sql);
      query4.Open;
      exist2g:=false;
      exist3g:=false;
      exist3g9:=false;
      exist4g:=false;
      sectors_count_2g:=0;
      sectors_count_3g:=0;
      sectors_count_3g9:=0;
      sectors_count_4g:=0;
      sector_3g:=0;
      sector_2g:=0;
      sector_3g9:=0;
      sector_4g:=0;
      for i:=1 to query4.RecordCount do
        begin
        if (query4.fieldbyname('tech_type').asstring = '2g') or (query4.fieldbyname('tech_type').asstring = 'gsm') or (query4.fieldbyname('tech_type').asstring = 'dcs') then
          begin
          exist2g:=true;
          if query4.fieldbyname('num').AsInteger<>sector_2g then
            begin
            inc(sectors_count_2g);
            sector_2g:=query4.fieldbyname('num').AsInteger;
            end;
          end;
        if query4.fieldbyname('tech_type').asstring = 'umts 2100' then
          begin
          exist3g:=true;
          if query4.fieldbyname('num').AsInteger<>sector_3g then
            begin
            inc(sectors_count_3g);
            sector_3g:=query4.fieldbyname('num').AsInteger;
            end;
          end;
        if query4.fieldbyname('tech_type').asstring = 'umts 900' then
          begin
          exist3g9:=true;
          if query4.fieldbyname('num').AsInteger<>sector_3g9 then
            begin
            inc(sectors_count_3g9);
            sector_3g9:=query4.fieldbyname('num').AsInteger;
            end;
          end;
        if query4.fieldbyname('tech_type').asstring = 'lte 1800' then
          begin
          exist4g:=true;
          if query4.fieldbyname('num').AsInteger<>sector_4g then
            begin
            inc(sectors_count_4g);
            sector_4g:=query4.fieldbyname('num').AsInteger;
            end;
          end;
        query4.Next;
        end;
      query4.First;

      if exist2g then // если существуют 2G сектора
        begin
        // лог
        TFilesEngine.AppendToFile('log.txt','заполнение секторов 2G: '+DateTimeToStr(Now));

        Word_StringReplace('{2G}','2G',[wrfReplaceAll]);
        Word_StringReplace('{construction_2g_type}',query3.fieldbyname('construction_type_2g').asstring,[wrfReplaceAll]);
        Word_StringReplace('{sectors_count_2g}',inttostr(sectors_count_2g),[wrfReplaceAll]);

        sql:='SELECT';    // запрос
        sql:=sql+' num';
        sql:=sql+',height';
        sql:=sql+',sectors.tech_type';
        sql:=sql+',antenna_type';
        sql:=sql+',antenna_count';
        sql:=sql+',azimuth';
        sql:=sql+',te_slope';
        sql:=sql+',tm_slope';
        sql:=sql+',cable_type';
        sql:=sql+',cable_length';
        sql:=sql+',msu_type';
        sql:=sql+',ret_type';
        sql:=sql+' FROM sectors';
        sql:=sql+' LEFT JOIN antenna_types';
        sql:=sql+' ON sectors.antenna_type_id=antenna_types.id';
        sql:=sql+' WHERE bts_id="'+query1.fieldbyname('bts_id').AsString+'" AND sectors.tech_type IN ("2g","gsm","dcs") ORDER BY num';
        query4.Close;
        query4.SQL.Clear;
        query4.SQL.Add(sql);
        query4.Open;

        /////      добовляем строки в таблицу секторов 2G ////////////////////////
        if (query4.RecordCount>3) then
          for i:=1 to query4.RecordCount-3 do
            begin
            varcol:=WordApp.ActiveDocument.Tables.Item(2).rows.Item(4);
            WordApp.ActiveDocument.Tables.Item(2).rows.Add(varcol);
            end;
        query4.first;

        /////     заполняем таблицу секторов 2G ///////////////
        gsm_row_count:=0;
        dcs_row_count:=0;
        for i:=1 to query4.RecordCount do
          begin
          if query4.fieldbyname('tech_type').AsString='gsm' then
            begin
            gsm:='(gsm)';
            inc(gsm_row_count);
            end else gsm:='';
          if query4.fieldbyname('tech_type').AsString='dcs' then
            begin
            dcs:='(dcs)';
            inc(dcs_row_count);
            end else dcs:='';
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,1).Range.text:=query4.fieldbyname('num').AsString+' '+gsm+dcs;
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,2).Range.text:=query4.fieldbyname('height').AsString;
          antenna_type:=query4.fieldbyname('antenna_type').AsString;
          if query4.fieldbyname('antenna_count').AsInteger>1 then antenna_type:=antenna_type+' - '+query4.fieldbyname('antenna_count').AsString+' шт.';
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,3).Range.text:=antenna_type;
          azimuth:=query4.fieldbyname('azimuth').AsString;
          if strtointdef(azimuth,-1)=-1 then azimuth:='indoor';
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,4).Range.text:=azimuth;
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,5).Range.text:=query4.fieldbyname('tm_slope').AsString;
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,6).Range.text:=query4.fieldbyname('te_slope').AsString;
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,7).Range.text:=query4.fieldbyname('cable_type').AsString;
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,8).Range.text:=query4.fieldbyname('cable_length').AsString;
          WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,9).Range.text:=query4.fieldbyname('msu_type').AsString;

          // выделение
          c1:=0;
          c2:=0;
          c3:=0;
          query5.First;
          if new_build<>1 then
          for j:=1 to query5.RecordCount do
            begin
            if (query5.fieldbyname('table_name').AsString='sectors') and (query5.fieldbyname('action').AsString<>'delete') then
              begin
              if (pos(query4.fieldbyname('height').AsString,query5.fieldbyname('changes').AsString)>0) then c1:=1;
              if (pos(query4.fieldbyname('antenna_type').AsString,query5.fieldbyname('changes').AsString)>0) then c2:=1;
              if (pos(query4.fieldbyname('azimuth').AsString,query5.fieldbyname('changes').AsString)>0) then c3:=1;
              end;

            query5.Next;
            end;

          if (c1=1) and (c2=1) and (c3=1) then
            begin
            c:=1;
            if query4.fieldbyname('tech_type').AsString='gsm' then
              begin
              setlength(bolt_sec,length(bolt_sec)+1);
              bolt_sec[length(bolt_sec)-1]:=gsm_row_count;
              end;
            if query4.fieldbyname('tech_type').AsString='dcs' then
              begin
              setlength(bolt_sec_dcs,length(bolt_sec_dcs)+1);
              bolt_sec_dcs[length(bolt_sec_dcs)-1]:=dcs_row_count;
              end;
            end
            else c:=0;

          if c=1 then
            begin
            for j:=1 to 9 do
              WordApp.ActiveDocument.Tables.Item(2).Cell(3+i,j).Range.font.bold:=wdToggle;
            end;

          query4.Next;
          end;

        tnum:=3;
        ///////////////////////////////////////////////////////
        end;

      if not exist2g then
        begin
        Word_StringReplace('{2G}','',[wrfReplaceAll]);
        WordApp.ActiveDocument.Tables.Item(2).delete;

        tnum:=2;
        end;

      if exist3g then  // если существуют 3G сектора
        begin
        // лог
        TFilesEngine.AppendToFile('log.txt','заполнение секторов UMTS 2100: '+DateTimeToStr(Now));

        Word_StringReplace('{3G}','UMTS 2100',[wrfReplaceAll]);
        Word_StringReplace('{construction_3g_type}',query3.fieldbyname('construction_type_3g').asstring,[wrfReplaceAll]);
        Word_StringReplace('{sectors_count_3g}',inttostr(sectors_count_3g),[wrfReplaceAll]);

        sql:='SELECT';    // запрос
        sql:=sql+' num';
        sql:=sql+',height';
        sql:=sql+',antenna_type';
        sql:=sql+',antenna_count';
        sql:=sql+',azimuth';
        sql:=sql+',te_slope';
        sql:=sql+',tm_slope';
        sql:=sql+',cable_type';
        sql:=sql+',cable_length';
        sql:=sql+',msu_type';
        sql:=sql+',ret_type';
        sql:=sql+' FROM sectors';
        sql:=sql+' LEFT JOIN antenna_types';
        sql:=sql+' ON sectors.antenna_type_id=antenna_types.id';
        sql:=sql+' WHERE bts_id="'+query1.fieldbyname('bts_id').AsString+'" AND sectors.tech_type IN ("umts 2100")';
        query4.Close;
        query4.SQL.Clear;
        query4.SQL.Add(sql);
        query4.Open;

        /////      добовляем строки в таблицу секторов 3G ////////////////////////
        if (query4.RecordCount>3) then
          for i:=1 to query4.RecordCount-3 do
            begin
            varcol:=WordApp.ActiveDocument.Tables.Item(tnum).rows.Item(4);
            WordApp.ActiveDocument.Tables.Item(tnum).rows.Add(varcol);
            end;
        query4.first;
        /////     заполняем таблицу секторов 3G ///////////////
        for i:=1 to query4.RecordCount do
          begin
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,1).Range.text:=query4.fieldbyname('num').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,2).Range.text:=query4.fieldbyname('height').AsString;
          antenna_type:=query4.fieldbyname('antenna_type').AsString;
          if query4.fieldbyname('antenna_count').AsInteger>1 then antenna_type:=antenna_type+' - '+query4.fieldbyname('antenna_count').AsString+' шт.';
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,3).Range.text:=antenna_type;
          azimuth:=query4.fieldbyname('azimuth').AsString;
          if strtointdef(azimuth,-1)=-1 then azimuth:='indoor';
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,4).Range.text:=azimuth;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,5).Range.text:=query4.fieldbyname('tm_slope').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,6).Range.text:=query4.fieldbyname('te_slope').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,7).Range.text:=query4.fieldbyname('cable_type').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,8).Range.text:=query4.fieldbyname('cable_length').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,9).Range.text:=query4.fieldbyname('ret_type').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,10).Range.text:=query4.fieldbyname('msu_type').AsString;

          // выделение
          c1:=0;
          c2:=0;
          c3:=0;
          query5.First;
          if new_build<>1 then
          for j:=1 to query5.RecordCount do
            begin
            if (query5.fieldbyname('table_name').AsString='sectors') and (query5.fieldbyname('action').AsString<>'delete') then
              begin
              if (pos(query4.fieldbyname('height').AsString,query5.fieldbyname('changes').AsString)>0) then c1:=1;
              if (pos(query4.fieldbyname('antenna_type').AsString,query5.fieldbyname('changes').AsString)>0) then c2:=1;
              if (pos(query4.fieldbyname('azimuth').AsString,query5.fieldbyname('changes').AsString)>0) then c3:=1;
              end;
            query5.Next;
            end;

          if (c1=1) and (c2=1) and (c3=1) then
            begin
            c:=1;
            setlength(bolt_sec_3g,length(bolt_sec_3g)+1);
            bolt_sec_3g[length(bolt_sec_3g)-1]:=i;
            end
            else c:=0;

          if c=1 then
            begin
            for j:=1 to 10 do
              WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,j).Range.font.bold:=wdToggle;
            end;

          query4.Next;
          end;

        inc(tnum);
        ///////////////////////////////////////////////////////
        end;

      if not exist3g then
        begin
        Word_StringReplace('{3G}','',[wrfReplaceAll]);
        WordApp.ActiveDocument.Tables.Item(tnum).delete;
        end;


      if exist3g9 then  // если существуют UMTS 900 сектора
        begin
        // лог
        TFilesEngine.AppendToFile('log.txt','заполнение секторов UMTS 900: '+DateTimeToStr(Now));

        Word_StringReplace('{3G9}','UMTS 900',[wrfReplaceAll]);
        Word_StringReplace('{construction_3g_type}',query3.fieldbyname('construction_type_3g').asstring,[wrfReplaceAll]);
        Word_StringReplace('{sectors_count_3g9}',inttostr(sectors_count_3g9),[wrfReplaceAll]);

        sql:='SELECT';    // запрос
        sql:=sql+' num';
        sql:=sql+',height';
        sql:=sql+',antenna_type';
        sql:=sql+',antenna_count';
        sql:=sql+',azimuth';
        sql:=sql+',te_slope';
        sql:=sql+',tm_slope';
        sql:=sql+',cable_type';
        sql:=sql+',cable_length';
        sql:=sql+',msu_type';
        sql:=sql+',ret_type';
        sql:=sql+' FROM sectors';
        sql:=sql+' LEFT JOIN antenna_types';
        sql:=sql+' ON sectors.antenna_type_id=antenna_types.id';
        sql:=sql+' WHERE bts_id="'+query1.fieldbyname('bts_id').AsString+'" AND sectors.tech_type IN ("umts 900")';
        query4.Close;
        query4.SQL.Clear;
        query4.SQL.Add(sql);
        query4.Open;

        /////      добовляем строки в таблицу секторов 3G9 ////////////////////////
        if (query4.RecordCount>3) then
          for i:=1 to query4.RecordCount-3 do
            begin
            varcol:=WordApp.ActiveDocument.Tables.Item(tnum).rows.Item(4);
            WordApp.ActiveDocument.Tables.Item(tnum).rows.Add(varcol);
            end;
        query4.first;
        /////     заполняем таблицу секторов 3G9 ///////////////
        for i:=1 to query4.RecordCount do
          begin
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,1).Range.text:=query4.fieldbyname('num').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,2).Range.text:=query4.fieldbyname('height').AsString;
          antenna_type:=query4.fieldbyname('antenna_type').AsString;
          if query4.fieldbyname('antenna_count').AsInteger>1 then antenna_type:=antenna_type+' - '+query4.fieldbyname('antenna_count').AsString+' шт.';
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,3).Range.text:=antenna_type;
          azimuth:=query4.fieldbyname('azimuth').AsString;
          if strtointdef(azimuth,-1)=-1 then azimuth:='indoor';
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,4).Range.text:=azimuth;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,5).Range.text:=query4.fieldbyname('tm_slope').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,6).Range.text:=query4.fieldbyname('te_slope').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,7).Range.text:=query4.fieldbyname('cable_type').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,8).Range.text:=query4.fieldbyname('cable_length').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,9).Range.text:=query4.fieldbyname('ret_type').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,10).Range.text:=query4.fieldbyname('msu_type').AsString;

          // выделение
          c1:=0;
          c2:=0;
          c3:=0;
          query5.First;
          if new_build<>1 then
          for j:=1 to query5.RecordCount do
            begin
            if (query5.fieldbyname('table_name').AsString='sectors') and (query5.fieldbyname('action').AsString<>'delete') then
              begin
              if (pos(query4.fieldbyname('height').AsString,query5.fieldbyname('changes').AsString)>0) then c1:=1;
              if (pos(query4.fieldbyname('antenna_type').AsString,query5.fieldbyname('changes').AsString)>0) then c2:=1;
              if (pos(query4.fieldbyname('azimuth').AsString,query5.fieldbyname('changes').AsString)>0) then c3:=1;
              end;
            query5.Next;
            end;

          if (c1=1) and (c2=1) and (c3=1) then
            begin
            c:=1;
            setlength(bolt_sec_3g9,length(bolt_sec_3g9)+1);
            bolt_sec_3g9[length(bolt_sec_3g9)-1]:=i;
            end
            else c:=0;

          if c=1 then
            begin
            for j:=1 to 10 do
              WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,j).Range.font.bold:=wdToggle;
            end;

          query4.Next;
          end;

        inc(tnum);
        ///////////////////////////////////////////////////////
        end;

      if not exist3g9 then
        begin
        Word_StringReplace('{3G9}','',[wrfReplaceAll]);
        WordApp.ActiveDocument.Tables.Item(tnum).delete;
        end;

      if exist4g then  // если существуют LTE 1800 сектора
        begin
        // лог
        TFilesEngine.AppendToFile('log.txt','заполнение секторов LTE: '+DateTimeToStr(Now));

        Word_StringReplace('{4G}','LTE 1800',[wrfReplaceAll]);
        Word_StringReplace('{construction_4g_type}',query3.fieldbyname('construction_type_4g').asstring,[wrfReplaceAll]);
        Word_StringReplace('{sectors_count_4g}',inttostr(sectors_count_4g),[wrfReplaceAll]);

        sql:='SELECT';    // запрос
        sql:=sql+' num';
        sql:=sql+',height';
        sql:=sql+',antenna_type';
        sql:=sql+',antenna_count';
        sql:=sql+',azimuth';
        sql:=sql+',te_slope';
        sql:=sql+',tm_slope';
        sql:=sql+',cable_type';
        sql:=sql+',cable_length';
        sql:=sql+',msu_type';
        sql:=sql+',ret_type';
        sql:=sql+' FROM sectors';
        sql:=sql+' LEFT JOIN antenna_types';
        sql:=sql+' ON sectors.antenna_type_id=antenna_types.id';
        sql:=sql+' WHERE bts_id="'+query1.fieldbyname('bts_id').AsString+'" AND sectors.tech_type IN ("lte 1800")';
        query4.Close;
        query4.SQL.Clear;
        query4.SQL.Add(sql);
        query4.Open;

        /////      добовляем строки в таблицу секторов 4g ////////////////////////
        if (query4.RecordCount>3) then
          for i:=1 to query4.RecordCount-3 do
            begin
            varcol:=WordApp.ActiveDocument.Tables.Item(tnum).rows.Item(4);
            WordApp.ActiveDocument.Tables.Item(tnum).rows.Add(varcol);
            end;
        query4.first;
        /////     заполняем таблицу секторов 4g ///////////////
        for i:=1 to query4.RecordCount do
          begin
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,1).Range.text:=query4.fieldbyname('num').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,2).Range.text:=query4.fieldbyname('height').AsString;
          antenna_type:=query4.fieldbyname('antenna_type').AsString;
          if query4.fieldbyname('antenna_count').AsInteger>1 then antenna_type:=antenna_type+' - '+query4.fieldbyname('antenna_count').AsString+' шт.';
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,3).Range.text:=antenna_type;
          azimuth:=query4.fieldbyname('azimuth').AsString;
          if strtointdef(azimuth,-1)=-1 then azimuth:='indoor';
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,4).Range.text:=azimuth;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,5).Range.text:=query4.fieldbyname('tm_slope').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,6).Range.text:=query4.fieldbyname('te_slope').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,7).Range.text:=query4.fieldbyname('cable_type').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,8).Range.text:=query4.fieldbyname('cable_length').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,9).Range.text:=query4.fieldbyname('ret_type').AsString;
          WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,10).Range.text:=query4.fieldbyname('msu_type').AsString;

          // выделение
          c1:=0;
          c2:=0;
          c3:=0;
          query5.First;
          if new_build<>1 then
          for j:=1 to query5.RecordCount do
            begin
            if (query5.fieldbyname('table_name').AsString='sectors') and (query5.fieldbyname('action').AsString<>'delete') then
              begin
              if (pos(query4.fieldbyname('height').AsString,query5.fieldbyname('changes').AsString)>0) then c1:=1;
              if (pos(query4.fieldbyname('antenna_type').AsString,query5.fieldbyname('changes').AsString)>0) then c2:=1;
              if (pos(query4.fieldbyname('azimuth').AsString,query5.fieldbyname('changes').AsString)>0) then c3:=1;
              end;
            query5.Next;
            end;

          if (c1=1) and (c2=1) and (c3=1) then
            begin
            c:=1;
            setlength(bolt_sec_4g,length(bolt_sec_4g)+1);
            bolt_sec_4g[length(bolt_sec_4g)-1]:=i;
            end
            else c:=0;

          if c=1 then
            begin
            for j:=1 to 10 do
              WordApp.ActiveDocument.Tables.Item(tnum).Cell(3+i,j).Range.font.bold:=wdToggle;
            end;

          query4.Next;
          end;

        inc(tnum);
        ///////////////////////////////////////////////////////
        end;

      if not exist4g then
        begin
        Word_StringReplace('{4G}','',[wrfReplaceAll]);
        WordApp.ActiveDocument.Tables.Item(tnum).delete;
        end;
     end;
    ///////////////////  сектора repeaters ///////////////////////////////////////////////
    if ftype='repeater' then
      begin
      sql:='SELECT';
      sql:=sql+' num';
      sql:=sql+',height';
      sql:=sql+',antenna_type';
      sql:=sql+',azimuth';
      sql:=sql+',tm_slope';
      sql:=sql+',te_slope';
      sql:=sql+',cable_type';
      sql:=sql+',cable_length';
      sql:=sql+',notes';
      sql:=sql+' FROM repeater_sectors';
      sql:=sql+' LEFT JOIN antenna_types';
      sql:=sql+' ON repeater_sectors.antenna_type_id=antenna_types.id';
      sql:=sql+' WHERE repeater_id="'+query1.fieldbyname('repeater_id').AsString+'" AND num>0 ORDER BY num';
      query4.Close;
      query4.SQL.Clear;
      query4.SQL.Add(sql);
      query4.Open;
      query4.Last;
      query4.First;
      sectors_count:=query4.RecordCount;
      Word_StringReplace('{sec_count}',inttostr(sectors_count),[wrfReplaceAll]);

      /////  добавляем строки в таблицу секторов репитера ////////////////////////
      if (sectors_count>3) then
        for i:=1 to sectors_count-3 do
          begin
          varcol:=WordApp.ActiveDocument.Tables.Item(3).rows.Item(3);
          WordApp.ActiveDocument.Tables.Item(3).rows.Add(varcol);
          end;

      ///// заполняем таблицу секторов репитора ///////////////
      for i:=1 to sectors_count do
        begin
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,1).Range.text:=query4.fieldbyname('num').AsString;
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,2).Range.text:=query4.fieldbyname('height').AsString;
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,3).Range.text:=query4.fieldbyname('antenna_type').AsString;
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,4).Range.text:=query4.fieldbyname('azimuth').AsString;
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,5).Range.text:=query4.fieldbyname('tm_slope').AsString;
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,6).Range.text:=query4.fieldbyname('te_slope').AsString;
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,7).Range.text:=query4.fieldbyname('cable_type').AsString;
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,8).Range.text:=query4.fieldbyname('cable_length').AsString;
        WordApp.ActiveDocument.Tables.Item(3).Cell(2+i,9).Range.text:=query4.fieldbyname('notes').AsString;

        query4.Next;
        end;
      tnum:=3;
      end;

    //////  Транспорт /////////////////////////////////////////////
    // лог
    TFilesEngine.AppendToFile('log.txt','заполнение транспорт: '+DateTimeToStr(Now));

    if ftype='bts' then
      begin
      sql:='SELECT';
      sql:=sql+' IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',bts2.bts_number,bts1.bts_number) as bts_number_2';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',height_point1,height_point2) as height_point1';
      sql:=sql+',fr_range';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',diam_point1,diam_point2) as diam_point1';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',azimuth_point1,azimuth_point2) as azimuth_point1';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',settlements2.type,settlements1.type) as type';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',settlements2.settlement,settlements1.settlement) as settlement';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',bts2.street_type,bts1.street_type) as street_type';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',bts2.street_name,bts1.street_name) as street_name';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',bts2.house_type,bts1.house_type) as house_type';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',bts2.house_number,bts1.house_number) as house_number';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',areas2.area,areas1.area) as area';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',regions2.region,regions1.region) as region';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',height_point2,height_point1) as height_point2';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',diam_point2,diam_point1) as diam_point2';
      sql:=sql+',IF(bts1.id='+query1.fieldbyname('bts_id').AsString+',azimuth_point2,azimuth_point1) as azimuth_point2';
      sql:=sql+',stream_total';
      sql:=sql+',stream_work';
      sql:=sql+',reserve';
      sql:=sql+',equipment';
      sql:=sql+' FROM rrl';
      sql:=sql+' LEFT JOIN bts bts1';
      sql:=sql+' ON rrl.bts_id_point1=bts1.id';
      sql:=sql+' LEFT JOIN settlements settlements1';
      sql:=sql+' ON bts1.settlement_id=settlements1.id';
      sql:=sql+' LEFT JOIN areas areas1';
      sql:=sql+' ON settlements1.area_id=areas1.id';
      sql:=sql+' LEFT JOIN regions regions1';
      sql:=sql+' ON areas1.region_id=regions1.id';
      sql:=sql+' LEFT JOIN bts bts2';
      sql:=sql+' ON rrl.bts_id_point2=bts2.id';
      sql:=sql+' LEFT JOIN settlements settlements2';
      sql:=sql+' ON bts2.settlement_id=settlements2.id';
      sql:=sql+' LEFT JOIN areas areas2';
      sql:=sql+' ON settlements2.area_id=areas2.id';
      sql:=sql+' LEFT JOIN regions regions2';
      sql:=sql+' ON areas2.region_id=regions2.id';
      sql:=sql+' WHERE bts_id_point1="'+query1.fieldbyname('bts_id').AsString+'" OR bts_id_point2="'+query1.fieldbyname('bts_id').AsString+'"';
      sql:=sql+' ORDER BY bts_number_2';

      query4.Close;
      query4.SQL.Clear;
      query4.SQL.Add(sql);
      query4.Open;
      query4.Last;
      query4.First;

      /////      добовляем строки в таблицу rrl ////////////////////////
      ad_row_count:=0;
      if (query4.RecordCount>2) then
        for i:=1 to query4.RecordCount-2 do
          begin
          varcol:=WordApp.ActiveDocument.Tables.Item(tnum).rows.Item(3);
          WordApp.ActiveDocument.Tables.Item(tnum).rows.Add(varcol);
          varcol:=WordApp.ActiveDocument.Tables.Item(tnum).rows.Item(6+i);
          WordApp.ActiveDocument.Tables.Item(tnum).rows.Add(varcol);
          inc(ad_row_count);
          end;

      //////      заполняем таблицу RRL   /////////////////////////////////
      switch:='';
      query4.First;
      for i:=1 to query4.RecordCount do
        begin
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(2+i,1).Range.text:='БС'+query3.fieldbyname('bts_number').AsString+' - БС'+query4.fieldbyname('bts_number_2').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(2+i,2).Range.text:=query4.fieldbyname('height_point1').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(2+i,3).Range.text:=query4.fieldbyname('fr_range').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(2+i,4).Range.text:=query4.fieldbyname('diam_point1').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(2+i,5).Range.text:=query4.fieldbyname('azimuth_point1').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(2+i,6).Range.text:=query4.fieldbyname('stream_total').AsString+' ('+query4.fieldbyname('reserve').AsString+')';

        WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i+ad_row_count,1).Range.text:='БС'+query4.fieldbyname('bts_number_2').AsString+' '+FormatAddress(query4.fieldbyname('type').AsString,query4.fieldbyname('settlement').AsString,query4.fieldbyname('street_type').AsString,query4.fieldbyname('street_name').AsString,query4.fieldbyname('house_type').AsString,query4.fieldbyname('house_number').AsString,query4.fieldbyname('area').AsString,'');
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i+ad_row_count,2).Range.text:=query4.fieldbyname('height_point2').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i+ad_row_count,3).Range.text:=query4.fieldbyname('fr_range').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i+ad_row_count,4).Range.text:=query4.fieldbyname('diam_point2').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i+ad_row_count,5).Range.text:=query4.fieldbyname('azimuth_point2').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i+ad_row_count,6).Range.text:=query4.fieldbyname('stream_total').AsString+' ('+query4.fieldbyname('reserve').AsString+')';

        if query4.fieldbyname('stream_total').AsString<>query4.fieldbyname('stream_work').AsString then
          switch:=switch+'РРЛ БС'+query3.fieldbyname('bts_number').AsString+' - БС'+query4.fieldbyname('bts_number_2').AsString+' включить по схеме '+query4.fieldbyname('stream_work').AsString+#10;

        // выделение
        c:=0;
        c1:=0;
        query5.First;
        if new_build<>1 then
        for j:=1 to query5.RecordCount do
          begin
          if query5.fieldbyname('action').AsString='delete' then   //проверяем, была ли удалена такая же
            begin
            if    (pos(query4.fieldbyname('bts_number_2').AsString,query5.fieldbyname('changes').AsString)>0)
              and (pos(query4.fieldbyname('stream_total').AsString,query5.fieldbyname('changes').AsString)>0)
              and (pos(query4.fieldbyname('equipment').AsString,query5.fieldbyname('changes').AsString)>0)
              then begin
              c1:=1;
              end;
            end;

          if (query5.fieldbyname('action').AsString<>'delete') and (c1=0) then
            begin
            if    (pos(query4.fieldbyname('stream_total').AsString,query5.fieldbyname('changes').AsString)>0)
              and (pos(query4.fieldbyname('bts_number_2').AsString,query5.fieldbyname('changes').AsString)>0)
              and (pos(query3.fieldbyname('bts_number').AsString,query5.fieldbyname('changes').AsString)>0)
              and (pos(query4.fieldbyname('equipment').AsString,query5.fieldbyname('changes').AsString)>0)
              then begin
              c:=1;
              end;
            end;
          query5.Next;
          end;

        if c=1 then
          begin
          for j:=1 to 6 do
            begin
            WordApp.ActiveDocument.Tables.Item(tnum).Cell(2+i,j).Range.font.bold:=wdToggle;
            WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i+ad_row_count,j).Range.font.bold:=wdToggle;
            end;
          end;

        query4.Next;
        end;

      cable_transport:='';
      if not empty(query3.fieldbyname('focl_2g').AsString) then
        cable_transport:=cable_transport+'2G привязывается по ВОЛС'+#10;
      if not empty(query3.fieldbyname('focl_3g').AsString) then
        cable_transport:=cable_transport+'3G привязывается по ВОЛС'+#10;

      if not empty(query3.fieldbyname('notes').AsString) then notes:=query3.fieldbyname('notes').AsString;

      if i=0 then ad_row_count:=ad_row_count+2;
      if i<3 then ad_row_count:=ad_row_count+1;
      WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i+ad_row_count,1).Range.text:=switch+cable_transport+notes;
      inc(tnum);
      end;

    //////  привязка репитера  /////////////////////////////////////////////
    if ftype='repeater' then
      begin
      sql:='SELECT';
      sql:=sql+' repeater_number';
      sql:=sql+',bts_number';
      sql:=sql+',height';
      sql:=sql+',antenna_type';
      sql:=sql+',cable_type';
      sql:=sql+',azimuth';
      sql:=sql+',repeater_sectors.notes';
      sql:=sql+',link_type';
      sql:=sql+',divider_type';
      sql:=sql+',incut_place';
      sql:=sql+' FROM repeaters';
      sql:=sql+' LEFT JOIN bts';
      sql:=sql+' ON repeaters.link_bts_id=bts.id';
      sql:=sql+' LEFT JOIN repeater_sectors';
      sql:=sql+' ON repeater_sectors.repeater_link_id=repeaters.id AND num=0';
      sql:=sql+' LEFT JOIN antenna_types';
      sql:=sql+' ON repeater_sectors.antenna_type_id=antenna_types.id';
      sql:=sql+' WHERE repeaters.id="'+query1.fieldbyname('repeater_id').AsString+'"';

      query4.Close;
      query4.SQL.Clear;
      query4.SQL.Add(sql);
      query4.Open;
      query4.Last;
      query4.First;

      if length(query4.fieldbyname('bts_number').AsString)>0 then
        tx:='Р'+query4.fieldbyname('repeater_number').AsString+' '+#62+' '+'БС'+query4.fieldbyname('bts_number').AsString
      else tx:='';
      Word_StringReplace('{link}',tx,[wrfReplaceAll]);

      tx:=query4.fieldbyname('height').AsString;
      if length(tx)>0 then
        begin
        Word_StringReplace('{высота подв.}','высота подв.',[wrfReplaceAll]);
        Word_StringReplace('{height}',tx,[wrfReplaceAll]);
        end;
      tx:=query4.fieldbyname('antenna_type').AsString;
      if length(tx)>0 then
        begin
        Word_StringReplace('{тип антенны}','тип антенны',[wrfReplaceAll]);
        Word_StringReplace('{ant_type}',tx,[wrfReplaceAll]);
        end;
      Word_StringReplace('{cable}',query4.fieldbyname('cable_type').AsString,[wrfReplaceAll]);

      tx:=query4.fieldbyname('azimuth').AsString;
      if length(tx)>0 then
        begin
        Word_StringReplace('{азим}','азимут',[wrfReplaceAll]);
        Word_StringReplace('{azim}',tx,[wrfReplaceAll]);
        end
        else if length(query4.fieldbyname('incut_place').AsString)=0 then
        begin
        Word_StringReplace('{азим}','азимут',[wrfReplaceAll]);
        Word_StringReplace('{azim}','',[wrfReplaceAll]);
        end;

      Word_StringReplace('{note}',query4.fieldbyname('notes').AsString,[wrfReplaceAll]);

      tx:=query4.fieldbyname('link_type').AsString;
      if length(tx)>0 then
        begin
        Word_StringReplace('{высота подв.}','тип привязки',[wrfReplaceAll]);
        Word_StringReplace('{height}',tx,[wrfReplaceAll]);
        end;
      tx:=query4.fieldbyname('divider_type').AsString;
      if length(tx)>0 then
        begin
        Word_StringReplace('{тип антенны}','тип делителя',[wrfReplaceAll]);
        Word_StringReplace('{ant_type}',tx,[wrfReplaceAll]);
        end;
      tx:=query4.fieldbyname('incut_place').AsString;
      if length(tx)>0 then
        begin
        Word_StringReplace('{азим}','место врезки',[wrfReplaceAll]);
        Word_StringReplace('{azim}',tx,[wrfReplaceAll]);
        end;
      end;

    /////////////   модель, конф, питание БС/////////////////////////
    // лог
    TFilesEngine.AppendToFile('log.txt','модель, конф, питание: '+DateTimeToStr(Now));

    if ftype='bts' then
      begin
      Word_StringReplace('{model_type_2g}',query3.fieldbyname('model_type_2g').AsString,[wrfReplaceAll]);

      if query3.fieldbyname('plan_gsm').AsString<>'' then gsm:='900('+query3.fieldbyname('plan_gsm').AsString+')' else gsm:='';
      Word_StringReplace('{gsm}',gsm,[wrfReplaceAll]);

      if query3.fieldbyname('plan_dcs').AsString<>'' then dcs:='1800('+query3.fieldbyname('plan_dcs').AsString+')' else dcs:='';
      Word_StringReplace('{dcs}',dcs,[wrfReplaceAll]);

      if query3.fieldbyname('cupboard_2g_count').AsString<>'' then cupboard_2g:='('+query3.fieldbyname('cupboard_2g_count').AsString+')';
      Word_StringReplace('{cupboard_2g}',cupboard_2g,[wrfReplaceAll]);
      Word_StringReplace('{model_type_3g}',query3.fieldbyname('model_type_3g').AsString,[wrfReplaceAll]);
      Word_StringReplace('{model_type_4g}',query3.fieldbyname('model_type_4g').AsString,[wrfReplaceAll]);

      if query3.fieldbyname('plan_umts').AsString<>'' then umts:='2100('+query3.fieldbyname('plan_umts').AsString+')' else umts:='';
      Word_StringReplace('{umts}',umts,[wrfReplaceAll]);

      if query3.fieldbyname('plan_umts9').AsString<>'' then umts9:='900('+query3.fieldbyname('plan_umts9').AsString+')' else umts9:='';
      Word_StringReplace('{umts9}',umts9,[wrfReplaceAll]);

      if query3.fieldbyname('plan_lte').AsString<>'' then lte:='2100('+query3.fieldbyname('plan_lte').AsString+')' else lte:='';
      Word_StringReplace('{lte}',lte,[wrfReplaceAll]);

      if query3.fieldbyname('cupboard_3g_count').AsString<>'' then cupboard_3g:='('+query3.fieldbyname('cupboard_3g_count').AsString+')';
      Word_StringReplace('{cupboard_3g}',cupboard_3g,[wrfReplaceAll]);

      if query3.fieldbyname('cupboard_4g_count').AsString<>'' then cupboard_4g:='('+query3.fieldbyname('cupboard_4g_count').AsString+')';
      Word_StringReplace('{cupboard_4g}',cupboard_4g,[wrfReplaceAll]);


      if pos('АРМ 30',query3.fieldbyname('power_type').AsString)>0 then pw:='ЩУНИ' else pw:='РЩ-1';
      Word_StringReplace('{PW}',pw,[wrfReplaceAll]);
      Word_StringReplace('{power_type}',query3.fieldbyname('power_type').AsString,[wrfReplaceAll]);
      p_cupboard:='+ '+query3.fieldbyname('battery_capacity').AsString;
      if query3.fieldbyname('battery_capacity').AsString='92' then p_cupboard:=p_cupboard+' x2' else p_cupboard:=p_cupboard+' x2';
      if query3.fieldbyname('power_cupboard_count').AsString<>'' then p_cupboard:=p_cupboard+' ('+query3.fieldbyname('power_cupboard_count').AsString+')' else p_cupboard:='';
      Word_StringReplace('{p_cupboard}',p_cupboard,[wrfReplaceAll]);

      dolg:=query3.fieldbyname('longitudel_d').AsString;
      i:=pos(' ',dolg);
      tx:=copy(dolg,1,i-1)+#176+' ';
      dolg:=copy(dolg,i+1,length(dolg));
      i:=pos(' ',dolg);
      tx:=tx+copy(dolg,1,i-1)+#39+' ';
      dolg:=copy(dolg,i+1,length(dolg)-1);
      tx:=tx+dolg+#39+#39+' ВД';
      Word_StringReplace('{l_d}',tx,[wrfReplaceAll]);

      shir:=query3.fieldbyname('longitudel_s').AsString;
      i:=pos(' ',shir);
      tx:=copy(shir,1,i-1)+#176+' ';
      shir:=copy(shir,i+1,length(shir));
      i:=pos(' ',shir);
      tx:=tx+copy(shir,1,i-1)+#39+' ';
      shir:=copy(shir,i+1,length(shir)-1);
      tx:=tx+shir+#39+#39+' СШ';
      Word_StringReplace('{l_s}',tx,[wrfReplaceAll]);
      ///////////////////////////////////////////////////////////////

      //////////////  доп. оборудование /////////////////////////////
      sql:='SELECT * FROM hardware WHERE bts_id="'+query1.fieldbyname('bts_id').AsString+'"';
      query4.Close;
      query4.SQL.Clear;
      query4.SQL.Add(sql);
      query4.Open;
      query4.Last;
      query4.First;
      for i:=1 to query4.RecordCount do
        begin
        varcol:=WordApp.ActiveDocument.Tables.Item(tnum).rows.Item(6);
        WordApp.ActiveDocument.Tables.Item(tnum).rows.Add(varcol);
        end;
      query4.First;
      for i:=1 to query4.RecordCount do
        begin
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i,1).Range.text:=query4.fieldbyname('equipment').AsString;
        WordApp.ActiveDocument.Tables.Item(tnum).Cell(5+i,3).Range.text:='('+query4.fieldbyname('quantity').AsString+')';
        query4.Next;
        end;
      end;

    /////////////   модель, конф, питание репитора/////////////////////////
    if ftype='repeater' then
      begin
      Word_StringReplace('{repeater_type}',query3.fieldbyname('repeater_type').AsString,[wrfReplaceAll]);

      if query3.fieldbyname('gsm_config').AsString<>'' then gsm:=' '+query3.fieldbyname('gsm_config').AsString+'(GSM)' else gsm:='';
      if query3.fieldbyname('dcs_config').AsString<>'' then dcs:=' '+query3.fieldbyname('dcs_config').AsString+'(DCS)' else dcs:='';
      if query3.fieldbyname('umts_config').AsString<>'' then umts:=' '+query3.fieldbyname('umts_config').AsString+'(UMTS)' else umts:='';
      Word_StringReplace('{config}',gsm+dcs+umts,[wrfReplaceAll]);

      Word_StringReplace('{power_type}',query3.fieldbyname('power_type').AsString,[wrfReplaceAll]);

      dolg:=query3.fieldbyname('longitudel_d').AsString;
      i:=pos(' ',dolg);
      tx:=copy(dolg,1,i-1)+#176+' ';
      dolg:=copy(dolg,i+1,length(dolg));
      i:=pos(' ',dolg);
      tx:=tx+copy(dolg,1,i-1)+#39+' ';
      dolg:=copy(dolg,i+1,length(dolg)-1);
      tx:=tx+dolg+#39+#39+' ВД';
      Word_StringReplace('{l_d}',tx,[wrfReplaceAll]);

      shir:=query3.fieldbyname('longitudel_s').AsString;
      i:=pos(' ',shir);
      tx:=copy(shir,1,i-1)+#176+' ';
      shir:=copy(shir,i+1,length(shir));
      i:=pos(' ',shir);
      tx:=tx+copy(shir,1,i-1)+#39+' ';
      shir:=copy(shir,i+1,length(shir)-1);
      tx:=tx+shir+#39+#39+' СШ';
      Word_StringReplace('{l_s}',tx,[wrfReplaceAll]);
      end;

    /////////////  выделения //////////////////////////////////////
    for i:=0 to length(bolt_sec)-1 do
      begin
      if not empty(gsm) then Word_SearchSelect(gsm,bolt_sec[i]);
      end;
    for i:=0 to length(bolt_sec_3g)-1 do
      begin
      if not empty(umts) then Word_SearchSelect(umts,bolt_sec_3g[i]);
      end;
    for i:=0 to length(bolt_sec_dcs)-1 do
      begin
      if not empty(dcs) then Word_SearchSelect(dcs,bolt_sec_dcs[i]);
      end;
    for i:=0 to length(bolt_sec_3g9)-1 do
      begin
      if not empty(umts9) then Word_SearchSelect(umts9,bolt_sec_3g9[i]);
      end;
    for i:=0 to length(bolt_sec_4g)-1 do
      begin
      if not empty(lte) then Word_SearchSelect(lte,bolt_sec_4g[i]);
      end;

      query5.First;
      if (new_build<>1) and (ftype='bts') then
      for i:=1 to query5.RecordCount do
        begin
        if pos(query3.fieldbyname('model_type_3g').AsString,query5.fieldbyname('changes').AsString)>0 then Word_SearchSelect(query3.fieldbyname('model_type_3g').AsString,0);
        if pos('cupboard_3g_count',query5.fieldbyname('changes').AsString)>0 then WordApp.ActiveDocument.Tables.Item(tnum).Cell(5,5).Range.font.bold:=wdToggle;
        query5.Next;
        end;
    ///////////////////////////////////////////////////////////////////

    ///////////////  список согласования //////////////////////////////
    // лог
    TFilesEngine.AppendToFile('log.txt','список согласования: '+DateTimeToStr(Now));

    sql:='SELECT * FROM formular_actions,users WHERE formular_actions.user_id=users.id AND formular_id="'+formular_id+'" ORDER BY formular_actions.id';
    query5.Close;
    query5.SQL.Clear;
    query5.SQL.Add(sql);
    query5.Open;
    query5.Last;
    query5.First;
    accept_list:='';
    for i:=1 to query5.RecordCount do
      begin
      accept_list:=accept_list+query5.fieldbyname('action_date').AsString;
      accept_list:=accept_list+' '+query5.fieldbyname('department').AsString;
      accept_list:=accept_list+' '+query5.fieldbyname('surname').AsString+' '+query5.fieldbyname('name').AsString[1]+'.'+query5.fieldbyname('middle_name').AsString[1]+'.';
      if query5.fieldbyname('action').AsString='accept' then accept_list:=accept_list+' согласовано';
      if query5.fieldbyname('action').AsString='decline' then accept_list:=accept_list+' отклонено';
      if query5.fieldbyname('action').AsString='sign' then accept_list:=accept_list+' согласовано';
      if query5.fieldbyname('action').AsString='fixed' then accept_list:=accept_list+' исправлено';
      if query5.fieldbyname('action').AsString='skip' then accept_list:=accept_list+' пропущено';
      if query5.fieldbyname('notes').AsString<>'' then accept_list:=accept_list+': '+query5.fieldbyname('notes').AsString;
      accept_list:=accept_list+#13+#13;
      query5.Next;
      end;
    //j:=Word_SearchSelect('{accept_list}',0);
    //WordApp.Selection.InsertAfter(accept_list);
    Word_StringReplace('{accept_list}','',[wrfReplaceAll]);

    ////////////////////////////////////////////////////////////////////
    filenameOLE1:='y:\home\radiosystem\www\files\lotus_fud\'+formular_id+'.doc';
    try
      WordApp.ActiveDocument.SaveAs(filenameOLE1);
      // лог
      TFilesEngine.AppendToFile('log.txt','сохранение: '+filenameOLE1+' успешно');
    except
      // лог
      TFilesEngine.AppendToFile('log.txt','сохранение: '+filenameOLE1+' ошибка');
    end;

    if ftype='bts' then
      filenameOLE1:='\\store3\kam\Формуляры на БС\База SQL\ФПД\'+query3.fieldbyname('bts_number').asstring+'_'+formular_id+'.pdf';
    if ftype='repeater' then
      filenameOLE1:='\\store3\kam\Формуляры на БС\База SQL\ФПД\'+query3.fieldbyname('repeater_number').asstring+'_'+formular_id+'.pdf';

    try
      WordApp.ActiveDocument.SaveAs(filenameOLE1,17);
      // лог
      TFilesEngine.AppendToFile('log.txt','сохранение: '+filenameOLE1+' успешно');
    except
      // лог
      TFilesEngine.AppendToFile('log.txt','сохранение: '+filenameOLE1+' ошибка');
    end;
  finally
    WordApp.Quit;
    WordApp := Unassigned;
    MySQLEngine.Free;
    query1.Free;
    query2.Free;
    query3.Free;
    query4.Free;
    query5.Free;
    // лог
    TFilesEngine.AppendToFile('log.txt','завершение: '+DateTimeToStr(Now));
  end;
except
  ON E:Exception do TFilesEngine.AppendToFile('log.txt','ошибка: '+E.Message);
end;
end;

procedure TForm1.FormActivate(Sender: TObject);
var
s:string;
begin
// запуск с командной строки
s:=ParamStr(1);
if not empty(s) then
  begin
  edit1.Text:=s;
  button1.Click;
  button2.Click;
  end;
end;

end.
