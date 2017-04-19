object PL_AKR: TPL_AKR
  Left = 537
  Top = 55
  Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090' '#1040#1050#1056#1048#1057#1058#1040#1051#1048#1071
  ClientHeight = 539
  ClientWidth = 522
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 168
    Top = 500
    Width = 169
    Height = 13
    Caption = #1088#1072#1079#1088#1077#1096#1080#1090#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1072#1081#1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label1Click
    OnMouseEnter = Label1MouseEnter
    OnMouseLeave = Label1MouseLeave
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 505
    Height = 481
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'height_meters'
        Title.Alignment = taCenter
        Title.Caption = #1074#1099#1089#1086#1090#1072' '#1087#1088#1086#1105#1084#1072
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'thick_6'
        Title.Alignment = taCenter
        Title.Caption = #1090#1086#1083#1097#1080#1085#1072' '#1089#1090#1077#1082#1083#1072' 6 '#1084#1084'.'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'thick_8'
        Title.Alignment = taCenter
        Title.Caption = #1090#1086#1083#1097#1080#1085#1072' '#1089#1090#1077#1082#1083#1072' 8 '#1084#1084'.'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'thick_10'
        Title.Alignment = taCenter
        Title.Caption = #1090#1086#1083#1097#1080#1085#1072' '#1089#1090#1077#1082#1083#1072' 10 '#1084#1084'.'
        Width = 120
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 24
    Top = 506
    Width = 75
    Height = 25
    Caption = #1087#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 424
    Top = 506
    Width = 75
    Height = 25
    Caption = #1079#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    DataSet = dsPriceList
    Left = 168
    Top = 72
  end
  object dsPriceList: TFDQuery
    Left = 88
    Top = 72
  end
end
