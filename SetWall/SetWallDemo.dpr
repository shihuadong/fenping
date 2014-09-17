program SetWallDemo;

uses
  Forms,
  SetWall in 'SetWall.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
