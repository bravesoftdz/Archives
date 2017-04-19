object Exchange: TExchange
  Left = 537
  Top = 219
  BorderStyle = bsToolWindow
  Caption = #1050#1091#1088#1089' '#1045#1074#1088#1086
  ClientHeight = 211
  ClientWidth = 386
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
    Left = 40
    Top = 48
    Width = 25
    Height = 13
    Caption = #1076#1072#1090#1072
  end
  object Label2: TLabel
    Left = 40
    Top = 96
    Width = 71
    Height = 13
    Caption = #1082#1091#1088#1089' EUR/RUR'
  end
  object Button1: TButton
    Left = 24
    Top = 168
    Width = 75
    Height = 25
    Caption = #1087#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 168
    Width = 75
    Height = 25
    Caption = #1086#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = Button2Click
  end
  object DateTimePicker1: TDateTimePicker
    Left = 145
    Top = 46
    Width = 121
    Height = 21
    Date = 41436.636856585650000000
    Time = 41436.636856585650000000
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 145
    Top = 93
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object FDQuery1: TFDQuery
    Left = 312
    Top = 72
  end
end
