unit DecodeThreadUnit;

interface

uses
  Windows,Forms, Classes, ExtCtrls,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, SysUtils, Graphics, jpeg, winsock, IniFiles,
  HCNetSDKUnit,PlayCtrl, DHNetSDKUnit,KDNvrSdkUnit,dhPlay;

const
  MaxCon=1000;

// var
//   CurDvrType:array[0..9]of string=('HIK-HC','HIK-HS','DH','DL','JT','HIK-HS','XW','','','');

 type //登录表
  TLoginDvrList = record
   DvrType:string;//设备类型
   DvrIP:string; //设备IP
   DvrPort:Integer;//设备端口
   UserID:Longint;//登录句柄
   ChannelCount:Integer;
  end;

 type //播放表
  TPlayDvrList = record
   DvrType:string;//设备类型
   DvrIP:string;
   DvrPort:Integer;//设备端口
   Channel:Integer;
   UserID:LongInt;
   RealHandle:Longint;
   PH:HWND;
  end;

 type //DvrIP和DvrType的对应表
  DvrTypeList = record
   DvrType:string;
   DvrIP: string;
   DvrPort:Integer;
  end;

type
  TChannelInfo=record

    ChannelError:string;
    DPort:Integer;//解码端口
    DecodeNo:Integer;//解码编码，用来在回调中确定是哪个通道。


    DevType:string;
    IP:string;
    Port:Integer;
    User:string;
    Pass:string;
    Ch:Integer;
    StreamType:Integer;

//    UserID:Integer;
//    RealHandle:Integer;
//    PHwnd:Integer;//播放窗口的句柄
//    LastError:string;
    PlayState:Integer;//是否自动播放
  end;

type
  TMonitors=record
    isUsed:Integer;
    Cut:Integer;  //是否切割显示 0 False  1True
    CutCount:Integer;//切割数量
    CutType:Integer;//切割类型
    CutPos:Integer; //显示的切割位置
    WinCount:Integer;//单显示器窗口数量 如果CUT为真，WinCount不起作用，强制1屏
    AutoPlay:Integer;//是否自动启动
    ChInfo:array[0..15]of TChannelInfo;
//    ThreadState:Integer; //线程状态
    FreePort:Integer;
    HasGetDHFrame:Boolean;

    X:Integer;
    Y:Integer;
    W:Integer;
    H:Integer;

  end;

type
  TBmpXY=record
    SX,SY:Integer;
    SW,SH:Integer;
  end;

procedure CreateVideoFilePath();
function HIK_GetError(ErrorNo: Cardinal): string;
function DH_GetError(ErrorNo: Cardinal): string;
function IsValidIP(astrIP: string): Boolean;
function CheckPing(DvrIP: string): Integer;
function CheckTelnet(State_Ping: byte; DvrIP: string; DvrPort: Integer): Integer;

procedure RealDataCallBack_V30(lRealHandle : LONG ; dwDataType : DWORD ; pBuffer : PBYTE ; dwBufSize: DWORD ; PUser : DWORD );stdcall;
procedure DH_RealDataCallBack( lRealHandle : LONG ;  dwDataType : DWORD ; pBuffer: PBYTE ; dwBufSize : DWORD ;  param : LPtagVideoFrameParam ; dwUser :  DWORD );stdcall;
procedure KD_NVRPFRAMECALLBACK(pFrmHdr:LPTNVR_FRAMEHDR;dwParam:DWORD);stdcall;
procedure GetBMPCallBack(BMPbufer: PChar;BufferSize:Integer; BmpWidth:Integer;BmpHight:Integer;FrameNo:Integer;ChannelNo:Integer;DataType:Integer;PlayHwnd:HWND); StdCall;
function videocall(bmpBuf:PChar;bufsize:integer;width:Integer;hight:integer;frameNum:Integer;instance:integer;DateType:integer;playHD:HWND):integer;stdcall;

function LoginDvr(DvrType:string;DvrIP:string;DvrPort:Integer;DvrUserName:string;DvrPassWord:string;var UserID:LongInt;var ChannelCount:Integer;var LastError:string):boolean;
function PlayDvr(UserID:LongInt;var RealHandle:LongInt;PlayWnd:HWND;DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer;PUser:Integer;var LastError:string;Cut:Integer;StreamType:Integer):Boolean;
function StopLoginDvr(DvrType:string;DvrIP:string;DvrPort:Integer):Boolean;
function StopPlayDvr(DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer):Boolean;

procedure InitShowBMP;
procedure ShowVideo(Bmps: Tbitmap; Pan: TPanel);
//function CutPicture(ABMP:TBitmap; CutCount:Integer;CutType:Integer):Boolean;


procedure PlayVideoByMonitorAndWin(MonitorNum:Integer;WinNum:Integer);
function ShutVideoByMonitorAndWin(MonitorNum:Integer;WinNum:Integer):Boolean;


function GetLocalIP:string;

procedure ShowBMP(VideoPanel: TPanel;VideoBMP:TBitmap;SX:Integer;SY:Integer;SW:Integer;SH:Integer);

procedure GetBMPXYWH(ABMP:TBitmap;CutCount:Integer;CutType:Integer;CutPos:Integer;var X,Y,W,H:Integer);

procedure SaveAllMList();

procedure SaveSingleMList(MonitorNum:Integer);

procedure AutoVideo();
procedure ShutAllMonitor();
procedure ShutSingleMonitor(MonitorNum:Integer);

function FindMonitorAndWin(DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer; var MinitorNum:Integer;var WinNum:Integer):Boolean;

procedure AddToLoginList(DvrType:string;DvrIP:string;DvrPort:Integer;UserID:Longint);
procedure DelFromLoginList(i:Integer);

procedure AddToPlayList(DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer;UserID:LongInt;RealHandle:LongInt;PH:HWND);
procedure DelFromPlayList(i:Integer);

function isInLoginList(DvrType:string;DvrIP:string;DvrPort:Integer;var UserID:Longint):Integer;
function isInPlayList(DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer;var UserID:Longint;var RealHandle:LongInt;var PH:HWND):Integer;

function isOtherChannelInPlayList(DvrType:string;DvrIP:string;DvrPort:Integer;var UserID:Longint;var RealHandle:LongInt;var PH:HWND):Integer;


var
  MList:array[0..9]of TMonitors;
  LoginList:array[0..159]of TLoginDvrList;
  PlayList:array[0..159]of TPlayDvrList;

  pBMIInfo: PBITMAPINFO;
  MonitorBMP:array [0..9]of TBitmap;
  BmpXY:array[0..9]of TBmpXY;
  GitUserID,GitMonitorNum,GitWinNum:Integer;
  GitPanel:array[0..9]of TPanel;
  DHPanel:array[0..9]of TPanel;

  isKDFirstCallback: Boolean=False;
  FInstancePlay264:Integer;
  KDMNo: Integer;
  
implementation

uses ping, Main, GraphDVR, play264DLLunit, CpuUnit;

function GetLocalIP:string;
type
 TaPInAddr = array [0..10] of PInAddr;   //用于存储活动的ip地址列表
  PaPInAddr = ^TaPInAddr;
var
  phe  : PHostEnt;
  pptr : PaPInAddr;
  Buffer : array [0..63] of char;    //store hostname
  I    : Integer;
  GInitData      : TWSADATA;
  wVersion:word;
begin
  wVersion:=MAKEWORD(1,1);     //winsock dll version
  Result :='';
  if WSAStartup(wVersion, GInitData)=0 then   //初始化windows socket
  begin
    if GetHostName(Buffer, SizeOf(Buffer))=0 then  //计算机名称
        phe :=GetHostByName(buffer);
   if phe = nil then
       Exit;
   pptr := PaPInAddr(Phe^.h_addr_list);
    I := 0;
    while pptr^[I] <> nil do
    begin
      result:=StrPas(inet_ntoa(pptr^[I]^));
      Inc(I);
    end;
   WSACleanup;           //关闭、清理windows socket
  end;
end;

procedure InitShowBMP;
begin
  pBMIInfo := AllocMem(sizeof(TBITMAPINFO) + (255 * SizeOf(TRGBQuad)));
  pBMIInfo^.bmiHeader.biSize := SizeOf(BITMAPINFOHEADER);
  //pBMIInfo^.bmiHeader.biWidth := OUTPUT_WINDOW_WIDTH;
  //pBMIInfo^.bmiHeader.biHeight := OUTPUT_WINDOW_HEIGHT div 2;
  pBMIInfo^.bmiHeader.biPlanes := 1;
  pBMIInfo^.bmiHeader.biBitCount := 24;
  pBMIInfo^.bmiHeader.biCompression := BI_RGB;
  pBMIInfo^.bmiHeader.biSizeImage := 0;
  pBMIInfo^.bmiHeader.biXPelsPerMeter := 0;
  pBMIInfo^.bmiHeader.biYPelsPerMeter := 0;
  pBMIInfo^.bmiHeader.biClrUsed := 0;
  pBMIInfo^.bmiHeader.biClrImportant := 0;

end;
procedure ShowVideo(Bmps: Tbitmap; Pan: TPanel);
var
  DcS : HDC;
begin
  try
    DcS := GetDc(Pan.Handle);
    pBMIInfo^.bmiHeader.biWidth := Bmps.Width ;
    pBMIInfo^.bmiHeader.biHeight := Bmps.Height;
    SetStretchBltMode(DcS, COLORONCOLOR);
    StretchDIBits(DcS, 0, 0, Pan.Width,Pan.Height,
        0, 0, pBMIInfo^.bmiHeader.biWidth , pBMIInfo^.bmiHeader.biHeight,
        BmpS.ScanLine[BmpS.Height-1], pBMIInfo^, DIB_RGB_COLORS, SRCCOPY);
  finally
    ReleaseDC(Pan.Handle, DcS);
  end;
end;

procedure ShowBMP(VideoPanel: TPanel;VideoBMP:TBitmap;SX:Integer;SY:Integer;SW:Integer;SH:Integer);
var
  HD:HWND;
  DC:HDC;
  PW,PH:Integer;
begin
  PW:=VideoPanel.Width;
  PH:=VideoPanel.Height;
  HD:=VideoPanel.Handle;
  try
    DC:=GetDC(HD);
    SetStretchBltMode(DC, COLORONCOLOR);
    StretchBlt(DC,0,0,PW,PH,VideoBMP.Canvas.Handle,SX,SY,SW,SH,SRCCOPY);
  finally
    ReleaseDC(HD,DC);
  end;
end;


procedure YV12ToYUV420( pBuffer:PByte;Size:Integer;picWide,picHight:Integer);
var
  bufptr,buf:pbyte;
  Ubuflength:Integer;
  ubuf:pbyte;
begin
  Ubuflength:=picWide*picHight div 4;           // Ubuflength: u和v的长度   y:u:v=4:1:1
  bufptr:=pBuffer;                              //fptr指向pBuffer
  Inc(bufptr,picWide*picHight);
  try
      GetMem(ubuf,Ubuflength);                  // 得到一块内存区域ubuf
      buf:=bufptr;
      Inc(buf,Ubuflength);
      CopyMemory(ubuf,bufptr,Ubuflength);       // 将u拷贝到 ubuf中
      Copymemory(bufptr,buf,ubuflength);        // 将v拷到bufptr中
      CopyMemory(buf,ubuf,Ubuflength);          // 将u拷到bufptr中
  finally
      FreeMem(ubuf);
  end;
end;


procedure ClearPlayState(MonitorNum:Integer;WinNum:Integer);
var
  i,j:Integer;
  DevType:string;
  IP:string;
  Port:Integer;
  Ch:Integer;
begin
    DevType:=MList[MonitorNum].ChInfo[WinNum].DevType;
    IP:=MList[MonitorNum].ChInfo[WinNum].IP;
    Port:=MList[MonitorNum].ChInfo[WinNum].Port;
    Ch:=MList[MonitorNum].ChInfo[WinNum].Ch;

    //关闭其他
    for i:=0 to 9 do
      if (MList[i].ChInfo[0].DevType=DevType)and (MList[i].ChInfo[0].IP=IP) and (MList[i].ChInfo[0].Port=Port)
        and (MList[i].ChInfo[j].Ch=Ch) and (MList[i].Cut=1)and (MList[i].ChInfo[j].PlayState=0)
      then
      begin
        MList[i].Cut:=0;
//        MF[MonitorNum].VP[i].Refresh;
//        MF[MonitorNum].Lab[0].Caption:='';
        MF[i].VP[0].Refresh;
        MF[i].Lab[0].Caption:='';
      end;
end;

procedure GetBMPXYWH(ABMP:TBitmap;CutCount:Integer;CutType:Integer;CutPos:Integer;var X,Y,W,H:Integer);
var
  i:Integer;
  AWidth,AHeight:Integer;
  CWidth,CHeight:Integer;
begin

    AHeight:=ABmp.Height;
    AWidth:=ABmp.Width;

    if (CutCount<>4) and (CutCount<>6) and (CutCount<>9) and (CutCount<>12)and (CutCount<>16) then
    begin
      Exit;
    end;

    if CutCount=4 then
    begin
      W:=AWidth div 2;
      H:=AHeight div 2;

      if CutPos=0 then
      begin
        X:=0;
        Y:=0;
      end;

      if CutPos=1 then
      begin
        X:=W;
        Y:=0;
      end;

      if CutPos=2 then
      begin
        X:=0;
        Y:=H;
      end;

      if CutPos=3 then
      begin
        X:=W;
        Y:=H;
      end;

    end;

    if (CutCount=6)and(CutType=1) then
    begin

      W:=AWidth div 3;
      H:=AHeight div 2;

      if CutPos=0 then
      begin
        X:=0;
        Y:=0;
      end;

      if CutPos=1 then
      begin
        X:=W;
        Y:=0;
      end;

      if CutPos=2 then
      begin
        X:=2*W;
        Y:=0;
      end;

      if CutPos=3 then
      begin
        X:=0;
        Y:=H;
      end;

      if CutPos=4 then
      begin
        X:=W;
        Y:=H;
      end;

      if CutPos=5 then
      begin
        X:=2*W;
        Y:=H;
      end;

    end;

   if (CutCount=6)and(CutType=2) then
    begin

      W:=AWidth div 2;
      H:=AHeight div 3;

      if CutPos=0 then
      begin
        X:=0;
        Y:=0;
      end;

      if CutPos=1 then
      begin
        X:=W;
        Y:=0;
      end;

      if CutPos=2 then
      begin
        X:=0;
        Y:=H;
      end;

      if CutPos=3 then
      begin
        X:=W;
        Y:=H;
      end;

      if CutPos=4 then
      begin
        X:=0;
        Y:=2*H;
      end;

      if CutPos=5 then
      begin
        X:=W;
        Y:=2*H;
      end;

    end;


    if CutCount=9 then
    begin
      
      W:=AWidth div 3;
      H:=AHeight div 3;
      
      if CutPos=0 then
      begin
        X:=0;
        Y:=0;
      end;

      if CutPos=1 then
      begin
        X:=W;
        Y:=0;
      end;

      if CutPos=2 then
      begin
        X:=2*W;
        Y:=0;
      end;

      if CutPos=3 then
      begin
        X:=0;
        Y:=H;
      end;

      if CutPos=4 then
      begin
        X:=W;
        Y:=H;
      end;

      if CutPos=5 then
      begin
        X:=2*W;
        Y:=H;
      end;

      if CutPos=6 then
      begin
        X:=0;
        Y:=2*H;
      end;

      if CutPos=7 then
      begin
        X:=W;
        Y:=2*H;
      end;

      if CutPos=8 then
      begin
        X:=2*W;
        Y:=2*H;
      end;

    end;

    //4*3
    if (CutCount=12)and(CutType=1) then
    begin

      W:=AWidth div 4;
      H:=AHeight div 3;

      if CutPos=0 then
      begin
        X:=0;
        Y:=0;
      end;

      if CutPos=1 then
      begin
        X:=W;
        Y:=0;
      end;

      if CutPos=2 then
      begin
        X:=2*W;
        Y:=0;
      end;

      if CutPos=3 then
      begin
        X:=3*W;
        Y:=0;
      end;



      if CutPos=4 then
      begin
        X:=0;
        Y:=H;
      end;

      if CutPos=5 then
      begin
        X:=W;
        Y:=H;
      end;

      if CutPos=6 then
      begin
        X:=2*W;
        Y:=H;
      end;

      if CutPos=7 then
      begin
        X:=3*W;
        Y:=H;
      end;


      if CutPos=8 then
      begin
        X:=0;
        Y:=2*H;
      end;

      if CutPos=9 then
      begin
        X:=W;
        Y:=2*H;
      end;

      if CutPos=10 then
      begin
        X:=2*W;
        Y:=2*H;
      end;

      if CutPos=11 then
      begin
        X:=3*W;
        Y:=2*H;
      end;

    end;
    //3*4
    if (CutCount=12)and(CutType=2) then
    begin

      W:=AWidth div 3;
      H:=AHeight div 4;

      if CutPos=0 then
      begin
        X:=0;
        Y:=0;
      end;

      if CutPos=1 then
      begin
        X:=W;
        Y:=0;
      end;

      if CutPos=2 then
      begin
        X:=2*W;
        Y:=0;
      end;



      if CutPos=3 then
      begin
        X:=0;
        Y:=H;
      end;

      if CutPos=4 then
      begin
        X:=W;
        Y:=H;
      end;

      if CutPos=5 then
      begin
        X:=2*W;
        Y:=H;
      end;




      if CutPos=6 then
      begin
        X:=0;
        Y:=2*H;
      end;

      if CutPos=7 then
      begin
        X:=W;
        Y:=2*H;
      end;


      if CutPos=8 then
      begin
        X:=2*W;
        Y:=2*H;
      end;




      if CutPos=9 then
      begin
        X:=0;
        Y:=3*H;
      end;

      if CutPos=10 then
      begin
        X:=W;
        Y:=3*H;
      end;

      if CutPos=11 then
      begin
        X:=2*W;
        Y:=3*H;
      end;

    end;


    if CutCount=16 then
    begin
      
      W:=AWidth div 4;
      H:=AHeight div 4;
      
      if CutPos=0 then
      begin
        X:=0;
        Y:=0;
      end;

      if CutPos=1 then
      begin
        X:=W;
        Y:=0;
      end;

      if CutPos=2 then
      begin
        X:=2*W;
        Y:=0;
      end;

      if CutPos=3 then
      begin
        X:=3*W;
        Y:=0;
      end;




      if CutPos=4 then
      begin
        X:=0;
        Y:=H;
      end;

      if CutPos=5 then
      begin
        X:=W;
        Y:=H;
      end;

      if CutPos=6 then
      begin
        X:=2*W;
        Y:=H;
      end;

      if CutPos=7 then
      begin
        X:=3*W;
        Y:=H;
      end;


      if CutPos=8 then
      begin
        X:=0;
        Y:=2*H;
      end;
      if CutPos=9 then
      begin
        X:=W;
        Y:=2*H;
      end;
      if CutPos=10 then
      begin
        X:=2*W;
        Y:=2*H;
      end;
      if CutPos=11 then
      begin
        X:=3*W;
        Y:=2*H;
      end;



      if CutPos=12 then
      begin
        X:=0;
        Y:=3*H;
      end;
      if CutPos=13 then
      begin
        X:=W;
        Y:=3*H;
      end;
      if CutPos=14 then
      begin
        X:=2*W;
        Y:=3*H;
      end;
      if CutPos=15 then
      begin
        X:=3*W;
        Y:=3*H;
      end;


    end;
    



end;
{
function CutPicture(ABMP:TBitmap; CutCount:Integer;CutType:Integer):Boolean;
var
  i:Integer;
  BA,BC:array of Byte;
  AWidth,AHeight:Integer;
  CWidth,CHeight:Integer;
  BmpSize,CBMPSize:Integer;
  RowSize,CRowSize:Integer;
  OffSize1,OffSize2:Integer; //偏移地址
  function GetRowBits(W:Integer):Integer;
  begin
    Result:=(W * 3 + 2) and not 3; // 24位图像每行数据字节
  end;
begin
  Result:=True;
  try
    AHeight:=ABmp.Height;
    AWidth:=ABmp.Width;

    if AWidth mod 2<>0 then AWidth:=AWidth+1;
    if AHeight mod 2<>0 then AHeight:=AHeight-1;


    if CutCount=4 then
    begin

    end;

    if (CutCount=6)and(CutType=1) then
    begin

      OffSize1:=AWidth mod 3 -1;

      OffSize2:=AWidth mod 3;
    end;

    if (CutCount=6)and(CutType=2) then
    begin

    end;

    if CutCount=9 then
    begin
      OffSize1:=AWidth mod 3 -1;

      OffSize2:=AWidth mod 3;


    end;


    RowSize:= GetRowBits(AWidth);
    BmpSize:= RowSize * AHeight;        // 图像总的字节数

    SetLength(BA,BmpSize);
    //BMP图片数据复制到BA里面
    CopyMemory(BA,ABmp.ScanLine[AHeight - 1],BmpSize);

//    23
//    01     图片切4份的对应关系，类型无所谓  默认1


//    3 4 5
//    0 1 2   图片切6份，类型1

//      45
//      23
//      01   类型2

//       678
//       345
//       012

    if (CutCount<>4) and (CutCount<>6) and (CutCount<>9)then
    begin
      Result:=False;
      Exit;
    end;  

    for i:=Low(MonitorBMP) to High(MonitorBMP) do
    begin

      case CutCount of
        4:
        begin
          MonitorBMP[i].Height:=AHeight div 2;
          MonitorBMP[i].Width:=AWidth div 2;
        end;
        6:
        begin
         //根据CutCount和CutType CutPos 分割图片
          if CutType=1 then
          begin
            MonitorBMP[i].Height:=AHeight div 2;
            MonitorBMP[i].Width:=AWidth div 3;
          end;

          if CutType=2 then
          begin
            MonitorBMP[i].Height:=AHeight div 3;
            MonitorBMP[i].Width:=AWidth div 2;
          end;

        end;
        9:
        begin

          MonitorBMP[i].Height:=AHeight div 3;
          MonitorBMP[i].Width:=AWidth div 3;

//          if MonitorBMP[i].Width mod 2<>0 then MonitorBMP[i].Width:=MonitorBMP[i].Width-1;
//         if AHeight mod 2<>0 then AHeight:=AHeight-1;

        end;
      end;
    end;
    //得到小图片的宽高
    CWidth:=MonitorBMP[0].Width;
    CHeight:=MonitorBMP[0].Height;
    //得到小图片每行字节和位图大小
    CRowSize:=GetRowBits(CWidth);
    CBMPSize:=CRowSize*CHeight;

    //设置小图片缓存大小
    SetLength(BC,CBMPSize);

     if CutCount=4 then
     begin
       //复制小图片0的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[0].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(0,CHeight+2,MonitorBMP[0]);
//       ShowVideo(MonitorBMP[0],MF[0].VP[3]);


       //复制小图片1的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[(i+1)*RowSize- RowSize div 2],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[1].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,CHeight+2,MonitorBMP[1]);
//      ShowVideo(MonitorBMP[1],MF[0].VP[4]);

       //复制小图片2的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+BmpSize div 2],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[2].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(0,0,MonitorBMP[2]);
//      ShowVideo(MonitorBMP[2],MF[0].VP[0]);

       //复制小图片3的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[(i+1)*RowSize- RowSize div 2+ BmpSize div 2],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[3].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//      ShowVideo(MonitorBMP[3],MF[0].VP[1]);
     end;


     if (CutCount=6)and(CutType=1) then
     begin
       //复制小图片0的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[0].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(0,CHeight+2,MonitorBMP[0]);
//       ShowVideo(MonitorBMP[0],MF[0].VP[3]);


       //复制小图片1的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[(i+1)*RowSize- 2*(RowSize div 3)+OffSize1 ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[1].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,CHeight+2,MonitorBMP[1]);
//      ShowVideo(MonitorBMP[1],MF[0].VP[4]);

       //复制小图片2的数据

       for i:= 0 to CHeight -1 do
       begin
         Move(BA[(i+1)*RowSize- RowSize div 3 + OffSize2 ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[2].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,CHeight+2,MonitorBMP[1]);
//       ShowVideo(MonitorBMP[2],MF[0].VP[5]);


        //复制小图片3的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+BmpSize div 2],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[3].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(0,0,MonitorBMP[2]);
//       ShowVideo(MonitorBMP[3],MF[0].VP[0]);


       //复制小图片4的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize +RowSize div 3+ BmpSize div 2 +OffSize1 ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[4].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//      ShowVideo(MonitorBMP[4],MF[0].VP[1]);


       //复制小图片5的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+ 2*(RowSize div 3)+ BmpSize div 2 +OffSize2  ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[5].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//      ShowVideo(MonitorBMP[5],MF[0].VP[2]);

     end;

 if (CutCount=6)and(CutType=2) then
     begin
      //复制小图片0的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[0].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(0,CHeight+2,MonitorBMP[0]);
//       ShowVideo(MonitorBMP[0],MF[0].VP[6]);


       //复制小图片1的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[(i+1)*RowSize- RowSize div 2],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[1].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,CHeight+2,MonitorBMP[1]);
//      ShowVideo(MonitorBMP[1],MF[0].VP[7]);

       //复制小图片2的数据

       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+BmpSize div 3],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[2].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,CHeight+2,MonitorBMP[1]);
//       ShowVideo(MonitorBMP[2],MF[0].VP[3]);


        //复制小图片3的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+BmpSize div 3+RowSize div 2],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[3].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(0,0,MonitorBMP[2]);
//       ShowVideo(MonitorBMP[3],MF[0].VP[4]);


       //复制小图片4的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+2*( BmpSize div 3)],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[4].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//       ShowVideo(MonitorBMP[4],MF[0].VP[0]);


       //复制小图片5的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+2*( BmpSize div 3)+RowSize div 2],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[5].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//       ShowVideo(MonitorBMP[5],MF[0].VP[1]);

     end;


 if CutCount=9 then
     begin
      //复制小图片0的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[0].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(0,CHeight+2,MonitorBMP[0]);
//       ShowVideo(MonitorBMP[0],MF[0].VP[6]);


       //复制小图片1的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[(i+1)*RowSize- 2*(RowSize div 3)+OffSize1 ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[1].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,CHeight+2,MonitorBMP[1]);
//       ShowVideo(MonitorBMP[1],MF[0].VP[7]);

       //复制小图片2的数据

       for i:= 0 to CHeight -1 do
       begin
         Move(BA[(i+1)*RowSize - RowSize div 3 +OffSize2 ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[2].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,CHeight+2,MonitorBMP[1]);
//       ShowVideo(MonitorBMP[2],MF[0].VP[8]);


        //复制小图片3的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+BmpSize div 3],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[3].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(0,0,MonitorBMP[2]);
//       ShowVideo(MonitorBMP[3],MF[0].VP[3]);


       //复制小图片4的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+ BmpSize div 3+RowSize div 3 +OffSize1 ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[4].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//       ShowVideo(MonitorBMP[4],MF[0].VP[4]);


       //复制小图片5的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+ BmpSize div 3+2*(RowSize div 3)+OffSize2],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[5].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//       ShowVideo(MonitorBMP[5],MF[0].VP[5]);

       //复制小图片6的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+2*( BmpSize div 3)],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[6].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//       ShowVideo(MonitorBMP[6],MF[0].VP[0]);

       //复制小图片7的数据
       for i:= 0 to CHeight -1 do
       begin

         Move(BA[i*RowSize+2*( BmpSize div 3)+RowSize div 3 +OffSize1 ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[7].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//       ShowVideo(MonitorBMP[7],MF[0].VP[1]);

       //复制小图片8的数据
       for i:= 0 to CHeight -1 do
       begin
         Move(BA[i*RowSize+2*( BmpSize div 3)+2*(RowSize div 3) +OffSize2 ],BC[i*CRowSize],CRowSize );
       end;

       CopyMemory(MonitorBMP[8].ScanLine[CHeight - 1],BC, CBMPSize);

  //     Canvas.Draw(CWidth+2,0,MonitorBMP[3]);
//       ShowVideo(MonitorBMP[8],MF[0].VP[2]);

     end;



  except
    Result:=False;
  end;

end;
}

procedure CreateVideoFilePath();
var
  FileName: string;
  H264Path:string;
begin
  H264Path:='D:\';
  //创建年份目录
  FileName := H264Path + FormatDateTime('yyyy', Now);
  if not DirectoryExists(FileName) then
    if not CreateDir(FileName) then
    begin
      raise Exception.Create('无法创建存放录像文件的目录,请检查!'+FileName);
      //Application.Terminate;
    end;

  //创建月份目录
  FileName := H264Path + FormatDateTime('yyyy', Now) + '\' + FormatDateTime('yyyy-mm', Now);
  if not DirectoryExists(FileName) then
    if not CreateDir(FileName) then
    begin
      raise Exception.Create('无法创建存放录像文件的目录,请检查!'+FileName);
      //application.Terminate;
    end;

  //创建每天目录
  FileName := H264Path + FormatDateTime('yyyy', Now) + '\' + FormatDateTime('yyyy-mm', Now) + '\' + FormatDateTime('yyyy-mm-dd', Now);
  if not DirectoryExists(FileName) then
    if not CreateDir(FileName) then
    begin
      raise Exception.Create('无法创建存放录像文件的目录,请检查!'+FileName);
      //application.Terminate;
    end;

end;

function HIK_GetError(ErrorNo: Cardinal): string;
begin
  case ErrorNo of
    NET_DVR_NOERROR: Result := '没有错误';
    NET_DVR_PASSWORD_ERROR: Result := '用户名密码错误';
    NET_DVR_NOENOUGHPRI: Result := '权限不足';
    NET_DVR_NOINIT: Result := '没有初始化';
    NET_DVR_CHANNEL_ERROR: Result := '通道号错误';
    NET_DVR_OVER_MAXLINK: Result := '连接到DVR的客户端个数超过最大';
    NET_DVR_VERSIONNOMATCH: Result := '版本不匹配';
    NET_DVR_NETWORK_FAIL_CONNECT: Result := '连接服务器失败';
    NET_DVR_NETWORK_SEND_ERROR: Result := '向服务器发送失败';
    NET_DVR_NETWORK_RECV_ERROR: Result := '从服务器接收数据失败';
    NET_DVR_NETWORK_RECV_TIMEOUT: Result := '从服务器接收数据超时';
    NET_DVR_NETWORK_ERRORDATA: Result := '传送的数据有误';
    NET_DVR_ORDER_ERROR: Result := '调用次序错误';
    NET_DVR_OPERNOPERMIT: Result := '无此权限';
    NET_DVR_COMMANDTIMEOUT: Result := 'DVR命令执行超时';
    NET_DVR_ERRORSERIALPORT: Result := '串口号错误';
    NET_DVR_ERRORALARMPORT: Result := '报警端口错误';
    NET_DVR_PARAMETER_ERROR: Result := '参数错误';
    NET_DVR_CHAN_EXCEPTION: Result := '服务器通道处于错误状态';
    NET_DVR_NODISK: Result := '没有硬盘';
    NET_DVR_ERRORDISKNUM: Result := '硬盘号错误';
    NET_DVR_DISK_FULL: Result := '服务器硬盘满';
    NET_DVR_DISK_ERROR: Result := '服务器硬盘出错';
    NET_DVR_NOSUPPORT: Result := '设备不支持';
    NET_DVR_BUSY: Result := '服务器忙';
    NET_DVR_MODIFY_FAIL: Result := '服务器修改不成功';
    NET_DVR_PASSWORD_FORMAT_ERROR: Result := '密码输入格式不正确';
    NET_DVR_DISK_FORMATING: Result := '硬盘正在格式化，不能启动操作';
    NET_DVR_DVRNORESOURCE: Result := 'DVR资源不足';
    NET_DVR_DVROPRATEFAILED: Result := 'DVR操作失败';
    NET_DVR_OPENHOSTSOUND_FAIL: Result := '打开PC声音失败';
    NET_DVR_DVRVOICEOPENED: Result := '服务器语音对讲被占用';
    NET_DVR_TIMEINPUTERROR: Result := '时间输入不正确';
    NET_DVR_NOSPECFILE: Result := '回放时服务器没有指定的文件';
    NET_DVR_CREATEFILE_ERROR: Result := '创建文件出错';
    NET_DVR_FILEOPENFAIL: Result := '打开文件出错';
    NET_DVR_OPERNOTFINISH: Result := '上次的操作还没有完成';
    NET_DVR_GETPLAYTIMEFAIL: Result := '获取当前播放的时间出错';
    NET_DVR_PLAYFAIL: Result := '播放出错';
    NET_DVR_FILEFORMAT_ERROR: Result := '文件格式不正确';
    NET_DVR_DIR_ERROR: Result := '路径错误';
    NET_DVR_ALLOC_RESOURCE_ERROR: Result := '资源分配错误';
    NET_DVR_AUDIO_MODE_ERROR: Result := '声卡模式错误';
    NET_DVR_NOENOUGH_BUF: Result := '缓冲区太小';
    NET_DVR_CREATESOCKET_ERROR: Result := '创建SOCKET出错';
    NET_DVR_SETSOCKET_ERROR: Result := '设置SOCKET出错';
    NET_DVR_MAX_NUM: Result := '个数达到最大';
    NET_DVR_USERNOTEXIST: Result := '用户不存在';
    NET_DVR_WRITEFLASHERROR: Result := '写FLASH出错';
    NET_DVR_UPGRADEFAIL: Result := 'DVR升级失败';
    NET_DVR_CARDHAVEINIT: Result := '解码卡已经初始化过';
    NET_DVR_PLAYERFAILED: Result := '调用播放库中某个函数失败';
    NET_DVR_MAX_USERNUM: Result := '设备端用户数达到最大';
    NET_DVR_GETLOCALIPANDMACFAIL: Result := '获得客户端的IP地址或物理地址失败';
    NET_DVR_NOENCODEING: Result := '该通道没有编码';
    NET_DVR_IPMISMATCH: Result := 'IP地址不匹配';
    NET_DVR_MACMISMATCH: Result := 'MAC地址不匹配';
    NET_DVR_UPGRADELANGMISMATCH: Result := '升级文件语言不匹配';
    NET_DVR_MAX_PLAYERPORT: Result := '播放器路数达到最大';
    NET_DVR_NOSPACEBACKUP: Result := '备份设备中没有足够空间进行备份';
    NET_DVR_NODEVICEBACKUP: Result := '没有找到指定的备份设备';
    NET_DVR_PICTURE_BITS_ERROR: Result := '图像素位数不符，限24色';
    NET_DVR_PICTURE_DIMENSION_ERROR: Result := '图片高*宽超限，';
    NET_DVR_PICTURE_SIZ_ERROR: Result := '图片大小超限，限100K';
    NET_DVR_LOADPLAYERSDKFAILED: Result := '载入当前目录下Player';
    NET_DVR_LOADPLAYERSDKPROC_ERROR: Result := '找不到Player';
    NET_DVR_LOADDSSDKFAILED: Result := '载入当前目录下DSsdk出错';
    NET_DVR_LOADDSSDKPROC_ERROR: Result := '找不到DsSdk中某个函数入口';
    NET_DVR_DSSDK_ERROR: Result := '调用硬解码库DsSdk中某个函数失败';
    NET_DVR_VOICEMONOPOLIZE: Result := '声卡被独占';
    NET_DVR_JOINMULTICASTFAILED: Result := '加入多播组失败';
    NET_DVR_CREATEDIR_ERROR: Result := '建立日志文件目录失败';
    NET_DVR_BINDSOCKET_ERROR: Result := '绑定套接字失败';
    NET_DVR_SOCKETCLOSE_ERROR: Result := 'socket连接中断，此错误通常是由于连接中断或目的地不可达';
    NET_DVR_USERID_ISUSING: Result := '注销时用户ID正在进行某操作';
    NET_DVR_SOCKETLISTEN_ERROR: Result := '监听失败';
    NET_DVR_PROGRAM_EXCEPTION: Result := '程序异常';
    NET_DVR_WRITEFILE_FAILED: Result := '写文件失败';
    NET_DVR_FORMAT_READONLY: Result := '禁止格式化只读硬盘';
    NET_DVR_WITHSAMEUSERNAME: Result := '用户配置结构中存在相同的用户名';
    NET_DVR_DEVICETYPE_ERROR: Result := '导入参数时设备型号不匹配';
    NET_DVR_LANGUAGE_ERROR: Result := '导入参数时语言不匹配';
    NET_DVR_PARAVERSION_ERROR: Result := '导入参数时软件版本不匹配';
    NET_DVR_IPCHAN_NOTALIVE: Result := '预览时外接IP通道不在线';
    NET_DVR_RTSP_SDK_ERROR: Result := '加载高清IPC通讯库StreamTransClient失败';
    NET_DVR_CONVERT_SDK_ERROR: Result := '加载转码库失败';
    NET_DVR_IPC_COUNT_OVERFLOW: Result := '超出最大的IP接入通道数';
  else Result := 'HIK未定义的错误!';
  end
end;

function DH_GetError(ErrorNo: Cardinal): string;
begin
  case ErrorNo of
    NET_NOERROR: Result := '没有错误';
  //NET_ERROR:Result:='未知错误';
    NET_SYSTEM_ERROR: Result := 'Windows系统出错';
    NET_NETWORK_ERROR: Result := '网络错误';
    NET_DEV_VER_NOMATCH: Result := '设备协议不匹配';
    NET_INVALID_HANDLE: Result := '句柄无效';
    NET_OPEN_CHANNEL_ERROR: Result := '打开通道失败';
    NET_CLOSE_CHANNEL_ERROR: Result := '关闭通道失败';
    NET_ILLEGAL_PARAM: Result := '用户参数不合法';
    NET_SDK_INIT_ERROR: Result := 'SDK初始化出错';
    NET_SDK_UNINIT_ERROR: Result := 'SDK清理出错';
    NET_RENDER_OPEN_ERROR: Result := '申请render资源出错';
    NET_DEC_OPEN_ERROR: Result := '打开解码库出错';
    NET_DEC_CLOSE_ERROR: Result := '关闭解码库出错';
    NET_MULTIPLAY_NOCHANNEL: Result := '多画面预览中检测到通道数为0';
    NET_TALK_INIT_ERROR: Result := '录音库初始化失败';
    NET_TALK_NOT_INIT: Result := '录音库未经初始化';
    NET_TALK_SENDDATA_ERROR: Result := '发送音频数据出错';
    NET_REAL_ALREADY_SAVING: Result := '实时数据已经处于保存状态';
    NET_NOT_SAVING: Result := '未保存实时数据';
    NET_OPEN_FILE_ERROR: Result := '打开文件出错';
    NET_PTZ_SET_TIMER_ERROR: Result := '启动云台控制定时器失败';
    NET_RETURN_DATA_ERROR: Result := '对返回数据的校验出错';
    NET_INSUFFICIENT_BUFFER: Result := '没有足够的缓存';
    NET_NOT_SUPPORTED: Result := '当前SDK未支持该功能';
    NET_NO_RECORD_FOUND: Result := '查询不到录象';
    NET_NOT_AUTHORIZED: Result := '无操作权限';
    NET_NOT_NOW: Result := '暂时无法执行';
    NET_NO_TALK_CHANNEL: Result := '未发现对讲通道';
    NET_NO_AUDIO: Result := '未发现音频';
    NET_NO_INIT: Result := 'CLientSDK未经初始化';
    NET_DOWNLOAD_END: Result := '下载已结束';
    NET_LOGIN_ERROR_PASSWORD: Result := '密码不正确';
    NET_LOGIN_ERROR_USER: Result := '帐户不存在';
    NET_LOGIN_ERROR_TIMEOUT: Result := '等待登录返回超时';
    NET_LOGIN_ERROR_RELOGGIN: Result := '帐号已登录';
    NET_LOGIN_ERROR_LOCKED: Result := '帐号已被锁定';
    NET_LOGIN_ERROR_BLACKLIST: Result := '帐号已被列为黑名单';
    NET_LOGIN_ERROR_BUSY: Result := '资源不足，系统忙';
    NET_LOGIN_ERROR_CONNECT: Result := '连接主机失败';
    NET_LOGIN_ERROR_NETWORK: Result := '网络连接失败';
    NET_RENDER_SOUND_ON_ERROR: Result := 'Render库打开音频出错';
    NET_RENDER_SOUND_OFF_ERROR: Result := 'Render库关闭音频出错';
    NET_RENDER_SET_VOLUME_ERROR: Result := 'Render库控制音量出错';
    NET_RENDER_ADJUST_ERROR: Result := 'Render库设置画面参数出错';
    NET_RENDER_PAUSE_ERROR: Result := 'Render库暂停播放出错';
    NET_RENDER_SNAP_ERROR: Result := 'Render库抓图出错';
    NET_RENDER_STEP_ERROR: Result := 'Render库步进出错';
    NET_RENDER_FRAMERATE_ERROR: Result := 'Render库设置帧率出错';
    NET_CONFIG_DEVBUSY: Result := '暂时无法设置';
    NET_CONFIG_DATAILLEGAL: Result := '配置数据不合法';
  else Result := 'DH未定义的错误!';
  end;
end;

function IsValidIP(astrIP: string): Boolean;
var
  iCount: Integer;
  iIPLength: Integer;
  iFieldLength: Integer;
  iFieldStart: Integer;
  iDotCount: Integer;
  strTemp: string;
begin
  iIPLength := Length(astrIP);
  if (iIPLength > 15) or (iIPLength < 7) then
  begin
    Result := False; //合法IPv4长度在7和15之间
    Exit;
  end;

  iDotCount := 0;
  iFieldLength := 0;
  iFieldStart := 1;
  for iCount := 1 to iIPLength do
  begin
    case astrIP[iCount] of
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
        begin
          iFieldLength := iFieldLength + 1;
          if (3 < iFieldLength) then
          begin
            Result := False; //IP的单域长度超过3
            Exit;
          end;
        end;
      '.':
        begin
          if 0 = iFieldLength then
          begin
            Result := False; //"."在开头或连续两个"."，或在结尾
            Exit;
          end;
          strTemp := copy(astrIp, iFieldStart, iCount - iFieldStart);
          if (255 < StrToInt(strTemp)) then
          begin
            Result := False; //单域值>255
            Exit;
          end;
          iDotCount := iDotCount + 1;
          if 3 < iDotCount then
          begin
            Result := False; //超过4个域
            Exit;
          end;
          iFieldLength := 0;
          iFieldStart := iCount + 1;
        end;
    else
      begin
        Result := False; //非法字符
        Exit;
      end;
    end;

    Result := True;
  end;
end;

function CheckPing(DvrIP: string): Integer;
var
  NetPing: TPing;
  pinginfo: string;
  i, failCount: Integer;
begin
  result := -1;
  try
    try
      NetPing := TPing.Create;
      if IsValidIP(DvrIP) then
      begin
        failCount := 0;
        for i := 1 to 1 do
        begin
          NetPing.pinghost(DvrIP, pinginfo);
//          sleep(100);
          if pinginfo = 'FAIL' then Inc(failCount);
        end;
        if failCount >= 1 then Result := 1 else Result := 0;
      end
      else
        exit;
    except
      result := 1;
    end
  finally
    NetPing.Free;
  end;
end;

function CheckTelnet(State_Ping: byte; DvrIP: string; DvrPort: Integer): Integer;
var IdTCPClient: TIdTCPClient;
begin
  result := -1;
  if DvrPort <= 0 then exit;

  if State_Ping = 1 then
  begin
    try
      IdTCPClient := TIdTCPClient.Create(nil);
      try
        IdTCPClient.Host := DvrIP;
        IdTCPClient.port := DvrPort;
        IdTCPClient.Connect;
        IdTCPClient.Disconnect;
        result := 1;
      except
        result := 0;
      end;
    finally

      IdTCPClient.Free;
    end;
  end
  else
    result := 0;
end;



procedure SaveSingleMList(MonitorNum:Integer);
var
  P: TIniFile;
  j:Integer;
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
  StreamType:Integer;
  AutoPlay:Integer;
  ChInfo:string;
begin

    P := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Wall.ini');


      MonitorName:='Monitor'+IntToStr(MonitorNum);
      Cut:=MList[MonitorNum].Cut;
      CutCount:=MList[MonitorNum].CutCount;
      CutType:=MList[MonitorNum].CutType;
      CutPos:=MList[MonitorNum].CutPos;
      WinCount:=MList[MonitorNum].WinCount;

      //写入配置文件
      P.WriteInteger(MonitorName,'Cut',Cut);
      P.WriteInteger(MonitorName,'CutCount',CutCount);
      P.WriteInteger(MonitorName,'CutType',CutType);
      P.WriteInteger(MonitorName,'CutPos',CutPos);
      P.WriteInteger(MonitorName,'WinCount',WinCount);

      AutoPlay:=MList[MonitorNum].ChInfo[0].PlayState;

      if Cut=0 then AutoPlay:=0;
      P.WriteInteger(MonitorName,'AutoPlay',AutoPlay);

      for j:=0 to 15 do
      begin
        WinName:='w'+IntToStr(j);

        DevType:=MList[MonitorNum].ChInfo[j].DevType;
        IP:=MList[MonitorNum].ChInfo[j].IP;
        Port:=MList[MonitorNum].ChInfo[j].Port;
        User:=MList[MonitorNum].ChInfo[j].User;
        Pass:=MList[MonitorNum].ChInfo[j].Pass;
        CH:=MList[MonitorNum].ChInfo[j].CH;
        //HIK-HS,192.168.170.253,8000,admin,12345,1,0
        StreamType:=MList[MonitorNum].ChInfo[j].StreamType;

        if IP='' then ChInfo:=''
        else
        ChInfo:=DevType+','+IP+','+IntToStr(Port)+','+User+','+Pass+','+IntToStr(Ch)+','+IntToStr(StreamType);

        P.WriteString(MonitorName,WinName,ChInfo);

      end;

    P.Free;

end;  


procedure SaveAllMList();
var
  i:Integer;
begin
  for i := 0 to 9 do
  begin
    SaveSingleMList(i);
  end;
end;


procedure AutoVideo();
var
  i,j:Integer;
  WinCount:Integer;
  AutoPlay:Integer;
begin
  for i := 0 to 9 do
  begin
    if MList[i].Cut=1 then
    begin
      WinCount:=1;
      ShutVideoByMonitorAndWin(i,0);
      AutoPlay:=MList[i].AutoPlay;
      if AutoPlay=1 then  PlayVideoByMonitorAndWin(i,0);
    end
    else
    begin
      WinCount:=MList[i].WinCount;
      for j:=0 to WinCount-1 do
      begin
        Application.ProcessMessages;
        //播放视频，播放以前关掉指定监视器号和窗口号的视频，然后打开新视频。
        ShutVideoByMonitorAndWin(i,j);
        //调用视频播放
        PlayVideoByMonitorAndWin(i,j);
      end;

    end;

  end;
end;

procedure ShutAllMonitor();
var
  i,j:Integer;
begin
  for i := 0 to 9 do
   for j:=0 to MList[i].WinCount-1 do
   begin
     Application.ProcessMessages;
     //播放视频，播放以前关掉指定监视器号和窗口号的视频，然后打开新视频。
     ShutVideoByMonitorAndWin(i,j);
   end;
end;  

procedure ShutSingleMonitor(MonitorNum:Integer);
var
  i,j:Integer;
begin
   for i:=0 to MList[MonitorNum].WinCount-1 do
   begin
     Application.ProcessMessages;
     //播放视频，播放以前关掉指定监视器号和窗口号的视频，然后打开新视频。
     ShutVideoByMonitorAndWin(MonitorNum,i);
   end;
end;



procedure PNVRMSGCALLBACKFunc(wMessage: WORD; byNVRID: BYTE; wErrorCode: WORD; wContextLen: Word; pContext: PChar; dwSender: DWORD);stdcall;
begin
  //RecordLog('科达进入回调：wMessage:'+inttostr(wMessage)+'  byNVRID:'+inttostr(byNVRID));
end;

function LoginDvr(DvrType:string;DvrIP:string;DvrPort:Integer;DvrUserName:string;DvrPassWord:string;var UserID:LongInt;var ChannelCount:Integer;var LastError:string):Boolean;
var Uid:LongInt;
    ErrorNo:Integer;// DH的错误代码
    HC_DeviceInfo: NET_DVR_DEVICEINFO_v30;
    DH_DeviceInfo: Net_DeviceInfo;
    nRet, KeDaStatus: Boolean;
    gLoginRetn: Byte;
begin
  Result:=False;
  LastError:='';
  ChannelCount:=-1;
  //HS HC 网络包通用的
  if (UpperCase(DvrType)='HIK-HC') or (UpperCase(DvrType)='HIK-HS') then
    begin
      Uid:=NET_DVR_Login_V30( PChar(DvrIP) ,  DvrPort , PChar(DvrUserName) , PChar(DvrPassWord)  , @HC_DeviceInfo ) ;
      if Uid<>-1 then
        begin
          UserID:=Uid;
          Result:=True;
          //更新到LDVR
          ChannelCount:=HC_DeviceInfo.byChanNum;
        end
      else
       begin
         Result:=False;
         LastError:=HIK_GetError(NET_DVR_GetLastError);
       end;
    end;

  if UpperCase(DvrType)='DH' then
    begin
      ErrorNo:=0;
      Uid := CLIENT_LoginEx( PChar(DvrIP) ,  DvrPort , PChar(DvrUserName) , PChar(DvrPassWord)  , 1 , nil , @DH_DeviceInfo , ErrorNo ) ;
      if Uid=0 then Uid:=-1;//DH的设备是0失败,所以统一成 -1是失败
      if Uid<>-1 then
      begin
        UserID:=Uid;
        Result:=True;
        ChannelCount:=DH_DeviceInfo.byChanNum;
      end
      else
       begin
         Result:=False;
         LastError:=DH_GetError(CLIENT_GetLastError);
       end;
    end;



  if UpperCase(DvrType) = 'KD' then
  begin
      nRet := NVR_SetConnectTime(5000,0);
      if ( not nRet) then
      begin
          Exit;
      end;
      nRet := NVR_SetMessageCallBack(@PNVRMSGCALLBACKFunc);
      if ( not nRet) then
      begin
           Exit;
      end;

      gLoginRetn := NVR_NewNVRID();
      KeDaStatus := False;
      nRet := NVR_Connect(gLoginRetn,PChar(DvrIP),DvrPort,PChar(DvrUserName),PChar(DvrPassWord),KeDaStatus,nil,gLoginRetn);
      if ( nRet) then
      begin
        UserID:=gLoginRetn;
        Result:=True;
        MainForm.VsMemo.Lines.Add('科达登陆成功');
      end
      else
      begin
         Result:=False;
         LastError:='科达连接失败！';
         MainForm.VsMemo.Lines.Add('科达连接失败');
      end;

  end;



  if UpperCase(DvrType)='GIT' then
    begin

      UserID := ConnectToVideoServer(PChar(DvrIP), DvrPort);

      if UserID >= 0 then
      begin
        Result:=True;
      end
      else
      begin
        Result:=False;
        LastError:='GIT连接服务器失败';
      end;

    end;

  if Result then AddToLoginList(DvrType,DvrIP,DvrPort,UserID);
end;

function PlayDvr(UserID:LongInt;var RealHandle:LongInt;PlayWnd:HWND;DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer;PUser:Integer;var LastError:string;Cut:Integer;StreamType:Integer):Boolean;
var
  DH_ChannelPREVIEW_Info:DHDEV_PREVIEW_CFG;
  HC_ClientIinfo_V40:NET_DVR_CLIENTINFO_V40;
  HC_ClientIinfo : NET_DVR_CLIENTINFO ;

  nRet: Boolean;
  tDevChnID: TNVR_DEVCHNID;
  nHandle: Cardinal;
  KDPlayHWND: HWND;
  MNo,WNo:Integer;
  DH_StreamType:RealPlayType;

begin
  Result:=False;
  LastError:='';

  MNo:=PUser div 16;
  WNo:=PUser mod 16;

  if (UpperCase(DvrType)='HIK-HC') or (UpperCase(DvrType)='HIK-HS') then
    begin
      //先使用V40来播放

      HC_ClientIinfo_V40.lChannel:=Channel;
      HC_ClientIinfo_V40.dwStreamType :=StreamType;  //码流类型：0-主码流，1-子码流，2-码流3，3-码流4，以此类推
      HC_ClientIinfo_V40.lLinkMode := $0;
      HC_ClientIinfo_V40.hPlayWnd := PlayWnd;
      HC_ClientIinfo_V40.bBlocked := False;
      HC_ClientIinfo_V40.bPassbackRecord := True;
      HC_ClientIinfo_V40.byPreviewMode := 0;
      HC_ClientIinfo_V40.byRes[0] := 0;
      HC_ClientIinfo_V40.sMultiCastIP := nil;




      if Cut=1 then  HC_ClientIinfo_V40.hPlayWnd :=0;
      RealHandle := NET_DVR_RealPlay_V40(UserID,@HC_ClientIinfo_V40,nil,nil);

      if RealHandle<>-1 then
      begin
        Result:=True;
        if Cut=1 then Result:=NET_DVR_SetRealDataCallBack(RealHandle,@RealDataCallBack_V30,PUser);
      end
      else
       LastError:=HIK_GetError(NET_DVR_GetLastError);
      //if RealHandle<>-1 then NET_DVR_ThrowBFrame(RealHandle,2);

      //公司的设备不支持V40函数，浪费了我一个下午最少。
      if LastError='设备不支持' then
      begin
        HC_ClientIinfo.lChannel := Channel ;
        HC_ClientIinfo.lLinkMode := $0 ;
        HC_ClientIinfo.hPlayWnd :=PlayWnd ;
        if StreamType=1 then //副码流
          HC_ClientIinfo.lLinkMode:=$80000000;
        if Cut=1 then HC_ClientIinfo.hPlayWnd :=0 ;

        RealHandle := NET_DVR_RealPlay_V30(UserID,@HC_ClientIinfo,nil,nil,False);

        if RealHandle<>-1 then
        begin
           Result:=True;
           //如果要切屏，调用回调函数
           if Cut=1 then Result:=NET_DVR_SetRealDataCallBack(RealHandle,@RealDataCallBack_V30,PUser);
        end
        else
        LastError:=HIK_GetError(NET_DVR_GetLastError);
      end;

    end;

  if UpperCase(DvrType) = 'DH' then
    begin
      if StreamType=0 then DH_StreamType:=DH_RType_RealPlay ;
      if StreamType=1 then DH_StreamType:=DH_RType_RealPlay_1;

      if Cut=1 then
      begin
//        RealHandle := CLIENT_StartRealPlay(UserID,Channel,PlayWnd, DH_StreamType,DH_RealDataCallBack,nil,@PUser,1000);
        RealHandle :=CLIENT_RealPlayEx(UserID,Channel,DHPanel[MNo].Handle,DH_StreamType) ; //0是不在控件上播放
      end
      else
      RealHandle :=CLIENT_RealPlayEx(UserID,Channel,PlayWnd,DH_StreamType) ; //0是不在控件上播放

      if RealHandle=0 then RealHandle:=-1; //DH的设备是0失败,所以统一成 -1是失败
      Result:=RealHandle<>-1;



      //播放成功,设置回调
      if RealHandle<>-1 then
      begin
         MNo:=PUser div 16;
         if Cut=1 then
         begin
           MList[MNo].HasGetDHFrame:=False;
           Result:=CLIENT_SetRealDataCallBackEx(RealHandle,@DH_RealDataCallBack,PUser,4 );  //4是YUV420数据   以上五种数据类型
         end;
      end
      else LastError:=DH_GetError(CLIENT_GetLastError);
    end;


   if UpperCase(DvrType) = 'KD' then
   begin
      nRet := FALSE;
      FillChar(tDevChnID, SizeOf(TNVR_DEVCHNID), #0);
      tDevChnID.byDevID := Channel;
      tDevChnID.byChnID := 1 ;  //默认为1  ？？？？？
      KDPlayHWND:=PlayWnd;
      if Cut=1 then KDPlayHWND:=0;
      
      //0：主码流  1：辅码流
      Sleep(500);
      FInstancePlay264:=GetIdlevideoINSTANCE();
      if  FInstancePlay264<0 then Exit;

      SetBmpCallBack(FInstancePlay264,pBmpCallBacK(@videocall));

      nHandle := NVR_CreateMonitor(Byte(UserID),tDevChnID,Byte(StreamType),KDPlayHWND);
      if (nHandle = NVR_INVALID_HANDLE) then
      begin
          Result:=False;
          LastError:='科达播放失败!';
          MainForm.VsMemo.Lines.Add('KD播放失败');
      end
      else
      begin
        RealHandle:=nHandle;
        if Cut=1 then //单独播放，不需要回调
        Result := NVR_SetRegFrameCallBack(nHandle,@KD_NVRPFRAMECALLBACK,PUser);
//        MainForm.VsMemo.Lines.Add('KD播放成功，设置回调 FInstancePlay264:'+inttostr(FInstancePlay264));
      end;
   end;


  if UpperCase(DvrType)='GIT' then
  begin

    GitUserID:=UserID;
    GitMonitorNum:=MNo;
    GitWinNum:=WNo;

    if Cut=1 then
      RealHandle := TL_NET_RealPlay(UserID, Channel, GitPanel[MNo].Handle)
    else
    begin
      RealHandle := TL_NET_RealPlay(UserID, Channel, PlayWnd);
      MainForm.Timer_SetGitSize.Enabled:=True;
      TL_NET_Resize(UserID,MF[MNo].VP[WNo].Handle, MF[MNo].VP[WNo].Width, MF[MNo].VP[WNo].Height);
    end;


    if RealHandle >= 0 then
    begin
      Result:=True;

      if Cut=1 then PL_setBmpCallBacK(UserID,GitPanel[MNo].Handle,@GetBMPCallBack);

    end
    else
    begin
      Result:=False;
      LastError:='GIT播放失败';
    end;

  end;

  if Result then AddToPlayList(DvrType,DvrIP,DvrPort,Channel,UserID,RealHandle,PlayWnd);

end;

function StopLoginDvr(DvrType:string;DvrIP:string;DvrPort:Integer):Boolean;
var UserID:Longint;
begin
  //先判断是否已经登录
  Result:=True;

  if isInLoginList(DvrType,DvrIP,DvrPort,UserID)=-1 then Exit;
  //再判断是否在播放

  if (UpperCase(DvrType)='HIK-HC') or (UpperCase(DvrType)='HIK-HS') then
    begin
      Result:=NET_DVR_Logout(UserID);
    end ;


  if UpperCase(DvrType) = 'DH' then
    begin
      Result:=CLIENT_Logout(UserID);
    end ;

    if UpperCase(DvrType) = 'KD' then
    begin
      Result:=NVR_Disconnect(UserID);
    end;


    if UpperCase(DvrType) = 'GIT' then
    begin
      Result:=DisConnectToVideoServer(UserID)>=0;
    end;

  DelFromLoginList(isInLoginList(DvrType,DvrIP,DvrPort,UserID));
end;

function StopPlayDvr(DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer):Boolean;
var
  UserID,RealHandle:Longint;
  PH:HWND;
  i,j:Integer;
  MonitorNum,WinNum:Integer;
  FreePort:Integer;
begin
  //先判断是否已经在播放
  Result:=True;
  if isInPlayList(DvrType,DvrIP,DvrPort,Channel,UserID,RealHandle,PH)=-1 then Exit;

  //停止一路DVR的播放通道
  if (UpperCase(DvrType)='HIK-HC') or (UpperCase(DvrType)='HIK-HS') then
    begin
      
       Result:=NET_DVR_StopRealPlay(RealHandle);
       
      //关闭播放后，停止解码，释放端口
      if FindMonitorAndWin(DvrType,DvrIP,DvrPort,Channel,MonitorNum,WinNum) then
      begin
        FreePort:=MList[MonitorNum].FreePort;
        if FreePort<>-1 then
        begin
          if  Hik_PlayM4_Stop_HS(FreePort) then
            if Hik_PlayM4_CloseStream_HS(FreePort) then
              if Hik_PlayM4_FreePort_HS(FreePort) then
                 MList[MonitorNum].FreePort:=-1;
        end;
      end;

    end ;
  if UpperCase(DvrType) = 'DH' then
    begin
      Result:=CLIENT_StopRealPlayEx(RealHandle);
    end ;


    if UpperCase(DvrType) = 'KD' then
    begin
      Result:=NVR_DestroyMonitor(RealHandle);
    end;


    if UpperCase(DvrType) = 'GIT' then
    begin
      Result:=TL_NET_StopRealPlay(UserID,Channel,PH) >= 0 ;
//      MF[MonitorNum].VP[0].Refresh;
    end;

  //删除播放列表
  DelFromPlayList(isInPlayList(DvrType,DvrIP,DvrPort,Channel,UserID,RealHandle,PH));
  //刷新停止的播放画面
  for i:=1 to 9 do
   for j:=0 to 15 do
     if MF[i].VP[j].Handle=PH then
     begin
       MF[i].VP[j].Refresh;
     end;

end;

procedure PlayVideoByMonitorAndWin(MonitorNum:Integer;WinNum:Integer);
var
  DevType:string;
  IP:string;
  Port:Integer;
  User:string;
  Pass:string;
  Ch:Integer;
  ChCount:Integer;
  StreamType:Integer;

  WinCount:Integer;  //设置单监视器的分屏数量 默认1 范围1..16
  Cut:Integer;//是否是拼接屏幕  0 false  1 true  默认0
//    CutCount:Integer;//切成几块 4 、6等   默认4
//    CutType:Integer;//按照什么方式来切 1..9  默认 1
//    CutPos:Integer;  //显示第几块小图片 默认0 范围:0..CutCount  不要超过上限

  UserID,RealHandle:LongInt;
  PHwnd:LongInt;
  LastError:string;
  PUser:Integer;
begin

  UserID:=-1;
  RealHandle:=-1;
  PHwnd:=-1;
  PUser:=0;

  //根据 MonitorNum和 WinNum，获取基本信息
  Cut:=MList[MonitorNum].Cut;

  WinCount:=MList[MonitorNum].WinCount;

  if Cut=1 then
  begin
    WinCount:=1;
    WinNum:=0;
  end;

  DevType:=MList[MonitorNum].ChInfo[WinNum].DevType;
  IP:=MList[MonitorNum].ChInfo[WinNum].IP;
  Port:=MList[MonitorNum].ChInfo[WinNum].Port;
  User:=MList[MonitorNum].ChInfo[WinNum].User;
  Pass:=MList[MonitorNum].ChInfo[WinNum].Pass;
  Ch:=MList[MonitorNum].ChInfo[WinNum].Ch;
  StreamType:=MList[MonitorNum].ChInfo[WinNum].StreamType;


  if IP='' then Exit;
  
  PUser:=MonitorNum*16+WinNum;
  //在15窗口播放视频，必须强制16分屏。
  if WinCount<WinNum+1 then WinCount:=WinNum+1;

  //设置窗口数量
  case WinCount of
    1:MF[MonitorNum].SetWinCount(1);
    2..4:MF[MonitorNum].SetWinCount(4);
    5..9:MF[MonitorNum].SetWinCount(9);
    10..16:MF[MonitorNum].SetWinCount(16);
  end;


        
  //先测试Ping
    if CheckPing(IP)<>0 then //Ping不通
    begin
      MF[MonitorNum].Lab[WinNum].Caption:='Ping不通';
//      Exit;
    end;

  //获取播放句柄
  PHwnd:=MF[MonitorNum].VP[WinNum].Handle;
  //已经登录
  if isInLoginList(DevType,IP,Port,UserID)>-1 then
  begin
    if PlayDvr(UserID,RealHandle,PHwnd,DevType,IP,Port,Ch,PUser,LastError,Cut,StreamType) then
    begin
      MF[MonitorNum].Lab[WinNum].Caption:='';
      MList[MonitorNum].ChInfo[WinNum].PlayState:=1;
    end
    else
    begin
      MList[MonitorNum].ChInfo[WinNum].PlayState:=0;
      MF[MonitorNum].Lab[WinNum].Caption:=LastError;
      //刷新画面
      MF[MonitorNum].VP[WinNum].Refresh;
    end;
  end
  else
  begin

    if LoginDvr(DevType,IP,Port,User,Pass,UserID,ChCount,LastError) then
    begin
      MF[MonitorNum].Lab[WinNum].Caption:='登录成功';
    end
    else
    begin
      MF[MonitorNum].Lab[WinNum].Caption:=LastError;
      Exit;
    end;

    Sleep(200);

    if PlayDvr(UserID,RealHandle,PHwnd,DevType,IP,Port,Ch,PUser,LastError,Cut,StreamType) then
    begin
      MF[MonitorNum].Lab[WinNum].Caption:='';
      MList[MonitorNum].ChInfo[WinNum].PlayState:=1;
    end
    else
    begin
      MList[MonitorNum].ChInfo[WinNum].PlayState:=0;
      MF[MonitorNum].Lab[WinNum].Caption:=LastError;
      //刷新画面
      MF[MonitorNum].VP[WinNum].Refresh;
    end;

  end;

end;

function ShutVideoByMonitorAndWin(MonitorNum:Integer;WinNum:Integer):Boolean;
var
  i:Integer;
  Cut:Integer;
  DvrType:string;
  IP:string;
  Port:Integer;
  Ch:Integer;

  UserID,RealHandle:LongInt;
  PlayState:Integer;
  PHwnd:HWND;
begin
  Result:=True;
  Cut:=MList[MonitorNum].Cut;
  DvrType:=MList[MonitorNum].ChInfo[WinNum].DevType;
  IP:=MList[MonitorNum].ChInfo[WinNum].IP;
  Port:=MList[MonitorNum].ChInfo[WinNum].Port;
  Ch:=MList[MonitorNum].ChInfo[WinNum].Ch;
  PlayState:= MList[MonitorNum].ChInfo[WinNum].PlayState;

  if PlayState=0 then Exit;

  Result:=StopPlayDvr(DvrType,IP,Port,Ch);
  MList[MonitorNum].ChInfo[WinNum].PlayState:=0;
  MF[MonitorNum].VP[WinNum].Refresh;
  //自动关闭其他cut=1的窗口
  ClearPlayState(MonitorNum,WinNum);

  //判断一下，如果DVR没有播放任何通道，那么退出DVR的登陆
  if isOtherChannelInPlayList(DvrType,IP,Port,UserID,RealHandle,PHwnd)=-1 then
    StopLoginDvr(DvrType,IP,Port);

end;




procedure  HIK_DecCBFun(nPort : long ; pBuf : Pchar ; nSize : long ; pFrameInfo : PFRAME_INFO ;nUser,nReserved2 : long ) ; stdcall;
var
  i:Integer;
  MNo,CNo:Integer;
  X,Y,W,H:Integer;
  ABMP:TBitmap;
  BmpSize:Integer;
  RowSize:Integer;
  PB:PByte;
  CutCount,CutType,CutPos:Integer;
  function GetRowBits(W:Integer):Integer;
  begin
    Result:=(W * 3 + 2) and not 3; // 24位图像每行数据字节
  end;

begin
  MNo:=nUser div 16;
//  CNo:=nUser mod 16;
  CNo:=0;


    //动态建立一个BMP图片，存放回调图片
//    MonitorBMP[MNo]:=TBitmap.Create;
//    MonitorBMP[MNo].PixelFormat:=pf24bit;

    MonitorBMP[MNo].Height:=pFrameInfo.nHeight;
    MonitorBMP[MNo].Width:=pFrameInfo.nWidth;
    RowSize:=GetRowBits(MonitorBMP[MNo].Width);// 24位图像每行数据字节
    BmpSize:= RowSize *MonitorBMP[MNo].Height;// 图像总的字节数

   GetMem(PB, BmpSize);//分配空间

    YUV12ToRGB(pBuf,MonitorBMP[MNo].Width,MonitorBMP[MNo].Height,PB);

    CopyMemory(MonitorBMP[MNo].ScanLine[MonitorBMP[MNo].Height - 1], PB, BmpSize);
    FreeMem(PB,BmpSize);

    for i:=0 to 9 do
      if (MList[MNo].ChInfo[0].DevType=MList[i].ChInfo[0].DevType)and (MList[MNo].ChInfo[0].IP=MList[i].ChInfo[0].IP) and
         (MList[MNo].ChInfo[0].Port=MList[i].ChInfo[0].Port)and (MList[MNo].ChInfo[0].Ch=MList[i].ChInfo[0].Ch)and(MList[i].Cut=1)
      then
      begin
        //根据CutCount和CutType CutPos 分割图片
        CutCount:=MList[i].CutCount;
        CutType:=MList[i].CutType;
        CutPos:=MList[i].CutPos;
        GetBMPXYWH(MonitorBMP[MNo],CutCount,CutType,CutPos,X,Y,W,H);
        ShowBMP(MF[i].VP[0],MonitorBMP[MNo],X,Y,W,H);
      end;


//    FreeAndNil(MonitorBMP[MNo]);
end;

//HIK-HC的回调函数
procedure RealDataCallBack_V30(lRealHandle : LONG ; dwDataType : DWORD ; pBuffer : PBYTE ; dwBufSize: DWORD ; PUser : DWORD );stdcall;
var
  MNo,CNo:Integer;
  DPort:Integer;
  FreePort:Integer;
begin
  DPort:=PUser ;
  if DPort>9*16 then Exit;
  MNo:=DPort div 16;
  CNo:=DPort mod 16;

  if  MList[Mno].Cut=0 then Exit;
  //为了方便，这里不适用PlayM4_GetPort来获取空闲端口了。感觉释放很麻烦。端口最大到500
  //Hik_PlayM4_GetPort_HS(FreePort);
  if MList[Mno].FreePort=-1 then
  begin
    Hik_PlayM4_GetPort_HS(FreePort);
    MList[Mno].FreePort:=FreePort;
  end
  else
  FreePort:=MList[Mno].FreePort;

  case dwDataType of
    NET_DVR_SYSHEAD: //1
    begin
      if not Hik_PlayM4_OpenStream_HS(FreePort, pBuffer, dwBufSize, 1024*1024) then  //超高清图像不知道600*1024是否够用
      begin
        MList[Mno].ChInfo[CNo].ChannelError:='OpenStream失败';
        Exit;
      end;
      if not Hik_PlayM4_SetDecCBStream_HS(FreePort,1) then  //1视频流，2音频流，3复合流
      begin
        MList[Mno].ChInfo[CNo].ChannelError:='PlayM4_SetDecCBStream失败';
        Exit;
      end;
      if not Hik_PlayM4_SetDecCallBackMend_HS(FreePort,@HIK_DecCBFun,DPort) then
      begin
        MList[Mno].ChInfo[CNo].ChannelError:='PlayM4_SetDecCallBackMend失败';
        Exit;
      end;
      if not Hik_PlayM4_Play_HS(FreePort,0) then
      begin
        MList[Mno].ChInfo[CNo].ChannelError:='PlayM4_Play失败';
        Exit;
      end;

    end;

    NET_DVR_STREAMDATA: //2
    begin
      if not Hik_PlayM4_InputData_HS( FreePort , pBuffer , dwBufSize ) then
      begin
        MList[Mno].ChInfo[CNo].ChannelError:='PlayM4_InputData失败';
        MF[MNo].Lab[CNo].Caption:='PlayM4_InputData失败';
//        Hik_PlayM4_FreePort_HS(FreePort);
//        MList[Mno].FreePort:=-1;
        Exit;
      end;
    end;

  end;
end;



{
//KD
procedure KD_NVRPFRAMECALLBACK(pFrmHdr:LPTNVR_FRAMEHDR;dwParam:DWORD);stdcall;
var
  i:Integer;
  MNo,CNo:Integer;
  DPort:Integer;
  BmpSize:Integer;
  RowSize:Integer;
  PB:PByte;
  Cut:Integer;
  CutCount,CutType,CutPos:Integer;
  ABMP:TBitmap;
  X,Y,W,H:Integer;
  function GetRowBits(W:Integer):Integer;
  begin
    Result:=(W * 3 + 2) and not 3; // 24位图像每行数据字节
  end;
begin
//  MainForm.VsMemo.Lines.Add(pFrmHdr.m_byMediaType);

  DPort:=dwParam ;
  if DPort>9*16 then Exit;
  MNo:=DPort div 16;
  CNo:=DPort mod 16;

  if pFrmHdr.m_byMediaType<>'j' then Exit;

  try
    //动态建立一个BMP图片，存放回调图片
    ABMP:=TBitmap.Create;
    ABMP.PixelFormat:=pf24bit;


    ABMP.Height:=pFrmHdr.m_tVideoParam.struct.m_wVideoHeight;
    ABMP.Width:= pFrmHdr.m_tVideoParam.struct.m_wVideoWidth;
    
  if pFrmHdr.m_tVideoParam.struct.m_wVideoHeight=1920 then
  begin
    ABMP.Height:=1080;
    ABMP.Width:= 1920;
  end;

  if pFrmHdr.m_tVideoParam.struct.m_wVideoHeight=1280 then
  begin
    ABMP.Height:=720;
    ABMP.Width:=1280;
  end;


//    MainForm.VsMemo.Lines.Add('图像宽'+inttostr(ABMP.Width)+' 图像高'+inttostr(ABMP.Height));
//    MainForm.VsMemo.Lines.Add('图像大小'+inttostr(pFrmHdr.m_dwDataSize));

    RowSize:=GetRowBits(ABMP.Width);// 24位图像每行数据字节
    BmpSize:= RowSize * ABMP.Height;// 图像总的字节数

    GetMem(PB, BmpSize);//分配空间
    
    //是否要偏移？？？
    Inc(pFrmHdr.m_pData,pFrmHdr.m_dwPreBufSize);

    YUV420ToRGB(pFrmHdr.m_pData,ABMP.Width,ABMP.Height,PB);

    CopyMemory(ABMP.ScanLine[ABMP.Height - 1], PB, BmpSize);


      if MList[MNo].Cut=1 then
      for i:=0 to 9 do
        if (MList[MNo].ChInfo[0].DevType=MList[i].ChInfo[0].DevType)and (MList[MNo].ChInfo[0].IP=MList[i].ChInfo[0].IP) and
           (MList[MNo].ChInfo[0].Port=MList[i].ChInfo[0].Port)and (MList[MNo].ChInfo[0].Ch=MList[i].ChInfo[0].Ch)and(MList[i].Cut=1)
        then
        begin
          //根据CutCount和CutType CutPos 分割图片
          Cut:=MList[i].Cut;
          CutCount:=MList[i].CutCount;
          CutType:=MList[i].CutType;
          CutPos:=MList[i].CutPos;
          GetBMPXYWH(ABMP,CutCount,CutType,CutPos,X,Y,W,H);
          ShowBMP(MF[i].VP[0],Abmp,X,Y,W,H);
        end;


  finally
    FreeMem(PB,BmpSize);
    FreeAndNil(ABMP);
  end;


end;
}

function videocall(bmpBuf:PChar;bufsize:integer;width:Integer;hight:integer;frameNum:Integer;instance:integer;DateType:integer;playHD:HWND):integer;stdcall;
var
  i:integer;
   bmpheader:BITMAPFILEHEADER;
  bmpinfo:BITMAPINFOHEADER;
  ms:TMemoryStream;
  ABMP:TBitmap;
  CNo:Integer;
  X,Y,W,H:Integer;
    BmpSize:Integer;
  RowSize:Integer;
  PB:PByte;
  Cut:Integer;
  CutCount,CutType,CutPos:Integer;
  function GetRowBits(W:Integer):Integer;
  begin
    Result:=(W * 3 + 2) and not 3; // 24位图像每行数据字节
  end;
  function GetMonitorNumByPlayHandle(PHwnd:HWND):Integer;
  var i:Integer;
  begin
    Result:=-1;
    for i:=0 to 9 do
      if PHwnd=GitPanel[i].Handle then
      begin
        Result:=i;
        Break;
      end;  
  end;
begin
//    RecordLog('进入BMP回调  width：'+inttostr(width)+'  width:'+inttostr(hight)+'  bufsize:'+inttostr(bufsize)+'  frameNum:'+inttostr(frameNum)+'  instance:'+inttostr(instance)
//             +'  DateType:'+inttostr(DateType)+'  playHD:'+inttostr(playHD)+'  KDMNo:'+inttostr(KDMNo));
    KDMNo:=1 div 16;
    Inc(KDMNo);
    if KDMNo = 5 then
    begin
        KDMNo := 1;
    end;

//    KDMNo:=GetMonitorNumByPlayHandle(playHD);
    CNo:=0;
    bmpheader.bfType:=$4d42;
    bmpheader.bfReserved1:=0;
    bmpheader.bfReserved2:=0;
    bmpheader.bfOffBits:=SizeOf(BITMAPFILEHEADER)+sizeof(BITMAPINFOHEADER);
    bmpheader.bfSize:=bmpheader.bfOffBits+Width*hight*24*8;
    bmpinfo.biSize:=sizeof(BITMAPINFOHEADER);
    bmpinfo.biWidth:=Width;
    bmpinfo.biHeight:=hight;
    bmpinfo.biPlanes:=1;
    bmpinfo.biBitCount:=24;
    bmpinfo.biCompression:=BI_RGB;
    bmpinfo.biSizeImage:=(Width*24+31)div 32*4*hight;
    bmpinfo.biSizeImage:=0;
    bmpinfo.biXPelsPerMeter:=100;
    bmpinfo.biYPelsPerMeter:=100;
    bmpinfo.biClrUsed:=0;
    bmpinfo.biClrImportant:=0;
    try
        ms:=TMemoryStream.Create;
        ms.WriteBuffer(bmpheader,SizeOf(bmpheader));
        ms.WriteBuffer(bmpinfo,sizeof(bmpinfo));
        ms.WriteBuffer(bmpBuf^,bufsize-54);
        //ms.SaveToFile('C:\'+inttostr(frameNum)+'.bmp');
        ms.Seek(0,0);
        ABMP:=TBitmap.Create;
        ABMP.PixelFormat:=pf24bit;
        ABMP.Height:=hight;
        ABMP.Width:=width;
        RowSize:=GetRowBits(ABMP.Width);// 24位图像每行数据字节
        BmpSize:= RowSize * ABMP.Height;// 图像总的字节数
        //GetMem(PB, BmpSize);//分配空间
        //YUV12ToRGB(pBuf,ABMP.Width,ABMP.Height,PB);
        //CopyMemory(ABMP.ScanLine[ABMP.Height - 1], PB, BmpSize);
        ABMP.LoadFromStream(ms);
//        if MList[KDMNo].Cut=1 then
        for i:=0 to 9 do
          if (MList[KDMNo].ChInfo[0].DevType=MList[i].ChInfo[0].DevType)and (MList[KDMNo].ChInfo[0].IP=MList[i].ChInfo[0].IP) and
             (MList[KDMNo].ChInfo[0].Port=MList[i].ChInfo[0].Port)and (MList[KDMNo].ChInfo[0].Ch=MList[i].ChInfo[0].Ch)and(MList[i].Cut=1)
          then
          begin
              //根据CutCount和CutType CutPos 分割图片
              Cut:=MList[i].Cut;
              CutCount:=MList[i].CutCount;
              CutType:=MList[i].CutType;
              CutPos:=MList[i].CutPos;
              GetBMPXYWH(ABMP,CutCount,CutType,CutPos,X,Y,W,H);
              ShowBMP(MF[i].VP[0],Abmp,X,Y,W,H);
          end;
    finally
      FreeAndNil(ABMP);
      ms.Free;
    end;
end;

procedure KD_NVRPFRAMECALLBACK(pFrmHdr:LPTNVR_FRAMEHDR;dwParam:DWORD);stdcall;
var
  FParamUser:PParamUser;
  ru:integer;
  VideoWidth, VideoHeight: Integer;
begin
   if not isKDFirstCallback then
   begin
      //设置参数
//      VideoWidth := pFrmHdr.m_tVideoParam.m_wVideoWidth;
//      VideoHeight := pFrmHdr.m_tVideoParam.m_wVideoHeight;
      VideoWidth := 1280;
      VideoHeight := 720;
      New(FParamUser);
      FParamUser.width:=VideoWidth;
      FParamUser.height:=VideoHeight;
      FParamUser.playWidth:=1;
      FParamUser.playHeight:=1;
      FParamUser.fps:=25;
      FParamUser.playHandle:=mainForm.Handle;
      FParamUser.stopPlay:=0;
      ru:= InitParamPB(FInstancePlay264,FParamUser);
      Dispose(FParamUser);
      if ru<0 then
      begin
//         RecordLog('科达264解码错误！');
        Exit;
      end;
      isKDFirstCallback := true;
//      RecordLog('科达第一次进入回调！');
   end;
   try
      if pFrmHdr.m_byMediaType<>'j' then Exit;
       begin
         inputBuf(FInstancePlay264, pFrmHdr.m_pData, pFrmHdr.m_dwDataSize);
//         RecordLog('科达播放视频  m_wVideoHeight：'+inttostr(VideoHeight)+'  m_wVideoWidth:'+inttostr(VideoWidth)+
//          '  m_dwPreBufSize:'+floatToStr(pFrmHdr.m_dwPreBufSize)+'  pFrmHdr.m_dwDataSize:'+floatToStr(pFrmHdr.m_dwDataSize));
       end;
   except
//       RecordLog('inputBuf 异常'+inttostr(VideoHeight)+'  m_wVideoWidth:'+inttostr(VideoWidth));
   end;

end;



//procedure DHDecCBFun(nPort:LONG;pBuf:Pchar;nSize:LONG;pFrameInfo:PFRAME_INFO;pUserData:Pointer;nReserved2:LONG);stdcall;
//begin
//
//end;

//DH的回调函数
procedure DH_RealDataCallBack( lRealHandle : LONG ;  dwDataType : DWORD ; pBuffer: PBYTE ; dwBufSize : DWORD ;  param : LPtagVideoFrameParam ; dwUser :  DWORD );stdcall;
var
  i:Integer;
  MNo,CNo:Integer;
  LPFrameParam:LPtagVideoFrameParam;
  BmpSize:Integer;
  RowSize:Integer;
  PB:PByte;
  Cut:Integer;
  CutCount,CutType,CutPos:Integer;
  ABMP:TBitmap;
  FrameType:Byte;
  X,Y,W,H:Integer;
  DPort,FreePort:Integer;
  function GetRowBits(W:Integer):Integer;
  begin
    Result:=(W * 3 + 2) and not 3; // 24位图像每行数据字节
  end;

begin
  MNo:=dwUser div 16;
  CNo:=dwUser mod 16;

  if dwDataType=2 then
  begin
    FrameType:=param.size;
   //CIF - 0, HD1 - 1, 2CIF - 2, D1 - 3, VGA - 4, QCIF - 5, QVGA - 6 ,SVCD - 7,QQVGA - 8, SVGA - 9, XVGA - 10,WXGA - 11,SXGA - 12,WSXGA - 13,UXGA - 14,WUXGA - 15.

    case FrameType of
      0:begin
          W:=352;
          H:=288;
        end;
      1:begin
          W:=352;
          H:=576;
        end;
      2:begin
          W:=352;
          H:=288;
        end;
      3:begin
          W:=704;
          H:=576;
        end;
      4:begin
          W:=640;
          H:=480;
        end;
      5:begin
          W:=176;
          H:=144;
        end;
      6:begin
          W:=320;
          H:=240;
        end;
      7:begin
          W:=480;
          H:=480;
        end;
      8:begin
          W:=160;
          H:=128;
        end;
      9:begin
          W:=800;
          H:=592;
        end;
     10:begin
          W:=1024;
          H:=768;
        end;
     11:begin
          W:=1280;
          H:=800;
        end;
     12:begin
          W:=1280;
          H:=1024;
        end;

     13:begin
          W:=1600;
          H:=1024;
        end;
     14:begin
          W:=1600;
          H:=1200;
        end;
     15:begin
          W:=1920;
          H:=1200;
        end;
     16:begin
          W:=1280;
          H:=720;
        end;

     17:begin
          W:=1920;
          H:=1080;
        end;



    else Exit;
    end;


    try
      //动态建立一个BMP图片，存放回调图片
      ABMP:=TBitmap.Create;
      ABMP.PixelFormat:=pf24bit;

      ABMP.Height:=H;
      ABMP.Width:=W;

      RowSize:=GetRowBits(ABMP.Width);// 24位图像每行数据字节
      BmpSize:= RowSize * ABMP.Height;// 图像总的字节数

      GetMem(PB, BmpSize);//分配空间

      YUV420ToRGB(PChar(pBuffer),ABMP.Width,ABMP.Height,PB);

      CopyMemory(ABMP.ScanLine[ABMP.Height - 1], PB, BmpSize);

      for i:=0 to 9 do
        if (MList[MNo].ChInfo[0].DevType=MList[i].ChInfo[0].DevType)and (MList[MNo].ChInfo[0].IP=MList[i].ChInfo[0].IP) and
           (MList[MNo].ChInfo[0].Port=MList[i].ChInfo[0].Port)and (MList[MNo].ChInfo[0].Ch=MList[i].ChInfo[0].Ch)and(MList[i].Cut=1)
        then
        begin
          //根据CutCount和CutType CutPos 分割图片
          CutCount:=MList[i].CutCount;
          CutType:=MList[i].CutType;
          CutPos:=MList[i].CutPos;
          GetBMPXYWH(ABMP,CutCount,CutType,CutPos,X,Y,W,H);
          ShowBMP(MF[i].VP[0],Abmp,X,Y,W,H);
        end;


    finally
      FreeMem(PB,BmpSize);
      FreeAndNil(ABMP);
    end;

  end;
end;

//BMp回调
procedure GetBMPCallBack(BMPbufer: PChar;BufferSize:Integer; BmpWidth:Integer;BmpHight:Integer;FrameNo:Integer;ChannelNo:Integer;DataType:Integer;PlayHwnd:HWND); StdCall;
var 
  i:Integer;
  MNo,CNo:Integer;
  BmpSize:Integer;
  RowSize:Integer;
  Cut:Integer;
  CutCount,CutType,CutPos:Integer;
  ABMP:TBitmap;
  FrameType:Byte;
  X,Y,W,H:Integer;
  function GetRowBits(W:Integer):Integer;
  begin
    Result:=(W * 3 + 2) and not 3; // 24位图像每行数据字节
  end;

  function GetMonitorNumByPlayHandle(PHwnd:HWND):Integer;
  var i:Integer;
  begin
    Result:=-1;
    for i:=0 to 9 do
      if PHwnd=GitPanel[i].Handle then
      begin
        Result:=i;
        Break;
      end;  
  end;
begin

  MNo:=GetMonitorNumByPlayHandle(PlayHwnd);
  if MNo=-1 then Exit;
  CNo:=0;

  try

    //动态建立一个BMP图片，存放回调图片
    ABMP:=TBitmap.Create;
    ABMP.PixelFormat:=pf24bit;

    ABMP.Width:=BmpWidth;
    ABMP.Height:=BmpHight;

    RowSize:=GetRowBits(ABMP.Width);// 24位图像每行数据字节
    BmpSize:= RowSize * ABMP.Height;// 图像总的字节数


    CopyMemory(ABMP.ScanLine[ABMP.Height - 1], BMPbufer, BmpSize-54);


    for i:=0 to 9 do
      if (MList[MNo].ChInfo[0].DevType=MList[i].ChInfo[0].DevType)and (MList[MNo].ChInfo[0].IP=MList[i].ChInfo[0].IP) and
         (MList[MNo].ChInfo[0].Port=MList[i].ChInfo[0].Port)and (MList[MNo].ChInfo[0].Ch=MList[i].ChInfo[0].Ch)and(MList[i].Cut=1) 
      then
      begin
        //根据CutCount和CutType CutPos 分割图片
        CutCount:=MList[i].CutCount;
        CutType:=MList[i].CutType;
        CutPos:=MList[i].CutPos;
        GetBMPXYWH(ABMP,CutCount,CutType,CutPos,X,Y,W,H);
        ShowBMP(MF[i].VP[0],Abmp,X,Y,W,H);
      end;

  finally
    FreeAndNil(ABMP);
  end;


end;




procedure AddToLoginList(DvrType:string;DvrIP:string;DvrPort:Integer;UserID:Longint);
var
  i:Integer;
begin
  if isInLogInList(DvrType,DvrIP,DvrPort,UserID)>-1 then Exit;
  
  for i:=Low(LoginList) to High(LoginList) do
    if LoginList[i].DvrIP='' then
    begin
      LoginList[i].DvrType:=DvrType;
      LoginList[i].DvrIP:=DvrIP;
      LoginList[i].DvrPort:=DvrPort;
      LoginList[i].UserID:=UserID;
      Break;
    end;
end;
procedure DelFromLoginList(i:Integer);
begin
  if i=-1 then Exit;
  LoginList[i].DvrType:='';
  LoginList[i].DvrIP:='';
  LoginList[i].DvrPort:=0;
  LoginList[i].UserID:=-1;
end;

procedure AddToPlayList(DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer;UserID:LongInt;RealHandle:LongInt;PH:HWND);
var
  i:Integer;
begin
  if isInPlayList(DvrType,DvrIP,DvrPort,Channel,UserID,RealHandle,PH)>-1 then Exit;
  for i:=Low(PlayList) to High(PlayList) do
    if PlayList[i].DvrIP='' then
    begin
      PlayList[i].DvrType:=DvrType;
      PlayList[i].DvrIP:=DvrIP;
      PlayList[i].DvrPort:=DvrPort;
      PlayList[i].Channel:=Channel;
      PlayList[i].UserID:=UserID;
      PlayList[i].RealHandle:=RealHandle;
      PlayList[i].PH:=PH;
      Break;
    end;
end;


procedure DelFromPlayList(i:Integer);
begin
  if i=-1 then Exit;
  PlayList[i].DvrType:='';
  PlayList[i].DvrIP:='';
  PlayList[i].DvrPort:=0;
  PlayList[i].Channel:=-1;
  PlayList[i].UserID:=-1;
  PlayList[i].RealHandle:=-1;
  PlayList[i].PH:=0;
end;  



function isInLoginList(DvrType:string;DvrIP:string;DvrPort:Integer;var UserID:Longint):Integer;
var
  i:Integer;
begin
  Result:=-1;
  for i:=Low(LoginList) to High(LoginList) do
    if (LoginList[i].DvrType=DvrType)and(LoginList[i].DvrIP=DvrIP)and(LoginList[i].DvrPort=DvrPort) then
    begin
      UserID:=LoginList[i].UserID;
      Result:=i;
      Break;
    end;
end;

function isInPlayList(DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer;var UserID:Longint;var RealHandle:LongInt;var PH:HWND):Integer;
var
  i:Integer;
begin
  Result:=-1;
  for i:=Low(PlayList) to High(PlayList) do
    if (PlayList[i].DvrType=DvrType)and(PlayList[i].DvrIP=DvrIP)and(PlayList[i].DvrPort=DvrPort)and(PlayList[i].Channel=Channel) then
    begin
      UserID:=PlayList[i].UserID;
      RealHandle:=PlayList[i].RealHandle;
      PH:=PlayList[i].PH;
      Result:=i;
      Break;
    end;
end;


function isOtherChannelInPlayList(DvrType:string;DvrIP:string;DvrPort:Integer;var UserID:Longint;var RealHandle:LongInt;var PH:HWND):Integer;
var
  i:Integer;
begin
  Result:=-1;
  for i:=Low(PlayList) to High(PlayList) do
    if (PlayList[i].DvrType=DvrType)and(PlayList[i].DvrIP=DvrIP)and(PlayList[i].DvrPort=DvrPort)and(PlayList[i].RealHandle >-1) then
    begin
      UserID:=PlayList[i].UserID;
      RealHandle:=PlayList[i].RealHandle;
      PH:=PlayList[i].PH;
      Result:=i;
      Break;
    end;
end;

function FindMonitorAndWin(DvrType:string;DvrIP:string;DvrPort:Integer;Channel:Integer; var MinitorNum:Integer;var WinNum:Integer):Boolean;
var
  i,j:Integer;
  UserID,RealHandle:Integer;
  PH:HWND;
begin
  Result:=False;
  if isInPlayList(DvrType,DvrIP,DvrPort,Channel,UserID,RealHandle,PH)=-1 then Exit;
  for i:=0 to 9 do
    for j:=0 to 15 do
    begin
      if MF[i].VP[j].Handle=PH then
      begin
        Result:=True;
        MinitorNum:=i;
        WinNum:=j;
        Break;
      end;
      if Result then Break;
    end;

end;  

end.

