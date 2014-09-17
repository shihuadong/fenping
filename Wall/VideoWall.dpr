program VideoWall;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Monitor in 'Monitor.pas' {MonitorForm},
  DataUnit in 'DataUnit.pas',
  DHNetSDKUnit in 'DHNetSDKUnit.pas',
  HCNetSDKUnit in 'HCNetSDKUnit.pas',
  MultInst in 'MultInst.pas',
  ping in 'ping.pas',
  PlayCtrl in 'PlayCtrl.pas',
  DecodeThreadUnit in 'DecodeThreadUnit.pas',
  KDNvrSdkUnit in 'KDNvrSdkUnit.pas',
  GraphDVR in 'GraphDVR.pas',
  dhPlay in 'dhplay.pas',
  play264DLLunit in 'play264DLLunit.pas',
  CpuUnit in 'CpuUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
