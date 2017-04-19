object frmUsers: TfrmUsers
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  ClientHeight = 490
  ClientWidth = 545
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lblAppend: TLabel
    Left = 16
    Top = 416
    Width = 49
    Height = 13
    Caption = #1076#1086#1073#1072#1074#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lblAppendClick
    OnMouseEnter = lblAppendMouseEnter
    OnMouseLeave = lblAppendMouseLeave
  end
  object lblEdit: TLabel
    Left = 88
    Top = 416
    Width = 79
    Height = 13
    Caption = #1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lblEditClick
    OnMouseEnter = lblEditMouseEnter
    OnMouseLeave = lblEditMouseLeave
  end
  object lblDelete: TLabel
    Left = 220
    Top = 416
    Width = 43
    Height = 13
    Caption = #1091#1076#1072#1083#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lblDeleteClick
    OnMouseEnter = lblDeleteMouseEnter
    OnMouseLeave = lblDeleteMouseLeave
  end
  object dbgrdUsers: TDBGrid
    Left = 8
    Top = 8
    Width = 529
    Height = 393
    DataSource = dsrUsers
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrdUsersTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'login'
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Alignment = taCenter
        Title.Caption = #1080#1084#1103
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'access'
        Title.Alignment = taCenter
        Title.Caption = #1076#1086#1089#1090#1091#1087
        Width = 100
        Visible = True
      end>
  end
  object btnApply: TButton
    Left = 39
    Top = 450
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = btnApplyClick
  end
  object btnCancel: TButton
    Left = 430
    Top = 450
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object dsrUsers: TDataSource
    DataSet = dsUsers
    Left = 128
    Top = 96
  end
  object dsUsers: TFDQuery
    CachedUpdates = True
    UpdateOptions.AssignedValues = [uvUpdateNonBaseFields]
    UpdateOptions.UpdateNonBaseFields = True
    UpdateObject = FDUpdateSQL
    Left = 72
    Top = 96
  end
  object FDUpdateSQL: TFDUpdateSQL
    Left = 72
    Top = 160
  end
end
