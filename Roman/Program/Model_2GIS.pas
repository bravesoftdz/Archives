unit Model_2GIS;

interface

uses
   System.Generics.Collections
  ,API_Parse
  ,API_DBases
  ,API_Yandex;

type
  T2GISModel = class(TModelParse)
  // ������� ������
  private
    FTranslater: TYaTranslater;
    procedure ParseCities(aLinkId: Integer; aPage: string);
    procedure ParseCategories(aLinkId: Integer; aPage: string);
    procedure ParseOrganizationsList(aLinkId: Integer; aPage: string);
    procedure ParseOrganizations(aLinkId: Integer; aPage: string);
  private
    procedure CustomerTableAddRecord(aLinkId, aNum: integer);
    function GetRubricData(aAlias: string; out aCatID: string; out aContent: TArray<string>): Boolean;
    function GetOrganizationURL(aPageNum: integer; aRubricId, aReginId, aKey: string): string;

  // ���������������� ������
  private
    procedure SetStartLinks(aLinkID: integer); override;
    procedure SetParseMethods(aLevel: Integer); override;
  protected
    procedure InitParserData; override;
    procedure DeinitParserData; override;
  end;

  procedure InsertToRomanTable(aDBEngine: TDBEngine; aParser: TParser; aLinkId: Integer; aCustomFields: TDictionary<string,string>; aNum: integer=1);

implementation

uses
   System.SysUtils
  ,System.JSON
  ,FireDAC.Comp.Client
  ,FireDAC.Stan.Param
  ,Data.DB;

procedure InsertToRomanTable(aDBEngine: TDBEngine; aParser: TParser; aLinkId: Integer; aCustomFields: TDictionary<string,string>; aNum: integer=1);
var
  sql: String;
  Fields: TArray<string>;
  Field, Value: String;
  dsQuery: TFDQuery;
  level: integer;
begin
  Fields:=Fields+['category_identifier'];
  Fields:=Fields+['ru_title'];
  Fields:=Fields+['en_title'];
  Fields:=Fields+['ua_title'];
  Fields:=Fields+['ru_city'];
  Fields:=Fields+['en_city'];
  Fields:=Fields+['ua_city'];
  Fields:=Fields+['ru_country'];
  Fields:=Fields+['en_country'];
  Fields:=Fields+['ua_country'];
  Fields:=Fields+['ru_address'];
  Fields:=Fields+['en_address'];
  Fields:=Fields+['ua_address'];
  Fields:=Fields+['email'];
  Fields:=Fields+['skype'];
  Fields:=Fields+['phone'];
  Fields:=Fields+['ru_contacts'];
  Fields:=Fields+['en_contacts'];
  Fields:=Fields+['ua_contacts'];
  Fields:=Fields+['ru_content'];
  Fields:=Fields+['en_content'];
  Fields:=Fields+['ua_content'];
  Fields:=Fields+['site_url'];
  Fields:=Fields+['ru_source'];
  Fields:=Fields+['en_source'];
  Fields:=Fields+['ua_source'];

  sql:='insert into parsed_sites_roman set';
  sql:=sql+' ctime=:ctime';
  for Field in Fields do
    begin
      sql:=sql+','+Field+'=:'+Field;
    end;
  sql:=sql+',ru_source_hash=md5(:ru_source)';
  sql:=sql+',en_source_hash=md5(:en_source)';
  sql:=sql+',ua_source_hash=md5(:ua_source)';

  dsQuery:=TFDQuery.Create(nil);
  try
    dsQuery.SQL.Text:=sql;

    dsQuery.ParamByName('ctime').AsDateTime:=Now;

    for Field in Fields do
      begin
        dsQuery.ParamByName(Field).DataType:=ftString;

        // ���� � ��������� ������
        if aCustomFields.ContainsKey(Field) then
          dsQuery.ParamByName(Field).AsString:=aCustomFields[Field]
        else
          begin
            // ���� � ������� ������� �� LinkID
            Value:=aParser.GetValueByKey(aLinkId, Field, level, aNum);
            if Value<>'' then dsQuery.ParamByName(Field).AsString:=Value
            else dsQuery.ParamByName(Field).Clear;
          end;
      end;

    aDBEngine.ExecQuery(dsQuery);

  finally
    dsQuery.Free;
  end;
end;

procedure T2GISModel.DeinitParserData;
begin
  FTranslater.Free;
end;

procedure T2GISModel.CustomerTableAddRecord(aLinkId: Integer; aNum: Integer);
var
  dsQuery, dsCheck: TFDQuery;
  sql, tx: string;
  level: Integer;
  City, CityEN, CityUA: string;
  Title, TitleEN, TitleUA: string;
  Content: string;
begin
  dsQuery:=TFDQuery.Create(nil);
  dsCheck:=TFDQuery.Create(nil);
  try
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
    sql:=sql+',phone=:phone';
    sql:=sql+',ru_content=:ru_content';
    sql:=sql+',en_content=:en_content';
    sql:=sql+',ua_content=:ua_content';
    sql:=sql+',site_url=:site_url';
    sql:=sql+',ru_source=:ru_source';
    sql:=sql+',en_source=:en_source';
    sql:=sql+',ua_source=:ua_source';
    sql:=sql+',ru_source_hash=md5(:ru_source)';
    sql:=sql+',en_source_hash=md5(:en_source)';
    sql:=sql+',ua_source_hash=md5(:ua_source)';

    dsQuery.SQL.Text:=sql;

    dsQuery.ParamByName('ctime').AsDateTime:=Now;
    dsQuery.ParamByName('category_identifier').AsString:=FParser.GetValueByKey(aLinkId, 'CategoryID', level);

    Title:=FParser.GetValueByKey(aLinkId, 'OrganizationName', level, aNum);
    dsQuery.ParamByName('ru_title').AsString:=Title;
    TitleEN:=FParser.GetValueByKey(aLinkId, 'OrganizationNameEN', level, aNum);
    dsQuery.ParamByName('en_title').AsString:=TitleEN;
    TitleUA:=FParser.GetValueByKey(aLinkId, 'OrganizationNameUA', level, aNum);
    dsQuery.ParamByName('ua_title').AsString:=TitleUA;

    City:=FParser.GetValueByKey(aLinkId, 'CityName', level);
    dsQuery.ParamByName('ru_city').AsString:=City;
    CityEN:=FParser.GetValueByKey(aLinkId, 'CityNameEN', level);
    dsQuery.ParamByName('en_city').AsString:=CityEN;
    CityUA:=FParser.GetValueByKey(aLinkId, 'CityNameUA', level);
    dsQuery.ParamByName('ua_city').AsString:=CityUA;

    dsQuery.ParamByName('ru_country').AsString:=FParser.GetValueByKey(aLinkId, 'Country', level, aNum);
    dsQuery.ParamByName('en_country').AsString:=FParser.GetValueByKey(aLinkId, 'CountryEN', level, aNum);
    dsQuery.ParamByName('ua_country').AsString:=FParser.GetValueByKey(aLinkId, 'CountryUA', level, aNum);

    dsQuery.ParamByName('ru_address').AsString:=Trim(City+' '+FParser.GetValueByKey(aLinkId, 'Address', level, aNum));
    dsQuery.ParamByName('en_address').AsString:=Trim(CityEN+' '+FParser.GetValueByKey(aLinkId, 'AddressEN', level, aNum));
    dsQuery.ParamByName('ua_address').AsString:=Trim(CityUA+' '+FParser.GetValueByKey(aLinkId, 'AddressUA', level, aNum));

    dsQuery.ParamByName('phone').AsString:=TParseTool.Inplode(FParser.GetArrayByKey(aLinkId, 'Phone', aNum),', ');
    dsQuery.ParamByName('email').AsString:=TParseTool.Inplode(FParser.GetArrayByKey(aLinkId, 'Email', aNum),', ');

    dsQuery.ParamByName('site_url').AsString:=TParseTool.Inplode(FParser.GetArrayByKey(aLinkId, 'Website', aNum),', ');

    Content:=FParser.GetValueByKey(aLinkId, 'ContentRU', level, aNum);
    Content:=StringReplace(Content, '#Name', Title, [rfReplaceAll, rfIgnoreCase]);
    Content:=StringReplace(Content, '#City', City, [rfReplaceAll, rfIgnoreCase]);
    dsQuery.ParamByName('ru_content').AsString:=Content;

    Content:=FParser.GetValueByKey(aLinkId, 'ContentEN', level, aNum);
    Content:=StringReplace(Content, '#Name', TitleEN, [rfReplaceAll, rfIgnoreCase]);
    Content:=StringReplace(Content, '#City', CityEN, [rfReplaceAll, rfIgnoreCase]);
    dsQuery.ParamByName('en_content').AsString:=Content;

    Content:=FParser.GetValueByKey(aLinkId, 'ContentUA', level, aNum);
    Content:=StringReplace(Content, '#Name', TitleUA, [rfReplaceAll, rfIgnoreCase]);
    Content:=StringReplace(Content, '#City', CityUA, [rfReplaceAll, rfIgnoreCase]);
    dsQuery.ParamByName('ua_content').AsString:=Content;

    tx:='http://2gis.ru/';
    tx:=tx+FParser.GetValueByKey(aLinkId, 'CityNameEN', level, aNum);
    tx:=tx+'/search/rubricId/';
    tx:=tx+FParser.GetValueByKey(aLinkId, 'RubricID', level, aNum);
    tx:=tx+'/firm/'+FParser.GetValueByKey(aLinkId, 'OrgID', level, aNum);
    dsQuery.ParamByName('ru_source').AsString:=tx;
    dsQuery.ParamByName('en_source').AsString:=tx;
    dsQuery.ParamByName('ua_source').AsString:=tx;

    dsCheck.SQL.Text:=Format('select id from parsed_sites_roman where ru_source_hash="%s"',[tx]);
    FDBEngine.OpenQuery(dsCheck);
    if dsCheck.IsEmpty then
      try
        FDBEngine.ExecQuery(dsQuery);
      except
        On E : Exception do
          begin
            // log
            FParser.WriteErrorLog(aLinkId, 'CustomerTableAddRecord', dsQuery.Params.ToString, E.Message);
            Exit;
          end;
      end;
  finally
    dsQuery.Free;
    dsCheck.Free;
  end;
end;

procedure T2GISModel.ParseOrganizations(aLinkId: Integer; aPage: string);
var
  jsnObject, jsnResult: TJSONObject;
  jsnArray: TJSONArray;
  jsnContactGroups: TJSONArray;
  jsnContacts: TJSONArray;
  jsnContact: TJSONObject;
  i,j,k: Integer;
  RubricID, RegionID, Key: string;
  level: Integer;
  url, tx: string;
  PageNume: Integer;
begin
  jsnObject:=TJSONObject(TJSONObject.ParseJSONValue(aPage));
  try
    jsnResult:=TJSONObject(jsnObject.GetValue('result'));
    if jsnResult=nil then Exit;

    jsnArray:=TJSONArray(jsnResult.GetValue('items'));
    for i:=0 to jsnArray.Count-1 do
      begin
        jsnResult:=TJSONObject(jsnArray.Items[i]);
        FParser.AddData(aLinkId, i+1, 'OrganizationName', jsnResult.GetValue('name').Value);

        tx:=Self.FTranslater.Translate('en', jsnResult.GetValue('name').Value);
        FParser.AddData(aLinkId, i+1, 'OrganizationNameEN', tx);

        tx:=Self.FTranslater.Translate('uk', jsnResult.GetValue('name').Value);
        FParser.AddData(aLinkId, i+1, 'OrganizationNameUA', tx);

        // �������, ����
        jsnContactGroups:=TJSONArray(jsnResult.GetValue('contact_groups'));
        for j:=0 to jsnContactGroups.Count-1 do
          begin
            jsnContacts:=TJSONArray(TJSONObject(jsnContactGroups.Items[j]).GetValue('contacts'));
            for k:=0 to jsnContacts.Count-1 do
              begin
                jsnContact:=TJSONObject(jsnContacts.Items[k]);
                if jsnContact.GetValue('type').Value='phone' then
                  begin
                    FParser.AddData(aLinkId, i+1, 'Phone', jsnContact.GetValue('value').Value);
                  end;
                if jsnContact.GetValue('type').Value='website' then
                  begin
                    FParser.AddData(aLinkId, i+1, 'Website', jsnContact.GetValue('text').Value);
                  end;
                if jsnContact.GetValue('type').Value='email' then
                  begin
                    FParser.AddData(aLinkId, i+1, 'Email', jsnContact.GetValue('text').Value);
                  end;
              end;
          end;

        // �����
        if jsnResult.GetValue('address_name')<>nil then
          begin
            FParser.AddData(aLinkId, i+1, 'Address', jsnResult.GetValue('address_name').Value);

            tx:=TParseTool.TranslitRus2Lat(jsnResult.GetValue('address_name').Value);
            FParser.AddData(aLinkId, i+1, 'AddressEN', tx);

            FParser.AddData(aLinkId, i+1, 'AddressUA', jsnResult.GetValue('address_name').Value);
          end;

        // id
        tx:=jsnResult.GetValue('id').Value;
        tx:=TParseTool.ParseByKey(tx,'','_');
        FParser.AddData(aLinkId, i+1, 'OrgID', tx);

        // ������ � ������� ���������
        CustomerTableAddRecord(aLinkId, i+1);
      end;

  finally
    FreeAndNil(jsnObject);
  end;

  // ���������� ��� ���� ��������
  RubricID:=FParser.GetValueByKey(aLinkId, 'RubricID', level);
  RegionID:=FParser.GetValueByKey(aLinkId, 'RegionID', level);
  Key:=FParser.GetValueByKey(aLinkId, 'WebKey', level);
  tx:=TParseTool.ParseByKey(FParser.GetLinkById(aLinkId),'&page=','&');
  PageNume:=StrToInt(tx)+1;
  url:=GetOrganizationURL(PageNume, RubricID, RegionID, Key);
  FParser.AddLink(4, url, aLinkId, 1);
end;

function T2GISModel.GetOrganizationURL(aPageNum: integer; aRubricId, aReginId, aKey: string): string;
var
  url: string;
begin
  url:='http://catalog.api.2gis.ru/2.0/catalog/branch/list?isIndexedFrame=true&shouldTrackSearch=false';
  url:=url+'&page='+IntToStr(aPageNum);
  url:=url+'&page_size=12';
  url:=url+'&rubric_id='+aRubricId;
  url:=url+'&stat%5Bpr%5D=10';
  url:=url+'&region_id='+aReginId;
  url:=url+'&fields=items.region_id%2Citems.adm_div%2Citems.contact_groups%2Citems.flags%2Citems.address%2Citems.rubrics';
  url:=url+'%2Citems.name_ex%2Citems.point%2Citems.external_content%2Citems.schedule%2Citems.org%2Citems.ads.options%2Citems.reg_bc_url%2Crequest_type%2Cwidgets%2Cfilters%2Citems.reviews%2Ccontext_rubrics%2Chash%2Csearch_attributes';
  url:=url+'&key='+aKey;
  Result:=url;
end;

procedure T2GISModel.ParseOrganizationsList(aLinkId: Integer; aPage: string);
var
  tx: string;
  level: integer;
  RubricID, RegionID: string;
  Key, url: string;
begin
  tx:=TParseTool.ParseByKey(aPage, '"region_id":"', '"');
  FParser.AddData(aLinkId, 1, 'RegionID', tx);

  tx:=TParseTool.ParseByKey(aPage, '"webApiKey":"', '"');
  FParser.AddData(aLinkId, 1, 'WebKey', tx);

  RubricID:=FParser.GetValueByKey(aLinkId, 'RubricID', level);
  RegionID:=FParser.GetValueByKey(aLinkId, 'RegionID', level);
  Key:=FParser.GetValueByKey(aLinkId, 'WebKey', level);
  url:=GetOrganizationURL(1, RubricID, RegionID, Key);
  FParser.AddLink(4, url, aLinkId, 1);
end;

function T2GISModel.GetRubricData(aAlias: string; out aCatID: string; out aContent: TArray<string>): Boolean;
var
  sql: string;
  dsQuery: TFDQuery;
begin
  sql:='select * from params_roman_2gis where site_rubric_name=:alias';
  dsQuery:=TFDQuery.Create(nil);
  try
    dsQuery.SQL.Text:=sql;
    dsQuery.ParamByName('alias').AsString:=aAlias;
    FDBEngine.OpenQuery(dsQuery);
    if not dsQuery.Eof then
      begin
        aCatID:=dsQuery.FieldByName('category_id').AsString;
        aContent:=aContent+[dsQuery.FieldByName('content_template_ru').AsString];
        aContent:=aContent+[dsQuery.FieldByName('content_template_en').AsString];
        aContent:=aContent+[dsQuery.FieldByName('content_template_ua').AsString];
        Result:=True;
      end
    else Result:=False;
  finally
    dsQuery.Free;
  end;
end;

procedure T2GISModel.ParseCategories(aLinkId: Integer; aPage: string);
var
  Rows: TArray<string>;
  i: integer;
  Row: string;
  CatID: string;
  Content: TArray<string>;
  rec, tx: string;
  url: string;
  Words: TArray<string>;
begin
  Rows:=TParseTool.MultiParseByKey(aPage,'"alias":"','"');

  i:=0;
  for Row in Rows do
    begin
      if GetRubricData(Row, CatID, Content) then
        begin
          inc(i);

          rec:=TParseTool.ParseByKeyReverse(aPage, Row, '{', 1) + TParseTool.ParseByKey(aPage, Row, '}', 1);
          tx:=TParseTool.ParseByKey(rec, '"name":"', '"');
          FParser.AddData(aLinkId, i, 'CategoryName', tx);
          FParser.AddData(aLinkId, i, 'CategoryID', CatID);

          FParser.AddData(aLinkId, i, 'ContentRU', Content[0]);
          FParser.AddData(aLinkId, i, 'ContentEN', Content[1]);
          FParser.AddData(aLinkId, i, 'ContentUA', Content[2]);

          url:=FParser.GetLinkById(aLinkId);
          Words:=TParseTool.Explode(url,'/');

          tx:=TParseTool.ParseByKey(rec, '"id":"', '"');
          FParser.AddData(aLinkId, i, 'RubricID', tx);

          url:=Words[0]+'//'+Words[2]+'/'+Words[3]+'/search/rubricId/'+tx;
          FParser.AddLink(3, url, aLinkId, i);
        end;
    end;
end;

procedure T2GISModel.ParseCities(aLinkId: Integer; aPage: string);
var
  Rows: TArray<string>;
  i, level: integer;
  Row, tx: string;
  Site, City, Country: string;
begin
  Rows:=TParseTool.MultiParseByKey(aPage, 'listItemName"><a href="', '</li>');

  i:=0;
  Site:=FParser.GetValueByKey(aLinkId, 'Site', level);
  for Row in Rows do
    begin
      Inc(i);

      tx:=Site + Copy(Row, 1, Pos('"', Row)-1) + '/rubrics';
      FParser.AddLink(2, tx, aLinkId, i);

      City:=TParseTool.ParseByKey(Row, 'listItemNameLink">', '<');
      FParser.AddData(aLinkId, i, 'CityName', City);

      tx:=FTranslater.Translate('en', City);
      FParser.AddData(aLinkId, i, 'CityNameEN', tx);

      tx:=FTranslater.Translate('uk', City);
      FParser.AddData(aLinkId, i, 'CityNameUA', tx);

      tx:=TParseTool.ParseByKeyReverse(aPage, 'world__listItemNameLink">'+City, '"world__sectionHeaderIn">', 0);
      tx:=TParseTool.ParseByKey(tx,'','<');
      Country:=tx;
      FParser.AddData(aLinkId, i, 'Country', Country);

      tx:=FTranslater.Translate('en', Country);
      FParser.AddData(aLinkId, i, 'CountryEN', tx);

      tx:=FTranslater.Translate('uk', Country);
      FParser.AddData(aLinkId, i, 'CountryUA', tx);
    end;
end;

procedure T2GISModel.SetStartLinks(aLinkID: Integer);
var
  LinkId: Integer;
begin
  LinkId:=FParser.AddLink(1, 'http://2gis.ru/countries/global/moscow?queryState=center%2F37.62017%2C55.753466%2Fzoom%2F5', aLinkID, 1);
  FParser.AddData(LinkId, 1, 'Site', 'https://2gis.ru');
end;

procedure T2GISModel.SetParseMethods(aLevel: Integer);
begin
  if aLevel=1 then FParseMethod:=ParseCities;
  if aLevel=2 then FParseMethod:=ParseCategories;
  if aLevel=3 then FParseMethod:=ParseOrganizationsList;
  if aLevel=4 then FParseMethod:=ParseOrganizations;
end;

procedure T2GISModel.InitParserData;
begin
  FData.AddOrSetValue('ParserName', 'roman_2gis');
  FData.AddOrSetValue('ZeroLink', 'http://2gis.ru/');

  FTranslater:=TYaTranslater.Create;
end;

end.
