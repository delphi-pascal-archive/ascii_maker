unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls;

type
  TfrmAbout = class(TForm)
    imgME: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblLink: TLabel;
    btnOk: TSpeedButton;
    procedure btnOkClick(Sender: TObject);
    procedure lblLinkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblLinkMouseEnter(Sender: TObject);
    procedure lblLinkMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.btnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  Cursor := crArrow;
  lblLink.Font.Color := clBlue;
  lblLink.Font.Style := [fsUnderline];
end;

procedure TfrmAbout.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Cursor := crArrow;
  lblLink.Font.Color := clBlue;
  lblLink.Font.Style := [fsUnderline];
end;

procedure TfrmAbout.lblLinkClick(Sender: TObject);
begin
  WinExec('explorer.exe http://systemhalt.org', 0);
end;

procedure TfrmAbout.lblLinkMouseEnter(Sender: TObject);
begin
  Cursor := crHandPoint;
  lblLink.Font.Color := clRed;
  lblLink.Font.Style := [];
end;

procedure TfrmAbout.lblLinkMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Cursor := crHandPoint;
  lblLink.Font.Color := clRed;
  lblLink.Font.Style := [];
end;

end.
