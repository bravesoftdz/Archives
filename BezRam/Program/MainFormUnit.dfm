object MainForm: TMainForm
  Left = 244
  Top = 0
  Caption = 'BezRam Network v.1.1'
  ClientHeight = 548
  ClientWidth = 889
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnResize = FormResize
  DesignSize = (
    889
    548)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 89
    Height = 25
    Caption = #1053#1086#1074#1099#1081' '#1079#1072#1082#1072#1079
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 87
    Width = 89
    Height = 25
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 16
    Top = 118
    Width = 89
    Height = 25
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 149
    Width = 89
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 3
    OnClick = Button4Click
  end
  object DBGrid1: TDBGrid
    Left = 128
    Top = 18
    Width = 753
    Height = 505
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = sourceOrders
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'order_date'
        Title.Alignment = taCenter
        Title.Caption = #1076#1072#1090#1072
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'contract_num'
        Title.Alignment = taCenter
        Title.Caption = #1085#1086#1084'. '#1076#1086#1075#1086#1074#1086#1088#1072
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'type'
        Title.Alignment = taCenter
        Title.Caption = #1090#1080#1087' '#1082#1083#1080#1077#1085#1090#1072
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Alignment = taCenter
        Title.Caption = #1080#1084#1103'/'#1085#1072#1079#1074#1072#1085#1080#1077
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'address'
        Title.Alignment = taCenter
        Title.Caption = #1072#1076#1088#1077#1089
        Width = 230
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'order_total_cost'
        Title.Alignment = taCenter
        Title.Caption = #1048#1090#1086#1075#1086
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'login'
        Title.Alignment = taCenter
        Title.Caption = #1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
        Width = 50
        Visible = True
      end>
  end
  object Button5: TButton
    Left = 16
    Top = 496
    Width = 89
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1093#1086#1076
    TabOrder = 5
    OnClick = Button5Click
  end
  object statConnectInfo: TStatusBar
    Left = 0
    Top = 529
    Width = 889
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Text = #1053#1077' '#1072#1074#1090#1086#1088#1080#1079#1086#1074#1072#1085
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 192
    object N1: TMenuItem
      Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090#1099
      object N3: TMenuItem
        Caption = #1040#1082#1088#1080#1089#1090#1072#1083#1080#1103
        OnClick = N3Click
      end
      object N8: TMenuItem
        Caption = #1054#1087#1090#1086#1074#1099#1081
        OnClick = N8Click
      end
      object N4: TMenuItem
        Caption = #1044#1086#1087'. '#1084#1072#1090#1077#1088#1080#1072#1083#1099
        OnClick = N4Click
      end
      object N5: TMenuItem
        Caption = #1044#1086#1087'. '#1091#1089#1083#1091#1075#1080
        OnClick = N5Click
      end
    end
    object N2: TMenuItem
      Caption = #1064#1072#1073#1083#1086#1085#1099' ('#1095#1090#1077#1085#1080#1077')'
      object N9: TMenuItem
        Caption = #1076#1086#1075#1086#1074#1086#1088' '#1092#1080#1079'.'#1083#1080#1094#1086
        OnClick = N9Click
      end
      object N10: TMenuItem
        Caption = #1076#1086#1075#1086#1074#1086#1088' '#1102#1088'. '#1083#1080#1094#1086
        OnClick = N10Click
      end
      object N11: TMenuItem
        Caption = #1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' 1'
        OnClick = N11Click
      end
      object N21: TMenuItem
        Caption = #1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' 2'
        OnClick = N21Click
      end
      object N31: TMenuItem
        Caption = #1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' 3'
        OnClick = N31Click
      end
      object N12: TMenuItem
        Caption = #1072#1082#1090' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1090#1086#1074#1072#1088#1072
        OnClick = N12Click
      end
      object N13: TMenuItem
        Caption = #1072#1082#1090' '#1087#1088#1080#1105#1084#1072'-'#1087#1077#1088#1077#1076#1072#1095#1080
        OnClick = N13Click
      end
      object N14: TMenuItem
        Caption = #1072#1082#1090' '#1087#1088#1080#1105#1084#1072' '#1088#1072#1073#1086#1090
        OnClick = N14Click
      end
      object N6: TMenuItem
        Caption = #1082#1086#1084#1084#1077#1088#1095#1077#1089#1082#1086#1077' '#1087#1088#1077#1076#1083#1086#1078#1077#1085#1080#1077
        OnClick = N6Click
      end
      object N15: TMenuItem
        Caption = #1089#1095#1105#1090
        OnClick = N15Click
      end
      object N16: TMenuItem
        Caption = #1087#1088#1080#1093#1086#1076#1085#1086#1081' '#1086#1088#1076#1077#1088
        OnClick = N16Click
      end
    end
    object Euro1: TMenuItem
      Caption = #1050#1091#1088#1089' Euro'
      OnClick = Euro1Click
    end
    object N7: TMenuItem
      Caption = #1056#1072#1089#1095#1105#1090#1099
      object N17: TMenuItem
        Caption = #1055#1088#1072#1081#1089'-'#1083#1080#1089#1090' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1086#1074
        OnClick = N17Click
      end
      object Excel1: TMenuItem
        Caption = #1042#1099#1095#1080#1089#1083#1077#1085#1080#1077' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1086#1074
        OnClick = Excel1Click
      end
      object N18: TMenuItem
        Caption = #1042#1099#1095#1080#1089#1083#1077#1085#1080#1077' '#1089#1090#1077#1082#1086#1083
        OnClick = N18Click
      end
    end
    object N19: TMenuItem
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      object N23: TMenuItem
        Caption = #1040#1074#1090#1086#1088#1080#1079#1072#1094#1080#1103
        OnClick = N23Click
      end
      object N24: TMenuItem
        Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
        Enabled = False
        OnClick = N24Click
      end
      object N20: TMenuItem
        Caption = #1057#1077#1088#1074#1080#1089' '#1041#1044' '#1082#1086#1084#1087#1086#1085#1077#1085#1090#1099
        Enabled = False
        OnClick = N20Click
      end
      object N22: TMenuItem
        Caption = #1057#1077#1088#1074#1080#1089' '#1041#1044' '#1076#1086#1087'. '#1084#1072#1090#1077#1088#1080#1072#1083#1099
        Enabled = False
        OnClick = N22Click
      end
    end
  end
  object FDQuery: TFDQuery
    Left = 16
    Top = 288
  end
  object sourceOrders: TDataSource
    DataSet = dsOrders
    Left = 80
    Top = 240
  end
  object dsOrders: TFDQuery
    Left = 16
    Top = 240
  end
  object IdFTP: TIdFTP
    IPVersion = Id_IPv4
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 16
    Top = 376
  end
end
