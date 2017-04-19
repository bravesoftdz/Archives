unit Model_Wiki;

interface

uses
   FireDAC.Comp.Client
  ,FireDAC.Stan.Param
  ,Data.DB
  ,API_Parse;

type
  TWikiModel = class(TModelParse)
  // частные методы
  private
    function GetQueryText(aLang: string; aIsUpdate: Boolean): string;
    procedure ParseObjectList(aLinkId: Integer; aPage: string);
    procedure ParseObject(aLinkId: Integer; aPage: string);
    procedure CustomerTableAddRecord(aLinkId: integer);

  // переопределяемые методы
  private
    procedure SetStartLinks(aLinkID: integer); override;
    procedure SetParseMethods(aLevel: Integer); override;
  protected
    procedure InitParserData; override;
  end;

implementation

uses
  System.SysUtils;

function TWikiModel.GetQueryText(aLang: string; aIsUpdate: Boolean): string;
var
  sql: string;
begin
  if aIsUpdate then sql:='update parsed_sites set'
  else sql:='insert into parsed_sites set';

  sql:=sql+' ctime=:ctime';
  sql:=sql+',category_identifier=:category_identifier';
  sql:=sql+',site_url=:site_url';

  if aLang='ru' then
    begin
      sql:=sql+',ru_title=:title';
      sql:=sql+',ru_city=:city';
      sql:=sql+',ru_country=:country';
      sql:=sql+',ru_address=:address';
      sql:=sql+',ru_content=:content';
      sql:=sql+',ru_source=:source';
      sql:=sql+',ru_source_hash=md5(:source)';
    end;

  if aLang='en' then
    begin
      sql:=sql+',en_title=:title';
      sql:=sql+',en_city=:city';
      sql:=sql+',en_country=:country';
      sql:=sql+',en_address=:address';
      sql:=sql+',en_content=:content';
      sql:=sql+',en_source=:source';
      sql:=sql+',en_source_hash=md5(:source)';
    end;

  if aIsUpdate then sql:=sql+' where id = %d';
  Result:=sql;
end;

procedure TWikiModel.CustomerTableAddRecord(aLinkId: integer);
var
  dsQuery, dsContent: TFDQuery;
  sql, tx: string;
  level: Integer;
  City: string;
  Title: string;
  site: string;
  rubric: string;
  isUpdateMode: Boolean;
  Lang: string;
  UpdatedID: integer;
begin
  if FParser.GetLinkLevel(aLinkId)=3 then isUpdateMode:=True;

  Lang:=FParser.GetValueByKey(aLinkId, 'Lang', level);

  dsQuery:=TFDQuery.Create(nil);
  try
    sql:=GetQueryText(Lang, isUpdateMode);
    if isUpdateMode then
      begin
        tx:='select ps.id';
        tx:=tx+' from links l';
        tx:=tx+' join links l2 on l2.id=l.parent_link_id';
        tx:=tx+' join parsed_sites ps on (ps.ru_source_hash=l2.link_hash) or (ps.en_source_hash=l2.link_hash)';
        tx:=tx+' where l.id=%d';
        tx:=Format(tx, [aLinkId]);
        dsQuery.SQL.Text:=tx;
        FDBEngine.OpenQuery(dsQuery);
        UpdatedID:=dsQuery.FieldByName('id').AsInteger;
        sql:=Format(sql, [UpdatedID]);
        dsQuery.Close;
        dsQuery.SQL.Clear;
      end;
    dsQuery.SQL.Text:=sql;

    dsQuery.ParamByName('ctime').AsDateTime:=Now;

    rubric:=FParser.GetValueByKey(aLinkId, 'Rubric', level);
    dsQuery.ParamByName('category_identifier').AsString:=rubric;
    dsQuery.ParamByName('site_url').AsString:=TParseTool.Inplode(FParser.GetArrayByKey(aLinkId, 'Web'),', ');

    Title:=FParser.GetValueByKey(aLinkId, 'Title', level);
    City:=FParser.GetValueByKey(aLinkId, 'City', level);

    dsQuery.ParamByName('title').AsWideString:=Title;
    dsQuery.ParamByName('city').AsString:=City;
    dsQuery.ParamByName('country').AsString:=FParser.GetValueByKey(aLinkId, 'Country', level);
    dsQuery.ParamByName('address').AsString:=FParser.GetValueByKey(aLinkId, 'Address', level);
    dsQuery.ParamByName('source').AsString:=FParser.GetLinkById(aLinkId);
    dsQuery.ParamByName('content').AsWideString:=FParser.GetValueByKey(aLinkId, 'Description', level);

    FDBEngine.ExecQuery(dsQuery);
  finally
    dsQuery.Free;
  end;
end;

procedure TWikiModel.ParseObject(aLinkId: Integer; aPage: string);
var
  tx: string;
  LastKey: string;
  address: string;
  rows: TArray<string>;
  i,j: Integer;
  row: string;
  Lang: string;
  LinkId: Integer;
begin
  // title
  tx:=TParseTool.ParseByKey(aPage, 'class="infobox', '</tr>');
  tx:=TParseTool.ParseByKey(tx, '<tr>', '');
  tx:=TParseTool.CutBetween(tx, '<small>', '</small>');
  tx:=TParseTool.RemoveTags(tx);

  if Length(tx)=0 then
    begin
      tx:=TParseTool.ParseByKey(aPage, 'wgTitle":"', '"');
    end;

  FParser.AddData(aLinkId, 1, 'Title', tx);

  // описание
  LastKey:='';
  if Pos('<span class="mw-headline" id=".D0.9F.D1.80.D0.B8.D0.BC.D0.B5.D1.87.D0.B0.D0.BD.D0.B8.D1.8F">', aPage)>0 then
    LastKey:='<span class="mw-headline" id=".D0.9F.D1.80.D0.B8.D0.BC.D0.B5.D1.87.D0.B0.D0.BD.D0.B8.D1.8F">'
  else
  if Pos('<span class="mw-headline" id=".D0.98.D1.81.D1.82.D0.BE.D1.87.D0.BD.D0.B8.D0.BA.D0.B8">', aPage)>0 then
    LastKey:='<span class="mw-headline" id=".D0.98.D1.81.D1.82.D0.BE.D1.87.D0.BD.D0.B8.D0.BA.D0.B8">'
  else
  if Pos('<span class="mw-headline" id=".D0.A1.D1.81.D1.8B.D0.BB.D0.BA.D0.B8">', aPage)>0 then
    LastKey:='<span class="mw-headline" id=".D0.A1.D1.81.D1.8B.D0.BB.D0.BA.D0.B8">'
  else
  if Pos('<span class="mw-headline" id="See_also"', aPage)>0 then
    LastKey:='<span class="mw-headline" id="See_also"'
  else
  if Pos('<span class="mw-headline" id="References"', aPage)>0 then
    LastKey:='<span class="mw-headline" id="References"';

  if LastKey='' then LastKey:='NewPP limit report';

  tx:=TParseTool.ParseByKey(aPage, '<p><b>', LastKey);

  tx:=TParseTool.CutBetween(tx, '<div id="toctitle">', '</ul>'+#$A+'</div>'); // удаляем содержание
  tx:=TParseTool.CutBetween(tx, '(<span class="bday">', ')</span>');
  tx:=TParseTool.CutBetween(tx, '(<span class="dday"', ')</span>');
  tx:=TParseTool.CutBetween(tx, '<sup', '</sup>'); // сноски
  tx:=TParseTool.CutBetween(tx, '<span class="mw-editsection">', '>]'); // править

  tx:=TParseTool.RemoveTags(tx);
  FParser.AddData(aLinkId, 1, 'Description', tx);

  // адрес
  tx:=TParseTool.ParseByKey(aPage, 'Местоположение</th>', '</td>');
  if Length(tx)=0 then TParseTool.ParseByKey(aPage, 'Location</th>', '</td>');
  if Length(tx)>0 then
    begin
      address:=TParseTool.ParseByKey(tx, '<p>', '<');
      FParser.AddData(aLinkId, 1, 'Address', row);
      rows:=TParseTool.MultiParseByKey(tx,'title="','<');
      j:=0;
      for i := Length(rows)-1 downto 0 do
        begin
          inc(j);
          if j>2 then Break;

          row:=rows[i];
          row:=TParseTool.CutBetween(row,'>','');
          if j=1 then FParser.AddData(aLinkId, 1, 'Country', row);
          if j=2 then FParser.AddData(aLinkId, 1, 'City', row);
        end;
    end;

  // сайт
  tx:=TParseTool.ParseByKey(aPage, 'class="infobox', '</table>');
  rows:=TParseTool.MultiParseByKey(tx,'<a rel="nofollow" class="external text" href="','"');
  for row in rows do
    begin
      FParser.AddData(aLinkId, 1, 'Web', row);
    end;
  tx:=TParseTool.ParseByKeyReverse(aPage, '">Официальный сайт<', '"', 1);
  if Length(tx)>0 then FParser.AddData(aLinkId, 1, 'Web', tx);
  tx:=TParseTool.ParseByKeyReverse(aPage, '">Official website<', '"', 1);
  if Length(tx)>0 then FParser.AddData(aLinkId, 1, 'Web', tx);

  // ссылка на страницу на других языках
  tx:=TParseTool.ParseByKey(aPage, 'interlanguage-link interwiki-en', '</a>');
  if Length(tx)>0 then Lang:='en'
  else
    begin
      TParseTool.ParseByKey(aPage, 'interlanguage-link interwiki-ru', '</a>');
      if Length(tx)>0 then Lang:='ru'
    end;

  if Length(tx)>0 then
    begin
      tx:=TParseTool.ParseByKey(tx, 'href="', '"');
      tx:='https:'+tx;
      LinkId:=FParser.AddLink(3, tx, aLinkId, 1);
      FParser.AddData(LinkId, 1, 'Lang', Lang);
    end;

  // пишем в результирующую таблицу
  CustomerTableAddRecord(aLinkId);
end;

procedure TWikiModel.ParseObjectList(aLinkId: Integer; aPage: string);
var
  tx: string;
  Rows: TArray<string>;
  Row: string;
  i: Integer;
begin
  tx:=TParseTool.ParseByKey(aPage, 'class="mw-category"', '</div></div></div>');
  Rows:=TParseTool.MultiParseByKey(tx, '<a href="', '"');

  i:=0;
  for Row in Rows do
    begin
      Inc(i);
      tx:='https://ru.wikipedia.org'+Row;
      FParser.AddLink(2, tx, aLinkId, i);
    end;

  tx:=TParseTool.ParseByKeyReverse(aPage,'#mw-pages','"',2);
  if Length(tx)>0 then
    begin
      tx:='https://ru.wikipedia.org'+tx;
      FParser.AddLink(1, tx, aLinkId, 1);
    end;
end;

procedure TWikiModel.SetParseMethods(aLevel: Integer);
begin
  if aLevel=1 then FParseMethod:=ParseObjectList;
  if aLevel=2 then FParseMethod:=ParseObject;
  if aLevel=3 then FParseMethod:=ParseObject;
end;

procedure TWikiModel.SetStartLinks(aLinkID: integer);
var
  dsStartLinks: TFDQuery;
  i: integer;
begin
  dsStartLinks:=TFDQuery.Create(nil);
  try
    FDBEngine.GetData(dsStartLinks, 'select * from params_roman_wiki order by id');
    for i := 1 to dsStartLinks.RecordCount do
      begin
        FParser.AddLink(1, dsStartLinks.FieldByName('start_link').AsString, aLinkId, i);
        FParser.AddData(aLinkId, i, 'Lang', 'ru');
        FParser.AddData(aLinkId, i, 'Rubric', dsStartLinks.FieldByName('rubric').AsString);

        dsStartLinks.Next;
      end;
  finally
    dsStartLinks.Free
  end;
end;

procedure TWikiModel.InitParserData;
begin
  FData.AddOrSetValue('ParserName', 'roman_wiki');
  FData.AddOrSetValue('ZeroLink', 'https://www.wikipedia.org/');
end;

end.
