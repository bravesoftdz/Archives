unit Unit3;

interface

uses
  Classes,ComObj,ActiveX,ADODB,SysUtils,Windows,ComCtrls;

type
  fudcheck = class(TThread)
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

    procedure fudcheck.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ fudcheck }
procedure fudcheck.UpdateTrunc;
var
itm:TListItem;
begin
itm:=form1.ListView1.Items.Item[1];
itm.SubItems[1]:=inttostr(trunc);
end;

procedure fudcheck.UpdateLastTime;
var
itm:TListItem;
begin
itm:=form1.ListView1.Items.Item[1];
itm.SubItems[0]:=datetimetostr(now);
end;

procedure fudcheck.Execute;
var
ADOMySqlConnection:TADOConnection;
mysqlquery,mysqlquery2:tadoquery;
sql,next_date,signature_date,mask,tx,bts_number,repeater_number:string;
i:integer;
sr :TSearchRec;
begin
  { Place thread code here }
////////////////////////////////////////////////////////////////////////////////
////       »Ќ»÷»јЋ»«ј÷»я
trunc:=0;
Synchronize(UpdateLastTime);

CoInitialize(nil);
ADOMySqlConnection:=TADOConnection.Create(nil);
ADOMySqlConnection.ConnectionString:='Provider=MSDASQL.1;Password=123;Persist Security Info=True;User ID=anekrash;Data Source=mts_dbase;Initial Catalog=mts_dbase';
ADOMySqlConnection.LoginPrompt:=false;
mysqlquery:=tadoquery.Create(nil);
mysqlquery.Connection:=ADOMySqlConnection;
mysqlquery2:=tadoquery.Create(nil);
mysqlquery2.Connection:=ADOMySqlConnection;

mysqlquery.Close;
mysqlquery.SQL.Clear;
mysqlquery.SQL.Add('SET NAMES cp1251');
mysqlquery.ExecSQL;

sql:='SELECT *';
sql:=sql+' FROM formulars';
sql:=sql+' LEFT JOIN bts';
sql:=sql+' ON bts.id = formulars.bts_id';
sql:=sql+' LEFT JOIN repeaters';
sql:=sql+' ON repeaters.id = formulars.repeater_id';
sql:=sql+' WHERE';
sql:=sql+' TO_DAYS(NOW())-TO_DAYS(create_date) <= 365';
sql:=sql+' AND signed_date IS NULL';
sql:=sql+' AND to_lotus_date IS NOT NULL';

mysqlquery.Close;
mysqlquery.SQL.Clear;
mysqlquery.SQL.Add(sql);
mysqlquery.Open;

////////////////////////////////////////////////////////////////////////////////
for i:=1 to mysqlquery.RecordCount do
  begin
  inc(trunc);
  Synchronize(UpdateTrunc);

  bts_number:=mysqlquery.fieldbyname('bts_number').AsString;
  repeater_number:=mysqlquery.fieldbyname('repeater_number').AsString;
  if Length(bts_number)>0 then sql:='SELECT create_date FROM formulars WHERE bts_id="'+mysqlquery.fieldbyname('bts_id').AsString+'" AND create_date>'+mysqldatetype(mysqlquery.fieldbyname('create_date').AsString)+' ORDER BY id LIMIT 1';
  if Length(repeater_number)>0 then sql:='SELECT create_date FROM formulars WHERE repeater_id="'+mysqlquery.fieldbyname('repeater_id').AsString+'" AND create_date>'+mysqldatetype(mysqlquery.fieldbyname('create_date').AsString)+' ORDER BY id LIMIT 1';

  mysqlquery2.Close;
  mysqlquery2.SQL.Clear;
  mysqlquery2.SQL.Add(sql);
  mysqlquery2.Open;
  next_date:=mysqlquery2.Fields[0].AsString;
  if empty(next_date) then next_date:=datetostr(now);
  signature_date:='';

  tx:='XXX';
  if Length(bts_number)>0 then
    begin
    tx:=bts_number;
    mask:='\\store3\rps-develop\‘ормул€ры\'+tx+'*.*';
    end;
  if Length(repeater_number)>0 then
    begin
    tx:=repeater_number;
    mask:='\\store3\rps-develop\‘ормул€ры\*'+tx+'*.*';
    end;

  if findfirst (mask, faAnyFile, sr)=0 then
    begin
    repeat
    if (FileDateToDateTime(sr.Time)>=strtodatedef(mysqlquery.fieldbyname('create_date').AsString,0)) and (FileDateToDateTime(sr.Time)<strtodatedef(next_date,0)+1) then
      begin
      if (pos(tx+'.',sr.Name)>0) or (pos(tx+'_',sr.Name)>0) then
        begin

        if pos('_d',sr.Name)>0 then  // если в названии файла закодирована дата
          begin
          signature_date:=copy(sr.Name,pos('_d',sr.Name)+2,2)+'.'+copy(sr.Name,pos('_d',sr.Name)+4,2)+'.'+copy(sr.Name,pos('_d',sr.Name)+6,4);
          end
          else
          signature_date:=datetostr(FileDateToDateTime(sr.time));

        end;

      end;


    until FindNext(sr) <> 0;
    sysutils.FindClose(sr);
    end;

  if (not empty(signature_date)) and (empty(mysqlquery.fieldbyname('signed_date').AsString)) then
    begin
    sql:='UPDATE formulars SET signed_date='+mysqldatetype(signature_date)+' WHERE id="'+mysqlquery.fieldbyname('id').AsString+'"';
    mysqlquery2.Close;
    mysqlquery2.SQL.Clear;
    mysqlquery2.SQL.Add(sql);
    mysqlquery2.ExecSQL;
    end;

  mysqlquery.Next;
  end;

////////////////////////////////////////////////////////////////////////////////
mysqlquery.Free;
mysqlquery2.Free;
ADOMysqlConnection.Free;
CoUninitialize;
end;

end.
