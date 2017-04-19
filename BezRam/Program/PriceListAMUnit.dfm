object PL_AM: TPL_AM
  Left = 342
  Top = 110
  BorderStyle = bsToolWindow
  Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
  ClientHeight = 554
  ClientWidth = 1020
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
    Left = 24
    Top = 445
    Width = 53
    Height = 13
    Caption = #1082#1072#1090#1077#1075#1086#1088#1080#1103
  end
  object Label2: TLabel
    Left = 248
    Top = 445
    Width = 72
    Height = 13
    Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label3: TLabel
    Left = 641
    Top = 445
    Width = 38
    Height = 13
    Caption = #1077#1076'.'#1080#1079#1084'.'
  end
  object Label4: TLabel
    Left = 704
    Top = 445
    Width = 49
    Height = 13
    Caption = #1094#1077#1085#1072', '#1088#1091#1073
  end
  object Label5: TLabel
    Left = 191
    Top = 504
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
    OnClick = Label5Click
    OnMouseEnter = Label5MouseEnter
    OnMouseLeave = Label5MouseLeave
  end
  object Label6: TLabel
    Left = 368
    Top = 504
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
    OnClick = Label6Click
    OnMouseEnter = Label6MouseEnter
    OnMouseLeave = Label6MouseLeave
  end
  object Label7: TLabel
    Left = 463
    Top = 504
    Width = 169
    Height = 13
    Caption = #1088#1072#1079#1088#1077#1096#1080#1090#1100' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1072#1081#1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label7Click
    OnMouseEnter = Label7MouseEnter
    OnMouseLeave = Label7MouseLeave
  end
  object Label8: TLabel
    Left = 775
    Top = 445
    Width = 51
    Height = 13
    Caption = #1094#1077#1085#1072', EUR'
  end
  object Label9: TLabel
    Left = 191
    Top = 523
    Width = 53
    Height = 13
    Caption = #1089#1086#1093#1088#1072#1085#1080#1090#1100
    Color = clBtnFace
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnClick = Label9Click
    OnMouseEnter = Label9MouseEnter
    OnMouseLeave = Label9MouseLeave
  end
  object Label10: TLabel
    Left = 264
    Top = 504
    Width = 79
    Height = 13
    Caption = #1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = Label10Click
    OnMouseEnter = Label10MouseEnter
    OnMouseLeave = Label10MouseLeave
  end
  object imgAM: TImage
    Left = 863
    Top = 48
    Width = 149
    Height = 161
  end
  object lblPix: TLabel
    Left = 904
    Top = 21
    Width = 67
    Height = 13
    Caption = #1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
  end
  object lblPixLink: TLabel
    Left = 856
    Top = 467
    Width = 150
    Height = 13
    Caption = #1089#1089#1099#1083#1082#1072' '#1085#1072' '#1092#1072#1081#1083' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lblPixLinkClick
    OnMouseEnter = lblPixLinkMouseEnter
    OnMouseLeave = lblPixLinkMouseLeave
  end
  object DBGrid1: TDBGrid
    Left = 191
    Top = 8
    Width = 666
    Height = 425
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
        FieldName = 'am_name'
        Title.Alignment = taCenter
        Title.Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 450
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'measure'
        Title.Alignment = taCenter
        Title.Caption = #1077#1076'.'#1080#1079#1084'.'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cost'
        Title.Alignment = taCenter
        Title.Caption = #1094#1077#1085#1072', '#1088#1091#1073
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cost_euro'
        Title.Alignment = taCenter
        Title.Caption = #1094#1077#1085#1072', EUR'
        Width = 60
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 32
    Top = 521
    Width = 75
    Height = 25
    Caption = #1087#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 904
    Top = 521
    Width = 75
    Height = 25
    Caption = #1079#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object DBEdit1: TDBEdit
    Left = 248
    Top = 464
    Width = 384
    Height = 21
    DataField = 'am_name'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 3
  end
  object DBComboBox2: TDBComboBox
    Left = 641
    Top = 464
    Width = 57
    Height = 21
    DataField = 'measure'
    DataSource = DataSource1
    Enabled = False
    Items.Strings = (
      #1087'.'#1084'.'
      #1096#1090'.'
      #1082#1074'.'#1084)
    TabOrder = 4
  end
  object DBEdit2: TDBEdit
    Left = 704
    Top = 464
    Width = 65
    Height = 21
    DataField = 'cost'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 5
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 464
    Width = 218
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object DBEdit3: TDBEdit
    Left = 775
    Top = 464
    Width = 66
    Height = 21
    DataField = 'cost_euro'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 7
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 8
    Width = 177
    Height = 425
    DataSource = DataSource2
    TabOrder = 8
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'am_category_name'
        Title.Alignment = taCenter
        Title.Caption = #1082#1072#1090#1077#1075#1086#1088#1080#1103
        Width = 140
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 304
    Top = 184
  end
  object DataSource2: TDataSource
    DataSet = FDQuery3
    Left = 104
    Top = 80
  end
  object FDQuery1: TFDQuery
    AfterScroll = FDQuery1AfterScroll
    Left = 240
    Top = 184
  end
  object FDQuery2: TFDQuery
    Left = 120
    Top = 456
  end
  object FDQuery3: TFDQuery
    AfterScroll = FDQuery3AfterScroll
    Left = 40
    Top = 80
  end
  object FDQuery4: TFDQuery
    Left = 184
    Top = 456
  end
  object dlgOpenPic: TOpenPictureDialog
    Left = 912
    Top = 416
  end
end
