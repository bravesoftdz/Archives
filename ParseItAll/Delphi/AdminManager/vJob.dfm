object ViewJob: TViewJob
  Left = 0
  Top = 0
  Caption = 'Parse It All! Job'
  ClientHeight = 290
  ClientWidth = 554
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
    Top = 33
    Width = 377
    Height = 257
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object chrmBrowser: TChromium
      Left = 1
      Top = 1
      Width = 375
      Height = 255
      Align = alClient
      DefaultUrl = 'about:blank'
      TabOrder = 0
      ExplicitLeft = 72
      ExplicitTop = 88
      ExplicitWidth = 100
      ExplicitHeight = 41
    end
  end
  object pnlURL: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 33
    Align = alTop
    TabOrder = 1
    object lblURL: TLabel
      Left = 45
      Top = 9
      Width = 16
      Height = 13
      Caption = 'url:'
    end
    object edtURL: TEdit
      Left = 67
      Top = 6
      Width = 422
      Height = 21
      TabOrder = 0
    end
    object btnNavigate: TBitBtn
      Left = 492
      Top = 4
      Width = 25
      Height = 25
      Caption = 'go'
      TabOrder = 1
      OnClick = btnNavigateClick
    end
  end
  object pnlFields: TPanel
    Left = 377
    Top = 33
    Width = 177
    Height = 257
    Align = alClient
    Caption = 'pnlFields'
    TabOrder = 2
    ExplicitLeft = 440
    ExplicitTop = 96
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
end