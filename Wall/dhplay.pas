//********************************************************************
// * 文件: dhplay.h
// * 版权:
// * 作者: 周国锋, 王卫东
// * 创建: 2006.12
//	purpose:	用于提供给用户做二次开发提供函数接口的定义和说明
//*********************************************************************/

unit dhPlay ;

interface

uses windows  ;

type
  long = longint ;

const dhplay_api  = 'dhplay.dll' ;

const  FUNC_MAX_PORT =100 ;             //最大播放通道数
//Wave coef range;
const MIN_WAVE_COEF = -100 ;
const MAX_WAVE_COEF = 100  ;
//Timer type
const TIMER_1 = 1 ;//Only 16 timers for every process.Default TIMER;
const TIMER_2 = 2 ;//Not limit;But the precision less than TIMER_1;
//缓冲类型
const BUF_VIDEO_SRC =1 ;   //视频源缓冲
const BUF_AUDIO_SRC =2 ;   //音频源缓冲
const BUF_VIDEO_RENDER =3 ; //解码后视频数据缓冲
const BUF_AUDIO_RENDER =4 ; //解码后音频数据缓冲

//错误类型
const	DH_PLAY_NOERROR			  =	0  ;            //没有错误；
const DH_PLAY_PARA_OVER			  =	1  ;            //输入参数非法；
const DH_PLAY_ORDER_ERROR		  =	2  ;            //调用顺序不对；
const DH_PLAY_TIMER_ERROR		  =	3  ;            //多媒体时钟设置失败；
const DH_PLAY_DEC_VIDEO_ERROR		  =	4  ;	           //视频解码失败；
const DH_PLAY_DEC_AUDIO_ERROR		  =	5  ;	           //音频解码失败；
const DH_PLAY_ALLOC_MEMORY_ERROR	  =	6  ;		       //分配内存失败；
const DH_PLAY_OPEN_FILE_ERROR		  =	7  ;			   //文件操作失败；
const DH_PLAY_CREATE_OBJ_ERROR		  =     8  ;	           //创建线程事件等失败；
const DH_PLAY_CREATE_DDRAW_ERROR	  =	9  ;		       //创建directDraw失败；
const DH_PLAY_CREATE_OFFSCREEN_ERROR	  =      10 ;		       //创建后端缓存失败；
const DH_PLAY_BUF_OVER			  =	11 ;	           //缓冲区满，输入流失败；
const DH_PLAY_CREATE_SOUND_ERROR	  =	12 ;		       //创建音频设备失败；
const DH_PLAY_SET_VOLUME_ERROR	       =	13 ;	           //设置音量失败；
const DH_PLAY_SUPPORT_FILE_ONLY	       =	14 ;		       //只能在播放文件时才能使用此接口；
const DH_PLAY_SUPPORT_STREAM_ONLY      =      	15 ;		       //只能在播放流时才能使用此接口；
const DH_PLAY_SYS_NOT_SUPPORT	       =      	16 ;		       //系统不支持，解码器只能工作在Pentium 3以上；
const DH_PLAY_FILEHEADER_UNKNOWN       =      	17 ;		       //没有文件头；
const DH_PLAY_VERSION_INCORRECT	       =	18 ;	           //解码器和编码器版本不对应；
const DH_PLAY_INIT_DECODER_ERROR       =     	19 ;		       //初始化解码器失败；
const DH_PLAY_CHECK_FILE_ERROR	       =	20 ;		       //文件太短或码流无法识别；
const DH_PLAY_INIT_TIMER_ERROR	       =	21 ;		       //初始化多媒体时钟失败；
const DH_PLAY_BLT_ERROR		       =       	22 ;		       //位拷贝失败；
const DH_PLAY_UPDATE_ERROR            = 23 ;			   //显示overlay失败；


//Max display regions.
const MAX_DISPLAY_WND = 4  ;

//Display type
const DISPLAY_NORMAL = 1  ;
const DISPLAY_QUARTER =2  ;

//Display buffers
const MAX_DIS_FRAMES =50 ;
const MIN_DIS_FRAMES =6  ;

//Locate by
const BY_FRAMENUM  =1  ;
const BY_FRAMETIME =2  ;

//Source buffer
const SOURCE_BUF_MAX  =	1024*100000 ;
const SOURCE_BUF_MIN  =	1024*50     ;

//Stream type
const STREAME_REALTIME =        0 ;
const STREAME_FILE     =        1 ;

//frame type
const T_AUDIO16	=101  ;
const T_AUDIO8	=100  ;

const T_UYVY	 =	1 ;
const T_YV12	 =	3 ;
const T_RGB32	 =	7 ;

//系统支持的功能，用于按位表示系统功能
const SUPPORT_DDRAW	 =	1  ;//支持DIRECTDRAW；如果不支持，则播放器不能工作。
const SUPPORT_BLT        = 2 ; //显卡支持BLT操作；如果不支持，则播放器不能工作
const SUPPORT_BLTFOURCC  = 4 ; //显卡BLT支持颜色转换；
const SUPPORT_BLTSHRINKX = 8 ; //显卡BLT支持X轴缩小；
const SUPPORT_BLTSHRINKY = 16 ;//显卡BLT支持Y轴缩小；
const SUPPORT_BLTSTRETCHX= 32 ;//显卡BLT支持X轴放大；
const SUPPORT_BLTSTRETCHY= 64 ;//显卡BLT支持Y轴放大；
const SUPPORT_SSE        = 128 ;//CPU支持SSE指令,Intel Pentium3以上支持SSE指令；
const SUPPORT_MMX	 =  256 ; //CPU支持MMX指令集。

type
//Frame position
PFRAME_POS = ^FRAME_POS ;
FRAME_POS = record
	nFilePos : long ;
	nFrameNum : long;
	nFrameTime : long;
	nErrorFrameNum : long;
	pErrorTime : PSYSTEMTIME ;
	nErrorLostFrameNum : long  ;
	nErrorFrameSize : long ;
end ;

//Frame Info
PFRAME_INFO = ^FRAME_INFO ;
FRAME_INFO = record
	nWidth : long ;  //画面宽，单位像素。如果是音频数据则为0；
	nHeight : long ; //画面高。如果是音频数据则为0；
	nStamp : long ;  //时标信息，单位毫秒。
	nType : long ;   //数据类型，T_AUDIO16，T_RGB32， T_YV12，详见宏定义说明。
	nFrameRate : long ; //编码时产生的图像帧率。
end ;

PFRAME_TYPE = ^FRAME_TYPE ;
FRAME_TYPE = record
	pDataBuf : Pchar ;
	nSize : long ;
	nFrameNum : long ;
	bIsAudio : BOOL ;
	nReserved : long ;
end ;


//以下为对外接口，供用户作二次开发调用
//以下两个是可以不需要调用的接口
function PLAY_InitDDraw(hWnd : HWND ) : boolean ; stdcall ; external dhplay_API name 'PLAY_InitDDraw';

function PLAY_RealeseDDraw(): boolean ; stdcall ; external dhplay_API name 'PLAY_RealeseDDraw';
                     // nPort 必须是  0 -- 100
function PLAY_OpenFile(nPort :LONG ; sFileName : LPSTR ): boolean ; stdcall ; external dhplay_API name 'PLAY_OpenFile';
function PLAY_CloseFile(nPort :LONG ): boolean ; stdcall ; external dhplay_API name 'PLAY_CloseFile';
function PLAY_Play(nPort :LONG ;  hWnd : HWND ): boolean ; stdcall ; external dhplay_API name 'PLAY_Play';
function PLAY_Stop(nPort : LONG ): boolean ; stdcall ; external dhplay_API name 'PLAY_Stop';
function PLAY_Pause(nPort : LONG ; nPause : DWORD ): boolean ; stdcall ; external dhplay_API name 'PLAY_Pause';
function PLAY_Fast(nPort : LONG): boolean ; stdcall ; external dhplay_API name 'PLAY_Fast';
function PLAY_Slow(nPort : LONG): boolean ; stdcall ; external dhplay_API name 'PLAY_Slow';
function PLAY_OneByOne(nPort : LONG): boolean ; stdcall ; external dhplay_API name 'PLAY_OneByOne';//网络回放单帧
function PLAY_SetPlayPos(nPort : LONG ; fRelativePos : single ): boolean ; stdcall ; external dhplay_API name 'PLAY_SetPlayPos';
function PLAY_GetPlayPos(nPort : LONG ): single ; stdcall ; external dhplay_API name 'PLAY_GetPlayPos';
function PLAY_SetFileEndMsg(nPort : LONG ; hWnd : HWND ; nMsg : UINT ): boolean ; stdcall ; external dhplay_API name 'PLAY_SetFileEndMsg';
function PLAY_SetVolume(nPort : LONG ;nVolume : WORD ): boolean ; stdcall ; external dhplay_API name 'PLAY_SetVolume';
function PLAY_StopSound(): boolean ; stdcall ; external dhplay_API name 'PLAY_StopSound';
function PLAY_PlaySound(nPort : LONG ): boolean ; stdcall ; external dhplay_API name 'PLAY_PlaySound';

function PLAY_OpenStream(nPort : LONG ; pFileHeadBuf : PBYTE  ; nSize, nBufPoolSize : DWORD ): boolean ; stdcall ; external dhplay_API name 'PLAY_OpenStream';
function PLAY_InputData(nPort : LONG ; pBuf : PBYTE ;  nSize : DWORD ): boolean ; stdcall ; external dhplay_API name 'PLAY_InputData';
function PLAY_CloseStream(nPort : LONG ): boolean ; stdcall ; external dhplay_API name 'PLAY_CloseStream';

function PLAY_SetStreamOpenMode(nPort : LONG; nMode:DWORD):Boolean;stdcall ; external dhplay_API name 'PLAY_SetStreamOpenMode';
function PLAY_SetDecCBStream(nPort : LONG;  nStream:DWORD):Boolean;stdcall ; external dhplay_API name 'PLAY_SetDecCBStream';



type
LPfDecCBFun=^TfDecCBFun;
TfDecCBFun=procedure(nPort:LONG;pBuf:Pchar;nSize:LONG;pFrameInfo:PFRAME_INFO;pUserData:Pointer;nReserved2:LONG);stdcall;


function PLAY_SetDecCallBackEx(nPort : LONG;fDecCBFun:LPfDecCBFun;pUserData:Pointer): boolean ; stdcall ; external dhplay_API name 'PLAY_SetDecCallBackEx';

//PLAYSDK_API int  CALLMETHOD PLAY_GetCaps(): boolean ; stdcall ; external dhplay_API name 'aaaaaa';
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetFileTime(LONG nPort): boolean ; stdcall ; external dhplay_API name 'aaaaaa';
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetPlayedTime(LONG nPort): boolean ; stdcall ; external dhplay_API name 'aaaaaa';
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetPlayedFrames(LONG nPort): boolean ; stdcall ; external dhplay_API name 'aaaaaa';
//function PLAY_Back(LONG nPort): boolean ; stdcall ; external dhplay_API name 'aaaaaa';
//function PLAY_BackOne(LONG nPort): boolean ; stdcall ; external dhplay_API name 'aaaaaa';
//function PLAY_SetDecCallBack(LONG nPort,void (CALLBACK* DecCBFun)(long nPort,char * pBuf,	long nSize,FRAME_INFO * pFrameInfo, long nReserved1,long nReserved2)): boolean ; stdcall ; external dhplay_API name 'aaaaaa';
//function PLAY_SetDisplayCallBack(LONG nPort,void (CALLBACK* DisplayCBFun)(long nPort,char * pBuf,long nSize,long nWidth,long nHeight,long nStamp,long nType,long nReserved), long nUser = 0): boolean ; stdcall ; external dhplay_API name 'aaaaaa';
//function PLAY_ConvertToBmpFile(char * pBuf,long nSize,long nWidth,long nHeight,long nType,char *sFileName);
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetFileTotalFrames(LONG nPort);
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetCurrentFrameRate(LONG nPort);
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetPlayedTimeEx(LONG nPort);
//function PLAY_SetPlayedTimeEx(LONG nPort,DWORD nTime);
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetCurrentFrameNum(LONG nPort);
//function PLAY_SetStreamOpenMode(LONG nPort,DWORD nMode);
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetFileHeadLength();
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetSdkVersion();
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetLastError(LONG nPort);
//PLAYSDK_API BOOL  CALLMETHOD PLAY_RefreshPlay(LONG nPort);
//PLAYSDK_API BOOL  CALLMETHOD PLAY_SetOverlayMode(LONG nPort,BOOL bOverlay,COLORREF colorKey);
//PLAYSDK_API BOOL  CALLMETHOD PLAY_GetPictureSize(LONG nPort,LONG *pWidth,LONG *pHeight);
//PLAYSDK_API BOOL  CALLMETHOD PLAY_SetPicQuality(LONG nPort,BOOL bHighQuality);
//PLAYSDK_API BOOL  CALLMETHOD PLAY_PlaySoundShare(LONG nPort);
//PLAYSDK_API BOOL  CALLMETHOD PLAY_StopSoundShare(LONG nPort);
//PLAYSDK_API LONG CALLMETHOD PLAY_GetStreamOpenMode(LONG nPort);
//PLAYSDK_API LONG CALLMETHOD PLAY_GetOverlayMode(LONG nPort);
//PLAYSDK_API COLORREF CALLMETHOD PLAY_GetColorKey(LONG nPort);
//PLAYSDK_API WORD CALLMETHOD PLAY_GetVolume(LONG nPort);
//function PLAY_GetPictureQuality(LONG nPort,BOOL *bHighQuality);
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetSourceBufferRemain(LONG nPort);
//function PLAY_ResetSourceBuffer(LONG nPort);
//function PLAY_SetSourceBufCallBack(LONG nPort,DWORD nThreShold,void (CALLBACK * SourceBuf__stdcall)(long nPort,DWORD nBufSize,DWORD dwUser,void*pResvered),DWORD dwUser,void *pReserved);
//function PLAY_ResetSourceBufFlag(LONG nPort);
//function PLAY_SetDisplayBuf(LONG nPort,DWORD nNum);
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetDisplayBuf(LONG nPort);
//function PLAY_OneByOneBack(LONG nPort);
//function PLAY_SetFileRefCallBack(LONG nPort, void (CALLBACK *pFileRefDone)(DWORD nPort,DWORD nUser),DWORD nUser);
  function PLAY_SetCurrentFrameNum(nPort : LONG ; nFrameNum : DWORD ) : boolean ; stdcall ; external dhplay_API name 'PLAY_SetCurrentFrameNum';

//function PLAY_GetKeyFramePos(LONG nPort,DWORD nValue, DWORD nType, PFRAME_POS pFramePos);
//function PLAY_GetNextKeyFramePos(LONG nPort,DWORD nValue, DWORD nType, PFRAME_POS pFramePos);
//function PLAY_InitDDrawDevice();
//PLAYSDK_API void CALLMETHOD PLAY_ReleaseDDrawDevice();
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetDDrawDeviceTotalNums();
//function PLAY_SetDDrawDevice(LONG nPort,DWORD nDeviceNum);

//function PLAY_GetDDrawDeviceInfo(DWORD nDeviceNum,LPSTR  lpDriverDescription,DWORD nDespLen,LPSTR lpDriverName ,DWORD nNameLen,long *hhMonitor);
//PLAYSDK_API int   CALLMETHOD PLAY_GetCapsEx(DWORD nDDrawDeviceNum);
//function PLAY_ThrowBFrameNum(LONG nPort,DWORD nNum);
//function PLAY_SetDisplayType(LONG nPort,LONG nType);
//PLAYSDK_API long CALLMETHOD PLAY_GetDisplayType(LONG nPort);
//function PLAY_SetDecCBStream(LONG nPort,DWORD nStream);
//function PLAY_SetDisplayRegion(LONG nPort,DWORD nRegionNum, RECT *pSrcRect, HWND hDestWnd, BOOL bEnable);
//function PLAY_RefreshPlayEx(LONG nPort,DWORD nRegionNum);
//function PLAY_SetDDrawDeviceEx(LONG nPort,DWORD nRegionNum,DWORD nDeviceNum);
//function PLAY_GetRefValue(LONG nPort,BYTE *pBuffer, DWORD *pSize);
//function PLAY_SetRefValue(LONG nPort,BYTE *pBuffer, DWORD nSize);
//function PLAY_OpenStreamEx(LONG nPort,PBYTE pFileHeadBuf,DWORD nSize,DWORD nBufPoolSize);
//function PLAY_CloseStreamEx(LONG nPort);
function PLAY_InputVideoData(nPort : LONG ; pBuf : PBYTE ;nSize : DWORD ) : boolean ; stdcall ; external dhplay_API name 'PLAY_InputVideoData';
function PLAY_InputAudioData(nPort : LONG ; pBuf : PBYTE ;nSize : DWORD ) : boolean ; stdcall ; external dhplay_API name 'PLAY_InputAudioData';
//function PLAY_RigisterDrawFun(LONG nPort,void (CALLBACK* DrawFun)(long nPort,HDC hDc,LONG nUser),LONG nUser);
//function PLAY_SetTimerType(LONG nPort,DWORD nTimerType,DWORD nReserved);
//function PLAY_GetTimerType(LONG nPort,DWORD *pTimerType,DWORD *pReserved);
//function PLAY_ResetBuffer(LONG nPort,DWORD nBufType);
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetBufferValue(LONG nPort,DWORD nBufType);

function PLAY_AdjustWaveAudio(nPort : LONG ; nCoefficient : LONG ) : boolean ; stdcall ; external dhplay_API name 'PLAY_AdjustWaveAudio';
//function PLAY_SetVerifyCallBack(LONG nPort, DWORD nBeginTime, DWORD nEndTime, void (CALLBACK * funVerify)(long nPort, FRAME_POS * pFilePos, DWORD bIsVideo, DWORD nUser),  DWORD  nUser);
//function PLAY_SetAudioCallBack(LONG nPort, void (CALLBACK * funAudio)(long nPort, char * pAudioBuf, long nSize, long nStamp, long nType, long nUser), long nUser);
//function PLAY_SetEncTypeChangeCallBack(LONG nPort,void(CALLBACK *funEncChange)(long nPort, long nUser),long nUser);
//function PLAY_SetColor(LONG nPort, DWORD nRegionNum, int nBrightness, int nContrast, int nSaturation, int nHue);
//function PLAY_GetColor(LONG nPort, DWORD nRegionNum, int *pBrightness, int *pContrast, int *pSaturation, int *pHue);
//function PLAY_SetEncChangeMsg(LONG nPort,HWND hWnd,UINT nMsg);

//function PLAY_SetMDRange(LONG nPort,RECT* rc,DWORD nVauleBegin,DWORD nValueEnd,DWORD nType);
//function PLAY_SetMDThreShold(LONG nPort, DWORD ThreShold) ;
//PLAYSDK_API DWORD CALLMETHOD PLAY_GetMDPosition(LONG nPort, DWORD Direction, DWORD nFrame, DWORD* MDValue) ;

function PLAY_CatchPic(nPort : LONG ;sFileName : Pchar ) : boolean ; stdcall ; external dhplay_API name 'PLAY_CatchPic';

//function PLAY_SetFileEndCallBack(LONG nPort, void (CALLBACK *pFileEnd)(DWORD nPort,DWORD nUser),DWORD nUser);
function PLAY_StartDataRecord(nPort : LONG ; sFileName : Pchar ) : boolean ; stdcall ; external dhplay_API name 'PLAY_StartDataRecord';
function PLAY_StopDataRecord(nPort : LONG ) :  boolean ; stdcall ; external dhplay_API name 'PLAY_StopDataRecord';
//function PLAY_AdjustFluency(LONG nPort, int level);
//function PLAY_ChangeRate(LONG nPort, int rate);
//function PLAY_SetDemuxCallBack(LONG nPort, void (CALLBACK* DecCBFun)(long nPort,char * pBuf,	long nSize,void * pParam, long nReserved,long nUser), long nUser);
//const PLAY_CMD_GetTime 1
//const PLAY_CMD_GetFileRate 2
//function PLAY_QueryInfo(LONG nPort , int cmdType, char* buf, int buflen, int* returnlen);

//typedef void (WINAPI *pCallFunction)(LPBYTE pDataBuffer, DWORD DataLength, long nUser);

//function PLAY_OpenAudioRecord(pCallFunction pProc, long nBitsPerSample, long nSamplesPerSec, long nLength, long nReserved, long nUser);

//function PLAY_CloseAudioRecord();

implementation

end.

