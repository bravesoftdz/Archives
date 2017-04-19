unit viewAccounts;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs
  ,View, FMX.Layouts, FMX.Memo;

type
  TfrmAccounts = class(TMViewAbstract)
    mmo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAccounts: TfrmAccounts;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

end.
