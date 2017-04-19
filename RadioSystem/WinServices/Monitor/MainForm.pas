unit MainForm;

interface

uses
   System.Classes
  ,System.SysUtils
  ,System.JSON
  ,Vcl.StdCtrls
  ,Vcl.Controls
  ,Vcl.Forms
  ,Vcl.ComCtrls
  ,Vcl.Dialogs
  ,Winapi.Messages
  ,Threads
  ,Model
  ,API_Files
  ,SettingForm;

type
  TfMainForm = class(TForm)
    lvProcList: TListView;
    btnStartProc: TButton;
    redtLog: TRichEdit;
    btnStopProc: TButton;
    btnStartNow: TButton;
    btnSettings: TButton;
    btnStartAll: TButton;
    procedure btnStartProcClick(Sender: TObject);
    procedure lvProcListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnStopProcClick(Sender: TObject);
    procedure btnStartNowClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnStartAllClick(Sender: TObject);
  private
    { Private declarations }
    FSettingFiles: array of string;
    FClassName: array of TStatEngineClass;
    procedure StartProc(ClassName: TStatEngineClass; ItemIndex: Integer; SettingFile: String; isStartNow: Boolean = False);
    procedure ProcessInit;
  public
    { Public declarations }
    procedure ShowLogToControl(Index: Integer);
    procedure SetGUIOnProcStart;
    procedure SetGUIOnProcStop;
  end;

var
  fMainForm: TfMainForm;
  ProcStat: array of TProcThread;

implementation

{$R *.dfm}
procedure TfMainForm.SetGUIOnProcStart;
begin
  Self.btnStartProc.Enabled:=False;
  Self.btnStartNow.Enabled:=False;
  Self.btnStopProc.Enabled:=True;
  Self.btnSettings.Enabled:=False;
end;

procedure TfMainForm.SetGUIOnProcStop;
begin
  Self.btnStartProc.Enabled:=True;
  Self.btnStartNow.Enabled:=True;
  Self.btnStopProc.Enabled:=False;
  Self.btnSettings.Enabled:=True;
end;

procedure TfMainForm.ShowLogToControl(Index: Integer);
var
  Settings: TJSONObject;
begin
  Settings:=TStatEngine.GetSettings(FSettingFiles[Index]);
  try
    redtLog.Text:=TFilesEngine.GetTextFromFile(Settings.GetValue('LogFile').Value);
    redtLog.SetFocus;
    redtLog.SelStart:=redtLog.GetTextLen;
    redtLog.Perform(EM_SCROLLCARET,0,0);
  finally
    Settings.Free;
  end;
end;

procedure TfMainForm.ProcessInit;
begin
  // добавл€ть процессы здесь

  // abis
  FSettingFiles:=FSettingFiles+['Settings\abis.json'];
  FClassName:=FClassName+[TStatAbis];

  // trau
  FSettingFiles:=FSettingFiles+['Settings\trau.json'];
  FClassName:=FClassName+[TStatTRAU];

  // ce
  FSettingFiles:=FSettingFiles+['Settings\cehw.json'];
  FClassName:=FClassName+[TStatCEHW];

  // Delete Old BackUp Files
  FSettingFiles:=FSettingFiles+['Settings\delBF.json'];
  FClassName:=FClassName+[TProcDelFiles];

  SetLength(ProcStat,Length(FSettingFiles));

  // запуск по параметру
  if ParamCount>0 then
    if ParamStr(1)='startall' then btnStartAll.Click;
end;

procedure TfMainForm.btnStopProcClick(Sender: TObject);
begin
  try
    ProcStat[Self.lvProcList.ItemIndex].Terminate;
    ProcStat[Self.lvProcList.ItemIndex].WaitFor;
    Self.SetGUIOnProcStop;
  finally
    FreeAndNil(ProcStat[Self.lvProcList.ItemIndex]);
  end;
end;

procedure TfMainForm.FormCreate(Sender: TObject);
begin
  Self.ProcessInit;
end;

procedure TfMainForm.lvProcListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Assigned(ProcStat[Item.Index]) then
    begin
      ShowLogToControl(Item.Index);
      if not ProcStat[Item.Index].Started then SetGUIOnProcStop
      else SetGUIOnProcStart;
    end
  else SetGUIOnProcStop;
end;

procedure TfMainForm.StartProc(ClassName: TStatEngineClass; ItemIndex: Integer; SettingFile: String; isStartNow: Boolean = False);
begin
  if not Assigned(ProcStat[ItemIndex]) then
    begin
      ProcStat[ItemIndex]:=TProcThread.Create(True);
      ProcStat[ItemIndex].Priority:=tpNormal;
      ProcStat[ItemIndex].FreeOnTerminate:=False;
      ProcStat[ItemIndex].ObjClass:=ClassName;
      ProcStat[ItemIndex].RowIndex:=ItemIndex;
      ProcStat[ItemIndex].SettingFile:=SettingFile;
      ProcStat[ItemIndex].IsStartingNow:=isStartNow;
      ProcStat[ItemIndex].Start;
    end;
end;

procedure TfMainForm.btnSettingsClick(Sender: TObject);
var
  frmSetting: TfrmSettings;
  SettingFileName: string;
begin
  SettingFileName:=FSettingFiles[lvProcList.ItemIndex];
  frmSetting:=TfrmSettings.Create(Self, SettingFileName);
  try
    if frmSetting.ShowModal=mrOk then TFilesEngine.SaveTextToFile(SettingFileName, frmSetting.jsnSettings.ToJSON);
  finally
    frmSetting.Free;
  end;
end;

procedure TfMainForm.btnStartAllClick(Sender: TObject);
var
  i:Integer;
begin
for i := 0 to Length(FClassName)-1 do
  begin
    SetGUIOnProcStart;
    StartProc(
       FClassName[i]
      ,i
      ,FSettingFiles[i]
      ,False
    );
  end;
end;

procedure TfMainForm.btnStartNowClick(Sender: TObject);
begin
  SetGUIOnProcStart;
  StartProc(
     FClassName[lvProcList.ItemIndex]
    ,lvProcList.ItemIndex
    ,FSettingFiles[lvProcList.ItemIndex]
    ,True
  );
end;

procedure TfMainForm.btnStartProcClick(Sender: TObject);
begin
  SetGUIOnProcStart;
  StartProc(
     FClassName[lvProcList.ItemIndex]
    ,lvProcList.ItemIndex
    ,FSettingFiles[lvProcList.ItemIndex]
    ,False
  );
end;

end.
