object AuthForm: TAuthForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
  ClientHeight = 114
  ClientWidth = 333
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
  object lblLogin: TLabel
    Left = 24
    Top = 19
    Width = 30
    Height = 13
    Caption = #1051#1086#1075#1080#1085
  end
  object lblPasw: TLabel
    Left = 24
    Top = 46
    Width = 37
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object edtLogin: TEdit
    Left = 92
    Top = 16
    Width = 209
    Height = 21
    TabOrder = 0
  end
  object edtPasw: TEdit
    Left = 92
    Top = 43
    Width = 209
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnApply: TButton
    Left = 136
    Top = 81
    Width = 75
    Height = 25
    Caption = #1042#1086#1081#1090#1080
    TabOrder = 2
    OnClick = btnApplyClick
  end
  object btnClose: TButton
    Left = 226
    Top = 81
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = btnCloseClick
  end
end
