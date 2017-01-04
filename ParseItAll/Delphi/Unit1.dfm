object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Parse It All!'
  ClientHeight = 458
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
  object lbl1: TLabel
    Left = 616
    Top = 2
    Width = 30
    Height = 13
    Caption = 'Levels'
  end
  object lblRules: TLabel
    Left = 8
    Top = 110
    Width = 26
    Height = 13
    Caption = 'Rules'
  end
  object bvl1: TBevel
    Left = 8
    Top = 105
    Width = 705
    Height = 1
    Style = bsRaised
  end
  object lblLinks: TLabel
    Left = 152
    Top = 110
    Width = 23
    Height = 13
    Caption = 'Links'
  end
  object lblRecords: TLabel
    Left = 286
    Top = 110
    Width = 39
    Height = 13
    Caption = 'Records'
  end
  object lblNodes: TLabel
    Left = 8
    Top = 250
    Width = 30
    Height = 13
    Caption = 'Nodes'
  end
  object btnStartJob: TButton
    Left = 638
    Top = 425
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
    Left = 616
    Top = 18
    Width = 97
    Height = 81
    DataSource = dsLevels
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'level'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end>
  end
  object dbgrdLinks: TDBGrid
    Left = 152
    Top = 127
    Width = 127
    Height = 120
    DataSource = dslinks
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'level'
        Title.Alignment = taCenter
        Width = 70
        Visible = True
      end>
  end
  object dbgrdRecords: TDBGrid
    Left = 286
    Top = 127
    Width = 154
    Height = 120
    DataSource = dsRecords
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'key'
        Title.Alignment = taCenter
        Width = 110
        Visible = True
      end>
  end
  object dbgrdNodes: TDBGrid
    Left = 8
    Top = 265
    Width = 432
    Height = 185
    DataSource = dsNodes
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'tag'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'index'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tag_id'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'class'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end>
  end
  object dbmmoZeroLink: TDBMemo
    Left = 287
    Top = 18
    Width = 323
    Height = 81
    DataField = 'zero_link'
    DataSource = dsJobs
    TabOrder = 6
  end
  object dbgrdRules: TDBGrid
    Left = 8
    Top = 127
    Width = 137
    Height = 120
    DataSource = dsRules
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'container_offset'
        Title.Alignment = taCenter
        Width = 100
        Visible = True
      end>
  end
  object mmo1: TMemo
    Left = 453
    Top = 127
    Width = 260
    Height = 210
    TabOrder = 8
  end
  object btnParseNodes: TButton
    Left = 536
    Top = 343
    Width = 94
    Height = 25
    Caption = 'btnParseNodes'
    TabOrder = 9
    OnClick = btnParseNodesClick
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
  object fdtblLevels: TFDTable
    IndexName = 'job_id'
    MasterSource = dsJobs
    MasterFields = 'id'
    Left = 672
    Top = 48
  end
  object dsLevels: TDataSource
    DataSet = fdtblLevels
    Left = 624
    Top = 48
  end
  object fdtblRules: TFDTable
    IndexName = 'job_level_id'
    MasterSource = dsLevels
    MasterFields = 'id'
    Left = 64
    Top = 176
  end
  object dsRules: TDataSource
    DataSet = fdtblRules
    Left = 16
    Top = 176
  end
  object fdtblLinks: TFDTable
    IndexName = 'job_rule_id'
    MasterSource = dsRules
    MasterFields = 'id'
    Left = 224
    Top = 176
  end
  object dslinks: TDataSource
    DataSet = fdtblLinks
    Left = 176
    Top = 176
  end
  object fdtblRecords: TFDTable
    IndexName = 'job_rule_id'
    MasterSource = dsRules
    MasterFields = 'id'
    Left = 368
    Top = 176
  end
  object dsRecords: TDataSource
    DataSet = fdtblRecords
    Left = 304
    Top = 176
  end
  object dsNodes: TDataSource
    DataSet = fdtblNodes
    Left = 40
    Top = 352
  end
  object fdtblNodes: TFDTable
    IndexName = 'job_rule_id'
    MasterSource = dsRules
    MasterFields = 'id'
    Left = 96
    Top = 352
  end
end
