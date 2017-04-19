unit Threads;

interface

uses
   System.SysUtils
  ,System.Classes
  ,System.JSON
  ,System.DateUtils
  ,Model
  ,API_Files;

type
  TStatEngineClass = class of TStatEngine;

  TProcThread = class(TThread)
  private
    { Private declarations }
    FLogFile: String;
    procedure OnStatInfoUpdated(Sender: TObject; EventData: TJSONObject);
    procedure ChangeState(State: String);
    function CheckScheduler(SettingsJSON: TJSONObject; LastExecTime: TDateTime): Boolean;
  protected
    procedure Execute; override;
  public
    ObjClass: TStatEngineClass;
    RowIndex: Integer;
    SettingFile: String;
    IsStartingNow: Boolean;
  end;

implementation

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure ProcThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;

    or

    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

uses MainForm;

{ ProcThread }
procedure TProcThread.ChangeState(State: string);
begin
  if State = 'Waiting' then
    Synchronize(procedure
      begin
        fMainForm.lvProcList.Items[RowIndex].SubItems.Strings[0]:='ожидание';
      end
    );
  if State = 'InProcess' then
    Synchronize(procedure
      begin
        fMainForm.lvProcList.Items[RowIndex].SubItems.Strings[0]:='в процессе';
        fMainForm.lvProcList.Items[RowIndex].SubItems.Strings[1]:=DateTimeToStr(Now);
      end
    );
  if State = 'Stopped' then
    begin
      Synchronize(procedure
        begin
          TFilesEngine.AppendToFile(FLogFile, DateTimeToStr(Now)+' '+'Процесс остановлен.');
          fMainForm.lvProcList.Items[RowIndex].SubItems.Strings[0]:='остановлен';
        end
      );
    end;

  if fMainForm.lvProcList.ItemIndex=RowIndex then fMainForm.ShowLogToControl(RowIndex);
end;

function TProcThread.CheckScheduler(SettingsJSON: TJSONObject; LastExecTime: TDateTime): Boolean;
var
  tx: string;
  nDay, nMonth, nYear, nHour, nMin, nSec, nMilli: Word;
  mHour, mMin: Word;
  lDay, lMonth, lYear, lHour, lMin, lSec, lMilli: Word;
begin
  result:=False;
  if SettingsJSON.GetValue('SchedulerMode').value='daily' then
    begin
      DecodeDateTime(Now, nYear, nMonth, nDay, nHour, nMin, nSec, nMilli);
      DecodeDateTime(LastExecTime, lYear, lMonth, lDay, lHour, lMin, lSec, lMilli);
      tx:=SettingsJSON.GetValue('SchedulerTime').value;
      mHour:=StrToInt(Copy(tx,1,2));
      mMin:=StrToInt(Copy(tx,4,2));
      if    (nHour=mHour)
        and (nMin=mMin)
        and (nDay>lDay)
      then Result:=True;
    end;
end;

procedure TProcThread.OnStatInfoUpdated(Sender: TObject; EventData: TJSONObject);
begin
  if Self.Terminated then TStatEngine(Sender).IsTerminated:=True;

  if EventData.GetValue('Log')<>nil then
    Synchronize(procedure
      begin
        TFilesEngine.AppendToFile(FLogFile, DateTimeToStr(Now)+' '+EventData.GetValue('Log').Value);
        if fMainForm.lvProcList.ItemIndex=RowIndex then
          fMainForm.ShowLogToControl(RowIndex);
      end
    );
  if EventData.GetValue('LastCheck')<>nil then
    Synchronize(procedure
      begin
        fMainForm.lvProcList.Items[RowIndex].SubItems.Strings[1]:=EventData.GetValue('LastCheck').Value;
      end
    );
  if EventData.GetValue('Records')<>nil then
    Synchronize(procedure
      begin
        fMainForm.lvProcList.Items[RowIndex].SubItems.Strings[2]:=EventData.GetValue('Records').Value;
      end
    );
  if EventData.GetValue('Current')<>nil then
    Synchronize(procedure
      begin
        fMainForm.lvProcList.Items[RowIndex].SubItems.Strings[3]:=EventData.GetValue('Current').Value;
      end
    );
end;

procedure TProcThread.Execute;
var
  ProcObj: TStatEngine;
  SettingsJSON: TJSONObject;
  LastExecTime: TDateTime;
  IsFirstExcute: Boolean;
begin
  { Place thread code here }

  // считываем настройки
  SettingsJSON:=TStatEngine.GetSettings(Self.SettingFile);
  FLogFile:=SettingsJSON.GetValue('LogFile').value;
  LastExecTime:=IncDay(Now,-1);

  try
    // создаём лог файл
    TFilesEngine.CreateFile(FLogFile);
    IsFirstExcute:=True;

    while not Self.Terminated do
      begin
        // установка state в ожидание
        Self.ChangeState('Waiting');

        // проверка расписания или немедленное 1-е исполнение
        if   (Self.CheckScheduler(SettingsJSON, LastExecTime))
          or (Self.IsStartingNow and IsFirstExcute)
        then
          begin
            // установка state в процессе
            Self.ChangeState('InProcess');

            ProcObj:=ObjClass.Create;
            try
              ProcObj.StatInfoUpdated:=Self.OnStatInfoUpdated;
              ProcObj.Excute(Self.SettingFile);
            finally
              ProcObj.Free;
              LastExecTime:=Now;
              IsFirstExcute:=False;
            end;
          end;
        Sleep(1000);
      end;
  finally
    SettingsJSON.Free;
    // установка state в остановлен
    Self.ChangeState('Stopped');
  end;
end;

end.
