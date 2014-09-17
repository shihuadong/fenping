unit SetWall;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  ExtCtrls, SUIProgressBar;

 


  type
  pCmdInfo=^TCmdInfo;
  TCmdInfo=record
    Cmd: Byte;  //0关闭视频   1 播放  2设置(设置参数，但是不播放)  3关闭单路监视器   4  关闭全部监视器   7 保存单路监视器  8保存全部监视器  9 马上显示默认视频  10得到CPU和内存
    isUsed:Integer;                  //0 没有使用 1已经使用
    DvrType:array[0..15] of Char;
    IP:array[0..14] of Char;
    Port:Integer;
    User:array[0..15] of Char;
    Pass:array[0..15] of Char;
    Ch:Integer;
    StreamType:Integer;//码流类型：0-主码流，1-子码流，2-码流3，3-码流4，以此类推
    
    MonitorNum:Integer;  //第几块屏幕  主屏是0 范围0..9
    WinCount:Integer;  //设置单监视器的分屏数量 默认1 范围1..16
    WinNum:Integer; //在单显示器上的第几个小窗口上播放，默认0  范围0..15
    Cut:Integer;//是否是拼接屏幕  0 false  1 true  默认0
    CutCount:Integer;//切成几块 4 、6等   默认4
    CutType:Integer;//按照什么方式来切 1..9  默认 1
    CutPos:Integer;  //显示第几块小图片 默认0 范围:0..CutCount  不要超过上限
//    4分屏 最左下面一个屏的CutPos是 0，最右上方的的是3
//    2 3
//    0 1

end;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    E_IP: TEdit;
    lbl3: TLabel;
    E_Port: TEdit;
    lbl4: TLabel;
    E_Ch: TEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    E_User: TEdit;
    E_Pass: TEdit;
    lbl7: TLabel;
    E_MonitorNum: TEdit;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    E_WinCount: TEdit;
    E_WinNum: TEdit;
    E_Cut: TEdit;
    E_CutCount: TEdit;
    E_CutType: TEdit;
    E_CutPos: TEdit;
    lbl14: TLabel;
    E_WallServerIP: TEdit;
    btn2: TButton;
    IdUDPClient1: TIdUDPClient;
    BtSend: TButton;
    lbl15: TLabel;
    CB_CMD: TComboBox;
    lbl16: TLabel;
    lbl17: TLabel;
    E_SteamType: TEdit;
    E_DvrType: TComboBox;
    L_cpu: TLabel;
    pb_cpu: TsuiProgressBar;
    L_memo: TLabel;
    pb_mem: TsuiProgressBar;
    P0: TPanel;
    P1: TPanel;
    P2: TPanel;
    P3: TPanel;
    lbl18: TLabel;
    Edit1: TEdit;
    btn1: TButton;
    rb1: TRadioButton;
    rb2: TRadioButton;
    Timer1: TTimer;
    btn3: TButton;
    procedure BtSendClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure P0Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BtSendClick(Sender: TObject);
var
  std:TCmdInfo;
  s:string;
begin

  FillChar(std,SizeOf(TCmdInfo),#0);

  std.Cmd:=StrToInt(CB_CMD.Text);

  std.isUsed:=0;
  s:=E_DvrType.Text;
  Move(s[1],std.DvrType[0],Length(s));

  s:=E_IP.Text;
  Move(s[1],std.IP[0],Length(s));

  std.Port:=StrToInt(E_Port.Text);



  s:=E_User.Text;
  Move(s[1],std.User[0],Length(s));

  s:=E_Pass.Text;
  Move(s[1],std.Pass[0],Length(s));

  std.Ch:=StrToInt(E_Ch.Text);

  std.StreamType:=StrToInt(E_SteamType.Text);

  
  std.MonitorNum:=StrToInt(E_MonitorNum.Text);
  std.WinCount:=StrToInt(E_WinCount.Text);
  std.WinNum:=StrToInt(E_WinNum.Text);
  std.Cut:=StrToInt(E_Cut.Text);
  std.CutCount:=StrToInt(E_CutCount.Text);
  std.CutType:=StrToInt(E_CutType.Text);
  std.CutPos:=StrToInt(E_CutPos.Text);

  IdUDPClient1.Host:=E_WallServerIP.Text;
  IdUDPClient1.Port:=30512;
  IdUDPClient1.Active:=True;
  IdUDPClient1.SendBuffer(std,SizeOf(TCmdInfo));

  if std.Cmd=10 then
  begin
   try
    IdUDPClient1.ReceiveBuffer(std,SizeOf(std));

      pb_cpu.Position :=  std.MonitorNum;
      pb_mem.Position :=  std.WinNum;

   except
     ShowMessage('无心跳');

   end;
  end;


  IdUDPClient1.Active:=False;

end;

procedure TForm1.btn2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.P0Click(Sender: TObject);

begin
  if rb1.Checked then  //单独监视器播放
  begin
    if (Sender as TPanel).Color=clHighlight then
    begin
      (Sender as TPanel).Color:=clBlue;
      CB_CMD.Text:='1';
    end
    else
    begin
      (Sender as TPanel).Color:=clHighlight;
      CB_CMD.Text:='0';
    end;

    E_MonitorNum.Text:= IntToStr((Sender as TPanel).Tag);
    E_Cut.Text:='0';

    BtSend.Click;


  end
  else  //大屏播放
  begin

    if (Sender as TPanel).Color=clHighlight then
    begin
      P0.Color:=clBlue;
      P1.Color:=clBlue;
      P2.Color:=clBlue;
      P3.Color:=clBlue;
      //在0号屏解码
      E_Cut.Text:='1';
      CB_CMD.Text:='1';
      E_MonitorNum.Text:='0';
      E_CutPos.Text:='0';
      BtSend.Click;
      //依次设置1 2 3号屏
      CB_CMD.Text:='2';

      E_MonitorNum.Text:='1';
      E_CutPos.Text:='1';
      BtSend.Click;

      E_MonitorNum.Text:='2';
      E_CutPos.Text:='2';
      BtSend.Click;

      E_MonitorNum.Text:='3';
      E_CutPos.Text:='3';
      BtSend.Click;

    end
    else
    begin
      P0.Color:=clHighlight;
      P1.Color:=clHighlight;
      P2.Color:=clHighlight;
      P3.Color:=clHighlight;
      //关闭0号屏

      //在0号屏解码
      E_Cut.Text:='0';
      CB_CMD.Text:='0';
      E_MonitorNum.Text:='0';
      E_CutPos.Text:='0';
      BtSend.Click;

    end

  end;  


end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  Timer1.Interval:=StrToInt(Edit1.Text)*1000;
  E_Ch.Text:='1';
  E_MonitorNum.Text:='0';

  Timer1.Enabled:=True; 
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
  Timer1.Enabled:=False;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var ch,mo:Integer;
begin

  if rb1.Checked then  //单独监视器播放
  begin

    CB_CMD.Text:='1';
    E_Cut.Text:='0';

    BtSend.Click;
    P0.Color:=clHighlight;
    P1.Color:=clHighlight;
    P2.Color:=clHighlight;
    P3.Color:=clHighlight;

    case StrToInt(E_MonitorNum.Text) of
      0:P0.Color:=clBlue;
      1:P1.Color:=clBlue;
      2:P2.Color:=clBlue;
      3:P3.Color:=clBlue;
    end;

  end
  else  //大屏播放
  begin


      //在0号屏解码
      E_Cut.Text:='1';
      CB_CMD.Text:='1';
      E_MonitorNum.Text:='0';
      E_CutPos.Text:='0';
      BtSend.Click;
      //依次设置1 2 3号屏
      CB_CMD.Text:='2';

      E_MonitorNum.Text:='1';
      E_CutPos.Text:='1';
      BtSend.Click;

      E_MonitorNum.Text:='2';
      E_CutPos.Text:='2';
      BtSend.Click;

      E_MonitorNum.Text:='3';
      E_CutPos.Text:='3';
      BtSend.Click;

      P0.Color:=clBlue;
      P1.Color:=clBlue;
      P2.Color:=clBlue;
      P3.Color:=clBlue;


  end;


  ch:=StrToInt(E_Ch.Text)+1;
  if ch>8 then ch:=1;
  E_Ch.Text:=IntToStr(ch);

  mo:=StrToInt(E_MonitorNum.Text)+1;
  if mo>3 then mo:=0;
   E_MonitorNum.Text:=IntToStr(mo);

end;

end.
