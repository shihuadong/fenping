unit play264DLLunit;


interface
uses windows;
const
  play264DLL = 'playH264ThreadDLL2.dll';
type
  PparamUser=^TparamUser;
  TparamUser=record
  width:integer;
  height:integer;
  playWidth:integer;
  playHeight:integer;
  fps:integer;
  playHandle:hwnd;
  stopPlay:integer;
  playChannel:integer;
end;
type
pDrawRectCallBack=^TDrawRectCallBack;
TDrawRectCallBack=function(bmpBuf:pchar;width:integer;height:integer):integer;stdcall; //提供bmp流用于rect区域
type
pBmpCallBack=^TBmpCallBack;
TBmpCallBack=function(bmpBuf:PChar;bufsize:integer;width:Integer;hight:integer;frameNum:Integer;instance:integer;DateType:integer;playHD:HWND):integer;stdcall;
type
PDrawLineCallBack=^TDrawLineCallBack;
TDrawLineCallBack=function(Data:integer;DC:HDC):integer;stdcall;
/////////////////////////////////////////////////////////////////////
//说明：
//此设备函数如果错误返回值一律为-1。
//错误代码可以通过HieGetLastError 获取
////////////////////////////////////////////////////////////////////
//function InitParam(pb:PparamUser):integer;cdecl; external play264DLL name 'InitParam';
//function Initplay():integer;cdecl; external play264DLL name 'Initplay';
//function pause():integer;cdecl; external play264DLL name 'pause';
//function play():integer;cdecl; external play264DLL name 'play';
//function stop():integer;cdecl; external play264DLL name 'stop';
//function inputBuf(buf:PChar;bufsize:integer):integer;cdecl; external play264DLL name 'inputBuf';
//function clearParam():Integer;cdecl; external play264DLL name 'clearParam';
function InitParamPB(INSTANCE:integer;pb:PparamUser):integer;cdecl; external play264DLL name 'InitVideoParam';
function pause(INSTANCE:integer):integer;cdecl; external play264DLL name 'pauseVideos';
function play(INSTANCE:integer):integer;cdecl; external play264DLL name 'playVideos';
function stop(INSTANCE:integer):integer;cdecl; external play264DLL name 'freeVideos';
function inputBuf(INSTANCE:integer;buf:PChar;bufsize:integer):integer;cdecl; external play264DLL name 'inputBuf';
function GetIdlevideoINSTANCE():integer;cdecl;external play264DLL name 'GetIdlevideoINSTANCE';
function initVideoDLL():integer;cdecl;external play264DLL name 'initVideoDLL';
function resizeVideo(INSTANCE, width, height:integer):integer;cdecl;external play264DLL name 'resize';
function SetCallBack(INSTANCE:integer;func:pDrawLineCallBack):integer;cdecl;external play264DLL name 'SetCallBack';
function SetBmpCallBack(INSTANCE:integer;func:pBmpCallBack):integer;cdecl;external play264DLL name 'SetBmpCallBack';
function SetFillBmpCallBack(INSTANCE:integer;func:pDrawRectCallBack):integer;cdecl;external play264DLL name 'SetFillBmpCallBack';
implementation

end.
