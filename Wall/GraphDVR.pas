unit GraphDVR;

interface

uses
  Windows;
const MaxBlock=1024*250;
      WarnBlock=1024*150;
      //MaxBlock=35840;
type
  PDataBlock = ^TDataBlock;
  TDataBlock= record
    Cmd:array [0..4] of Char;  //命令PLAY STOP JPG
    DvrIP: array [0..15] of Char;   //IP
    DvrPort:Integer;    //端口
    DvrChannel:Integer;//通道
    PlayHWND:Integer; //播放控件的handle
    FrameWidth:Integer;
    FrameHeight:Integer;
    FrameFPS:Integer;
    BlockType:Integer;
    FrameNum:Integer;//帧号
    //Reserve:Integer;//备用
    BlockSize:Integer;//JPG实际大小
    Block:array[0..MaxBlock-1] of byte;//存放jpg的包
  end;

type
   BlockPack = record
     BufSize: integer;          //整个报警信息和报警图片大小
     WarnCount: byte;           //警报个数
     WarnType: Integer;           //警报类型
     WarnID: Byte;             //警报ID
     WarnTime: int64;          //警报时间
     LBMPWidth: Integer;       //图片宽
     LBMPHeight: Integer;      //图片高
     LBMPSize: Integer;        //图片大小
     LBMPStartPos: Integer;    //图片起始位置
     LBMPEndPos: Integer;      //图片终止位置
   end;


//     WarnCount: Integer;   //警报个数
//     BufType: Integer;     //包类型
//     BufBegin: Integer;    //包起始位置
//     BufSize: Integer;     //包大小
//     WarnID: Integer;   //警报ID
//     WarnIP:string;            //警报设备IP
//     Warnport: Integer;        //警报设备Port
//     Warnchannel: Integer;     //警报设备通道
//     WarnTime: int64;     //警报时间
//     LBMPWidth: Integer;  //图片宽
//     LBMPHeight: Integer; //图片高
//     LBMPSize: Integer;
//     LBMPBuf: array[0..MaxBlock-1] of byte;   //图片内容

const
  ViewDLL = 'ViewDll03.dll';
  function GInitDLL(): Integer; cdecl; external ViewDLL name 'InitDLL';
  function GPlaylocalFile(INSTANCE: Integer; ViewIp: PChar; Hwnd: hwnd): Integer; cdecl; external ViewDLL name 'PlaylocalFile';
  function GStoplocalFile(INSTANCE: Integer): Integer; cdecl; external ViewDLL name 'StoplocalFile';
  function GGetIdleDecordINSTANCE(): Integer; cdecl; external ViewDLL name 'GetIdleDecordINSTANCE';
  function GSuspendLocalFile(INSTANCE: Integer):Integer; cdecl; external ViewDLL name 'SuspendLocalFile';
  function GPlayContinueLocalFile(INSTANCE: Integer):Integer; cdecl; external ViewDLL name 'PlayContinueLocalFile';


// function ConnectToVideoServer(ServerIP:PChar;ServerPort:Integer):Integer;stdcall;external 'VideoClient.dll';
//  //断开连接视频服务器
//  function TL_NET_DisConnectToVideoServer(instance:integer): Integer; stdcall;external 'VideoClient.dll' name 'DisConnectToVideoServer';
//  //实时播放
//  function TL_NET_RealPlay(instance:Integer;DvrChannel:Integer;PlayHWND:Integer):Integer;stdcall;external 'VideoClient.dll';
//  //停止实时播放
//  function TL_NET_StopRealPlay(instance:Integer;DvrChannel:Integer;PlayHWND:Integer):Integer;stdcall;external 'VideoClient.dll';
//  //录像文件查询
//  function TL_NET_FindRecordFile(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;StartTime:TDateTime;EndTime:TDateTime):Integer;stdcall;external 'VideoClient.dll';
//  //按文件名称回放
//  function TL_NET_PlayBackByFileName(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;PlayHWND:Integer;RecordFileName:PChar;StartPosition:Integer;PlaySpeed:Integer):Integer;stdcall;external 'VideoClient.dll';
//  //按时间回放
//  //function TL_NET_PlayBackByFileTime(DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;StartTime:TDateTime;EndTime:TDateTime):Integer;stdcall;external 'VideoClient.dll';
//  //停止回放
//  function TL_NET_StopPlayBack(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;PlayHWND:Integer):Integer;stdcall;external 'VideoClient.dll';
//  //按文件名称下载
//  function TL_NET_DownLoadByFileName(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;RecordFileName:PChar;SaveFileName:PChar):Integer;stdcall;external 'VideoClient.dll';
//  //按时间下载
//  //function TL_NET_DownLoadByTime
//  //停止下载
//  function TL_NET_StopDownLoad(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer):Integer;stdcall;external 'VideoClient.dll';
//  //初始化CLientDLL

 //连接视频服务器
  function ConnectToVideoServer(ServerIP:PChar;ServerPort:Integer):Integer;stdcall;external 'VideoClient.dll';
  //断开连接视频服务器
  function DisConnectToVideoServer(instance:integer): Integer; stdcall;external 'VideoClient.dll';
  //实时播放
  function TL_NET_RealPlay(instance:integer;DvrChannel:Integer;PlayHWND:Integer):Integer;stdcall;external 'VideoClient.dll';
  //播放IVS
    function TL_NET_PlayIVS(instance:integer;DvrChannel:Integer;PlayHWND:Integer):Integer;stdcall;external 'VideoClient.dll';
  //停止实时播放
  function TL_NET_StopRealPlay(instance:integer;DvrChannel:Integer;PlayHWND:Integer):Integer;stdcall;external 'VideoClient.dll';
  //录像文件查询
  function TL_NET_FindRecordFile(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;StartTime:TDateTime;EndTime:TDateTime):Integer;stdcall;external 'VideoClient.dll';
  //按文件名称回放
  function TL_NET_PlayBackByFileName(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;PlayHWND:Integer;RecordFileName:PChar;StartPosition:Integer;PlaySpeed:Integer):Integer;stdcall;external 'VideoClient.dll';
  //按时间回放
  //function TL_NET_PlayBackByFileTime(DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;StartTime:TDateTime;EndTime:TDateTime):Integer;stdcall;external 'VideoClient.dll';
  //停止回放
  function TL_NET_StopPlayBack(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;PlayHWND:Integer):Integer;stdcall;external 'VideoClient.dll';
  //按文件名称下载
  function TL_NET_DownLoadByFileName(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer;RecordFileName:PChar;SaveFileName:PChar):Integer;stdcall;external 'VideoClient.dll';
  //按时间下载
  //function TL_NET_DownLoadByTime
  //停止下载
  function TL_NET_StopDownLoad(instance:integer;DvrIP:PChar;DvrPort:Integer;DvrChannel:Integer):Integer;stdcall;external 'VideoClient.dll';
  //改变大小
  function TL_NET_Resize(instance:integer;PlayHWND:Integer;width:Integer;height:integer):Integer;stdcall; external 'VideoClient.dll';
  function initClientTCPVideo():boolean;stdcall;external 'VideoClient.dll';
  function FreeClientTCPVideo():boolean;stdcall;external 'VideoClient.dll';
  function PL_setBmpCallBacK(instance:integer;playHD:HWND;pfunc:pointer):integer;stdcall;external 'VideoClient.dll';  //
 type
  TGetPictureFrame = procedure(nFrame: PDataBlock); StdCall;


// typedef int (WINAPI *TBmpCallBack)(char*,int,int,int,int ,int ,int,HWND);
//TBmpCallBack参数说明：char*（BMPbufer）,int(buferSize),bmpWidth,bmpHight,int(帧号),int(通道号),int(数据类型),HWND,句柄

 type
  TBmpCallBack=procedure(BMPbufer: PChar;BufferSize:Integer; BmpWidth:Integer;BmpHight:Integer;FrameNo:Integer;ChannelNo:Integer;DataType:Integer;PlayHwnd:HWND); StdCall;

procedure SetPictureFrameCallBack(aFrame: TGetPictureFrame); stdcall; external 'VideoClient.dll';

implementation

end.
