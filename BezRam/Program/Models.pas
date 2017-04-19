unit Models;

interface

uses
   API_MVC
  ,API_DBases
  ,System.Generics.Collections;

type
  TAuthModel = class(TModelAbstract)
  public
    procedure Excute; override;
  end;

  TCustomersModel = class(TModelAbstract)
  public
    procedure Excute; override;
  end;

  TUsersModel = class(TModelAbstract)
  public
    procedure Excute; override;
  end;

implementation

uses
  FireDAC.Comp.Client;

procedure TUsersModel.Excute;
var
  dsQuery: TFDQuery;
  sql: string;
begin
  dsQuery:=FObjData.Items['FDQuery'] as TFDQuery;
  sql:='SELECT Id, login, password, name, access_type,'+
       ' CASE access_type'+
       '  WHEN 1 THEN "Администратор"'+
       '  ELSE "Пользователь"'+
       ' END AS access'+
       ' FROM users ORDER BY id';
  FDBEngine.GetData(dsQuery,sql);
end;

procedure TCustomersModel.Excute;
var
  dsCustomers: TFDQuery;
  sql: string;
begin
  dsCustomers:=FObjData.Items['FDQuery'] as TFDQuery;
  sql:='SELECT * FROM customers ORDER BY name';
  FDBEngine.GetData(dsCustomers,sql);
end;

procedure TAuthModel.Excute;
var
  sql: string;
  dsQuery: TFDQuery;
begin
  dsQuery:=TFDQuery.Create(nil);
  try
    sql:='SELECT * FROM users WHERE login='+TDBEngine.StrToSQL(FData.Items['login'])+' AND password='+TDBEngine.StrToSQL(FData.Items['password']);
    FDBEngine.GetData(dsQuery,sql);
    dsQuery.FetchAll;
    if not dsQuery.Eof then
      begin
       FEventData.Clear;
       FEventData.Add('user_id',dsQuery.FieldByName('id').AsString);
       FEventData.Add('login',dsQuery.FieldByName('login').AsString);
       FEventData.Add('user_name',dsQuery.FieldByName('name').AsString);
       FEventData.Add('access_type',dsQuery.FieldByName('access_type').AsInteger);
       Self.GenerateEvent('AuthOK');
      end
    else Self.GenerateEvent('AuthFail');
  finally
    dsQuery.Free;
  end;
end;

end.
