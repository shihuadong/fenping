unit DataUnit;

interface
uses
   Windows,Forms, Classes, ExtCtrls,IdBaseComponent, IdComponent,Dialogs, IdTCPConnection, IdTCPClient, SysUtils, Graphics, jpeg, IdTCPServer;
const
    imgpnlwidth = 243;
    imgpnlheight = 171;
    DVRMaxCount=16;                 //DVR总数
    DecodeChannelMaxCount=64;       //解码通道
    MaxVideoFormCount=9;            //SCreen 总数
    MaxPannelCount=16;              //分屏总数

type
  pCmdInfo=^TCmdInfo;
  TCmdInfo=record
    Cmd: Byte;                       //1 播放 2 设置 0其他
    isUsed:integer;                  //0 没有使用 1已经使用
    DVRType:array[0..15] of Char;
    IP:array[0..14] of Char;
    Port:Integer;
    User:array[0..15] of Char;
    Pass:array[0..15] of Char;
    DVRChannel:integer;
    videoForm:integer;               //第几块屏幕
    FormPos:integer;                 //第几个小窗
    RealplayHWND:Integer;            //播放返回值
    Mode: Byte;                      //处理模式 0新加 1修改
    VideoCount: Integer;
end;


type
  pChannelInfo=^TchannelInfo;
  TChannelInfo=record
  isUsed:integer;//0 没有使用 1已经使用
  DVRType:string;
  IP:string;
  Port:Integer;
  User:string;
  Pass:string;
  DVRChannel:integer;
  videoForm:integer; //第几块屏幕
  FormPos:integer;   //第几个小窗
  RealplayHWND:Integer;  //播放返回值
end;
type
  TDevInfo = record
    DVRName:string;
    DVRType:string;
    IP:string;
    Port:Integer;
    User:string;
    Pass:string;
    LoginID:integer;
    status:integer;//1 login -1 loginout 0 未使用
    channelCount:integer; //DVR总通道数
  end;
implementation

end.
