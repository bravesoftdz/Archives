unit eRegister;

interface

uses
  API_ORM,
  eCommon,
  eContact;

type
  TRegister = class(TEntity)
  private
    FContact: TContact;
    FContactID: Integer;
    FState: Integer;
  public
    class function GetStructure: TSructure; override;
  published
    property Contact: TContact read FContact write FContact;
    property ContactID: Integer read FContactID write FContactID;
    property State: Integer read FState write FState;
  end;

  TRegisterList = TEntityList<TRegister>;

implementation

class function TRegister.GetStructure: TSructure;
begin
  Result.TableName := 'REGISTERS';

  AddForeignKey(Result.ForeignKeyArr, 'CONTACT_ID', TContact, 'ID');
end;

end.
