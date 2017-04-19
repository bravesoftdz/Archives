unit cntrMoneyRuller;

interface

uses
   Controller
  ,System.JSON;

type
  TMController = class(TMControllerAbstract)
  private
    procedure AuthState(aJSNRequest: TJSONObject);
    procedure SignOut(aJSNRequest: TJSONObject);
    procedure SignIn(aJSNRequest: TJSONObject);
    procedure GetExpenceBudget(aJSNRequest: TJSONObject);
    procedure GetAccounts(aJSNRequest: TJSONObject);
    procedure ControllerInit; override;
  public
    procedure ProcessViewMessage(aMessage: string); override;
  end;

  TCategory = record
    ID: integer;
    Title: string;
  end;

implementation

uses
   System.Classes
  ,System.SysUtils
  ,viewAuth
  ,viewBudget
  ,viewAccounts;

procedure TMController.GetAccounts(aJSNRequest: TJSONObject);
var
  jsnAccTypes: TJSONObject;
  jsnAccAccounts: TJSONArray;
  jsnAcc: TJSONObject;
  jsnPair: TJSONPair;
  jsnValue: TJSONValue;
  i: integer;
begin
  frmAccounts:=TfrmAccounts.Create(FMainForm);
  try
    jsnAccTypes:=aJSNRequest.GetValue('accounts') as TJSONObject;
    for jsnPair in jsnAccTypes do
      begin
        jsnAccAccounts:=TJSONArray(jsnPair.JsonValue);
        for jsnValue in jsnAccAccounts do
          begin
             jsnAcc:=TJSONObject(jsnValue);
             frmAccounts.mmo1.Lines.Add(jsnAcc.Values['acc_name'].Value);
          end;
      end;

    frmAccounts.ShowModal;
  finally
    frmAccounts.Free;
  end;
end;

procedure TMController.GetExpenceBudget(aJSNRequest: TJSONObject);
var
  Categories: TArray<TCategory>;
  Category: TCategory;
  jsnCategories: TJSONArray;
  jsnCat: TJSONValue;
begin
  jsnCategories := aJSNRequest.GetValue('expence_categories') as TJSONArray;
  for jsnCat in jsnCategories do
    begin
      Category.ID:=StrToInt(TJSONObject(jsnCat).GetValue('id').Value);
      Category.Title:=TJSONObject(jsnCat).GetValue('title').Value;

      Categories := Categories + [Category];
    end;

  frmBudget:=TfrmBudget.Create(FMainForm);
  try
    frmBudget.Categories:=Categories;
    frmBudget.ShowModal;
  finally
    frmBudget.Free;
  end;
end;

procedure TMController.SignIn(aJSNRequest: TJSONObject);
begin
  if aJSNRequest.GetValue('auth') is TJSONTrue then
    frmAuth.Close;
end;

procedure TMController.SignOut(aJSNRequest: TJSONObject);
begin
  if aJSNRequest.GetValue('auth') is TJSONFalse then
    begin
      frmAuth:=TfrmAuth.Create(FMainForm);
      try
        frmAuth.ShowModal;
      finally
        frmAuth.Free;
      end;
    end;
end;

procedure TMController.ProcessViewMessage(aMessage: string);
var
  PostData: TStringList;
begin
  if aMessage='GetAuthState' then
    begin
      ProcessRequest('/en/api/auth/getstate', AuthState);
    end;

  if aMessage='SignIn' then
    begin
      PostData:=TStringList.Create;
      try
        PostData.Add('login='+frmAuth.edtLogin.Text);
        PostData.Add('password='+frmAuth.edtPassword.Text);
        ProcessRequest('/en/api/auth/signin', SignIn, PostData);
      finally
        PostData.Free;
      end;
    end;

  if aMessage='SignOut' then
    begin
      ProcessRequest('/en/api/auth/signout', SignOut);
    end;

  if aMessage='ShowExpenceBudget' then
    begin
      ProcessRequest('/en/api/budget/expences', GetExpenceBudget);
    end;

  if aMessage='ShowAccounts' then
    begin
      ProcessRequest('/en/api/accounts', GetAccounts);
    end;
end;

procedure TMController.ControllerInit;
begin
  FDomen:='http://moneyruller';
end;

procedure TMController.AuthState(aJSNRequest: TJSONObject);
var
  isSigned: Boolean;
begin
  if aJSNRequest.GetValue('is_signed') is TJSONTrue then isSigned:=True
  else isSigned:=False;

  if not isSigned then
    begin
      frmAuth:=TfrmAuth.Create(FMainForm);
      try
        frmAuth.ShowModal;
      finally
        frmAuth.Free;
      end;
    end;
end;

end.
