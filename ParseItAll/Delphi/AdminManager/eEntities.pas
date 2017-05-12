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

    procedure InitFields; override;
  public
    class function GetTableName: string; override;
    property Caption: string read GetCaption write SetCaption;
    property ZeroLink: string read GetZeroLink write SetZeroLink;
  end;

  //TJobList = TObjectList<TJob>;

implementation

procedure TJob.SetZeroLink(aValue: string);
begin
  FData.AddOrSetValue('zero_link', aValue);
end;

function TJob.GetZeroLink;
begin
  Result := FData.Items['zero_link'];
end;

procedure TJob.SetCaption(aValue: string);
begin
  FData.AddOrSetValue('caption', aValue);
end;

function TJob.GetCaption;
begin
  Result := FData.Items['caption'];
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
