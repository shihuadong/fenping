unit DrawDib;

interface

uses
  Windows;

// DrawDib flags

const
  DDF_UPDATE =        $0002;           // re-draw the last DIB
  DDF_SAME_HDC =      $0004;           // HDC same as last call (all setup)
  DDF_SAME_DRAW =     $0008;           // draw params are the same
  DDF_DONTDRAW =      $0010;           // dont draw frame, just decompress
  DDF_ANIMATE =       $0020;           // allow palette animation
  DDF_BUFFER =        $0040;           // always buffer image
  DDF_JUSTDRAWIT =    $0080;           // just draw it with GDI
  DDF_FULLSCREEN =    $0100;           // use DisplayDib
  DDF_BACKGROUNDPAL = $0200;           // Realize palette in background
  DDF_NOTKEYFRAME =   $0400;           // this is a partial frame update, hint
  DDF_HURRYUP =       $0800;           // hurry up please!
  DDF_HALFTONE =      $1000;           // always halftone

  DDF_PREROLL =       DDF_DONTDRAW;    // Builing up a non-keyframe
  DDF_SAME_DIB =      DDF_SAME_DRAW;
  DDF_SAME_SIZE =     DDF_SAME_DRAW;

  // display profiling
  PD_CAN_DRAW_DIB      = $0001;      // if you can draw at all
  PD_CAN_STRETCHDIB    = $0002;      // basicly RC_STRETCHDIB
  PD_STRETCHDIB_1_1_OK = $0004;      // is it fast?
  PD_STRETCHDIB_1_2_OK = $0008;
  PD_STRETCHDIB_1_N_OK = $0010;      


type
  hDrawDib = THandle;

  TDrawDibTime = record
    timeCount: LongInt;       // see below
    timeDraw: LongInt;        // time to draw bitmaps
    timeDecompress: LongInt;  // time to decompress bitmaps
    timeDither: LongInt;      // time to dither bitmaps
    timeStretch: LongInt;     // time to stretch bitmaps
    timeBlt: LongInt;         // time to transfer bitmaps (BitBlt)
    timeSetDIBits: LongInt;   // time to transfer bitmaps (SetDIBits)
  end;

function DrawDibBegin(hdd: hDrawDib; hDC: THandle; dxDest, dyDest: Integer;
  var lpbi: TBitmapInfoHeader; dxSrc, dySrc: Integer; wFlags: UInt): Boolean; stdcall;

function DrawDibChangePalette(hdd: hDrawDib; iStart, iLen: Integer;
  var lppe: TPaletteEntry): Boolean; stdcall;

function DrawDibClose(hdd: hDrawDib): Boolean; stdcall;

function DrawDibDraw(hdd: hDrawDib; hDC: THandle; xDst, yDst, dxDst, dyDst: Integer;
  var lpbi: TBitmapInfoHeader; Bits: Pointer; xSrc, ySrc, dxSrc, dySrc: Integer;
  wFlags: UInt): Boolean; stdcall; 

function DrawDibEnd(hdd: hDrawDib): Boolean; stdcall;

function DrawDibGetBuffer(hdd: hDrawDib; var lpbi: TBitmapInfoHeader; 
  dwSize, dwFlags: DWord): Pointer; stdcall;

function DrawDibGetPalette(hdd: hDrawDib): THandle; stdcall;

function DrawDibOpen: hDrawDib; stdcall;

function DrawDibProfileDisplay(var lpbi: TBitmapInfoHeader): Boolean; stdcall;

function DrawDibRealize(hdd: hDrawDib; hDC: THandle; fBackground: Bool): UInt; stdcall;

function DrawDibSetPalette(hdd: hDrawDib; hpal: THandle): Boolean; stdcall;

function DrawDibStart(hdd: hDrawDib; rate: LongInt): Boolean; stdcall;

function DrawDibStop(hdd: hDrawDib): Boolean; stdcall;

function DrawDibTime(hdd: hDrawDib; var lpddtime: TDrawDibTime): Boolean; stdcall;

implementation

const
  DLL = 'MsVfW32.dll';

function DrawDibBegin; external DLL name 'DrawDibBegin';
function DrawDibChangePalette; external DLL name 'DrawDibChangePalette';
function DrawDibClose; external DLL name 'DrawDibClose';
function DrawDibDraw; external DLL name 'DrawDibDraw';
function DrawDibEnd; external DLL name 'DrawDibEnd';
function DrawDibGetBuffer; external DLL name 'DrawDibGetBuffer';
function DrawDibGetPalette; external DLL name 'DrawDibGetPalette';
function DrawDibOpen; external DLL name 'DrawDibOpen';
function DrawDibProfileDisplay; external DLL name 'DrawDibProfileDisplay';
function DrawDibRealize; external DLL name 'DrawDibRealize';
function DrawDibSetPalette; external DLL name 'DrawDibSetPalette';
function DrawDibStart; external DLL name 'DrawDibStart';
function DrawDibStop; external DLL name 'DrawDibStop';
function DrawDibTime; external DLL name 'DrawDibTime';

end.
