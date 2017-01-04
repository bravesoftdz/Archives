object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Parse It All!'
  ClientHeight = 395
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblJobs: TLabel
    Left = 8
    Top = 2
    Width = 22
    Height = 13
    Caption = 'Jobs'
  end
  object lblZeroLink: TLabel
    Left = 287
    Top = 2
    Width = 43
    Height = 13
    Caption = 'Zero Link'
  end
  object btnStartJob: TButton
    Left = 638
    Top = 362
    Width = 75
    Height = 25
    Caption = 'btnStartJob'
    TabOrder = 0
    OnClick = btnStartJobClick
  end
  object dbgrdJobs: TDBGrid
    Left = 8
    Top = 18
    Width = 273
    Height = 81
    DataSource = dsJobs
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'caption'
        Title.Alignment = taCenter
        Width = 230
        Visible = True
      end>
  end
  object dbgrdLevels: TDBGrid
    Left = 8
    Top = 134
    Width = 320
    Height = 120
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dbgrdLinks: TDBGrid
    Left = 344
    Top = 110
    Width = 320
    Height = 120
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dbgrdRecords: TDBGrid
    Left = 344
    Top = 236
    Width = 320
    Height = 120
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dbgrdNodes: TDBGrid
    Left = 8
    Top = 260
    Width = 320
    Height = 120
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dbmmoZeroLink: TDBMemo
    Left = 287
    Top = 18
    Width = 426
    Height = 81
    DataField = 'zero_link'
    DataSource = dsJobs
    TabOrder = 6
  end
  object fdtblJobs: TFDTable
    UpdateOptions.UpdateTableName = 'jobs'
    TableName = 'jobs'
    Left = 184
    Top = 48
  end
  object dsJobs: TDataSource
    DataSet = fdtblJobs
    Left = 128
    Top = 48
  end
end
