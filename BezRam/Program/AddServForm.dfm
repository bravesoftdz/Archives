object AS_Edit: TAS_Edit
  Left = 342
  Top = 165
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1093' '#1091#1089#1083#1091#1075
  ClientHeight = 181
  ClientWidth = 739
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
    Top = 21
    Width = 72
    Height = 13
    Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label5: TLabel
    Left = 24
    Top = 77
    Width = 41
    Height = 13
    Caption = #1077#1076'. '#1080#1079#1084'.'
  end
  object Label3: TLabel
    Left = 144
    Top = 77
    Width = 34
    Height = 13
    Caption = #1082#1086#1083'-'#1074#1086
  end
  object Label4: TLabel
    Left = 264
    Top = 77
    Width = 29
    Height = 13
    Caption = #1089#1091#1084#1084#1072
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 40
    Width = 689
    Height = 21
    TabOrder = 0
    OnChange = ComboBox1Change
  end
  object Edit1: TEdit
    Left = 24
    Top = 96
    Width = 81
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object DBEdit1: TDBEdit
    Left = 144
    Top = 96
    Width = 81
    Height = 21
    DataField = 'quantity'
    DataSource = DataSource1
    TabOrder = 2
    OnChange = DBEdit1Change
  end
  object DBEdit2: TDBEdit
    Left = 264
    Top = 96
    Width = 81
    Height = 21
    DataField = 'sum'
    DataSource = DataSource1
    TabOrder = 3
  end
  object Button1: TButton
    Left = 32
    Top = 145
    Width = 75
    Height = 25
    Caption = #1087#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 632
    Top = 145
    Width = 75
    Height = 25
    Caption = #1086#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = Button2Click
  end
  object DBEdit3: TDBEdit
    Left = 592
    Top = 74
    Width = 121
    Height = 21
    DataField = 'as_id'
    DataSource = DataSource1
    TabOrder = 6
    Visible = False
  end
  object DBEdit4: TDBEdit
    Left = 592
    Top = 101
    Width = 121
    Height = 21
    DataField = 'order_id'
    DataSource = DataSource1
    TabOrder = 7
    Visible = False
  end
  object DataSource1: TDataSource
    DataSet = Order.dsAddServ
    Left = 472
    Top = 128
  end
  object FDQuery2: TFDQuery
    Left = 400
    Top = 128
  end
end
