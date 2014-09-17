unit Monitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,jpeg;

type
  TMonitorForm = class(TForm)
    BackPanel: TPanel;
    Image_TL: TImage;
    PFrame: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }


  public
    { Public declarations }
    VP: array[0..15] of TPanel; //定义16路视频窗口
    Lab: array[0..15] of TLabel;
    Img:array[0..15] of TImage;
    OneX, OneY, OneW, OneH: integer;
    ShowOneWin: Boolean;
    WinCount: Integer;
    FocusID: Integer;
    BackColor, FrameColor: TColor;
    FrameWidth:Integer;
    procedure CreateVideoWindows(); //动态创建16路窗口
    procedure SetWinCount(N: integer); //设置窗口数
    procedure VPClick(Sender: TObject);
    procedure VPDblClick(Sender: TObject);
    procedure VPResize(Sender: TObject);
    procedure VPDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure VPDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure VPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VPMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure VPMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function GetAnIdleWin(): Integer;
    procedure MoveFramePannel(n:Integer);
    
  end;

var
  MonitorForm: TMonitorForm;
implementation

uses Main;

{$R *.dfm}

{ TMonitorForm }

procedure TMonitorForm.CreateVideoWindows;
var i: integer;
begin
  BackPanel.Color:=clWhite;
  BackColor:=clBlack;
//  FrameColor:=clLime;
  FrameColor:=clWhite;
  FocusID:=0;

  for i := Low(VP) to High(VP) do
  begin
    VP[i] := TPanel.Create(nil);
    with VP[i] do
    begin
      Top := 0;
      Left := 0;
      Width := 0;
      Height := 0;
      Align := alNone;
      BevelInner := bvNone;
      BevelOuter := bvNone;
      BorderStyle := bsNone;
      BorderWidth := 1;
      Font.Size := 24;
      Font.Color := clWhite;
      Visible := True;
      Tag := i;
      Locked := False;
      Caption := '';
      Alignment := taCenter;
      Color := BackColor;
      Name := 'VP' + IntToStr(i);
      Parent := BackPanel;
      OnClick := VPClick;
      OnDblClick := VPDblClick;
      OnResize := VPResize;
      OnMouseDown := VPMouseDown;
      OnMouseMove := VPMouseMove;
      OnMouseUp := VPMouseUp;
      OnDragDrop := VPDragDrop;
      OnDragOver := VPDragOver;
    end;
    Lab[i] := TLabel.Create(nil);
    with Lab[i] do
    begin
      Parent := VP[i];
      Align := alTop;
      Font.Size := 9;
      Font.Color := clWhite;
      Visible := True;
      Tag := i;
      Transparent := True;
      Caption :='';
    end;

    Img[i] := TImage.Create(nil);
    with Img[i] do
    begin
      Parent := VP[i];
      Width:=Image_TL.Width;
      Height:=Image_TL.Height;
      Align := alNone;
      Visible := True;
      Tag := i;
//      Transparent := True;
      Stretch:=False;
      Picture:=Image_TL.Picture;
    end;
  end;

end;


function TMonitorForm.GetAnIdleWin: integer;
begin

end;

procedure TMonitorForm.MoveFramePannel(n: Integer);
begin
  //移动背景
//  FocusID := n-1; //设置焦点
  PFrame.Left := VP[n].Left - FrameWidth;
  PFrame.Top := VP[n].Top - FrameWidth;
  PFrame.Width := VP[n].Width + 2 * FrameWidth;
  PFrame.Height := VP[n].Height + 2 * FrameWidth;
  
end;

procedure TMonitorForm.SetWinCount(N: integer);
var
  i: integer;
  w, h: integer;
  modulo: Integer;
begin
  //if WinCount <> N then WinCountChange := True;
  if N=1 then FrameWidth:=0
  else
    FrameWidth:=1;
  WinCount := N;
  ShowOneWin := False;
  case N of
    1: modulo := 1;
    4: modulo := 2;
    9: modulo := 3;
    16: modulo := 4;

  else
    modulo := 1;
  end;
  w := Trunc((BackPanel.Width - 2 * modulo * FrameWidth) / modulo);
  h := Trunc((BackPanel.Height - 2 * modulo * FrameWidth) / modulo);

  PFrame.Width := w + 2 * FrameWidth;
  PFrame.Height := h + 2 * FrameWidth;

  PFrame.Top := 0;
  PFrame.Left := 0;

  PFrame.Color := FrameColor;
  for i := Low(VP) to High(VP) do
    VP[i].Color := BackColor;
    
//重置
  for i := N to High(VP) do
  begin
    VP[i].Visible := False;
  end;

  for i := 0 to N - 1 do
  begin
   // VP[i].BringToFront;
    VP[i].Visible := True;
    VP[i].Width := w;
    VP[i].Height := h;
    //同一行的Y坐标相等
    //同一列的X坐标相等
    if (i mod modulo = 0) then //同一行
    begin
      VP[i].Left := FrameWidth;
      if i = 0 then VP[i].Top := FrameWidth
      else
        VP[i].Top := VP[i - modulo].Top + h + FrameWidth;

    end
    else //同一列
    begin
      VP[i].Left := VP[i - 1].Left + w + FrameWidth;
      VP[i].Top := VP[i - 1].Top;

    end;

    Img[i].Top:=(VP[i].Height-Image_TL.Height) div 2;
    Img[i].Left:=(VP[i].Width-Image_TL.Width) div 2;

  end;



end;



procedure TMonitorForm.VPClick(Sender: TObject);
begin

end;

procedure TMonitorForm.VPDblClick(Sender: TObject);
var i: integer;
begin

  i := (Sender as TPanel).Tag;

  if not ShowOneWin then
  begin
    OneX := VP[i].Left;
    OneY := VP[i].Top;
    OneW := VP[i].Width;
    OneH := VP[i].Height;

    VP[i].Left := FrameWidth;
    VP[i].Top := FrameWidth;
  //单屏最大
    VP[i].Width := BackPanel.Width - 2 * FrameWidth;
    VP[i].Height := BackPanel.Height - 2 * FrameWidth;

    VP[i].BringToFront;
    VP[i].Repaint;
    ShowOneWin := True
  end
  else
  begin

    VP[i].Width := OneW;
    VP[i].Height := OneH;

    VP[i].Left := OneX;
    VP[i].Top := OneY;
    VP[i].Repaint;
    ShowOneWin := False;

  end;

    Img[i].Top:=(VP[i].Height-Image_TL.Height) div 2;
    Img[i].Left:=(VP[i].Width-Image_TL.Width) div 2;

end;


procedure TMonitorForm.VPDragDrop(Sender, Source: TObject; X, Y: Integer);
begin

end;

procedure TMonitorForm.VPDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;

procedure TMonitorForm.VPMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: integer;
begin
  //移动背景
  i := (Sender as TPanel).Tag;
  FocusID := i; //设置焦点
  PFrame.Left := VP[i].Left - FrameWidth;
  PFrame.Top := VP[i].Top - FrameWidth;
  PFrame.Width := VP[i].Width + 2 * FrameWidth;
  PFrame.Height := VP[i].Height + 2 * FrameWidth;
end;

procedure TMonitorForm.VPMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

end;

procedure TMonitorForm.VPMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TMonitorForm.VPResize(Sender: TObject);
begin

end;

procedure TMonitorForm.FormCreate(Sender: TObject);
begin
  KeyPreview:=True;
  CreateVideoWindows;
  SetWinCount(1);
end;


procedure TMonitorForm.FormResize(Sender: TObject);
begin
  SetWinCount(WinCount);
end;

procedure TMonitorForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then isShowMainForm:=not isShowMainForm;

  if isShowMainForm then
  begin
    Self.SendToBack;
  end
  else
  begin
    Self.BringToFront;
  end;
end;

end.
