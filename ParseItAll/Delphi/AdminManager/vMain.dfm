object ViewMain: TViewMain
  Left = 0
  Top = 0
  Caption = 'ParseItAll! Admin Manager'
  ClientHeight = 290
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object statBar: TStatusBar
    Left = 0
    Top = 271
    Width = 554
    Height = 19
    Panels = <
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = 'user:'
        Width = 150
      end
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = 'ip:'
        Width = 50
      end>
  end
  object pnlJobs: TPanel
    Left = 0
    Top = 41
    Width = 554
    Height = 230
    Align = alClient
    TabOrder = 1
    object stgdJobs: TStringGrid
      Left = 1
      Top = 1
      Width = 552
      Height = 228
      Align = alClient
      ColCount = 2
      FixedCols = 0
      RowCount = 2
      TabOrder = 0
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 0
    Width = 554
    Height = 41
    Align = alTop
    TabOrder = 2
    object btnNewJob: TBitBtn
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btnAddJob'
      TabOrder = 0
      OnClick = btnNewJobClick
    end
  end
end