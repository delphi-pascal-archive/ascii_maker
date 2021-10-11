unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, XPMan, Buttons, StdCtrls;

type
   TMyRGB = record
    r, g, b: Byte;
  end;

type
  TfrmAsciiMaker = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    bmp1: TMenuItem;
    html1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    btnLoad: TSpeedButton;
    Stylez: TXPManifest;
    btnSave: TSpeedButton;
    pnlMain: TPanel;
    imgView: TImage;
    Memo: TMemo;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N1x1: TMenuItem;
    N2x1: TMenuItem;
    N4x1: TMenuItem;
    N181: TMenuItem;
    ColorDialog: TColorDialog;
    N9: TMenuItem;
    N111: TMenuItem;
    N121: TMenuItem;
    N211: TMenuItem;
    procedure N211Click(Sender: TObject);
    procedure N1x1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
  public
    aborted: Boolean;
  private
    bmp: TBitmap;
    fonColor: TMyRGB;
    mashtab, sootnx, sootny: Integer;
  end;

var
  frmAsciiMaker: TfrmAsciiMaker;

implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TfrmAsciiMaker.FormCreate(Sender: TObject);
begin
  bmp := nil;

  fonColor.r := 0;
  fonColor.g := 0;
  fonColor.b := 0;

  mashtab := 1;

  sootnx := 2;
  sootny := 1;
end;

procedure TfrmAsciiMaker.N1x1Click(Sender: TObject);
begin
  mashtab := (Sender as TMenuItem).Tag;

  N1x1.Checked := False;
  N2x1.Checked := False;
  N4x1.Checked := False;
  N181.Checked := False;

  (Sender as TMenuItem).Checked := True;
end;

procedure TfrmAsciiMaker.N211Click(Sender: TObject);
begin
  N211.Checked := False;
  N111.Checked := False;
  N121.Checked := False;

  (Sender as TMenuItem).Checked := True;
end;

procedure TfrmAsciiMaker.N3Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmAsciiMaker.N5Click(Sender: TObject);
begin
  Beep;
  frmAbout.Left := (Screen.Width - frmAbout.Width) div 2;
  frmAbout.Top := (Screen.Height - frmAbout.Height) div 2;
  frmAbout.ShowModal;
end;

procedure TfrmAsciiMaker.N8Click(Sender: TObject);
begin
  if ColorDialog.Execute
  then
  begin
    fonColor.r := GetRValue(ColorDialog.Color);
    fonColor.g := GetGValue(ColorDialog.Color);
    fonColor.b := GetBValue(ColorDialog.Color);
  end;
end;

procedure TfrmAsciiMaker.btnLoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    imgView.Picture.LoadFromFile(OpenDialog.FileName);
    bmp.Free;
    bmp := TBitmap.Create;
    bmp.LoadFromFile(OpenDialog.FileName);
  end;
end;

procedure TfrmAsciiMaker.btnSaveClick(Sender: TObject);
var
  arr: Array of Array of TMyRGB;
  x, y, i, j, t, len, px, py, sx, sy: Integer;
  s, s1: String;
  pre: TMyRGB;
  f: TextFile;

  function DecToHex(d: Byte): String;
  var
    a, b: Byte;
  begin
    a := d div 16;
    b := d mod 16;

    if a < 10 then
      Result := IntToStr(a)
    else
      Result := Chr(Ord('A') + a - 10);

    if b < 10 then
      Result := Result + IntToStr(b)
    else
      Result := Result + Chr(Ord('A') + b - 10);
end;

  function RGBColor(color: TMyRGB): String;
  begin
    Result := DecToHex(color.r) + DecToHex(color.g) + DecToHex(color.b);
  end;

  procedure DoAbort;
  begin
    SetLength(arr, 0, 0);
    Finalize(arr);
  end;

begin
  if N211.Checked then
  begin
    sootnx := 2;
    sootny := 1;
  end;

  if N111.Checked then
  begin
    sootnx := 1;
    sootny := 1;
  end;

  if N121.Checked then
  begin
    sootnx := 1;
    sootny := 2;
  end;
  
  aborted := False;
  if bmp = nil then
    MessageBox(Handle, 'Сначала нужно загрузить картинку!',
      'Ошибка', MB_OK)
  else
    if SaveDialog.Execute then
    begin
      frmProcess.pbProgress.Position := 0;
      frmProcess.lblConvertion.Caption := 'Преобразование картинки (0%)... подождите.';
      frmProcess.lblMashtab.Caption := 'Масштаб:  1:' + IntToStr(mashtab);
      frmProcess.pnlColor.Brush.Color := RGB(fonColor.r, fonColor.g, fonColor.b);
      frmProcess.lblSootn.Caption := 'Соотношение сторон:  ' + IntToStr(sootnx) + ':' + IntToStr(sootny);
      frmProcess.Left := (Screen.Width - frmProcess.Width) div 2;
      frmProcess.Top := (Screen.Height - frmProcess.Height) div 2;
      frmProcess.Show;
      self.Enabled := False;

      Sleep(50);
      Application.ProcessMessages;

      ///////////////////////////////////////////

      x := bmp.Height;
      y := bmp.Width;
      t := 0;
      s1 := Memo.Text;
      s := '';
      len := Length(s1);

      for i := 1 to len - 1 do
        if Ord(s1[i]) > 32 then
          s := s + s1[i];

      len := Length(s);

      SetLength(arr, x, y);

      if (x > 0) and (y > 0) then
      begin

        for i := 0 to x - 1 do
        begin
          if aborted then
          begin
            DoAbort;
            break;
          end;
          
          for j := 0 to y - 1 do
          begin
            arr[i, j].r := GetRValue(bmp.Canvas.Pixels[j, i]);
            arr[i, j].g := GetGValue(bmp.Canvas.Pixels[j, i]);
            arr[i, j].b := GetBValue(bmp.Canvas.Pixels[j, i]);
          end;
          frmProcess.pbProgress.Position := Trunc((i / x) * 50);
          frmProcess.lblConvertion.Caption := 'Преобразование картинки (' + IntToStr(frmProcess.pbProgress.Position) + '%)... подождите.';
          Sleep(50);
          Application.ProcessMessages;
        end;

        if not aborted then
        begin

        AssignFile(f, SaveDialog.FileName);
        ReWrite(f);
        WriteLn(f, '<html><head><title>Ascii</title></head><body bgcolor="' + RGBColor(fonColor) + '"><pre>');
        pre := arr[0, 0];
        Write(f, '<font color="#' + RGBColor(pre) + '">');

        px := 0;
        py := 0;

        for i := 0 to x - 1 do
        begin
          if aborted then
          begin
            DoAbort;
            break;
          end;
            
          inc(px);
          if px = mashtab then
            for sy := 1 to sootny do
            begin
              if not aborted then
              
              for j := 0 to y - 1 do
              begin
                inc(py);
                if py = mashtab then
                  for sx := 1 to sootnx do
                  begin

                    if (arr[i, j].r <> pre.r) and (arr[i, j].g <> pre.g) and (arr[i, j].b <> pre.b) then
                    begin
                      pre := arr[i, j];
                      Write(f, '</font><font color="' + RGBColor(pre) + '">');
                    end;

                    inc(t);
                    if t >= len then
                      t := 1;
                    Write(f, s[t]);

                    py := 0;
                  end;
              end;
              Write(f, #13#10);
              frmProcess.pbProgress.Position := 50 + Trunc((i / x) * 50);
              frmProcess.lblConvertion.Caption := 'Преобразование картинки (' + IntToStr(frmProcess.pbProgress.Position) + '%).... подождите.';

              if aborted then
              begin
                DoAbort;
                break;
              end;

              Sleep(50);
              Application.ProcessMessages;
              px := 0;
            end;
        end;

        WriteLn(f, '</font></pre></body></html>');
        CloseFile(f);

      end;

      end;

      SetLength(arr, 0, 0);
      Finalize(arr);

      ///////////////////////////////////////////

      Sleep(50);
      Application.ProcessMessages;

      self.Enabled := True;
      frmProcess.Hide;
    end;
end;

end.
