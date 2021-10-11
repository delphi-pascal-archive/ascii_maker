program asciimaker;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frmAsciiMaker},
  Unit2 in 'Unit2.pas' {frmProcess},
  Unit3 in 'Unit3.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'AsciiMaker by NightmareZ';
  Application.CreateForm(TfrmAsciiMaker, frmAsciiMaker);
  Application.CreateForm(TfrmProcess, frmProcess);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;
end.
