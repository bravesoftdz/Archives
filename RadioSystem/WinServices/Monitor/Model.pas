unit Model;

interface

uses
   System.SysUtils
  ,System.JSON
  ,System.Classes
  ,SimpleDS
  ,Data.SqlExpr
  ,Data.DBXMySQL
  ,Data.DB
  ,Data.DBXCommon
  ,FireDAC.Comp.Client
  ,FireDAC.Phys.ODBC
  ,FireDAC.Stan.Def
  ,FireDAC.Stan.Async
  ,FireDAC.DApt
  ,FireDAC.Comp.UI
  ,FireDAC.ConsoleUI.Wait
  ,FireDAC.Phys.Intf
  ,API_Files;

type
  ArrayOfVariant = Array Of Variant;

  TArrayFuncs = class
  public
    class function InArray(Source: ArrayOfVariant; SearchElem: Variant):Boolean;
  end;

  TMySQLEngine = class
  private
    FSQLConnection: TSQLConnection;
  public
    procedure OpenConnection;
    procedure CloseConnection;
    procedure GetData(DataSet: TSimpleDataSet; sql: String);
    procedure SetData(sql: String);
    class function StrToSQL(value: string): string;
  end;

  TExcelEngine = class
  private
    FDConnection: TFDConnection;
  public
    procedure OpenConnection(FileName: String);
    procedure CloseConnection;
    procedure GetData(DataSet: TFDQuery; sql: String);
    procedure GetTables(Tables: TStringList);
  end;

  TStatEvent = procedure(Sender: TObject; EventData: TJSONObject) of object;

  TStatEngine = class abstract
  private
    Fmysql: TMySQLEngine;
    FSettingData: TJSONObject;
    FCurrFile: string;
    FCurrSheet: string;
    FRecordsCount: Integer;
    FRecordNum: Integer;
    FStatInfoUpdated: TStatEvent;
    FEventData: TJSONObject;
    function GetLastDate(TableName: String): TDateTime;
    function GetFileDataDate(FileName, FilePath: String): TDateTime;
    function CheckDoubleAndEmpty(Row, RuleFields: TJSONObject): Boolean;
    procedure ChooseFilesToImport(Files: TJSONObject; LastDate: TDateTime);
    procedure GetStatData(FileJS: TJSONPair; jsnImportRules, DataJSON: TJSONObject);
    procedure ImportStatData(ImportRules, DataJSON: TJSONObject);
    function CustomRecalc(Row, RuleFields: TJSONObject): Boolean; virtual; abstract;
    procedure InsertData(Row, RuleFields: TJSONObject);
    procedure GenerateEvent(EventCode: String; EventMsg: string = '');
    procedure StatExcute(SettingFile: String);
  public
    IsTerminated: Boolean;
    constructor Create;
    destructor Destroy;
    class function GetSettings(SettingFile: String): TJSONObject;
    procedure Excute(SettingFile: String); virtual; abstract;
    property RecordsCount: Integer read FRecordsCount;
    property RecordNum: Integer read FRecordNum;
    property StatInfoUpdated: TStatEvent read FStatInfoUpdated write FStatInfoUpdated;
    property EventData: TJSONObject read FEventData;
    //procedure считать настройки
    //procedure записать настройки
  end;

  TStatAbis = class(TStatEngine)
  private
    function CustomRecalc(Row, RuleFields: TJSONObject): Boolean; override;
  private
    procedure Excute(SettingFile: String); override;
  end;

  TStatTRAU = class(TStatEngine)
  private
    function CustomRecalc(Row, RuleFields: TJSONObject): Boolean; override;
  private
    procedure Excute(SettingFile: String); override;
  end;

  TStatCEHW = class(TStatEngine)
  private
    function CustomRecalc(Row, RuleFields: TJSONObject): Boolean; override;
  private
    procedure Excute(SettingFile: String); override;
  end;

  TProcEngine = class(TStatEngine)
  private
    procedure CustomProc; virtual; abstract;
    procedure ProcExcute(SettingFile: String);
  public
    procedure Excute(SettingFile: String); override;
  end;

  TProcDelFiles = class(TProcEngine)
  private
    procedure CustomProc; override;
  end;

implementation

uses
  API_RS;

procedure TProcDelFiles.CustomProc;
var
  jsnFiles: TJSONObject;
  jsnPair: TJSONPair;
  i: Integer;
  Threshold: Integer;
  tx: string;
begin
    jsnFiles:=TJSONObject.Create;
    try
      // получить список файлов
      with TFilesEngine.Create do
      try
        GetFileNamesByMask(FSettingData.GetValue('SearchPath').Value, FSettingData.GetValue('FileMask').Value, jsnFiles);
      finally
        Free;
      end;

      // выбрать список файлов к обработке, отсортировать по дате
      Self.ChooseFilesToImport(jsnFiles, 0);
      tx:=jsnFiles.ToString;

      // если нет файлов к обработке
      if jsnFiles.Count=0 then Self.GenerateEvent('NoFilesToProcess');

      // перебрать список открывать каждый файл
      i:=0;
      Threshold:=jsnFiles.Count-TJSONNumber(FSettingData.GetValue('MaxFilesCountInFolder')).AsInt;
      FRecordsCount:=Threshold;
      Self.GenerateEvent('ProcRange');

      for jsnPair in jsnFiles do
        begin
          if IsTerminated then Exit;

          Inc(i);
          if i<=Threshold then
            begin
              FRecordNum:=i;
              Self.GenerateEvent('ProcStep');
              tx:=jsnPair.ToString;
              DeleteFile(jsnPair.JsonString.Value+jsnPair.JsonValue.Value);
            end;
        end;
    finally
      jsnFiles.Free;
    end;
end;

procedure TProcEngine.ProcExcute(SettingFile: string);
begin
  FEventData:=TJSONObject.Create;
  Self.GenerateEvent('Begin');
  try
    // считать настройки
    FSettingData:=Self.GetSettings(SettingFile);

    // переопределямая процедура процесса
    Self.CustomProc;

  finally
    Self.GenerateEvent('End');
    FEventData.Free;
    if Assigned(FSettingData) then FSettingData.Free;
  end;
end;

procedure TProcEngine.Excute(SettingFile: string);
begin
  ProcExcute(SettingFile);
end;

procedure TStatAbis.Excute(SettingFile: string);
begin
  Self.StatExcute(SettingFile);
end;

procedure TStatTRAU.Excute(SettingFile: string);
begin
  Self.StatExcute(SettingFile);
end;

procedure TStatCEHW.Excute(SettingFile: string);
begin
  Self.StatExcute(SettingFile);
end;

class function TArrayFuncs.InArray(Source: ArrayOfVariant; SearchElem: Variant):Boolean;
var
  i: Integer;
begin
  result:=False;
  for i := 0 to Length(Source)-1 do
    if Source[i]=SearchElem then
      begin
        result:=True;
        Break;
      end;
end;

procedure TMySQLEngine.OpenConnection;
begin
  with TStringList.Create do
  try
    LoadFromFile('Settings/MySQL.ini');
    FSQLConnection:=TSQLConnection.Create(nil);
    FSQLConnection.DriverName:='MySQL';
    FSQLConnection.Params.Values['Host']:=Values['host'];
    FSQLConnection.Params.Values['Database']:=Values['Database'];
    FSQLConnection.Params.Values['User_Name']:=Values['User'];
    FSQLConnection.Params.Values['Password']:=Values['Pas'];
    FSQLConnection.LoginPrompt:=False;
    FSQLConnection.Connected:=True;
  finally
    Free;
  end;
end;

procedure TMySQLEngine.CloseConnection;
begin
  FSQLConnection.CloseDataSets;
  FSQLConnection.Connected:=False;
  FSQLConnection.Free;
end;

procedure TMySQLEngine.GetData(DataSet: TSimpleDataSet; sql: String);
begin
  DataSet.Connection:=Self.FSQLConnection;
  DataSet.DataSet.CommandText:=sql;
  DataSet.Open;
end;

procedure TMySQLEngine.SetData(sql: string);
var
  DataSet: TSimpleDataSet;
begin
  DataSet:=TSimpleDataSet.Create(nil);
  try
    DataSet.Connection:=Self.FSQLConnection;
    DataSet.DataSet.CommandText:=sql;
    DataSet.Execute;
  finally
    DataSet.Free;
  end;
end;

class function TMySQLEngine.StrToSQL(Value: string): string;
var
  tpFloat: Extended;
begin
  if StrToDateDef(Value,0)>0 then         // дата
    begin
      while Pos('.',Value) > 0 do
      Value[Pos('.', Value)] := ' ';
      result:=quotedstr(copy(Value,7,4)+copy(Value,4,2)+copy(Value,1,2));
      Exit;
    end;
  if TryStrToFloat(Value, tpFloat) then   // число
    begin
      if Pos(',',Value)>0 then
        Value:=StringReplace(Value, ',', '.', [rfReplaceAll, rfIgnoreCase]);
      result:=Value;
      Exit;
    end
  else                                    // строка
    begin
      Value:=Trim(Value);
      if Length(Value)=0 then Value:='NULL' else Value:=QuotedStr(Value);
      result:=Value;
    end;
end;

procedure TExcelEngine.OpenConnection(FileName: string);
begin
  FDConnection:=TFDConnection.Create(nil);
  FDConnection.Params.Values['Database']:=FileName;
  FDConnection.Params.Values['ODBCDriver']:='{Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)}';
  FDConnection.Params.Values['DataSource']:='Excel Files';
  FDConnection.Params.Values['DriverID']:='ODBC';
  FDConnection.LoginPrompt:=False;
  FDConnection.Connected:=True;
end;

procedure TExcelEngine.CloseConnection;
begin
  FDConnection.Connected:=False;
  FDConnection.Free;
end;

procedure TExcelEngine.GetData(DataSet: TFDQuery; sql: string);
begin
  DataSet.Connection:=Self.FDConnection;
  DataSet.SQL.Text:=sql;
  DataSet.Open;
end;

procedure TExcelEngine.GetTables(Tables: TStringList);
var
  i: Integer;
  tx: String;
  UnCleanTables: TStringList;
begin
  UnCleanTables:=TStringList.Create;
  try
    FDConnection.GetTableNames('','','',UnCleanTables,[osMy, osSystem],[tkTable],False);
    for i:=0 to UnCleanTables.Count-1 do
      begin
        tx:=UnCleanTables.Strings[i];
        if Pos('#',tx)=0
        then
          begin
            tx:=StringReplace(tx,'`','',[rfReplaceAll, rfIgnoreCase]);
            tx:=StringReplace(tx,'"','',[rfReplaceAll, rfIgnoreCase]);
            Tables.Add(tx);
          end;
      end;
  finally
    UnCleanTables.Free;
  end;
end;

constructor TStatEngine.Create;
begin
  Fmysql:=TMySQLEngine.Create;
  Fmysql.OpenConnection;
end;

destructor TStatEngine.Destroy;
begin
  Fmysql.CloseConnection;
  Fmysql.Free;
end;

function TStatEngine.CheckDoubleAndEmpty(Row, RuleFields: TJSONObject): Boolean;
var
  sql: string;
  DSet: TSimpleDataSet;
  KeyFields: TJSONArray;
  i, ColNum: Integer;
  IsEmptyRow: Boolean;
begin
  result:=False;

  sql:='SELECT Id FROM '+FSettingData.GetValue('TableName').Value+' WHERE';
  KeyFields:=TJSONArray(FSettingData.GetValue('KeyFields'));
  IsEmptyRow:=False;
  for i := 0 to KeyFields.Count-1 do
    begin
      ColNum:=StrToIntDef(RuleFields.GetValue(KeyFields.Items[i].Value).Value,0)-1;
      if ColNum > -1 then
        begin
          if Row.Pairs[ColNum].JsonValue=nil then
            IsEmptyRow:=True
          else
            begin
              if i>0 then sql:=sql + ' and ';
              sql:=sql + ' '+KeyFields.Items[i].Value+'='+TMySQLEngine.StrToSQL(Row.Pairs[ColNum].JsonValue.Value);
            end;
        end;
    end;

  if not IsEmptyRow then
    begin
      DSet:=TSimpleDataSet.Create(nil);
      with DSet do
      try
        Fmysql.GetData(DSet,sql);
        if DSet.Eof then Result := True;
      finally
        Free;
      end;
    end;
end;

procedure TStatEngine.ImportStatData(ImportRules: TJSONObject; DataJSON: TJSONObject);
var
  SheetsNum, RowNum: Integer;
  Rows: TJSONArray;
  Row, RuleFields: TJSONObject;
begin
  for SheetsNum := 0 to DataJSON.Count-1 do
    begin
      Rows:=TJSONArray(DataJSON.Pairs[SheetsNum].JsonValue);

      // получаем правила по листу
      FCurrSheet:=DataJSON.Pairs[SheetsNum].JsonString.Value;
      RuleFields:=TJSONObject(ImportRules.GetValue(FCurrSheet));

      FRecordsCount:=Rows.Count;
      Self.GenerateEvent('ImportSheet');
      for RowNum := 0 to FRecordsCount-1 do
        begin
          if IsTerminated then Exit;

          FRecordNum:=RowNum+1;
          Self.GenerateEvent('ImportRow');
          Row:=TJSONObject(Rows.Items[RowNum]);
          try
            // собственная обработка в каждом типе статистики - переопределяется потомком
            if Self.CustomRecalc(Row, RuleFields) then
              // проверка на дубли и пустое значение
              if Self.CheckDoubleAndEmpty(Row, RuleFields) then
                begin
                  // инсерт
                  Self.InsertData(Row, RuleFields);
                end;
          except
          On E : Exception do
            begin
              Raise Exception.CreateFmt('Лист %s, итерация %s. %s', [FCurrSheet,IntToStr(RowNum),E.Message]);
            end;
          end;
        end;
    end;
end;

procedure TStatEngine.GetStatData(FileJS: TJSONPair; jsnImportRules, DataJSON: TJSONObject);
var
  ExcelEngine: TExcelEngine;
  DSet: TFDQuery;
  sql: string;
  Tables: TStringList;
  i,j, FieldNum: Integer;
  tpFloat: Extended;
  Rows: TJSONArray;
  Row: TJSONObject;
  Cell: TJSONPair;
  NumValue: TJSONNumber;
  isValidSheet: Boolean;
  ProcessedCount: Integer;
  ErrorText: string;
begin
  ExcelEngine:=TExcelEngine.Create;
  Tables:=TStringList.Create;
  ProcessedCount:=0;
  try
    ExcelEngine.OpenConnection(FileJS.JsonString.Value+FileJS.JsonValue.Value);
    ExcelEngine.GetTables(Tables);
    for i:=0 to Tables.Count-1 do
      begin
        // ищем лист в настройках статистики, если нет - след. итерация
        isValidSheet:=False;
        for j := 0 to jsnImportRules.Count-1 do
            if Tables.Strings[i]=jsnImportRules.Pairs[j].JsonString.Value then isValidSheet:=True;
        if not isValidSheet then Continue;

        Inc(ProcessedCount);
        DSet:=TFDQuery.Create(nil);
        try
          sql:=Format('SELECT * FROM [%s]',[Tables.Strings[i]]);
          ExcelEngine.GetData(DSet,sql);
          Rows:=TJSONArray.Create;
          while not DSet.Eof do
            begin
              if IsTerminated then Exit;

              Row:=TJSONObject.Create;
              for FieldNum:=0 to DSet.FieldCount-1 do
                begin
                  if not DSet.Fields[FieldNum].IsNull then
                    if TryStrToFloat(DSet.Fields[FieldNum].AsString, tpFloat) then
                      begin
                        NumValue:=TJSONNumber.Create(DSet.Fields[FieldNum].AsFloat);
                        Cell:=TJSONPair.Create(DSet.Fields[FieldNum].FieldName, NumValue);
                      end
                    else Cell:=TJSONPair.Create(DSet.Fields[FieldNum].FieldName, DSet.Fields[FieldNum].AsString)
                  else
                    Cell:=TJSONPair.Create(DSet.Fields[FieldNum].FieldName,nil);
                  Row.AddPair(Cell);
                end;
              Rows.AddElement(Row);
              DSet.Next;
            end;
          DataJSON.AddPair(TJSONPair.Create(Tables.Strings[i],Rows));
        finally
          DSet.Free
        end;
      end;

    // если не обработан ни один лист - выводим ошибку и список листов статистики
    if ProcessedCount=0 then
      begin
        ErrorText:='';
        for j := 0 to Tables.Count-1 do
          begin
            if j>0 then ErrorText:=ErrorText+', ';
            ErrorText:=ErrorText+Tables.Strings[j];
          end;
        Raise Exception.CreateFmt('Ни по одину листу в настройках нет информации. Листы: %s', [ErrorText]);
      end;

    ExcelEngine.CloseConnection;
  finally
    ExcelEngine.Free;
    Tables.Free;
  end;
end;

function TStatEngine.GetFileDataDate(FileName, FilePath: String): TDateTime;
var
  i: Integer;
  Year, Month, Day: Integer;
begin
  try
    for i := Length(FileName) downto 0 do
      if FileName[i]='_' then Break;
    Year:=StrToIntDef(Copy(FileName,i+1,4),0);
    Month:=StrToIntDef(Copy(FileName,i+5,2),0);
    Day:=StrToIntDef(Copy(FileName,i+7,2),0);
    result:=EncodeDate(Year,Month,Day)
  except
    FileAge(FilePath+FileName, result);
  end;
end;

procedure TStatEngine.ChooseFilesToImport(Files: TJSONObject; LastDate: TDateTime);
var
  i, j, MinIdx: Integer;
  FileDataDate, MinDate: TDateTime;
  TempJSON: TJSONObject;
  SortedIdx: ArrayOfVariant;
begin
  // выбираем подходящие файлы из списка
  TempJSON:=TJSONObject.Create;
  try
    for i := 0 to Files.Count-1 do
      begin
        FileDataDate:=GetFileDataDate(Files.Pairs[i].JsonValue.Value, Files.Pairs[i].JsonString.Value);
        if FileDataDate>LastDate then
          begin
            TempJSON.AddPair(Files.Pairs[i]);
          end;
      end;
    Files.FreeInstance;
    Files:=TJSONObject(TempJSON.Clone);
  finally
    TempJSON.Free;
  end;

  // подходящие файлы в списке сортируем
  TempJSON:=TJSONObject.Create;
  try
    for i:=0 to Files.Count-1 do
      begin
        for j:=0 to Files.Count-1 do
          if not TArrayFuncs.InArray(SortedIdx,j) then
            begin
              MinDate:=GetFileDataDate(Files.Pairs[j].JsonValue.Value, Files.Pairs[j].JsonString.Value);
              MinIdx:=j;
              Break;
            end;
        for j:=0 to Files.Count-1 do
          begin
            FileDataDate:=GetFileDataDate(Files.Pairs[j].JsonValue.Value, Files.Pairs[j].JsonString.Value);
            if (FileDataDate<MinDate) and (not TArrayFuncs.InArray(SortedIdx,j)) then
              begin
                MinDate:=FileDataDate;
                MinIdx:=j;
              end;
          end;
        SortedIdx:=SortedIdx+[MinIdx];
      end;

    for i:=0 to High(SortedIdx) do
      TempJSON.AddPair(Files.Pairs[SortedIdx[i]]);
    Files.FreeInstance;
    Files:=TJSONObject(TempJSON.Clone);
  finally
    TempJSON.Free;
  end;
end;

function TStatEngine.GetLastDate(TableName: String): TDateTime;
var
  sql: String;
  DSet: TSimpleDataSet;
begin
  DSet:=TSimpleDataSet.Create(nil);
  with DSet do
  try
    sql:='SELECT max(stat_date) as maxdate from '+TableName;
    Fmysql.GetData(DSet,sql);
    result:=DSet.FieldByName('maxdate').AsDateTime;
  finally
    Free;
  end;
end;

class function TStatEngine.GetSettings(SettingFile: String): TJSONObject;
begin
  with TStringList.Create do
  try
    LoadFromFile(SettingFile);
    Result:=TJSONObject(TJSONObject.ParseJSONValue(Text));
  finally
    Free;
  end;
end;

procedure TStatEngine.StatExcute(SettingFile: String);
var
  LastDate: TDateTime;
  FilesJSON: TJSONObject;
  DataJSON: TJSONObject;
  TransInfo: TDBXTransaction;
  i: Integer;
begin
  FEventData:=TJSONObject.Create;
  FilesJSON:=TJSONObject.Create;
  Self.GenerateEvent('Begin');
  try
    // считать настройки
    FSettingData:=Self.GetSettings(SettingFile);

    // получить последнюю актуальную дату с базы
    LastDate:=Self.GetLastDate(FSettingData.GetValue('TableName').Value);

    // получить список файлов
    with TFilesEngine.Create do
    try
      GetFileNamesByMask(FSettingData.GetValue('SearchPath').Value,FSettingData.GetValue('FileMask').Value,FilesJSON);
    finally
      Free;
    end;

    // выбрать список файлов к импорту, отсортировать по дате
    Self.ChooseFilesToImport(FilesJSON,LastDate);

    // если нет файлов к обработке
    if FilesJSON.Count=0 then Self.GenerateEvent('NoFilesToProcess');

    // перебрать список открывать каждый файл
    for i := 0 to FilesJSON.Count-1 do
      begin
        // старт транзакции
        TransInfo:=Self.Fmysql.FSQLConnection.BeginTransaction;
        try
          FCurrFile:=FilesJSON.Pairs[i].JsonValue.Value;
          Self.GenerateEvent('ProcessFile');
          DataJSON:=TJSONObject.Create;
          try
            // датасет файла перегнать в json
            Self.GenerateEvent('ReadFromFile');
            Self.GetStatData(FilesJSON.Pairs[i],TJSONObject(FSettingData.GetValue('ImportRules')),DataJSON);
            // json согласно правилам настройки перегнать в mysql
            Self.ImportStatData(TJSONObject(FSettingData.GetValue('ImportRules')), DataJSON);
          finally
            DataJSON.Free;
          end;

          if IsTerminated then Exit;

          // конец транкзакции
          Self.Fmysql.FSQLConnection.CommitFreeAndNil(TransInfo);
        except
          On E : Exception do
            begin
              // откат транкзакции
              Self.Fmysql.FSQLConnection.RollbackFreeAndNil(TransInfo);
              Self.GenerateEvent('Error',E.Message);
              Exit;
            end;
        end;
      end;

  finally
    Self.GenerateEvent('End');
    FilesJSON.Free;
    FEventData.Free;
    if Assigned(FSettingData) then FSettingData.Free;
  end;
end;

function TStatAbis.CustomRecalc(Row, RuleFields: TJSONObject): Boolean;
var
  ColNum: Integer;
  BtsNumber: String;
  Key: String;
  Value: Integer;
begin
  Result:=False;
  ColNum:=TJSONNumber(RuleFields.GetValue('bts_id')).AsInt-1;
  if Row.Pairs[ColNum].JsonValue<>nil then
    begin
      BtsNumber:=Row.Pairs[ColNum].JsonValue.Value;
      Key:=Row.Pairs[ColNum].JsonString.Value;
      Value:=TRSapi.GetBtsIdByNumber(BtsNumber, Self.Fmysql);
      if Value>0 then
        begin
          Row.Pairs[ColNum].Create(Key, TJSONNumber.Create(Value));
          Result:=True;
        end;
    end;
end;

function TStatTRAU.CustomRecalc(Row, RuleFields: TJSONObject): Boolean;
var
  ColNum: Integer;
  BSCNumber: String;
  Key: String;
  Value: Integer;
begin
  Result:=False;
  if Row.Pairs[2].JsonValue<>nil then
    begin
      ColNum:=TJSONNumber(RuleFields.GetValue('bsc_id')).AsInt-1;
      if Row.Pairs[ColNum].JsonValue<>nil then
        begin
          BSCNumber:=Row.Pairs[ColNum].JsonValue.Value;
          Delete(BSCNumber,Pos('_',BSCNumber),Length(BSCNumber));
          Key:=Row.Pairs[ColNum].JsonString.Value;
          Value:=TRSapi.GetBSCIdByNumber(BSCNumber, Self.Fmysql);
          if Value>0 then
            begin
              Row.Pairs[ColNum].Create(Key, TJSONNumber.Create(Value));
              Result:=True;
            end;
        end;
    end;
end;

function TStatCEHW.CustomRecalc(Row, RuleFields: TJSONObject): Boolean;
var
  ColNum: Integer;
  BtsNumber: String;
  Key: String;
  Value: Integer;
begin
  Result:=False;
  ColNum:=TJSONNumber(RuleFields.GetValue('bts_id')).AsInt-1;
  if Row.Pairs[ColNum].JsonValue<>nil then
    begin
      BtsNumber:=Row.Pairs[ColNum].JsonValue.Value;
      Delete(BtsNumber,1,Pos('-',BtsNumber));
      Key:=Row.Pairs[ColNum].JsonString.Value;
      Value:=TRSapi.GetBtsIdByNumber(BtsNumber, self.Fmysql);
      if Value>0 then
        begin
          Row.Pairs[ColNum].Create(Key, TJSONNumber.Create(Value));
          Result:=True;
        end;
    end;
  if Result then
    begin
      ColNum:=TJSONNumber(RuleFields.GetValue('lcg')).AsInt-1;
      if Row.Pairs[ColNum].JsonValue<>nil then
        begin
          if TJSONNumber(Row.Pairs[ColNum].JsonValue).AsInt=0 then
            Row.Pairs[ColNum].Create('lcg', '');
        end;

      ColNum:=TJSONNumber(RuleFields.GetValue('vendor')).AsInt-1;
      if Row.Pairs[ColNum].JsonValue<>nil then
        begin
          Row.Pairs[ColNum].Create('vendor', 'huawei');
        end;
    end;
end;

procedure TStatEngine.InsertData(Row: TJSONObject; RuleFields: TJSONObject);
var
  Pair: TJSONPair;
  sql: string;
  i: Integer;
begin
  sql:='INSERT INTO '+FSettingData.GetValue('TableName').Value+' SET';
  i:=0;
  for Pair in RuleFields do
    begin
      if i=0 then sql:=sql + ' ' else sql:=sql + ',';
      sql:=sql + Pair.JsonString.Value + '=';
      if Row.Pairs[StrToInt(Pair.JsonValue.Value)-1].JsonValue<>nil then
        sql:=sql + TMySQLEngine.StrToSQL(Row.Pairs[StrToInt(Pair.JsonValue.Value)-1].JsonValue.Value)
      else sql:=sql + 'NULL';
      Inc(i);
    end;
  Fmysql.SetData(sql);
end;

procedure TStatEngine.GenerateEvent(EventCode: string; EventMsg: string = '');
begin
  if IsTerminated then Exit;

  if FEventData.Count>0 then
    begin
       FEventData.FreeInstance;
       FEventData:=TJSONObject.Create;
    end;

  if EventCode = 'Begin' then
    begin
      FEventData.AddPair(TJSONPair.Create('Log','Старт процесса...'));
      FEventData.AddPair(TJSONPair.Create('Records',''));
      FEventData.AddPair(TJSONPair.Create('Current',''));
    end;

  if EventCode = 'NoFilesToProcess' then
    begin
      FEventData.AddPair(TJSONPair.Create('Log','Нет подходящих файлов для обработки.'));
    end;

  if EventCode = 'ProcessFile' then
    begin
      FEventData.AddPair(TJSONPair.Create('Log','В работе файл: '+FCurrFile));
    end;
  if EventCode = 'ReadFromFile' then
    begin
      FEventData.AddPair(TJSONPair.Create('Log','Чтение из файла...'));
    end;
  if EventCode = 'ImportSheet' then
    begin
      FEventData.AddPair(TJSONPair.Create('Log','Импорт в базу листа: '+FCurrSheet));
      FEventData.AddPair(TJSONPair.Create('Records',IntToStr(FRecordsCount)));
    end;
  if EventCode = 'ProcRange' then
    begin
      FEventData.AddPair(TJSONPair.Create('Log','Выполнение...'));
      FEventData.AddPair(TJSONPair.Create('Records',IntToStr(FRecordsCount)));
    end;
  if (EventCode = 'ImportRow') or (EventCode = 'ProcStep') then
    begin
      FEventData.AddPair(TJSONPair.Create('Current',IntToStr(FRecordNum)));
    end;
  if EventCode = 'End' then
    begin
      FEventData.AddPair(TJSONPair.Create('Log','Процесс закончен.'));
    end;
  if EventCode = 'Error' then
    begin
      FEventData.AddPair(TJSONPair.Create('Log','Ошибка процесса: '+ EventMsg));
    end;

  if Assigned(FStatInfoUpdated) then FStatInfoUpdated(Self, Self.FEventData);
end;

end.
