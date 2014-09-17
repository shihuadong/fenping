object Form1: TForm1
  Left = 192
  Top = 130
  BorderStyle = bsSingle
  Caption = 'Ver.2014-1-10 18:52:05'
  ClientHeight = 523
  ClientWidth = 958
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 24
    Top = 24
    Width = 41
    Height = 13
    Caption = 'DvrType'
  end
  object lbl2: TLabel
    Left = 24
    Top = 61
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object lbl3: TLabel
    Left = 24
    Top = 98
    Width = 19
    Height = 13
    Caption = 'Port'
  end
  object lbl4: TLabel
    Left = 24
    Top = 208
    Width = 13
    Height = 13
    Caption = 'Ch'
  end
  object lbl5: TLabel
    Left = 24
    Top = 134
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object lbl6: TLabel
    Left = 24
    Top = 171
    Width = 23
    Height = 13
    Caption = 'Pass'
  end
  object lbl7: TLabel
    Left = 279
    Top = 19
    Width = 57
    Height = 13
    Caption = 'MonitorNum'
  end
  object lbl8: TLabel
    Left = 279
    Top = 51
    Width = 47
    Height = 13
    Caption = 'WinCount'
  end
  object lbl9: TLabel
    Left = 279
    Top = 83
    Width = 41
    Height = 13
    Caption = 'WinNum'
  end
  object lbl10: TLabel
    Left = 279
    Top = 115
    Width = 16
    Height = 13
    Caption = 'Cut'
  end
  object lbl11: TLabel
    Left = 279
    Top = 147
    Width = 44
    Height = 13
    Caption = 'CutCount'
  end
  object lbl12: TLabel
    Left = 279
    Top = 179
    Width = 40
    Height = 13
    Caption = 'CutType'
  end
  object lbl13: TLabel
    Left = 279
    Top = 211
    Width = 34
    Height = 13
    Caption = 'CutPos'
  end
  object lbl14: TLabel
    Left = 32
    Top = 304
    Width = 62
    Height = 13
    Caption = 'WallServerIP'
  end
  object lbl15: TLabel
    Left = 296
    Top = 256
    Width = 24
    Height = 13
    Caption = 'CMD'
  end
  object lbl16: TLabel
    Left = 8
    Top = 376
    Width = 481
    Height = 13
    AutoSize = False
    Caption = '0'#20851#38381#35270#39057'   1 '#25773#25918'  2'#35774#32622'('#35774#32622#21442#25968#65292#20294#26159#19981#25773#25918')'#13#10'3 '#20851#38381#25773#25918#65288#30417#35270#22120#21495' '#31383#21475#21495#65289#13#10' '
  end
  object lbl17: TLabel
    Left = 24
    Top = 240
    Width = 57
    Height = 13
    Caption = 'StreamType'
  end
  object L_cpu: TLabel
    Left = 13
    Top = 416
    Width = 34
    Height = 13
    Caption = 'CPU'#65306
  end
  object L_memo: TLabel
    Left = 209
    Top = 416
    Width = 36
    Height = 13
    Caption = #20869#23384#65306
  end
  object lbl18: TLabel
    Left = 544
    Top = 224
    Width = 60
    Height = 13
    Caption = #38388#38548#26102#38388#65306
  end
  object E_IP: TEdit
    Left = 74
    Top = 57
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '192.168.170.253'
  end
  object E_Port: TEdit
    Left = 74
    Top = 93
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '8000'
  end
  object E_Ch: TEdit
    Left = 74
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object E_User: TEdit
    Left = 74
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'admin'
  end
  object E_Pass: TEdit
    Left = 74
    Top = 164
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '12345'
  end
  object E_MonitorNum: TEdit
    Left = 360
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '0'
  end
  object E_WinCount: TEdit
    Left = 360
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '4'
  end
  object E_WinNum: TEdit
    Left = 360
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object E_Cut: TEdit
    Left = 360
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 8
    Text = '0'
  end
  object E_CutCount: TEdit
    Left = 360
    Top = 143
    Width = 121
    Height = 21
    TabOrder = 9
    Text = '4'
  end
  object E_CutType: TEdit
    Left = 360
    Top = 175
    Width = 121
    Height = 21
    TabOrder = 10
    Text = '1'
  end
  object E_CutPos: TEdit
    Left = 360
    Top = 207
    Width = 121
    Height = 21
    TabOrder = 11
    Text = '3'
  end
  object E_WallServerIP: TEdit
    Left = 104
    Top = 302
    Width = 121
    Height = 21
    TabOrder = 12
    Text = '127.0.0.1'
  end
  object btn2: TButton
    Left = 392
    Top = 344
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 13
    OnClick = btn2Click
  end
  object BtSend: TButton
    Left = 248
    Top = 296
    Width = 75
    Height = 25
    Caption = #21457#36865#25968#25454
    TabOrder = 14
    OnClick = BtSendClick
  end
  object CB_CMD: TComboBox
    Left = 328
    Top = 248
    Width = 65
    Height = 21
    ItemHeight = 13
    TabOrder = 15
    Text = '1'
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20')
  end
  object E_SteamType: TEdit
    Left = 92
    Top = 232
    Width = 103
    Height = 21
    TabOrder = 16
    Text = '0'
  end
  object E_DvrType: TComboBox
    Left = 80
    Top = 24
    Width = 113
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 17
    Text = 'HIK-HS'
    Items.Strings = (
      'HIK-HS'
      'DH'
      'KD')
  end
  object pb_cpu: TsuiProgressBar
    Left = 47
    Top = 417
    Width = 140
    Height = 12
    UIStyle = WinXP
    CaptionColor = clBlack
    ShowCaption = True
    SmartShowCaption = False
    Max = 100
    Min = 0
    Position = 0
    Orientation = suiHorizontal
    BorderColor = 6842472
    Color = 14609391
    Picture.Data = {
      07544269746D617086040000424D860400000000000036040000280000000600
      00000A0000000100080000000000500000000000000000000000000100000000
      000000000000FFFFFF00EFEFEF00ACEDAB0090E88F0090E78E007EE47C0077E2
      760077E2750068DF660045D7420044D7410038D5350031D32E0032D32F0078E2
      76007DE37B0037D53500FFFFFF004D4D4D004242420039393900807CFF005050
      FF009300D600FFECCC00C6D6EF00D6E7E70090A9AD0000003300000066000000
      99000000CC00003300000033330000336600003399000033CC000033FF000066
      00000066330000666600006699000066CC000066FF0000990000009933000099
      6600009999000099CC000099FF0000CC000000CC330000CC660000CC990000CC
      CC0000CCFF0000FF660000FF990000FFCC003300000033003300330066003300
      99003300CC003300FF00333300003333330033336600333399003333CC003333
      FF00336600003366330033666600336699003366CC003366FF00339900003399
      330033996600339999003399CC003399FF0033CC000033CC330033CC660033CC
      990033CCCC0033CCFF0033FF330033FF660033FF990033FFCC0033FFFF006600
      00006600330066006600660099006600CC006600FF0066330000663333006633
      6600663399006633CC006633FF00666600006666330066666600666699006666
      CC00669900006699330066996600669999006699CC006699FF0066CC000066CC
      330066CC990066CCCC0066CCFF0066FF000066FF330066FF990066FFCC00CC00
      FF00FF00CC009999000099339900990099009900CC0099000000993333009900
      66009933CC009900FF00996600009966330099336600996699009966CC009933
      FF009999330099996600999999009999CC009999FF0099CC000099CC330066CC
      660099CC990099CCCC0099CCFF0099FF000099FF330099CC660099FF990099FF
      CC0099FFFF00CC00000099003300CC006600CC009900CC00CC0099330000CC33
      3300CC336600CC339900CC33CC00CC33FF00CC660000CC66330099666600CC66
      9900CC66CC009966FF00CC990000CC993300CC996600CC999900CC99CC00CC99
      FF00CCCC0000CCCC3300CCCC6600CCCC9900CCCCCC00CCCCFF00CCFF0000CCFF
      330099FF6600CCFF9900CCFFCC00CCFFFF00CC003300FF006600FF009900CC33
      0000FF333300FF336600FF339900FF33CC00FF33FF00FF660000FF663300CC66
      6600FF669900FF66CC00CC66FF00FF990000FF993300FF996600FF999900FF99
      CC00FF99FF00FFCC0000FFCC3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF
      3300CCFF6600FFFF9900FFFFCC006666FF0066FF660066FFFF00FF666600FF66
      FF00FFFF66002100A5005F5F5F00777777008686860096969600CBCBCB00B2B2
      B200D7D7D700DDDDDD00E3E3E300EAEAEA00F1F1F100F8F8F800F0FBFF00A4A0
      A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF00F3F3F3F3F3F300000404050505050000080F0808080800000A0A0A0A0A0A
      00000D0D0D0D0D0D00000C0C0C0C0C1100000909090909090000101010101010
      00000303030303030000F3F3F3F3F3F30000}
  end
  object pb_mem: TsuiProgressBar
    Left = 248
    Top = 417
    Width = 140
    Height = 12
    UIStyle = MacOS
    CaptionColor = clBlack
    ShowCaption = True
    SmartShowCaption = False
    Max = 100
    Min = 0
    Position = 0
    Orientation = suiHorizontal
    BorderColor = 8355711
    Color = 15198183
    Picture.Data = {
      07544269746D6170D6040000424DD60400000000000036040000280000000D00
      00000A0000000100080000000000A00000000000000000000000000100000000
      000000000000FFFFFF00B3390000DA9B7700DC9D7600DC9E7900DC9E7600DCA0
      7600DFA37600DFA47700DCA27500DEA27700DEA37700E0873B00DF8A4200E392
      4D00E3935000DFA77A00E08A3F00E08A4000DF8B4200E4914700E18E4700E391
      4A00EB974E00E1904A00E5944E00EC9A5200EE9B5300EB9B5500E5975300EC9D
      5800EFA25B00EEA05B00F9A86000FDAC6400EEA25E00EFA46000FBAC6500F0A5
      6100F0A66400FDAE6A00FBAD6900FFB36D00FEB26D00F3AA6800FDB26F00FFB4
      7100FFB47200FFB47300FFB67600FFBA7A00E5AD7B00E6AE7C00E0AA7A00E7B1
      7F00E9B38200E6B18000E9B48400EAB68800EAB88A00E7B68900E6B48800E6B5
      8800EAB98B00E6B68900E6B58A00E5B68A00E5B68C00EABB9100E9BB9100E7BA
      9100E6B99000EABD9400E9BD9500E9BD9600E7BC9400E7BC9500E7BD9600FFBD
      7B00E7B38200E5B38300EAB88900E7B98C00E6B88C00E7B98D00E7BA8E00E6BA
      8E00E7BB9100E6BB9200FFBB7100FFBC7400FFBC7600FFBF7A00FFC07D00FFC1
      7D00FFC28000FFC48100FFC78400FFC78700FFC87F00FFC88000FFC88200FFCC
      8700FFCD8900FFCC8B00FFCD8300FFCC8600FFCD8800FFCF8A00FFD08B00FFD0
      8700FFD28D00FFD38E00FFD39000FFD49000FFD49100FFD59300FFD69300FFD6
      9400FFD99A00FFD58900FFD89500FFDA9A00FFD88D00FFDA9300FFDB9000FFDF
      9700FFDF9800FFE09A00FFE19D00FFE39E00FFE6A200FFE7A3005C5C5C00FFFF
      FF009933CC009900FF00996600009966330099336600996699009966CC009933
      FF009999330099996600999999009999CC009999FF0099CC000099CC330066CC
      660099CC990099CCCC0099CCFF0099FF000099FF330099CC660099FF990099FF
      CC0099FFFF00CC00000099003300CC006600CC009900CC00CC0099330000CC33
      3300CC336600CC339900CC33CC00CC33FF00CC660000CC66330099666600CC66
      9900CC66CC009966FF00CC990000CC993300CC996600CC999900CC99CC00CC99
      FF00CCCC0000CCCC3300CCCC6600CCCC9900CCCCCC00CCCCFF00CCFF0000CCFF
      330099FF6600CCFF9900CCFFCC00CCFFFF00CC003300FF006600FF009900CC33
      0000FF333300FF336600FF339900FF33CC00FF33FF00FF660000FF663300CC66
      6600FF669900FF66CC00CC66FF00FF990000FF993300FF996600FF999900FF99
      CC00FF99FF00FFCC0000FFCC3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF
      3300CCFF6600FFFF9900FFFFCC006666FF0066FF660066FFFF00FF666600FF66
      FF00FFFF66002100A5005F5F5F00777777008686860096969600CBCBCB00B2B2
      B200D7D7D700DDDDDD00E3E3E300EAEAEA00F1F1F100F8F8F800F0FBFF00A4A0
      A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
      FF0083837D7D7D707C7D7D7B838484000000757569696A646A6A707075757B00
      000061615F4F5B5B5B4F5F61616169000000312C2C29232323292C3131314F00
      00002824241F1D181D1D242428282D0000001A1A1514160D1214161A1A1E1E00
      00003B3A5151373434513A4440404000000049575744445144445757494C4900
      00004C4C4C4C5744444C4C4C494C490000000A0A0A04040405040A0A0A113400
      0000}
  end
  object P0: TPanel
    Left = 536
    Top = 24
    Width = 100
    Height = 80
    Caption = '0'
    Color = clHighlight
    TabOrder = 20
    OnClick = P0Click
  end
  object P1: TPanel
    Tag = 1
    Left = 640
    Top = 24
    Width = 100
    Height = 80
    Caption = '1'
    Color = clHighlight
    TabOrder = 21
    OnClick = P0Click
  end
  object P2: TPanel
    Tag = 2
    Left = 536
    Top = 110
    Width = 100
    Height = 80
    Caption = '2'
    Color = clHighlight
    TabOrder = 22
    OnClick = P0Click
  end
  object P3: TPanel
    Tag = 3
    Left = 640
    Top = 110
    Width = 100
    Height = 80
    Caption = '3'
    Color = clHighlight
    TabOrder = 23
    OnClick = P0Click
  end
  object Edit1: TEdit
    Left = 608
    Top = 221
    Width = 41
    Height = 21
    TabOrder = 24
    Text = '5'
  end
  object btn1: TButton
    Left = 536
    Top = 344
    Width = 75
    Height = 25
    Caption = #24320#22987#36718#35810
    TabOrder = 25
    OnClick = btn1Click
  end
  object rb1: TRadioButton
    Left = 544
    Top = 256
    Width = 113
    Height = 17
    Caption = #21333#23631#25773#25918
    Checked = True
    TabOrder = 26
    TabStop = True
  end
  object rb2: TRadioButton
    Left = 544
    Top = 288
    Width = 113
    Height = 25
    Caption = #22823#23631#25773#25918
    TabOrder = 27
  end
  object btn3: TButton
    Left = 624
    Top = 344
    Width = 75
    Height = 25
    Caption = #32467#26463#36718#35810
    TabOrder = 28
    OnClick = btn3Click
  end
  object IdUDPClient1: TIdUDPClient
    Port = 30512
    Left = 40
    Top = 328
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 680
    Top = 256
  end
end
