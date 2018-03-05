unit eClient;

interface

uses
  API_ORM,
  eCommon;

type
  TClient = class(TEntity)
  private
    FFirstName: string;
    FLastName: string;
    FPassportNumber: string;
    FRepresentedBy: Integer;
    function GetFullName: string;
  public
    class function GetStructure: TSructure; override;
    property FullName: string read GetFullName;
  published
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property PassportNumber: string read FPassportNumber write FPassportNumber;
    property RepresentedBy: Integer read FRepresentedBy write FRepresentedBy;
  end;

  TClientList = TEntityList<TClient>;

  TClientRel = class(TEntity)
  private
    FClient: TClient;
    FClientID: Integer;
    FNum: Integer;
    FRegisterID: Integer;
  public
    class function GetStructure: TSructure; override;
  published
    property Client: TClient read FClient write FClient;
    property ClientID: Integer read FClientID write FClientID;
    property Num: Integer read FNum write FNum;
    property RegisterID: Integer read FRegisterID write FRegisterID;
  end;

  TClientRelList = TEntityList<TClientRel>;

const
  rtPersonally = 1;
  rtParents = 2;
  rtDeputy = 3;

implementation

uses
  eRegister,
  System.SysUtils;

class function TClientRel.GetStructure: TSructure;
begin
  Result.TableName := 'CLIENT2REGISTER';

  AddForeignKey(Result.ForeignKeyArr, 'REGISTER_ID', TRegister, 'ID');
  AddForeignKey(Result.ForeignKeyArr, 'CLIENT_ID', TClient, 'ID');
end;

function TClient.GetFullName: string;
begin
  Result := Format('%s %s', [FirstName, LastName]);
end;

class function TClient.GetStructure: TSructure;
begin
  Result.TableName := 'CLIENTS';
end;

end.
