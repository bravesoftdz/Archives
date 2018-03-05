unit eRegister;

interface

uses
  API_ORM,
  eClient,
  eCommon,
  eContact;

type
  TRegister = class(TEntity)
  private
    FClRelList: TClientRelList;
    FContact: TContact;
    FContactID: Integer;
    FState: Integer;
    function GetClientRelList: TClientRelList;
  public
    class function GetStructure: TSructure; override;
    property ClRelList: TClientRelList read GetClientRelList;
  published
    property Contact: TContact read FContact write FContact;
    property ContactID: Integer read FContactID write FContactID;
    property State: Integer read FState write FState;
  end;

  TRegisterList = TEntityList<TRegister>;

implementation

function TRegister.GetClientRelList: TClientRelList;
begin
  if not Assigned(FClRelList) then
    FClRelList := TClientRelList.Create(Self);

  Result := FClRelList;
end;

class function TRegister.GetStructure: TSructure;
begin
  Result.TableName := 'REGISTERS';

  AddForeignKey(Result.ForeignKeyArr, 'CONTACT_ID', TContact, 'ID');
end;

end.
