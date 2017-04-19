object frmUser: TfrmUser
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  ClientHeight = 177
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblLogin: TLabel
    Left = 32
    Top = 19
    Width = 30
    Height = 13
    Caption = #1051#1086#1075#1080#1085
  end
  object lblName: TLabel
    Left = 32
    Top = 46
    Width = 19
    Height = 13
    Caption = #1048#1084#1103
  end
  object lblPass: TLabel
    Left = 32
    Top = 73
    Width = 37
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object lblAccess: TLabel
    Left = 32
    Top = 100
    Width = 37
    Height = 13
    Caption = #1044#1086#1089#1090#1091#1087
  end
  object dbedtLogin: TDBEdit
    Left = 176
    Top = 16
    Width = 179
    Height = 21
    Cursor = crDrag
    DataField = 'login'
    DataSource = frmUsers.dsrUsers
    TabOrder = 0
  end
  object dbedtName: TDBEdit
    Left = 176
    Top = 43
    Width = 179
    Height = 21
    DataField = 'name'
    DataSource = frmUsers.dsrUsers
    TabOrder = 1
  end
  object dbedtPass: TDBEdit
    Left = 176
    Top = 70
    Width = 179
    Height = 21
    DataField = 'password'
    DataSource = frmUsers.dsrUsers
    PasswordChar = '*'
    TabOrder = 2
  end
  object dbcbbAccess: TDBComboBox
    Left = 176
    Top = 97
    Width = 179
    Height = 21
    DataField = 'access'
    DataSource = frmUsers.dsrUsers
    Items.Strings = (
      #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
      #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088)
    TabOrder = 3
    OnChange = dbcbbAccessChange
  end
  object btnApply: TButton
    Left = 40
    Top = 144
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TButton
    Left = 272
    Top = 144
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 5
  end
end
