unit PlayCtrl  ;

interface

uses windows  ;
type
  long = longint ;
//const HIK_PLAYCtrl_API  = 'HikPlay6.11.dll' ;
const HIK_PLAYCtrl_API  = 'PlayCtrl.dll' ;
type
//Frame position
 PFRAME_POS = ^FRAME_POS;
 FRAME_POS = record
	nFilePos : long ;
	nFrameNum : long ;
	nFrameTime : long ;
	nErrorFrameNum  : long ;
	pErrorTime : ^SYSTEMTIME ;
	nErrorLostFrameNum : long ;
	nErrorFrameSize : long ;
 end ;
 
//Frame Info
PFRAME_INFO = ^FRAME_INFO ;
FRAME_INFO = record
	nWidth : long ;
	nHeight : long ;
	nStamp : long ;
	nType : long ;
	nFrameRate : long ;
        dwFrameNum :DWORD;
end ;

//Frame
PFRAME_TYPE = ^FRAME_TYPE ;
FRAME_TYPE = record
	pDataBuf : Pchar ;
	nSize : long  ;
	nFrameNum : long   ;
	bIsAudio : BOOL  ;
	nReserved : long  ;
end ;

function YUV420ToRGB(pubyChanYUV:PChar;dwImgWidth:DWORD;dwImgHeight:DWORD;pubyChanRGB:PByte) : Integer ; stdcall  ; external 'yuvrgb.dll' name 'YUV420ToRGB';
function YUV12ToRGB(pubyChanYUV:PChar;dwImgWidth:DWORD;dwImgHeight:DWORD;pubyChanRGB:PByte) : Integer ; stdcall  ; external 'yuvrgb.dll' name 'YUV12ToRGB';


function Hik_PlayM4_Play_HS(nPort : LONG ; hWnd : HWND ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_Play';
function Hik_PlayM4_Stop_HS(nPort : LONG ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_Stop';
function Hik_PlayM4_OpenStream_HS(nPort : LONG ; pFileHeadBuf : PBYTE ; nSize : DWORD ; nBufPoolSize : DWORD ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_OpenStream';
function Hik_PlayM4_InputData_HS(nPort : LONG ;  pBuf : PBYTE ;nSize :DWORD ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_InputData';
function Hik_PlayM4_CloseStream_HS(nPort :LONG ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_CloseStream';
function Hik_PlayM4_StopSound_HS() : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_StopSound';
function Hik_PlayM4_PlaySound_HS(nPort : LONG ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_PlaySound';
function Hik_PlayM4_SetDecCBStream_HS(nPort:long;nStream:DWORD): boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_SetDecCBStream';
type
  PDecCBFun_HS = ^TDecCBFun_HS ;
  TDecCBFun_HS = procedure (nPort : long ; pBuf : PChar ; nSize : long ; pFrameInfo : PFRAME_INFO ;nUser,nReserved2 : long ) of object  ;stdcall;
function Hik_PlayM4_SetDecCallBack_HS(nPort : LONG ; fDecCBFun_HS : PDecCBFun_HS ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_SetDecCallBack';

function Hik_PlayM4_SetDecCallBackMend_HS(nPort : LONG ; fDecCBFun_HS : PDecCBFun_HS;nUser:LONG ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_SetDecCallBackMend';

{type
  PfRealDataCallBack = ^TfRealDataCallBack;
  TfRealDataCallBack = procedure(lRealHandle: LONG; dwDataType: DWORD; pBuffer: PBYTE; dwBufSize: DWORD; pUser: Pointer) of object;

function NET_DVR_SetRealDataCallBack(lRealHandle: LONG; fRealDataCallBack: PfRealDataCallBack; dwUser: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetRealDataCallBack';
}

type
  PDisplayCBFun_HS = ^TDisplayCBFun_HS ;
  TDisplayCBFun_HS = procedure (nPort : long ; pBuf : Pchar ; nSize,nWidth,nHeight,nStamp,nType,nReserved : long ) of object ;stdcall ;

function Hik_PlayM4_SetDisplayCallBack_HS(nPort : LONG ; fDisplayCBFun_HS : PDisplayCBFun_HS) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_SetDisplayCallBack';
function Hik_PLayM4_ConvertToBmpFile_HS(pBuf : Pchar ;nSize,nWidth,nHeight,nType : long ; sFileName: Pchar ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PLayM4_ConvertToBmpFile';


function Hik_PlayM4_GetPort_HS(var nPort : LONG ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_GetPort';


function Hik_PlayM4_FreePort_HS(nPort : LONG ) : boolean ; stdcall ; external HIK_PLAYCtrl_API name 'PlayM4_FreePort';


implementation

end.
