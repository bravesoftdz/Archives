object CompCalc: TCompCalc
  Left = 390
  Top = 55
  BorderStyle = bsToolWindow
  Caption = #1042#1099#1095#1080#1089#1083#1077#1085#1080#1077' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1086#1074
  ClientHeight = 552
  ClientWidth = 805
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
    Left = 16
    Top = 8
    Width = 96
    Height = 13
    Caption = #1044#1083#1080#1085#1072' '#1089#1080#1089#1090#1077#1084#1099', '#1084#1084
  end
  object Label2: TLabel
    Left = 16
    Top = 35
    Width = 141
    Height = 13
    Caption = #1055#1086#1083#1085#1072#1103' '#1074#1099#1089#1086#1090#1072' '#1089#1080#1089#1090#1077#1084#1099', '#1084#1084
  end
  object Label3: TLabel
    Left = 16
    Top = 62
    Width = 79
    Height = 13
    Caption = #1062#1074#1077#1090' '#1087#1088#1086#1092#1080#1083#1077#1081
  end
  object Label4: TLabel
    Left = 16
    Top = 89
    Width = 75
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1087#1072#1085#1077#1083#1077#1081
  end
  object Label5: TLabel
    Left = 16
    Top = 136
    Width = 83
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1086#1090#1082#1088#1099#1090#1080#1081
  end
  object Label6: TLabel
    Left = 16
    Top = 163
    Width = 89
    Height = 13
    Caption = #1073#1086#1082#1086#1074#1086#1081' '#1087#1088#1086#1092#1080#1083#1100
  end
  object Label7: TLabel
    Left = 16
    Top = 190
    Width = 112
    Height = 13
    Caption = #1043#1091#1089#1090#1086#1090#1072' '#1080#1079' '#1089#1090#1077#1082#1083#1072', '#1084#1084
  end
  object Label8: TLabel
    Left = 16
    Top = 217
    Width = 154
    Height = 13
    Caption = #1059#1090#1086#1087#1083#1077#1085#1085#1072#1103' '#1085#1080#1078#1085#1103#1103' '#1085#1072#1082#1083#1072#1076#1082#1072
  end
  object Label9: TLabel
    Left = 16
    Top = 244
    Width = 62
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1091#1075#1083#1086#1074
  end
  object Label10: TLabel
    Left = 16
    Top = 271
    Width = 137
    Height = 13
    Caption = #1050#1086#1084#1087#1077#1085#1089#1080#1088#1091#1102#1097#1080#1081' '#1087#1088#1086#1092#1080#1083#1100
  end
  object Label11: TLabel
    Left = 16
    Top = 298
    Width = 81
    Height = 13
    Caption = #1042#1085#1077#1096'. '#1065#1077#1082#1086#1083#1076#1072
  end
  object Label12: TLabel
    Left = 16
    Top = 352
    Width = 92
    Height = 13
    Caption = #1042#1099#1073#1086#1088#1099' '#1079#1072#1082#1088#1099#1090#1080#1103
  end
  object Label13: TLabel
    Left = 16
    Top = 325
    Width = 29
    Height = 13
    Caption = #1079#1072#1084#1086#1082
  end
  object Label14: TLabel
    Left = 352
    Top = 479
    Width = 40
    Height = 13
    Caption = #1088#1072#1089#1089#1095#1105#1090
    Visible = False
    OnClick = Label14Click
  end
  object Label15: TLabel
    Left = 672
    Top = 491
    Width = 33
    Height = 13
    Caption = #1080#1090#1086#1075#1086':'
  end
  object Button1: TButton
    Left = 368
    Top = 519
    Width = 75
    Height = 25
    Caption = #1079#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 186
    Top = 5
    Width = 83
    Height = 21
    TabOrder = 1
    Text = '0'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 186
    Top = 32
    Width = 83
    Height = 21
    TabOrder = 2
    Text = '0'
    OnChange = Edit2Change
  end
  object ComboBox1: TComboBox
    Left = 186
    Top = 59
    Width = 147
    Height = 21
    TabOrder = 3
    OnChange = ComboBox1Change
    Items.Strings = (
      #1073#1077#1079
      'RAL 9010'
      #1076#1088#1077#1074#1077#1089#1080#1085#1072
      #1072#1085#1086#1076#1080#1088#1086#1074#1072#1085#1080#1077' inox'
      #1072#1085#1086#1076#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1077#1088#1077#1073#1088#1086)
  end
  object Edit3: TEdit
    Left = 186
    Top = 86
    Width = 83
    Height = 21
    TabOrder = 4
    Text = '0'
    OnChange = Edit3Change
  end
  object Edit4: TEdit
    Left = 186
    Top = 133
    Width = 83
    Height = 21
    TabOrder = 5
    Text = '0'
    OnChange = Edit4Change
  end
  object ComboBox2: TComboBox
    Left = 186
    Top = 160
    Width = 83
    Height = 21
    TabOrder = 6
    OnChange = ComboBox2Change
    Items.Strings = (
      #1076#1072
      #1085#1077#1090)
  end
  object ComboBox3: TComboBox
    Left = 186
    Top = 187
    Width = 83
    Height = 21
    TabOrder = 7
    OnChange = ComboBox3Change
    Items.Strings = (
      '6'
      '8'
      '10')
  end
  object ComboBox4: TComboBox
    Left = 186
    Top = 214
    Width = 83
    Height = 21
    TabOrder = 8
    OnChange = ComboBox4Change
    Items.Strings = (
      #1076#1072
      #1085#1077#1090)
  end
  object Edit5: TEdit
    Left = 186
    Top = 241
    Width = 83
    Height = 21
    TabOrder = 9
    Text = '0'
    OnChange = Edit5Change
  end
  object ComboBox5: TComboBox
    Left = 186
    Top = 268
    Width = 83
    Height = 21
    TabOrder = 10
    OnChange = ComboBox5Change
    Items.Strings = (
      #1076#1072
      #1085#1077#1090)
  end
  object ComboBox6: TComboBox
    Left = 186
    Top = 295
    Width = 83
    Height = 21
    TabOrder = 11
    OnChange = ComboBox6Change
    Items.Strings = (
      #1076#1072
      #1085#1077#1090)
  end
  object ComboBox7: TComboBox
    Left = 186
    Top = 322
    Width = 147
    Height = 21
    TabOrder = 12
    OnChange = ComboBox7Change
    Items.Strings = (
      #1082#1072#1073#1077#1083#1100
      #1056#1091#1095#1082#1072'-'#1082#1085#1086#1087#1082#1072' 1'
      #1056#1091#1095#1082#1072'-'#1082#1085#1086#1087#1082#1072' 2'
      #1047#1072#1084#1086#1082' '#1073#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1080)
  end
  object ComboBox8: TComboBox
    Left = 186
    Top = 349
    Width = 147
    Height = 21
    TabOrder = 13
    OnChange = ComboBox8Change
    Items.Strings = (
      #1085#1077#1090
      #1041#1083#1086#1082#1080#1088#1086#1074#1082#1072' '#1076#1083#1103' '#1076#1077#1090#1077#1081
      #1047#1072#1089#1086#1074)
  end
  object StringGrid1: TStringGrid
    Left = 352
    Top = 8
    Width = 445
    Height = 465
    DefaultColWidth = 85
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 3
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goThumbTracking]
    TabOrder = 14
  end
  object Edit6: TEdit
    Left = 724
    Top = 488
    Width = 73
    Height = 21
    Enabled = False
    TabOrder = 15
    Text = '0'
  end
  object FDQuery1: TFDQuery
    Left = 64
    Top = 424
  end
end
