unit eContact;

interface

uses
  API_ORM,
  eCommon;

type
  TContact = class(TEntity)
  private
    FEmail: string;
    FPhone: string;
  public
    class function GetStructure: TSructure; override;
  published
    property Email: string read FEmail write FEmail;
    property Phone: string read FPhone write FPhone;
  end;

implementation

class function TContact.GetStructure: TSructure;
begin
  Result.TableName := 'CONTACTS';
end;

end.
