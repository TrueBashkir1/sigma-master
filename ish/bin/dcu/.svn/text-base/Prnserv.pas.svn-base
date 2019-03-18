unit PrnServ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, ToolWin, Menus, StdCtrls, Printers, ImgList;

type

  TDrawPanel=class(TPanel)
  public
    constructor Create(AOwner: TComponent); override;
    procedure Paint; override;
    property Canvas;
  end;

  TDrawTarget = (dtPreview,dtPrint);

  TViewMode = (vm200,vm150,vm100,vm75,vm50,vm25,vm10,vmPageWidth,vmFullPage);

  TDrawEvent = procedure (Sender: TObject; Canvas: TCanvas; PageNumber: Integer;
    DrawTarget: TDrawTarget) of object;

  TPrintService = class;

  TPreviewForm = class(TForm)
    pmnScale: TPopupMenu;
    mni200: TMenuItem;
    mni150: TMenuItem;
    mni100: TMenuItem;
    mni75: TMenuItem;
    mni50: TMenuItem;
    mni25: TMenuItem;
    mni10: TMenuItem;
    mniWidth: TMenuItem;
    mniFull: TMenuItem;
    sbxMain: TScrollBox;
    tbrMain: TToolBar;
    imlMain: TImageList;
    tbtPrint: TToolButton;
    tbtPrintDialog: TToolButton;
    pnlShadow: TPanel;
    tbtPrinterSetupDialog: TToolButton;
    tbtScale: TToolButton;
    tbtPrevPage: TToolButton;
    tbtNextPage: TToolButton;
    stbMain: TStatusBar;
    procedure mniScaleClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tbtPrintDialogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtPrintClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbtPrinterSetupDialogClick(Sender: TObject);
    procedure tbtPrevPageClick(Sender: TObject);
    procedure tbtNextPageClick(Sender: TObject);
  private
    { Private declarations }
    FPrintService: TPrintService;
    FDrawPanel: TDrawPanel;
    FViewMode: TViewMode;
    FPageCount: Integer;
    FPageIndex: Integer;
    procedure SetViewMode(Value: TViewMode);
    procedure SetPageCount(Value: Integer);
    procedure SetPageIndex(Value: Integer);
    procedure WMGetMinMaxInfo(var Msg: TMessage); message wm_GetMinMaxInfo;
  private
    { Private declarations }
    procedure UpdatePageSetup;
    procedure UpdatePreview;
    property PrintService: TPrintService read FPrintService write FPrintService;
    property PageCount: Integer read FPageCount write SetPageCount;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    property ViewMode: TViewMode read FViewMode write SetViewMode;
    property PageIndex: Integer read FPageIndex write SetPageIndex;
  end;

  TPrintService = class(TComponent)
  private
    { Private declarations }
    FOnCreate: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    FOnDraw: TDrawEvent;
    FOnPrinterSetupChange: TNotifyEvent;
    FOnPrint: TNotifyEvent;
    FOnPreviewOpen: TNotifyEvent;
    FOnPreviewClose: TNotifyEvent;
    FPreviewer: TPreviewForm;
    FPageCount: Integer;
    FPreviewerCaption: string;
    procedure SetPreviewer(Value: TPreviewForm);
    procedure SetPageCount(Value: Integer);
    procedure SetPreviewerCaption(Value: string);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OpenPreview;
    procedure ClosePreview;
    procedure Print;
    procedure PrintDialog;
    procedure PrinterSetupDialog;
    procedure UpdatePreview;
    property Previewer: TPreviewForm read FPreviewer write SetPreviewer;
  published
    { Published declarations }
    property PageCount: Integer read FPageCount write SetPageCount;
    property PreviewerCaption: string read FPreviewerCaption write SetPreviewerCaption;
    property OnCreate: TNotifyEvent read FOnCreate write FOnCreate;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnDraw: TDrawEvent read FOnDraw write FOnDraw;
    property OnPrinterSetupChange: TNotifyEvent read FOnPrinterSetupChange write FOnPrinterSetupChange;
    property OnPrint: TNotifyEvent read FOnPrint write FOnPrint;
    property OnPreviewOpen: TNotifyEvent read FOnPreviewOpen write FOnPreviewOpen;
    property OnPreviewClose: TNotifyEvent read FOnPreviewClose write FOnPreviewClose;
  end;

procedure Register;

implementation

{$R *.DFM}

constructor TDrawPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color:=clWhite;
  Visible:=False;
end;

procedure TDrawPanel.Paint;
begin
  with Canvas do
  begin
    SetMapMode(Canvas.Handle,mm_AnIsotropic);
    SetWindowExtEx(Canvas.Handle,Printer.PageWidth,Printer.PageHeight,nil);
    SetViewportExtEx(Canvas.Handle,Width,Height,nil);
    SetViewportOrgEx(Canvas.Handle,0,0,nil);
    Brush.Color:=clWhite;
    Brush.Style:=bsSolid;
    FillRect(ClientRect);
    Font.PixelsPerInch:=GetDeviceCaps(Printer.Handle,LOGPIXELSX);
    if Font.PixelsPerInch>GetDeviceCaps(Printer.Handle,LOGPIXELSY) then
      Font.PixelsPerInch:=GetDeviceCaps(Printer.Handle,LOGPIXELSY);
    with TPreviewForm(Owner),PrintService do
      if Assigned(PrintService) and
        Assigned(OnDraw) then
          OnDraw(PrintService,Self.Canvas,PageIndex,dtPreview);
  end;
end;

constructor TPreviewForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  imlMain.GetIcon(6,Icon);
  FViewMode:=vmFullPage;
  FPageCount:=1;
  FPageIndex:=1;
  FDrawPanel:=TDrawPanel.Create(Self);
  with FDrawPanel do
  begin
    Parent:=sbxMain;
    BorderStyle:=bsSingle;
    Ctl3D:=False;
    Left:=8;
    Top:=8;
  end;
end;

procedure TPreviewForm.UpdatePageSetup;
var
  Scaling: Integer;
begin
  pnlShadow.Visible:=False;
  with FDrawPanel,Printer do
  begin
    Visible:=False;
    case FViewMode of
      vm200: Scaling:=200;
      vm150: Scaling:=150;
      vm100: Scaling:=100;
      vm75: Scaling:=75;
      vm50: Scaling:=50;
      vm25: Scaling:=25;
      vm10: Scaling:=10;
      vmPageWidth: // по ширине страницы
      begin
        with sbxMain do
        begin
          VertScrollBar.Position:=0;
          HorzScrollBar.Position:=0;
        end;
        Scaling:=1;
        Left:=8;
        Top:=8;
        Width:=sbxMain.Width-20-GetSystemMetrics(sm_CXVScroll);
        Height:=Width*GetDeviceCaps(Printer.Handle,VertSize) div
          GetDeviceCaps(Printer.Handle,HorzSize);
        with sbxMain do
        begin
          VertScrollBar.Range:=FDrawPanel.Height+16;
          HorzScrollBar.Range:=0;
        end;
      end;
      vmFullPage: // страница целиком
      begin
        Scaling:=1;
        with sbxMain do
        begin
          VertScrollBar.Range:=0;
          HorzScrollBar.Range:=0;
          VertScrollBar.Position:=0;
          HorzScrollBar.Position:=0;
        end;
        Height:=sbxMain.ClientHeight-16;
        Width:=Height*GetDeviceCaps(Printer.Handle,HorzSize) div
          GetDeviceCaps(Printer.Handle,VertSize);
        if Width>sbxMain.ClientWidth-16 then
        begin
          Width:=sbxMain.ClientWidth-16;
          Height:=Width*GetDeviceCaps(Printer.Handle,VertSize) div
            GetDeviceCaps(Printer.Handle,HorzSize);
        end;
        Left:=(sbxMain.ClientWidth-Width) div 2;
        Top:=(sbxMain.ClientHeight-Height) div 2;
      end;
    else Scaling:=1;
    end;
    case FViewMode of
      vm200..vm10:
      begin
        with sbxMain do
        begin
          VertScrollBar.Position:=0;
          HorzScrollBar.Position:=0;
        end;
        Left:=8;
        Top:=8;
        Width:=Scaling*PageWidth*PixelsPerInch div
          GetDeviceCaps(Printer.Handle,LOGPIXELSX) div 100;
        Height:=Width*GetDeviceCaps(Printer.Handle,VertSize) div
          GetDeviceCaps(Printer.Handle,HorzSize);
        with sbxMain do
        begin
          VertScrollBar.Range:=FDrawPanel.Height+16;
          HorzScrollBar.Range:=FDrawPanel.Width+16;
        end;
      end;
    end;
    Visible:=True;
  end;
  with pnlShadow do
  begin
    Left:=FDrawPanel.Left+4;
    Top:=FDrawPanel.Top+4;
    Width:=FDrawPanel.Width;
    Height:=FDrawPanel.Height;
    Visible:=True;
  end;
end;

procedure TPreviewForm.UpdatePreview;
begin
  with FDrawPanel do
  begin
    Hide;
    Show;
  end;
end;

procedure TPreviewForm.SetViewMode(Value: TViewMode);
begin
  if Value<>FViewMode then
  begin
    FViewMode:=Value;
    case FViewMode of
      vm200: mni200.Checked:=True;
      vm150: mni150.Checked:=True;
      vm100: mni100.Checked:=True;
      vm75: mni75.Checked:=True;
      vm50: mni50.Checked:=True;
      vm25: mni25.Checked:=True;
      vm10: mni10.Checked:=True;
      vmPageWidth: mniWidth.Checked:=True;
      vmFullPage: mniFull.Checked:=True;
    end;
    UpdatePageSetup;
  end;
end;

procedure TPreviewForm.SetPageCount(Value: Integer);
begin
  if Value<1 then Value:=1;
  if Value<>PageCount then FPageCount:=Value;
  if PageIndex>PageCount then PageIndex:=PageCount;
  if (PageCount>1) and not stbMain.Visible then Height:=Height+stbMain.Height
  else
    if (PageCount=1) and stbMain.Visible then Height:=Height-stbMain.Height;
  tbtPrevPage.Visible:=PageCount>1;
  tbtNextPage.Visible:=PageCount>1;
  stbMain.Visible:=PageCount>1;
  tbtPrevPage.Enabled:=PageIndex>1;
  tbtNextPage.Enabled:=PageIndex<PageCount;
  stbMain.SimpleText:='Страница '+IntToStr(PageIndex)+' из '+IntToStr(PageCount);
  UpdatePageSetup;
end;

procedure TPreviewForm.SetPageIndex(Value: Integer);
begin
  if Value<1 then Value:=1;
  if Value>PageCount then Value:=PageCount;
  if Value<>FPageIndex then
  begin
    FPageIndex:=Value;
    tbtPrevPage.Enabled:=PageIndex>1;
    tbtNextPage.Enabled:=PageIndex<PageCount;
    stbMain.SimpleText:='Страница '+IntToStr(PageIndex)+' из '+IntToStr(PageCount);
    with sbxMain do
    begin
      VertScrollBar.Position:=0;
      HorzScrollBar.Position:=0;
    end;
    UpdatePreview;
  end;
end;

procedure TPreviewForm.FormResize(Sender: TObject);
begin
  UpdatePageSetup;
end;

procedure TPreviewForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(PrintService) then PrintService.Previewer:=nil;
end;

procedure TPreviewForm.mniScaleClick(Sender: TObject);
begin
  with Sender as TMenuItem do
  begin
    Checked:=True;
    FViewMode:=TViewMode(Tag);
    UpdatePageSetup;
  end;
end;

procedure TPreviewForm.tbtPrintDialogClick(Sender: TObject);
begin
  if Assigned(PrintService) then PrintService.PrintDialog;
end;

procedure TPreviewForm.tbtPrinterSetupDialogClick(Sender: TObject);
begin
  if Assigned(PrintService) then PrintService.PrinterSetupDialog;
end;

procedure TPreviewForm.tbtPrintClick(Sender: TObject);
begin
  if Assigned(PrintService) then PrintService.Print;
end;

procedure TPreviewForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with sbxMain do
  begin
    with VertScrollBar do
      case Key of
        vk_Up: Position:=Position-Increment;
        vk_Down: Position:=Position+Increment;
        vk_Prior:
          if ssCtrl in Shift then Position:=0
          else Position:=Position-ClientHeight+Increment;
        vk_Next:
          if ssCtrl in Shift then Position:=Range
          else Position:=Position+ClientHeight-Increment;
      end;
    with HorzScrollBar do
      case Key of
        vk_Left:
          if ssCtrl in Shift then Position:=Position-ClientWidth+Increment
          else Position:=Position-Increment;
        vk_Right:
          if ssCtrl in Shift then Position:=Position+ClientWidth-Increment
          else Position:=Position+Increment;
        vk_Home:
          if ssCtrl in Shift then
          begin
            Position:=0;
            VertScrollBar.Position:=0;
          end
          else Position:=0;
        vk_End:
          if ssCtrl in Shift then
          begin
            Position:=Range;
            VertScrollBar.Position:=VertScrollBar.Range;
          end
          else Position:=Range;
      end;
  end;
end;

procedure TPreviewForm.tbtPrevPageClick(Sender: TObject);
begin
  PageIndex:=Pred(PageIndex);
end;

procedure TPreviewForm.tbtNextPageClick(Sender: TObject);
begin
  PageIndex:=Succ(PageIndex);
end;

procedure TPreviewForm.WMGetMinMaxInfo(var Msg: TMessage);
begin
  inherited;
  with PMinMaxInfo(Msg.lParam)^.ptMinTrackSize do
  begin
    X:=164;
    Y:=277;
  end;
end;

constructor TPrintService.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPageCount:=1;
  FPreviewerCaption:='Предварительный просмотр';
  try
    if Assigned(FOnCreate) then FOnCreate(Self);
  except
    Application.HandleException(Self);
  end;
end;

destructor TPrintService.Destroy;
begin
  try
    if Assigned(FOnDestroy) then FOnDestroy(Self);
  except
    Application.HandleException(Self);
  end;
  inherited Destroy;
end;

procedure TPrintService.OpenPreview;
begin
  if FPreviewer=nil then
  begin
    FPreviewer:=TPreviewForm.Create(Owner);
    with FPreviewer do
    begin
      PrintService:=Self;
      PageCount:=Self.PageCount;
      Caption:=PreviewerCaption;
      if Assigned(FOnPreviewOpen) then FOnPreviewOpen(Self);
      Show;
    end;
  end
  else
  begin
    if IsIconic(FPreviewer.Handle) then
      ShowWindow(FPreviewer.Handle,sw_Restore);
    BringWindowToTop(FPreviewer.Handle);
  end;
end;

procedure TPrintService.ClosePreview;
begin
  if Assigned(Previewer) then
  begin
    Previewer.Free;
    Previewer:=nil;
  end;
end;

procedure TPrintService.Print;
var
  Page: Integer;
begin
  if Assigned(FOnPrint) then FOnPrint(Self);
  with Printer do
  begin
    BeginDoc;
    if Assigned(FOnDraw) then
      for Page:=1 to PageCount do
      begin
        FOnDraw(Self,Canvas,Page,dtPrint);
        if Page<PageCount then NewPage;
      end;
    EndDoc;
  end;
end;

procedure TPrintService.PrintDialog;
var
  Page: Integer;
begin
  with TPrintDialog.Create(Owner) do
  try
    Options:=Options+[poPageNums];
    MinPage:=1;
    MaxPage:=PageCount;
    FromPage:=1;
    ToPage:=PageCount;
    if Execute then
    begin
      if Assigned(Previewer) then Previewer.UpdatePageSetup;
      if Assigned(FOnPrinterSetupChange) then FOnPrinterSetupChange(Self);
      if Assigned(FOnPrint) then FOnPrint(Self);
      with Printer do
      begin
        BeginDoc;
        if Assigned(FOnDraw) then
          for Page:=FromPage to ToPage do
          begin
            FOnDraw(Self,Canvas,Page,dtPrint);
            if Page<ToPage then NewPage;
          end;
        EndDoc;
      end;
    end;
  except
    Free;
  end;
end;

procedure TPrintService.PrinterSetupDialog;
begin
  with TPrinterSetupDialog.Create(Owner) do
  try
    if Execute then
    begin
      if Assigned(Previewer) then Previewer.UpdatePageSetup;
      if Assigned(FOnPrinterSetupChange) then FOnPrinterSetupChange(Self);
    end;
  except
    Free;
  end;
end;

procedure TPrintService.UpdatePreview;
begin
  if Assigned(Previewer) then Previewer.UpdatePreview;
end;

procedure TPrintService.SetPreviewer(Value: TPreviewForm);
begin
  if FPreviewer<>Value then
  begin
    if (Value=nil) and Assigned(FOnPreviewClose) then
      FOnPreviewClose(Self);
    FPreviewer:=Value;
  end;
end;

procedure TPrintService.SetPreviewerCaption(Value: string);
begin
  if Value<>FPreviewerCaption then
  begin
    FPreviewerCaption:=Value;
    if Assigned(Previewer) then Previewer.Caption:=PreviewerCaption;
  end;
end;

procedure TPrintService.SetPageCount(Value: Integer);
begin
  if Value<1 then Value:=1;
  if Value<>PageCount then
  begin
    FPageCount:=Value;
    if Assigned(Previewer) then Previewer.PageCount:=PageCount;
  end;
end;

procedure Register;
begin
  RegisterComponents('Silent', [TPrintService]);
end;

end.
