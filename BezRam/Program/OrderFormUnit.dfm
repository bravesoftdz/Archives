object Order: TOrder
  Left = 244
  Top = 55
  BorderStyle = bsToolWindow
  Caption = #1047#1072#1082#1072#1079
  ClientHeight = 569
  ClientWidth = 973
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
  object Label14: TLabel
    Left = 468
    Top = 543
    Width = 40
    Height = 13
    Caption = #1088#1072#1089#1089#1095#1105#1090
    Visible = False
    OnClick = Label14Click
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 957
    Height = 522
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1056#1072#1089#1095#1105#1090' '#1079#1072#1082#1072#1079#1072
      object GroupBox1: TGroupBox
        Left = 16
        Top = 16
        Width = 409
        Height = 441
        Caption = #1087#1072#1088#1072#1084#1077#1090#1088#1099
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 32
          Width = 127
          Height = 13
          Caption = #1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1081
        end
        object Label3: TLabel
          Left = 16
          Top = 69
          Width = 111
          Height = 13
          Caption = #1088#1072#1079#1084#1077#1088#1099' '#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1081
        end
        object Label4: TLabel
          Left = 16
          Top = 280
          Width = 102
          Height = 13
          Caption = #1090#1086#1083#1097#1080#1085#1072' '#1089#1090#1077#1082#1083#1072', '#1084#1084
        end
        object Label5: TLabel
          Left = 16
          Top = 307
          Width = 65
          Height = 13
          Caption = #1087#1083#1086#1097#1072#1076#1100', '#1084'2'
        end
        object Label6: TLabel
          Left = 16
          Top = 361
          Width = 110
          Height = 13
          Caption = #1082#1086#1083'-'#1074#1086' '#1092#1080#1082#1089'. '#1089#1090#1074#1086#1088#1086#1082
        end
        object Label7: TLabel
          Left = 16
          Top = 388
          Width = 117
          Height = 13
          Caption = #1082#1086#1083'-'#1074#1086' '#1089#1076#1074#1080#1078'. '#1089#1090#1074#1086#1088#1086#1082
        end
        object Label8: TLabel
          Left = 16
          Top = 251
          Width = 86
          Height = 13
          Caption = #1086#1073#1097#1072#1103' '#1076#1083#1080#1085#1072', '#1084#1084
        end
        object Label15: TLabel
          Left = 16
          Top = 334
          Width = 78
          Height = 13
          Caption = #1082#1086#1083'-'#1074#1086' '#1089#1090#1074#1086#1088#1086#1082
        end
        object StringGrid1: TStringGrid
          Left = 16
          Top = 88
          Width = 377
          Height = 137
          ColCount = 1
          DefaultColWidth = 50
          FixedCols = 0
          RowCount = 4
          FixedRows = 0
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goThumbTracking]
          TabOrder = 0
          OnSetEditText = StringGrid1SetEditText
        end
        object DBComboBox1: TDBComboBox
          Left = 160
          Top = 29
          Width = 57
          Height = 21
          DataField = 'constructions_count'
          DataSource = DataSource1
          Items.Strings = (
            '1'
            '2'
            '3'
            '4'
            '5')
          TabOrder = 1
          OnChange = DBComboBox1Change
        end
        object DBEdit1: TDBEdit
          Left = 152
          Top = 248
          Width = 65
          Height = 21
          DataField = 'width'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 2
        end
        object DBComboBox2: TDBComboBox
          Left = 152
          Top = 275
          Width = 65
          Height = 21
          DataField = 'glass_thick'
          DataSource = DataSource1
          Items.Strings = (
            '6'
            '8'
            '10')
          TabOrder = 3
          OnChange = DBComboBox2Change
        end
        object DBEdit2: TDBEdit
          Left = 152
          Top = 304
          Width = 65
          Height = 21
          DataField = 'square'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 4
        end
        object DBEdit3: TDBEdit
          Left = 152
          Top = 331
          Width = 65
          Height = 21
          DataField = 'glass_count'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 5
        end
        object DBEdit4: TDBEdit
          Left = 152
          Top = 358
          Width = 65
          Height = 21
          DataField = 'fix_count'
          DataSource = DataSource1
          TabOrder = 6
          OnChange = DBEdit4Change
        end
        object DBEdit5: TDBEdit
          Left = 152
          Top = 385
          Width = 65
          Height = 21
          DataField = 'mov_count'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 7
        end
        object RadioButton1: TRadioButton
          Left = 256
          Top = 245
          Width = 113
          Height = 17
          Caption = 'STANDART'
          Checked = True
          TabOrder = 8
          TabStop = True
          OnClick = RadioButton1Click
        end
        object RadioButton2: TRadioButton
          Left = 256
          Top = 277
          Width = 113
          Height = 17
          Caption = 'BASIC-PRO'
          TabOrder = 9
          OnClick = RadioButton2Click
        end
        object DBEdit38: TDBEdit
          Left = 256
          Top = 304
          Width = 121
          Height = 21
          DataField = 'system_type'
          DataSource = DataSource1
          TabOrder = 10
          Visible = False
        end
      end
      object GroupBox2: TGroupBox
        Left = 431
        Top = 16
        Width = 506
        Height = 261
        Caption = #1089#1093#1077#1084#1072
        TabOrder = 1
        object Image1: TImage
          Left = 16
          Top = 13
          Width = 473
          Height = 236
        end
      end
      object GroupBox3: TGroupBox
        Left = 431
        Top = 283
        Width = 506
        Height = 174
        Caption = #1089#1090#1086#1080#1084#1086#1089#1090#1100
        TabOrder = 2
        object Label9: TLabel
          Left = 96
          Top = 27
          Width = 145
          Height = 13
          Caption = #1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1081', '#1088#1091#1073
        end
        object Label10: TLabel
          Left = 96
          Top = 54
          Width = 51
          Height = 13
          Caption = 'c'#1082#1080#1076#1082#1072',%'
        end
        object Label11: TLabel
          Left = 96
          Top = 81
          Width = 113
          Height = 13
          Caption = #1080#1090#1086#1075#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081', '#1088#1091#1073
        end
        object Label12: TLabel
          Left = 96
          Top = 108
          Width = 127
          Height = 13
          Caption = #1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1086#1085#1090#1072#1078#1072', '#1088#1091#1073' '
        end
        object Label13: TLabel
          Left = 96
          Top = 135
          Width = 54
          Height = 13
          Caption = #1080#1090#1086#1075#1086', '#1088#1091#1073
        end
        object DBEdit6: TDBEdit
          Left = 280
          Top = 24
          Width = 65
          Height = 21
          DataField = 'cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 0
        end
        object DBEdit7: TDBEdit
          Left = 280
          Top = 51
          Width = 65
          Height = 21
          DataField = 'discount'
          DataSource = DataSource1
          TabOrder = 1
          OnChange = DBEdit7Change
        end
        object DBEdit8: TDBEdit
          Left = 280
          Top = 78
          Width = 65
          Height = 21
          DataField = 'cost_w_discount'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 2
        end
        object DBEdit9: TDBEdit
          Left = 280
          Top = 105
          Width = 65
          Height = 21
          DataField = 'install_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 3
        end
        object DBEdit10: TDBEdit
          Left = 280
          Top = 132
          Width = 65
          Height = 21
          DataField = 'total_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 4
        end
        object DBCheckBox1: TDBCheckBox
          Left = 392
          Top = 24
          Width = 81
          Height = 17
          Caption = #1087#1088#1072#1081#1089' '#1076#1080#1083#1077#1088
          DataField = 'is_dealer'
          DataSource = DataSource5
          TabOrder = 5
          ValueChecked = '1'
          ValueUnchecked = '0'
          OnClick = DBCheckBox1Click
        end
        object DBCheckBox2: TDBCheckBox
          Left = 392
          Top = 104
          Width = 97
          Height = 17
          Caption = #1073#1077#1079' '#1084#1086#1085#1090#1072#1078#1072
          DataField = 'is_no_install'
          DataSource = DataSource1
          TabOrder = 6
          ValueChecked = '1'
          ValueUnchecked = '0'
          OnClick = DBCheckBox2Click
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1044#1086#1087'. '#1084#1072#1090#1077#1088#1080#1072#1083#1099
      ImageIndex = 3
      object Label2: TLabel
        Left = 48
        Top = 332
        Width = 49
        Height = 13
        Caption = #1076#1086#1073#1072#1074#1080#1090#1100
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
      object Label16: TLabel
        Left = 48
        Top = 351
        Width = 79
        Height = 13
        Caption = #1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label16Click
        OnMouseEnter = Label16MouseEnter
        OnMouseLeave = Label16MouseLeave
      end
      object Label17: TLabel
        Left = 48
        Top = 388
        Width = 43
        Height = 13
        Caption = #1091#1076#1072#1083#1080#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label17Click
        OnMouseEnter = Label17MouseEnter
        OnMouseLeave = Label17MouseLeave
      end
      object DBGrid1: TDBGrid
        Left = 16
        Top = 16
        Width = 909
        Height = 297
        DataSource = DataSource2
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
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
            Width = 220
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'am_name'
            Title.Alignment = taCenter
            Title.Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 400
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
            Title.Caption = #1094#1077#1085#1072
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantity'
            Title.Alignment = taCenter
            Title.Caption = #1082#1086#1083'-'#1074#1086
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sum'
            Title.Alignment = taCenter
            Title.Caption = #1089#1091#1084#1084#1072
            Width = 60
            Visible = True
          end>
      end
      object GroupBox4: TGroupBox
        Left = 488
        Top = 316
        Width = 437
        Height = 150
        Caption = #1089#1090#1086#1080#1084#1086#1089#1090#1100
        TabOrder = 1
        object Label18: TLabel
          Left = 15
          Top = 17
          Width = 58
          Height = 13
          Caption = #1080#1090#1086#1075#1086', '#1088#1091#1073'.'
        end
        object Label19: TLabel
          Left = 15
          Top = 45
          Width = 54
          Height = 13
          Caption = #1089#1082#1080#1076#1082#1072', %'
        end
        object Label20: TLabel
          Left = 15
          Top = 72
          Width = 117
          Height = 13
          Caption = #1080#1090#1086#1075#1086' '#1089#1086' '#1089#1082#1080#1076#1082#1086#1081', '#1088#1091#1073'.'
        end
        object Label21: TLabel
          Left = 15
          Top = 100
          Width = 191
          Height = 13
          Caption = #1089#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1086#1085#1090#1072#1078#1072' '#1076#1086#1087'. '#1084#1072#1090#1077#1088'., '#1088#1091#1073'.'
        end
        object Label22: TLabel
          Left = 15
          Top = 126
          Width = 58
          Height = 13
          Caption = #1080#1090#1086#1075#1086', '#1088#1091#1073'.'
        end
        object Label23: TLabel
          Left = 128
          Top = 16
          Width = 51
          Height = 13
          Caption = #1088#1072#1089#1095#1105#1090' '#1076#1084
          Visible = False
          OnClick = Label23Click
        end
        object DBEdit11: TDBEdit
          Left = 222
          Top = 13
          Width = 121
          Height = 21
          DataField = 'am_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 0
        end
        object DBEdit12: TDBEdit
          Left = 222
          Top = 42
          Width = 121
          Height = 21
          DataField = 'am_discount'
          DataSource = DataSource1
          TabOrder = 1
          OnChange = DBEdit12Change
        end
        object DBEdit13: TDBEdit
          Left = 222
          Top = 69
          Width = 121
          Height = 21
          DataField = 'am_cost_w_discount'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 2
        end
        object DBEdit14: TDBEdit
          Left = 222
          Top = 95
          Width = 121
          Height = 21
          DataField = 'am_install_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 3
        end
        object DBEdit15: TDBEdit
          Left = 222
          Top = 123
          Width = 121
          Height = 21
          DataField = 'am_total_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 4
        end
        object DBCheckBox3: TDBCheckBox
          Left = 349
          Top = 96
          Width = 97
          Height = 17
          Caption = #1073#1077#1079' '#1084#1086#1085#1090#1072#1078#1072
          DataField = 'is_no_am_install'
          DataSource = DataSource1
          TabOrder = 5
          ValueChecked = '1'
          ValueUnchecked = '0'
          OnClick = DBCheckBox3Click
        end
      end
    end
    object TabSheet5: TTabSheet
      Caption = #1044#1086#1087'. '#1091#1089#1083#1091#1075#1080
      ImageIndex = 4
      object Label25: TLabel
        Left = 67
        Top = 392
        Width = 49
        Height = 13
        Caption = #1076#1086#1073#1072#1074#1080#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label25Click
        OnMouseEnter = Label25MouseEnter
        OnMouseLeave = Label25MouseLeave
      end
      object Label26: TLabel
        Left = 67
        Top = 411
        Width = 79
        Height = 13
        Caption = #1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label26Click
        OnMouseEnter = Label26MouseEnter
        OnMouseLeave = Label26MouseLeave
      end
      object Label27: TLabel
        Left = 67
        Top = 440
        Width = 43
        Height = 13
        Caption = #1091#1076#1072#1083#1080#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label27Click
        OnMouseEnter = Label27MouseEnter
        OnMouseLeave = Label27MouseLeave
      end
      object DBGrid2: TDBGrid
        Left = 16
        Top = 16
        Width = 913
        Height = 361
        DataSource = DataSource3
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'as_name'
            Title.Alignment = taCenter
            Title.Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 580
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'mesuare'
            Title.Alignment = taCenter
            Title.Caption = #1077#1076'.'#1080#1079#1084'.'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cost'
            Title.Alignment = taCenter
            Title.Caption = #1094#1077#1085#1072
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantity'
            Title.Alignment = taCenter
            Title.Caption = #1082#1086#1083'-'#1074#1086
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'sum'
            Title.Alignment = taCenter
            Title.Caption = #1089#1091#1084#1084#1072
            Width = 70
            Visible = True
          end>
      end
      object GroupBox5: TGroupBox
        Left = 632
        Top = 383
        Width = 297
        Height = 83
        Caption = #1089#1090#1086#1080#1084#1086#1089#1090#1100
        TabOrder = 1
        object Label24: TLabel
          Left = 64
          Top = 32
          Width = 58
          Height = 13
          Caption = #1080#1090#1086#1075#1086', '#1088#1091#1073'.'
        end
        object DBEdit16: TDBEdit
          Left = 160
          Top = 29
          Width = 112
          Height = 21
          DataField = 'as_total_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 0
        end
      end
    end
    object TabSheet6: TTabSheet
      Caption = #1057#1074#1086#1076#1085#1099#1081' '#1088#1072#1089#1089#1095#1105#1090
      ImageIndex = 5
      object lblEuroRate: TLabel
        Left = 528
        Top = 24
        Width = 128
        Height = 13
        Caption = #1050#1091#1088'c EURO '#1076#1083#1103' '#1088#1072#1089#1095#1105#1090#1072': '
      end
      object dbtxtEuroRate: TDBText
        Left = 662
        Top = 25
        Width = 65
        Height = 17
        DataField = 'ce_on_calc_day'
        DataSource = DataSource1
      end
      object lblRateUpdate: TLabel
        Left = 743
        Top = 24
        Width = 166
        Height = 13
        Caption = #1087#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1087#1086' '#1090#1077#1082#1091#1097#1077#1084#1091' '#1082#1091#1088#1089#1091
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = lblRateUpdateClick
        OnMouseEnter = lblRateUpdateMouseEnter
        OnMouseLeave = lblRateUpdateMouseLeave
      end
      object GroupBox6: TGroupBox
        Left = 29
        Top = 48
        Width = 880
        Height = 257
        Caption = #1054#1073#1097#1072#1103' '#1089#1090#1086#1080#1084#1086#1089#1090#1100
        TabOrder = 0
        object Label28: TLabel
          Left = 32
          Top = 51
          Width = 185
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1080' '#1040#1082#1088#1080#1089#1090#1072#1083#1080#1103
        end
        object Label29: TLabel
          Left = 32
          Top = 78
          Width = 164
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1084#1086#1085#1090#1072#1078#1072' '#1040#1082#1088#1080#1089#1090#1072#1083#1080#1103
        end
        object Label30: TLabel
          Left = 32
          Top = 105
          Width = 207
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
        end
        object Label31: TLabel
          Left = 32
          Top = 132
          Width = 192
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1052#1086#1085#1090#1072#1078#1072' '#1076#1086#1087'. '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
        end
        object Label32: TLabel
          Left = 32
          Top = 159
          Width = 175
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1091#1089#1083#1091#1075
        end
        object Label33: TLabel
          Left = 32
          Top = 199
          Width = 30
          Height = 13
          Caption = #1048#1090#1086#1075#1086
        end
        object DBEdit17: TDBEdit
          Left = 288
          Top = 48
          Width = 121
          Height = 21
          DataField = 'cost_w_discount'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 0
        end
        object DBEdit18: TDBEdit
          Left = 288
          Top = 75
          Width = 121
          Height = 21
          DataField = 'install_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 1
        end
        object DBEdit19: TDBEdit
          Left = 288
          Top = 102
          Width = 121
          Height = 21
          DataField = 'am_cost_w_discount'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 2
        end
        object DBEdit20: TDBEdit
          Left = 288
          Top = 129
          Width = 121
          Height = 21
          DataField = 'am_install_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 3
        end
        object DBEdit21: TDBEdit
          Left = 288
          Top = 156
          Width = 121
          Height = 21
          DataField = 'as_total_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 4
        end
        object DBEdit22: TDBEdit
          Left = 288
          Top = 196
          Width = 121
          Height = 21
          DataField = 'order_total_cost'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 5
        end
      end
      object GroupBox7: TGroupBox
        Left = 29
        Top = 311
        Width = 880
        Height = 154
        Caption = #1044#1083#1103' '#1076#1086#1075#1086#1074#1086#1088#1072
        TabOrder = 1
        object Label34: TLabel
          Left = 32
          Top = 23
          Width = 85
          Height = 13
          Caption = #1062#1077#1085#1072' '#1052#1072#1090#1077#1088#1080#1072#1083#1072
        end
        object Label35: TLabel
          Left = 32
          Top = 50
          Width = 22
          Height = 13
          Caption = #1053#1044#1057
        end
        object Label36: TLabel
          Left = 32
          Top = 77
          Width = 59
          Height = 13
          Caption = #1062#1077#1085#1072' '#1088#1072#1073#1086#1090
        end
        object Label37: TLabel
          Left = 32
          Top = 104
          Width = 22
          Height = 13
          Caption = #1053#1044#1057
        end
        object DBEdit23: TDBEdit
          Left = 288
          Top = 20
          Width = 121
          Height = 21
          DataField = 'm_for_contract'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 0
        end
        object DBEdit24: TDBEdit
          Left = 288
          Top = 47
          Width = 121
          Height = 21
          DataField = 'vat_m_for_contract'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 1
        end
        object DBEdit25: TDBEdit
          Left = 288
          Top = 74
          Width = 121
          Height = 21
          DataField = 'w_for_contract'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 2
        end
        object DBEdit26: TDBEdit
          Left = 288
          Top = 101
          Width = 121
          Height = 21
          DataField = 'vat_w_for_contract'
          DataSource = DataSource1
          Enabled = False
          TabOrder = 3
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1044#1072#1085#1085#1099#1077' '#1082#1083#1080#1077#1085#1090#1072
      ImageIndex = 1
      object Label59: TLabel
        Left = 672
        Top = 18
        Width = 60
        Height = 13
        Caption = #1087#1088#1080#1084#1077#1095#1072#1085#1080#1103
      end
      object GroupBox8: TGroupBox
        Left = 29
        Top = 95
        Width = 628
        Height = 396
        Caption = #1044#1072#1085#1085#1099#1077' '#1086' '#1079#1072#1082#1072#1079#1095#1080#1082#1077
        TabOrder = 0
        object Label38: TLabel
          Left = 38
          Top = 61
          Width = 63
          Height = 13
          Caption = #1090#1080#1087' '#1082#1083#1080#1077#1085#1090#1072
        end
        object Label39: TLabel
          Left = 38
          Top = 88
          Width = 168
          Height = 13
          Caption = #1060#1048#1054' '#1082#1083#1080#1077#1085#1090#1072'/'#1085#1072#1079#1074#1072#1085#1080#1077' '#1102#1088'. '#1083#1080#1094#1072
        end
        object Label40: TLabel
          Left = 38
          Top = 115
          Width = 30
          Height = 13
          Caption = #1072#1076#1088#1077#1089
        end
        object Label41: TLabel
          Left = 38
          Top = 142
          Width = 73
          Height = 13
          Caption = #1090#1077#1083#1077#1092#1086#1085'/'#1092#1072#1082#1089
        end
        object lblChooseCustomer: TLabel
          Left = 360
          Top = 17
          Width = 216
          Height = 13
          Caption = #1074#1099#1073#1088#1072#1090#1100' '#1082#1083#1080#1077#1085#1090#1072' '#1080#1079' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093' '#1079#1072#1082#1072#1079#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = lblChooseCustomerClick
          OnMouseEnter = lblChooseCustomerMouseEnter
          OnMouseLeave = lblChooseCustomerMouseLeave
        end
        object lblNewCustomer: TLabel
          Left = 256
          Top = 17
          Width = 71
          Height = 13
          Caption = #1085#1086#1074#1099#1081' '#1082#1083#1080#1077#1085#1090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = lblNewCustomerClick
          OnMouseEnter = lblNewCustomerMouseEnter
          OnMouseLeave = lblNewCustomerMouseLeave
        end
        object lblId: TLabel
          Left = 38
          Top = 28
          Width = 15
          Height = 13
          Caption = 'ID:'
        end
        object dbtxtCustomerId: TDBText
          Left = 64
          Top = 28
          Width = 65
          Height = 17
          DataField = 'Id'
          DataSource = DataSource5
        end
        object DBComboBox3: TDBComboBox
          Left = 216
          Top = 58
          Width = 145
          Height = 21
          DataField = 'type'
          DataSource = DataSource5
          Items.Strings = (
            #1092#1080#1079'. '#1083#1080#1094#1086
            #1102#1088'. '#1083#1080#1094#1086)
          TabOrder = 0
        end
        object DBEdit27: TDBEdit
          Left = 216
          Top = 85
          Width = 329
          Height = 21
          DataField = 'name'
          DataSource = DataSource5
          TabOrder = 1
        end
        object DBEdit28: TDBEdit
          Left = 216
          Top = 112
          Width = 329
          Height = 21
          DataField = 'address'
          DataSource = DataSource5
          TabOrder = 2
        end
        object DBEdit29: TDBEdit
          Left = 216
          Top = 139
          Width = 145
          Height = 21
          DataField = 'phone'
          DataSource = DataSource5
          TabOrder = 3
        end
        object GroupBox11: TGroupBox
          Left = 3
          Top = 164
          Width = 622
          Height = 104
          Caption = #1092#1080#1079'. '#1083#1080#1094#1086
          TabOrder = 4
          object Label46: TLabel
            Left = 35
            Top = 74
            Width = 98
            Height = 13
            Caption = #1082#1077#1084' '#1074#1099#1076#1072#1085' '#1087#1072#1089#1087#1086#1088#1090
          end
          object Label45: TLabel
            Left = 35
            Top = 47
            Width = 117
            Height = 13
            Caption = #1076#1072#1090#1072' '#1074#1099#1076#1072#1095#1080' '#1087#1072#1089#1087#1086#1088#1090#1072
          end
          object Label44: TLabel
            Left = 35
            Top = 20
            Width = 80
            Height = 13
            Caption = #1085#1086#1084#1077#1088' '#1087#1072#1089#1087#1086#1088#1090#1072
          end
          object DBEdit34: TDBEdit
            Left = 213
            Top = 71
            Width = 329
            Height = 21
            DataField = 'passport_out'
            DataSource = DataSource5
            TabOrder = 0
          end
          object DBEdit33: TDBEdit
            Left = 213
            Top = 44
            Width = 121
            Height = 21
            DataField = 'passport_date'
            DataSource = DataSource5
            TabOrder = 1
          end
          object DBEdit32: TDBEdit
            Left = 213
            Top = 17
            Width = 121
            Height = 21
            DataField = 'passport'
            DataSource = DataSource5
            TabOrder = 2
          end
        end
        object GroupBox12: TGroupBox
          Left = 3
          Top = 274
          Width = 622
          Height = 119
          Caption = #1102#1088'. '#1083#1080#1094#1086
          TabOrder = 5
          object Label47: TLabel
            Left = 35
            Top = 95
            Width = 80
            Height = 13
            Caption = #1088'/c '#1076#1083#1103' '#1102#1088'. '#1083#1080#1094
          end
          object Label51: TLabel
            Left = 35
            Top = 16
            Width = 119
            Height = 13
            Caption = #1060#1048#1054' '#1076#1086#1074#1077#1088#1077#1085#1085#1086#1075#1086' '#1083#1080#1094#1072
          end
          object Label52: TLabel
            Left = 35
            Top = 42
            Width = 72
            Height = 13
            Caption = #1076#1086#1074#1077#1088#1077#1085#1085#1086#1089#1090#1100
          end
          object Label65: TLabel
            Left = 35
            Top = 68
            Width = 21
            Height = 13
            Caption = #1048#1053#1053
          end
          object DBEdit35: TDBEdit
            Left = 213
            Top = 92
            Width = 329
            Height = 21
            DataField = 'customer_bank'
            DataSource = DataSource5
            TabOrder = 0
          end
          object DBEdit36: TDBEdit
            Left = 213
            Top = 13
            Width = 329
            Height = 21
            DataField = 'attorney_name'
            DataSource = DataSource5
            TabOrder = 1
          end
          object DBEdit37: TDBEdit
            Left = 213
            Top = 39
            Width = 329
            Height = 21
            DataField = 'attorney_doc'
            DataSource = DataSource5
            TabOrder = 2
          end
          object DBEdit39: TDBEdit
            Left = 213
            Top = 65
            Width = 329
            Height = 21
            DataField = 'customer_inn'
            DataSource = DataSource5
            TabOrder = 3
          end
        end
      end
      object GroupBox9: TGroupBox
        Left = 29
        Top = 16
        Width = 628
        Height = 73
        Caption = #1044#1072#1085#1085#1099#1077' '#1076#1086#1075#1086#1074#1086#1088#1072
        TabOrder = 1
        object Label42: TLabel
          Left = 38
          Top = 19
          Width = 76
          Height = 13
          Caption = #1076#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072
        end
        object Label43: TLabel
          Left = 38
          Top = 46
          Width = 81
          Height = 13
          Caption = #1085#1086#1084#1077#1088' '#1076#1086#1075#1086#1074#1086#1088#1072
        end
        object DBEdit30: TDBEdit
          Left = 216
          Top = 43
          Width = 145
          Height = 21
          DataField = 'contract_num'
          DataSource = DataSource1
          TabOrder = 0
        end
        object DBEdit31: TDBEdit
          Left = 376
          Top = 16
          Width = 145
          Height = 21
          DataField = 'order_date'
          DataSource = DataSource1
          TabOrder = 1
          Visible = False
        end
        object DateTimePicker1: TDateTimePicker
          Left = 216
          Top = 16
          Width = 145
          Height = 21
          Date = 41438.693954120370000000
          Time = 41438.693954120370000000
          TabOrder = 2
          OnChange = DateTimePicker1Change
        end
      end
      object DBMemo1: TDBMemo
        Left = 672
        Top = 37
        Width = 265
        Height = 454
        DataField = 'customer_notes'
        DataSource = DataSource1
        TabOrder = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      ImageIndex = 2
      object Label48: TLabel
        Left = 504
        Top = 56
        Width = 121
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1075#1086#1074#1086#1088
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label48Click
        OnMouseEnter = Label48MouseEnter
        OnMouseLeave = Label48MouseLeave
      end
      object Label53: TLabel
        Left = 504
        Top = 88
        Width = 150
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label53Click
        OnMouseEnter = Label53MouseEnter
        OnMouseLeave = Label53MouseLeave
      end
      object Label54: TLabel
        Left = 504
        Top = 120
        Width = 150
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label54Click
        OnMouseEnter = Label54MouseEnter
        OnMouseLeave = Label54MouseLeave
      end
      object Label55: TLabel
        Left = 504
        Top = 152
        Width = 150
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080#1083#1086#1078#1077#1085#1080#1077' 3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label55Click
        OnMouseEnter = Label55MouseEnter
        OnMouseLeave = Label55MouseLeave
      end
      object Label56: TLabel
        Left = 504
        Top = 312
        Width = 186
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1072#1082#1090' '#1087#1086#1089#1090#1072#1074#1082#1080' '#1090#1086#1074#1072#1088#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label56Click
        OnMouseEnter = Label56MouseEnter
        OnMouseLeave = Label56MouseLeave
      end
      object Label57: TLabel
        Left = 504
        Top = 344
        Width = 188
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1072#1082#1090' '#1087#1088#1080#1105#1084#1072' '#1087#1077#1088#1077#1076#1072#1095#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label57Click
        OnMouseEnter = Label57MouseEnter
        OnMouseLeave = Label57MouseLeave
      end
      object Label58: TLabel
        Left = 504
        Top = 376
        Width = 169
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1072#1082#1090' '#1087#1088#1080#1105#1084#1072' '#1088#1072#1073#1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label58Click
        OnMouseEnter = Label58MouseEnter
        OnMouseLeave = Label58MouseLeave
      end
      object Label60: TLabel
        Left = 504
        Top = 24
        Width = 223
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1050#1086#1084#1084#1077#1088#1095#1077#1089#1082#1086#1077' '#1087#1088#1077#1076#1083#1086#1078#1077#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label60Click
        OnMouseEnter = Label60MouseEnter
        OnMouseLeave = Label60MouseLeave
      end
      object Label61: TLabel
        Left = 504
        Top = 184
        Width = 102
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1089#1095#1105#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label61Click
        OnMouseEnter = Label61MouseEnter
        OnMouseLeave = Label61MouseLeave
      end
      object Label62: TLabel
        Left = 504
        Top = 216
        Width = 207
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080#1093#1086#1076#1085#1086#1081' '#1086#1088#1076#1077#1088' - '#1072#1074#1072#1085#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label62Click
        OnMouseEnter = Label62MouseEnter
        OnMouseLeave = Label62MouseLeave
      end
      object Label63: TLabel
        Left = 504
        Top = 248
        Width = 230
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080#1093#1086#1076#1085#1086#1081' '#1086#1088#1076#1077#1088' - '#1076#1086#1087#1083#1072#1090#1072' 1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label63Click
        OnMouseEnter = Label63MouseEnter
        OnMouseLeave = Label63MouseLeave
      end
      object Label64: TLabel
        Left = 504
        Top = 280
        Width = 230
        Height = 13
        Caption = #1089#1075#1077#1085#1077#1088#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1080#1093#1086#1076#1085#1086#1081' '#1086#1088#1076#1077#1088' - '#1076#1086#1087#1083#1072#1090#1072' 2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        OnClick = Label64Click
        OnMouseEnter = Label64MouseEnter
        OnMouseLeave = Label64MouseLeave
      end
      object GroupBox10: TGroupBox
        Left = 11
        Top = 11
        Width = 462
        Height = 446
        Caption = #1089#1087#1080#1089#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' '#1087#1086' '#1079#1072#1082#1072#1079#1091
        TabOrder = 0
        object Label49: TLabel
          Left = 24
          Top = 415
          Width = 44
          Height = 13
          Caption = #1086#1090#1082#1088#1099#1090#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = Label49Click
          OnMouseEnter = Label49MouseEnter
          OnMouseLeave = Label49MouseLeave
        end
        object Label50: TLabel
          Left = 400
          Top = 415
          Width = 43
          Height = 13
          Caption = #1091#1076#1072#1083#1080#1090#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnClick = Label50Click
          OnMouseEnter = Label50MouseEnter
          OnMouseLeave = Label50MouseLeave
        end
        object DBGrid3: TDBGrid
          Left = 18
          Top = 21
          Width = 431
          Height = 388
          DataSource = DataSource4
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'doc_date'
              Title.Alignment = taCenter
              Title.Caption = #1076#1072#1090#1072
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'doc_type'
              Title.Alignment = taCenter
              Title.Caption = #1076#1086#1082#1091#1084#1077#1085#1090
              Width = 300
              Visible = True
            end>
        end
      end
    end
    object TabSheet7: TTabSheet
      Caption = #1048#1089#1090#1086#1088#1080#1103
      ImageIndex = 6
      object dbgrdHistory: TDBGrid
        Left = 16
        Top = 16
        Width = 913
        Height = 457
        DataSource = dsrHistory
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnTitleClick = dbgrdHistoryTitleClick
        Columns = <
          item
            Expanded = False
            FieldName = 'date'
            Title.Alignment = taCenter
            Title.Caption = #1076#1072#1090#1072' '#1074#1088#1077#1084#1103
            Width = 130
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'operation'
            Title.Alignment = taCenter
            Title.Caption = #1076#1077#1081#1089#1090#1074#1080#1077
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'login'
            Title.Alignment = taCenter
            Title.Caption = #1083#1086#1075#1080#1085
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'name'
            Title.Alignment = taCenter
            Title.Caption = #1080#1084#1103
            Width = 250
            Visible = True
          end>
      end
    end
  end
  object Button1: TButton
    Left = 41
    Top = 536
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 846
    Top = 536
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    DataSet = dsOrder
    Left = 442
    Top = 376
  end
  object DataSource2: TDataSource
    DataSet = dsAddMat
    Left = 443
    Top = 430
  end
  object DataSource3: TDataSource
    DataSet = dsAddServ
    Left = 444
    Top = 484
  end
  object DataSource4: TDataSource
    DataSet = dsOrderDoc
    Left = 444
    Top = 328
  end
  object dsOrder: TFDQuery
    UpdateOptions.AssignedValues = [uvUpdateNonBaseFields]
    UpdateOptions.UpdateNonBaseFields = True
    Left = 376
    Top = 376
  end
  object dsAddMat: TFDQuery
    CachedUpdates = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvUpdateNonBaseFields]
    UpdateOptions.UpdateNonBaseFields = True
    Left = 376
    Top = 430
  end
  object dsAddServ: TFDQuery
    AfterOpen = dsAddServAfterOpen
    CachedUpdates = True
    UpdateOptions.AssignedValues = [uvUpdateNonBaseFields]
    UpdateOptions.UpdateNonBaseFields = True
    UpdateObject = FDUpdateSQL1
    Left = 376
    Top = 484
  end
  object dsOrderDocNum: TFDQuery
    Left = 377
    Top = 281
  end
  object dsOrderDoc: TFDQuery
    Left = 376
    Top = 328
  end
  object dsCustomer: TFDQuery
    Left = 377
    Top = 232
  end
  object DataSource5: TDataSource
    DataSet = dsCustomer
    Left = 443
    Top = 232
  end
  object FDUpdateSQL1: TFDUpdateSQL
    Left = 148
    Top = 488
  end
  object dsHistory: TFDQuery
    Left = 572
    Top = 232
  end
  object dsrHistory: TDataSource
    DataSet = dsHistory
    Left = 628
    Top = 232
  end
end
