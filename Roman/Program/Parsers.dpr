program Parsers;

uses
  Vcl.Forms,
  _View in '_View.pas' {frmView},
  Controller in 'Controller.pas',
  API_MVC in '..\..\..\Libraries\API_MVC.pas',
  API_DBases in '..\..\..\Libraries\API_DBases.pas',
  API_Files in '..\..\..\Libraries\API_Files.pas',
  API_Types in '..\..\..\Libraries\API_Types.pas',
  API_Controls in '..\..\..\Libraries\API_Controls.pas' {frmJSONEdit},
  API_Threads in '..\..\..\Libraries\API_Threads.pas',
  Model_Wiki in 'Model_Wiki.pas',
  API_Parse in '..\..\..\Libraries\API_Parse.pas' {ViewParse},
  View in 'View.pas' {RomanView},
  Model_TripAdvisor in 'Model_TripAdvisor.pas',
  Model_2GIS in 'Model_2GIS.pas',
  API_Yandex in '..\..\..\Libraries\API_Yandex.pas',
  Model_Convertor in 'Model_Convertor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRomanView, RomanView);
  Application.Run;
end.
