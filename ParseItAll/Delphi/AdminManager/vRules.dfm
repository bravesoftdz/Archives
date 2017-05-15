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
      ExplicitLeft = 88
      ExplicitTop = 112
      ExplicitWidth = 100
      ExplicitHeight = 41
    end
  end
  object pnlControls: TPanel
    Left = 441
    Top = 0
    Width = 250
    Height = 349
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 496
    ExplicitTop = 64
    ExplicitWidth = 185
    ExplicitHeight = 41
    object pnlLevel: TPanel
      Left = 1
      Top = 1
      Width = 248
      Height = 40
      Align = alTop
      TabOrder = 0
      object lbllevel: TLabel
        Left = 119
        Top = 11
        Width = 25
        Height = 13
        Caption = 'Level'
      end
      object cbbLevel: TComboBox
        Left = 152
        Top = 8
        Width = 81
        Height = 21
        TabOrder = 0
        Text = 'cbbLevel'
      end
      object btnAddLevel: TBitBtn
        Left = 15
        Top = 6
        Width = 75
        Height = 25
        Caption = 'btnAddLevel'
        TabOrder = 1
      end
    end
    object pnlTree: TPanel
      Left = 1
      Top = 41
      Width = 248
      Height = 144
      Align = alTop
      Caption = 'pnlTree'
      TabOrder = 1
      object tvTree: TTreeView
        Left = 1
        Top = 1
        Width = 246
        Height = 142
        Align = alClient
        Indent = 19
        TabOrder = 0
        ExplicitLeft = 48
        ExplicitTop = 40
        ExplicitWidth = 121
        ExplicitHeight = 97
      end
    end
    object pnlFields: TPanel
      Left = 1
      Top = 185
      Width = 248
      Height = 163
      Align = alClient
      Caption = 'pnlFields'
      TabOrder = 2
      ExplicitTop = 192
      ExplicitHeight = 156
    end
  end
end
