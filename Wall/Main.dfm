object MainForm: TMainForm
  Left = 462
  Top = 261
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'VideoWall Ver1.21('#25903#25345'4.6.9.12.16'#20998#23631')'
  ClientHeight = 312
  ClientWidth = 487
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object L_cpu: TLabel
    Left = 4
    Top = 247
    Width = 34
    Height = 13
    AutoSize = False
    Caption = 'CPU'#65306
  end
  object L_memo: TLabel
    Left = 4
    Top = 273
    Width = 36
    Height = 13
    AutoSize = False
    Caption = #20869#23384#65306
  end
  object grp1: TGroupBox
    Left = 0
    Top = 0
    Width = 487
    Height = 233
    Align = alTop
    Caption = #25552#31034#20449#24687
    TabOrder = 0
    object VsMemo: TMemo
      Left = 2
      Top = 15
      Width = 483
      Height = 216
      Align = alClient
      TabOrder = 0
      OnChange = VsMemoChange
    end
  end
  object btn1: TButton
    Left = 216
    Top = 256
    Width = 75
    Height = 25
    Caption = #32467#26463#31243#24207
    TabOrder = 1
    OnClick = btn1Click
  end
  object pb_cpu: TProgressBar
    Left = 40
    Top = 246
    Width = 121
    Height = 17
    Min = 0
    Max = 1000
    Smooth = True
    TabOrder = 2
  end
  object pb_mem: TProgressBar
    Left = 40
    Top = 272
    Width = 121
    Height = 17
    Min = 0
    Max = 1000
    Smooth = True
    TabOrder = 3
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 240
    Top = 64
  end
  object Timer_Auto: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer_AutoTimer
    Left = 320
    Top = 64
  end
  object Timer_SetGitSize: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer_SetGitSizeTimer
    Left = 328
    Top = 128
  end
  object Timer_CPU: TTimer
    OnTimer = Timer_CPUTimer
    Left = 80
    Top = 64
  end
  object Timer_ClearMemory: TTimer
    Enabled = False
    Interval = 3600000
    OnTimer = Timer_ClearMemoryTimer
    Left = 80
    Top = 128
  end
end
