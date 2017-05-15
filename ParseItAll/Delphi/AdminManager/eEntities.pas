unit eEntities;

interface

uses
  //System.Generics.Collections,
  Data.DB,
  API_ORM;

type
  TJob = class(TEntityAbstract)
  protected
    function GetCaption: string;
    procedure SetCaption(aValue: string);

    function GetZeroLink: string;
    procedure SetZeroLink(aValue: string);

    function GetUserID: integer;
    procedure SetUserID(aValue: integer);

    procedure InitFields; override;
  public
    class function GetTableName: string; override;
    property Caption: string read GetCaption write SetCaption;
    property ZeroLink: string read GetZeroLink write SetZeroLink;
    property UserID: Integer read GetUserID write SetUserID;
  end;

  //TJobList = TObjectList<TJob>;

implementation

function TJob.GetUserID: integer;
begin
  Result := FData.Items['USER_ID'];
end;

procedure TJob.SetUserID(aValue: integer);
begin
  FData.AddOrSetValue('USER_ID', aValue);
end;

procedure TJob.SetZeroLink(aValue: string);
begin
  FData.AddOrSetValue('ZERO_LINK', aValue);
end;

function TJob.GetZeroLink: string;
begin
  Result := FData.Items['ZERO_LINK'];
end;

procedure TJob.SetCaption(aValue: string);
begin
  FData.AddOrSetValue('CAPTION', aValue);
end;

function TJob.GetCaption;
begin
  Result := FData.Items['CAPTION'];
end;

class function TJob.GetTableName: string;
begin
  Result := 'Jobs';
end;

procedure TJob.InitFields;
begin
  AddField('user_id', ftInteger);
  AddField('caption', ftString);
  AddField('zero_link', ftString);
end;

end.
