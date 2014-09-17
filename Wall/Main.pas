unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Monitor, ComCtrls, ExtCtrls,IniFiles, DecodeThreadUnit,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, IdSocketHandle;

type
  pCmdInfo=^TCmdInfo;
  TCmdInfo=record
    Cmd: Byte;                       //0关闭视频   1 播放  2设置(设置参数，但是不播放)  3 其他 9 轮训ini     8保存当前播放参数
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
{
3 关闭单个监视器
4 关闭全部监视器
7 保存单路监视器参数
8保存全部监视器参数
9自动播放配置文件的配置
}

type
  TMainForm = class(TForm)
    grp1: TGroupBox;
    VsMemo: TMemo;
    IdUDPServer1: TIdUDPServer;
    Timer_Auto: TTimer;
    Timer_SetGitSize: TTimer;
    L_cpu: TLabel;
    L_memo: TLabel;
    Timer_CPU: TTimer;
    Timer_ClearMemory: TTimer;
    btn1: TButton;
    pb_cpu: TProgressBar;
    pb_mem: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    procedure Timer_AutoTimer(Sender: TObject);
    procedure Timer_SetGitSizeTimer(Sender: TObject);
    procedure VsMemoChange(Sender: TObject);
    procedure Timer_CPUTimer(Sender: TObject);
    procedure Timer_ClearMemoryTimer(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitMonitors;
    //将BMP图片在Pannel上显示出来
  end;


var
  MainForm: TMainForm;
  //windows系统扩展显示器的上限数量为10个
  MF:array [0..9] of TMonitorForm;
  MonitorCount: Integer;
  isShowMainForm:Boolean;
  isSaveLog:Boolean;
  AutoWaitTime:Integer;
  ClearMemoryTime:Integer;
  G_Checktimes : integer ;
  G_CPUIndex : Integer ;

  G_StatCPU : single ;   //  xx%
  G_StatMem : single ;   // xx%

implementation

uses  DHNetSDKUnit, HCNetSDKUnit, ping, KDNvrSdkUnit, GraphDVR,
  play264DLLunit, CpuUnit;


{$R *.dfm}

procedure TMainForm.InitMonitors;
var
  P: TIniFile;
  DN: TStringList;
  i,j:Integer;
  Cut:Integer;  //是否拼接显示
  CutCount:Integer;//切割数量
  CutType:Integer;//切割类型
  CutPos:Integer; //切割位置
  WinCount:Integer;//单显示器窗口数量
  MonitorName:string;
  WinName:string;

  DevType:string;
  IP:string;
  Port:Integer;
  User:string;
  Pass:string;
  Ch:Integer;
  SteamType:Integer;
  AutoPlay:Integer;
  UserID:Integer;
  RealHandle:Integer;
  LastError:string;

begin
  //windows系统扩展显示器的上限数量为10个
  MonitorCount:=Screen.MonitorCount;
  if MonitorCount>10 then MonitorCount:=10;

  for i:=0 to 9 do
  begin
    MonitorBMP[i]:=TBitmap.Create;
    MonitorBMP[i].PixelFormat:=pf24bit;
    //创建显示窗口
    if MF[i]=nil then  MF[i]:=TMonitorForm.Create(Application);

    //GIT回调用Panel
    GitPanel[i]:=TPanel.Create(nil);
    GitPanel[i].Parent:=MainForm;
    GitPanel[i].Visible:=False;

    //DH回调用Panel
    DHPanel[i]:=TPanel.Create(nil);
    DHPanel[i].Parent:=MainForm;
    DHPanel[i].Visible:=False;
  end;
  //设置显示窗口 的位置
  for i:=0 to MonitorCount-1 do
  with Screen.Monitors[i]do
  begin
    MF[i].Top:=Top;
    MF[i].Left:=Left;

    MF[i].Width:=Width;
    MF[i].Height:=Height;
    MF[i].Lab[0].Caption:=IntToStr(i);
    if i=0  then MF[i].Lab[0].Caption:=MF[i].Lab[0].Caption+'   LoaclIP:'+ GetLocalIP;
    MF[i].Show;

  end;
  P := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Wall.ini');

  isShowMainForm:=P.ReadBool('Basic','isShowMainForm',False);
  isSaveLog:=P.ReadBool('Basic','isSaveLog',False);
  AutoWaitTime:=P.ReadInteger('Basic','AutoWaitTime',60);
  ClearMemoryTime:=p.ReadInteger('Basic','ClearMemoryTime',300);

  Timer_Auto.Interval:=AutoWaitTime*1000;
  Timer_Auto.Enabled:=True;
  VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + IntToStr(AutoWaitTime)+'秒后将自动开启电视墙！');

  Timer_ClearMemory.Interval:=ClearMemoryTime*1000;
  Timer_ClearMemory.Enabled:=True;
  VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + IntToStr(ClearMemoryTime)+'秒定时清理内存！');

  for i := 0 to MonitorCount - 1 do
  begin
    MonitorName:='Monitor'+IntToStr(i);
    Cut:=P.ReadInteger(MonitorName,'Cut',0);
    CutCount:=P.ReadInteger(MonitorName,'CutCount',4);
    CutType:=P.ReadInteger(MonitorName,'CutType',1);
    CutPos:=P.ReadInteger(MonitorName,'CutPos',1);
    WinCount:=P.ReadInteger(MonitorName,'WinCount',1);
    AutoPlay:=P.ReadInteger(MonitorName,'AutoPlay',0);

    if WinCount>16 then WinCount:=16;

    MList[i].Cut:=Cut;
    MList[i].CutCount:=CutCount;
    MList[i].CutType:=CutType;
    MList[i].CutPos:=CutPos;
    MList[i].WinCount:=WinCount;
    MList[i].AutoPlay:=AutoPlay;
    MList[i].FreePort:=-1;

    for j:=0 to 15 do
    begin
      WinName:='w'+IntToStr(j);


      with TStringList.Create do
      try
        try
          Delimiter := ',';
          DelimitedText := P.ReadString(MonitorName, WinName, '');
          if DelimitedText <> '' then
          begin
            DevType := Strings[0];
            IP := Strings[1];
            Port := StrToInt(Strings[2]);
            User := Strings[3];
            Pass := Strings[4];
            CH :=StrToInt(Strings[5]);
            if Count<7 then SteamType:=0
            else
            SteamType :=StrToInt(Strings[6]);
          end
          else
          begin
            DevType:='';
            IP:='';
            Port:=0;
            User:='';
            Pass:='';
            CH:=-1;
            SteamType:=0;
          end;  
        except
          VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + '信息配置错误，无法读入，请检查' + #10#13 + DelimitedText);
        end;
      finally
        Free;
      end;

      MList[i].ChInfo[j].DevType:=DevType;
      MList[i].ChInfo[j].IP:=IP;
      MList[i].ChInfo[j].Port:=Port;
      MList[i].ChInfo[j].User:=User;
      MList[i].ChInfo[j].Pass:=Pass;
      MList[i].ChInfo[j].CH:=CH;
      MList[i].ChInfo[j].StreamType:=SteamType;
      MList[i].ChInfo[j].PlayState:=0;
      MList[i].ChInfo[j].DPort:=i*16+j;
    end;  

  end;


  P.Free;


end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  P: TIniFile;
  i, j: Integer;
  DN: TStringList;
  CH: string;
  ChannelCount: Integer;
  ListItem: TListItem;
begin

  //初始化SDK
  if NET_DVR_Init then VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + 'HIK初始化成功')
  else VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + 'HIK初始化失败');
  if CLIENT_Init(nil,0) then VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + 'DH初始化成功')
  else VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + 'DH初始化失败');

  if (GInitDLL>=0)and initClientTCPVideo  then VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + 'GIT初始化成功')
  else VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + 'GIT初始化失败');


  if (NVR_GetSDKVersion >= 0) and (NVR_Init(20000, 2500, FALSE)) then
      VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + '科达初始化成功')
  else
      VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + '科达初始化失败');


  if initVideoDLL>=0 then
     VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + 'H264初始化成功')
  else VSMemo.Lines.Add(DateTimeToStr(Now) + ' ' + 'H264初始化失败');      

  //监视器初始化和播放默认视频
  InitMonitors;

  //初始化视频参数
  InitShowBMP;

  IdUDPServer1.DefaultPort:=30512;
  IdUDPServer1.Active:=True;

//  MF[0].SetWinCount(9);
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  if isShowMainForm then Exit;
  MainForm.SendToBack;
  if MF[0]<>nil then MF[0].Show;
end;

procedure TMainForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
//  #13 回车
//  #10换行
//  #20为空格
  if Key=#27 then if isShowMainForm then Exit;
  Self.SendToBack;
end;



procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i,j:Integer;
begin
  //大华和海康的SDK释放
  NET_DVR_Cleanup;
  //大华
  CLIENT_Cleanup;
  //科达
  NVR_Cleanup;


end;

procedure TMainForm.IdUDPServer1UDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var
    std:pCmdInfo;
    scd:TCmdInfo;
    DevType:string;
    IP:string;
    Port:Integer;
    User:string;
    Pass:string;
    Ch:Integer;
    ChCount:Integer;
    StreamType:Integer;

    MonitorNum:Integer;  //第几块屏幕  主屏是0 范围0..9
    WinCount:Integer;  //设置单监视器的分屏数量 默认1 范围1..16
    WinNum:Integer; //在单显示器上的第几个小窗口上播放，默认0  范围0..15
    Cut:Integer;//是否是拼接屏幕  0 false  1 true  默认0
    CutCount:Integer;//切成几块 4 、6等   默认4
    CutType:Integer;//按照什么方式来切 1..9  默认 1
    CutPos:Integer;  //显示第几块小图片 默认0 范围:0..CutCount  不要超过上限


    UserID,RealHandle:LongInt;
    PHwnd:LongInt;
    DecodeNo:Integer;
    LastError:string;
    PUser:Integer;
    i,j:Integer;
begin
  Timer_Auto.Enabled:=False;

  New(std);
  AData.Read(std^,SizeOf(TCmdInfo));

  //设置解码通道
  IP:=StrPas(@std.IP);
  Port:=std.Port;
  DevType:=StrPas(@std.DvrType);
  Ch:=std.Ch;

  StreamType:=std.StreamType;

  User:=StrPas(@std.User);
  Pass:=StrPas(@std.Pass);

  MonitorNum:=std.MonitorNum;
  WinCount:=std.WinCount;
  WinNum:=std.WinNum;
  Cut:=std.Cut;
  CutCount:=std.CutCount;
  CutType:=std.CutType;
  CutPos:=std.CutPos;
  VsMemo.Lines.Add(DateTimeToStr(Now)+' '+'收到指令 '+IntToStr(std.Cmd));
  //HIK-HS,192.168.170.253,8000,admin,12345,1,0
  VsMemo.Lines.Add(DevType+','+IP+','+IntToStr(Port)+','+User+','+Pass+','+IntToStr(Ch)+','+IntToStr(StreamType));

  if MonitorNum<0 then Exit;
  if MonitorNum>9 then Exit;
  if WinNum<0 then Exit;
  if WinNum>15 then Exit;
  
  //无监视器则不处理
  if MonitorNum>MonitorCount-1 then Exit;


 //0关闭视频   1 播放  2设置(设置参数，但是不播放)  3关闭单路监视器   4  关闭全部监视器   7 保存单路监视器  8保存全部监视器  9 马上显示默认视频  10得到CPU和内存

  //关闭指定视频 主要根据 监视器号和窗口号  如果是切割屏，关掉其中任何一块，其它全部关掉？？还是保留其它的？？
  //关闭指定监视器、指定窗口的视频
  if std.Cmd=10 then
  begin
    scd.Cmd:=10;
    scd.MonitorNum:=Round(G_StatCPU);
    scd.WinNum:=Round(G_StatMem);
    ABinding.SendTo(ABinding.PeerIP, ABinding.PeerPort, scd, SizeOf(scd));
  end;
  
  if std.Cmd=0 then
  begin
    //  关闭其他监视器上的该通道视频
    if FindMonitorAndWin(DevType,IP,Port,Ch,i,j) then
      ShutVideoByMonitorAndWin(i,j);

    if Cut=1 then  WinNum:=0;
    ShutVideoByMonitorAndWin(MonitorNum,WinNum);

    if (MList[MonitorNum].Cut=1)and (MList[MonitorNum].ChInfo[WinNum].PlayState=0)then
    begin
      //先关闭解码的
      DevType:=MList[MonitorNum].ChInfo[WinNum].DevType;
      IP:=MList[MonitorNum].ChInfo[WinNum].IP;
      Port:=MList[MonitorNum].ChInfo[WinNum].Port;
      Ch:=MList[MonitorNum].ChInfo[WinNum].Ch;
      if FindMonitorAndWin(DevType,IP,Port,Ch,i,j) then
        ShutVideoByMonitorAndWin(i,j);
    end;  



  end;
  if std.Cmd=1 then
  begin
//  关闭其他监视器上的该通道视频
    if FindMonitorAndWin(DevType,IP,Port,Ch,i,j) then
    ShutVideoByMonitorAndWin(i,j);

//  播放视频，播放以前关掉指定监视器号和窗口号的视频，然后打开新视频。
    ShutVideoByMonitorAndWin(MonitorNum,WinNum);

    //如果是拼接屏，强制分屏=1，窗户号=0
    if Cut=1 then
    begin
      WinCount:=1;
      WinNum:=0;
      ShutVideoByMonitorAndWin(MonitorNum,WinNum);
    end;

    //重新设置参数
    MList[MonitorNum].Cut:=Cut;
    MList[MonitorNum].CutCount:=CutCount;
    MList[MonitorNum].CutType:=CutType;
    MList[MonitorNum].CutPos:=CutPos;
    MList[MonitorNum].WinCount:=WinCount;

    MList[MonitorNum].ChInfo[WinNum].DevType:=DevType;
    MList[MonitorNum].ChInfo[WinNum].IP:=IP;
    MList[MonitorNum].ChInfo[WinNum].Port:=Port;
    MList[MonitorNum].ChInfo[WinNum].User:=User;
    MList[MonitorNum].ChInfo[WinNum].Pass:=Pass;
    MList[MonitorNum].ChInfo[WinNum].Ch:=Ch;
    MList[MonitorNum].ChInfo[WinNum].StreamType:=StreamType;
    //调用视频播放
    PlayVideoByMonitorAndWin(MonitorNum,WinNum);
  end;
  
  //设置屏的格式和硬件参数，主要是分屏之类的。
  if std.Cmd=2 then
  begin
    //如果有视频播放，那么先关掉。
//    ShutVideoByMonitorAndWin(MonitorNum,WinNum);

     //如果是拼接屏，强制分屏=1，窗户号=0
    if Cut=1 then
    begin
      WinCount:=1;
      WinNum:=0;
    end;

    //设置窗口数量
    case WinCount of
      1:MF[MonitorNum].SetWinCount(1);
      2..4:MF[MonitorNum].SetWinCount(4);
      5..9:MF[MonitorNum].SetWinCount(9);
      10..16:MF[MonitorNum].SetWinCount(16);
    end;

    //设置参数
    MList[MonitorNum].Cut:=Cut;
    MList[MonitorNum].CutCount:=CutCount;
    MList[MonitorNum].CutType:=CutType;
    MList[MonitorNum].CutPos:=CutPos;
    MList[MonitorNum].WinCount:=WinCount;

    
    MList[MonitorNum].ChInfo[WinNum].DevType:=DevType;
    MList[MonitorNum].ChInfo[WinNum].IP:=IP;
    MList[MonitorNum].ChInfo[WinNum].Port:=Port;
    MList[MonitorNum].ChInfo[WinNum].User:=User;
    MList[MonitorNum].ChInfo[WinNum].Pass:=Pass;
    MList[MonitorNum].ChInfo[WinNum].Ch:=Ch;

    MF[MonitorNum].VP[WinNum].Refresh;

  end;

  //7 保存单路监视器  8保存全部监视器  9 马上显示默认视频

  if std.Cmd=3 then
  begin

    ShutSingleMonitor(MonitorNum);
  end;

  if std.Cmd=4 then
  begin

    ShutAllMonitor;
  end;


  if std.Cmd=7 then
  begin
    SaveSingleMList(MonitorNum);

  end;

  if std.Cmd=8 then
  begin
    SaveAllMList;

  end;

  if std.Cmd=9 then
  begin
    AutoVideo;
  end;

  if std.Cmd=$FF then
  begin
    Application.Terminate;
    Exit;
  end;


//  for i:=1 to 9 do
//   for j:=0 to 15 do
//   begin
//     MF[i].VP[j].Refresh;
//   end;


  Dispose(std);
end;



procedure TMainForm.Timer_AutoTimer(Sender: TObject);
var i:Integer;
   Abmp:TBitmap;
   x,y,w,h:Integer;
begin
  Timer_Auto.Enabled:=False;
  AutoVideo;

//  Abmp:=TBitmap.Create;
//  Abmp.LoadFromFile('C:\1.bmp');
//  for i:=0 to 8 do
//  begin
//    GetBMPXYWH(Abmp,9,1,i,x,y,w,h);
//    ShowBMP(MF[0].VP[i],Abmp,x,y,w,h);
//  end;
//  Abmp.free;

end;

procedure TMainForm.Timer_SetGitSizeTimer(Sender: TObject);
begin
  Timer_SetGitSize.Enabled:=False;
  TL_NET_Resize(GitUserID,MF[GitMonitorNum].VP[GitWinNum].Handle, MF[GitMonitorNum].VP[GitWinNum].Width, MF[GitMonitorNum].VP[GitWinNum].Height);
end;

procedure TMainForm.VsMemoChange(Sender: TObject);
var f:textfile;
    year,month,day:word;
    path,fname,sname,textpath:string;
begin
 if not isSaveLog then Exit;
 decodedate(date,year,month,day);
 fname:=inttostr(year)+'-'+inttostr(month)+'-'+inttostr(day)+'.log';
//创建目录
 path:=extractfilepath(application.ExeName);
 sname:=path+'WallLog';
 if not DirectoryExists(sname) then
        if not createDir(sname)then
           begin
            raise Exception.Create('无法创建存放日志文件的目录,请检查!');
            application.Terminate;
           end;

 textpath:=sname+'\'+fname;
 //不存在就创建
 if not fileexists(textpath) then
   begin
    assignfile(f,textpath);
    Rewrite(f);
    writeln(f,datetimetostr(now)+' 开始记录...');
    CloseFile(F);
   end
 else
 if VsMemo.Lines.count<>0 then
 begin
 assignfile(f,textpath);
 Append(f);
 writeln(f,VsMemo.Lines.Strings[VsMemo.Lines.count-1]);
 Flush(f);
 closefile(f);
 end;
 if VsMemo.Lines.Count>500 then VsMemo.Lines.Clear;

end;

procedure TMainForm.Timer_CPUTimer(Sender: TObject);
var
  VName,VSNumber,PType:string;
  TotalS,TotalF:string;
  MemStatus: TMEMORYSTATUS; //定义内存结构变量
begin
  Timer_CPU.Enabled := False ;
  // 状态采集
  try
    // cpu 占用状态采集
    CollectCPUData ;
    G_StatCPU := ( GetCPUUsage( G_CPUIndex ) * 100 ) ;
    if G_StatCPU < 0 then
      G_StatCPU := 0 ;

    // 内存占用状态采集

    MemStatus.dwLength := sizeof(TMEMORYSTATUS);
    GlobalMemoryStatus(MemStatus); //返回内存使用信息
   // G_StatMem := ( MemStatus.dwAvailPhys / MemStatus.dwTotalPhys * 100  );
    G_StatMem := MemStatus.dwMemoryLoad ;


    pb_cpu.Position :=  Round(G_StatCPU * 10) ;
    pb_mem.Position :=  Round(G_StatMem * 10) ;

  except
  
  end ;

  Timer_CPU.Enabled := True ;
end;

procedure TransMemory;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      SetProcessWorkingSetSize(GetCurrentProcess, $FFFFFFFF, $FFFFFFFF);
      Application.ProcessMessages;
    end;
end;


procedure TMainForm.Timer_ClearMemoryTimer(Sender: TObject);
begin
  TransMemory;
end;

procedure TMainForm.btn1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
