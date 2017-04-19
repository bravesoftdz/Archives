unit PriceListAMUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Data.Win.ADODB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, API_MVC, Vcl.ExtDlgs;

type
  TPL_AM = class(TViewAbstract)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    DBEdit1: TDBEdit;
    DBComboBox2: TDBComboBox;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox1: TComboBox;
    Label7: TLabel;
    DBEdit3: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    FDQuery3: TFDQuery;
    FDQuery4: TFDQuery;
    imgAM: TImage;
    lblPix: TLabel;
    lblPixLink: TLabel;
    dlgOpenPic: TOpenPictureDialog;
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Label5MouseEnter(Sender: TObject);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label6MouseEnter(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label7MouseEnter(Sender: TObject);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Label9MouseEnter(Sender: TObject);
    procedure Label9MouseLeave(Sender: TObject);
    procedure Label10MouseEnter(Sender: TObject);
    procedure Label10MouseLeave(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure FDQuery3AfterScroll(DataSet: TDataSet);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FDQuery1AfterScroll(DataSet: TDataSet);
    procedure lblPixLinkMouseEnter(Sender: TObject);
    procedure lblPixLinkMouseLeave(Sender: TObject);
    procedure lblPixLinkClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitMVC; override;
  public
    { Public declarations }
  end;

var
  PL_AM: TPL_AM;

implementation

{$R *.dfm}

uses MainFormUnit, Unit9, Controllers, Jpeg;

procedure TPL_AM.InitMVC;
begin
  FControllerClass:=TController;
end;

procedure TPL_AM.FDQuery1AfterScroll(DataSet: TDataSet);
var
  s: string;
begin
  if not FDQuery1.FieldByName('pix_link').IsNull then
    begin
      try
        s:='TempFiles\pic'+ExtractFileExt(FDQuery1.FieldByName('pix_link').AsString);
        if FileExists(s) then DeleteFile(s);
        MainForm.IdFTP.Get('изображения\'+FDQuery1.FieldByName('pix_link').AsString ,s);
        imgAM.Picture.LoadFromFile(s);
      except
        imgAM.Picture:=nil;
      end;
    end
  else imgAM.Picture:=nil;
end;

procedure TPL_AM.FDQuery3AfterScroll(DataSet: TDataSet);
var
sql:string;
begin
sql:='SELECT * FROM additional_materials WHERE am_category_id='+FDQuery3.FieldByName('id').AsString+' ORDER BY am_category_id, am_name';
FDQuery1.Close;
FDQuery1.SQL.Clear;
FDQuery1.SQL.Add(sql);
FDQuery1.Open;

combobox1.Text:=FDQuery3.FieldByName('am_category_name').AsString;
end;

procedure TPL_AM.Button1Click(Sender: TObject);
begin
if FDQuery1.State<>dsbrowse then FDQuery1.Post;
button2.Click;
end;

procedure TPL_AM.Button2Click(Sender: TObject);
begin
PL_AM.Close;
PL_AM.Release;
end;

procedure TPL_AM.DBComboBox1Change(Sender: TObject);
var
sql:string;
begin
sql:='SELECT id FROM am_categories WHERE am_category_name="'+ComboBox1.text+'"';
FDQuery2.Close;
FDQuery2.SQL.Clear;
FDQuery2.SQL.Add(sql);
FDQuery2.Open;

FDQuery1.FieldByName('am_category_id').AsString:=FDQuery2.FieldByName('id').AsString;
end;

procedure TPL_AM.DBGrid1TitleClick(Column: TColumn);
begin
  FDQuery1.IndexFieldNames:=Column.FieldName;
end;

procedure TPL_AM.FormActivate(Sender: TObject);
var
sql:string;
i:integer;
begin
  FDQuery1.Connection:=MainForm.Connection;
  FDQuery2.Connection:=MainForm.Connection;
  FDQuery3.Connection:=MainForm.Connection;
  FDQuery4.Connection:=MainForm.Connection;

sql:='SELECT * FROM am_categories ORDER BY am_category_name';
FDQuery2.Close;
FDQuery2.SQL.Clear;
FDQuery2.SQL.Add(sql);
FDQuery2.Open;
for I := 1 to FDQuery2.RecordCount do
  begin
  combobox1.Items.Add(FDQuery2.FieldByName('am_category_name').AsString);
  FDQuery2.Next;
  end;

sql:='SELECT * FROM am_categories ORDER BY am_category_name';
FDQuery3.Close;
FDQuery3.SQL.Clear;
FDQuery3.SQL.Add(sql);
FDQuery3.Open;
end;

procedure TPL_AM.Label10Click(Sender: TObject);
begin
PL_AM.ComboBox1.Enabled:=true;
PL_AM.DBEdit1.Enabled:=true;
PL_AM.DBComboBox2.Enabled:=true;
PL_AM.DBEdit2.Enabled:=true;
PL_AM.DBEdit3.Enabled:=true;

label5.Enabled:=false;
label10.Enabled:=false;
label6.Enabled:=false;
label9.Enabled:=true;
lblPixLink.Enabled:=True;

FDQuery1.Edit;
end;

procedure TPL_AM.Label10MouseEnter(Sender: TObject);
begin
Label10.Font.Style:=[fsUnderline];
end;

procedure TPL_AM.Label10MouseLeave(Sender: TObject);
begin
Label10.Font.Style:=[];
end;

procedure TPL_AM.Label5Click(Sender: TObject);
begin
PL_AM.ComboBox1.Enabled:=true;
PL_AM.DBEdit1.Enabled:=true;
PL_AM.DBComboBox2.Enabled:=true;
PL_AM.DBEdit2.Enabled:=true;
PL_AM.DBEdit3.Enabled:=true;

label5.Enabled:=false;
label10.Enabled:=false;
label6.Enabled:=false;
label9.Enabled:=true;
lblPixLink.Enabled:=True;

FDQuery1.Append;
FDQuery1.FieldByName('am_name').AsString:='введите название материала';
end;

procedure TPL_AM.Label5MouseEnter(Sender: TObject);
begin
Label5.Font.Style:=[fsUnderline];
end;

procedure TPL_AM.Label5MouseLeave(Sender: TObject);
begin
Label5.Font.Style:=[];
end;

procedure TPL_AM.Label6Click(Sender: TObject);
var
buttonSelected : Integer;
begin
buttonSelected := MessageDlg('Вы уверены?',mtConfirmation, mbOKCancel, 0);

if buttonSelected = mrOK then
  begin
  FDQuery1.Delete;
  end;

end;

procedure TPL_AM.Label6MouseEnter(Sender: TObject);
begin
Label6.Font.Style:=[fsUnderline];
end;

procedure TPL_AM.Label6MouseLeave(Sender: TObject);
begin
Label6.Font.Style:=[];
end;

procedure TPL_AM.Label7Click(Sender: TObject);
begin
mode:='PL_AM';
pl_pas:=tpl_pas.Create(nil);
pl_pas.ShowModal;
end;

procedure TPL_AM.Label7MouseEnter(Sender: TObject);
begin
Label7.Font.Style:=[fsUnderline];
end;

procedure TPL_AM.Label7MouseLeave(Sender: TObject);
begin
Label7.Font.Style:=[];
end;

procedure TPL_AM.Label9Click(Sender: TObject);
var
sql,count:string;
begin
PL_AM.ComboBox1.Enabled:=false;
PL_AM.DBEdit1.Enabled:=false;
PL_AM.DBComboBox2.Enabled:=false;
PL_AM.DBEdit2.Enabled:=false;
PL_AM.DBEdit3.Enabled:=false;

label5.Enabled:=true;
label10.Enabled:=true;
label6.Enabled:=true;
label9.Enabled:=false;
lblPixLink.Enabled:=false;

sql:='SELECT id, am_category_name FROM am_categories WHERE am_category_name="'+ComboBox1.text+'"';
FDQuery2.Close;
FDQuery2.SQL.Clear;
FDQuery2.SQL.Add(sql);
FDQuery2.Open;

if FDQuery2.RecordCount=0 then
  begin
  sql:='SELECT id FROM am_categories ORDER BY id DESC';
  FDQuery2.Close;
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(sql);
  FDQuery2.Open;
  count:=inttostr(FDQuery2.Fields[0].asinteger+1);

  sql:='INSERT INTO am_categories (am_category_name, id) VALUES ("'+ComboBox1.text+'", '+count+')';
  FDQuery2.Close;
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(sql);
  FDQuery2.ExecSQL;

  sql:='SELECT id, am_category_name FROM am_categories WHERE am_category_name="'+ComboBox1.text+'"';
  FDQuery2.Close;
  FDQuery2.SQL.Clear;
  FDQuery2.SQL.Add(sql);
  FDQuery2.Open;
  end;

sql:='SELECT id FROM additional_materials ORDER BY id DESC';
FDQuery4.Close;
FDQuery4.SQL.Clear;
FDQuery4.SQL.Add(sql);
FDQuery4.Open;
count:=inttostr(FDQuery4.Fields[0].asinteger+1);

FDQuery1.Edit;
FDQuery1.FieldByName('am_category_id').AsString:=FDQuery2.FieldByName('id').AsString;
FDQuery1.FieldByName('id').AsString:=count;
FDQuery1.Post;
end;

procedure TPL_AM.Label9MouseEnter(Sender: TObject);
begin
Label9.Font.Style:=[fsUnderline];
end;

procedure TPL_AM.Label9MouseLeave(Sender: TObject);
begin
Label9.Font.Style:=[];
end;

procedure TPL_AM.lblPixLinkClick(Sender: TObject);
var
  s: string;
begin
  if dlgOpenPic.Execute then
    begin
      try
        s:=ExtractFileName(dlgOpenPic.FileName);
        MainForm.IdFTP.Put(dlgOpenPic.FileName, 'изображения\'+s);

        FDQuery1.Edit;
        FDQuery1.FieldByName('pix_link').AsString:=s;
        FDQuery1AfterScroll(nil);
      except

      end;
    end;
end;

procedure TPL_AM.lblPixLinkMouseEnter(Sender: TObject);
begin
  lblPixLink.Font.Style:=[fsUnderline];
end;

procedure TPL_AM.lblPixLinkMouseLeave(Sender: TObject);
begin
  lblPixLink.Font.Style:=[];
end;

end.
