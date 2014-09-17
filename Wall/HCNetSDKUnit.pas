unit HCNetSDKUnit;

interface

uses windows, DataUnit;

//#include "stdafx.h"
//#define NET_DVR_API  extern "C"__declspec(dllimport)
type
  LONG = LongInt;
  USHORT = word;
  Bool = Boolean;
  Int = Integer;

  Char_2 = array[0..1] of char;
  Char_4 = array[0..3] of char;
  Char_6 = array[0..5] of char;
  Char_16 = array[0..15] of char;
  Char_20 = array[0..19] of char;
  Char_32 = array[0..31] of char;
  Char_48 = array[0..47] of char;
  Char_128 = array[0..47] of char;


const
  NET_DVR_API = 'HCNetSDK.dll';
  {
  NET_DVR_NOERROR 	       =	   	0  ;     //没有错误
  NET_DVR_PASSWORD_ERROR       =	   	1  ;     //用户名密码错误
  NET_DVR_NOENOUGHPRI 	       =		2  ;     //权限不足
  NET_DVR_NOINIT 	       =	   	3  ;     //没有初始化
  NET_DVR_CHANNEL_ERROR        =	        4  ;     //通道号错误
  NET_DVR_OVER_MAXLINK         =		5  ;     //连接到DVR的客户端个数超过最大
  NET_DVR_VERSIONNOMATCH       =		6  ;     //版本不匹配
  NET_DVR_NETWORK_FAIL_CONNECT =               	7  ;     //连接服务器失败
  NET_DVR_NETWORK_SEND_ERROR   =		8  ;     //向服务器发送失败
  NET_DVR_NETWORK_RECV_ERROR   =		9  ;     //从服务器接收数据失败
  NET_DVR_NETWORK_RECV_TIMEOUT =	        10 ;     //从服务器接收数据超时
  NET_DVR_NETWORK_ERRORDATA    =	        11 ;     //传送的数据有误
  NET_DVR_ORDER_ERROR	       =		12 ;     //调用次序错误
  NET_DVR_OPERNOPERMIT	       =        	13 ;     //无此权限
  NET_DVR_COMMANDTIMEOUT       =	   	14 ;     //DVR命令执行超时
  NET_DVR_ERRORSERIALPORT      =	   	15 ;     //串口号错误
  NET_DVR_ERRORALARMPORT       =	  	16 ;     //报警端口错误
  NET_DVR_PARAMETER_ERROR      =		17 ;     //参数错误
  NET_DVR_CHAN_EXCEPTION       =	  	18 ;	//服务器通道处于错误状态
  NET_DVR_NODISK	       =	  	19 ;	//没有硬盘
  NET_DVR_ERRORDISKNUM	       =		20 ;	//硬盘号错误
  NET_DVR_DISK_FULL	       =	   	21 ;	//服务器硬盘满
  NET_DVR_DISK_ERROR	       =	   	22 ;	//服务器硬盘出错
  NET_DVR_NOSUPPORT	       =	   	23 ;	//服务器不支持
  NET_DVR_BUSY		       =	   	24 ;	//服务器忙
  NET_DVR_MODIFY_FAIL	       =	   	25 ;	//服务器修改不成功
  NET_DVR_PASSWORD_FORMAT_ERROR	=               26 ;	//密码输入格式不正确
  NET_DVR_DISK_FORMATING       = 		27 ;	//硬盘正在格式化，不能启动操作
  NET_DVR_DVRNORESOURCE	       =		28 ;	//DVR资源不足
  NET_DVR_DVROPRATEFAILED      =		29 ;     //DVR操作失败
  NET_DVR_OPENHOSTSOUND_FAIL   =	        30 ;     //打开PC声音失败
  NET_DVR_DVRVOICEOPENED       =		31 ;     //服务器语音对讲被占用
  NET_DVR_TIMEINPUTERROR       =		32 ;     //时间输入不正确
  NET_DVR_NOSPECFILE	       = 		33 ;     //回放时服务器没有指定的文件
  NET_DVR_CREATEFILE_ERROR     =		34 ;	//创建文件出错
  NET_DVR_FILEOPENFAIL	       =		35 ;     //打开文件出错
  NET_DVR_OPERNOTFINISH	       =		36 ;     //上次的操作还没有完成
  NET_DVR_GETPLAYTIMEFAIL      =    		37 ;     //获取当前播放的时间出错
  NET_DVR_PLAYFAIL	       =    		38 ;     //播放出错
  NET_DVR_FILEFORMAT_ERROR     =		39 ;     //文件格式不正确
  NET_DVR_DIR_ERROR	       =    		40 ;	//路径错误
  NET_DVR_ALLOC_RESOUCE_ERROR  =		41 ;     //资源分配错误
  NET_DVR_AUDIO_MODE_ERROR     =		42 ;	//声卡模式错误
  NET_DVR_NOENOUGH_BUF	       =		43 ;	//缓冲区太小
  NET_DVR_CREATESOCKET_ERROR   =		44 ;	//创建SOCKET出错
  NET_DVR_SETSOCKET_ERROR      =    		45 ;	//设置SOCKET出错
  NET_DVR_MAX_NUM	       =    		46 ;	//个数达到最大
  NET_DVR_USERNOTEXIST	       =		47 ;	//用户不存在
  NET_DVR_WRITEFLASHERROR      =    		48 ;     //写FLASH出错
  NET_DVR_UPGRADEFAIL	       =    		49 ;     //DVR升级失败
  NET_DVR_CARDHAVEINIT	       =		50 ;     //解码卡已经初始化过
  NET_DVR_PLAYERFAILED	       =		51 ;	//播放器中错误
  NET_DVR_MAX_USERNUM	       =    		52 ;     //用户数达到最大
  NET_DVR_GETLOCALIPANDMACFAIL	=               53 ;     //获得客户端的IP地址或物理地址失败
  NET_DVR_NOENCODEING		=		54 ;	//该通道没有编码
  NET_DVR_IPMISMATCH		=		55 ;	//IP地址不匹配
  NET_DVR_MACMISMATCH		=		56 ;	//MAC地址不匹配
  NET_DVR_UPGRADELANGMISMATCH	=       	57 ;	//升级文件语言不匹配
  NET_DVR_DDRAWDEVICENOSUPPORT	=       	58 ;	//本地显卡不支持
  }
  NET_DVR_NOERROR = 0; //没有错误
  NET_DVR_PASSWORD_ERROR = 1; //用户名密码错误
  NET_DVR_NOENOUGHPRI = 2; //权限不足
  NET_DVR_NOINIT = 3; //没有初始化
  NET_DVR_CHANNEL_ERROR = 4; //通道号错误
  NET_DVR_OVER_MAXLINK = 5; //连接到DVR的客户端个数超过最大
  NET_DVR_VERSIONNOMATCH = 6; //版本不匹配
  NET_DVR_NETWORK_FAIL_CONNECT = 7; //连接服务器失败
  NET_DVR_NETWORK_SEND_ERROR = 8; //向服务器发送失败
  NET_DVR_NETWORK_RECV_ERROR = 9; //从服务器接收数据失败
  NET_DVR_NETWORK_RECV_TIMEOUT = 10; //从服务器接收数据超时
  NET_DVR_NETWORK_ERRORDATA = 11; //传送的数据有误
  NET_DVR_ORDER_ERROR = 12; //调用次序错误
  NET_DVR_OPERNOPERMIT = 13; //无此权限
  NET_DVR_COMMANDTIMEOUT = 14; //DVR命令执行超时
  NET_DVR_ERRORSERIALPORT = 15; //串口号错误
  NET_DVR_ERRORALARMPORT = 16; //报警端口错误
  NET_DVR_PARAMETER_ERROR = 17; //参数错误
  NET_DVR_CHAN_EXCEPTION = 18; //服务器通道处于错误状态
  NET_DVR_NODISK = 19; //没有硬盘
  NET_DVR_ERRORDISKNUM = 20; //硬盘号错误
  NET_DVR_DISK_FULL = 21; //服务器硬盘满
  NET_DVR_DISK_ERROR = 22; //服务器硬盘出错
  NET_DVR_NOSUPPORT = 23; //服务器不支持
  NET_DVR_BUSY = 24; //服务器忙
  NET_DVR_MODIFY_FAIL = 25; //服务器修改不成功
  NET_DVR_PASSWORD_FORMAT_ERROR = 26; //密码输入格式不正确
  NET_DVR_DISK_FORMATING = 27; //硬盘正在格式化，不能启动操作
  NET_DVR_DVRNORESOURCE = 28; //DVR资源不足
  NET_DVR_DVROPRATEFAILED = 29; //DVR操作失败
  NET_DVR_OPENHOSTSOUND_FAIL = 30; //打开PC声音失败
  NET_DVR_DVRVOICEOPENED = 31; //服务器语音对讲被占用
  NET_DVR_TIMEINPUTERROR = 32; //时间输入不正确
  NET_DVR_NOSPECFILE = 33; //回放时服务器没有指定的文件
  NET_DVR_CREATEFILE_ERROR = 34; //创建文件出错
  NET_DVR_FILEOPENFAIL = 35; //打开文件出错
  NET_DVR_OPERNOTFINISH = 36; //上次的操作还没有完成
  NET_DVR_GETPLAYTIMEFAIL = 37; //获取当前播放的时间出错
  NET_DVR_PLAYFAIL = 38; //播放出错
  NET_DVR_FILEFORMAT_ERROR = 39; //文件格式不正确
  NET_DVR_DIR_ERROR = 40; //路径错误
  NET_DVR_ALLOC_RESOURCE_ERROR = 41; //资源分配错误
  NET_DVR_AUDIO_MODE_ERROR = 42; //声卡模式错误
  NET_DVR_NOENOUGH_BUF = 43; //缓冲区太小
  NET_DVR_CREATESOCKET_ERROR = 44; //创建SOCKET出错
  NET_DVR_SETSOCKET_ERROR = 45; //设置SOCKET出错
  NET_DVR_MAX_NUM = 46; //个数达到最大
  NET_DVR_USERNOTEXIST = 47; //用户不存在
  NET_DVR_WRITEFLASHERROR = 48; //写FLASH出错
  NET_DVR_UPGRADEFAIL = 49; //DVR升级失败
  NET_DVR_CARDHAVEINIT = 50; //解码卡已经初始化过
  NET_DVR_PLAYERFAILED = 51; //调用播放库中某个函数失败
  NET_DVR_MAX_USERNUM = 52; //设备端用户数达到最大
  NET_DVR_GETLOCALIPANDMACFAIL = 53; //获得客户端的IP地址或物理地址失败
  NET_DVR_NOENCODEING = 54; //该通道没有编码
  NET_DVR_IPMISMATCH = 55; //IP地址不匹配
  NET_DVR_MACMISMATCH = 56; //MAC地址不匹配
  NET_DVR_UPGRADELANGMISMATCH = 57; //升级文件语言不匹配
  NET_DVR_MAX_PLAYERPORT = 58; //播放器路数达到最大
  NET_DVR_NOSPACEBACKUP = 59; //备份设备中没有足够空间进行备份
  NET_DVR_NODEVICEBACKUP = 60; //没有找到指定的备份设备
  NET_DVR_PICTURE_BITS_ERROR = 61; //图像素位数不符，限24色
  NET_DVR_PICTURE_DIMENSION_ERROR = 62; //图片高*宽超限，
  NET_DVR_PICTURE_SIZ_ERROR = 63; //图片大小超限，限100K
  NET_DVR_LOADPLAYERSDKFAILED = 64; //载入当前目录下Player
  NET_DVR_LOADPLAYERSDKPROC_ERROR = 65; //找不到Player
  NET_DVR_LOADDSSDKFAILED = 66; //载入当前目录下DSsdk出错
  NET_DVR_LOADDSSDKPROC_ERROR = 67; //找不到DsSdk中某个函数入口
  NET_DVR_DSSDK_ERROR = 68; //调用硬解码库DsSdk中某个函数失败
  NET_DVR_VOICEMONOPOLIZE = 69; //声卡被独占
  NET_DVR_JOINMULTICASTFAILED = 70; //加入多播组失败
  NET_DVR_CREATEDIR_ERROR = 71; //建立日志文件目录失败
  NET_DVR_BINDSOCKET_ERROR = 72; //绑定套接字失败
  NET_DVR_SOCKETCLOSE_ERROR = 73; //socket连接中断，此错误通常是由于连接中断或目的地不可达
  NET_DVR_USERID_ISUSING = 74; //注销时用户ID正在进行某操作
  NET_DVR_SOCKETLISTEN_ERROR = 75; //监听失败
  NET_DVR_PROGRAM_EXCEPTION = 76; //程序异常
  NET_DVR_WRITEFILE_FAILED = 77; //写文件失败
  NET_DVR_FORMAT_READONLY = 78; //禁止格式化只读硬盘
  NET_DVR_WITHSAMEUSERNAME = 79; //用户配置结构中存在相同的用户名
  NET_DVR_DEVICETYPE_ERROR = 80; //导入参数时设备型号不匹配
  NET_DVR_LANGUAGE_ERROR = 81; //导入参数时语言不匹配
  NET_DVR_PARAVERSION_ERROR = 82; //导入参数时软件版本不匹配
  NET_DVR_IPCHAN_NOTALIVE = 83; //预览时外接IP通道不在线
  NET_DVR_RTSP_SDK_ERROR = 84; //加载高清IPC通讯库StreamTransClient失败
  NET_DVR_CONVERT_SDK_ERROR = 85; //加载转码库失败
  NET_DVR_IPC_COUNT_OVERFLOW = 86; //超出最大的IP接入通道数

  MAX_CHANNUM_V30=64;
  MAX_ALARMOUT_V30=96;
  MAX_DISKNUM_V30=33;
  MAX_ALARMIN_V30=160;
  MAX_AUDIO_V30=2;
  
//查找文件和日志函数返回值
  NET_DVR_FILE_SUCCESS = 1000; //获得文件信息
  NET_DVR_FILE_NOFIND = 1001; //没有文件
  NET_DVR_ISFINDING = 1002; //正在查找文件
  NET_DVR_NOMOREFILE = 1003; //查找文件时没有更多的文件
  NET_DVR_FILE_EXCEPTION = 1004; //查找文件时异常

//NET_DVR_IsSupport()返回值
//1－9位分别表示以下信息（位与是TRUE)表示支持；
  NET_DVR_SUPPORT_DDRAW = $01; //支持DIRECTDRAW，如果不支持，则播放器不能工作；
  NET_DVR_SUPPORT_BLT = $02; //显卡支持BLT操作，如果不支持，则播放器不能工作；
  NET_DVR_SUPPORT_BLTFOURCC = $04; //显卡BLT支持颜色转换，如果不支持，播放器会用软件方法作RGB转换；
  NET_DVR_SUPPORT_BLTSHRINKX = $08; //显卡BLT支持X轴缩小；如果不支持，系统会用软件方法转换；
  NET_DVR_SUPPORT_BLTSHRINKY = $10; //显卡BLT支持Y轴缩小；如果不支持，系统会用软件方法转换；
  NET_DVR_SUPPORT_BLTSTRETCHX = $20; //显卡BLT支持X轴放大；如果不支持，系统会用软件方法转换；
  NET_DVR_SUPPORT_BLTSTRETCHY = $40; //显卡BLT支持Y轴放大；如果不支持，系统会用软件方法转换；
  NET_DVR_SUPPORT_SSE = $80; //CPU支持SSE指令，Intel Pentium3以上支持SSE指令；
  NET_DVR_SUPPORT_MMX = $100; //CPU支持MMX指令集，Intel Pentium3以上支持SSE指令；

  SET_PRESET = 8; // 设置预置点
  CLE_PRESET = 9; // 清除预置点
  GOTO_PRESET = 39; // 转到预置点

  LIGHT_PWRON = 2; //* 接通灯光电源 */
  WIPER_PWRON = 3; //* 接通雨刷开关 */
  FAN_PWRON = 4; //* 接通风扇开关 */
  HEATER_PWRON = 5; //* 接通加热器开关 */
  AUX_PWRON1 = 6; //* 接通辅助设备开关 */
  AUX_PWRON2 = 7;
  ZOOM_IN = 11; //* 焦距以速度SS变大(倍率变大) */
  ZOOM_OUT = 12; //* 焦距以速度SS变小(倍率变小) */
  FOCUS_NEAR = 13; //* 焦点以速度SS前调 */
  FOCUS_FAR = 14; //* 焦点以速度SS后调 */
  IRIS_OPEN = 15; //* 光圈以速度SS扩大 */
  IRIS_CLOSE = 16; //* 光圈以速度SS缩小 */
  TILT_UP = 21; //* 云台以SS的速度上仰 */
  TILT_DOWN = 22; //* 云台以SS的速度下俯 */
  PAN_LEFT = 23; //* 云台以SS的速度左转 */
  PAN_RIGHT = 24; //* 云台以SS的速度右转 */
  PAN_AUTO = 29; //* 云台以SS的速度左右自动扫描 */

  RUN_CRUISE = 36; //* 开始轨迹 */
  RUN_SEQ = 37; //* 开始巡航 */
  STOP_SEQ = 38; //* 停止巡航 */
  FILL_PRE_SEQ = 30;
  SET_SEQ_DWELL = 31;
  SET_SEQ_SPEED = 32;
  CLE_PRE_SEQ = 33; //将预置点从巡航序列中删除

const
  //显示模式
  NORMALMODE = 0;
  OVERLAYMODE = 1;

type
//发送模式
  TSendMode = (PTOPTCPMODE, PTOPUDPMODE, MULTIMODE, RTPMODE, AUDIODETACH, NOUSEMODE);

const
  NET_DVR_SYSHEAD = 1; //系统头数据
  NET_DVR_STREAMDATA = 2; //流数据

//播放控制命令宏定义 NET_DVR_PlayBackControl,NET_DVR_PlayControlLocDisplay,NET_DVR_DecPlayBackCtrl的宏定义
  NET_DVR_PLAYSTART = 1; //开始播放
  NET_DVR_PLAYSTOP = 2; //停止播放
  NET_DVR_PLAYPAUSE = 3; //暂停播放
  NET_DVR_PLAYRESTART = 4; //恢复播放
  NET_DVR_PLAYFAST = 5; //快放
  NET_DVR_PLAYSLOW = 6; //慢放
  NET_DVR_PLAYNORMAL = 7; //正常速度
  NET_DVR_PLAYFRAME = 8; //单帧放
  NET_DVR_PLAYSTARTAUDIO = 9; //打开声音
  NET_DVR_PLAYSTOPAUDIO = 10; //关闭声音
  NET_DVR_PLAYAUDIOVOLUME = 11; //调节音量
  NET_DVR_PLAYSETPOS = 12; //改变文件回放的进度
  NET_DVR_PLAYGETPOS = 13; //获取文件回放的进度
  NET_DVR_PLAYGETTIME = 14; //获取当前已经播放的时间
  NET_DVR_PLAYGETFRAME = 15; //获取当前已经播放的帧数
  NET_DVR_GETTOTALFRAMES = 16; //获取当前播放文件总的帧数
  NET_DVR_GETTOTALTIME = 17; //获取当前播放文件总的时间
  NET_DVR_THROWBFRAME_ = 20; //丢B帧

//NET_DVR_GetDVRConfig,NET_DVR_GetDVRConfig的命令定义
  NET_DVR_GET_DEVICECFG = 100; //获取设备参数
  NET_DVR_SET_DEVICECFG = 101; //设置设备参数
  NET_DVR_GET_NETCFG = 102; //获取网络参数
  NET_DVR_SET_NETCFG = 103; //设置网络参数
  NET_DVR_GET_PICCFG = 104; //获取图象参数
  NET_DVR_SET_PICCFG = 105; //设置图象参数
  NET_DVR_GET_COMPRESSCFG = 106; //获取压缩参数
  NET_DVR_SET_COMPRESSCFG = 107; //设置压缩参数
  NET_DVR_GET_COMPRESSCFG_EX = 204; //获取压缩参数(扩展)
  NET_DVR_SET_COMPRESSCFG_EX = 205; //设置压缩参数(扩展)
  NET_DVR_GET_RECORDCFG = 108; //获取录像时间参数
  NET_DVR_SET_RECORDCFG = 109; //设置录像时间参数
  NET_DVR_GET_DECODERCFG = 110; //获取解码器参数
  NET_DVR_SET_DECODERCFG = 111; //设置解码器参数
  NET_DVR_GET_RS232CFG = 112; //获取232串口参数
  NET_DVR_SET_RS232CFG = 113; //设置232串口参数
  NET_DVR_GET_ALARMINCFG = 114; //获取报警输入参数
  NET_DVR_SET_ALARMINCFG = 115; //设置报警输入参数
  NET_DVR_GET_ALARMOUTCFG = 116; //获取报警输出参数
  NET_DVR_SET_ALARMOUTCFG = 117; //设置报警输出参数
  NET_DVR_GET_TIMECFG = 118; //获取DVR时间
  NET_DVR_SET_TIMECFG = 119; //设置DVR时间
  NET_DVR_GET_PREVIEWCFG = 120; //获取预览参数
  NET_DVR_SET_PREVIEWCFG = 121; //设置预览参数
  NET_DVR_GET_VIDEOOUTCFG = 122; //获取视频输出参数
  NET_DVR_SET_VIDEOOUTCFG = 123; //设置视频输出参数
  NET_DVR_GET_USERCFG = 124; //获取用户参数
  NET_DVR_SET_USERCFG = 125; //设置用户参数
  NET_DVR_GET_EXCEPTIONCFG = 126; //获取异常参数
  NET_DVR_SET_EXCEPTIONCFG = 127; //设置异常参数
  NET_DVR_GET_SHOWSTRING = 130; //获取叠加字符参数
  NET_DVR_SET_SHOWSTRING = 131; //设置叠加字符参数
  NET_DVR_GET_AUXOUTCFG = 140; //获取辅助输出设置
  NET_DVR_SET_AUXOUTCFG = 141; //设置辅助输出设置
//2006-04-13 -s系列双输出
  NET_DVR_GET_PREVIEWCFG_AUX = 142; //获取预览参数
  NET_DVR_SET_PREVIEWCFG_AUX = 143; //设置预览参数
  NET_DVR_GET_PICCFG_EX = 200; //获取图象参数（扩展）
  NET_DVR_SET_PICCFG_EX = 201; //设置图象参数（扩展）
  NET_DVR_GET_USERCFG_EX = 202; //获取用户参数
  NET_DVR_SET_USERCFG_EX = 203; //设置用户参数

//回调函数类型
  COMM_ALARM = $1100; //报警信息
  COMM_TRADEINFO = $1500; //ATMDVR主动上传交易信息

//消息方式
//异常类型
  EXCEPTION_AUDIOEXCHANGE = $8001; //语音对讲异常
  EXCEPTION_ALARM = $8002; //报警异常
  EXCEPTION_PREVIEW = $8003; //网络预览异常
  EXCEPTION_SERIAL = $8004; //透明通道异常
  EXCEPTION_RECONNECT = $8005; //预览时重连

  NAME_LEN = 32;
  SERIALNO_LEN = 48;
  MACADDR_LEN = 6;
  MAX_ETHERNET = 2;
  PATHNAME_LEN = 128;
  PASSWD_LEN = 16;
  MAX_CHANNUM = 16;
  MAX_ALARMOUT = 4;
  MAX_TIMESEGMENT = 4;
  MAX_PRESET = 128;
  MAX_DAYS = 7;
  PHONENUMBER_LEN = 32;
  MAX_DISKNUM = 16;
  MAX_WINDOW = 16;
  MAX_VGA = 1;
  MAX_USERNUM = 16;
  MAX_EXCEPTIONNUM = 16;
  MAX_LINK = 6;
  MAX_ALARMIN = 16;
  MAX_VIDEOOUT = 2;
  MAX_NAMELEN = 16; //DVR本地登陆名
  MAX_RIGHT = 32; //权限
  CARDNUM_LEN = 20;
  MAX_SHELTERNUM = 4; //遮挡区域数
  MAX_DECPOOLNUM = 4;
  MAX_DECNUM = 4;
  MAX_TRANSPARENTNUM = 2;
  MAX_STRINGNUM = 4;
  MAX_AUXOUT = 4;

//* 网络接口定义 */
  NET_IF_10M_HALF = 1; //* 10M ethernet */
  NET_IF_10M_FULL = 2;
  NET_IF_100M_HALF = 3; //* 100M ethernet */
  NET_IF_100M_FULL = 4;
  NET_IF_AUTO = 5;

//设备型号(DVR类型)
  DVR = 1;
  ATMDVR = 2;
  DVS = 3;
  DEC1 = 4; //* 6001D */
  ENC_DEC = 5; //* 6001F */
  DVR_HC = 6;
  DVR_HT = 7;
  DVR_HF = 8;
  DVR_HS = 9;
  DVR_HTS = 10;
  DVR_HB = 11;
  DVR_HCS = 12;
  DVS_A = 13;
  DVR_HC_S = 14;
  DVR_HT_S = 15;
  DVR_HF_S = 16;
  DVR_HS_S = 17;
  ATMDVR_S = 18;
  LOWCOST_DVR = 19;

type

  LPNET_DVR_DEVICEINFO = ^NET_DVR_DEVICEINFO;
  NET_DVR_DEVICEINFO = record
    sSerialNumber: array[0..SERIALNO_LEN - 1] of Char; //序列号
    byAlarmInPortNum: BYTE; //DVR报警输入个数
    byAlarmOutPortNum: BYTE; //DVR报警输出个数
    byDiskNum: BYTE; //DVR 硬盘个数
    byDVRType: BYTE; //DVR类型,
    byChanNum: BYTE; //DVR 通道个数
    byStartChan: BYTE; //起始通道号,例如DVS-1,DVR - 1
  end;

//NET_DVR_Login_V30()参数结构
type LPNET_DVR_DEVICEINFO_V30 = ^NET_DVR_DEVICEINFO_V30;
  NET_DVR_DEVICEINFO_V30 = record
    sSerialNumber: array[1..SERIALNO_LEN] of char; //序列号
    byAlarmInPortNum: BYTE; //报警输入个数
    byAlarmOutPortNum: BYTE; //报警输出个数
    byDiskNum: BYTE; //硬盘个数
    byDVRType: BYTE; //设备类型, 1:DVR 2:ATM DVR 3:DVS ......
    byChanNum: BYTE; //模拟通道个数
    byStartChan: BYTE; //起始通道号,例如DVS-1,DVR - 1
    byAudioChanNum: BYTE; //语音通道数
    byIPChanNum: BYTE; //最大数字通道个数
    byRes1: array[1..24] of BYTE; //保留

  end;

//预览参数
  LPNET_DVR_DISPLAY_PARA = ^NET_DVR_DISPLAY_PARA;
  NET_DVR_DISPLAY_PARA = record
    bToScreen: long;
    bToVideoOut: long;
    nLeft: long;
    nTop: long;
    nWidth: long;
    nHeight: long;
    nReserved: long;
  end;

  LPNET_DVR_CLIENTINFO = ^NET_DVR_CLIENTINFO;
  NET_DVR_CLIENTINFO = record
    lChannel: LONG; //通道号                                //   10000000000000000000000000000000     2147483648   $80000000
    lLinkMode: LONG; //最高位(31)为0表示主码流，为1表示子码流，0－30位表示码流连接方式: 0：TCP方式,1：UDP方式,2：多播方式,3 - RTP方式，4-音视频分开(TCP)
    hPlayWnd: HWND; //播放窗口的句柄,为NULL表示不播放图象
    sMultiCastIP: PChar; //多播组地址
  end;

  LPNET_DVR_CLIENTINFO_V40 = ^NET_DVR_CLIENTINFO_V40;
  NET_DVR_CLIENTINFO_V40 = record
    lChannel: LONG; //通道号
    dwStreamType: LONG;   // 码流类型，0-主码流，1-子码流，2-码流3，3-码流4 等以此类推
    lLinkMode: LONG; //最高位(31)为0表示主码流，为1表示子码流，0－30位表示码流连接方式: 0：TCP方式,1：UDP方式,2：多播方式,3 - RTP方式，4-音视频分开(TCP)
    hPlayWnd: HWND; //播放窗口的句柄,为NULL表示不播放图象
    bBlocked: Boolean;        //0-非阻塞取流, 1-阻塞取流, 如果阻塞SDK内部connect失败将会有5s的超时才能够返回,不适合于轮询取流操作.
    bPassbackRecord: Boolean;  //0-不启用录像回传,1启用录像回传
    byPreviewMode: Byte;    //预览模式，0-正常预览，1-延迟预览
    byRes: array[0..254] of Byte;
    sMultiCastIP: PChar; //多播组地址
  end;

  LPNET_DVR_CARDINFO = ^NET_DVR_CARDINFO;
  NET_DVR_CARDINFO = record
    lChannel: LONG; //通道号
    lLinkMode: LONG; //最高位(31)为0表示主码流，为1表示子码流，0－30位表示码流连接方式: 0：TCP方式,1：UDP方式,2：多播方式,3 - RTP方式，4-电话线，5－128k宽带，6－256k宽带，7－384k宽带，8－512k宽带；
    sMultiCastIP: PChar;
    struDisplayPara: NET_DVR_DISPLAY_PARA;
  end;

  LPNET_DVR_TIME = ^NET_DVR_TIME;
  NET_DVR_TIME = record
    dwYear: DWORD; //年
    dwMonth: DWORD; //月
    dwDay: DWORD; //日
    dwHour: DWORD; //时
    dwMinute: DWORD; //分
    dwSecond: DWORD; //秒
  end;

  LPNET_DVR_SCHEDTIME = ^NET_DVR_SCHEDTIME;
  NET_DVR_SCHEDTIME = record
    //开始时间
    byStartHour: BYTE;
    byStartMin: BYTE;
    //结束时间
    byStopHour: BYTE;
    byStopMin: BYTE;
  end;

const
//*处理方式*/
  NOACTION = 0; //*无响应*/
  WARNONMONITOR = 1; //*监视器上警告*/
  WARNONAUDIOOUT = 2; //*声音警告*/
  UPTOCENTER = 4; //*上传中心*/
  TRIGGERALARMOUT = 8; //*触发报警输出*/

type

  LPNET_DVR_HANDLEEXCEPTION = ^NET_DVR_HANDLEEXCEPTION;
  NET_DVR_HANDLEEXCEPTION = record
    dwHandleType: DWORD; //*处理方式,处理方式的"或"结果*/
 //*$00: 无响应*/
 //*$01: 监视器上警告*/
 //*$02: 声音警告*/
 //*$04: 上传中心*/
 //*$08: 触发报警输出*/
    byRelAlarmOut: array[0..MAX_ALARMOUT - 1] of BYTE; //报警触发的输出通道,报警触发的输出,为1表示触发该输出
  end;

  //DVR设备参数
  LPNET_DVR_DEVICECFG = ^NET_DVR_DEVICECFG;
  NET_DVR_DEVICECFG = record
    dwSize: DWORD;
    sDVRName: array[0..NAME_LEN - 1] of BYTE; //DVR名称
    dwDVRID: DWORD; //DVR ID,用于遥控器
    dwRecycleRecord: DWORD; //是否循环录像,0:不是; 1:是
        //以下不能更改
    sSerialNumber: array[0..SERIALNO_LEN - 1] of BYTE; //序列号
    dwSoftwareVersion: DWORD; // 软件版本号,高16位是主版本,低16位是次版本
    dwSoftwareBuildDate: DWORD; // 软件生成日期,$YYYYMMDD
    dwDSPSoftwareVersion: DWORD; // DSP软件版本,高16位是主版本,低16位是次版本
    dwDSPSoftwareBuildDate: DWORD; // DSP软件生成日期,$YYYYMMDD
    dwPanelVersion: DWORD; // 前面板版本,高16位是主版本,低16位是次版本
    dwHardwareVersion: DWORD; // 硬件版本,高16位是主版本,低16位是次版本
    byAlarmInPortNum: BYTE; // DVR报警输入个数
    byAlarmOutPortNum: BYTE; // DVR报警输出个数
    byRS232Num: BYTE; // DVR 232串口个数
    byRS485Num: BYTE; // DVR 485串口个数
    byNetworkPortNum: BYTE; // 网络口个数
    byDiskCtrlNum: BYTE; // DVR 硬盘控制器个数
    byDiskNum: BYTE; // DVR 硬盘个数
    byDVRType: BYTE; //DVR类型,
    byChanNum: BYTE; //DVR 通道个数
    byStartChan: BYTE; //起始通道号,例如DVS-1,DVR - 1
    byDecordChans: BYTE; //DVR 解码路数
    byVGANum: BYTE; //VGA口的个数
    byUSBNum: BYTE; //USB口的个数
    reservedData: array[0..2] of Char; //保留
  end;


  LPNET_DVR_ETHERNET = ^NET_DVR_ETHERNET;
  NET_DVR_ETHERNET = record
    sDVRIP: char_16; //DVR IP地址
    sDVRIPMask: char_16; // DVR IP地址掩码
    dwNetInterface: DWORD; //网络接口 1-10MBase-T 2-10MBase-T全双工 3-100MBase-TX 4-100M全双工 5-10M/100M自适应
    wDVRPort: WORD; //端口号
    byMACAddr: array[0..MACADDR_LEN - 1] of BYTE; //服务器的物理地址
  end;

//网络配置结构
  LPNET_DVR_NETCFG = ^NET_DVR_NETCFG;
  NET_DVR_NETCFG = record
    dwSize: DWORD;
    struEtherNet: array[0..MAX_ETHERNET - 1] of NET_DVR_ETHERNET; //* 以太网口 */
    sManageHostIP: char_16; //远程管理主机地址
    wManageHostPort: WORD; //远程管理主机端口号
    sDNSIP: char_16; //DNS服务器地址
    sMultiCastIP: char_16; //多播组地址
    sGatewayIP: char_16; //网关地址
    sNFSIP: char_16; //NAS主机IP地址
    sNFSDirectory: array[0..PATHNAME_LEN - 1] of BYTE; //NAS目录
    dwPPPOE: DWORD; //0-不启用,1-启用
    sPPPoEUser: array[0..NAME_LEN - 1] of byte; //PPPoE用户名
    sPPPoEPassword: array[0..PASSWD_LEN - 1] of char; // PPPoE密码
    sPPPoEIP: char_16; //PPPoE IP地址(只读)
    wHttpPort: WORD; //HTTP端口号
  end;

//通道图象结构
//移动侦测

  LPNET_DVR_MOTION = ^NET_DVR_MOTION;
  NET_DVR_MOTION = record
    byMotionScope: array[0..17, 0..21] of BYTE; //*侦测区域,共有22*18个小宏块,为1表示该宏块是移动侦测区域,0-表示不是*/
    byMotionSensitive: BYTE; //*移动侦测灵敏度, 0 - 5,越高越灵敏,$ff关闭*/
    byEnableHandleMotion: BYTE; //* 是否处理移动侦测 */
    strMotionHandleType: NET_DVR_HANDLEEXCEPTION; //* 处理方式 */
    struAlarmTime: array[0..MAX_DAYS - 1, 0..MAX_TIMESEGMENT - 1] of NET_DVR_SCHEDTIME; //布防时间
    byRelRecordChan: array[0..MAX_CHANNUM - 1] of BYTE; //报警触发的录象通道,为1表示触发该通道
  end;

  //遮挡报警区域为704*576

  LPNET_DVR_HIDEALARM = ^NET_DVR_HIDEALARM;
  NET_DVR_HIDEALARM = record
    dwEnableHideAlarm: DWORD; //* 是否启动遮挡报警 ,0-否,1-低灵敏度 2-中灵敏度 3-高灵敏度 */
    wHideAlarmAreaTopLeftX: WORD; //* 遮挡区域的x坐标 */
    wHideAlarmAreaTopLeftY: WORD; //* 遮挡区域的y坐标 */
    wHideAlarmAreaWidth: WORD; //* 遮挡区域的宽 */
    wHideAlarmAreaHeight: WORD; //*遮挡区域的高*/
    strHideAlarmHandleType: NET_DVR_HANDLEEXCEPTION; //* 处理方式 */
    struAlarmTime: array[0..MAX_DAYS - 1, 0..MAX_TIMESEGMENT - 1] of NET_DVR_SCHEDTIME; //布防时间
  end;

//信号丢失报警
  LPNET_DVR_VILOST = ^NET_DVR_VILOST;
  NET_DVR_VILOST = record
    byEnableHandleVILost: BYTE; //* 是否处理信号丢失报警 */
    strVILostHandleType: NET_DVR_HANDLEEXCEPTION; //* 处理方式 */
    struAlarmTime: array[0..MAX_DAYS - 1, 0..MAX_TIMESEGMENT - 1] of NET_DVR_SCHEDTIME; //布防时间
  end;


  LPNET_DVR_PICCFG = ^NET_DVR_PICCFG;
  NET_DVR_PICCFG = record
    dwSize: DWORD;
    sChanName: array[0..NAME_LEN - 1] of BYTE;
    dwVideoFormat: DWORD; //* 只读：视频制式 1-NTSC 2-PAL*/
    byBrightness: BYTE; //*亮度,0-255*/
    byContrast: BYTE; //*对比度,0-255*/
    bySaturation: BYTE; //*饱和度,0-255 */
    byHue: BYTE; //*色调,0-255*/
 //显示通道名
    dwShowChanName: DWord; //* 预览的图象上是否显示通道名称,0-不显示,1-显示 区域为704*576 */
    wShowNameTopLeftX: Word; //* 通道名称显示位置的x坐标 */
    wShowNameTopLeftY: Word; //* 通道名称显示位置的y坐标 */
 //信号丢失报警
    struVILost: NET_DVR_VILOST;
 //移动侦测
    struMotion: NET_DVR_MOTION;
 //遮挡报警
    struHideAlarm: NET_DVR_HIDEALARM;
 //遮挡
    dwEnableHide: DWORD; //* 是否启动遮挡 ,0-否,1-是 区域为704*576*/
    wHideAreaTopLeftX: WORD; //* 遮挡区域的x坐标 */
    wHideAreaTopLeftY: WORD; //* 遮挡区域的y坐标 */
    wHideAreaWidth: WORD; //* 遮挡区域的宽 */
    wHideAreaHeight: WORD; //*遮挡区域的高*/
 //OSD
    dwShowOsd: DWORD; //* 预览的图象上是否显示OSD,0-不显示,1-显示*/
    wOSDTopLeftX: WORD; //* OSD的x坐标 */
    wOSDTopLeftY: WORD; //* OSD的y坐标 */
    byOSDType: BYTE; //* OSD类型(主要是年月日格式) */
       //* 0: XXXX-XX-XX 年月日 */
       //* 1: XX-XX-XXXX 月日年 */
       //* 2: XXXX年XX月XX日 */
       //* 3: XX月XX日XXXX年 */
       //* 4: XX-XX-XXXX 日月年*/
       //* 5: XX日XX月XXXX年 */

    byDispWeek: BYTE; //* 是否显示星期 */
    byOSDAttrib: BYTE; //* OSD属性:透明，闪烁 */
         //* 1: 透明,闪烁 */
         //* 2: 透明,不闪烁 */
         //* 3: 闪烁,不透明 */
         //* 4: 不透明,不闪烁 */
  end;

  LPNET_DVR_SHELTER = ^NET_DVR_SHELTER;
  NET_DVR_SHELTER = record
    wHideAreaTopLeftX: WORD; //* 遮挡区域的x坐标 */
    wHideAreaTopLeftY: WORD; //* 遮挡区域的y坐标 */
    wHideAreaWidth: WORD; //* 遮挡区域的宽 */
    wHideAreaHeight: WORD; //*遮挡区域的高*/
  end;

//SDK_V14

  LPNET_DVR_PICCFG_EX = ^NET_DVR_PICCFG_EX;
  NET_DVR_PICCFG_EX = record
    dwSize: DWORD;
    sChanName: array[0..NAME_LEN - 1] of BYTE;
    dwVideoFormat: DWORD; //* 只读 视频制式 1-NTSC 2-PAL*/
    byBrightness: BYTE; //*亮度,0-255*/
    byContrast: BYTE; //*对比度,0-255*/
    bySaturation: BYTE; //*饱和度,0-255 */
    byHue: BYTE; //*色调,0-255*/
 //显示通道名
    dwShowChanName: DWORD; // 预览的图象上是否显示通道名称,0-不显示,1-显示 区域大小704*576
    wShowNameTopLeftX: WORD; //* 通道名称显示位置的x坐标 */
    wShowNameTopLeftY: WORD; //* 通道名称显示位置的y坐标 */
 //信号丢失报警
    struVILost: NET_DVR_VILOST;
 //移动侦测
    struMotion: NET_DVR_MOTION;
 //遮挡报警
    struHideAlarm: NET_DVR_HIDEALARM;
 //遮挡  区域大小704*576
    dwEnableHide: DWORD; //* 是否启动遮挡 ,0-否,1-是*/
    struShelter: array[0..MAX_SHELTERNUM - 1] of NET_DVR_SHELTER;
 //OSD
    dwShowOsd: DWORD; // 预览的图象上是否显示OSD,0-不显示,1-显示 区域大小704*576
    wOSDTopLeftX: WORD; //* OSD的x坐标 */
    wOSDTopLeftY: WORD; //* OSD的y坐标 */
    byOSDType: BYTE; //* OSD类型(主要是年月日格式) */
 //* 0: XXXX-XX-XX 年月日 */
 //* 1: XX-XX-XXXX 月日年 */
 //* 2: XXXX年XX月XX日 */
 //* 3: XX月XX日XXXX年 */
    byDispWeek: BYTE; //* 是否显示星期 */
    byOSDAttrib: BYTE; //* OSD属性:透明，闪烁 */
 //* 1: 透明,闪烁 */
 //* 2: 透明,不闪烁 */
 //* 3: 闪烁,不透明 */
 //* 4: 不透明,不闪烁 */
  end;

//压缩参数

  LPNET_DVR_COMPRESSION_INFO = ^NET_DVR_COMPRESSION_INFO;
  NET_DVR_COMPRESSION_INFO = record
    byStreamType: BYTE; //码流类型0-视频流,1-复合流
    byResolution: BYTE; //分辨率0-DCIF 1-CIF, 2-QCIF, 3-4CIF, 4-2CIF
    byBitrateType: BYTE; //码率类型0:变码率，1:定码率
    byPicQuality: BYTE; //图象质量 0-最好 1-次好 2-较好 3-一般 4-较差 5-差
    dwVideoBitrate: DWORD; //视频码率 0-保留 1-保留 2-32K 3-48k 4-64K 5-80K 6-96K 7-128K 8-160k 9-192K 10-224K 11-256K 12-320K
    // 13-384K 14-448K 15-512K 16-640K 17-768K 18-896K 19-1024K 20-1280K 21-1536K 22-1792K 23-2048K
    //最高位(31位)置成1表示是自定义码流, 0-30位表示码流值(MIN-16K MAX-8192K)。
    dwVideoFrameRate: DWORD; //帧率 0-全部; 1-1/16; 2-1/8; 3-1/4; 4-1/2; 5-1; 6-2; 7-4; 8-6; 9-8; 10-10; 11-12; 12-16; 13-20;
  end;

  LPNET_DVR_COMPRESSION_INFO_EX = ^NET_DVR_COMPRESSION_INFO_EX;
  NET_DVR_COMPRESSION_INFO_EX = record
    byStreamType: BYTE; //码流类型0-视频流,1-复合流
    byResolution: BYTE; //分辨率0-DCIF 1-CIF, 2-QCIF, 3-4CIF, 4-2CIF
    byBitrateType: BYTE; //码率类型0:变码率，1:定码率
    byPicQuality: BYTE; //图象质量 0-最好 1-次好 2-较好 3-一般 4-较差 5-差
    dwVideoBitrate: DWORD; //视频码率 0-保留 1-16K(保留) 2-32K 3-48k 4-64K 5-80K 6-96K 7-128K 8-160k 9-192K 10-224K 11-256K 12-320K
 // 13-384K 14-448K 15-512K 16-640K 17-768K 18-896K 19-1024K 20-1280K 21-1536K 22-1792K 23-2048K
 //最高位(31位)置成1表示是自定义码流, 0-30位表示码流值(MIN-32K MAX-8192K)。
    dwVideoFrameRate: DWORD; //帧率 0-全部; 1-1/16; 2-1/8; 3-1/4; 4-1/2; 5-1; 6-2; 7-4; 8-6; 9-8; 10-10; 11-12; 12-16; 13-20; //V2.0增加 14-15; 15-18; 16-22;
    wIntervalFrameI: WORD; //I帧间隔
 //2006-08-11 增加单P帧的配置接口，可以改善实时流延时问题
    byIntervalBPFrame: BYTE; //0-BBP帧; 1-BP帧; 2-单P帧 BP帧设置暂不支持
    byRes: BYTE;
  end;

  LPNET_DVR_COMPRESSIONCFG = ^NET_DVR_COMPRESSIONCFG;
  NET_DVR_COMPRESSIONCFG = record
    dwSize: DWORD;
    struRecordPara: NET_DVR_COMPRESSION_INFO; //录像
    struNetPara: NET_DVR_COMPRESSION_INFO; //网传
  end;

  LPNET_DVR_COMPRESSIONCFG_EX = ^NET_DVR_COMPRESSIONCFG_EX;
  NET_DVR_COMPRESSIONCFG_EX = record
    dwSize: DWORD;
    struRecordPara: NET_DVR_COMPRESSION_INFO_EX; //录像
    struNetPara: NET_DVR_COMPRESSION_INFO_EX; //网传
  end;

//录像
  LPNET_DVR_RECORDSCHED = ^NET_DVR_RECORDSCHED;
  NET_DVR_RECORDSCHED = record
    struRecordTime: NET_DVR_SCHEDTIME;
    byRecordType: BYTE; //0:定时录像，1:移动侦测，2:报警录像，3:动测|报警，4:动测&报警, 5:命令触发, 6: 手动录像
    reservedData: array[0..2] of char;
  end;

  LPNET_DVR_RECORDDAY = ^NET_DVR_RECORDDAY;
  NET_DVR_RECORDDAY = record
    wAllDayRecord: WORD; //* 是否全天录像 */
    byRecordType: BYTE; //* 录象类型 0:定时录像，1:移动侦测，2:报警录像，3:动测|报警，4:动测&报警 5:命令触发, 6: 手动录像*/
    reservedData: char;
  end;

  LPNET_DVR_RECORD = ^NET_DVR_RECORD;
  NET_DVR_RECORD = record
    dwSize: DWORD;
    dwRecord: DWORD; //*是否录像 0-否 1-是*/
    struRecAllDay: array[0..MAX_DAYS - 1] of NET_DVR_RECORDDAY;
    struRecordSched: array[0..MAX_DAYS - 1, 0..MAX_TIMESEGMENT - 1] of NET_DVR_RECORDSCHED;
    dwRecordTime: DWORD; //* 录象时间长度 */
    dwPreRecordTime: DWORD; //* 预录时间 0-不预录 1-5秒 2-10秒 3-15秒 4-20秒 5-25秒 6-30秒 7-$ffffffff(尽可能预录) */
  end;

  LPNET_DVR_FILECOND = ^NET_DVR_FILECOND;
  NET_DVR_FILECOND = record
    lChannel: LONG;
    dwFileType: DWORD;
    dwIsLocked: DWORD;
    dwUseCardNo: DWORD;
    sCardNumber: array[0..31] of Byte;
    struStartTime: NET_DVR_TIME;
    struStopTime: NET_DVR_TIME;
  end;



const
//* PTZ type */
  YOULI = 0;
  LILIN_1016 = 1;
  LILIN_820 = 2;
  PELCO_P = 3;
  DM_QUICKBALL = 4;
  HD600 = 5;
  JC4116 = 6;
  PELCO_DWX = 7;
  PELCO_D = 8;
  VCOM_VC_2000 = 9;
  NETSTREAMER = 10;
  SAE = 11;
  SAMSUNG = 12;
  KALATEL_KTD_312 = 13;
  CELOTEX = 14;
  TLPELCO_P = 15;
  TL_HHX2000 = 16;
  BBV = 17;
  RM110 = 18;
  KC3360S = 19;
  ACES = 20;
  ALSON = 21;
  INV3609HD = 22;
  HOWELL = 23;
  TC_PELCO_P = 24;
  TC_PELCO_D = 25;
  AUTO_M = 26;
  AUTO_H = 27;
  ANTEN = 28;
  CHANGLIN = 29;
  DELTADOME = 30;
  XYM_12 = 31;
  ADR8060 = 32;
  EVI = 33;
  Demo_Speed = 34;
  DM_PELCO_D = 35;
  ST_832 = 36;
  LC_D2104 = 37;
  HUNTER = 38;
  A01 = 39;
  TECHWIN = 40;
  WEIHAN = 41;
  LG = 42;
  D_MAX = 43;
  PANASONIC = 44;
  KTD_348 = 45;
  INFINOVA = 46;
  LILIN = 47;
  IDOME_IVIEW_LCU = 48;
  DENNARD_DOME = 49;
  PHLIPS = 50;
  SAMPLE = 51;
  PLD = 52;
  PARCO = 53;
  HY = 54;
  NAIJIE = 55;
  CAT_KING = 56;
  YH_06 = 57;
  SP9096X = 58;
  M_PANEL = 59;
  M_MV2050 = 60;
  SAE_QUICKBALL = 61;
  RED_APPLE = 62;
  NKO8G = 63;
  DAHUA = 64;
  TX_CONTROL_232 = 65;
  VCL_SPEED_DOME = 66;
  ST_2C160 = 67;
  TIANDI = 68;
  TWHC = 69;
  USNT = 70;
  KALLATE_NVD2200PS = 71;


type
//解码器
  LPNET_DVR_DECODERCFG = ^NET_DVR_DECODERCFG;
  NET_DVR_DECODERCFG = record
    dwSize: DWORD;
    dwBaudRate: DWORD; //波特率(bps)，0－50，1－75，2－110，3－150，4－300，5－600，6－1200，7－2400，8－4800，9－9600，10－19200， 11－38400，12－57600，13－76800，14－115.2k;
    byDataBit: BYTE; // 数据有几位 0－5位，1－6位，2－7位，3－8位;
    byStopBit: BYTE; // 停止位 0－1位，1－2位;
    byParity: BYTE; // 校验 0－无校验，1－奇校验，2－偶校验;
    byFlowcontrol: BYTE; // 0－无，1－软流控,2-硬流控
    wDecoderType: WORD; //解码器类型, 0－YouLi，1－LiLin-1016，2－LiLin-820，3－Pelco-p，4－DM DynaColor，5－HD600，6－JC-4116，7－Pelco-d WX，8－Pelco-d PICO
    wDecoderAddress: WORD; //*解码器地址:0 - 255*/
    bySetPreset: array[0..MAX_PRESET - 1] of byte; //* 预置点是否设置,0-没有设置,1-设置*/
    bySetCruise: array[0..MAX_PRESET - 1] of byte; //* 巡航是否设置: 0-没有设置,1-设置 */
    bySetTrack: array[0..MAX_PRESET - 1] of byte; //* 轨迹是否设置,0-没有设置,1-设置*/
  end;

//RS232串口
  LPNET_DVR_PPPCFG = ^NET_DVR_PPPCFG;
  NET_DVR_PPPCFG = record
    sRemoteIP: char_16; //远端IP地址
    sLocalIP: char_16; //本地IP地址
    sLocalIPMask: char_16; //本地IP地址掩码
    sUsername: array[0..NAME_LEN - 1] of BYTE; //* 用户名 */
    sPassword: array[0..PASSWD_LEN - 1] of BYTE; //* 密码 */
    byPPPMode: Byte; //PPP模式, 0－主动，1－被动
    byRedial: Byte; //是否回拨 ：0-否,1-是
    byRedialMode: Byte; //回拨模式,0-由拨入者指定,1-预置回拨号码
    byDataEncrypt: Byte; //数据加密,0-否,1-是
    dwMTU: DWORD; //MTU
    sTelephoneNumber: array[0..PHONENUMBER_LEN - 1] of char; //电话号码
  end;

  LPNET_DVR_RS232CFG = ^NET_DVR_RS232CFG;
  NET_DVR_RS232CFG = record
    dwSize: DWORD;
    dwBaudRate: DWORD; //波特率(bps)，0－50，1－75，2－110，3－150，4－300，5－600，6－1200，7－2400，8－4800，9－9600，10－19200， 11－38400，12－57600，13－76800，14－115.2k;
    byDataBit: BYTE; // 数据有几位 0－5位，1－6位，2－7位，3－8位;
    byStopBit: BYTE; // 停止位 0－1位，1－2位;
    byParity: BYTE; // 校验 0－无校验，1－奇校验，2－偶校验;
    byFlowcontrol: BYTE; // 0－无，1－软流控,2-硬流控
    dwWorkMode: DWORD; // 工作模式，0－窄带传输(232串口用于PPP拨号)，1－控制台(232串口用于参数控制)，2－透明通道
    struPPPConfig: NET_DVR_PPPCFG;
  end;

//报警输入

  LPNET_DVR_ALARMINCFG = ^NET_DVR_ALARMINCFG;
  NET_DVR_ALARMINCFG = record
    dwSize: DWORD;
    sAlarmInName: array[0..NAME_LEN - 1] of BYTE; //* 名称 */
    byAlarmType: BYTE; //报警器类型,0：常开,1：常闭
    byAlarmInHandle: BYTE; //* 是否处理 */
    struAlarmHandleType: NET_DVR_HANDLEEXCEPTION; //* 处理方式 */
    struAlarmTime: array[0..MAX_DAYS - 1, 0..MAX_TIMESEGMENT - 1] of NET_DVR_SCHEDTIME; //布防时间
    byRelRecordChan: array[0..MAX_CHANNUM - 1] of BYTE; //报警触发的录象通道,为1表示触发该通道
    byEnablePreset: array[0..MAX_CHANNUM - 1] of BYTE; //* 是否调用预置点 */
    byPresetNo: array[0..MAX_CHANNUM - 1] of BYTE; //* 调用的云台预置点序号,一个报警输入可以调用多个通道的云台预置点, $ff表示不调用预置点。*/
    byEnableCruise: array[0..MAX_CHANNUM - 1] of BYTE; //* 是否调用巡航 */
    byCruiseNo: array[0..MAX_CHANNUM - 1] of BYTE; //* 巡航 */
    byEnablePtzTrack: array[0..MAX_CHANNUM - 1] of BYTE; //* 是否调用轨迹 */
    byPTZTrack: array[0..MAX_CHANNUM - 1] of BYTE; //* 调用的云台的轨迹序号 */
  end;


//上传报警信息
  LPNET_DVR_ALARMINFO = ^NET_DVR_ALARMINFO;
  NET_DVR_ALARMINFO = record
    dwAlarmType: DWORD; //*0-信号量报警,1-硬盘满,2-信号丢失，3－移动侦测，4－硬盘未格式化,5-读写硬盘出错,6-遮挡报警,7-制式不匹配, 8-非法访问*/
    dwAlarmInputNumber: DWORD; //*报警输入端口*/
    dwAlarmOutputNumber: array[0..MAX_ALARMOUT - 1] of DWORD; //*报警输入端口对应的输出端口，哪一位为1表示对应哪一个输出*/
    dwAlarmRelateChannel: array[0..MAX_CHANNUM - 1] of DWORD; //*报警输入端口对应的录像通道，哪一位为1表示对应哪一路录像,dwAlarmRelateChannel[0]对应第1个通道*/
    dwChannel: array[0..MAX_CHANNUM - 1] of DWORD; //*dwAlarmType为2或3时，表示哪个通道，dwChannel[0]位对应第0个通道*/
    dwDiskNumber: array[0..MAX_DISKNUM - 1] of DWORD; //*dwAlarmType为4时,表示哪个硬盘*/
  end;


//DVR报警输出
  LPNET_DVR_ALARMOUTCFG = ^NET_DVR_ALARMOUTCFG;
  NET_DVR_ALARMOUTCFG = record
    dwSize: DWORD;
    sAlarmOutName: array[0..NAME_LEN - 1] of BYTE; //* 名称 */
    dwAlarmOutDelay: DWORD; //* 输出保持时间(-1为无限，手动关闭) */
    struAlarmOutTime: array[0..MAX_DAYS - 1, 0..MAX_TIMESEGMENT - 1] of NET_DVR_SCHEDTIME; //* 报警输出激活时间段 */
  end;

//DVR本地预览参数
  LPNET_DVR_PREVIEWCFG = ^NET_DVR_PREVIEWCFG;
  NET_DVR_PREVIEWCFG = record
    dwSize: DWORD;
    byPreviewNumber: BYTE; //预览数目,0-1画面,1-4画面,2-9画面,3-16画面,$ff:最大画面
    byEnableAudio: BYTE; //是否声音预览,0-不预览,1-预览
    wSwitchTime: WORD; //切换时间,0-不切换,1-5s,2-10s,3-20s,4-60s,5-120s,6-300s
    bySwitchSeq: array[0..MAX_WINDOW - 1] of BYTE; //切换顺序,如果lSwitchSeq[i]为 $ff表示不用
  end;

//DVR视频输出
  LPNET_DVR_VGAPARA = ^NET_DVR_VGAPARA;
  NET_DVR_VGAPARA = record
    wResolution: WORD; //* 分辨率 */
    wFreq: WORD; //* 刷新频率 */
    dwBrightness: DWORD; //* 亮度 */
  end;


  PNET_DVR_MATRIXPARA = ^NET_DVR_MATRIXPARA;
  NET_DVR_MATRIXPARA = record
    wDisplayLogo: WORD; //* 显示视频通道号 */
    wDisplayOsd: WORD; //* 显示时间 */
  end;

  LPNET_DVR_VOOUT = ^NET_DVR_VOOUT;
  NET_DVR_VOOUT = record
    byVideoFormat: BYTE; //* 输出制式,0-PAL,1-N	*/
    byMenuAlphaValue: BYTE; //* 菜单与背景图象对比度 */
    wScreenSaveTime: WORD; //* 屏幕保护时间 */
    wVOffset: WORD; //* 视频输出偏移 */
    wBrightness: WORD; //* 视频输出亮度 */
    byStartMode: BYTE; //* 启动后视频输出模式(0:菜单,1:预览)*/
    reservedData: char;
  end;

  LPNET_DVR_VIDEOOUT = ^NET_DVR_VIDEOOUT;
  NET_DVR_VIDEOOUT = record
    dwSize: DWORD;
    struVOOut: array[0..MAX_VIDEOOUT - 1] of NET_DVR_VOOUT;
    struVGAPara: array[0..MAX_VGA - 1] of NET_DVR_VGAPARA; //* VGA参数 */
    struMatrixPara: NET_DVR_MATRIXPARA; //* MATRIX参数 */
  end;

//DVR用户参数
  LPNET_DVR_USER_INFO = ^NET_DVR_USER_INFO;
  NET_DVR_USER_INFO = record
    sUserName: array[0..NAME_LEN - 1] of BYTE; //* 用户名 */
    sPassword: array[0..PASSWD_LEN - 1] of BYTE; //* 密码 */
    dwLocalRight: array[0..MAX_RIGHT - 1] of DWORD; //* 权限 */
  //*数组0: 本地控制云台*/
  //*数组1: 本地手动录象*/
  //*数组2: 本地回放*/
  //*数组3: 本地设置参数*/
  //*数组4: 本地查看状态、日志*/
  //*数组5: 本地高级操作(升级，格式化，重启，关机)*/
    dwRemoteRight: array[0..MAX_RIGHT - 1] of DWORD; //* 权限 */
    //*数组0: 远程控制云台*/
   //*数组1: 远程手动录象*/
  //*数组2: 远程回放*/
  //*数组3: 远程设置参数*/
  //*数组4: 远程查看状态、日志*/
  //*数组5: 远程高级操作(升级，格式化，重启，关机)*/
  //*数组6: 远程发起语音对讲*/
  //*数组7: 远程预览*/
  //*数组8: 远程请求报警上传、报警输出*/
  //*数组9: 远程控制，本地输出*/
  //*数组10: 远程控制串口*/
    sUserIP: char_16; //* 用户IP地址(为0时表示允许任何地址) */
    byMACAddr: array[0..MACADDR_LEN - 1] of BYTE; //* 物理地址 */
  end;

  LPNET_DVR_USER = ^NET_DVR_USER;
  NET_DVR_USER = record
    dwSize: DWORD;
    struUser: array[0..MAX_USERNUM - 1] of NET_DVR_USER_INFO;
  end;

  //DVR用户参数扩展
  LPNET_DVR_USER_INFO_EX = ^NET_DVR_USER_INFO_EX;
  NET_DVR_USER_INFO_EX = record
    sUserName: array[0..NAME_LEN - 1] of BYTE; //* 用户名 */
    sPassword: array[0..PASSWD_LEN - 1] of BYTE; //* 密码 */
    dwLocalRight: array[0..MAX_RIGHT - 1] of DWORD; //* 权限 */
 //*数组0: 本地控制云台*/
 //*数组1: 本地手动录象*/
 //*数组2: 本地回放*/
 //*数组3: 本地设置参数*/
 //*数组4: 本地查看状态、日志*/
 //*数组5: 本地高级操作(升级，格式化，重启，关机)*/
    dwLocalPlaybackRight: DWORD; //* 本地可以回放的通道 bit0 -- channel 1*/
    dwRemoteRight: array[0..MAX_RIGHT - 1] of DWORD; //* 权限 */
 //*数组0: 远程控制云台*/
 //*数组1: 远程手动录象*/
 //*数组2: 远程回放 */
 //*数组3: 远程设置参数*/
 //*数组4: 远程查看状态、日志*/
 //*数组5: 远程高级操作(升级，格式化，重启，关机)*/
 //*数组6: 远程发起语音对讲*/
 //*数组7: 远程预览*/
 //*数组8: 远程请求报警上传、报警输出*/
 //*数组9: 远程控制，本地输出*/
 //*数组10: 远程控制串口*/
    dwNetPreviewRight: DWORD; //* 远程可以预览的通道 bit0 -- channel 1*/
    dwNetPlaybackRight: DWORD; //* 远程可以回放的通道 bit0 -- channel 1*/
    sUserIP: char_16; //* 用户IP地址(为0时表示允许任何地址) */
    byMACAddr: array[0..MACADDR_LEN - 1] of BYTE; //* 物理地址 */
  end;

  LPNET_DVR_USER_EX = ^NET_DVR_USER_EX;
  NET_DVR_USER_EX = record
    dwSize: DWORD;
    struUser: array[0..MAX_USERNUM] of NET_DVR_USER_INFO_EX;
  end;

//DVR异常参数
  LPNET_DVR_EXCEPTION = ^NET_DVR_EXCEPTION;
  NET_DVR_EXCEPTION = record
    dwSize: DWORD;
    struExceptionHandleType: array[0..MAX_EXCEPTIONNUM - 1] of NET_DVR_HANDLEEXCEPTION;
 //*数组0-盘满,1- 硬盘出错,2-网线断,3-局域网内IP 地址冲突,4-非法访问, 5-输入/输出视频制式不匹配*/
  end;

  LPNET_DVR_FIND_DATA = ^NET_DVR_FIND_DATA;
  NET_DVR_FIND_DATA = record
    sFileName: array[0..99] of char; //文件名
    struStartTime: NET_DVR_TIME; //文件的开始时间
    struStopTime: NET_DVR_TIME; //文件的结束时间
    dwFileSize: DWORD; //文件的大小
  end;

  LPNET_DVR_FINDDATA_V30 = ^NET_DVR_FINDDATA_V30;
  NET_DVR_FINDDATA_V30 = record
    sFileName: array[0..99] of char; //文件名
    struStartTime: NET_DVR_TIME; //文件的开始时间
    struStopTime: NET_DVR_TIME; //文件的结束时间
    dwFileSize: DWORD;
    sCardNum: array[0..31] of Char;
    byLocked: Byte;
    byRes: array[0..2] of Byte;
  end;


  LPNET_DVR_CHANNELSTATE = ^NET_DVR_CHANNELSTATE;
  NET_DVR_CHANNELSTATE = record
    byRecordStatic: BYTE; //通道是否在录像,0-不录像,1-录像
    bySignalStatic: BYTE; //连接的信号状态,0-正常,1-信号丢失
    byHardwareStatic: BYTE; //通道硬件状态,0-正常,1-异常,例如DSP死掉
    reservedData: char;
    dwBitRate: DWORD; //实际码率
    dwLinkNum: DWORD; //客户端连接的个数
    dwClientIP: array[0..MAX_LINK - 1] of DWORD; //客户端的IP地址
  end;

  LPNET_DVR_DISKSTATE = ^NET_DVR_DISKSTATE;
  NET_DVR_DISKSTATE = record
    dwVolume: DWORD; //硬盘的容量
    dwFreeSpace: DWORD; //硬盘的剩余空间
    dwHardDiskStatic: DWORD; //硬盘的状态,休眠,活动,不正常等
  end;

  NET_DVR_IPADDR=record
   sIpV4:array[0..16-1] of char;
   sIpV6:array[0..128-1] of BYTE;
  end;
  


  NET_DVR_CHANNELSTATE_V30=record
  byRecordStatic:BYTE;
  bySignalStatic:BYTE;
  byHardwareStatic:BYTE;
  byRes1:BYTE;
  dwBitRate:DWORD;
  dwLinkNum:DWORD;
  struClientIP:array[0..MAX_LINK-1] of NET_DVR_IPADDR;
  dwIPLinkNum:DWORD;
  byRes:array[0..12-1] of BYTE;
  end;

  LPNET_DVR_WORKSTATE = ^NET_DVR_WORKSTATE;
  NET_DVR_WORKSTATE = record
    dwDeviceStatic: DWORD; //设备的状态,0-正常,1-CPU占用率太高,超过85%,2-硬件错误,例如串口死掉
    struHardDiskStatic: array[0..MAX_DISKNUM - 1] of NET_DVR_DISKSTATE;
    struChanStatic: array[0..MAX_CHANNUM - 1] of NET_DVR_CHANNELSTATE; //通道的状态
    byAlarmInStatic: array[0..MAX_ALARMIN - 1] of BYTE; //报警端口的状态,0-没有报警,1-有报警
    byAlarmOutStatic: array[0..MAX_ALARMOUT - 1] of BYTE; //报警输出端口的状态,0-没有输出,1-有报警输出
    dwLocalDisplay: DWORD; //本地显示状态,0-正常,1-不正常
  end;

  LPNET_DVR_WORKSTATE_V30 = ^NET_DVR_WORKSTATE_V30;
  NET_DVR_WORKSTATE_V30=record
  dwDeviceStatic:DWORD;
  struHardDiskStatic:array[0..MAX_DISKNUM_V30-1] of NET_DVR_DISKSTATE;
  struChanStatic:array[0..MAX_CHANNUM_V30-1] of NET_DVR_CHANNELSTATE_V30;
  byAlarmInStatic:array[0..MAX_ALARMIN_V30-1] of BYTE;
  byAlarmOutStatic:array[0..MAX_ALARMOUT_V30-1] of BYTE;
  dwLocalDisplay:DWORD;
  byAudioChanStatus:array[0..MAX_AUDIO_V30-1] of BYTE;
  byRes:array[0..10-1] of BYTE;
 end;

const
//DVR日志
//* 报警 */
//主类型
  MAJOR_ALARM = $1;
//次类型
  MINOR_ALARM_IN = $1; //* 报警输入 */
  MINOR_ALARM_OUT = $2; //* 报警输出 */
  MINOR_MOTDET_START = $3; //* 移动侦测报警开始 */
  MINOR_MOTDET_STOP = $4; //* 移动侦测报警结束 */
  MINOR_HIDE_ALARM_START = $5; //* 遮挡报警开始 */
  MINOR_HIDE_ALARM_STOP = $6; //* 遮挡报警结束 */

//* 异常 */
//主类型
  MAJOR_EXCEPTION = $2;
//次类型
  MINOR_VI_LOST = $21; //* 信号丢失 */
  MINOR_ILLEGAL_ACCESS = $22; //* 非法访问 */
  MINOR_HD_FULL = $23; //* 硬盘满 */
  MINOR_HD_ERROR = $24; //* 硬盘错误 */
  MINOR_DCD_LOST = $25; //* MODEM 掉线 */
  MINOR_IP_CONFLICT = $26; //* IP地址冲突 */
  MINOR_NET_BROKEN = $27; //* 网线断 */

//* 操作 */
//主类型
  MAJOR_OPERATION = $3;
//次类型
  MINOR_START_DVR = $41; //* 开机 */
  MINOR_STOP_DVR = $42; //* 关机 */
  MINOR_STOP_ABNORMAL = $43; //* 非法关机 */

  MINOR_LOCAL_LOGIN = $50; //* 本地登陆 */
  MINOR_LOCAL_LOGOUT = $51; //* 本地注销登陆 */
  MINOR_LOCAL_CFG_PARM = $52; //* 本地配置参数 */
  MINOR_LOCAL_PLAYBYFILE = $53; //* 本地按文件回放 */
  MINOR_LOCAL_PLAYBYTIME = $54; //* 本地按时间回放 */
  MINOR_LOCAL_START_REC = $55; //* 本地开始录像 */
  MINOR_LOCAL_STOP_REC = $56; //* 本地停止录像 */
  MINOR_LOCAL_PTZCTRL = $57; //* 本地云台控制 */
  MINOR_LOCAL_PREVIEW = $58; //* 本地预览 */
  MINOR_LOCAL_MODIFY_TIME = $59; //* 本地修改时间 */
  MINOR_LOCAL_UPGRADE = $5A; //* 本地升级 */
  MINOR_LOCAL_COPYFILE = $5B; //* 本地备份文件 */

  MINOR_REMOTE_LOGIN = $70; //* 远程登录 */
  MINOR_REMOTE_LOGOUT = $71; //* 远程注销登陆 */
  MINOR_REMOTE_START_REC = $72; //* 远程开始录像 */
  MINOR_REMOTE_STOP_REC = $73; //* 远程停止录像 */
  MINOR_START_TRANS_CHAN = $74; //* 开始透明传输 */
  MINOR_STOP_TRANS_CHAN = $75; //* 停止透明传输 */
  MINOR_REMOTE_GET_PARM = $76; //* 远程获得参数 */
  MINOR_REMOTE_CFG_PARM = $77; //* 远程配置参数 */
  MINOR_REMOTE_GET_STATUS = $78; //* 远程获得状态 */
  MINOR_REMOTE_ARM = $79; //* 远程布防 */
  MINOR_REMOTE_DISARM = $7A; //* 远程撤防 */
  MINOR_REMOTE_REBOOT = $7B; //* 远程重启 */
  MINOR_START_VT = $7C; //* 开始语音对讲 */
  MINOR_STOP_VT = $7D; //* 停止语音对讲 */
  MINOR_REMOTE_UPGRADE = $7E; //* 远程升级 */
  MINOR_REMOTE_PLAYBYFILE = $7F; //* 远程按文件回放 */
  MINOR_REMOTE_PLAYBYTIME = $80; //* 远程按时间回放 */
  MINOR_REMOTE_PTZCTRL = $81; //* 远程云台控制 */

type
  LPNET_DVR_LOG = ^NET_DVR_LOG;
  NET_DVR_LOG = record
    strLogTime: NET_DVR_TIME;
    dwMajorType: DWORD; //主类型 1-报警; 2-异常; 3-操作; $ff-全部
    dwMinorType: DWORD; //次类型 $ff-全部;
    sPanelUser: array[0..MAX_NAMELEN - 1] of BYTE; //操作面板的用户名
    sNetUser: array[0..MAX_NAMELEN - 1] of BYTE; //网络操作的用户名
    sRemoteHostAddr: char_16; //远程主机地址
    dwParaType: DWORD; //参数类型
    dwChannel: DWORD; //通道号
    dwDiskNumber: DWORD; //硬盘号
    dwAlarmInPort: DWORD; //报警输入端口
    dwAlarmOutPort: DWORD; //报警输出端口
  end;

  LPNET_DVR_REDIRECTORINFO = ^NET_DVR_REDIRECTORINFO;
  NET_DVR_REDIRECTORINFO = record
    sRedirectorIP: char_16; // 转发服务器IP地址
    wRedirectorPort: WORD; // 端口号
  end;

  LPNET_DVR_ALARMOUTSTATUS = ^NET_DVR_ALARMOUTSTATUS;
  NET_DVR_ALARMOUTSTATUS = record
    Output: array[0..MAX_ALARMOUT - 1] of BYTE;
  end;

  LPNET_DVR_TRADEINFO = ^NET_DVR_TRADEINFO;
  NET_DVR_TRADEINFO = record
    m_Year: USHORT;
    m_Month: USHORT;
    m_Day: USHORT;
    m_Hour: USHORT;
    m_Minute: USHORT;
    m_Second: USHORT;
    DeviceName: array[0..23] of BYTE; //设备名称
    dwChannelNumer: DWORD; //通道号
    CardNumber: array[0..31] of BYTE; //卡号
    cTradeType: array[0..12] of char; //交易类型
    dwCash: DWORD; //交易金额
  end;

//以下为ATM专用
//*帧格式*/

  LPNET_DVR_FRAMETYPECODE = ^NET_DVR_FRAMETYPECODE;
  NET_DVR_FRAMETYPECODE = record
    code: array[0..11] of BYTE; //* 代码 */
  end;

  LPNET_DVR_FRAMEFORMAT = ^NET_DVR_FRAMEFORMAT;
  NET_DVR_FRAMEFORMAT = record
    dwSize: DWORD;
    sATMIP: char_16; //* ATM IP地址 */
    dwATMType: DWORD; //* ATM类型 */
    dwInputMode: DWORD; //* 输入方式	*/
    dwFrameSignBeginPos: DWORD; //* 报文标志位的起始位置*//
    dwFrameSignLength: DWORD; //* 报文标志位的长度 */
    byFrameSignContent: array[0..11] of BYTE; //* 报文标志位的内容 */
    dwCardLengthInfoBeginPos: DWORD; //* 卡号长度信息的起始位置 */
    dwCardLengthInfoLength: DWORD; //* 卡号长度信息的长度 */
    dwCardNumberInfoBeginPos: DWORD; //* 卡号信息的起始位置 */
    dwCardNumberInfoLength: DWORD; //* 卡号信息的长度 */
    dwBusinessTypeBeginPos: DWORD; //* 交易类型的起始位置 */
    dwBusinessTypeLength: DWORD; //* 交易类型的长度 */
    frameTypeCode: array[0..9] of NET_DVR_FRAMETYPECODE; //* 类型 */
  end;


const

//DS-6001D/F
//*解码设备控制码定义*/
  NET_DEC_STARTDEC = 1;
  NET_DEC_STOPDEC = 2;
  NET_DEC_STOPCYCLE = 3;
  NET_DEC_CONTINUECYCLE = 4;

type
  //*连接的通道配置*/
  LPNET_DVR_DECCHANINFO = ^NET_DVR_DECCHANINFO;
  NET_DVR_DECCHANINFO = record
    sDVRIP: char_16; //* DVR IP地址 */
    wDVRPort: WORD; //* 端口号 */
    sUserName: array[0..NAME_LEN - 1] of BYTE; //* 用户名 */
    sPassword: array[0..PASSWD_LEN - 1] of BYTE; //* 密码 */
    byChannel: BYTE; //* 通道号 */
    byLinkMode: BYTE; //* 连接模式 */
    byLinkType: BYTE; //* 连接类型 0－主码流 1－子码流 */
  end;

  //*每个解码通道的配置*/
  LPNET_DVR_DECINFO = ^NET_DVR_DECINFO;
  NET_DVR_DECINFO = record
    byPoolChans: BYTE; //*每路解码通道上的循环通道数量, 最多4通道*/
    struchanConInfo: array[0..MAX_DECPOOLNUM - 1] of NET_DVR_DECCHANINFO;
    byEnablePoll: BYTE; //*是否轮巡 0-否 1-是*/
    byPoolTime: BYTE; //*轮巡时间 0-保留 1-10秒 2-15秒 3-20秒 4-30秒 5-45秒 6-1分钟 7-2分钟 8-5分钟 */
  end;

//*整个设备解码配置*/
  LPNET_DVR_DECCFG = ^NET_DVR_DECCFG;
  NET_DVR_DECCFG = record
    dwSize: DWORD;
    dwDecChanNum: DWORD; //*解码通道的数量*/
    struDecInfo: array[0..MAX_DECNUM - 1] of NET_DVR_DECINFO;
  end;
//2005-08-01
//* 解码设备透明通道设置 */
  LPNET_DVR_PORTINFO = ^NET_DVR_PORTINFO;
  NET_DVR_PORTINFO = record
    dwEnableTransPort: DWORD; //* 是否启动透明通道 0－不启用 1－启用*/
    sDecoderIP: char_16; //* DVR IP地址 */
    wDecoderPort: WORD; //* 端口号 */
    wDVRTransPort: WORD; //* 配置前端DVR是从485/232输出，1表示485串口,2表示232串口 */
    cReserve: array[0..3] of char;
  end;


  LPNET_DVR_PORTCFG = ^NET_DVR_PORTCFG;
  NET_DVR_PORTCFG = record
    dwSize: DWORD;
    struTransPortInfo: array[0..MAX_TRANSPARENTNUM - 1] of NET_DVR_PORTINFO; //* 数组0表示485 数组1表示232 */
  end;

  //* 控制网络文件回放 */
  TBytime = record
    dwChannel: DWORD;
    sUserName: array[0..NAME_LEN - 1] of BYTE; //*请求视频用户名*/
    sPassword: array[0..PASSWD_LEN - 1] of BYTE; //* 密码 */
    struStartTime: NET_DVR_TIME; //* 按时间回放的开始时间 */
    struStopTime: NET_DVR_TIME; //* 按时间回放的结束时间 */
  end;

  LPNET_DVR_PLAYREMOTEFILE = ^NET_DVR_PLAYREMOTEFILE;
  NET_DVR_PLAYREMOTEFILE = record
    dwSize: DWORD;
    sDecoderIP: char_16; //* DVR IP地址 */
    wDecoderPort: WORD; //* 端口号 */
    wLoadMode: WORD; //* 回放下载模式 1－按名字 2－按时间 */
    case Integer of
      0: (
        byFile: array[0..99] of BYTE; //* 回放的文件名 */
        );
      1: (
        ByTime: TBytime;
        );

  end;

  //*当前设备解码连接状态*/

  TUserInfo = record
    sUserName: array[0..NAME_LEN - 1] of BYTE; //*请求视频用户名*/
    sPassword: array[0..PASSWD_LEN - 1] of BYTE; //* 密码 */
    cReserve: array[0..51] of char;
  end;
  TfileInfo = record
    fileName: array[0..99] of BYTE;
  end;

  TTimeInfo = record
    dwChannel: DWORD;
    sUserName: array[0..NAME_LEN - 1] of BYTE; //*请求视频用户名*/
    sPassword: array[0..PASSWD_LEN - 1] of BYTE; //* 密码 */
    struStartTime: NET_DVR_TIME; //* 按时间回放的开始时间 */
    struStopTime: NET_DVR_TIME; //* 按时间回放的结束时间 */
  end;

  LPNET_DVR_DECCHANSTATUS = ^NET_DVR_DECCHANSTATUS;
  NET_DVR_DECCHANSTATUS = record
    dwWorkType: DWORD; //*工作方式：1：轮巡、2：动态连接解码、3：按文件回放 4：按时间回放*/
    sDVRIP: char_16; //*连接的设备ip*/
    wDVRPort: WORD; //*连接端口号*/
    byChannel: BYTE; //* 通道号 */
    byLinkMode: BYTE; //* 连接模式 */
    dwLinkType: DWORD; //*连接类型 0－主码流 1－子码流*/
    case Integer of
      0: (userInfo: TuserInfo); // 100个字节
      1: (fileInfo: TfileInfo);
      2: (timeInfo: TtimeInfo);

  end;

  LPNET_DVR_DECSTATUS = ^NET_DVR_DECSTATUS;
  NET_DVR_DECSTATUS = record
    dwSize: DWORD;
    struDecState: array[0..MAX_DECNUM - 1] of NET_DVR_DECCHANSTATUS;
  end;

  //叠加字符
  LPNET_DVR_SHOWSTRINGINFO = ^NET_DVR_SHOWSTRINGINFO;
  NET_DVR_SHOWSTRINGINFO = record
    wShowString: WORD; // 预览的图象上是否显示字符,0-不显示,1-显示 区域大小704*576,单个字符的大小为32*32
    wStringSize: WORD; //* 该行字符的长度，不能大于44个字符 */
    wShowStringTopLeftX: WORD; //* 字符显示位置的x坐标 */
    wShowStringTopLeftY: WORD; //* 字符名称显示位置的y坐标 */
    sString: array[0..43] of char; //* 要显示的字符内容 */
  end;


  //叠加字符

  LPNET_DVR_SHOWSTRING = ^NET_DVR_SHOWSTRING;
  NET_DVR_SHOWSTRING = record
    dwSize: DWORD;
    struStringInfo: array[0..MAX_STRINGNUM - 1] of NET_DVR_SHOWSTRINGINFO; //* 要显示的字符内容 */
  end;

  //* ftp 上传参数*/

  LPNET_DVR_FTPCFG = ^NET_DVR_FTPCFG;
  NET_DVR_FTPCFG = record
    dwSize: DWORD;
    dwEnableFTP: DWORD; //*是否启动ftp上传功能*/
    sFTPIP: char_16; //*ftp 服务器*/
    dwFTPPort: DWORD; //*ftp端口*/
    sUserName: array[0..NAME_LEN - 1] of BYTE; //*用户名*/
    sPassword: array[0..PASSWD_LEN - 1] of BYTE; //*密码*/
 //BYTE	reservedData[32];
    dwDirLevel: DWORD; //*0 = 不使用目录结构，直接保存在根目录,1 = 使用1级目录,2=使用2级目录*/
    wTopDirMode: WORD; //* $1 = 使用设备名,$2 = 使用设备号,$3 = 使用设备ip地址*/
    wSubDirMode: WORD; //* $4 = 使用通道名,$5 = 使用通道号*/
    reservedData: array[0..23] of BYTE;
  end;


const

  //*可用来命名图片的相关元素 */
  PICNAME_ITEM_DEV_NAME = 1;
  PICNAME_ITEM_DEV_NO = 2;
  PICNAME_ITEM_DEV_IP = 3;
  PICNAME_ITEM_CHAN_NAME = 4;
  PICNAME_ITEM_CHAN_NO = 5;
  PICNAME_ITEM_TIME = 6;
  PICNAME_ITEM_CARDNO = 7;
  PICNAME_MAXITEM = 15;

type

  LPNET_DVR_PICTURE_NAME = ^NET_DVR_PICTURE_NAME;
  NET_DVR_PICTURE_NAME = record
    byItemOrder: array[0..PICNAME_MAXITEM - 1] of BYTE; //*	桉数组定义文件命名的规则 */
    byDelimiter: BYTE; //*分隔符，一般为'_'*/
  end;

  //图片质量

  LPNET_DVR_JPEGPARA = ^NET_DVR_JPEGPARA;
  NET_DVR_JPEGPARA = record
    wPicSize: WORD; //*图片尺寸：0-CIF，1-QCIF，2-D1，3-UXGA，4-SVGA，5-HD720p，6-VGA，7-XVGA，8-HD900p */
    wPicQuality: WORD; //* 图片质量系数 0-最好 1-较好 2-一般 */
  end;

  //* 串口抓图设置*/
  LPNET_DVR_SERIAL_CATCHPIC_PARA = ^NET_DVR_SERIAL_CATCHPIC_PARA;
  NET_DVR_SERIAL_CATCHPIC_PARA = record
    byStrFlag: BYTE; //*串口数据开始符*/
    byEndFlag: BYTE; //*结束符*/
    wCardIdx: WORD; //*卡号相对起始位*/
    dwCardLen: DWORD; //*卡号长度*/
    dwTriggerPicChans: DWORD; //*所触发的通道号，按位，从第1位开始计，即$2表示第一通道*/
  end;

 // typedef struct tagJPEGCFG
  LPNET_DVR_JPEGCFG = ^NET_DVR_JPEGCFG;
  NET_DVR_JPEGCFG = record
    dwSize: DWORD;
    struJpegPara: array[0..MAX_CHANNUM - 1] of NET_DVR_JPEGPARA; //*每个通道的图像参数*/
    wBurstMode: WORD; //*抓图方式,按位设置.$1=报警输入触发，$2=移动侦测触发 $4=232触发，$8=485触发，$10=网络触发*/
    wUploadInterval: WORD; //*图片上传间隔(秒)[0,65535]*/
    struPicNameRule: NET_DVR_PICTURE_NAME; //* 图片命名规则 */
    bySaveToHD: BYTE; //*是否保存到硬盘*/
    res1: BYTE;
    wCatchInterval: WORD; //*抓图间隔(毫秒)[0,65535]*/
    res2: array[0..11] of BYTE;
    struRs232Cfg: NET_DVR_SERIAL_CATCHPIC_PARA;
    struRs485Cfg: NET_DVR_SERIAL_CATCHPIC_PARA;
    dwTriggerPicTimes: array[0..MAX_CHANNUM - 1] of DWORD; //* 每个通道一次触发拍照次数 */
    dwAlarmInPicChanTriggered: array[0..MAX_ALARMIN - 1] of DWORD; //*报警触发抓拍通道,按位设置，从第0位开始*/
  end;

  //typedef struct tagGetJpeg
  LPNET_DVR_GETJPEG = ^NET_DVR_GETJPEG;
  NET_DVR_GETJPEG = record
    dwReturn: DWORD; //*是否直接返回图片数据*/
    dwUploadFtp: DWORD; //*是否上传Ftp服务器*/
    dwSaveHd: DWORD; //*是否保存到设备硬盘*/
    sImageName: array[0..PATHNAME_LEN - 1] of char; //*自定义的生成图片文件名*/
    sOsdStr: char_16; //*需要叠加在图片上的OSD字符串*/
    wOsdLen: WORD; //*OSD字符串长度*/
  end;

  // HS设备辅助输出参数
  // typedef struct tagAUXOUT{
  LPNET_DVR_AUXOUTCFG = ^NET_DVR_AUXOUTCFG;
  NET_DVR_AUXOUTCFG = record
    dwSize: DWORD;
    dwAlarmOutChan: DWORD; //* 选择报警弹出大画面的输出通道: 0:主输出/1:辅1/2:辅2/3:辅3/4:辅4 */
    dwAlarmChanSwitchTime: DWORD; //* 报警通道切换时间：1:1秒 - 10:10秒 */
    dwAuxSwitchTime: array[0..MAX_AUXOUT - 1] of DWORD; //* 辅助输出切换时间: 0-不切换,1-5s,2-10s,3-20s,4-30s,5-60s,6-120s,7-300s */
    byAuxOrder: array[0..MAX_AUXOUT - 1, 0..MAX_WINDOW - 1] of BYTE; //* 辅助输出预览顺序, $ff表示相应的窗口不预览 */
  end;



// 初始化与释放
function NET_DVR_Init(): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_Init';
function NET_DVR_Cleanup(): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_Cleanup';
function NET_DVR_SetDVRMessage(nMessage: UINT; handle: HWND): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetDVRMessage';

type
  PfMessCallBack = ^TfMessCallBack;
  TfMessCallBack = function(lCommand: LONG; sDVRIP: Pchar; pBuf: Pchar; dwBufLen: DWORD): boolean of object;
function NET_DVR_SetDVRMessCallBack(fMessCallBack: PfMessCallBack): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetDVRMessCallBack';
//NET_DVR_API BOOL __stdcall NET_DVR_SetDVRMessCallBack(   BOOL (CALLBACK *fMessCallBack)   (LONG lCommand,char *sDVRIP,char *pBuf,DWORD dwBufLen));

type
  PfMessCallBack_Ex = ^TfMessCallBack_Ex;
  TfMessCallBack_Ex = function(lCommand: LONG; lUserID: LONG; pBuf: Pchar; dwBufLen: DWORD): BOOL of object;
function NET_DVR_SetDVRMessCallBack_EX(fMessCallBack_Ex: PfMessCallBack_Ex): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetDVRMessCallBack_EX';
//NET_DVR_API BOOL __stdcall NET_DVR_SetDVRMessCallBack_EX(BOOL (CALLBACK *fMessCallBack_EX)(LONG lCommand,LONG lUserID,char *pBuf,DWORD dwBufLen));

function NET_DVR_SetConnectTime(dwWaitTime, dwTryTimes: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetConnectTime';
function NET_DVR_GetSDKVersion(): DWORD; stdcall; external NET_DVR_API name 'NET_DVR_GetSDKVersion';

function NET_DVR_IsSupport(): int; stdcall; external NET_DVR_API name 'NET_DVR_IsSupport';
function NET_DVR_StartListen(sLocalIP: Pchar; wLocalPort: WORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StartListen';
function NET_DVR_StopListen(): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StopListen';
function NET_DVR_Login(sDVRIP: Pchar; wDVRPort: WORD; sUserName, sPassword: Pchar; lpDeviceInfo: LPNET_DVR_DEVICEINFO): LONG; stdcall; external NET_DVR_API name 'NET_DVR_Login';
function NET_DVR_Logout(lUserID: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_Logout';
function NET_DVR_Login_V30(sDVRIP: Pchar; wDVRPort: WORD; sUserName, sPassword: Pchar; lpDeviceInfo: LPNET_DVR_DEVICEINFO): LONG; stdcall; external NET_DVR_API name 'NET_DVR_Login_V30';
function NET_DVR_Logout_V30(lUserID: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_Logout_V30';

function NET_DVR_GetLastError(): DWORD; stdcall; external NET_DVR_API name 'NET_DVR_GetLastError';
function NET_DVR_SetShowMode(dwShowType: DWORD; colorKey: COLORREF): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetShowMode';
function NET_DVR_GetDVRIPByResolveSvr(sServerIP: Pchar; wServerPort: WORD; sDVRName: PByte; wDVRNameLen: WORD; sDVRSerialNumber: PByte; wDVRSerialLen: WORD; sGetIP: Pchar): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetDVRIPByResolveSvr';

//图像预览
function NET_DVR_RealPlay(lUserID: LONG; lpClientInfo: LPNET_DVR_CLIENTINFO): LONG; stdcall; external NET_DVR_API name 'NET_DVR_RealPlay';
function NET_DVR_StopRealPlay(lRealHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StopRealPlay';
type
  PfRealDataCallBack_V30 = ^TfRealDataCallBack_V30;
  TfRealDataCallBack_V30 = procedure(lRealHandle: LONG; dwDataType: DWORD; pBuffer: PBYTE; dwBufSize, dwUser: Pointer) of object; stdcall;
function NET_DVR_RealPlay_V30(lUserID: LONG; lpClientInfo: LPNET_DVR_CLIENTINFO; fRealDataCallBack_V30: PfRealDataCallBack_V30; pUser: Pointer; bBlocked: Boolean): LONG; stdcall; external NET_DVR_API name 'NET_DVR_RealPlay_V30';
type
  PfRealDataCallBack_V40 = ^TfRealDataCallBack_V40;
  TfRealDataCallBack_V40 = procedure(lRealHandle: LONG; dwDataType: DWORD; pBuffer: PBYTE; dwBufSize, dwUser: Pointer) of object; stdcall;
function NET_DVR_RealPlay_V40(lUserID: LONG; lpClientInfo: LPNET_DVR_CLIENTINFO_V40; fRealDataCallBack_V40: PfRealDataCallBack_V30; pUser: Pointer): LONG; stdcall; external NET_DVR_API name 'NET_DVR_RealPlay_V40';
function NET_DVR_SetStandardDataCallBack(lUserID:long;fRealDataCallBack_V30:PfRealDataCallBack_V40;puser:Pointer):Boolean; stdcall; external NET_DVR_API name 'NET_DVR_SetStandardDataCallBack';
//视频参数是索引值 1-10
function NET_DVR_ClientSetVideoEffect(lRealHandle: LONG; dwBrightValue, dwContrastValue, dwSaturationValue, dwHueValue: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_ClientSetVideoEffect';
function NET_DVR_ClientGetVideoEffect(lRealHandle: LONG; var pBrightValue, pContrastValue, pSaturationValue, pHueValue: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_ClientGetVideoEffect';
type
  PfDrawFun = ^TfDrawFun;
  TfDrawFun = procedure(lRealHandle: LONG; Dc: HDC; dwUser: DWORD) of object; stdcall;
function NET_DVR_RigisterDrawFun(lRealHandle: LONG; PfDrawFun: PfDrawFun; dwUser: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_RigisterDrawFun';
  // NET_DVR_API BOOL __stdcall NET_DVR_RigisterDrawFun(LONG lRealHandle,void (CALLBACK* fDrawFun)(LONG lRealHandle,HDC hDc,DWORD dwUser),DWORD dwUser);
function NET_DVR_SetPlayerBufNumber(lRealHandle: LONG; dwBufNum: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetPlayerBufNumber';
  // 丢B帧
function NET_DVR_ThrowBFrame(lRealHandle: LONG; dwNum: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_ThrowBFrame';
function NET_DVR_SetAudioMode(dwMode: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetAudioMode';
function NET_DVR_OpenSound(lRealHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_OpenSound';
function NET_DVR_CloseSound(): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_CloseSound';
function NET_DVR_OpenSoundShare(lRealHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_OpenSoundShare';
function NET_DVR_CloseSoundShare(lRealHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_CloseSoundShare';
function NET_DVR_Volume(lRealHandle: LONG; wVolume: WORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_Volume';

function NET_DVR_SaveRealData(lRealHandle: LONG; sFileName: Pchar): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SaveRealData';
function NET_DVR_StopSaveRealData(lRealHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StopSaveRealData';

type
  PfRealDataCallBack = ^TfRealDataCallBack;
  TfRealDataCallBack = procedure(lRealHandle: LONG; dwDataType: DWORD; pBuffer: PBYTE; dwBufSize: DWORD; pUser: Pointer) of object;

function NET_DVR_SetRealDataCallBack(lRealHandle: LONG; fRealDataCallBack: PfRealDataCallBack; dwUser: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetRealDataCallBack';
  // NET_DVR_API BOOL __stdcall NET_DVR_SetRealDataCallBack(LONG lRealHandle,void(CALLBACK *fRealDataCallBack) (LONG lRealHandle, DWORD dwDataType, BYTE *pBuffer,DWORD dwBufSize,DWORD dwUser),DWORD dwUser);
function NET_DVR_CapturePicture(lRealHandle: LONG; sPicFileName: Pchar): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_CapturePicture';
function NET_DVR_MakeKeyFrame(lUserID: LONG; lChannel: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_MakeKeyFrame';

  //云台控制
function NET_DVR_PTZControl(lRealHandle: LONG; dwPTZCommand, dwStop: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZControl';
function NET_DVR_PTZControl_Other(lUserID, lChannel: LONG; dwPTZCommand, dwStop: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZControl_Other';
function NET_DVR_TransPTZ(lRealHandle: LONG; pPTZCodeBuf: Pchar; dwBufSize: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_TransPTZ';
function NET_DVR_TransPTZ_Other(lUserID, lChannel: LONG; pPTZCodeBuf: Pchar; dwBufSize: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_TransPTZ_Other';
function NET_DVR_PTZPreset(lRealHandle: LONG; dwPTZPresetCmd, dwPresetIndex: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZPreset';
function NET_DVR_PTZPreset_Other(lUserID, lChannel: LONG; dwPTZPresetCmd, dwPresetIndex: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZPreset_Other';
function NET_DVR_TransPTZ_EX(lRealHandle: LONG; pPTZCodeBuf: Pchar; dwBufSize: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_TransPTZ_EX';
function NET_DVR_PTZControl_EX(lRealHandle: LONG; dwPTZCommand, dwStop: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZControl_EX';
function NET_DVR_PTZPreset_EX(lRealHandle: LONG; dwPTZPresetCmd, dwPresetIndex: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZPreset_EX';
function NET_DVR_PTZCruise(lRealHandle: LONG; dwPTZCruiseCmd: DWORD; byCruiseRoute, byCruisePoint: BYTE; wInput: WORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZCruise';
function NET_DVR_PTZCruise_Other(lUserID, lChannel: LONG; dwPTZCruiseCmd: DWORD; byCruiseRoute, byCruisePoint: BYTE; wInput: WORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZCruise_Other';
function NET_DVR_PTZCruise_EX(lRealHandle: LONG; dwPTZCruiseCmd: DWORD; byCruiseRoute, byCruisePoint: BYTE; wInput: WORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZCruise_EX';
function NET_DVR_PTZTrack(lRealHandle: LONG; dwPTZTrackCmd: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZTrack';
function NET_DVR_PTZTrack_Other(lUserID, lChannel: LONG; dwPTZTrackCmd: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZTrack_Other';
function NET_DVR_PTZTrack_EX(lRealHandle: LONG; dwPTZTrackCmd: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZTrack_EX';

//带速度的云台控制
function NET_DVR_PTZControlWithSpeed(lRealHandle: LONG; dwPTZCommand, dwStop, dwSpeed: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZControlWithSpeed';
function NET_DVR_PTZControlWithSpeed_Other(lUserID, lChannel: LONG; dwPTZCommand, dwStop, dwSpeed: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PTZControlWithSpeed_Other';

//文件回放
function NET_DVR_FindFile(lUserID, lChannel: LONG; dwFileType: DWORD; lpStartTime, lpStopTime: LPNET_DVR_TIME): LONG; stdcall; external NET_DVR_API name 'NET_DVR_FindFile';
function NET_DVR_FindNextFile(lFindHandle: LONG; lpFindData: LPNET_DVR_FIND_DATA): LONG; stdcall; external NET_DVR_API name 'NET_DVR_FindNextFile';
function NET_DVR_FindClose(lFindHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_FindClose';
function NET_DVR_PlayBackByName(lUserID: LONG; sPlayBackFileName: Pchar; Handle: HWND): LONG; stdcall; external NET_DVR_API name 'NET_DVR_PlayBackByName';
function NET_DVR_PlayBackByTime(lUserID, lChannel: LONG; lpStartTime, lpStopTime: LPNET_DVR_TIME; Handle: HWND): LONG; stdcall; external NET_DVR_API name 'NET_DVR_PlayBackByTime';
function NET_DVR_PlayBackControl(lPlayHandle: LONG; dwControlCode, dwInValue: DWORD; var lpOutValue: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PlayBackControl';
function NET_DVR_StopPlayBack(lPlayHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StopPlayBack';

//V3.0
function NET_DVR_FindFile_V30(lUserID: LONG; pFindCond: LPNET_DVR_FILECOND): LONG; stdcall; external NET_DVR_API name 'NET_DVR_FindFile_V30';
function NET_DVR_FindNextFile_V30(lFindHandle: LONG; lpFindData: LPNET_DVR_FIND_DATA): LONG; stdcall; external NET_DVR_API name 'NET_DVR_FindNextFile_V30';
function NET_DVR_FindClose_V30(lFindHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_FindClose_V30';

//V4.0
function NET_DVR_FindFile_V40(lUserID: LONG; pFindCond: LPNET_DVR_FILECOND): LONG; stdcall; external NET_DVR_API name 'NET_DVR_FindFile_V40';
function NET_DVR_PlayBackControl_V40(lPlayHandle: LONG; dwControlCode: DWORD; lpInBuffer: Pointer; dwInValue: DWORD; lpOutBuffer: Pointer;var lpOutValue: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PlayBackControl_V40';


type
  PfPlayDataCallBack = ^TfPlayDataCallBack;
  TfPlayDataCallBack = procedure(lPlayHandle: LONG; dwDataType: DWORD; pBuffer: PBYTE; dwBufSize, dwUser: DWORD) of object;
function NET_DVR_SetPlayDataCallBack(lPlayHandle: LONG; fPlayDataCallBack: PfPlayDataCallBack; dwUser: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetPlayDataCallBack';
  //?? NET_DVR_API BOOL __stdcall NET_DVR_SetPlayDataCallBack(LONG lPlayHandle,void(CALLBACK *fPlayDataCallBack) (LONG lPlayHandle, DWORD dwDataType, BYTE *pBuffer,DWORD dwBufSize,DWORD dwUser),DWORD dwUser);

function NET_DVR_PlayBackSaveData(lPlayHandle: LONG; sFileName: Pchar): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PlayBackSaveData';
function NET_DVR_StopPlayBackSave(lPlayHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StopPlayBackSave';

function NET_DVR_GetPlayBackOsdTime(lPlayHandle: LONG; lpOsdTime: LPNET_DVR_TIME): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetPlayBackOsdTime';
function NET_DVR_PlayBackCaptureFile(lPlayHandle: LONG; sFileName: Pchar): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_PlayBackCaptureFile';
function NET_DVR_GetFileByName(lUserID: LONG; sDVRFileName, sSavedFileName: Pchar): LONG; stdcall; external NET_DVR_API name 'NET_DVR_GetFileByName';
function NET_DVR_GetFileByTime(lUserID, lChannel: LONG; lpStartTime, lpStopTime: LPNET_DVR_TIME; sSavedFileName: Pchar): LONG; stdcall; external NET_DVR_API name 'NET_DVR_GetFileByTime';
function NET_DVR_StopGetFile(lFileHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StopGetFile';
function NET_DVR_GetDownloadPos(lFileHandle: LONG): int; stdcall; external NET_DVR_API name 'NET_DVR_GetDownloadPos';

//恢复默认值
function NET_DVR_RestoreConfig(lUserID: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_RestoreConfig';

//保存参数
function NET_DVR_SaveConfig(lUserID: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SaveConfig';
//重启
function NET_DVR_RebootDVR(lUserID: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_RebootDVR';
//关闭DVR
function NET_DVR_ShutDownDVR(lUserID: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_ShutDownDVR';
//升级
function NET_DVR_Upgrade(lUserID: LONG; sFileName: Pchar): LONG; stdcall; external NET_DVR_API name 'NET_DVR_Upgrade';
function NET_DVR_GetUpgradeState(lUpgradeHandle: LONG): int; stdcall; external NET_DVR_API name 'NET_DVR_GetUpgradeState';
function NET_DVR_CloseUpgradeHandle(lUpgradeHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_CloseUpgradeHandle';
//远程格式化硬盘
function NET_DVR_FormatDisk(lUserID, lDiskNumber: LONG): LONG; stdcall; external NET_DVR_API name 'NET_DVR_FormatDisk';
function NET_DVR_GetFormatProgress(lFormatHandle: LONG; var pCurrentFormatDisk, pCurrentDiskPos, pFormatStatic: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetFormatProgress';
function NET_DVR_CloseFormatHandle(lFormatHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_CloseFormatHandle';
//报警
function NET_DVR_SetupAlarmChan(lUserID: LONG): LONG; stdcall; external NET_DVR_API name 'NET_DVR_SetupAlarmChan';
function NET_DVR_CloseAlarmChan(lAlarmHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_CloseAlarmChan';
function NET_DVR_GetAlarmOut(lUserID: LONG; lpAlarmOutState: LPNET_DVR_ALARMOUTSTATUS): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetAlarmOut';
function NET_DVR_SetAlarmOut(lUserID, lAlarmOutPort, lAlarmOutStatic: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetAlarmOut';

type
//语音对讲
  PfVoiceDataCallBack = ^TfVoiceDataCallBack;
  TfVoiceDataCallBack = procedure(lVoiceComHandle: LONG; pRecvDataBuffer: Pchar; dwBufSize: DWORD; byAudioFlag: BYTE; dwUser: DWORD) of object;
function NET_DVR_StartVoiceCom(lUserID: LONG; fVoiceDataCallBack: PfVoiceDataCallBack; dwUser: DWORD): LONG; stdcall; external NET_DVR_API name 'NET_DVR_StartVoiceCom';
  // NET_DVR_API LONG __stdcall NET_DVR_StartVoiceCom(LONG lUserID, void(CALLBACK *fVoiceDataCallBack)(LONG lVoiceComHandle,char *pRecvDataBuffer,DWORD dwBufSize,BYTE byAudioFlag,DWORD dwUser), DWORD dwUser);
function NET_DVR_SetVoiceComClientVolume(lVoiceComHandle: LONG; wVolume: WORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetVoiceComClientVolume';
function NET_DVR_StopVoiceCom(lVoiceComHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StopVoiceCom';
//语音广播
function NET_DVR_ClientAudioStart(): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_ClientAudioStart';
function NET_DVR_ClientAudioStop(): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_ClientAudioStop';
function NET_DVR_AddDVR(lUserID: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_AddDVR';
function NET_DVR_DelDVR(lUserID: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_DelDVR';


  //语音转发
function NET_DVR_StartVoiceCom_MR(lUserID: LONG; fVoiceDataCallBack: PfVoiceDataCallBack; dwUser: DWORD): LONG; stdcall; external NET_DVR_API name 'NET_DVR_StartVoiceCom_MR';
  // NET_DVR_API LONG __stdcall NET_DVR_StartVoiceCom_MR(LONG lUserID, void(CALLBACK *fVoiceDataCallBack)(LONG lVoiceComHandle,char *pRecvDataBuffer,DWORD dwBufSize,BYTE byAudioFlag,DWORD dwUser), DWORD dwUser);
function NET_DVR_VoiceComSendData(lVoiceComHandle: LONG; pSendBuf: Pchar; dwBufSize: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_VoiceComSendData';

  ////////////////////////////////////////////////////////////
type
  //透明通道设置
  PfSerialDataCallBack = ^TfSerialDataCallBack;
  TfSerialDataCallBack = procedure(lSerialHandle: LONG; pRecvDataBuffer: Pchar; dwBufSize, dwUser: DWORD);
function NET_DVR_SerialStart(lUserID, lSerialPort: LONG; fSerialDataCallBack: PfSerialDataCallBack; dwUser: DWORD): LONG; stdcall; external NET_DVR_API name 'NET_DVR_SerialStart';
  // NET_DVR_API LONG __stdcall NET_DVR_SerialStart(LONG lUserID,LONG lSerialPort,void(CALLBACK *fSerialDataCallBack)(LONG lSerialHandle,char *pRecvDataBuffer,DWORD dwBufSize,DWORD dwUser),DWORD dwUser);
function NET_DVR_SerialSend(lSerialHandle, lChannel: LONG; pSendBuf: Pchar; dwBufSize: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SerialSend';
function NET_DVR_SerialStop(lSerialHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SerialStop';
function NET_DVR_SendTo232Port(lUserID: LONG; pSendBuf: Pchar; dwBufSize: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SendTo232Port';

//远程控制本地显示
function NET_DVR_ClickKey(lUserID, lKeyIndex: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_ClickKey';
//远程控制手动录像
function NET_DVR_StartDVRRecord(lUserID, lChannel, lRecordType: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StartDVRRecord';
function NET_DVR_StopDVRRecord(lUserID, lChannel: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_StopDVRRecord';

{  //解码卡
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';

NET_DVR_API BOOL __stdcall NET_DVR_InitDevice_Card(long *pDeviceTotalChan);
NET_DVR_API BOOL __stdcall NET_DVR_ReleaseDevice_Card();
NET_DVR_API BOOL __stdcall NET_DVR_InitDDraw_Card(HWND hParent,COLORREF colorKey);
NET_DVR_API BOOL __stdcall NET_DVR_ReleaseDDraw_Card();
NET_DVR_API LONG __stdcall NET_DVR_RealPlay_Card(LONG lUserID,LPNET_DVR_CARDINFO lpCardInfo,long lChannelNum);
NET_DVR_API BOOL __stdcall NET_DVR_ResetPara_Card(LONG lRealHandle,LPNET_DVR_DISPLAY_PARA lpDisplayPara);
NET_DVR_API BOOL __stdcall NET_DVR_RefreshSurface_Card();
NET_DVR_API BOOL __stdcall NET_DVR_ClearSurface_Card();
NET_DVR_API BOOL __stdcall NET_DVR_RestoreSurface_Card();
NET_DVR_API BOOL __stdcall NET_DVR_OpenSound_Card(LONG lRealHandle);

  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
NET_DVR_API BOOL __stdcall NET_DVR_CloseSound_Card(LONG lRealHandle);
NET_DVR_API BOOL __stdcall NET_DVR_SetVolume_Card(LONG lRealHandle,WORD wVolume);
NET_DVR_API BOOL __stdcall NET_DVR_AudioPreview_Card(LONG lRealHandle,BOOL bEnable);
NET_DVR_API BOOL __stdcall NET_DVR_CapturePicture_Card(LONG lRealHandle, char *sPicFileName);
NET_DVR_API BOOL __stdcall NET_DVR_SetDspErrMsg_Card(UINT nMessage,HWND hWnd);
NET_DVR_API BOOL __stdcall NET_DVR_ResetDSP_Card(long lChannelNum);
NET_DVR_API BOOL __stdcall NET_DVR_GetSerialNum_Card(long lChannelNum,DWORD *pDeviceSerialNo);
NET_DVR_API HANDLE __stdcall NET_DVR_GetChanHandle_Card(LONG lRealHandle);
}
//服务器状态

function NET_DVR_GetDVRWorkState(lUserID: LONG; lpWorkState: LPNET_DVR_WORKSTATE): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetDVRWorkState';
function NET_DVR_GetDVRWorkState_V30(lUserID: LONG; lpWorkState: LPNET_DVR_WORKSTATE_V30): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetDVRWorkState_V30';



//日志
function NET_DVR_FindDVRLog(lUserID, lSelectMode: LONG; dwMajorType, dwMinorType: DWORD; lpStartTime, lpStopTime: LPNET_DVR_TIME): LONG; stdcall; external NET_DVR_API name 'NET_DVR_FindDVRLog';
function NET_DVR_FindNextLog(lLogHandle: LONG; lpLogData: LPNET_DVR_LOG): LONG; stdcall; external NET_DVR_API name 'NET_DVR_FindNextLog';
function NET_DVR_FindLogClose(lLogHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_FindLogClose';

//参数设置
function NET_DVR_GetDVRConfig(lUserID: LONG; dwCommand: DWORD; lChannel: LONG; lpOutBuffer: pointer; dwOutBufferSize: DWORD; lpBytesReturned: LPDWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetDVRConfig';
function NET_DVR_SetDVRConfig(lUserID: LONG; dwCommand: DWORD; lChannel: LONG; lpInBuffer: pointer; dwInBufferSize: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetDVRConfig';

  //NET_DVR_API BOOL __stdcall NET_DVR_GetDVRConfig(LONG lUserID, DWORD dwCommand,LONG lChannel, LPVOID lpOutBuffer,DWORD dwOutBufferSize,LPDWORD lpBytesReturned);
  //NET_DVR_API BOOL __stdcall NET_DVR_SetDVRConfig(LONG lUserID, DWORD dwCommand,LONG lChannel, LPVOID lpInBuffer,DWORD dwInBufferSize);

{
//截止2004年8月5日,共113个接口

  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
NET_DVR_API BOOL __stdcall NET_DVR_ClientGetframeformat(LONG lUserID, LPNET_DVR_FRAMEFORMAT lpFrameFormat);
NET_DVR_API BOOL __stdcall NET_DVR_ClientSetframeformat(LONG lUserID, LPNET_DVR_FRAMEFORMAT lpFrameFormat);
NET_DVR_API LONG __stdcall NET_DVR_FindFileByCard(LONG lUserID,LONG lChannel,DWORD dwFileType, BOOL bNeedCardNum, BYTE *sCardNumber, LPNET_DVR_TIME lpStartTime, LPNET_DVR_TIME lpStopTime);
//截止2004年10月5日,共116个接口

//解码
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
NET_DVR_API void* __stdcall NET_DVR_InitG722Decoder(int nBitrate);
NET_DVR_API void __stdcall NET_DVR_ReleaseG722Decoder(void *pDecHandle);
NET_DVR_API BOOL __stdcall NET_DVR_DecodeG722Frame(void *pDecHandle, unsigned char* pInBuffer, unsigned char* pOutBuffer);
//编码
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
NET_DVR_API void* __stdcall NET_DVR_InitG722Encoder();
NET_DVR_API BOOL __stdcall NET_DVR_EncodeG722Frame(void *pEncodeHandle,unsigned char* pInBuffer, unsigned char* pOutBuffer);
NET_DVR_API void __stdcall NET_DVR_ReleaseG722Encoder(void *pEncodeHandle);
//参数设置
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
NET_DVR_API BOOL __stdcall NET_DVR_GetConfigFile(LONG lUserID, char *sFileName);
NET_DVR_API BOOL __stdcall NET_DVR_SetConfigFile(LONG lUserID, char *sFileName);
NET_DVR_API BOOL __stdcall NET_DVR_GetConfigFile_EX(LONG lUserID, char *sOutBuffer, DWORD dwOutSize);
NET_DVR_API BOOL __stdcall NET_DVR_SetConfigFile_EX(LONG lUserID, char *sInBuffer, DWORD dwInSize);
//6001D/F解码设备接口
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
  function AAAAA( ) : BOOL ; stdcall ; external NET_DVR_API name 'AAAA';
NET_DVR_API BOOL __stdcall NET_DVR_SetDecInfo(LONG lUserID, LONG lChannel, LPNET_DVR_DECCFG lpDecoderinfo);
NET_DVR_API BOOL __stdcall NET_DVR_GetDecInfo(LONG lUserID, LONG lChannel, LPNET_DVR_DECCFG lpDecoderinfo);
NET_DVR_API BOOL __stdcall NET_DVR_SetDecTransPort(LONG lUserID, LPNET_DVR_PORTCFG lpTransPort);
NET_DVR_API BOOL __stdcall NET_DVR_GetDecTransPort(LONG lUserID, LPNET_DVR_PORTCFG lpTransPort);
NET_DVR_API BOOL __stdcall NET_DVR_DecPlayBackCtrl(LONG lUserID, LONG lChannel, DWORD dwControlCode, DWORD dwInValue,DWORD *lpOutValue, LPNET_DVR_PLAYREMOTEFILE lpRemoteFileInfo);
NET_DVR_API BOOL __stdcall NET_DVR_StartDecSpecialCon(LONG lUserID, LONG lChannel, LPNET_DVR_DECCHANINFO lpDecChanInfo);
NET_DVR_API BOOL __stdcall NET_DVR_StopDecSpecialCon(LONG lUserID, LONG lChannel, LPNET_DVR_DECCHANINFO lpDecChanInfo);
NET_DVR_API BOOL __stdcall NET_DVR_DecCtrlDec(LONG lUserID, LONG lChannel, DWORD dwControlCode);
NET_DVR_API BOOL __stdcall NET_DVR_DecCtrlScreen(LONG lUserID, LONG lChannel, DWORD dwControl);
NET_DVR_API BOOL __stdcall NET_DVR_GetDecCurLinkStatus(LONG lUserID, LONG lChannel, LPNET_DVR_DECSTATUS lpDecStatus);
}
//JPEG抓图
function NET_DVR_CaptureJPEGPicture(lUserID, lChannel: LONG; lpJpegPara: LPNET_DVR_JPEGPARA; sPicFileName: Pchar): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_CaptureJPEGPicture';
//单帧数据捕获并保存成JPEG存放在指定的内存空间中。
function NET_DVR_CaptureJPEGPicture_NEW(lUserID, lChannel: LONG; lpJpegPara: LPNET_DVR_JPEGPARA; sJpegPicBuffer: Pchar; dwPicSize: DWORD; lpSizeReturned: PDWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_CaptureJPEGPicture_NEW';

//ATM PORT配置
function NET_DVR_SetATMPortCFG(lUserID: LONG; wATMPort: WORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetATMPortCFG';
function NET_DVR_GetATMPortCFG(lUserID: LONG; var lpOutATMPort: WORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetATMPortCFG';

//增加是否启用缩放接口
function NET_DVR_SetScaleCFG(lUserID: LONG; dwScale: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_SetScaleCFG';
function NET_DVR_GetScaleCFG(lUserID: LONG; var lpOutScale: DWORD): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_GetScaleCFG';
function NET_DVR_GetRealPlayerIndex(lRealHandle: LONG): Int; stdcall; external NET_DVR_API name 'NET_DVR_GetRealPlayerIndex';
function NET_DVR_GetPlayBackPlayerIndex(lPlayHandle: LONG): Int; stdcall; external NET_DVR_API name 'NET_DVR_GetPlayBackPlayerIndex';
{
//支持显卡
#if (WINVER > $0400)
//Note: These funtion must be builded under win2000 or above with Microsoft Platform sdk.
//	    You can download the sdk from "http://www.microsoft.com/msdownload/platformsdk/sdkupdate/";
NET_DVR_API BOOL __stdcall NET_DVR_InitDDrawDevice();
NET_DVR_API BOOL __stdcall NET_DVR_ReleaseDDrawDevice();
NET_DVR_API LONG __stdcall NET_DVR_GetDDrawDeviceTotalNums();
NET_DVR_API BOOL __stdcall NET_DVR_SetDDrawDevice(LONG lPlayPort, DWORD nDeviceNum);
#endif
}

function NET_DVR_RefreshPlay(lPlayHandle: LONG): BOOL; stdcall; external NET_DVR_API name 'NET_DVR_RefreshPlay';

implementation

end.
