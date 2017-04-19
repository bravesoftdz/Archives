unit Model;

interface

uses
   API_MVC
  ,API_DBases;

type
  TStatExport = class(TModelAbstract)
  private
    function OnOrDate(aValue: string): string;
    function HasOrDate(aValue: string): string;
  public
    procedure Excute; override;
  end;

implementation

uses
   Excel2010
  ,Variants
  ,Winapi.Windows
  ,System.SysUtils
  ,FireDAC.Comp.Client
  ,FireDAC.Stan.Param
  ,Data.DB
  ,alezzle;

function TStatExport.OnOrDate(aValue: string): string;
begin
  Result:='';
  if aValue.Length=10 then Result:=aValue
  else if not aValue.IsEmpty then Result:='вкл';
end;

function TStatExport.HasOrDate(aValue: string): string;
begin
  Result:='';
  if aValue.Length=10 then Result:=aValue
  else if not aValue.IsEmpty then Result:='есть';
end;

procedure TStatExport.Excute;
var
  MySQLEngine: TMySQLEngine;
  ExcelApplication: TExcelApplication;
  Sheet: TExcelWorksheet;
  LCID: Integer;
  sql: string;
  dsQuery: TFDQuery;
  i,row_num: Integer;
begin
  MySQLEngine:=FObjData.Items['MySQLEngine'] as TMySQLEngine;
  dsQuery:=TFDQuery.Create(nil);
  ExcelApplication:=TExcelApplication.Create(nil);
  Sheet:=TExcelWorksheet.Create(nil);
  try
    ExcelApplication.AutoConnect:=true;
    ExcelApplication.AutoQuit:=true;
    LCID := GetUserDefaultLCID;
    ExcelApplication.DisplayAlerts[LCID]:=False;
    ExcelApplication.Workbooks.Open(GetCurrentDir+'\Template\stat_template.xlsx'
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,EmptyParam
      ,LCID
    );
    Sheet.ConnectTo(ExcelApplication.ActiveWorkbook.ActiveSheet as ExcelWorkSheet);

    sql:='select *';
    sql:=sql+' from switchings s';
    sql:=sql+' join bts on bts.id=s.bts_id';
    sql:=sql+' join settlements stl on stl.id=bts.settlement_id';
    sql:=sql+' join areas ar on ar.id=stl.area_id';
    sql:=sql+' join regions r on r.id=ar.region_id';
    sql:=sql+' where site_type="БС"';
    sql:=sql+' order by bts_number';

    dsQuery.SQL.Text:=sql;
    MySQLEngine.OpenQuery(dsQuery);
    i:=0;
    row_num:=2;
    while not dsQuery.Eof do
      begin
        inc(i);
        inc(row_num);

        FEventData.AddOrSetValue('num',IntToStr(i));
        Self.GenerateEvent('UpdateLabel');

        Sheet.Cells.Item[row_num,1]:=i;
        Sheet.Cells.Item[row_num,2]:=dsQuery.FieldByName('bts_number').AsString;
        Sheet.Cells.Item[row_num,3]:=dsQuery.FieldByName('site_type').AsString;
        Sheet.Cells.Item[row_num,4]:=FormatAddress(
           dsQuery.FieldByName('type').AsString
          ,dsQuery.FieldByName('settlement').AsString
          ,dsQuery.FieldByName('street_type').AsString
          ,dsQuery.FieldByName('street_name').AsString
          ,dsQuery.FieldByName('house_type').AsString
          ,dsQuery.FieldByName('house_number').AsString
          ,dsQuery.FieldByName('area').AsString
          ,dsQuery.FieldByName('region').AsString
        );
        Sheet.Cells.Item[row_num,5]:=dsQuery.FieldByName('region').AsString;
        Sheet.Cells.Item[row_num,6]:=dsQuery.FieldByName('settlement').AsString;
        if not dsQuery.FieldByName('plan_gsm_config_id').IsNull then Sheet.Cells.Item[row_num,7]:='gsm';
        if not dsQuery.FieldByName('plan_dcs_config_id').IsNull then Sheet.Cells.Item[row_num,8]:='dcs';
        if not dsQuery.FieldByName('plan_umts_config_id').IsNull then Sheet.Cells.Item[row_num,9]:='umts';
        if not dsQuery.FieldByName('plan_umts9_config_id').IsNull then Sheet.Cells.Item[row_num,10]:='umts 900';
        if not dsQuery.FieldByName('plan_lte_config_id').IsNull then Sheet.Cells.Item[row_num,11]:='lte 1800';
        Sheet.Cells.Item[row_num,12]:=OnOrDate(dsQuery.FieldByName('gsm').AsString);
        Sheet.Cells.Item[row_num,13]:=OnOrDate(dsQuery.FieldByName('dcs').AsString);
        Sheet.Cells.Item[row_num,14]:=OnOrDate(dsQuery.FieldByName('umts2100').AsString);
        Sheet.Cells.Item[row_num,15]:=OnOrDate(dsQuery.FieldByName('umts900').AsString);
        Sheet.Cells.Item[row_num,16]:=OnOrDate(dsQuery.FieldByName('lte').AsString);
        Sheet.Cells.Item[row_num,18]:=HasOrDate(dsQuery.FieldByName('uninstall').AsString);
        Sheet.Cells.Item[row_num,23]:=HasOrDate(dsQuery.FieldByName('stat').AsString);
        Sheet.Cells.Item[row_num,24]:=HasOrDate(dsQuery.FieldByName('belgei_2g').AsString);
        Sheet.Cells.Item[row_num,25]:=HasOrDate(dsQuery.FieldByName('act_2g').AsString);
        Sheet.Cells.Item[row_num,26]:=HasOrDate(dsQuery.FieldByName('belgei_3g').AsString);
        Sheet.Cells.Item[row_num,27]:=HasOrDate(dsQuery.FieldByName('act_3g').AsString);
        Sheet.Cells.Item[row_num,28]:=HasOrDate(dsQuery.FieldByName('belgei_3g9').AsString);
        Sheet.Cells.Item[row_num,29]:=HasOrDate(dsQuery.FieldByName('act_3g9').AsString);
        dsQuery.Next;
      end;

    Sheet.SaveAs(GetCurrentDir+'\stat.xlsx');
  finally
    Sheet.Free;
    ExcelApplication.Disconnect;
    ExcelApplication.Free;
    dsQuery.Free;
  end;
end;

end.
