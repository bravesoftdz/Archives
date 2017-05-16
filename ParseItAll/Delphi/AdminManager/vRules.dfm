object ViewRules: TViewRules
  Left = 0
  Top = 0
  Caption = 'Parse It All! Rules'
  ClientHeight = 349
  ClientWidth = 691
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
  object pnlBrowser: TPanel
    Left = 0
    Top = 0
    Width = 441
    Height = 349
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'pnlBrowser'
    TabOrder = 0
    object chrmBrowser: TChromium
      Left = 1
      Top = 1
      Width = 439
      Height = 347
      Align = alClient
      DefaultUrl = 'about:blank'
      TabOrder = 0
    end
  end
  object pnlControls: TPanel
    Left = 441
    Top = 0
    Width = 250
    Height = 349
    Align = alClient
    TabOrder = 1
    object pnlLevel: TPanel
      Left = 1
      Top = 1
      Width = 248
      Height = 40
      Align = alTop
      TabOrder = 0
      object lbllevel: TLabel
        Left = 119
        Top = 12
        Width = 25
        Height = 13
        Caption = 'Level'
      end
      object cbbLevel: TComboBox
        Left = 152
        Top = 8
        Width = 81
        Height = 21
        Style = csDropDownList
        TabOrder = 0
      end
      object btnAddLevel: TBitBtn
        Left = 15
        Top = 6
        Width = 75
        Height = 25
        Caption = 'btnAddL'
        TabOrder = 1
      end
    end
    object pnlTree: TPanel
      Left = 1
      Top = 41
      Width = 248
      Height = 184
      Align = alTop
      Caption = 'pnlTree'
      TabOrder = 1
      object tvTree: TTreeView
        Left = 1
        Top = 32
        Width = 246
        Height = 151
        Align = alBottom
        Indent = 19
        TabOrder = 0
      end
      object btnAG: TBitBtn
        Left = 8
        Top = 4
        Width = 33
        Height = 25
        Caption = 'btnAG'
        TabOrder = 1
        OnClick = btnAGClick
      end
    end
    object pnlFields: TPanel
      Left = 1
      Top = 225
      Width = 248
      Height = 123
      Align = alClient
      Caption = 'pnlFields'
      TabOrder = 2
      ExplicitTop = 216
      ExplicitHeight = 132
    end
  end
end
