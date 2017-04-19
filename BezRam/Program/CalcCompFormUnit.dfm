object CompPrice: TCompPrice
  Left = 293
  Top = 110
  BorderStyle = bsToolWindow
  Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1086#1074
  ClientHeight = 519
  ClientWidth = 891
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 650
    Top = 478
    Width = 43
    Height = 13
    Caption = #1091#1076#1072#1083#1080#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label1Click
    OnMouseEnter = Label1MouseEnter
    OnMouseLeave = Label1MouseLeave
  end
  object DBGrid1: TDBGrid
    Left = 2
    Top = 1
    Width = 887
    Height = 465
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'c_code'
        Title.Alignment = taCenter
        Title.Caption = 'code'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'component_en'
        Title.Alignment = taCenter
        Title.Caption = #1082#1086#1084#1087#1086#1085#1077#1085#1090' en'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'component_ru'
        Title.Alignment = taCenter
        Title.Caption = #1082#1086#1084#1087#1086#1085#1077#1085#1090' ru'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Mill_Finish'
        Title.Alignment = taCenter
        Title.Caption = 'Mill Finish'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'White'
        Title.Alignment = taCenter
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Dark_Oak'
        Title.Alignment = taCenter
        Title.Caption = 'Dark Oak'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Anod_Inox'
        Title.Alignment = taCenter
        Title.Caption = 'Anod Inox'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Anod_Silver'
        Title.Alignment = taCenter
        Title.Caption = 'Anod Silver'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Unit'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'price'
        Title.Alignment = taCenter
        Width = 50
        Visible = True
      end>
  end
  object Button2: TButton
    Left = 768
    Top = 486
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 48
    Top = 486
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 112
    Top = 80
  end
  object FDQuery1: TFDQuery
    Left = 40
    Top = 80
  end
end
