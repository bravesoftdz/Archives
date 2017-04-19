object frmCustomers: TfrmCustomers
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1050#1083#1080#1077#1085#1090#1099
  ClientHeight = 472
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdCustomers: TDBGrid
    Left = 8
    Top = 8
    Width = 729
    Height = 417
    DataSource = dsrCustomers
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnTitleClick = dbgrdCustomersTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Title.Alignment = taCenter
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'type'
        Title.Alignment = taCenter
        Title.Caption = #1090#1080#1087
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Title.Alignment = taCenter
        Title.Caption = #1080#1084#1103'/'#1085#1072#1079#1074#1072#1085#1080#1077
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'address'
        Title.Alignment = taCenter
        Title.Caption = #1072#1076#1088#1077#1089
        Width = 300
        Visible = True
      end>
  end
  object btnApply: TButton
    Left = 24
    Top = 439
    Width = 75
    Height = 25
    Caption = #1042#1099#1073#1088#1072#1090#1100
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 648
    Top = 439
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object dsCustomers: TFDQuery
    Left = 48
    Top = 80
  end
  object dsrCustomers: TDataSource
    DataSet = dsCustomers
    Left = 128
    Top = 80
  end
end
