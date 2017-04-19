inherited RomanView: TRomanView
  Caption = 'Roman Parsers'
  ExplicitWidth = 691
  ExplicitHeight = 325
  PixelsPerInch = 96
  TextHeight = 13
  inherited ParsersGrid: TStringGrid
    Top = -16
    ExplicitTop = -16
  end
  object btnStartConvertor: TButton
    Left = 560
    Top = 254
    Width = 91
    Height = 25
    Caption = 'Start Converter'
    TabOrder = 3
    OnClick = btnStartConvertorClick
  end
end
