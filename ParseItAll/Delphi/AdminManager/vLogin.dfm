object ViewLogin: TViewLogin
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'ParseItAll! Admin Manager Login'
  ClientHeight = 119
  ClientWidth = 260
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblLogin: TLabel
    Left = 15
    Top = 21
    Width = 25
    Height = 13
    Caption = 'Login'
  end
  object lblPassword: TLabel
    Left = 16
    Top = 49
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object edtLogin: TEdit
    Left = 69
    Top = 17
    Width = 172
    Height = 21
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 70
    Top = 45
    Width = 171
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnApply: TBitBtn
    Left = 72
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 2
    OnClick = btnApplyClick
  end
  object btnCancel: TBitBtn
    Left = 168
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = btnCancelClick
  end
end
