unit Controllers;

interface

uses
   API_MVC
  ,API_DBases
  ,API_DBModels
  ,System.Generics.Collections
  ,System.Classes
  ,System.SysUtils
  ,Vcl.Forms;

type
  TController = class(TControllerAbstract)
  private
    procedure InitController; override;
    procedure PrepareModel(aMessage: string); override;
    procedure EventListener(EventName: string; EventData: TDictionary<string,variant>); override;
  public
    property DBEngine: TDBEngine read FDBEngine;
  end;

implementation

uses
  MigrateFormUnit;

procedure TController.InitController;
var
  ConnectFileName: string;
begin
  // указываем файл настроек
  FSettingFileName:='Settings\Settings.ini';

  // подключаемся к БД MySQL
  ConnectFileName:='Settings\MySQL.ini';
  FDBEngine:=TMySQLEngine.Create;
  TMySQLEngine(FDBEngine).OpenConnection(ConnectFileName);
end;

procedure TController.PrepareModel(aMessage: string);
var
  MSAccessEngine: TAccessEngine;
begin
  if aMessage='MigrateData' then
    begin
      MSAccessEngine:=TAccessEngine.Create;
      try
        MSAccessEngine.OpenConnection(GetCurrentDir+'\'+Self.FSettings.Values['ImportAccessTable']);
        Self.FObjData.Add('Source',MSAccessEngine);
        Self.FObjData.Add('Destination',Self.FDBEngine);
        Self.FData.Add('RulesFileName',Self.FSettings.Values['RulesFileName']);
        Self.FData.Add('PreScriptFileName',Self.FSettings.Values['PreScriptFileName']);
        Self.FData.Add('PostScriptFileName',Self.FSettings.Values['PostScriptFileName']);
        Self.CallModel(TDataMigrate);
      finally
        MSAccessEngine.Free;
      end;
    end;
end;

procedure TController.EventListener(EventName: string; EventData: TDictionary<System.string,System.Variant>);
begin
  if EventName='SetTableName' then
    begin
      frmMigrate.lblTableNameValue.Caption:=EventData.Items['TableName'];
    end;

  if EventName='SetRecCount' then
    begin
      frmMigrate.lblRecCount.Caption:=IntToStr(EventData.Items['RecCount']);
      frmMigrate.ProgressBar.Max:=EventData.Items['RecCount'];
      frmMigrate.ProgressBar.Position:=0;
      frmMigrate.ProgressBar.Step:=1;
    end;

  if EventName='SetRecNum' then
    begin
      frmMigrate.lblRecNum.Caption:=IntToStr(EventData.Items['RecNum']);
      frmMigrate.ProgressBar.StepIt;
    end;

  Application.ProcessMessages;
end;

end.
