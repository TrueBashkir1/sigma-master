unit PrnMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PrnServ, Printers;

type
  TfrmMain = class(TForm)
    btnOpenPreview: TButton;
    btnPrint: TButton;
    btnPrinterSetupDialog: TButton;
    btnPrintDialog: TButton;
    psrMain: TPrintService;
    imlMain: TImageList;
    btnClosePreview: TButton;
    btnUpdatePreview: TButton;
    procedure btnOpenPreviewClick(Sender: TObject);
    procedure btnClosePreviewClick(Sender: TObject);
    procedure btnUpdatePreviewClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnPrinterSetupDialogClick(Sender: TObject);
    procedure psrMainDraw(Sender: TObject; Canvas: TCanvas;
      PageNumber: Integer; DrawTarget: TDrawTarget);
    procedure psrMainPreviewClose(Sender: TObject);
    procedure psrMainPreviewOpen(Sender: TObject);
    procedure psrMainPrint(Sender: TObject);
    procedure psrMainPrinterSetupChange(Sender: TObject);
    procedure btnPrintDialogClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.btnOpenPreviewClick(Sender: TObject);
begin
  psrMain.OpenPreview;
end;

procedure TfrmMain.btnClosePreviewClick(Sender: TObject);
begin
  psrMain.ClosePreview;
end;

procedure TfrmMain.btnUpdatePreviewClick(Sender: TObject);
begin
  psrMain.UpdatePreview;
end;

procedure TfrmMain.btnPrintClick(Sender: TObject);
begin
  psrMain.Print;
end;

procedure TfrmMain.btnPrintDialogClick(Sender: TObject);
begin
  psrMain.PrintDialog;
end;

procedure TfrmMain.btnPrinterSetupDialogClick(Sender: TObject);
begin
  psrMain.PrinterSetupDialog;
end;

procedure TfrmMain.psrMainDraw(Sender: TObject; Canvas: TCanvas;
  PageNumber: Integer; DrawTarget: TDrawTarget);
const
  Text = 'Демонстрация компонента'#13+
    'TPrintService для Delphi 3'#13+
    '© 1997 Дмитрий Васильев'#13+
    'e-mail: silent@paracels.yrh.yar.ru';
var
  PX,PY: Integer;
  R: TRect;
  BMP: TBitmap;
  S: string;
begin
  with Canvas do
  begin
    SetBkMode(Handle,Opaque);
    PX:=Printer.PageWidth div 100;
    PY:=Printer.PageHeight div 100;

    BMP:=TBitmap.Create;
    imlMain.GetBitmap(0,BMP);
    R.Left:=PX*10;
    R.Right:=PX*90;
    R.Top:=PY*10;
    R.Bottom:=PY*10+PX*80*BMP.Height div BMP.Width*
      GetDeviceCaps(Printer.Handle,LOGPIXELSY) div
      GetDeviceCaps(Printer.Handle,LOGPIXELSX);
    StretchDraw(R,BMP);
    BMP.Free;

    Brush.Color:=clSilver;
    Pen.Width:=PX;
    Rectangle(PX*10,PY*70,PX*90,PY*90);

    SetBkMode(Handle,Transparent);
    R.Left:=PX*11;
    R.Right:=Printer.PageWidth-PX*11;
    R.Top:=PY*75;
    R.Bottom:=PY*85;
    Font.Name:='Times New Roman';
    Font.Style:=[fsBold];
    Font.Size:=24;
    Font.Color:=clGray;
    DrawText(Handle,Text,Length(Text),R,dt_CalcRect);
    OffsetRect(R,0,(PY*10-(R.Bottom-R.Top)) div 2);
    R.Right:=Printer.PageWidth-PX*11;
    DrawText(Handle,Text,Length(Text),R,dt_Center or dt_WordBreak);
    OffsetRect(R,-PX div 2,-PX div 2);
    Font.Color:=clBlack;
    DrawText(Handle,Text,Length(Text),R,dt_Center or dt_WordBreak);
    R.Top:=PY*92;
    R.Bottom:=Printer.PageHeight;
    Font.Size:=32;
    S:='Страница №'+IntToStr(PageNumber);
    DrawText(Handle,PChar(S),Length(S),R,dt_Center or dt_WordBreak);
  end;
end;

procedure TfrmMain.psrMainPreviewClose(Sender: TObject);
begin
  MessageDlg('Окно предварительного просмотра сейчас будет закрыто',mtInformation,[mbOK],0);
end;

procedure TfrmMain.psrMainPreviewOpen(Sender: TObject);
begin
  MessageDlg('Окно предварительного просмотра сейчас будет открыто',mtInformation,[mbOK],0);
end;

procedure TfrmMain.psrMainPrint(Sender: TObject);
begin
  MessageDlg('Принтер сейчас начнет печатать',mtInformation,[mbOK],0);
end;

procedure TfrmMain.psrMainPrinterSetupChange(Sender: TObject);
begin
  MessageDlg('Настройки принтера были изменены',mtInformation,[mbOK],0);
end;

end.
