object Form1: TForm1
  Left = 536
  Top = 340
  BorderStyle = bsToolWindow
  Caption = #1054#1090#1095#1105#1090#1099' '#1087#1086' '#1073#1102#1076#1078#1077#1090#1072#1084
  ClientHeight = 150
  ClientWidth = 399
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 98
    Top = 20
    Width = 58
    Height = 13
    Caption = #1074#1099#1073#1086#1088' '#1075#1086#1076#1072
  end
  object Button1: TButton
    Left = 48
    Top = 112
    Width = 75
    Height = 25
    Caption = #1089#1090#1072#1088#1090
    Enabled = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 168
    Top = 16
    Width = 89
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = ComboBox1Change
  end
  object Button2: TButton
    Left = 280
    Top = 112
    Width = 75
    Height = 25
    Caption = #1079#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object Database1: TDatabase
    AliasName = 'mts_dbase'
    DatabaseName = 'mts_dbase'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=root')
    SessionName = 'Default'
    Left = 16
    Top = 16
  end
  object Query1: TQuery
    DatabaseName = 'mts_dbase'
    Left = 48
    Top = 16
  end
  object Query2: TQuery
    DatabaseName = 'mts_dbase'
    Left = 48
    Top = 48
  end
  object Database2: TDatabase
    AliasName = 'msbase2'
    DatabaseName = 'mtssqlnet'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=anekrash')
    SessionName = 'Default'
    Left = 288
    Top = 16
  end
  object Query3: TQuery
    DatabaseName = 'msbase2'
    Left = 320
    Top = 16
  end
end
