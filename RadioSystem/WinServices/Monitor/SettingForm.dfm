object frmSettings: TfrmSettings
  Left = 293
  Top = 110
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 510
  ClientWidth = 466
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object pnlJSONTree: TPanel
    Left = 8
    Top = 8
    Width = 450
    Height = 449
    BevelOuter = bvNone
    Caption = 'pnlJSONTree'
    Color = clSkyBlue
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
  end
  object btnOk: TBitBtn
    Left = 24
    Top = 472
    Width = 75
    Height = 25
    Caption = 'Save'
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TBitBtn
    Left = 367
    Top = 472
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
