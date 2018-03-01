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
  public
    class function GetStructure: TSructure; override;
  published
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property PassportNumber: string read FPassportNumber write FPassportNumber;
    property RepresentedBy: Integer read FRepresentedBy write FRepresentedBy;
  end;

const
  rtPersonally = 1;
  rtParents = 2;
  rtDeputy = 3;

implementation

class function TClient.GetStructure: TSructure;
begin
  Result.TableName := 'CLIENTS';
end;

end.
