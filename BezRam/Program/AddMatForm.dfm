object AM_Edit: TAM_Edit
  Left = 439
  Top = 219
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1076#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
  ClientHeight = 221
  ClientWidth = 758
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
    Top = 13
    Width = 53
    Height = 13
    Caption = #1082#1072#1090#1077#1075#1086#1088#1080#1103
  end
  object Label2: TLabel
    Left = 24
    Top = 61
    Width = 72
    Height = 13
    Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label3: TLabel
    Left = 144
    Top = 125
    Width = 34
    Height = 13
    Caption = #1082#1086#1083'-'#1074#1086
  end
  object Label4: TLabel
    Left = 264
    Top = 125
    Width = 29
    Height = 13
    Caption = #1089#1091#1084#1084#1072
  end
  object Label5: TLabel
    Left = 24
    Top = 125
    Width = 41
    Height = 13
    Caption = #1077#1076'. '#1080#1079#1084'.'
  end
  object DBEdit1: TDBEdit
    Left = 144
    Top = 144
    Width = 81
    Height = 21
    DataField = 'quantity'
    DataSource = DataSource1
    TabOrder = 0
    OnChange = DBEdit1Change
  end
  object DBEdit2: TDBEdit
    Left = 264
    Top = 144
    Width = 81
    Height = 21
    DataField = 'sum'
    DataSource = DataSource1
    Enabled = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 30
    Top = 188
    Width = 75
    Height = 25
    Caption = #1087#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 654
    Top = 188
    Width = 75
    Height = 25
    Caption = #1086#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button2Click
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 32
    Width = 705
    Height = 21
    TabOrder = 4
    OnChange = ComboBox1Change
  end
  object DBEdit3: TDBEdit
    Left = 608
    Top = 109
    Width = 121
    Height = 21
    DataField = 'am_id'
    DataSource = DataSource1
    TabOrder = 5
    Visible = False
  end
  object ComboBox2: TComboBox
    Left = 24
    Top = 82
    Width = 705
    Height = 21
    TabOrder = 6
    OnChange = ComboBox2Change
  end
  object Edit1: TEdit
    Left = 24
    Top = 144
    Width = 81
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object DBEdit4: TDBEdit
    Left = 608
    Top = 136
    Width = 121
    Height = 21
    DataField = 'order_id'
    DataSource = DataSource1
    TabOrder = 8
    Visible = False
  end
  object ListBox1: TListBox
    Left = 456
    Top = 82
    Width = 121
    Height = 97
    ItemHeight = 13
    TabOrder = 9
    Visible = False
  end
  object DataSource1: TDataSource
    DataSet = Order.dsAddMat
    Left = 472
    Top = 128
  end
  object FDQuery2: TFDQuery
    Left = 200
    Top = 176
  end
  object FDQuery3: TFDQuery
    Left = 256
    Top = 176
  end
  object FDQuery1: TFDQuery
    Left = 144
    Top = 176
  end
end
