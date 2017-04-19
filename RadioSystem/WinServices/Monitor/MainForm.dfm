object fMainForm: TfMainForm
  Left = 98
  Top = 55
  Caption = 'Process Monitor v.1.1'
  ClientHeight = 400
  ClientWidth = 805
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lvProcList: TListView
    Left = 0
    Top = 0
    Width = 805
    Height = 257
    Align = alTop
    Columns = <
      item
        AutoSize = True
        Caption = 'process name'
      end
      item
        Alignment = taCenter
        AutoSize = True
        Caption = 'state'
        MaxWidth = 100
      end
      item
        Alignment = taCenter
        AutoSize = True
        Caption = 'last check'
        MaxWidth = 120
      end
      item
        Alignment = taCenter
        AutoSize = True
        Caption = 'records'
        MaxWidth = 60
      end
      item
        Alignment = taCenter
        AutoSize = True
        Caption = 'current'
        MaxWidth = 60
      end>
    Items.ItemData = {
      05A20100000400000000000000FFFFFFFFFFFFFFFF04000000FFFFFFFF000000
      0016410062006900730020005300740061007400690073007400690063007300
      200049006D0070006F007200740000406FBE27009070BE270008A7BE2700B86D
      BE2700000000FFFFFFFFFFFFFFFF04000000FFFFFFFF00000000165400520041
      00550020005300740061007400690073007400690063007300200049006D0070
      006F007200740000F0A5BE270010A5BE270048A5BE2700B8A5BE2700000000FF
      FFFFFFFFFFFFFF04000000FFFFFFFF00000000224300680061006E006E006500
      6C00200045006C0065006D0065006E0074007300200053007400610074006900
      73007400690063007300200049006D0070006F00720074000068A4BE270098A6
      BE27008082BE270028A6BE2700000000FFFFFFFFFFFFFFFF04000000FFFFFFFF
      0000000017440065006C0065007400650020004F006C00640020004200610063
      006B00750070002000460069006C006500730000809EBE2700B0A0BE2700B89E
      BE27005064BE27FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF}
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnSelectItem = lvProcListSelectItem
  end
  object btnStartProc: TButton
    Left = 112
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Start'
    Enabled = False
    TabOrder = 1
    OnClick = btnStartProcClick
  end
  object redtLog: TRichEdit
    Left = 0
    Top = 311
    Width = 805
    Height = 89
    Align = alBottom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
    Zoom = 100
  end
  object btnStopProc: TButton
    Left = 331
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Stop'
    Enabled = False
    TabOrder = 3
    OnClick = btnStopProcClick
  end
  object btnStartNow: TButton
    Left = 198
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Start Now'
    Enabled = False
    TabOrder = 4
    OnClick = btnStartNowClick
  end
  object btnSettings: TButton
    Left = 442
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Settings'
    Enabled = False
    TabOrder = 5
    OnClick = btnSettingsClick
  end
  object btnStartAll: TButton
    Left = 15
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Start All'
    TabOrder = 6
    OnClick = btnStartAllClick
  end
end
