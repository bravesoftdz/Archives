object frmMigrate: TfrmMigrate
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1052#1080#1075#1088#1072#1094#1080#1103' '#1076#1072#1085#1085#1099#1093' MSAccess->MySQL'
  ClientHeight = 133
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblTableName: TLabel
    Left = 8
    Top = 16
    Width = 46
    Height = 13
    Caption = #1058#1072#1073#1083#1080#1094#1072':'
  end
  object lblTableNameValue: TLabel
    Left = 72
    Top = 16
    Width = 89
    Height = 13
    Caption = 'lblTableNameValue'
  end
  object lblProcessed: TLabel
    Left = 8
    Top = 40
    Width = 66
    Height = 13
    Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1085#1086':'
  end
  object lblRecNum: TLabel
    Left = 82
    Top = 40
    Width = 14
    Height = 13
    Caption = 'RN'
  end
  object lblFrom: TLabel
    Left = 110
    Top = 40
    Width = 11
    Height = 13
    Caption = #1080#1079
  end
  object lblRecCount: TLabel
    Left = 136
    Top = 40
    Width = 14
    Height = 13
    Caption = 'RC'
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 67
    Width = 336
    Height = 17
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 269
    Top = 100
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 8
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object btnStart: TButton
    Left = 8
    Top = 100
    Width = 75
    Height = 25
    Caption = #1057#1090#1072#1088#1090
    TabOrder = 2
    OnClick = btnStartClick
  end
end
