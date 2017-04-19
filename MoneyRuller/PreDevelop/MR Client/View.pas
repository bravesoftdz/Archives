unit View;

interface

uses
   FMX.Forms
  ,System.Classes
  ,Controller;

type
  TMViewAbstract = class abstract(TForm)
  protected
    FControllerClass: TMControllerAbstractClass;
    FController: TMControllerAbstract;
    FisMainView: Boolean;
    procedure SendViewMessage(aMessage: string);
    procedure InitView; virtual;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    property Controller: TMControllerAbstract read FController;
  end;

implementation

procedure TMViewAbstract.InitView;
begin
  Position:=TFormPosition.ScreenCenter;
end;

constructor TMViewAbstract.Create(AOwner: TComponent);
begin
  inherited;
  InitView;

  // главная форма
  if Assigned(FControllerClass) then
    begin
      FController := FControllerClass.Create(Self);
      FisMainView:=True;
    end;

  // подчинённая форма
  if AOwner is TMViewAbstract then
    begin
      FController:=TMViewAbstract(AOwner).Controller;
      FisMainView:=False;
    end;
end;

destructor TMViewAbstract.Destroy;
begin
  if FisMainView and (Assigned(FController)) then FController.Free;
  inherited;
end;

procedure TMViewAbstract.SendViewMessage(aMessage: string);
begin
  FController.ProcessViewMessage(aMessage);
end;

end.
