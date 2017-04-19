object Form1: TForm1
  Left = 840
  Top = 342
  BorderStyle = bsToolWindow
  Caption = 'FUD Create'
  ClientHeight = 138
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 32
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 40
    Top = 88
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 216
    Top = 88
    Width = 75
    Height = 25
    Caption = 'close'
    TabOrder = 2
    OnClick = Button2Click
  end
end
