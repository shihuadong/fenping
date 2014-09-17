unit DHNetSDKUnit;
interface

uses windows;


const

  DHNetSDK_API = 'dhnetsdk.dll';

//************************************************************************
// ** 接口枚举定义
// ***********************************************************************/
//通用云台控制命令
type

  UChar = byte; // unsigned char
  LONG = LongInt; //
  ULong = Dword; // unsigned long
  USHORT = word; // unsigned short
  Bool = Boolean;
  Int = Integer;
  Char_2 = array[0..1] of char;
  Char_4 = array[0..3] of char;
  Char_6 = array[0..5] of char;
  Char_8 = array[0..7] of char;
  Char_10 = array[0..9] of char;
  Char_12 = array[0..11] of char;
  Char_16 = array[0..15] of char;
  Char_17 = array[0..16] of char;
  Char_20 = array[0..19] of char;
  Char_32 = array[0..31] of char;
  Char_48 = array[0..47] of char;
  Char_128 = array[0..127] of char;

const
  PTZ_UP_CONTROL = 0; //上
  PTZ_DOWN_CONTROL = 1; //下
  PTZ_LEFT_CONTROL = 2; //左
  PTZ_RIGHT_CONTROL = 3; //右
  PTZ_ZOOM_ADD_CONTROL = 4; //变倍+
  PTZ_ZOOM_DEC_CONTROL = 5; //变倍-
  PTZ_FOCUS_ADD_CONTROL = 6; //调焦+
  PTZ_FOCUS_DEC_CONTROL = 7; //调焦-
  PTZ_APERTURE_ADD_CONTROL = 8; //光圈+
  PTZ_APERTURE_DEC_CONTROL = 9; //光圈-
  PTZ_POINT_MOVE_CONTROL = 10; //转至预置点
  PTZ_POINT_SET_CONTROL = 11; //设置
  PTZ_POINT_DEL_CONTROL = 12; //删除
  PTZ_POINT_LOOP_CONTROL = 13; //点间轮循
  PTZ_LAMP_CONTROL = 14; //灯光雨刷

//
//type
//  PTZ_ControlType = (
//    PTZ_UP_CONTROL = 0, //上
//    PTZ_DOWN_CONTROL, //下
//    PTZ_LEFT_CONTROL, //左
//    PTZ_RIGHT_CONTROL, //右
//    PTZ_ZOOM_ADD_CONTROL, //变倍+
//    PTZ_ZOOM_DEC_CONTROL, //变倍-
//    PTZ_FOCUS_ADD_CONTROL, //调焦+
//    PTZ_FOCUS_DEC_CONTROL, //调焦-
//    PTZ_APERTURE_ADD_CONTROL, //光圈+
//    PTZ_APERTURE_DEC_CONTROL, //光圈-
//    PTZ_POINT_MOVE_CONTROL, //转至预置点
//    PTZ_POINT_SET_CONTROL, //设置
//    PTZ_POINT_DEL_CONTROL, //删除
//    PTZ_POINT_LOOP_CONTROL, //点间轮循
//    PTZ_LAMP_CONTROL //灯光雨刷
//    );
type
 //云台控制扩展命令
  EXTPTZ_ControlType = (
    EXTPTZ_LEFTTOP = $20, //左上
    EXTPTZ_RIGHTTOP, //右上
    EXTPTZ_LEFTDOWN, //左下
    EXTPTZ_RIGHTDOWN, //右下
    EXTPTZ_ADDTOLOOP, //加入预置点到巡航	巡航线路	预置点值
    EXTPTZ_DELFROMLOOP, //删除巡航中预置点	巡航线路	预置点值
    EXTPTZ_CLOSELOOP, //清除巡航	巡航线路
    EXTPTZ_STARTPANCRUISE, //开始水平旋转
    EXTPTZ_STOPPANCRUISE, //停止水平旋转
    EXTPTZ_SETLEFTBORDER, //设置左边界
    EXTPTZ_RIGHTBORDER, //设置右边界
    EXTPTZ_STARTLINESCAN, //开始线扫
    EXTPTZ_CLOSELINESCAN, //停止线扫
    EXTPTZ_SETMODESTART, //设置模式开始	模式线路
    EXTPTZ_SETMODESTOP, //设置模式结束	模式线路
    EXTPTZ_RUNMODE, //运行模式	模式线路
    EXTPTZ_STOPMODE, //停止模式	模式线路
    EXTPTZ_DELETEMODE, //清除模式	模式线路
    EXTPTZ_REVERSECOMM, //翻转命令
    EXTPTZ_FASTGOTO, //快速定位	水平坐标	垂直坐标	变倍
    EXTPTZ_AUXIOPEN, //x34	辅助开关开	辅助点
    EXTPTZ_AUXICLOSE, //0x35	辅助开关关	辅助点
    EXTPTZ_OPENMENU = $36, //打开球机菜单
    EXTPTZ_CLOSEMENU, //关闭菜单
    EXTPTZ_MENUOK, //菜单确定
    EXTPTZ_MENUCANCEL, //菜单取消
    EXTPTZ_MENUUP, //菜单上
    EXTPTZ_MENUDOWN, //菜单下
    EXTPTZ_MENULEFT, //菜单左
    EXTPTZ_MENURIGHT, //菜单右
    EXTPTZ_TOTAL //最大命令值
    );

//IO控制命令
  IOTYPE = (
    ALARMINPUT = 1, //报警输入
    ALARMOUTPUT = 2 //报警输出
    );


const _EC = $80000000;

//*错误类型代号，用于GetLastError函数的返回*/
const NET_NOERROR = 0; //没有错误
const NET_ERROR = -1; //未知错误
const NET_SYSTEM_ERROR = _EC or 1; //Windows系统出错
const NET_NETWORK_ERROR = _EC or 2; //网络错误
const NET_DEV_VER_NOMATCH = _EC or 3; //设备协议不匹配
const NET_INVALID_HANDLE = _EC or 4; //句柄无效
const NET_OPEN_CHANNEL_ERROR = _EC or 5; //打开通道失败
const NET_CLOSE_CHANNEL_ERROR = _EC or 6; //关闭通道失败
const NET_ILLEGAL_PARAM = _EC or 7; //用户参数不合法
const NET_SDK_INIT_ERROR = _EC or 8; //SDK初始化出错
const NET_SDK_UNINIT_ERROR = _EC or 9; //SDK清理出错
const NET_RENDER_OPEN_ERROR = _EC or 10; //申请render资源出错
const NET_DEC_OPEN_ERROR = _EC or 11; //打开解码库出错
const NET_DEC_CLOSE_ERROR = _EC or 12; //关闭解码库出错
const NET_MULTIPLAY_NOCHANNEL = _EC or 13; //多画面预览中检测到通道数为0
const NET_TALK_INIT_ERROR = _EC or 14; //录音库初始化失败
const NET_TALK_NOT_INIT = _EC or 15; //录音库未经初始化
const NET_TALK_SENDDATA_ERROR = _EC or 16; //发送音频数据出错
const NET_REAL_ALREADY_SAVING = _EC or 17; //实时数据已经处于保存状态
const NET_NOT_SAVING = _EC or 18; //未保存实时数据
const NET_OPEN_FILE_ERROR = _EC or 19; //打开文件出错
const NET_PTZ_SET_TIMER_ERROR = _EC or 20; //启动云台控制定时器失败
const NET_RETURN_DATA_ERROR = _EC or 21; //对返回数据的校验出错
const NET_INSUFFICIENT_BUFFER = _EC or 22; //没有足够的缓存
const NET_NOT_SUPPORTED = _EC or 23; //当前SDK未支持该功能
const NET_NO_RECORD_FOUND = _EC or 24; //查询不到录象
const NET_NOT_AUTHORIZED = _EC or 25; //无操作权限
const NET_NOT_NOW = _EC or 26; //暂时无法执行
const NET_NO_TALK_CHANNEL = _EC or 27; //未发现对讲通道
const NET_NO_AUDIO = _EC or 28; //未发现音频
const NET_NO_INIT = _EC or 29; //CLientSDK未经初始化
const NET_DOWNLOAD_END = _EC or 30; //下载已结束


const NET_LOGIN_ERROR_PASSWORD = _EC or 100; //密码不正确
const NET_LOGIN_ERROR_USER = _EC or 101; //帐户不存在
const NET_LOGIN_ERROR_TIMEOUT = _EC or 102; //等待登录返回超时
const NET_LOGIN_ERROR_RELOGGIN = _EC or 103; //帐号已登录
const NET_LOGIN_ERROR_LOCKED = _EC or 104; //帐号已被锁定
const NET_LOGIN_ERROR_BLACKLIST = _EC or 105; //帐号已被列为黑名单
const NET_LOGIN_ERROR_BUSY = _EC or 106; //资源不足，系统忙
const NET_LOGIN_ERROR_CONNECT = _EC or 107; //连接主机失败"
const NET_LOGIN_ERROR_NETWORK = _EC or 108; //网络连接失败"

const NET_RENDER_SOUND_ON_ERROR = _EC or 120; //Render库打开音频出错
const NET_RENDER_SOUND_OFF_ERROR = _EC or 121; //Render库关闭音频出错
const NET_RENDER_SET_VOLUME_ERROR = _EC or 122; //Render库控制音量出错
const NET_RENDER_ADJUST_ERROR = _EC or 123; //Render库设置画面参数出错
const NET_RENDER_PAUSE_ERROR = _EC or 124; //Render库暂停播放出错
const NET_RENDER_SNAP_ERROR = _EC or 125; //Render库抓图出错
const NET_RENDER_STEP_ERROR = _EC or 126; //Render库步进出错
const NET_RENDER_FRAMERATE_ERROR = _EC or 127; //Render库设置帧率出错

const NET_CONFIG_DEVBUSY = _EC or 999; //暂时无法设置
const NET_CONFIG_DATAILLEGAL = _EC or 1000; //配置数据不合法

//回调函数类型
const COMM_ALARM = $1100; //报警信息

//************************************************************************
// ** 设备型号(DVR类型 );
// ***********************************************************************/

const DVR_NONREALTIME_MACE = 1; //*!< 非实时MACE */
const DVR_NONREALTIME = 2; //!< 非实时 */
const NVS_MPEG1 = 3; //!< 网络视频服务器 */
const DVR_MPEG1_2 = 4; //!< MPEG1二路录像机 */
const DVR_MPEG1_8 = 5; //!< MPEG1八路录像机 */
const DVR_8 = 6; //!< 一代八路录像机 */
const DVR_16 = 7; //!< 一代十六路录像机 */
const DVR_SX2 = 8; //!< 二代视新十六路录像机 */
const DVR_ST2 = 9; //!< 二代视通录像机 */
const DVR_SH2 = 10; //!< 二代视豪录像机 */
const DVR_GBE = 11; //!< 二代视通二代增强型录像机 */
const DVR_STD_NEW = 12; //!< 新标准配置协议 */


//************************************************************************
// ** 常量定义
// ***********************************************************************/
const SERIALNO_LEN = 48;
const MAX_DISKNUM = 32;
const MAX_LINK = 6;
const MAX_CHANNUM = 16;
const MAX_ALARMIN = 128;
const MAX_ALARMOUT = 64;


//************************************************************************
// ** 设备信息
// ***********************************************************************/
type

  LPNET_DEVICEINFO = ^NET_DEVICEINFO;
  NET_DEVICEINFO = record
    sSerialNumber: array[0..SERIALNO_LEN - 1] of BYTE; //序列号
    byAlarmInPortNum: BYTE; //DVR报警输入个数
    byAlarmOutPortNum: BYTE; //DVR报警输出个数
    byDiskNum: BYTE; //DVR 硬盘个数
    byDVRType: BYTE; //DVR类型,
    byChanNum: BYTE; //DVR 通道个数
  end;

// ************************************************************************
// ** 主动上传信息
// ***********************************************************************/

  LPNET_CLIENT_STATE = ^NET_CLIENT_STATE;
  NET_CLIENT_STATE = record
    channelcount: integer;
    alarminputcount: integer;
    diskerror: array[0..MAX_DISKNUM - 1] of byte;
    //?? unsigned char *record;          //size:channelcount
    //?? unsigned char *alarm;           //size:alarminputcount
    //?? unsigned char *motiondection;   //size:channelcount
    //?? unsigned char *videolost;       //size:channelcount
  end;

//************************************************************************
// ** 查询设备工作状态通道信息:现在设备支持
// ***********************************************************************/
  LPNET_DEV_CHANNELSTATE = ^NET_DEV_CHANNELSTATE;
  NET_DEV_CHANNELSTATE = record
    byRecordStatic: BYTE; //通道是否在录像,0-不录像,1-录像
    bySignalStatic: BYTE; //连接的信号状态,0-正常,1-信号丢失
    byHardwareStatic: BYTE; //通道硬件状态,0-正常,1-异常,例如DSP死掉
    reserve: char;
    dwBitRate: DWORD; //实际码率
    dwLinkNum: DWORD; //客户端连接的个数
    dwClientIP: array[0..MAX_LINK - 1] of DWORD; //客户端的IP地址
  end;

//************************************************************************
// ** 查询设备工作状态硬盘信息:现在设备不支持
// ***********************************************************************/
  LPNET_DEV_DISKSTATE = ^NET_DEV_DISKSTATE;
  NET_DEV_DISKSTATE = record
    dwVolume: DWORD; //硬盘的容量
    dwFreeSpace: DWORD; //硬盘的剩余空间
    dwStatus: DWORD; //硬盘的状态,休眠,活动,不正常等
  end;

//************************************************************************
// ** 查询设备工作状态
// ***********************************************************************/
  LPNET_DEV_WORKSTATE = ^NET_DEV_WORKSTATE;
  NET_DEV_WORKSTATE = record
    dwDeviceStatic: DWORD; //设备的状态,0x00 正常,0x01 CPU占用过高,0x02 硬件错误
    stHardDiskStatic: array[0..MAX_DISKNUM - 1] of NET_DEV_DISKSTATE;
    stChanStatic: array[0..MAX_CHANNUM - 1] of NET_DEV_CHANNELSTATE; //通道的状态
    byAlarmInStatic: array[0..MAX_ALARMIN - 1] of BYTE; //报警端口的状态,0-没有报警,1-有报警
    byAlarmOutStatic: array[0..MAX_ALARMOUT - 1] of BYTE; //报警输出端口的状态,0-没有输出,1-有报警输出
    dwLocalDisplay: DWORD; //本地显示状态,0-正常,1-不正常
  end;

//************************************************************************
// ** 时间
// ***********************************************************************/
  LPNET_TIME = ^NET_TIME;
  NET_TIME = record
    dwYear: DWORD; //年
    dwMonth: DWORD; //月
    dwDay: DWORD; //日
    dwHour: DWORD; //时
    dwMinute: DWORD; //分
    dwSecond: DWORD; //秒
  end;

//************************************************************************
// ** 录像文件信息
// ***********************************************************************/
  LPNET_RECORDFILE_INFO = ^NET_RECORDFILE_INFO;
  NET_RECORDFILE_INFO = record
    ch: DWord; //通道号
    filename: char_128; //文件名
    size: Dword; //文件长度
    starttime: NET_TIME; //开始时间
    endtime: NET_TIME; //结束时间
    driveno: dword; //磁盘号
    startcluster: dword; //起始簇号
    nRecordFileType: Byte; // 0 普通录象  1 报警录象  2 移动检测 3 卡号录象 4 图片
    bImportantRecID: Byte; //0 普通录象 1 重要录象
    bHint: BYTE; //文件定位索引
    bReserved: BYTE; //保留
  end;



//************************************************************************
// ** 协议信息
// ***********************************************************************/
  LPPROTOCOL_INFO = ^PROTOCOL_INFO;
  PROTOCOL_INFO = record
    protocolname: char_12; //协议名
    baudbase: dword; //波特率
    databits: byte; //数据位
    stopbits: byte; //停止位
    parity: byte; //校验位
    reserve: byte;
  end;

//************************************************************************
// ** 报警IO控制
//***********************************************************************/

  LPALARM_CONTROL = ^ALARM_CONTROL;
  ALARM_CONTROL = record
    index: UShort; //端口序号
    state: UShort; //端口状态
  end;

//************************************************************************
// ** 服务器断开回调原形
// ***********************************************************************/
  PfDisConnect = ^TfDisConnect;
  TfDisConnect = procedure(lLoginID: LONG; pchDVRIP: Pchar; nDVRPort: LONG; dwUser: DWORD) of object; stdcall;
//************************************************************************
// ** 实时预览回调原形
// ***********************************************************************/
  PfRealDataCallBack = ^TfRealDataCallBack;
  TfRealDataCallBack = procedure(lRealHandle: LONG; dwDataType: DWORD; pBuffer: PBYTE; dwBufSize, dwUser: DWORD) of object; stdcall;
//************************************************************************
// ** 原始数据回调原形
// ***********************************************************************/
  PfDataCallBack = ^TfDataCallBack;
  TfDataCallBack = procedure(lRealHandle: LONG; dwDataType: DWORD; pBuffer: PBYTE; dwBufSize, dwUser: DWORD) of object; stdcall;

//************************************************************************
// ** 回调原形
// ***********************************************************************/
  PfMessCallBack = ^TfMessCallBack;
  TfMessCallBack = procedure(lCommand: LONG; lLoginID: LONG; pBuf: Pchar;
    dwBufLen: DWORD; pchDVRIP: Pchar; nDVRPort: LONG; dwUser: DWORD) of object; stdcall;
//************************************************************************
// ** 屏幕叠加回调原形
// ***********************************************************************/
  PfDrawCallBack = ^TfDrawCallBack;
  TfDrawCallBack = procedure(lLoginID, lPlayHandle: LONG; DC: HDC; dwUser: DWORD) of object; stdcall;

//************************************************************************
// ** 实时预览回调原形-扩展
// ***********************************************************************/
  PfRealDataCallBackEx = ^TfRealDataCallBackEx;
  TfRealDataCallBackEx = procedure(lRealHandle: LONG; dwDataType: DWORD; pBuffer: PBYTE; dwBufSize: DWORD; param: LONG; dwUser: DWORD) of object; stdcall;



type
  EM_REALPLAY_DISCONNECT_EVENT_TYPE=(
  DISCONNECT_EVENT_REAVE =0,     //表示高级用户抢占低级用户资源
  DISCONNECT_EVENT_NETFORBID ,//禁止入网
 DISCONNECT_EVENT_SUBCONNECT //动态子链接断开
 );

 type
 
  PfRealPlayDisConnect = ^TfRealPlayDisConnect;
  TfRealPlayDisConnect = procedure(lOperateHandle: LONG; dwEventType: EM_REALPLAY_DISCONNECT_EVENT_TYPE; param : Pointer; dwUser: DWORD) of object; stdcall;


//  typedef void (CALLBACK *fRealPlayDisConnect)(
//  LLONG  lOperateHandle,
//  EM_REALPLAY_DISCONNECT_EVENT_TYPE  dwEventType,
//  void*   param,
//  LDWORD dwUser
//);


//************************************************************************
// ** 回放录像进度回调原形
// ***********************************************************************/

  PfDownLoadPosCallBack = ^TfDownLoadPosCallBack;
  TfDownLoadPosCallBack = procedure(lPlayHandle: LONG; dwTotalSize, dwDownLoadSize, dwUser: DWORD) of object; stdcall;

//************************************************************************
// ** 通过时间下载录像进度回调原形
// 现在按时间下载没有使用这个回调函数，使用的是回放录像进度回调原形. //by linjianyan
// ***********************************************************************/
  PfTimeDownLoadPosCallBack = ^TfTimeDownLoadPosCallBack;
  TfTimeDownLoadPosCallBack = procedure(lPlayHandle: LONG; dwTotalSize, dwDownLoadSize: DWORD; index: int; recordfileinfo: NET_RECORDFILE_INFO; dwUser: DWORD) of object; stdcall;

//************************************************************************
// ** 查询设备日志数据回调原形
// ***********************************************************************/
  PfLogDataCallBack = ^TfLogDataCallBack;
  TfLogDataCallBack = procedure(lLoginID: LONG; pBuffer: Pchar; dwBufSize, nTotalSize: DWORD; bEnd: bool; dwUser: DWORD) of object; stdcall;

///************************************************************************
// ** 透明串口回调原形
// ***********************************************************************/
  PfTransComCallBack = ^TfTransComCallBack;
  TfTransComCallBack = procedure(lLoginID, lTransComChannel: LONG; pBuffer: Pchar; dwBufSize, dwUser: DWORD) of object; stdcall;

//************************************************************************
// ** 升级设备程序回调原形
// ***********************************************************************/
  PfUpgradeCallBack = ^TfUpgradeCallBack;
  TfUpgradeCallBack = procedure(lLoginID: LONG; lUpgradechannel: LONG; nTotalSize, nSendSize: int; dwUser: DWORD) of object; stdcall;


//************************************************************************
// ** SDK初始化
// ***********************************************************************/
function CLIENT_Init(cbDisConnect: PfDisConnect; dwUser: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_Init';

//************************************************************************
// ** SDK退出清理
// ***********************************************************************/
procedure CLIENT_Cleanup(); stdcall; external DHNetSDK_API name 'CLIENT_Cleanup';

//************************************************************************/
//* 返回函数执行失败代码                                                                  */
//************************************************************************/
function CLIENT_GetLastError(): DWORD; stdcall; external DHNetSDK_API name 'CLIENT_GetLastError';

//************************************************************************
// ** 设置连接服务器超时时间和尝试次数
// ***********************************************************************/
procedure CLIENT_SetConnectTime(nWaitTime, nTryTimes: int); stdcall; external DHNetSDK_API name 'CLIENT_SetConnectTime';


//************************************************************************
// ** 获取SDK的版本信息
// ***********************************************************************/
function CLIENT_GetSDKVersion(): DWORD; stdcall; external DHNetSDK_API name 'CLIENT_GetSDKVersion';

//************************************************************************
// ** 向设备注册
// ***********************************************************************/
function CLIENT_Login(pchDVRIP: Pchar; wDVRPort: WORD; pchUserName, pchPassword: Pchar; lpDeviceInfo: LPNET_DEVICEINFO; var error: integer): LONG; stdcall; external DHNetSDK_API name 'CLIENT_Login';

function CLIENT_LoginEx(pchDVRIP: Pchar; wDVRPort: WORD; pchUserName, pchPassword: Pchar; nSpecCap: int; pCapParam: Pointer; lpDeviceInfo: LPNET_DEVICEINFO; var error: integer): LONG; stdcall; external DHNetSDK_API name 'CLIENT_LoginEx';

//************************************************************************
// ** 向设备注销
// ***********************************************************************/
function CLIENT_Logout(lLoginID: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_Logout';

//************************************************************************
// **
// ***********************************************************************/
procedure CLIENT_SetDVRMessCallBack(cbMessage: PfMessCallBack; dwUser: DWORD); stdcall; external DHNetSDK_API name 'CLIENT_SetDVRMessCallBack';


//************************************************************************
// ** 开始帧听设备
// ***********************************************************************/
function CLIENT_StartListen(lLoginID: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StartListen';


//************************************************************************
// ** 停止帧听设备
// ***********************************************************************/
function CLIENT_StopListen(lLoginID: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StopListen';


//************************************************************************
// ** 设置屏幕叠加回调
// ***********************************************************************/
procedure CLIENT_RigisterDrawFun(cbDraw: PfDrawCallBack; dwUser: DWORD); stdcall; external DHNetSDK_API name 'CLIENT_RigisterDrawFun';


//************************************************************************
// ** 开始实时预览
// ***********************************************************************/
function CLIENT_RealPlay(lLoginID: LONG; nChannelID: int; hWnd: HWND): LONG; stdcall; external DHNetSDK_API name 'CLIENT_RealPlay';



//************************************************************************
// ** 开始实时预览_扩展
// ***********************************************************************/
//实时预览扩展接口增加的参数：预览类型
type

  RealPlayType = (
    DH_RType_RealPlay  = 0, //实时预览
    DH_RType_Multiplay, //多画面预览
    DH_RType_RealPlay_0,//实时监视-主码流，等同于DH_RType_Realplay
    DH_RType_RealPlay_1,//实时监视-从码流1
    DH_RType_RealPlay_2,// 实时监视-从码流2
    DH_RType_RealPlay_3,// 实时监视-从码流3
    DH_RType_Multiplay_1,// 多画面预览－1画面
    DH_RType_Multiplay_4,// 多画面预览－4画面
    DH_RType_Multiplay_8,// 多画面预览－8画面
    DH_RType_Multiplay_9,// 多画面预览－9画面
    DH_RType_Multiplay_16,// 多画面预览－16画面
    DH_RType_Multiplay_6,// 多画面预览－6画面
    DH_RType_Multiplay_12// 多画面预览－12画面

    );




function CLIENT_RealPlayEx(lLoginID: LONG; nChannelID: int; hWnd: HWND; rType: RealPlayType = DH_RType_RealPlay): LONG; stdcall; external DHNetSDK_API name 'CLIENT_RealPlayEx';

function CLIENT_StartRealPlay(lLoginID: LONG; nChannelID: int; hWnd: HWND; rType: RealPlayType;fRealDataCallBackEx :PfRealDataCallBackEx; fRealPlayDisConnect :PfRealPlayDisConnect;dwUser:PDWORD; dwWaitTime:DWORD=1000  ): LONG; stdcall; external DHNetSDK_API name 'CLIENT_StartRealPlay';


///***********************************************************************
// ** 停止实时预览
// ***********************************************************************/
function CLIENT_StopRealPlay(lRealHandle: LONG): bool; stdcall; external DHNetSDK_API name 'CLIENT_StopRealPlay';

///***********************************************************************
// ** 停止实时预览_扩展
// ***********************************************************************/
function CLIENT_StopRealPlayEx(lRealHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StopRealPlayEx';

//***********************************************************************
/// 保存数据为文件
///*********************************************************************/
function CLIENT_SaveRealData(lRealHandle: LONG; const pchFileName: Pchar): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SaveRealData';

//***********************************************************************
/// 结束保存数据为文件
///*********************************************************************/
function CLIENT_StopSaveRealData(lRealHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StopSaveRealData';


//***********************************************************************
/// 设置图像属性
///*********************************************************************/
function CLIENT_ClientSetVideoEffect(lPlayHandle: LONG; nBrightness, nContrast, nHue, nSaturation: byte): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_ClientSetVideoEffect';


//***********************************************************************
/// 获取图像属性
///*********************************************************************/
function CLIENT_ClientGetVideoEffect(lPlayHandle: LONG; nBrightness, nContrast, nHue, nSaturation: Pbyte): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_ClientGetVideoEffect';

//***********************************************************************
// 打开声音
//*********************************************************************/
function CLIENT_OpenSound(lPlayHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_OpenSound';
//***********************************************************************
/// 关闭声音
///*********************************************************************/
function CLIENT_CloseSound(): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_CloseSound';

//***********************************************************************
/// 设置音量
///*********************************************************************/
function CLIENT_SetVolume(lPlayHandle: LONG; nVolume: int): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetVolume';

type

  LPtagVideoFrameParam = ^tagVideoFrameParam;
  tagVideoFrameParam = record
    encode: BYTE; //编码类型
    frametype: BYTE; //I = 0, P = 1, B = 2...
    format: BYTE; //PAL - 0, NTSC - 1
    size: BYTE; //CIF - 0, HD1 - 1, 2CIF - 2, D1 - 3, VGA - 4, QCIF - 5, QVGA - 6
    fourcc: DWORD; //如果是H264编码则总为0，MPEG4这里总是填写FOURCC('X','V','I','D');
    reserved: DWORD; //保留
    struTime: NET_TIME; //时间信息
  end;

  LPtagCBPCMDataParam = ^tagCBPCMDataParam;
  tagCBPCMDataParam = record
    channels: BYTE; // 声道数
    samples: BYTE; // 采样 0 - 8000, 1 - 11025, 2 - 16000, 3 - 22050, 4 - 32000, 5 - 44100, 6 - 48000
    depth: BYTE; // 采样深度 取值8或者16等。直接表示
    param1: BYTE; // 0 - 指示无符号，1-指示有符号
    reserved: DWORD; // 保留
  end;
//***********************************************************************
/// 设置实时预览回调
///*********************************************************************/
function CLIENT_SetRealDataCallBack(lRealHandle: LONG; cbRealData: PfRealDataCallBack; dwUser: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetRealDataCallBack';



//***********************************************************************
/// 设置实时预览回调-扩展
///*********************************************************************/
function CLIENT_SetRealDataCallBackEx(lRealHandle: LONG; cbRealData: PfRealDataCallBackEx; dwUser, dwFlag: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetRealDataCallBackEx';
//***********************************************************************
/// 抓图
///*********************************************************************/
function CLIENT_CapturePicture(hPlayHandle: LONG; const pchPicFileName: Pchar): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_CapturePicture';


//***********************************************************************
/// 通过时间查询录像文件
///*********************************************************************/
function CLIENT_QueryRecordFile(lLoginID: LONG; nChannelId, nRecordFileType: int; tmStart, tmEnd: LPNET_TIME; pchCardid: Pchar; nriFileinfo: LPNET_RECORDFILE_INFO; maxlen: int; var filecount; waittime: int = 1500; bTime: bool = false): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryRecordFile';


//***********************************************************************
/// 回放录像文件
///*********************************************************************/
function CLIENT_PlayBackByRecordFile(lLoginID: LONG; lpRecordFile: LPNET_RECORDFILE_INFO; hWnd: HWND; cbDownLoadPos: PfDownLoadPosCallBack; dwUserData: DWORD): Long; stdcall; external DHNetSDK_API name 'CLIENT_PlayBackByRecordFile';

//***********************************************************************
/// 回放录像文件扩展_增加了数据回调参数
///*********************************************************************/
function CLIENT_PlayBackByRecordFileEx(lLoginID: LONG; lpRecordFile: LPNET_RECORDFILE_INFO; hWnd: HWND; cbDownLoadPos: PfDownLoadPosCallBack; dwPosUser: DWORD; fDownLoadDataCallBack: PfDataCallBack; dwDataUser: DWORD): Long; stdcall; external DHNetSDK_API name 'CLIENT_PlayBackByRecordFileEx';

//***********************************************************************
/// 暂停录像回放
///*********************************************************************/
function CLIENT_PausePlayBack(lPlayHandle: LONG; bPause: BOOL): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_PausePlayBack';


//***********************************************************************
/// 定位录像回放起始点
///*********************************************************************/
function CLIENT_SeekPlayBack(lPlayHandle: LONG; offsettime, offsetbyte: uint): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SeekPlayBack';


//***********************************************************************
/// 停止录像回放
///*********************************************************************/
function CLIENT_StopPlayBack(lPlayHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StopPlayBack';


function CLIENT_NormalPlayBack(lPlayHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_NormalPlayBack';

//***********************************************************************
/// 步进录像回放
///*********************************************************************/
function CLIENT_StepPlayBack(lPlayHandle: LONG; bStop: bool): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StepPlayBack';


//***********************************************************************
/// 快进录像回放
///*********************************************************************/
function CLIENT_FastPlayBack(lPlayHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_FastPlayBack';


//***********************************************************************
/// 慢进录像回放
///*********************************************************************/
function CLIENT_SlowPlayBack(lPlayHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SlowPlayBack';


//***********************************************************************
/// 设置回放帧速
///*********************************************************************/
function CLIENT_SetFramePlayBack(lPlayHandle: LONG; framerate: int): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetFramePlayBack';

//***********************************************************************
/// 获取回放帧速
///*********************************************************************/
function CLIENT_GetFramePlayBack(lPlayHandle: LONG; var fileframerate, playframerate: int): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_GetFramePlayBack';


//***********************************************************************
/// 获取回放OSD时间
///*********************************************************************/
function CLIENT_GetPlayBackOsdTime(lPlayHandle: LONG; lpOsdTime, lpStartTime, lpEndTime: LPNET_TIME): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_GetPlayBackOsdTime';


//***********************************************************************
/// 下载录像文件
///*********************************************************************/
function CLIENT_DownloadByRecordFile(lLoginID: LONG; lpRecordFile: LPNET_RECORDFILE_INFO; sSavedFileName: Pchar; cbDownLoadPos: PfDownLoadPosCallBack; dwUserData: DWORD): Long; stdcall; external DHNetSDK_API name 'CLIENT_DownloadByRecordFile';


//***********************************************************************
/// 通过时间下载录像
///*********************************************************************/
function CLIENT_DownloadByTime(lLoginID: LONG; nChannelId, nRecordFileType: int; tmStart, tmEnd: LPNET_TIME; sSavedFileName: Pchar; cbTimeDownLoadPos: PfTimeDownLoadPosCallBack; dwUserData: DWORD): Long; stdcall; external DHNetSDK_API name 'CLIENT_DownloadByTime';


//***********************************************************************
/// 停止录像下载
///*********************************************************************/
function CLIENT_StopDownload(lFileHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StopDownload';


//***********************************************************************
/// 查询录像下载进度
///*********************************************************************/
function CLIENT_GetDownloadPos(lFileHandle: LONG; var nTotalSize, nDownLoadSize: int): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_GetDownloadPos';


//***********************************************************************
/// 多画面实时预览
///*********************************************************************/
function CLIENT_MultiPlay(lLoginID: LONG; hWnd: HWND): Long; stdcall; external DHNetSDK_API name 'CLIENT_MultiPlay';


//***********************************************************************
/// 停止多画面实时预览
///*********************************************************************/
function CLIENT_StopMultiPlay(lMultiHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StopMultiPlay';


//***********************************************************************
/// 查询系统服务器配置
/// 普通设置
/// COM口设置
/// 网络设置
/// 定时设置
/// 图像设置
/// PTZ设置
/// 动态检测设置
/// 报警设置
///*********************************************************************/
function CLIENT_QueryConfig(lLoginID: LONG; nConfigType: int; pConfigbuf: Pchar; maxlen: int; var nConfigbuflen: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryConfig';


//***********************************************************************
/// 设置系统服务器配置
/// 普通设置
/// COM口设置
/// 网络设置
/// 定时设置
/// 图像设置
/// PTZ设置
/// 动态检测设置
/// 报警设置
///*********************************************************************/
function CLIENT_SetupConfig(lLoginID: LONG; nConfigType: int; pConfigbuf: Pchar; nConfigbuflen: Int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetupConfig';


//***********************************************************************
/// 查询设备通道名称
///*********************************************************************/
function CLIENT_QueryChannelName(lLoginID: LONG; pChannelName: Pchar; maxlen: int; var nChannelCount: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryChannelName';

//***********************************************************************
/// 设置设备通道名称
///*********************************************************************/
function CLIENT_SetupChannelName(lLoginID: LONG; pbuf: Pchar; nbuflen: int): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetupChannelName';


//***********************************************************************
/// 通用云台控制
///*********************************************************************/
function CLIENT_PTZControl(lLoginID: LONG; nChannelID: int; dwPTZCommand, dwStep: DWORD; dwStop: BOOL): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_PTZControl';


//***********************************************************************
/// 大华云台控制
///*********************************************************************/
function CLIENT_DHPTZControl(lLoginID: LONG; nChannelID: int; dwPTZCommand: DWORD;
  param1, param2, param3: byte; dwStop: BOOL): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_DHPTZControl';


//***********************************************************************
/// 异步查询设备日志
///*********************************************************************/
function CLIENT_QueryLogCallback(lLoginID: LONG; cbLogData: PfLogDataCallBack; dwUser: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryLogCallback';


//***********************************************************************
/// 同步查询设备日志
///*********************************************************************/
function CLIENT_QueryLog(lLoginID: LONG; pLogBuffer: Pchar; maxlen: int; var nLogBufferlen: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryLog';


//***********************************************************************
/// 创建透明串口通道
///*********************************************************************/

function CLIENT_CreateTransComChannel(lLoginID: LONG; TransComType: int; baudrate, databits, stopbits, parity: uint;
  cbTransCom: PfTransComCallBack; dwUser: DWORD): LONG; stdcall; external DHNetSDK_API name 'CLIENT_CreateTransComChannel';

//***********************************************************************
/// 透明串口发送数据
///*********************************************************************/
function CLIENT_SendTransComData(lTransComChannel: LONG; pBuffer: Pchar; dwBufSize: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SendTransComData';

//***********************************************************************
/// 释放通明串口通道
///*********************************************************************/
function CLIENT_DestroyTransComChannel(lTransComChannel: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_DestroyTransComChannel';


//***********************************************************************
///
///*********************************************************************/
function CLIENT_Reset(lLoginID: LONG; bReset: BOOL): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_Reset';

//***********************************************************************
/// 开始升级设备程序
///*********************************************************************/
function CLIENT_StartUpgrade(lLoginID: LONG; pchFileName: Pchar; cbUpgrade: PfUpgradeCallBack; dwUser: DWORD): LONG; stdcall; external DHNetSDK_API name 'CLIENT_StartUpgrade';


//***********************************************************************
/// 发送数据
///*********************************************************************/
function CLIENT_SendUpgrade(lUpgradeID: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SendUpgrade';


//***********************************************************************
/// 结束升级设备程序
///*********************************************************************/
function CLIENT_StopUpgrade(lUpgradeID: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StopUpgrade';


//***********************************************************************
/// 查道通道录像状态
///*********************************************************************/
function CLIENT_QueryRecordState(lLoginID: LONG; pRSBuffer: Pchar; maxlen: int; var nRSBufferlen: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryRecordState';


//***********************************************************************
/// 设置通道录像状态
///*********************************************************************/
function CLIENT_SetupRecordState(lLoginID: LONG; pRSBuffer: Pchar; nRSBufferlen: int): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetupRecordState';


//***********************************************************************
/// 查询设备当前时间
///*********************************************************************/
function CLIENT_QueryDeviceTime(lLoginID: LONG; pDeviceTime: LPNET_TIME; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryDeviceTime';


//***********************************************************************
/// 设置设备当前时间
///*********************************************************************/
function CLIENT_SetupDeviceTime(lLoginID: LONG; pDeviceTime: LPNET_TIME): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetupDeviceTime';


//***********************************************************************
/// 查询串口协议
///*********************************************************************/
function CLIENT_QueryComProtocol(lLoginID: LONG; nProtocolType: int; pProtocolBuffer: Pchar; maxlen: int; var nProtocollen: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryComProtocol';


//***********************************************************************
/// 查询系统信息
///*********************************************************************/
function CLIENT_QuerySystemInfo(lLoginID: LONG; nSystemType: int; pSysInfoBuffer: Pchar; maxlen: int; var nSysInfolen: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QuerySystemInfo';


//***********************************************************************
/// 查询设备用户
///*********************************************************************/
function CLIENT_QueryUserInfo(lLoginID: LONG; nUserType: int; pUserInfoBuffer: Pchar; maxlen: int; var nUserInfolen: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryUserInfo';


//***********************************************************************
/// 操作设备用户
///*********************************************************************/
function CLIENT_OperateUserInfo(lLoginID: LONG; nOperateType: int; pOperateBuffer: Pchar; nOpreateInfolen: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_OperateUserInfo';


//***********************************************************************
/// 开始对讲
///*********************************************************************/
function CLIENT_StartTalk(lRealHandle: LONG; bCustomSend: bool = false): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StartTalk';


//***********************************************************************
/// 结束对讲
///*********************************************************************/
function CLIENT_StopTalk(lRealHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_StopTalk';


//***********************************************************************
/// 发送自定义对讲数据
///*********************************************************************/
function CLIENT_SendTalkData_Custom(lRealHandle: LONG; pBuffer: Pchar; dwBufSize: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SendTalkData_Custom';


//***********************************************************************
/// 获取通道码流
///*********************************************************************/
function CLIENT_GetStatiscFlux(lLoginID: LONG; lPlayHandle: LONG): LONG; stdcall; external DHNetSDK_API name 'CLIENT_GetStatiscFlux';


//***********************************************************************
/// 查询IO状态
///*********************************************************************/
function CLIENT_QueryIOControlState(lLoginID: LONG; emType: IOTYPE;
  pState: pointer; maxlen: int; var nIOCount: int; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_QueryIOControlState';


//***********************************************************************
/// IO控制
///*********************************************************************/
function CLIENT_IOControl(lLoginID: LONG; emType: IOTYPE; pState: Pointer; maxlen: int): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_IOControl';

//add by zhaojs 2006/08/16

//***********************************************************************
/// 查询设备工作状态
///*********************************************************************/
function CLIENT_GetDEVWorkState(lLoginID: LONG; lpWorkState: LPNET_DEV_WORKSTATE; waittime: int = 15000): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_GetDEVWorkState';


//***********************************************************************
/// 强制I帧
///*********************************************************************/
function CLIENT_MakeKeyFrame(lLoginID: LONG; nChannelID: int; nSubChannel: int = 0): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_MakeKeyFrame';


//***********************************************************************
/// 设置设备限制码流
///*********************************************************************/
function CLIENT_SetMaxFlux(lLoginID: LONG; wFlux: WORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetMaxFlux';


//要新加的,未实现


//***********************************************************************
/// 通过设备名字或者设备序列号向DDNS服务器查询设备IP
///*********************************************************************/
function CLIENT_GetDVRIPByResolveSvr(pchDVRIP: Pchar; wDVRPort: WORD;
  sDVRName: Pchar; wDVRNameLen: WORD;
  sDVRSerialNumber: Pchar; wDVRSerialLen: WORD;
  sGetIP: Pchar): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_GetDVRIPByResolveSvr';

//***********************************************************************
/// 设置实时预览缓冲大小
///*********************************************************************/
function CLIENT_SetPlayerBufNumber(lRealHandle: LONG; dwBufNum: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetPlayerBufNumber';


//***********************************************************************
/// 通过时间回放录像
///*********************************************************************/
function CLIENT_PlayBackByTime(lLoginID: LONG; nChannelID: int;
  lpStartTime, lpStopTime: LPNET_TIME; hWnd: HWND; cbDownLoadPos: PfDownLoadPosCallBack; dwPosUser: DWORD): LONG; stdcall; external DHNetSDK_API name 'CLIENT_PlayBackByTime';

//***********************************************************************
/// 通过时间回放录像扩展_增加了数据回调参数
///*********************************************************************/
function CLIENT_PlayBackByTimeEx(lLoginID: LONG; nChannelID: int;
  lpStartTime, lpStopTime: LPNET_TIME; hWnd: HWND; cbDownLoadPos: PfDownLoadPosCallBack; dwPosUser: DWORD;
  fDownLoadDataCallBack: PfDataCallBack; dwDataUser: DWORD): LONG; stdcall; external DHNetSDK_API name 'CLIENT_PlayBackByTimeEx';

//***********************************************************************
/// 通过时间下载文件
///*********************************************************************/
function CLIENT_GetFileByTime(lLoginID: LONG; nChannelID: int;
  lpStartTime, lpStopTime: LPNET_TIME; sSavedFileName: Pchar): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_GetFileByTime';

//***********************************************************************
/// 网络回放控制
///*********************************************************************/
function CLIENT_PlayBackControl(lPlayHandle: LONG;
  dwControlCode, dwInValue: DWORD; var lpOutValue: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_PlayBackControl';

//***********************************************************************
/// 开始查找录像文件
///*********************************************************************/
function CLIENT_FindFile(lLoginID: LONG; nChannelId: int; nRecordFileType: int; cardid: Pchar; time_start, time_end: LPNET_TIME;
  bTime: bool; waittime: int): LONG; stdcall; external DHNetSDK_API name 'CLIENT_FindFile';
//***********************************************************************
/// 查找录像文件
///*********************************************************************/
function CLIENT_FindNextFile(lFindHandle: LONG; lpFindData: LPNET_RECORDFILE_INFO): int; stdcall; external DHNetSDK_API name 'CLIENT_FindNextFile';


//***********************************************************************
/// 结束录像文件查找
///*********************************************************************/
function CLIENT_FindClose(lFindHandle: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_FindClose';


//***********************************************************************
/// 重启设备：返回值 TRUE 成功， FALSE 失败
///*********************************************************************/
function CLIENT_RebootDev(lLoginID: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_RebootDev';


//***********************************************************************
/// 关闭设备：返回值 TRUE 成功， FALSE 失败
///*********************************************************************/
function CLIENT_ShutDownDev(lLoginID: LONG): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_ShutDownDev';


//***********************************************************************
/// 常量定义
///*********************************************************************/
const NAME_LEN = 32;
const MACADDR_LEN = 6;
const MAX_ETHERNET = 2;
const PATHNAME_LEN = 128;
const PASSWD_LEN = 16;
const MAX_TIMESEGMENT = 4;
const MAX_PRESET = 128;
const MAX_DAYS = 7;
const PHONENUMBER_LEN = 32;
const MAX_WINDOW = 16;
const MAX_VGA = 1;
const MAX_USERNUM = 16;
const MAX_EXCEPTIONNUM = 16;
const MAXCARD_NUM = 40;
const MAX_SERIALNUM = 2;
const CARDNUM_LEN = 20;
const MAX_VIDEOOUT = 2;
const MAX_DISPLAY_REGION = 16;
const MAX_NAMELEN = 16;
const MAX_RIGHT = 32;
const MAX_SHELTERNUM = 4;
const MAX_DECPOOLNUM = 4;
const MAX_DECNUM = 4;
const MAX_TRANSPARENTNUM = 2;
const MAX_STRINGNUM = 4;
const MAX_AUXOUT = 4;

type

  LPNET_DEV_SCHEDTIME = ^NET_DEV_SCHEDTIME;
  NET_DEV_SCHEDTIME = record
    byStartHour: BYTE; //开始时间
    byStartMin: BYTE;
    byStopHour: BYTE; //结束时间
    byStopMin: BYTE;
  end;
///***********************************************************************
/// 设备系统配置结构
///*********************************************************************/
{
 LPNET_DEV_DEVICECFG  =  ^NET_DEV_DEVICECFG     ;
 NET_DEV_DEVICECFG   = record
     DWORD	dwSize;
     BYTE	sDVRName[NAME_LEN];		// DVR 名称 ///
     DWORD	dwDVRID;			// DVR ID,用于遥控器 ///
     DWORD	dwRecycleRecord;		// 是否循环录像,0:不是; 1:是 ///
     // 以下不能更改
     BYTE	sSerialNumber[SERIALNO_LEN];	// 序列号 ///
     DWORD	dwSoftwareVersion;		// 软件版本号,高 16 位是主版本,低 16 位是次版本 ///
     DWORD	dwSoftwareBuildDate;		// 软件生成日期,0xYYYYMMDD///
     DWORD	dwDSPSoftwareVersion;		// DSP 软件版本,高 16 位是主版本,低 16 位是次版本///
     DWORD	dwDSPSoftwareBuildDate;		// DSP 软件生成日期,0xYYYYMMDD///
     DWORD	dwPanelVersion;			// 前面板版本,高 16 位是主版本,低 16 位是次版本 ///
     DWORD	dwHardwareVersion;		// 硬件版本,高 16 位是主版本,低 16 位是次版本 ///
     DWORD	dwDVRType;			// DVR 类型, 1:DVR 2:ATM DVR 3:DVS  等等 ///
     BYTE	byAlarmInPortNum;		// DVR 报警输入个数 ///
     BYTE	byAlarmOutPortNum;		// DVR 报警输出个数 ///
     BYTE	byRS232Num;			// DVR 232  串口个数 ///
     BYTE	byRS485Num;			// DVR 485  串口个数 ///
     BYTE	byNetworkPortNum;		// 网络口个数 ///
     BYTE	byDiskCtrlNum;			// DVR  硬盘控制器个数 ///
     BYTE	byDiskNum;			// DVR  硬盘个数 ///
     BYTE	byChanNum;			// DVR  通道个数 ///
     BYTE	byStartChan;			// 起始通道号,例如DVS-1,DVR – 1///
     BYTE	byDecordChans;			// DVR  解码路数 ///
     BYTE	byVGANum;			// VGA  口的个数 ///
     BYTE	byUSBNum;			// USB  口的个数 ///
 end ;

//***********************************************************************
/// 网络配置结构
///*********************************************************************/
 LPNET_DEV_ETHERNET  =  ^NET_DEV_ETHERNET     ;
 NET_DEV_ETHERNET   = record
     char	sDVRIP[16];                     // DVR IP 地址 ///
     char	sDVRIPMask[16];                 // DVR IP 地址掩码 ///
     DWORD	dwNetInterface;                 // 10M/100M  自适应,索引 ///
                                                //1-10MBase - T
                                                //2-10MBase-T 全双工
                                                //3-100MBase - TX
                                                //4-100M 全双工
                                                //5-10M/100M  自适应
     WORD	wDVRPort;                       // 端口号 ///
     BYTE	byMACAddr[MACADDR_LEN];         // 服务器的物理地址 ///
 end ;

 LPNET_DEV_NETCFG  =  ^NET_DEV_NETCFG     ;
 NET_DEV_NETCFG   = record
     DWORD	dwSize;
     NET_DEV_ETHERNET struEtherNet[MAX_ETHERNET];// 以太网口 ///
     char	sManageHostIP[16];				// 远程管理主机地址 ///
     WORD	wManageHostPort;				// 远程管理主机端口号 ///
     char	sDNSIP[16];						// DNS 服务器地址 ///
     char	sMultiCastIP[16];				// 多播组地址 ///
  WORD	wMultiCastPort;					// 多播端口///
     char	sGatewayIP[16];					// 网关地址 ///
     char	sNFSIP[16];						// NAS 主机IP 地址 ///
     BYTE	sNFSDirectory[PATHNAME_LEN];            	// NAS  目录 ///
     DWORD	dwPPPOE;						// 0-不启用,1-启用 ///
     BYTE	sPPPoEUser[NAME_LEN];                           // PPPoE 用户名 ///
     char	sPPPoEPassword[PASSWD_LEN];	        	// PPPoE 密码 ///
     char	sPPPoEIP[16];					//PPPoE IP 地址(只读)
     WORD	wHttpPort;						//http 端口号
 end ;

//***********************************************************************
/// 通道图象配置结构
///*********************************************************************/
 LPNET_DEV_HANDLEEXCEPTION  =  ^NET_DEV_HANDLEEXCEPTION     ;
 NET_DEV_HANDLEEXCEPTION   = record
 DWORD dwHandleType;						//处理方式,处理方式的"或"结果*/
           //0x00: 无响应*/
           //0x01: 监视器上警告*/
           //0x02: 声音警告*/
           //0x04: 上传中心*/
           //0x08: 触发报警输出*/
 BYTE   byRelAlarmOut[MAX_ALARMOUT];     // 报警触发的输出通道,报警触发的输出,为 1 表示触发该输出 ///
  end ;

 LPNET_DEV_MOTION  =  ^NET_DEV_MOTION     ;
 NET_DEV_MOTION   = record
    BYTE byMotionScope[18][22];				//侦测区域,共有22*18 个小宏块,为 1 表示改宏块是移动侦测区域,0-表示不是*/
 BYTE byMotionSenstive;					//移动侦测灵敏度, 0 - 5,越高越灵敏,0xff 关闭*/
    BYTE byEnableHandleMotion;				// 是否处理移动侦测 ///
    NET_DEV_HANDLEEXCEPTION strMotionHandleType; // 处理方式 ///
    NET_DEV_SCHEDTIME        struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT];// 布防时间///
    BYTE byRelRecordChan[MAX_CHANNUM];		//报警触发的录象通道,为 1 表示触发该通道
 end ;
 
//遮挡报警 区域大小704*576
 LPNET_DEV_HIDEALARM  =  ^NET_DEV_HIDEALARM     ;
 NET_DEV_HIDEALARM   = record
    DWORD	dwEnableHideAlarm;               // 是否启动遮挡报警  ,0-否,1-低灵敏度  2-中灵敏度  3-高灵敏度*/
    WORD	wHideAlarmAreaTopLeftX;          // 遮挡区域的x 坐标 ///
    WORD	wHideAlarmAreaTopLeftY;          // 遮挡区域的y 坐标 ///
    WORD	wHideAlarmAreaWidth;             // 遮挡区域的宽 ///
    WORD	wHideAlarmAreaHeight;            //遮挡区域的高*/
    NET_DEV_HANDLEEXCEPTION strHideAlarmHandleType;   // 处理方式 ///
    NET_DEV_SCHEDTIME        struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT];   //布防时间 ///

//信号丢失报警
 LPNET_DEV_VILOST  =  ^NET_DEV_VILOST     ;
 NET_DEV_VILOST   = record
     BYTE byEnableHandleVILost;     // 是否处理信号丢失报警 ///
     NET_DEV_HANDLEEXCEPTION strVILostHandleType; // 处理方式 ///
     NET_DEV_SCHEDTIME         struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT]; // 布防时间 ///
 end ;
 

 LPNET_DEV_SHELTER  =  ^NET_DEV_SHELTER     ;
 NET_DEV_SHELTER   = record
     WORD wHideAreaTopLeftX;                  // 遮挡区域的x 坐标 ///
     WORD wHideAreaTopLeftY;                  // 遮挡区域的y 坐标 ///
     WORD wHideAreaWidth;                     // 遮挡区域的宽 ///
     WORD wHideAreaHeight;                    //遮挡区域的高*/
 end;

 LPNET_DEV_PICCFG  =  ^NET_DEV_PICCFG     ;
 NET_DEV_PICCFG   = record
     DWORD dwSize;
     BYTE sChanName[NAME_LEN];
     DWORD dwVideoFormat;					 // 只读 视频制式  1-NTSC 2-PAL*/
     BYTE byBrightness;						 //亮度,0-255*/
     BYTE byContrast;						 //对比度,0-255*/
     BYTE bySaturation;						 //饱和度,0-255///
     BYTE byHue;							 //色调,0-255*/
     //显示通道名
     DWORD     dwShowChanName;				 // 预览的图象上是否显示通道名称,0-不显示,1-显示 区域大小704*576

     WORD wShowNameTopLeftX;                 // 通道名称显示位置的x 坐标 ///
     WORD wShowNameTopLeftY;                 // 通道名称显示位置的y 坐标 ///
     //信号丢失报警
     NET_DEV_VILOST struVILost;
     //移动侦测
     NET_DEV_MOTION struMotion;
     //遮挡报警
     NET_DEV_HIDEALARM struHideAlarm;
     //遮挡    区域大小704*576
     DWORD dwEnableHide;					// 是否启动遮挡  ,0-否,1-是*/
     NET_DEV_SHELTER struShelter[MAX_SHELTERNUM];
     //OSD
     DWORD dwShowOsd;//     预览的图象上是否显示OSD,0-不显示,1-显示 区域大小704*576
     WORD wOSDTopLeftX;                     // OSD 的x 坐标 ///
     WORD wOSDTopLeftY;                     // OSD 的y 坐标 ///
     BYTE byOSDType;                        // OSD 类型(主要是年月日格式)///
     // 0: XXXX-XX-XX    年月日 ///
     // 1: XX-XX-XXXX    月日年 ///
     // 2: XXXX 年XX 月XX  日 ///
     // 3: XX 月XX  日XXXX 年 ///
     BYTE byDispWeek;                   // 是否显示星期 ///
     BYTE byOSDAttrib;                  // OSD 属性:透明，闪烁 ///
     // 1: 透明,闪烁 ///
     // 2: 透明,不闪烁 ///
     // 3: 闪烁,不透明 ///
     // 4: 不透明,不闪烁 ///
 end ;
//3.2.4   压缩参数配置结构

 LPNET_DEV_COMPRESSION_INFO  =  ^NET_DEV_COMPRESSION_INFO     ;
 NET_DEV_COMPRESSION_INFO   = record
 BYTE byStreamType;             // 码流类型0-视频流,1-复合流 ///
    BYTE byResolution;              // 分辨率0-D1 1-HD1, 2-BCIF, 3-CIF, 4-QCIF,
         5-VGA , 6-QVGA, 7-SVCD, 8-NR*/
 BYTE byBitrateType;            // 码率类型0:定码率，1:变码率 ///
 BYTE byPicQuality;             // 图象质量  6-最好  5-次好  4-较好  3-一般  2-较差  1-差*/
    DWORD dwVideoBitrate;           // 视频码率  0- 保留  1-16K( 保留)           2-32K  3-48k  4-64K
                                    //5-80K   6-96K  7-128K  8-160k  9-192K  10-224K   11-256K
                                    //12-320K    13-384K  14-448K   15-512K  16-640K   17-768K
                                    //18-896K 19-1024K 20-1280K 21-1536K 22-1792K 23-2048K
                                    // 最高位(31 位)置成 1 表示是自定义码流,                  0-30 位表示码流
                                    // 值。最小值 16k        最大值 8192k*/
 DWORD dwVideoFrameRate;        // 帧率  0-全部; 1-1/16; 2-1/8; 3-1/4; 4-1/2; 5-1; 6-2; 7-4; 8-6;
                                        // 9-8; 10-10; 11-12; 12-16; 13-20*/
  end ;

 LPNET_DEV_COMPRESSIONCFG  =  ^NET_DEV_COMPRESSIONCFG     ;
 NET_DEV_COMPRESSIONCFG   = record
     DWORD dwSize;                  // 此结构的大小 ///
     NET_DEV_COMPRESSION_INFO struRecordPara; //        录像 ///
     NET_DEV_COMPRESSION_INFO struNetPara;            // 网传 ///
 end ;
 
//注：在网传（子码流）中的分辨率只能设置成 CIF 和QCIF。

//3.2.5   录像参数配置结构

 LPNET_DEV_RECORDSCHED  =  ^NET_DEV_RECORDSCHED     ;
 NET_DEV_RECORDSCHED   = record
     NET_DEV_SCHEDTIME struRecordTime;
     BYTE byRecordType;     //   0:定时录像，1:移动侦测，2:报警录像，3:动测|报警，4:动测&报警  5:命令触发, 6:  手动录像*/
     char reservedData[3];  // 保留 ///
 end ;
 
 LPNET_DEV_RECORDDAY  =  ^NET_DEV_RECORDDAY     ;
 NET_DEV_RECORDDAY   = record
     WORD wAllDayRecord;                // 是否全天录像 ///
     BYTE byRecordType;                 // 录象类型  0:定时录像，1:移动侦测，2:报警录像，3:动测|报警，4:动测&报警  5:命令触发, 6:  手动录像*/
     char reservedData;
 end ;

 LPNET_DEV_RECORD  =  ^NET_DEV_RECORD     ;
 NET_DEV_RECORD   = record
 DWORD dwSize;         // 此结构的大小 ///
    DWORD dwRecord;       //是否录像  0-否  1-是*/
    NET_DEV_RECORDDAY struRecAllDay[MAX_DAYS];
    NET_DEV_RECORDSCHED struRecordSched[MAX_DAYS][MAX_TIMESEGMENT];
    DWORD dwRecordTime;        // 录象时间长度 ///
    DWORD dwPreRecordTime; //     预录时间  0-不预录  1-5 秒  2-10 秒  3-15 秒  4-20 秒  5-25 秒 6-30 秒  7-0xffffffff(尽可能预录)///
 end ;

 //3.2.6   解码器参数配置结构

 LPNET_DEV_DECODERCFG  =  ^NET_DEV_DECODERCFG     ;
 NET_DEV_DECODERCFG   = record
     DWORD dwSize;         // 此结构的大小 ///
     DWORD dwBaudRate;      // 波特率(bps)(300，600，1200，2400，4800，9600，19200，
       38400，57600，76800，115.2k);///
      BYTE byDataBit;       // 数据有几位 (5 ，6，7，8) ;///
      BYTE byStopBit;       // 停止位  0 －1 位，1－2 位;///
      BYTE byParity;        // 校验  0 －无校验，1－奇校验，2－偶校验;///
      BYTE byFlowcontrol;    // 0 －无，1－软流控,2-硬流控 ///
      WORD wDecoderType; //    解码器类型,        见下表*/
      WORD wDecoderAddress;       //解码器地址:0 - 255*/
      BYTE bySetPreset[MAX_PRESET];            // 预置点是否设置,0-没有设置,1-设置*/
      BYTE bySetCruise[MAX_PRESET];            // 巡航是否设置: 0-没有设置,1-设置 ///
      BYTE bySetTrack[MAX_PRESET];             // 轨迹是否设置,0-没有设置,1-设置*/
 end ;
 }
// PTZ type///
const YOULI = 0;
const LILIN_1016 = 1;
const LILIN_820 = 2;
const PELCO_P = 3;
const DM_QUICKBALL = 4;
const HD600 = 5;
const JC4116 = 6;
const PELCO_DWX = 7;
const PELCO_D = 8;
const VCOM_VC_2000 = 9;
const NETSTREAMER = 10;
const SAE = 11;
const SAMSUNG = 12;
const KALATEL_KTD_312 = 13;
const CELOTEX = 14;
const TLPELCO_P = 15;
const TL_HHX2000 = 16;
const BBV = 17;
const RM110 = 18;
const KC3360S = 19;
const ACES = 20;
const ALSON = 21;
const INV3609HD = 22;
const HOWELL = 23;
const TC_PELCO_P = 24;
const TC_PELCO_D = 25;
const AUTO_M = 26;
const AUTO_H = 27;
const ANTEN = 28;
const CHANGLIN = 29;
const DELTADOME = 30;
const XYM_12 = 31;
const ADR8060 = 32;
const EVI = 33;
const Demo_Speed = 34;
const DM_PELCO_D = 35;
const ST_832 = 36;
const LC_D2104 = 37;
const HUNTER = 38;
const A01 = 39;
const TECHWIN = 40;
const WEIHAN = 41;
const LG = 42;
const D_MAX = 43;
const PANASONIC = 44;
const KTD_348 = 45;
const INFINOVA = 46;
const PIH717 = 47;
const IDOME_IVIEW_LCU = 48;
const DENNARD_DOME = 49;
const PHLIPS = 50;
const SAMPLE = 51;
const PLD = 52;
const PARCO = 53;
const HY = 54;
const NAIJIE = 55;
const CAT_KING = 56;
const YH_06 = 57;
const SP9096X = 58;
const M_PANEL = 59;
const M_MV2050 = 60;
const SAE_QUICKBALL = 61;
const RED_APPLE = 62;
const NKO8G = 63;
const DH_CC440 = 64;

{
//3.2.7    串口配置结构

 LPNET_DEV_PPPCFG  =  ^NET_DEV_PPPCFG     ;
 NET_DEV_PPPCFG   = record
      char sRemoteIP[16];             // 远端IP 地址 ///
      char sLocalIP[16];             //  本地IP 地址 ///
      char sLocalIPMask[16];          // 本地IP 地址掩码 ///
      BYTE sUsername[NAME_LEN];           // 用户名 ///
      BYTE sPassword[PASSWD_LEN];          // 密码 ///
      BYTE byPPPMode;                 // PPP 模式, 0－主动，1－被动 ///
      BYTE byRedial;                  // 是否回拨 ：0-否,1-是 ///
      BYTE byRedialMode;              // 回拨模式,0-由拨入者指定,1-预置回拨号码 ///
      BYTE byDataEncrypt;             // 数据加密,0-否,1-是 ///
      DWORD dwMTU;                   // MTU///
      char sTelephoneNumber[PHONENUMBER_LEN];            // 电话号码 ///
 end ;

 LPNET_DEV_RS232CFG  =  ^NET_DEV_RS232CFG     ;
     DWORD dwSize;                   // 此结构的大小 ///
  DWORD dwBaudRate;               // (300，600，1200，2400，4800，9600，19200，
           38400，57600，76800，115.2k);///

     BYTE byDataBit;         // 数据有几位 (5 ，6，7，8)///
     BYTE byStopBit;         // 停止位  0 －1 位，1－2 位;///
     BYTE byParity;              // 校验  0 －无校验，1－奇校验，2－偶校验;///
     BYTE byFlowcontrol;     // 0 －无，1－软流控,2-硬流控 ///
     DWORD dwWorkMode;           // 工作模式，0－窄带传输（232            串口用于 PPP  拨号），1－控制台（232  串口用于参数控制），2－透明通道 ///
     NET_DEV_PPPCFG struPPPConfig;
 end ;
 
//3.2.8  报警输入配置结构

 LPNET_DEV_ALARMINCFG  =  ^NET_DEV_ALARMINCFG     ;
 NET_DEV_ALARMINCFG   = record
    DWORD dwSize;        // 此结构的大小 ///
     BYTE sAlarmInName[NAME_LEN];     // 名称 ///
     BYTE byAlarmType;               // 报警器类型,0：常开,1：常闭 ///
     BYTE byAlarmInHandle;           // 是否处理 ///
     NET_DEV_HANDLEEXCEPTION struAlarmHandleType;          // 处理方式 ///
     NET_DEV_SCHEDTIME struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT];//布防时间
     BYTE byRelRecordChan[MAX_CHANNUM];          // 报警触发的录象通道,为 1  表示触发该通道 ///
     BYTE byEnablePreset[MAX_CHANNUM];           // 是否调用预置点 ///
     BYTE byPresetNo[MAX_CHANNUM];               // 调用的云台预置点序号,一个报警输 入可以调用多个通道的云台预置点, 0xff 表示不调用预置点。*/
     BYTE byEnableCruise[MAX_CHANNUM];           // 是否调用巡航 ///
     BYTE byCruiseNo[MAX_CHANNUM];               // 巡航 ///
     BYTE byEnablePtzTrack[MAX_CHANNUM];         // 是否调用轨迹 ///
     BYTE byPTZTrack[MAX_CHANNUM];               // 调用的云台的轨迹序号 ///
 end ;
//3.2.9  报警输出配置结构

 LPNET_DEV_ALARMOUTCFG  =  ^NET_DEV_ALARMOUTCFG     ;
 NET_DEV_ALARMOUTCFG   = record
     DWORD dwSize;       // 此结构的大小 ///
     BYTE sAlarmOutName[NAME_LEN];        // 名称 ///
     DWORD dwAlarmOutDelay; //  输出保持时间(-1 为无限，手动关闭)///
     NET_DEV_SCHEDTIME   struAlarmOutTime[MAX_DAYS][MAX_TIMESEGMENT];//          报警输出激活时间段 ///
 end;
//3.2.10   本地预览参数配置结构

 LPNET_DEV_PREVIEWCFG  =  ^NET_DEV_PREVIEWCFG     ;
 NET_DEV_PREVIEWCFG   = record
     DWORD dwSize;           // 此结构的大小 ///
     BYTE byPreviewNumber;    // 预览数目,0-1 画面,1-4 画面,2-9 画面,3-16 画面,0xff:最大画面*/
     BYTE byEnableAudio;       // 是否声音预览,0-不预览,1-预览 ///
     WORD wSwitchTime;         // 切换时间,0-不切换,1-5s,2-10s,3-20s,4-60s,5-120s,6-300s///
     BYTE bySwitchSeq[MAX_WINDOW];            //切换顺序,如果lSwitchSeq[i]为  0xff 表示不用*/
 end ;
 
//3.2.11    视频输出配置结构

 LPNET_DEV_VGAPARA  =  ^NET_DEV_VGAPARA     ;
 NET_DEV_VGAPARA   = record
     WORD wResolution;                           // 分辨率 ///
     WORD wFreq;                                 // 刷新频率 ///
     DWORD dwBrightness;                         // 亮度 ///
 end;

 LPNET_DEV_MATRIXPARA  =  ^NET_DEV_MATRIXPARA     ;
 NET_DEV_MATRIXPARA   = record
     WORD wDisplayLogo;                          // 显示视频通道号 ///
     WORD wDisplayOsd;                           // 显示时间 ///
 end;

 LPNET_DEV_VOOUT  =  ^NET_DEV_VOOUT     ;
 NET_DEV_VOOUT   = record
     BYTE byVideoFormat;                         // 输出制式,0-PAL,1-N///
     BYTE byMenuAlphaValue;                      // 菜单与背景图象对比度 ///
     WORD wScreenSaveTime;                       // 屏幕保护时间 ///
     WORD wVOffset;                              // 视频输出偏移 ///
     WORD wBrightness;                           // 视频输出亮度 ///
     BYTE byStartMode;                           // 启动后视频输出模式(0:菜单,1:预览)*/
     char reservedData;
 end ;

 LPNET_DEV_VIDEOOUT  =  ^NET_DEV_VIDEOOUT     ;
 NET_DEV_VIDEOOUT   = record
     DWORD dwSize;
     NET_DEV_VOOUT struVOOut[MAX_VIDEOOUT];
     NET_DEV_VGAPARA struVGAPara[MAX_VGA];             // VGA 参数 ///
     NET_DEV_MATRIXPARA struMatrixPara;          // MATRIX 参数 ///
 end;

//3.2.12    用户参数配置结构

//DVR 用户参数扩展，本地、远程回放，远程预览权限细化到通道。
 LPNET_DEV_USER_INFO  =  ^NET_DEV_USER_INFO     ;
 NET_DEV_USER_INFO   = record
     BYTE sUserName[NAME_LEN]; // 用户名 ///
     BYTE sPassword[PASSWD_LEN];   // 密码 ///
     DWORD dwLocalRight[MAX_RIGHT];    // 权限 ///
                   //数组0:  本地控制云台*/
                   //数组1:  本地手动录象*/
                   //数组2:  本地回放*/
                   //数组3:  本地设置参数*/
                   //数组4:  本地查看状态、日志*/
                   //数组5:  本地高级操作(升级，格式化，重启，关机)*/
     DWORD dwLocalPlaybackRight; // 本地可以回放的通道  bit0 -- channel 1*/
     DWORD dwRemoteRight[MAX_RIGHT];   // 权限 ///
                   //数组0:  远程控制云台*/
                   //数组 1:  远程手动录象*/
                   //数组2:  远程回放 ///
                   //数组3:  远程设置参数*/
                   //数组4:  远程查看状态、日志*/
                   //数组5:  远程高级操作(升级，格式化，重启，关机)*/
                   //数组6:  远程发起语音对讲*/
                   //数组7:  远程预览*/
                   //数组 8:  远程请求报警上传、报警输出*/
                   //数组9:  远程控制，本地输出*/
                   //数组 10:  远程控制串口*/
     DWORD dwNetPreviewRight;  // 远程可以预览的通道  bit0 -- channel 1*/
     DWORD dwNetPlaybackRight;      // 远程可以回放的通道  bit0 -- channel 1*/
     char sUserIP[16];    // 用户IP 地址(为0 时表示允许任何地址)///
     BYTE byMACAddr[MACADDR_LEN];            // 物理地址 ///
 end ;

 LPNET_DEV_USER  =  ^NET_DEV_USER     ;
 NET_DEV_USER   = record
     DWORD dwSize;
     NET_DEV_USER_INFO struUser[MAX_USERNUM];
 end ;
 
//3.2.13   异常参数配置结构

 LPNET_DEV_EXCEPTION  =  ^NET_DEV_EXCEPTION     ;
 NET_DEV_EXCEPTION   = record
     DWORD dwSize;
     NET_DEV_HANDLEEXCEPTION struExceptionHandleType[MAX_EXCEPTIONNUM];
     //数组0-盘满,1-  硬盘出错,2-网线断,3-局域网内IP  地址冲突,4-非法访问,   5-输入/输出视频制式不匹配*/
 end;

//3.2.14    帧信息配置结构

 LPNET_DEV_FRAMETYPECODE  =  ^NET_DEV_FRAMETYPECODE     ;
 NET_DEV_FRAMETYPECODE  = record
     BYTE code[12];       // 代码 ///
 end;

 LPNET_DEV_FRAMEFORMAT = ^NET_DEV_FRAMEFORMAT ;
 NET_DEV_FRAMEFORMAT = record
    DWORD dwSize;
     char sATMIP[16];                           // ATM IP 地址 ///
     DWORD dwATMType;                           // ATM 类型 ///
     DWORD dwInputMode;                         // 输入方式 ///
     DWORD dwFrameSignBeginPos;                 // 报文标志位的起始位置*/
     DWORD dwFrameSignLength;                   // 报文标志位的长度 ///
     BYTE   byFrameSignContent[12];             // 报文标志位的内容 ///
     DWORD dwCardLengthInfoBeginPos;            // 卡号长度信息的起始位置 ///
     DWORD dwCardLengthInfoLength;              // 卡号长度信息的长度 ///
     DWORD dwCardNumberInfoBeginPos;            // 卡号信息的起始位置 ///
     DWORD dwCardNumberInfoLength;              // 卡号信息的长度 ///
     DWORD dwBusinessTypeBeginPos;              // 交易类型的起始位置 ///
     DWORD dwBusinessTypeLength;                // 交易类型的长度 ///
     NET_DEV_FRAMETYPECODE frameTypeCode[10];//         类型 ///
 end;

 }

//CLIENT_GetDEVConfig,CLIENT_GetDEVConfig的命令定义
//const DEV_GET_DEVICECFG = 100; //获取设备参数
//const DEV_SET_DEVICECFG = 100; //设置设备参数
//const DEV_GET_NETCFG = 102; //获取网络参数
//const DEV_SET_NETCFG = 102; //设置网络参数
//const DEV_GET_PICCFG = 104; //获取图象参数
//const DEV_SET_PICCFG = 104; //设置图象参数
//const DEV_GET_COMPRESSCFG = 106; //获取压缩参数
//const DEV_SET_COMPRESSCFG = 106; //设置压缩参数
//const DEV_GET_RECORDCFG = 108; //获取录像时间参数
//const DEV_SET_RECORDCFG = 108; //设置录像时间参数
//const DEV_GET_DECODERCFG = 110; //获取解码器参数
//const DEV_SET_DECODERCFG = 110; //设置解码器参数
//const DEV_GET_RS232CFG = 112; //获取232串口参数
//const DEV_SET_RS232CFG = 112; //设置232串口参数
//const DEV_GET_ALARMINCFG = 114; //获取报警输入参数
//const DEV_SET_ALARMINCFG = 114; //设置报警输入参数
//const DEV_GET_ALARMOUTCFG = 116; //获取报警输出参数
//const DEV_SET_ALARMOUTCFG = 116; //设置报警输出参数
//const DEV_GET_TIMECFG = 118; //获取DVR时间
//const DEV_SET_TIMECFG = 118; //设置DVR时间
//const DEV_GET_PREVIEWCFG = 120; //获取预览参数
//const DEV_SET_PREVIEWCFG = 120; //设置预览参数
//const DEV_GET_VIDEOOUTCFG = 122; //获取视频输出参数
//const DEV_SET_VIDEOOUTCFG = 122; //设置视频输出参数
//const DEV_GET_USERCFG = 124; //获取用户参数
//const DEV_SET_USERCFG = 124; //设置用户参数
//const DEV_GET_EXCEPTIONCFG = 126; //获取异常参数
//const DEV_SET_EXCEPTIONCFG = 126; //设置异常参数

const DH_DEV_PREVIEWCFG=4;		// 预览参数配置
const DH_N_COL_TSECT=2; // 颜色时间段个数
// 预览图像参数
//typedef struct
//{
//	DWORD				dwSize;
//	DH_VIDEOENC_OPT		stPreView;
//	DH_COLOR_CFG		stColorCfg[DH_N_COL_TSECT];
//}DHDEV_PREVIEW_CFG;

// 画面颜色属性
//typedef struct
//{
//	DH_TSECT			stSect;
//	BYTE				byBrightness;			// 亮度；0-100
//	BYTE				byContrast;				// 对比度；0-100
//	BYTE				bySaturation;			// 饱和度；0-100
//	BYTE				byHue;					// 色度；0-100
//	BYTE				byGainEn;				// 增益使能
//	BYTE				byGain;					// 增益；0-100
//	BYTE				byReserved[2];
//} DH_COLOR_CFG, *LPDH_COLOR_CFG;


// 时间段结构															    
//typedef struct
//{
//	BOOL				bEnable;				// 当表示录像时间段时，按位表示四个使能，从低位到高位分别表示动检录象、报警录象、普通录象、动检和报警同时发生才录像
//	int					iBeginHour;
//	int					iBeginMin;
//	int					iBeginSec;
//	int					iEndHour;
//	int					iEndMin;
//	int					iEndSec;
//} DH_TSECT, *LPDH_TSECT;
type
  LPDH_TSECT=^DH_TSECT;
  DH_TSECT=record
  bEnable:BOOL;//当表示录像时间段时，按位表示四个使能，从低位到高位分别表示动检录象、报警录象、普通录象、动检和报警同时发生才录像
  iBeginHour:int;
  iBeginMin:int;
  iBeginSec:int;
  iEndHour:int;
  iEndMin:int;
  iEndSec:int;
end;

LPDH_COLOR_CFG=^DH_COLOR_CFG;
DH_COLOR_CFG=record
  stSect:DH_TSECT;
  byBrightness:BYTE;//亮度；0-100
  byContrast:BYTE;//对比度；0-100
  bySaturation:BYTE;//饱和度；0-100
  byHue:BYTE;//色度；0-100
  byGainEn:BYTE;//增益使能
  byGain:BYTE;//增益；0-100
  byReserved:array[0..2-1] of BYTE;
end;

// 通道音视频属性
//typedef struct
//{
//	// 视频参数
//	BYTE				byVideoEnable;			// 视频使能；1：打开，0：关闭
//	BYTE				byBitRateControl;		// 码流控制；参照常量"码流控制"定义
//	BYTE				byFramesPerSec;			// 帧率
//	BYTE				byEncodeMode;			// 编码模式；参照常量"编码模式"定义
//	BYTE				byImageSize;			// 分辨率；参照常量"分辨率"定义
//	BYTE				byImageQlty;			// 档次1-6
//	WORD				wLimitStream;			// 限码流参数
//	// 音频参数
//	BYTE				byAudioEnable;			// 音频使能；1：打开，0：关闭
//	BYTE				wFormatTag;				// 音频编码类型
//	WORD				nChannels;				// 声道数
//	WORD				wBitsPerSample;			// 采样深度	
//	BYTE				bAudioOverlay;			// 音频叠加使能
//	BYTE				bReserved_2;
//	DWORD				nSamplesPerSec;			// 采样率
//	BYTE				bIFrameInterval;		// I帧间隔帧数量，描述两个I帧之间的P帧个数，0-149
//	BYTE				bScanMode;				// NSP
//	BYTE				bReserved_3;
//	BYTE				bReserved_4;
//} DH_VIDEOENC_OPT, *LPDH_VIDEOENC_OPT;

LPDH_VIDEOENC_OPT=^DH_VIDEOENC_OPT;
DH_VIDEOENC_OPT=record
  //视频参数
  byVideoEnable:BYTE;//视频使能；1：打开，0：关闭
  byBitRateControl:BYTE;//码流控制；参照常量"码流控制"定义
  byFramesPerSec:BYTE;//帧率
  byEncodeMode:BYTE;//编码模式；参照常量"编码模式"定义
  byImageSize:BYTE;//分辨率；参照常量"分辨率"定义
  byImageQlty:BYTE;//档次1-6
  wLimitStream:WORD;//限码流参数
  //音频参数
  byAudioEnable:BYTE;//音频使能；1：打开，0：关闭
  wFormatTag:BYTE;//音频编码类型
  nChannels:WORD;//声道数
  wBitsPerSample:WORD;//采样深度
  bAudioOverlay:BYTE;//音频叠加使能
  bReserved_2:BYTE;
  nSamplesPerSec:DWORD;//采样率
  bIFrameInterval:BYTE;//I帧间隔帧数量，描述两个I帧之间的P帧个数，0-149
  bScanMode:BYTE;//NSP
  bReserved_3:BYTE;
  bReserved_4:BYTE;
end;


type
  DHDEV_PREVIEW_CFG=record
    dwSize:DWORD;
    stPreView:DH_VIDEOENC_OPT;
    stColorCfg:array[0..DH_N_COL_TSECT-1] of DH_COLOR_CFG;
  end;



//参数设置
function CLIENT_GetDevConfig(lLoginID:LONG;dwCommand:DWORD;lChannel:LONG;lpOutBuffer:Pointer;dwOutBufferSize:DWORD;lpBytesReturned:LPDWORD;waittime:int=500):BOOL;stdcall; external DHNetSDK_API name 'CLIENT_GetDevConfig';

//function CLIENT_GetDevConfig(lLoginID: LONG; dwCommand: DWORD; lChannel: LONG; lpOutBuffer: Pointer; dwOutBufferSize: DWORD; var lpBytesReturned: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_GetDevConfig';
function CLIENT_SetDevConfig(lLoginID: LONG; dwCommand: DWORD; lChannel: LONG; lpInBuffer: Pointer; dwInBufferSize: DWORD): BOOL; stdcall; external DHNetSDK_API name 'CLIENT_SetDevConfig';

const
DH_CAPTURE_SIZE_D1=$00000001;
DH_CAPTURE_SIZE_HD1=$00000002;
DH_CAPTURE_SIZE_BCIF=$00000004;
DH_CAPTURE_SIZE_CIF=$00000008;
DH_CAPTURE_SIZE_QCIF=$00000010;
DH_CAPTURE_SIZE_VGA=$00000020;
DH_CAPTURE_SIZE_QVGA=$00000040;
DH_CAPTURE_SIZE_SVCD=$00000080;
DH_CAPTURE_SIZE_QQVGA=$00000100;
DH_CAPTURE_SIZE_SVGA=$00000200;
DH_CAPTURE_SIZE_XVGA=$00000400;
DH_CAPTURE_SIZE_WXGA=$00000800;
DH_CAPTURE_SIZE_SXGA=$00001000;
DH_CAPTURE_SIZE_WSXGA=$00002000;
DH_CAPTURE_SIZE_UXGA=$00004000;
DH_CAPTURE_SIZE_WUXGA=$00008000;
DH_CAPTURE_SIZE_LFT=$00010000;
DH_CAPTURE_SIZE_720=$00020000;
DH_CAPTURE_SIZE_1080=$00040000;
DH_CAPTURE_SIZE_1_3M=$00080000;
DH_CAPTURE_SIZE_2M=$00100000;
DH_CAPTURE_SIZE_5M=$00200000;
DH_CAPTURE_SIZE_3M=$00400000;
DH_CAPTURE_SIZE_5_0M=$00800000;
DH_CPTRUTE_SIZE_1_2M=$01000000;
DH_CPTRUTE_SIZE_1408_1024=$02000000;
DH_CPTRUTE_SIZE_8M=$04000000;


implementation



end.
