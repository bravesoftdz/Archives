unit Controller;

interface

uses
   API_MVC
  ,API_DBases
  ,System.Generics.Collections;

type
  TController = class(TControllerAbstract)
  private
    procedure InitController; override;
    procedure PrepareModel(aMessage: string); override;
    procedure EventListener(EventName: string; EventData: TDictionary<string,variant>); override;
  end;

implementation

uses
   Model
  ,View
  ,Vcl.Forms;

procedure TController.EventListener(EventName: string; EventData: TDictionary<System.string,System.Variant>);
begin
  if EventName='UpdateLabel' then
    begin
      frmView.lblNum.Caption:=EventData.Items['num'];
    end;
  Application.ProcessMessages;
end;

procedure TController.InitController;
var
  ConnectFileName: string;
begin
  // подключаемся к БД MySQL
  ConnectFileName:='Settings\MySQL.ini';
  FDBEngine:=TMySQLEngine.Create;
  TMySQLEngine(FDBEngine).OpenConnection(ConnectFileName);
end;

procedure TController.PrepareModel(aMessage: string);
var
  MySQLEngine: TMySQLEngine;
begin
  if aMessage='vmStartImport' then
    begin
      Self.FObjData.Add('MySQLEngine',FDBEngine);
      Self.CallModel(TStatImport);
    end;
end;

end.
