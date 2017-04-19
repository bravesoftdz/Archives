object frmView: TfrmView
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'StatExport'
  ClientHeight = 79
  ClientWidth = 202
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lblNum: TLabel
    Left = 144
    Top = 29
    Width = 6
    Height = 13
    Caption = '0'
  end
  object btnStart: TButton
    Left = 24
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
end
