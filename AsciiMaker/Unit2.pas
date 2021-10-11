unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons;

type
  TfrmProcess = class(TForm)
    lblConvertion: TLabel;
    pbProgress: TProgressBar;
    lblMashtab: TLabel;
    lblColor: TLabel;
    pnlColor: TShape;
    lblSootn: TLabel;
    btnAbort: TSpeedButton;
    procedure btnAbortClick(Sender: TObject);
  end;

var
  frmProcess: TfrmProcess;

implementation

uses Unit1;

{$R *.dfm}

procedure TfrmProcess.btnAbortClick(Sender: TObject);
begin
  frmAsciiMaker.aborted := True;
end;

end.
