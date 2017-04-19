object Form1: TForm1
  Left = 439
  Top = 214
  BorderStyle = bsToolWindow
  Caption = 'dbase Scripts Scheduler'
  ClientHeight = 565
  ClientWidth = 562
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
  object ListView1: TListView
    Left = 8
    Top = 8
    Width = 545
    Height = 150
    Checkboxes = True
    Columns = <
      item
        Caption = #1089#1082#1088#1080#1087#1090
        Width = 150
      end
      item
        Caption = #1087#1086#1089#1083#1077#1076#1085#1077#1077' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077
        Width = 135
      end
      item
        Caption = #1090#1088#1072#1085#1082#1079#1072#1082#1094#1080#1103
        Width = 80
      end>
    Items.Data = {
      5C0000000200000000000000FFFFFFFFFFFFFFFF02000000000000000CD1EBEE
      E8204D6170496E666F000000000000FFFFFFFFFFFFFFFF020000000000000012
      D7E5EA20EFEEE4EFE8F1E0EDFBF520D4D3C40000FFFFFFFFFFFFFFFF}
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Button1: TButton
    Left = 32
    Top = 176
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 136
    Top = 176
    Width = 75
    Height = 25
    Caption = 'stop'
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 32
    Top = 224
    Width = 473
    Height = 305
    TabOrder = 3
  end
end
