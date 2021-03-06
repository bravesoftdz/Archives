unit Model_TripAdvisor;

interface

uses
   API_Parse
  ,API_Yandex;

type
  TTripAdvModel = class(TModelParse)
  // ������� ������
  private
    FTranslater: TYaTranslater;
    function CalcRedirectedURL(d: string): string;
    function GetOffset(a: integer): integer;
    procedure ParseCountries(aLinkId: Integer; aPage: string);
    procedure ParseCatLinks(aLinkId: Integer; aPage: string);
    procedure ParseRegions(aLinkId: Integer; aPage: string);
    procedure ParseObjectsList(aLinkId: Integer; aPage: string);
    procedure ParseObject(aLinkId: Integer; aPage: string);

  // ���������������� ������
  private
    procedure SetStartLinks(aLinkID: integer); override;
    procedure SetParseMethods(aLevel: Integer); override;
    procedure CustomerTableAddRecord(aLinkId: integer); override;
  protected
    procedure InitParserData; override;
    procedure DeinitParserData; override;
  end;

implementation

uses
   System.SysUtils
  ,System.Generics.Collections
  ,API_Files
  ,FireDAC.Comp.Client
  ,FireDAC.Stan.Param
  ,Data.DB
  ,Model_2GIS;

procedure TTripAdvModel.CustomerTableAddRecord(aLinkId: integer);
var
  tx, Content: string;
  level: Integer;
  dsQuery, dsContent: TFDQuery;
  Rubric: string;
  CustomFields: TDictionary<string,string>;
  TitleRU, TitleEN, TitleUN: string;
  CityRU, CityEN, CityUN: string;
begin
  CustomFields:=TDictionary<string,string>.Create;
  try
    Rubric:=FParser.GetValueByKey(aLinkId, 'Rubric', level);
    CustomFields.AddOrSetValue('category_identifier', Rubric);

    TitleRU:=FParser.GetValueByKey(aLinkId, 'ru_title', level);
    TitleEN:=FParser.GetValueByKey(aLinkId, 'en_title', level);
    TitleUN:=TitleEN;
    CustomFields.AddOrSetValue('ua_title', TitleUN);

    CityRU:=FParser.GetValueByKey(aLinkId, 'ru_city', level);
    CityEN:=FParser.GetValueByKey(aLinkId, 'en_city', level);
    CityUN:=FTranslater.Translate('uk', CityEN);
    CustomFields.AddOrSetValue('ua_city', CityUN);

    tx:=FParser.GetValueByKey(aLinkId, 'ru_address', level);
    CustomFields.AddOrSetValue('ua_address', tx);

    dsContent:=TFDQuery.Create(nil);
    try
      dsContent.SQL.Text:='select * from params_roman_ta where rubric=:rubric';
      dsContent.ParamByName('rubric').AsString:=Rubric;
      FDBEngine.OpenQuery(dsContent);

      Content:=FParser.GetValueByKey(aLinkId, 'ru_amenities', level);
      Content := dsContent.FieldByName('content_template_ru').AsString + #$A + Content;
      Content:=StringReplace(Content, '#Name', TitleRU, [rfReplaceAll, rfIgnoreCase]);
      Content:=StringReplace(Content, '#City', CityRU, [rfReplaceAll, rfIgnoreCase]);
      CustomFields.AddOrSetValue('ru_content', Content);

      Content:=FParser.GetValueByKey(aLinkId, 'en_amenities', level);
      Content := dsContent.FieldByName('content_template_en').AsString + #$A + Content;
      Content:=StringReplace(Content, '#Name', TitleEN, [rfReplaceAll, rfIgnoreCase]);
      Content:=StringReplace(Content, '#City', CityEN, [rfReplaceAll, rfIgnoreCase]);
      CustomFields.AddOrSetValue('en_content', Content);

      Content:=FParser.GetValueByKey(aLinkId, 'en_amenities', level);
      Content:=FTranslater.Translate('uk', Content);
      Content := dsContent.FieldByName('content_template_ua').AsString + #$A + Content;
      Content:=StringReplace(Content, '#Name', TitleUN, [rfReplaceAll, rfIgnoreCase]);
      Content:=StringReplace(Content, '#City', CityUN, [rfReplaceAll, rfIgnoreCase]);
      CustomFields.AddOrSetValue('ua_content', Content);
    finally
      dsContent.Free;
    end;

    tx:=FParser.GetValueByKey(aLinkId, 'ru_source', level);
    CustomFields.AddOrSetValue('ru_source', tx);
    tx:=FParser.GetValueByKey(aLinkId, 'en_source', level);
    CustomFields.AddOrSetValue('en_source', tx);
    CustomFields.AddOrSetValue('ua_source', tx);

    InsertToRomanTable(FDBEngine, FParser, aLinkId, CustomFields);
  finally
    CustomFields.Free;
  end;
end;

function TTripAdvModel.GetOffset(a: integer): integer;
begin
  Result:=-1;
  if (a >= 97) and (a <= 122) then Exit(a-61);
  if (a >= 65) and (a <= 90) then Exit(a-55);
  if (a >= 48) and (a <= 71) then Exit(a-48);
end;

function TTripAdvModel.CalcRedirectedURL(d: string): string;
var
  zz, q, x, z: TArray<string>;
  g: TArray<TArray<string>>;
  b, e: string;
  a, i: integer;
  f: Integer;
  h: string;
  CurrArray: TArray<string>;
begin
  zz := ['&', '=', 'p', '6', '?', 'H', '%', 'B', '.com', 'k', '9', '.html', 'n', 'M', 'r', 'www.', 'h', 'b', 't', 'a', '0', '/', 'd', 'O', 'j', 'http://', '_', 'L', 'i', 'f', '1', 'e', '-', '2', '.', 'N', 'm', 'A', 'l', '4', 'R', 'C', 'y', 'S', 'o', '+', '7', 'I', '3', 'c', '5', 'u', '0', 'T', 'v', 's', 'w', '8', 'P', '0', 'g', '0'];
  q := ['0', '__3F__', '0', 'Photos', '0', 'https://', '.edu', '*', 'Y', '>', '0', '0', '0', '0', '0', '0', '`', '__2D__', 'X', '<', 'slot', '0', 'ShowUrl', 'Owners', '0', '[', 'q', '0', 'MemberProfile', '0', 'ShowUserReviews', #39, 'Hotel', '0', '0', 'Expedia', 'Vacation', 'Discount', '0', 'UserReview', 'Thumbnail', '0', '__2F__', 'Inspiration', 'V', 'Map', ':', '@', '0', 'F', 'help', '0', '0', 'Rental', '0', 'Picture', '0', '0', '0', 'hotels', '0', 'ftp:'];
  x := ['0', '0', 'J', '0', '0', 'Z', '0', '0', '0', ';', '0', 'Text', '0', '(', 'x', 'GenericAds', 'U', '0', 'careers', '0', '0', '0', 'D', '0', 'members', 'Search', '0', '0', '0', 'Post', '0', '0', '0', 'Q', '0', '$', '0', 'K', '0', 'W', '0', 'Reviews', '0', ',', '__2E__', '0', '0', '0', '0', '0', '0', '0', '{', '}', '0', 'Cheap', ')', '0', '0', '0', '#', '.org'];
  z := ['0', 'Hotels', '0', '0', 'Icon', '0', '0', '0', '0', '.net', '0', '0', 'z', '0', '0', 'pages', '0', 'geo', '0', '0', '0', 'cnt', '~', '0', '0', ']', '|', '0', 'tripadvisor', 'Images', 'BookingBuddy', '0', 'Commerce', '0', '0', 'partnerKey', '0', 'area', '0', 'Deals', 'from', '\\', '0', 'urlKey', '0', #39, '0', 'WeatherUnderground', '0', 'MemberSign', 'Maps', '0', 'matchID', 'Packages', 'E', 'Amenities', 'Travel', '.htm', '0', '!', '^', 'G'];
  g := [zz, q, x, z];

  b:='';
  a:=0;
  for i := 0 to Length(d)-1 do
    begin
      inc(a);
      h := d[a];
      e := h;

      CurrArray:=[];
      if h='q' then CurrArray:=q;
      if h='x' then CurrArray:=x;
      if h='z' then CurrArray:=z;
      if h='' then CurrArray:=zz;

      if (Length(CurrArray)>0) and (a < Length(d)) then
        begin
            Inc(a);
            e := e + d[a];
        end
      else CurrArray:=zz;

      f := getOffset(Ord(d[a]));
      if (f < 0) {or (StrToIntDef(CurrArray[f], -1) <> -1)} then
        b := b + e
      else b := b + CurrArray[f];
    end;
  b:=TParseTool.ParseByKey(b,'',#0);
  Result:=b;
end;

procedure TTripAdvModel.ParseObject(aLinkId: Integer; aPage: string);
var
  Link: string;
  Lang: string;
  tx, url, purl, subtx: string;
  AltName, Name: string;
  CityField, CountryField, AddressField, AmenitiesField: string;
  phone: string;
  ObjId: string;
  email: string;
  level: Integer;
  address: string;
  ContRows, ARows: TArray<string>;
  ContRow, Row, Content: string;
  i, j: Integer;
begin
  // ����
  Link:=FParser.GetLinkById(aLinkId);
  if Pos('.ru', Link)>0 then Lang:='RU' else Lang:='EN';

  if Lang='RU' then
    begin
      CityField:='ru_city';
      CountryField:='ru_country';
      AddressField:='ru_address';
      AmenitiesField:='ru_amenities';
      FParser.AddData(aLinkId, 1, 'ru_source', FParser.GetLinkById(aLinkId));
    end;
  if Lang='EN' then
    begin
      CityField:='en_city';
      CountryField:='en_country';
      AddressField:='en_address';
      AmenitiesField:='en_amenities';
      FParser.AddData(aLinkId, 1, 'en_source', FParser.GetLinkById(aLinkId));
    end;

  ObjId:=FParser.GetValueByKey(aLinkId, 'ID', level);

  // name
  tx:=TParseTool.ParseByKey(aPage, '<h1 id="HEADING"', '</h1>');
  if Lang='EN' then
    begin
      tx:=TParseTool.ParseByKey(tx, '">', '');
      tx:=TParseTool.RemoveTags(tx);
    end
  else
    tx:=TParseTool.ParseByKey(tx, '</div>', '');
  if Pos('>',tx)>0 then AltName:=Trim(TParseTool.ParseByKey(tx,'>','<'));
  Name:=Trim(TParseTool.ParseByKey(tx,'','<'));
  if Lang='RU' then
    if AltName<>'' then FParser.AddData(aLinkId, 1, 'ru_title', AltName)
    else
      if Name<>'' then FParser.AddData(aLinkId, 1, 'ru_title', Name)
      else Exit;
  if Lang='EN' then
    if Name<>'' then FParser.AddData(aLinkId, 1, 'en_title', Name)
    else Exit;

  // �����
  tx:=Trim(TParseTool.ParseByKey(aPage, '<span class="geoName"', '<'));
  delete(tx,1,pos('>',tx));
  if tx<>'' then FParser.AddData(aLinkId, 1, CityField, tx);

  // �����
  address:=TParseTool.ParseByKey(aPage, 'property="streetAddress">', '<');
  tx:=TParseTool.ParseByKey(aPage, '<span class="extended-address">', '<');
  if tx<>'' then address:=tx+', '+address;
  tx:=FParser.GetValueByKey(aLinkId, CityField, level);
  if tx<>'' then
    begin
      if address<>'' then  address:=address+', ';
      address:=address+tx;
    end;
  tx:=TParseTool.ParseByKey(aPage, 'property="postalCode">', '<');
  if tx<>'' then address:=address+' '+tx;
  address:=address+', '+FParser.GetValueByKey(aLinkId, CountryField, level)+' ';
  FParser.AddData(aLinkId, 1, AddressField, address);

  if Lang='RU' then
    begin
      // url
      if Pos('ui_icon laptop fl icnLink', aPage)>0 then     // �����
        begin
          purl:=TParseTool.ParseByKey(aPage, 'URL_HOTEL|text|', '|');
          purl:=(StrToIntDef(purl,1)-1).ToString;
          url:=Format('https://www.tripadvisor.ru/ShowUrl?&excludeFromVS=false&odc=BusinessListingsUrl&d=%s&url=%s', [ObjId, purl]);
          tx:=FParser.GetRedirectedUrl(url);
          FParser.AddData(aLinkId, 1, 'site_url', tx);
        end;
      if FParser.GetValueByKey(aLinkId, 'Rubric', level)='Restaurants' then  // ���������
        begin
          tx:=TParseTool.ParseByKey(aPage, #39+'aHref'+#39+':'+#39, #39);
          purl:=CalcRedirectedURL(tx);
          if purl<>'' then
            begin
              url:='https://www.tripadvisor.ru'+purl;
              tx:=FParser.GetRedirectedUrl(url);
              tx:=StringReplace(tx, '#_=_', '', [rfReplaceAll, rfIgnoreCase]);
              FParser.AddData(aLinkId, 1, 'site_url', tx);
            end;
        end;

      // email
      if Pos('ui_icon email fl icnLink', aPage)>0 then
        begin
          tx:=TParseTool.ParseByKey(aPage, 'EMAIL|text|', '|');
          url:=Format('https://www.tripadvisor.ru/EmailHotel?detail=%s&isOfferEmail=false&overrideOfferEmail=&contactColumn=%s', [ObjId, tx]);
          tx:=FParser.GetHTMLByURL(url);
          email:=TParseTool.ParseByKey(tx, 'name="receiver" value="', '"');
          FParser.AddData(aLinkId, 1, 'email', email);
        end;
      if FParser.GetValueByKey(aLinkId, 'Rubric', level)='Restaurants' then  // ���������
        begin
          email:=TParseTool.ParseByKey(aPage, 'checkEmailAction'+#39+',event,this,'+#39, #39);
          if Length(email)>0 then FParser.AddData(aLinkId, 1, 'email', email);
        end;

      // phone
      if Pos('ui_icon phone fl icnLink', aPage)>0 then
        begin
          tx:=TParseTool.ParseByKey(aPage, 'ui_icon phone fl icnLink', 'document');
          phone:=TParseTool.ParseByKey(tx, 'a='+#39, #39);
          phone:=phone+Trim(TParseTool.ParseByKey(tx, 'a+='+#39, #39));
          phone:=phone+Trim(TParseTool.ParseByKey(tx, 'c='+#39, #39));
          phone:=phone+Trim(TParseTool.ParseByKey(tx, 'c+='+#39, #39));
          phone:=phone+Trim(TParseTool.ParseByKey(tx, 'b='+#39, #39));
          phone:=phone+Trim(TParseTool.ParseByKey(tx, 'b+='+#39, #39));
          FParser.AddData(aLinkId, 1, 'phone', phone);
        end;
    end;

  // ������
  if FParser.GetValueByKey(aLinkId, 'Rubric', level)='Restaurants' then
    begin
      tx:=TParseTool.ParseByKey(aPage, '<div class="additional_info">', '</div>'+#$A+'</div>');
      Content:=Trim(TParseTool.ParseByKey(tx, '<div class="title">', '<'));
      ARows := TParseTool.MultiParseByKey(tx, '<li>', '</li>');
      i:=0;
      for Row in ARows do
        begin
          Inc(i);
          subtx := Trim(TParseTool.RemoveTags(Row));
          subtx := StringReplace(subtx, #$A, ' ', [rfReplaceAll, rfIgnoreCase]);
          subtx := StringReplace(subtx, '&nbsp;&gt;&nbsp;', '>', [rfReplaceAll, rfIgnoreCase]);
          Content := Content + #$A + subtx;
        end;
      if (Pos('����� ��������:', tx)>0) or (Pos('Phone Number:', tx)>0) then
        begin
          phone:=TParseTool.ParseByKey(tx, '����� ��������:'+#$A+'<span>', '<');
          if Phone.IsEmpty then phone:=TParseTool.ParseByKey(tx, 'Phone Number:'+#$A+'<span>', '<');
          FParser.AddData(aLinkId, 1, 'phone', phone);
        end;

      tx:=TParseTool.ParseByKey(aPage, 'data-tab="TABS_DETAILS"', '</div> </div> </div>');
      Delete(tx,1,Pos('>',tx));

      ContRows:=TParseTool.MultiParseByKey(tx, '<div class="row">', '</div>'+#$A+'</div>');
      j:=0;
      for ContRow in ContRows do
        begin
          tx:=TParseTool.ParseByKey(ContRow, 'title">', '<');
          if Length(tx)>0 then
            begin
              inc(j);
              Content := Content + #$A + tx + ':';

              ARows := TParseTool.MultiParseByKey(ContRow, '<div', '</div>');
              i:=0;
              for Row in ARows do
                begin
                  Inc(i);
                  if i>1 then
                    begin
                      subtx:=Row;
                      Delete(subtx, 1, Pos('>', subtx));
                      subtx := Trim(TParseTool.RemoveTags(subtx));
                      subtx := StringReplace(subtx, #$A, ' ', [rfReplaceAll, rfIgnoreCase]);  // ������� ��������
                      subtx := ' ' + subtx;
                      if i>2 then subtx := ',' + subtx;
                      Content := Content + subtx;
                    end;
                end;
            end;
        end;
    end
  else
    begin
      tx:=TParseTool.ParseByKey(aPage, 'id="AMENITIES_TAB"', '</div> </div> </div>');
      Delete(tx,1,Pos('>',tx));
      subtx:=TParseTool.ParseByKey(tx,'additional_info reservation_info">','</dl>');
      tx:=StringReplace(tx, subtx, '', [rfReplaceAll, rfIgnoreCase]);
      Content:='';

      ContRows:=TParseTool.MultiParseByKey(tx, 'amenity_hdr', '</div>'+#$A+'</div>');
      for ContRow in ContRows do
        begin
          Content := Content + TParseTool.ParseByKey(ContRow, '>', '<') + ':';
          ARows := TParseTool.MultiParseByKey(ContRow, '<li>', '</li>');
          i:=0;
          for Row in ARows do
            begin
              Inc(i);
              subtx := Trim(TParseTool.RemoveTags(Row));
              subtx := ' ' + subtx;
              if i>1 then subtx := ',' + subtx;
              Content := Content + subtx;
            end;
          Content := Content + #$A;
        end;
      subtx := TParseTool.ParseByKey(tx, 'additional_info_amenities">', '');
      subtx := StringReplace(subtx, '</h3>', 'endstr', [rfReplaceAll, rfIgnoreCase]);  // ����� ��������
      subtx := StringReplace(subtx, '</div>', 'endstr', [rfReplaceAll, rfIgnoreCase]); // ����� ��������
      subtx := StringReplace(subtx, '</address>', 'endstr', [rfReplaceAll, rfIgnoreCase]); // ����� ��������
      subtx := Trim(TParseTool.RemoveTags(subtx));

      subtx := StringReplace(subtx, #$A, ' ', [rfReplaceAll, rfIgnoreCase]);           // ������� ��������
      subtx := StringReplace(subtx, '&#62;', '>', [rfReplaceAll, rfIgnoreCase]);       // ������ >
      subtx := StringReplace(subtx, #$20BD, '&#8381;', [rfReplaceAll, rfIgnoreCase]);  // ������ �����
      subtx := StringReplace(subtx, 'endstr', #$A, [rfReplaceAll, rfIgnoreCase]);      // ��������������� ��������
      subtx := StringReplace(subtx, #$A+' ', #$A, [rfReplaceAll, rfIgnoreCase]);       // ��������������� ��������
      subtx := StringReplace(subtx, ' '+#$A, #$A, [rfReplaceAll, rfIgnoreCase]);       // ��������������� ��������
      while Pos(#$A+#$A, subtx)>0 do subtx:=StringReplace(subtx,#$A+#$A,#$A,[rfReplaceAll, rfIgnoreCase]); // ��������������� ��������
      Content := Content + Trim(subtx);
    end;
  FParser.AddData(aLinkId, 1, AmenitiesField, Content);

  // ������ .COM
  if Lang='RU' then
    begin
      Link:=StringReplace(Link, '.ru', '.com', [rfReplaceAll, rfIgnoreCase]);
      FParser.AddLink(6, Link, aLinkId, 1);
    end;
end;

procedure TTripAdvModel.ParseObjectsList(aLinkId: Integer; aPage: string);
var
  Rubric, Link, Site, Geo: string;
  level, i: integer;
  Rows: TArray<string>;
  Row: String;
  ID: String;
begin
  Rubric:=FParser.GetValueByKey(aLinkId, 'Rubric', level);
  Site:=FParser.GetValueByKey(aLinkId, 'Site', level);
  Geo:=FParser.GetValueByKey(aLinkId, 'geo', level);
  i:=0;

  // ������ �� ������
  if Rubric = 'Hotels' then
    Rows:=TParseTool.MultiParseByKey(aPage, 'class="property_details', 'id="property_');
  if Rubric = 'Restaurants' then
    Rows:=TParseTool.MultiParseByKey(aPage, 'class="shortSellDetails', 'class="property');
  if Rubric = 'Attractions' then
    Rows:=TParseTool.MultiParseByKey(aPage, 'id="ATTR_ENTRY_', 'onclick=');

  for Row in Rows do
    begin
      if Pos('�������', Row) = 0 then
        begin
          Inc(i);
          Link:=Site+TParseTool.ParseByKey(Row, 'href="', '"');
          ID:=TParseTool.ParseByKey(Link, '-d', '-');
          if ID<>'' then
            begin
              FParser.AddLink(5, Link, aLinkId, i);
              FParser.AddData(aLinkId, i, 'ID', ID);
            end;
        end;
    end;

  // ������ �� ��������� ������
  if Pos('<link rel="next"', aPage)>0 then
    begin
      Link:=TParseTool.ParseByKey(aPage, '<link rel="next"', '.');
      Link:=Site+Copy(Link, 7, Length(Link));
      FParser.AddLink(4, Link, aLinkId, 1);
    end;
end;

procedure TTripAdvModel.ParseRegions(aLinkId: Integer; aPage: string);
var
  Site, Rubric, Geo: string;
  level, i, Offset: integer;
  Rows: TArray<string>;
  Row, tx, Link: string;
begin
  Site:=FParser.GetValueByKey(aLinkId, 'Site', level);
  Rubric:=FParser.GetValueByKey(aLinkId, 'Rubric', level);
  Geo:=FParser.GetValueByKey(aLinkId, 'geo', level);
  tx:=FParser.GetLinkById(aLinkId);
  tx:=TParseTool.ParseByKey(tx, '-oa', '');
  Offset:=StrToIntDef(tx, 0);

  if (Rubric = 'Hotels') or (Rubric = 'Restaurants') then
    Rows:=TParseTool.MultiParseByKey(aPage, '"geo_name">', '">');
  if Rubric = 'Attractions' then
    Rows:=TParseTool.MultiParseByKey(aPage, 'id="ATTR_ENTRY_', '</a>');

  i:=0;
  for Row in Rows do
    begin
      Inc(i);

      tx:=TParseTool.ParseByKey(Row, '-', '-');
      Link:=Site+'/'+Rubric+'-'+tx;
      FParser.AddLink(4, Link, aLinkId, i);
      FParser.AddData(aLinkId, i, 'geo', tx);
    end;

  // ����. �������� ������ ��������
  tx:='/'+Rubric+'-'+Geo+'-oa'+IntToStr(Offset+20);
   if Pos(tx, aPage)>0 then
    begin
      Inc(i);
      Link:=Site+tx;
      FParser.AddLink(3, Link, aLinkId, i);
    end;
end;

procedure TTripAdvModel.DeinitParserData;
begin
  FTranslater.Free;
end;

procedure TTripAdvModel.ParseCatLinks(aLinkId: Integer; aPage: string);
var
  Link: string;
  level: integer;
  Site: string;
  linkid: Integer;
begin
  Site:=FParser.GetValueByKey(aLinkId, 'Site', level);

  Link:=TParseTool.ParseByKey(aPage, 'HOTEL:{url:'+#39, #39);
  if Length(Link)>0 then
    begin
      Link:=Site+Link;
      FParser.AddLink(3, Link, aLinkId, 1);
      FParser.AddData(aLinkId, 1, 'Rubric', 'Hotels');
    end;

  Link:=TParseTool.ParseByKey(aPage, 'EATERY:{url:'+#39, #39);
  if Length(Link)>0 then
    begin
      Link:=Site+Link;
      linkid:=FParser.AddLink(3, Link, aLinkId, 2);
      FParser.AddData(aLinkId, 2, 'Rubric', 'Restaurants');
      FDBEngine.SetData('update links set handled=-100 where id='+IntToStr(linkid)); //Temp
    end;

  Link:=TParseTool.ParseByKey(aPage, 'ATTRACTION:{url:'+#39, #39);
  if Length(Link)>0 then
    begin
      Link:=Site+Link;
      linkid:=FParser.AddLink(3, Link, aLinkId, 3);
      FParser.AddData(aLinkId, 3, 'Rubric', 'Attractions');
      FDBEngine.SetData('update links set handled=-100 where id='+IntToStr(linkid)); //Temp
    end;
end;

procedure TTripAdvModel.ParseCountries(aLinkId: Integer; aPage: string);
var
  tx: string;
  Rows: TArray<string>;
  Row: string;
  Link: string;
  Site: string;
  i, level: integer;
begin
  Site:=FParser.GetValueByKey(aLinkId, 'Site', level);

  tx:=TParseTool.ParseByKey(aPage, 'class="world_destinations', '</div></DIV>');
  Rows:=TParseTool.MultiParseByKey(tx, 'href="', '<');

  i:=0;
  for Row in Rows do
    begin
      tx:=TParseTool.ParseByKey(Row, '-', '-');
      if length(tx)>3 then
        begin
          Inc(i);
          FParser.AddData(aLinkId, i, 'geo', tx);

          Link:=Site+TParseTool.ParseByKey(Row, '', '"');
          FParser.AddLink(2, Link, aLinkId, i);

          tx:=TParseTool.ParseByKey(Row, '>', '');
          FParser.AddData(aLinkId, i, 'ru_country', tx);

          tx:=FTranslater.Translate('uk', tx);
          FParser.AddData(aLinkId, i, 'ua_country', tx);

          tx:=TParseTool.ParseByKeyReverse(Row, '.html', '-', 1);
          tx:=StringReplace(tx, '_', ' ', [rfReplaceAll, rfIgnoreCase]);
          FParser.AddData(aLinkId, i, 'en_country', tx);
        end;
    end;
end;

procedure TTripAdvModel.SetParseMethods(aLevel: Integer);
begin
  if aLevel=1 then FParseMethod:=ParseCountries;
  if aLevel=2 then FParseMethod:=ParseCatLinks;
  if aLevel=3 then FParseMethod:=ParseRegions;
  if aLevel=4 then FParseMethod:=ParseObjectsList;
  if aLevel=5 then FParseMethod:=ParseObject;
  if aLevel=6 then FParseMethod:=ParseObject;
end;

procedure TTripAdvModel.SetStartLinks(aLinkID: integer);
begin
  FParser.AddLink(1, 'https://www.tripadvisor.ru/SiteIndex', aLinkId, 1);
  FParser.AddData(aLinkID, 1, 'Site', 'https://www.tripadvisor.ru');
end;

procedure TTripAdvModel.InitParserData;
begin
  FData.AddOrSetValue('ParserName', 'roman_tripadvisor');
  FData.AddOrSetValue('ZeroLink', 'https://www.tripadvisor.com/');
  FLevelForCustomerAddRecord:=6;

  FTranslater:=TYaTranslater.Create;
end;

end.
