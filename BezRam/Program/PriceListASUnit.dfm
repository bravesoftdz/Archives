object AS_PL: TAS_PL
  Left = 439
  Top = 110
  BorderStyle = bsToolWindow
  Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1091#1089#1083#1091#1075#1080' '#1055#1088#1072#1081#1089'-'#1083#1080#1089#1090
  ClientHeight = 449
  ClientWidth = 587
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
    Left = 128
    Top = 392
    Width = 49
    Height = 13
    Caption = #1076#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
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
  object Label2: TLabel
    Left = 216
    Top = 392
    Width = 43
    Height = 13
    Caption = #1091#1076#1072#1083#1080#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label2Click
    OnMouseEnter = Label2MouseEnter
    OnMouseLeave = Label2MouseLeave
  end
  object Label3: TLabel
    Left = 296
    Top = 392
    Width = 169
    Height = 13
    Caption = #1088#1072#1079#1088#1077#1096#1080#1090#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1072#1081#1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label3Click
    OnMouseEnter = Label3MouseEnter
    OnMouseLeave = Label3MouseLeave
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 571
    Height = 369
    DataSource = DataSource1
    ReadOnly = True
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
        FieldName = 'as_name'
        Title.Alignment = taCenter
        Title.Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'mesuare'
        Title.Alignment = taCenter
        Title.Caption = #1077#1076'.'#1080#1079#1084'.'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cost'
        Title.Alignment = taCenter
        Title.Caption = #1094#1077#1085#1072
        Width = 60
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 32
    Top = 416
    Width = 75
    Height = 25
    Caption = #1087#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 480
    Top = 416
    Width = 75
    Height = 25
    Caption = #1079#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 208
    Top = 120
  end
  object FDQuery1: TFDQuery
    Left = 144
    Top = 120
  end
end
