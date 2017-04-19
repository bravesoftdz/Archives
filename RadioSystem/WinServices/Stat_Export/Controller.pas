unit Controller;

interface

uses
   API_MVC
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
   API_DBases
  ,Model
  ,View
  ,Vcl.Forms;

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
  if aMessage='vmStartExport' then
    begin
      Self.FObjData.Add('MySQLEngine',FDBEngine);
      Self.CallModel(TStatExport);
    end;
end;

procedure TController.EventListener(EventName: string; EventData: TDictionary<System.string,System.Variant>);
begin
  if EventName='UpdateLabel' then
    begin
      frmView.lblNum.Caption:=EventData.Items['num'];
    end;
  Application.ProcessMessages;
end;

end.
