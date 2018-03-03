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

const
  rtPersonally = 1;
  rtParents = 2;
  rtDeputy = 3;

implementation

uses
  System.SysUtils;

function TClient.GetFullName: string;
begin
  Result := Format('%s %s', [FirstName, LastName]);
end;

class function TClient.GetStructure: TSructure;
begin
  Result.TableName := 'CLIENTS';
end;

end.
