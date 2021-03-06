unit Model_Convertor;

interface

uses
   System.SysUtils
  ,API_MVC
  ,API_Threads
  ,API_Yandex
  ,FireDAC.Comp.Client
  ,FireDAC.Stan.Param
  ,Data.DB;

type
  TConvertModel = class(TModelThread)
  private
    FTranslater: TYaTranslater;
    function GetQuery(aQuery: TFDQuery): TFDQuery;
    procedure ProcessRecord(aQuery: TFDQuery);
  public
    procedure Execute; override;
  end;

implementation

uses
   System.Classes
  ,API_Parse
  ,API_Files;

function TConvertModel.GetQuery(aQuery: TFDQuery): TFDQuery;
var
  sql: string;
begin
    sql:='select * from pre_parsed_sites';
    sql:=sql+' where handled is null limit 1';
    Result:=FDBEngine.GetData(sql);

    sql := Format('update pre_parsed_sites set handled=1 where id=%d', [Result.FieldByName('Id').AsInteger]);
    FDBEngine.SetData(sql);
end;

procedure TConvertModel.ProcessRecord(aQuery: TFDQuery);
var
  sql: string;
  dsQuery: TFDQuery;
begin
  sql:='insert into parsed_sites_roman set';
  sql:=sql+' ctime=:ctime';
  sql:=sql+',category_identifier=:category_identifier';
  sql:=sql+',ru_title=:ru_title';
  sql:=sql+',en_title=:en_title';
  sql:=sql+',ua_title=:ua_title';
  sql:=sql+',ru_city=:ru_city';
  sql:=sql+',en_city=:en_city';
  sql:=sql+',ua_city=:ua_city';
  sql:=sql+',ru_country=:ru_country';
  sql:=sql+',en_country=:en_country';
  sql:=sql+',ua_country=:ua_country';
  sql:=sql+',ru_address=:ru_address';
  sql:=sql+',en_address=:en_address';
  sql:=sql+',ua_address=:ua_address';
  sql:=sql+',email=:email';
  sql:=sql+',skype=:skype';
  sql:=sql+',phone=:phone';
  sql:=sql+',ru_content=:ru_content';
  sql:=sql+',en_content=:en_content';
  sql:=sql+',ua_content=:ua_content';
  sql:=sql+',site_url=:site_url';
  sql:=sql+',ru_source=:ru_source';
  sql:=sql+',en_source=:ru_source';
  sql:=sql+',ua_source=:ru_source';
  sql:=sql+',ru_source_hash=md5(:ru_source)';
  sql:=sql+',en_source_hash=md5(:ru_source)';
  sql:=sql+',ua_source_hash=md5(:ru_source)';

  dsQuery:=TFDQuery.Create(nil);
  try
    dsQuery.SQL.Text:=sql;
    dsQuery.ParamByName('ctime').DataType:=ftDateTime;
    dsQuery.ParamByName('ctime').AsDateTime:=Now;
    dsQuery.ParamByName('category_identifier').DataType:=ftString;
    dsQuery.ParamByName('category_identifier').AsString:=aQuery.FieldByName('category_identifier').AsString;
    dsQuery.ParamByName('ru_title').DataType:=ftString;
    dsQuery.ParamByName('ru_title').AsString:=aQuery.FieldByName('ru_title').AsString;
    dsQuery.ParamByName('en_title').DataType:=ftString;
    dsQuery.ParamByName('en_title').AsString:=FTranslater.Translate('en', aQuery.FieldByName('ru_title').AsString);
    dsQuery.ParamByName('ua_title').DataType:=ftString;
    dsQuery.ParamByName('ua_title').AsString:=FTranslater.Translate('uk', aQuery.FieldByName('ru_title').AsString);
    dsQuery.ParamByName('ru_city').DataType:=ftString;
    dsQuery.ParamByName('ru_city').AsString:=aQuery.FieldByName('ru_city').AsString;
    dsQuery.ParamByName('en_city').DataType:=ftString;
    dsQuery.ParamByName('en_city').AsString:=FTranslater.Translate('en', aQuery.FieldByName('ru_city').AsString);
    dsQuery.ParamByName('ua_city').DataType:=ftString;
    dsQuery.ParamByName('ua_city').AsString:=FTranslater.Translate('uk', aQuery.FieldByName('ru_city').AsString);
    dsQuery.ParamByName('ru_country').DataType:=ftString;
    dsQuery.ParamByName('ru_country').AsString:=aQuery.FieldByName('ru_country').AsString;
    dsQuery.ParamByName('en_country').DataType:=ftString;
    dsQuery.ParamByName('en_country').AsString:=FTranslater.Translate('en', aQuery.FieldByName('ru_country').AsString);
    dsQuery.ParamByName('ua_country').DataType:=ftString;
    dsQuery.ParamByName('ua_country').AsString:=FTranslater.Translate('uk', aQuery.FieldByName('ru_country').AsString);
    dsQuery.ParamByName('ru_address').DataType:=ftString;
    dsQuery.ParamByName('ru_address').AsString:=aQuery.FieldByName('ru_address').AsString;
    dsQuery.ParamByName('en_address').DataType:=ftString;
    dsQuery.ParamByName('en_address').AsString:=TParseTool.TranslitRus2Lat(aQuery.FieldByName('ru_address').AsString);
    dsQuery.ParamByName('ua_address').DataType:=ftString;
    dsQuery.ParamByName('ua_address').AsString:=aQuery.FieldByName('ru_address').AsString;
    dsQuery.ParamByName('email').DataType:=ftString;
    dsQuery.ParamByName('email').AsString:=aQuery.FieldByName('email').AsString;
    dsQuery.ParamByName('skype').DataType:=ftString;
    dsQuery.ParamByName('skype').AsString:=aQuery.FieldByName('skype').AsString;
    dsQuery.ParamByName('phone').DataType:=ftString;
    dsQuery.ParamByName('phone').AsString:=aQuery.FieldByName('phone').AsString;
    dsQuery.ParamByName('ru_content').DataType:=ftString;
    dsQuery.ParamByName('ru_content').AsString:=aQuery.FieldByName('ru_content').AsString;
    dsQuery.ParamByName('en_content').DataType:=ftString;
    dsQuery.ParamByName('en_content').AsString:=FTranslater.Translate('en', aQuery.FieldByName('ru_content').AsString);
    dsQuery.ParamByName('ua_content').DataType:=ftString;
    dsQuery.ParamByName('ua_content').AsString:=FTranslater.Translate('uk', aQuery.FieldByName('ru_content').AsString);
    dsQuery.ParamByName('site_url').DataType:=ftString;
    dsQuery.ParamByName('site_url').AsString:=aQuery.FieldByName('site_url').AsString;
    dsQuery.ParamByName('ru_source').DataType:=ftString;
    dsQuery.ParamByName('ru_source').AsString:=aQuery.FieldByName('ru_source').AsString;
    FDBEngine.ExecQuery(dsQuery);
  finally
    dsQuery.Free;
  end;
end;

procedure TConvertModel.Execute;
var
  error, sql: string;
  dsQuery: TFDQuery;
  isProcess: Boolean;
begin
  isProcess:=True;
  FTranslater:=TYaTranslater.Create;

  while isProcess do
    begin
      dsQuery:=TFDQuery.Create(nil);
      try
        TThread.Synchronize(nil,
          procedure()
          begin
            dsQuery := GetQuery(dsQuery);
          end
        );

        if dsQuery.IsEmpty then isProcess:=False
        else
          begin
            while not dsQuery.Eof do
              begin
                try
                  ProcessRecord(dsQuery);
                except
                  On E : Exception do
                    begin
                      sql := Format('update pre_parsed_sites set handled=-1 where id=%d', [dsQuery.FieldByName('Id').AsInteger]);
                      FDBEngine.SetData(sql);
                      error:=DateTimeToStr(Now);
                      error:=error+': Id=%d,';
                      error:=error+' Thread=%d, ';
                      error:=error+e.Message;
                      error:=Format(error, [dsQuery.FieldByName('Id').AsInteger, Self.FThreadNum]);
                      TThread.Synchronize(nil,
                        procedure()
                          begin
                            TFilesEngine.AppendToFile('ConvertErrors.log', error);
                          end
                        );
                    end;
                end;
                dsQuery.Next;
              end;
          end;
      finally
        dsQuery.Free;
      end;
    end;

  FTranslater.Free;
end;

end.
