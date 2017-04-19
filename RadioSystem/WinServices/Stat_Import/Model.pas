unit Model;

interface

uses
   API_MVC
  ,API_DBases;

type
  TStatImport = class(TModelAbstract)
  private
    function CheckOnOrDate(CellValue: String; out aDate: TDate): Boolean;
    procedure InsertAction(aMySQLEngine: TMySQLEngine; aSwitchType, aBtsID: Integer; aActDate: TDate; aSwAct: string);
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
  ,API_RS;

procedure TStatImport.InsertAction(aMySQLEngine: TMySQLEngine; aSwitchType, aBtsID: Integer; aActDate: TDate; aSwAct: string);
var
  dsQuery: TFDQuery;
  sql: string;
begin
  try
    dsQuery:=TFDQuery.Create(nil);
    try
      // проверка на существование записи по БС
      sql:='select id from switchings where bts_id=:bts_id';
      dsQuery.SQL.Text:=sql;
      dsQuery.ParamByName('bts_id').AsInteger:=aBtsID;
      aMySQLEngine.OpenQuery(dsQuery);

      // если нет записи по включению БС - вставляем
      if dsQuery.Eof then
        begin
          sql:='insert into switchings set bts_id=:bts_id';
          dsQuery.SQL.Text:=sql;
          dsQuery.ParamByName('bts_id').AsInteger:=aBtsID;
          aMySQLEngine.ExecQuery(dsQuery);
        end;

      // обновляем поле категории
      sql:='update switchings set ';
      case aSwitchType of
        1: sql:=sql+'gsm=:value ';
        2: sql:=sql+'dcs=:value ';
        3: sql:=sql+'umts2100=:value ';
        4: sql:=sql+'uninstall=:value ';
        5: sql:=sql+'umts900=:value ';
        6: sql:=sql+'lte=:value ';
        7: sql:=sql+'stat=:value ';
        8: sql:=sql+'belgei_2g=:value ';
        9: sql:=sql+'belgei_3g=:value ';
        10: sql:=sql+'act_2g=:value ';
        11: sql:=sql+'act_3g=:value ';
        0: sql:=sql+'is_on=:value ';
      end;
      sql:=sql+'where bts_id=:bts_id';
      dsQuery.SQL.Text:=sql;
      if aActDate>0 then dsQuery.ParamByName('value').AsString:=FormatDateTime('yyyy-mm-dd',aActDate)
      else dsQuery.ParamByName('value').AsString:=aSwAct;
      dsQuery.ParamByName('bts_id').AsInteger:=aBtsID;
      aMySQLEngine.ExecQuery(dsQuery);
    finally
      dsQuery.Free;
    end;
  except

  end;
end;

function TStatImport.CheckOnOrDate(CellValue: string; out aDate: TDate): Boolean;
begin
  Result:=False;
  aDate:=StrToDateDef(CellValue,0);
  if aDate>0 then
    begin
      Result:=True;
      Exit;
    end;
  aDate:=0;
  if Length(CellValue)>0 then Result:=True;
end;

procedure TStatImport.Excute;
var
  ExcelApplication: TExcelApplication;
  Sheet: TExcelWorksheet;
  MySQLEngine: TMySQLEngine;
  LCID: Integer;
  i: Integer;
  bts_id: Integer;
  sql: string;
  ActDate: TDate;
  IsTrashOn, IsTrashOff: Boolean;
  is2g,is3g,is4g,isUninst: Boolean;
begin
  MySQLEngine:=FObjData.Items['MySQLEngine'] as TMySQLEngine;
  ExcelApplication:=TExcelApplication.Create(nil);
  Sheet:=TExcelWorksheet.Create(nil);
  try
    ExcelApplication.AutoConnect:=true;
    ExcelApplication.AutoQuit:=true;
    LCID := GetUserDefaultLCID;
    ExcelApplication.Workbooks.Open(GetCurrentDir+'\stat.xlsx'
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
    IsTrashOn:=False;
    IsTrashOff:=False;
    for i := 3 to 4000 do
      begin
        is2g:=False;
        is3g:=False;
        is4g:=False;
        isUninst:=False;
        FEventData.AddOrSetValue('num',IntToStr(i));
        Self.GenerateEvent('UpdateLabel');
        bts_id:=TRSApi.GetBtsIdByNumber(Sheet.Cells.Item[i,2],MySQLEngine);
        if bts_id>0 then
          begin
            // gsm
            if Self.CheckOnOrDate(Sheet.Cells.Item[i,12],ActDate) then
              begin
                InsertAction(MySQLEngine,1,bts_id,ActDate,'on');
                is2g:=True;
              end;
            // dcs
            if Self.CheckOnOrDate(Sheet.Cells.Item[i,13],ActDate) then
              begin
                InsertAction(MySQLEngine,2,bts_id,ActDate,'on');
                is2g:=True;
              end;
            // UMTS 2100
            if Self.CheckOnOrDate(Sheet.Cells.Item[i,14],ActDate) then
              begin
                InsertAction(MySQLEngine,3,bts_id,ActDate,'on');
                is3g:=True;
              end;
            // UMTS 900
            if Self.CheckOnOrDate(Sheet.Cells.Item[i,15],ActDate) then
              begin
                InsertAction(MySQLEngine,5,bts_id,ActDate,'on');
                is3g:=True;
              end;
            // LTE 1800
            if Self.CheckOnOrDate(Sheet.Cells.Item[i,16],ActDate) then
              begin
                InsertAction(MySQLEngine,6,bts_id,ActDate,'on');
                is4g:=True;
              end;

            //Демонтаж
            if Self.CheckOnOrDate(Sheet.Cells.Item[i,18],ActDate) then
              begin
                InsertAction(MySQLEngine,4,bts_id,ActDate,'got');
                isUninst:=True;
              end;

            if Sheet.Cells.Item[i,1].text='Планируемые к включению БС' then IsTrashOn:=True;
            if Sheet.Cells.Item[i,1].text='Планируемые к выключению БС' then IsTrashOff:=True;

            if IsTrashOn then
              begin
                //Статистика
                if Self.CheckOnOrDate(Sheet.Cells.Item[i,23],ActDate) then
                  InsertAction(MySQLEngine,7,bts_id,ActDate,'got');
                //Разрешение БелГИЭ 2G
                if Self.CheckOnOrDate(Sheet.Cells.Item[i,24],ActDate) then
                  InsertAction(MySQLEngine,8,bts_id,ActDate,'got');
                //Разрешение БелГИЭ 3G
                if Self.CheckOnOrDate(Sheet.Cells.Item[i,26],ActDate) then
                  InsertAction(MySQLEngine,9,bts_id,ActDate,'got');
                //Акт ввода в эксплуатацию 2G
                if Self.CheckOnOrDate(Sheet.Cells.Item[i,25],ActDate) then
                  InsertAction(MySQLEngine,10,bts_id,ActDate,'got');
                //Акт ввода в эксплуатацию 3G
                if Self.CheckOnOrDate(Sheet.Cells.Item[i,27],ActDate) then
                  InsertAction(MySQLEngine,11,bts_id,ActDate,'got');
              end
            else
            if not IsTrashOn or IsTrashOff then
              begin
                //Статистика
                if is2g or is3g or is4g then
                  begin
                    Self.CheckOnOrDate(Sheet.Cells.Item[i,23],ActDate);
                    InsertAction(MySQLEngine,7,bts_id,ActDate,'got');
                  end;

                //Разрешение БелГИЭ 2G
                if is2g then
                  begin
                    Self.CheckOnOrDate(Sheet.Cells.Item[i,24],ActDate);
                    InsertAction(MySQLEngine,8,bts_id,ActDate,'got');
                  end;

                //Разрешение БелГИЭ 3G
                if is3g then
                  begin
                    Self.CheckOnOrDate(Sheet.Cells.Item[i,26],ActDate);
                    InsertAction(MySQLEngine,9,bts_id,ActDate,'got');
                  end;

                //Акт ввода в эксплуатацию 2G
                if is2g then
                  begin
                    Self.CheckOnOrDate(Sheet.Cells.Item[i,25],ActDate);
                    InsertAction(MySQLEngine,10,bts_id,ActDate,'got');
                  end;

                //Акт ввода в эксплуатацию 3G
                if is3g then
                  begin
                    Self.CheckOnOrDate(Sheet.Cells.Item[i,27],ActDate);
                    InsertAction(MySQLEngine,11,bts_id,ActDate,'got');
                  end;

                //Отметка о включении
                if not isUninst then InsertAction(MySQLEngine,0,bts_id,0,'1');
              end;
          end;
      end;

  finally
    Sheet.Free;
    ExcelApplication.Disconnect;
    ExcelApplication.Free;
  end;

end;

end.
