unit Controller;

interface

uses
  System.Generics.Collections
  ,API_Threads;

type
  TController = class(TControllerThread)
  private
    procedure InitController; override;
    procedure PrepareModel(aMessage: string); override;
    procedure EventListener(aEventName: string;
      aEventData: TDictionary<string, variant>); override;
  end;

implementation

uses
   Model_2GIS
  ,Model_TripAdvisor
  ,Model_Wiki
  ,Model_Convertor
  ,View
  ,API_DBases
  ,API_Parse
  ,Vcl.Forms
  ,System.SysUtils
  ,System.Threading
  ,System.Classes;

procedure TController.InitController;
var
  ConnectFileName: string;
begin
  // ����������� � ��
  ConnectFileName:='Settings\MySQL.ini';
  FDBEngine:=TMySQLEngine.Create;
  TMySQLEngine(FDBEngine).OpenConnection(ConnectFileName);
end;

procedure TController.PrepareModel(aMessage: string);
var
  ThreadsCount: Integer;
  ParserInfo: TParserInfo;
begin
  // ���������� � ����� �������
  if aMessage='GetParsersLastState' then
    begin
      for ParserInfo in RomanView.ParsersList do
        begin
          Self.FData.AddOrSetValue('ParserName', ParserInfo.Name);
          Self.FData.AddOrSetValue('ParserNum', ParserInfo.Num);
          CallModel(TParserStateModel);
        end;
    end;

  ThreadsCount:=16;

  if aMessage='start 2gis' then
    begin
      Self.FData.AddOrSetValue('ParserNum', 1);
      CallModelInThreads(ThreadsCount, T2GISModel, TController, aMessage);
      //if aMessage='stop 2gis' then FModel.IsStopped:=True;
    end;

  if aMessage='start tripadvisor' then
    begin
      Self.FData.AddOrSetValue('ParserNum', 2);
      //CallModelInThreads(ThreadsCount, TTAModel, TController, aMessage);
      CallModelInThreads(ThreadsCount, TTripAdvModel, TController, aMessage);
    end;

  if aMessage='start wiki' then CallModelInThreads(ThreadsCount, TWikiModel, TController, aMessage);

  if aMessage='start convertor' then CallModelInThreads(ThreadsCount, TConvertModel, TController, aMessage);

  if aMessage='grid update' then
    begin
      SendMessageToThreadModel(0, aMessage);
    end;
end;

procedure TController.EventListener(aEventName: string;
  aEventData: TDictionary<string, variant>);
var
  i: Integer;
begin
  {TThread.Synchronize(nil,
  procedure()
  begin}

    // ���������� ������� (�������) ������
    if aEventName='UpdateGrid' then
      begin
        RomanView.UpdateCountersInGrid(aEventData.Items['ParserNum'], aEventData.Items['LinkCount'], aEventData.Items['HandledCount']);
      end;

    {if aEventData.Items['ParserName']='roman_2gis' then i:=1;
    if aEventData.Items['ParserName']='roman_tripadvisor' then i:=2;

    if aEventName='UpdateGrid' then
      begin
        frmView.ParsersGrid.Cells[2,i]:=aEventData.Items['LinkCount'];
        frmView.ParsersGrid.Cells[3,i]:=aEventData.Items['HandledCount'];
      end;
    if aEventName='Complite' then
      begin
        frmView.ParsersGrid.Cells[1,1]:='���������';
        frmView.ParsersGridClick(nil);
      end;

    if aEventName='Stopped' then
      begin
        frmView.ParsersGrid.Cells[1,1]:='�����������';
        frmView.ParsersGridClick(nil);
      end;

  {end);}
end;

end.


