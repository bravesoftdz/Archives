unit vJob;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  API_MVC;

type
  TViewJob = class(TViewAbstract)
  private
    { Private declarations }
  protected
    procedure InitView; override;
  public
    { Public declarations }
  end;

var
  ViewJob: TViewJob;

implementation

{$R *.dfm}

procedure TViewJob.InitView;
begin
  ViewJob := Self;
end;

end.
