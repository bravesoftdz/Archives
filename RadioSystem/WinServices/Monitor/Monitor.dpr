program Monitor;



uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {fMainForm},
  Model in 'Model.pas',
  Threads in 'Threads.pas',
  API_Files in '..\Libraries\API_Files.pas',
  SettingForm in 'SettingForm.pas' {frmSettings},
  API_Controls in '..\Libraries\API_Controls.pas' {frmJSONEdit},
  API_RS in '..\Libraries\API_RS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMainForm, fMainForm);
  Application.Run;
end.
