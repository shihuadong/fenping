unit KDNvrSdkUnit;

interface
    uses windows;
const
    KDNvrSdkDll = 'nvrsdk.dll';

    NVR_LEN_PROXY_NAMEPWD = 64;
    NVR_LEN_NAME = 32;            // 最大名称长度，如设备名、设备类型名、用户名
    NVR_LEN_GUID = 32;            // 设备产品GUID长度
    NVR_MAX_ALARMIN = 16;         // 最大报警输入
    NVR_MAX_ALARMOUT = 16;        // 最大报警输出
   NVR_MAX_MACADDR = 6;           // MAC地址位数

NVR_MAX_NVRNUM=127;	// 可以连接的最大的NVR数量 -->256
NVR_MAX_NVRDEVNUM=64;	// 单个NVR可以管理的最大编码设备或解码设备的数量
NVR_MAX_NVRENCNUM=64;	// 单个NVR可以管理的最大编码设备的数量
NVR_MAX_NVRDECNUM=64;	// 单个NVR可以管理的最大编码设备的数量
NVR_MAX_NVRCHNNUM =64;  // 单个NVR可以管理的最大编码通道或解码通道的数量
NVR_MAX_DEVCHNNUM=16;  // 单个编码设备具有的编码通道的最大数量
NVR_MAX_USERNUM	=64;  // NVR最大用户数目
NVR_MAX_MONITORNUM=64;	// 支持的最大Monitor数量，TODO:可能需要修改
NVR_MAX_NVRALARM_INPUT=2;	// NVR告警输入最多个数
NVR_MAX_PRIMARYSCRSETNUM=32;  // NVR主屏输出模式集合最多个数
NVR_MAX_NVRDEVALARM=8;   // NVR系统告警最多个数
NVR_MAX_TVWCHN2860=64;  //NVR2860电视墙预案最大个
NVR_MAXNUM_TVWPROJ= 16;  //最大电视墙预案数 需求为16个预案

   NVR_LEN_DDNS_USERNAME=128;	// DDNS用户名最大长度，考虑去除
  NVR_LEN_DDNS_PWD=128;	// DDNS密码最大长度，考虑去除
  NVR_LEN_PPPOE_USERNAME=32;	// PPPoE用户名最大长度，考虑去除
  NVR_LEN_PPPOE_PWD=32;	// PPPoE密码最大长度，考虑去除
  NVR_MAXLEN_PICNAME=128;	// 图片文件名的字符串最大长度
  NVR_LEN_LOGCONTENT=256;	// 日志内容描述信息的最大长度
  NVR_LEN_VERSION=64;	// 软件版本号字符串最大长度
  NVR_LEN_DEVSERIAL=16;	// 设备序列号字符串最大长度
  NVR_MAXLEN_PRODUCTDATE=16;	// 产品生产日期字符串最大长度
  NVR_LEN_DEVFLOWCODE=8;	// 设备流水号字符串最大长度
  NVR_LEN_URL=  255;//

  // 其他重要的宏
  NVR_INVALID_HANDLE =-1;	// 无效的句柄
  NVR_MAX_NETSND_DEST_NUM=5;
  NVR_NVRID_BEGIN=1;					// NVR ID号最小值
  NVR_NVRID_END	=NVR_MAX_NVRNUM	;	// NVR ID号最大值
  NVR_ENCID_BEGIN=1;					// 编码器ID最小值
  NVR_ENCID_END	=NVR_MAX_NVRENCNUM;	// 编码器ID最大值
  NVR_DECID_BEGIN=128;					// 解码器ID最小值
  NVR_DECID_END	=(NVR_DECID_BEGIN+NVR_MAX_NVRDECNUM-1);	// 解码器ID最大值
  NVR_CHNID_BEGIN=1;					// 编码器或解码器的通道ID的最小值
  NVR_CHNID_END	=NVR_MAX_DEVCHNNUM ;	// 编码器或解码器的通道ID的最大值
  NVR_SYNCPLAY_MAX =4;                   //同步回放最高路数
  NVR_INVALID_NVRID=$ff;		// 非法的NVR ID号
  NVR_INVALID_DVSID=$ff;		// 非法的DVS ID号
  NVR_INVALID_CHNID=$ff;		// 非法的通道ID号

type
    LPInt = PInteger;
    LPCSTR = PChar;
    LPWORD = PWORD;
    LPBYTE = PByte;

//// 修改时所用的设备IP信息
//typedef struct TNVR_DEV_IPINFO
//{
//	BOOL  bModifyDevIP;					 //是否修改设备IP信息
//	DWORD dwGroupIp;                     //组播IP 网络序 inet_addr("224.16.32.1")
//	WORD  wPort;                         //当前port 默认端口 5510
//	DWORD dwOldIp;                       //旧设置ip
//	DWORD dwNewIp;                       //新设置ip
//	DWORD dwNewMask;                     //新掩码
//	DWORD dwNewGW;                       //新网关
//	BOOL  bModifyDevRegisterIP;		     //是否修改设备注册地址IP信息
//	DWORD dwRegisterIP;                  //设备的注册IP
//	BYTE  abyGUID[NVR_LEN_GUID];		 // 产品GUID
//} *LPTNVR_DEVIPINFO;

{ //SHIHUADONG定义
type
  Tm_tVideoParam=record
    case Integer of
    0:(struct: record
         m_bKeyFrame:Boolean;
         m_wVideoWidth:Word;
         m_wVideoHeight:Word;
         end;
       );

    1:(m_byAudioMode:Byte);
  end;
}

type
  Tm_tVideoParam=record
    m_bKeyFrame:Boolean;
    m_wVideoWidth:Word;
    m_wVideoHeight:Word
  end;

type
    LPTNVR_FRAMEHDR=^TNVR_FRAMEHDR;
    TNVR_FRAMEHDR = record
        m_byMediaType: Char;
        m_pData: PChar;
        m_dwPreBufSize: DWORD;
        m_dwDataSize: DWORD;
        m_byFrameRate: Byte;
        m_dwFrameID: DWORD;
        m_dwTimeStamp: DWORD;
        m_dwSSRC: DWORD;
        m_tVideoParam:Tm_tVideoParam;
    end;
//
////Frame Header Structure
//typedef struct TNVR_FRAMEHDR
//{
//    char  m_byMediaType; //媒体类型
//    char  *m_pData;       //数据缓冲
//    DWORD  m_dwPreBufSize;//m_pData缓冲前预留了多少空间，用于加
//                          // RTP option的时候偏移指针一般为12+4+12
//                          // (FIXED HEADER + Extence option + Extence bit)
//    DWORD    m_dwDataSize;  //m_pData指向的实际缓冲大小缓冲大小
//    BYTE	 m_byFrameRate; //发送帧率,用于接收端
//    DWORD    m_dwFrameID;   //帧标识，用于接收端
//    DWORD    m_dwTimeStamp; //时间戳, 用于接收端
//    DWORD    m_dwSSRC;      //同步源, 用于接收端
//    union
//    {
//        struct{
//                   BOOL    m_bKeyFrame;    //频帧类型（I or P）
//                   WORD    m_wVideoWidth;  //视频帧宽
//                   WORD    m_wVideoHeight; //视频帧宽
//              }m_tVideoParam;
//        BYTE  m_byAudioMode;//音频模式
//    };
//}*LPTNVR_FRAMEHDR;
  //网络参数
  PNVR_NET_SESSION = ^TNVR_NET_SESSION;
  TNVR_NET_SESSION  = record
      m_dwRTPAddr: DWORD;   //RTP地址(网络序)
      m_wRTPPort: DWORD;    //RTP端口(本机序)
      m_dwRTCPAddr: DWORD;  //RTCP地址(网络序)
      m_wRTCPPort: DWORD;   //RTCP端口(本机序)
  end;

  //本地网络参数
  PNVR_LOCAL_NET_PARAM = ^TNVR_LOCAL_NET_PARAM;
  TNVR_LOCAL_NET_PARAM = record
     m_tLocalNet: TNVR_NET_SESSION;
     m_dwRtcpBackAddr: Dword;  //RTCP回发地址
     m_wRtcpBackPort: Word;    //RTCP回发端口
  end;

  //网络发送参数
  PNVR_SEND_NET_PARAM = ^TNVR_SEND_NET_PARAM;
  TNVR_SEND_NET_PARAM = record
     m_byNum: Byte;
     m_tLocalNet: TNVR_NET_SESSION;
     m_tRemoteNet: TNVR_NET_SESSION;
  end;

  LPTNVR_SOCKS5INFO = ^TNVR_SOCKS5INFO;
  TNVR_SOCKS5INFO = record
      dwProxyIP: DWORD;      // 代理服务器Ip地址，网络序
      wProxyPort: WORD;      // 代理服务器端口
      szUserName: array[0..NVR_LEN_PROXY_NAMEPWD - 1] of Char;  // 代理登录用户
      szPassword: array[0..NVR_LEN_PROXY_NAMEPWD - 1] of Char;   // 代理登录用户密码
  end;

  LPTNVR_CONNECTINFO = ^TNVR_CONNECTINFO;
  TNVR_CONNECTINFO = record
      szNVRAddr: array[0..MAX_PATH -1] of Char;           // NVR的地址，可以IP地址或域名
      wNVRPort: Word;                                     // 连接端口号，一般为1730
      szUserName: array[0..NVR_LEN_NAME-1] of Char;       // 认证用户名
      szPassword: array[0..NVR_LEN_NAME-1] of Char;       // 认证用户密码
      bRemoteConnect: Boolean;                            // FALSE表示本地登录，TRUE表示远程登录，本地登录时，不支持代理服务器
      bUsedSocks: Boolean;                                // 是否使用代理服务器
      tSocks: TNVR_SOCKS5INFO;                            // Socks5代理服务器信息
      wConnectState: Word;                                // 连接状态：0-未连接 1-连接中，wConnectProgress有效，2-已正常连接
      wConnectProgress: Word;                             // 连接进度
  end;

  // 设备信息：编码器、解码器
  LPTNVR_DEVINFO = ^TNVR_DEVINFO;
  TNVR_DEVINFO  = record
	byNVRID: BYTE;			// 设备所属NVR
	byDevID: BYTE;			// 编码器/解码器ID
	// 设备基本信息
	szDevName: array[0..NVR_LEN_NAME-1] of CHAR;	// 设备名称
        dwDevIpAddr: DWORD;		// IP地址
	dwRegIp: DWORD;			// 记录设备注册的IP地址（NVR支持多IP）
	byManuId: BYTE;			// 设备厂商
	szTypeName: array[0..NVR_LEN_NAME-1] of CHAR;	// 设备类型名称
        abyGUID: array[0..NVR_LEN_GUID-1] of BYTE;	// 产品GUID
	// 设备能力信息
        bySupportDoubleStream: BYTE;	// 是否支持双流
        bySupportSave: BYTE;            // 是否支持SD卡存储
	byVideoInPortNum: BYTE;	// 视频输入端口数量
	byVideoEncNum: BYTE;	// 视频编码通道数量
	byVideoDecNum: BYTE;	// 视频解码通道数量
	byAudioEncNum: BYTE;	// 音频编码通道数量
	byAudioDecNum: BYTE;	// 音频解码通道数量
	bySerialPortNum: BYTE;	// 串口数量
	byInputPinNum: BYTE;	// 并口输入数量
	byAlarmInPortNum: BYTE;	// 报警输入数量
	byAlarmOutPortNum: BYTE;// 报警输出数量
        byImageShadeNum: BYTE;  // 图像遮蔽能力
	// 设备在线状态（注册状态）
	byOnlineState: BYTE;	// 是否在线
  end;

  LPTNVR_DEVSTATE = ^TNVR_DEVSTATE;
  TNVR_DEVSTATE = record
	abyAlarmInState: array[0..NVR_MAX_ALARMIN-1] of BYTE;			// 告警输入状态 0-无告警 1-有告警
	abyAlarmOutState: array[0..NVR_MAX_ALARMOUT-1]of BYTE;		// 告警输出状态 0-无输出 1-有输出
  end;

  
// 设备通道ID
  LPTNVR_DEVCHNID = ^TNVR_DEVCHNID;
  TNVR_DEVCHNID = record
	byDevID: BYTE;		// 设备号，编码器或解码器。(1~256)
	byChnID: BYTE;		// 设备通道号。(0~1)
	byReserved: BYTE;	// 字节对齐，留用，可以用于表达特定信息
	byReservedEx: BYTE;	// 字节对齐，留用，可以用于表达特定信息
  end;


//DVS通道状态
  LPTNVR_DEVCHNSTATE = ^TNVR_DEVCHNSTATE;
  TNVR_DEVCHNSTATE = record
	byDspWorkState: BYTE;      // DSP工作状态 0-DSP无响应 1-DSP工作正常
        byVideoInPortState: BYTE;  // 视频源状态 0-视频源丢失 1-视频源连接正常
	byRecordLocal: BYTE;       // 前端录像状态 0-不录 1-正在本地录
	byRecordNvr: BYTE;         // 在Nvr上录像状态 值为EmTaskState
	bySendVideo: BYTE;         // 发送视频 0-不发 1-发
	bySendSecondVideo: BYTE;   // 发送第二路视频 0-不发 1-发
	bySendAudio: BYTE;         // 发送音频 0-不发 1-发
	byRecvVideo: BYTE;         // 接收视频 0-不收 1-收
	byRecvAudio: BYTE;         // 接收音频 0-不收 1-收
	byAudioVolume: BYTE;       // 音量(采集\解码音量)
	byVideoBitrate: DWORD;      // 视频码率(单位Kbps)
	bySecondVideoBitrate: DWORD;// 第二路视频码率(单位Kbps)
  end;

  // 编码通道信息
  LPTNVR_ENCCHNINFO = ^TNVR_ENCCHNINFO;
  TNVR_ENCCHNINFO = Record
	byDevID: BYTE;			// 编码器/解码器ID
	byChnID: BYTE;			// 编码器/解码器通道ID
	byVideoType: BYTE;		// 视频信道类型：VIDEO_H261等
	byAudioType: BYTE;		// 音频信道类型：AUDIO_G711A等
	byResolution: BYTE;      // 第一路视频信道的分辩率
	bySecondResolution: BYTE;// 第二路视频信道的分辩率
	wBitrate: WORD;          // 信道流量(单位:Kbps,1K=1024)
	wSecondBitrate: WORD;    // 第二路信道流量(单位:Kbps,1K=1024)
	byVideoInPortIndex: BYTE;// 当前连接视频源编号
	byTransferNum: BYTE;	    // 第一路视频信道使用的直传路数
	bySecondTransferNum: BYTE;// 第二路视频信道使用的直传路数
	byReserved: BYTE;		// 保留
	achChnAlias: array[0..NVR_LEN_NAME-1] of CHAR;   // 通道别名
  end;

  
// 解码通道信息
  LPTNVR_DECCHNINFO = ^TNVR_DECCHNINFO;
  TNVR_DECCHNINFO = record
	byVideoType: BYTE;				// 视频解码格式
	byDispStyleAtNoVideo: BYTE;	    // 无码流情况下的屏幕显示
	byOutputType: BYTE;			    // 视频输出接口类型  注：需重启生效
	byPostPrcLvl: BYTE;			    // 后处理级别
	byFrequency: BYTE;				// VGA刷新频率       注：需重启生效
	byPlayerBufNum: BYTE;		    // 播放缓冲区数 6-50
	byPlayerStartBufNum: BYTE;		// 播放起始缓冲区号 0-10
	byReserved: BYTE;                // 保留
  end;

  LPTNVR_RTSPINFO = ^TNVR_RTSPINFO;
  TNVR_RTSPINFO = record
	byUseDns: BYTE;                   // 0:不使用， 1：使用
	szDns: array[0..NVR_LEN_DDNS_USERNAME+1 -1] of CHAR;
	szUrl: array[0..NVR_LEN_URL+1 - 1] of CHAR;
  end;

  //ONVIF设备鉴权信息
  LPTNVR_ONVIFINFO = ^TNVR_ONVIFINFO;
  TNVR_ONVIFINFO = record
	byUserName: array[0..NVR_LEN_NAME+1 - 1] of BYTE;
	byPassWd: array[0..NVR_LEN_NAME+1 - 1] of BYTE;
  end;

  // 修改时所用的设备IP信息
  LPTNVR_DEVIPINFO= ^TNVR_DEV_IPINFO;
  TNVR_DEV_IPINFO = record
	bModifyDevIP: BOOL;					 //是否修改设备IP信息
	dwGroupIp: DWORD;                     //组播IP 网络序 inet_addr("224.16.32.1")
	wPort: WORD;                         //当前port 默认端口 5510
	dwOldIp: DWORD;                       //旧设置ip
	dwNewIp: DWORD;                       //新设置ip
	dwNewMask: DWORD;                     //新掩码
	dwNewGW: DWORD;                       //新网关
	bModifyDevRegisterIP: Boolean;		     //是否修改设备注册地址IP信息
	dwRegisterIP: DWORD;                  //设备的注册IP
        abyGUID: array[0..NVR_LEN_GUID-1] of BYTE;		 // 产品GUID
  end;

  LPTNVR_AUDIOINFO = ^TNVR_AUDIOINFO;
  TNVR_AUDIOINFO = record
    byCallMode: BYTE;     //0-空闲，1-呼叫，2-广播
    byListenStatus: BYTE; //0-无音频，1-有音频
    byCallMute: BYTE;     //呼叫静音，0-非静音，1-静音
    byListenMute: BYTE;   //监听静音，0-非静音，1-静音
    byVolumeIn: BYTE;     //输入音量（0~255）
    byVolumeOut: BYTE;    //输出音量（0~255）
  end;

//  procedure NVRPFRAMECALLBACK(pFrmHdr: LPTNVR_FRAMEHDR; dwParam: DWORD); stdcall; external KDNvrSdkDll name 'NVRPFRAMECALLBACK';
//
//typedef void (CALLBACK *NVRPFRAMECALLBACK)(LPTNVR_FRAMEHDR pFrmHdr, DWORD dwParam);
//////////////////////////////////////////////////////////////////////////
// 接口声明
//////////////////////////////////////////////////////////////////////////


//函数名      : PNVRMSGCALLBACK
//功能        : NVRSDK回调函数，用于接口异步消息，例如连接通知，返回搜索结果等
//输入参数说明: wMessage：消息ID，指NVR_MSG_开头的消息，
//              byNVRID：NVRID，通过NVR_NewNVRID()分配获得的NVRID。
//			  wErrorCode：错误代码，范围为NVR_ERR_开头的错误代码
//			  wContextLen：指示pContext内容区的数据量，当wContextLen为0时，
//			      pContext表示为DWORD值，当wContextLen长度大于0时，pContext
//				  为数据指针。
//			  pContext：内容信息，不同消息不同解析，请参考NVR_MSG_消息说明
//			  dwSender：当dwSender为0时，表示消息为NVR主动消息，当dwSender不为
//			      0时，dwSender为异步接口传入的发送者标记，对于所有异步接口都有
//				  dwSender参数。
//返回值说明  : [BOOL] 若操作成功，则返回TRUE；否则返回FALSE。

//typedef void (CALLBACK *PNVRMSGCALLBACK)(WORD wMessage,
//                                         BYTE byNVRID,
//                                         WORD wErrorCode,
//                                         WORD wContextLen,
//                                         char* pContext,
//                                         DWORD dwSender);
   PNVRMSGCALLBACK = ^TNVRMSGCALLBACK;
   TNVRMSGCALLBACK=procedure(wMessage: WORD; byNVRID: BYTE; wErrorCode: WORD; wContextLen: Word; pContext: PChar; dwSender: DWORD) of object; stdcall;


  PNVRPFRAMECALLBACK=^TNVRPFRAMECALLBACK;
  TNVRPFRAMECALLBACK=procedure(pFrmHdr:LPTNVR_FRAMEHDR;dwParam:DWORD)of object; stdcall;



// [SDK版本信息]
// 发布版本号，与最新的NVR同步
function NVR_GetSDKVersion(): DWORD; stdcall; external KDNvrSdkDll index 168;

// 编译版本号，自动编译版时生成
function NVR_GetSDKBuildVersion(): DWORD; stdcall; external KDNvrSdkDll index 167;

// [初始化]
function NVR_Init(wLocalStreamPort: WORD; wTelnetPort: Word; bOpenTelnet: Boolean): Boolean; stdcall; external KDNvrSdkDll index 178;

function NVR_Cleanup(): Boolean; stdcall; external KDNvrSdkDll index 91;

function NVR_SetMessageCallBack(fMessageCallBack: PNVRMSGCALLBACK): Boolean; stdcall; external KDNvrSdkDll index 218;

// NVRSDK系统错误代码，对于所有返回BOOL的函数都可以使用此函数获取详细的错误信息
function NVR_GetLastError(): DWORD; stdcall; external KDNvrSdkDll index 141;

// [连接NVR]
// 设定连接的超时时间和重试次数，建议：dwWatiTime为5000，dwTryTimes为10
function NVR_SetConnectTime(dwWaitTime: DWORD; dwTryTimes: DWORD): Boolean; stdcall; external KDNvrSdkDll index 214;

// 分配NVRID
function NVR_NewNVRID(): Byte; stdcall; external KDNvrSdkDll index 189;

// 释放NVRID
function NVR_FreeNVRID(): Boolean; stdcall; external KDNvrSdkDll index 117;

// 获取NVR状态，返回NVR_STATE_
function NVR_GetNVRState(byNVRID: BYTE; pnNVRState: LPInt): Boolean; stdcall; external KDNvrSdkDll index 146;

// 连接NVR，异步接口，连接结果通过NVR_WM_CONNECTNVR消息上传，lpszNVRAddr可以是IP字符串或URL，
function NVR_Connect(byNVRID: BYTE; lpszNVRAddr: LPCSTR;wNVRPort: Word;lpszUserName: LPCSTR;lpszPassword:LPCSTR; bRemoteConnect: Boolean;
                     lpSocks5Info: LPTNVR_SOCKS5INFO;dwSender: DWORD): Boolean; stdcall; external KDNvrSdkDll index 92;

function NVR_ConnectEx(byNVRID: BYTE; lpszNVRAddr: LPCSTR;wNVRPort: Word;lpszUserName: LPCSTR;lpszPassword:LPCSTR; bRemoteConnect: Boolean;
                     dwSender: DWORD): Boolean; stdcall; external KDNvrSdkDll index 93;

function NVR_Disconnect(byNVRID: Byte): Boolean; stdcall; external KDNvrSdkDll index 114;

// 测试是否是存在的NVRID
function NVR_IsValidNVR(byNVRID: Byte): Boolean; stdcall; external KDNvrSdkDll index 179;

// 获取NVR连接信息
function NVR_GetConnectInfo(byNVRID: Byte; lptConnectInfo: LPTNVR_CONNECTINFO): Boolean; stdcall; external KDNvrSdkDll index 120;

// 获取NVR版本号和产品型号
function NVR_GetNVRVersion(byNVRID: Byte; pwNvrVersion: LPWORD; pbyNvrType:LPBYTE ): Boolean; stdcall; external KDNvrSdkDll index 149;

// [设备管理]
// 获取NVR接入编码器的能力——最大数量
function NVR_GetEncCaps(byNVRID: Byte ): Byte; stdcall; external KDNvrSdkDll index 134;

// 获取NVR接入解码器的能力——最大数量
function NVR_GetDecCaps(byNVRID: Byte ): Byte; stdcall; external KDNvrSdkDll index 125;

//// 获取编码器/编码器通道的数量
function NVR_GetEncCount(byNVRID: Byte ): Byte; stdcall; external KDNvrSdkDll index 138;
function NVR_GetEncChnCount(byNVRID: Byte ): Byte; stdcall; external KDNvrSdkDll index 135;

// 获取解码器的数量
function NVR_GetDecCount(byNVRID: Byte ): Byte; stdcall; external KDNvrSdkDll index 127;

// 获取一个编码器、解码器的信息
function NVR_GetDevInfo(byNVRID: Byte; byDevID: Byte; lptDevInfo: LPTNVR_DEVINFO ): Byte; stdcall; external KDNvrSdkDll index 131;

// 获取编码器/解码器id号
function NVR_GetEncId(byNVRID: Byte; pbyEncId: PUCHAR; nEncTableIndex: Integer ): Byte; stdcall; external KDNvrSdkDll index 139;
function NVR_GetDecId(byNVRID: Byte; pbyDecId: PUCHAR; nDecTableIndex: Integer ): Byte; stdcall; external KDNvrSdkDll index 128;

// 获取一个编码器、解码器的状态
function NVR_GetDevState(byNVRID: Byte; byDevID: BYTE; lptDevState: LPTNVR_DEVSTATE ): Boolean; stdcall; external KDNvrSdkDll index 132;

// 获取一个编码器或解码器的一个通道的状态
function NVR_GetDevChnState(byNVRID: Byte; tDevChnID: TNVR_DEVCHNID; lptChnState: LPTNVR_DEVCHNSTATE ): Boolean; stdcall; external KDNvrSdkDll index 130;

// 获取编码通道的信息
function NVR_GetEncChnInfo(byNVRID: Byte; tDevChnID: TNVR_DEVCHNID; lptEncChnInfo: LPTNVR_ENCCHNINFO ): Boolean; stdcall; external KDNvrSdkDll index 136;

function NVR_GetEncChnInfoByIndex(byNVRID: Byte; byTableIndex: BYTE; lptEncChnInfo: LPTNVR_ENCCHNINFO ): Boolean; stdcall; external KDNvrSdkDll index 137;

// 获取解码通道的信息
function NVR_GetDecChnInfo(byNVRID: Byte; tDevChnID: TNVR_DEVCHNID; lptDecChnInfo: LPTNVR_DECCHNINFO ): Boolean; stdcall; external KDNvrSdkDll index 126;

// 搜索所有设备信息
function NVR_SearchDevice(byNVRID: Byte; dwIp: DWORD; wPort: WORD ): Boolean; stdcall; external KDNvrSdkDll index 208;

////搜索ONVIF设备
function NVR_SearchONVIFDevice(byNVRID: Byte; dwIp: DWORD; dwSearchIp: DWORD; wSearchPort: WORD ): Boolean; stdcall; external KDNvrSdkDll index 210;

//// 添加设备
function NVR_AddDevice(byNVRID: Byte; lptInfo: LPTNVR_DEVINFO): Boolean; stdcall; external KDNvrSdkDll index 82;

function NVR_AddDeviceEx(byNVRID: Byte; lptInfo: LPTNVR_DEVINFO): Boolean; stdcall; external KDNvrSdkDll index 83;   //外厂商设备

function NVR_AddRTSPDevice(byNVRID: Byte; lptInfo: LPTNVR_DEVINFO; lptRtspInfo: LPTNVR_RTSPINFO): Boolean; stdcall; external KDNvrSdkDll index 87;  //RTSP设备

function NVR_AddONVIFDevice(byNVRID: Byte; lptInfo: LPTNVR_DEVINFO; lptONVIFInfo: LPTNVR_ONVIFINFO; bDVS: Boolean): Boolean; stdcall; external KDNvrSdkDll index 85;  //RTSP设备

// 删除设备
function NVR_DeleteDevice(byNVRID: Byte; byDevID: BYTE): Boolean; stdcall; external KDNvrSdkDll index 104;

//// 修改设备IP信息和修改设备注册IP信息
function NVR_ModifyDeviceIP(byNVRID: Byte; ptDevIPInfo: LPTNVR_DEVIPINFO): Boolean; stdcall; external KDNvrSdkDll index 185;

// 得到搜索的设备的列表数目
function NVR_GetSearchListNumber(byNVRID: Byte; pwNum: LPWORD): Boolean; stdcall; external KDNvrSdkDll index 171;

// 得到搜索的设备信息(根据序号)
function NVR_GetSearchDeviceInfoByNum(byNVRID: Byte; wNum: WORD;lptInfo: LPTNVR_DEVINFO ): Boolean; stdcall; external KDNvrSdkDll index 170;

// 得到搜索的设备信息(根据设备ID)
function NVR_GetSearchDeviceInfoByDvsId(byNVRID: Byte; byDvsId: BYTE;lptInfo: LPTNVR_DEVINFO ): Boolean; stdcall; external KDNvrSdkDll index 169;

// 视频浏览
function NVR_CreateMonitor(byNVRID: Byte; tDevChnID: TNVR_DEVCHNID;byFlowIndex: BYTE; hPlayWnd: HWND; bDec: Boolean=True): THandle; stdcall; external KDNvrSdkDll index 95;

function NVR_ChangeMonitorPlayWnd(hMonitor: THandle; hPlayWnd: HWND): Boolean; stdcall; external KDNvrSdkDll index 88;

function NVR_SwitchMonitor(hMonitor: THandle; byNVRID: BYTE; tDevChnID: TNVR_DEVCHNID; byFlowIndex: BYTE): Boolean; stdcall; external KDNvrSdkDll index 240;

function NVR_CtrlMonitor(hMonitor: THandle; dwCtrlCommand: DWORD; byContent: BYTE): Boolean; stdcall; external KDNvrSdkDll index 101;

function NVR_DestroyMonitor(hMonitor: THandle): Boolean; stdcall; external KDNvrSdkDll index 110;

// 获取媒体状态
function NVR_GetAudioStatus(hMonitor: THandle; lptAudioInfo: LPTNVR_AUDIOINFO): Boolean; stdcall; external KDNvrSdkDll index 118;

// 图像抓拍
function NVR_LocalCapture(hMonitor: THandle; lpszPicFileName: LPCTSTR;byPicType: BYTE): Boolean; stdcall; external KDNvrSdkDll index 182;

// PTZ云台控制
function NVR_PTZControl(hMonitor: THandle; dwPTZCommand: DWORD;byStep: BYTE): Boolean; stdcall; external KDNvrSdkDll index 191;

function NVR_PTZControlEx(byNVRID: BYTE; tDevChnID:TNVR_DEVCHNID; dwPTZCommand: DWORD;byStep: BYTE): Boolean; stdcall; external KDNvrSdkDll index 192;

function NVR_TransPTZControl(hMonitor: THandle; lpszPTZCtrlBuf:LPCTSTR; dwBufSize: DWORD): Boolean; stdcall; external KDNvrSdkDll index 242;

function NVR_TransPTZControlEx(byNVRID: BYTE; tDevChnID:TNVR_DEVCHNID; lpszPTZCtrlBuf: LPCTSTR;dwBufSize: DWORD): Boolean; stdcall; external KDNvrSdkDll index 243;
//NVR_API BOOL __stdcall NVR_SetRegFrameCallBack(HANDLE hMonitor, NVRPFRAMECALLBACK fFrameCallBack, DWORD dwParam);
//NVR_API HANDLE __stdcall NVR_CreateMonitorEx(LTNVR_LOCAL_NETPARAM lpVideoNet,

function NVR_SetRegFrameCallBack(hMonitor:THandle; fFrameCallBack:PNVRPFRAMECALLBACK; dwParam:DWORD):Boolean;stdcall; external KDNvrSdkDll index 226;


implementation

end.
