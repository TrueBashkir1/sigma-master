{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }                       
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{                               изменения:                           }
{                                                                     }
{                 Петроченков Михаил Александрович 2003               }
{                                                                     }
{                     Цветаев Борис Михайлович 2004                   }
{                                                                     }
{*********************************************************************}
 
UNIT ShowMovings;

INTERFACE

USES
  Windows, Messages, SysUtils,IniFiles, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, ResultsArrays, ImgList, ToolWin, Menus,
  Grids, Buttons, printers, ExtDlgs, TSigmaForm, Spin, Unit1;

CONST
  IniFileName='Sigma32.ini';
  HandAct = 1;
  HandPas = 2;
  ZoomIn = 3;
  Zoomout = 4;
  ZoomArea = 5;
  CM_Inch=2.5428571428571428571428571428571;
  cursorcrosdx=3;
  CountMaterial = 3;

TYPE

  // Прокофьев. Массив хранит соответсвие номеров зонам
  TElemZone = array[1..20, 1..100000] of integer;

  Arr = array[1..3, 1..4] of MyReal;

  TStress = Array [1..CountMaterial] of real;
  ZoneStruct = Record
               ZoneNum    : word;      // номер зоны
               NodesNum   : Array [0..7] of word;      // номера узлов
               NodesCoord : Array [0..1,0..7] of real;      // координаты узлов
     End;
     TZoneInfo = Array [0..20] Of ZoneStruct;
  TStressArray = ARRAY [1..7] OF MyReal;
  ElStressArray = ARRAY [1..3] OF MyReal;
  TShowMovingsForm = Class(TForm)
    ScrollBox1     : TScrollBox;
    StatusBar1     : TStatusBar;
    LegendPanel    : TPanel;
    Splitter2      : TSplitter;
    Legend         : TPaintBox;
    Panel2         : TPanel;
    ControlBar1    : TControlBar;
    ToolBar1       : TToolBar;
    DefaultAction  : TToolButton;
    ImageList1     : TImageList;
    PaintBox1      : TPaintBox;
    MoveAction     : TToolButton;
    ZoomInAction   : TToolButton;
    ZoomOutAction  : TToolButton;
    ZoomAreaAction : TToolButton;
    BestFitAction  : TToolButton;
    Panel4         : TPanel;
    ColorMinus     : TPanel;
    ColorPlus      : TPanel;
    ColorDialog1   : TColorDialog;
    ColorZero      : TPanel;
    CheckColor     : TPopupMenu;
    PlusM          : TMenuItem;
    MinusM         : TMenuItem;
    ZeroM          : TMenuItem;
    BkgrM          : TMenuItem;
    ForceM         : TMenuItem;
    SavePicDlg     : TSavePictureDialog;
    Panel8         : TPanel;
    SpeedButton2   : TSpeedButton;
    SpeedButton3   : TSpeedButton;
    SpeedButton4   : TSpeedButton;
    GroupBox7: TGroupBox;
    StringGrid1: TStringGrid;
    GroupBox5: TGroupBox;
    Label9: TLabel;
    EditForce: TEdit;
    ForceTrackBar: TTrackBar;
    StressType: TRadioGroup;
    GroupBox8: TGroupBox;
    Panel9: TPanel;
    StressMethod1: TRadioButton;
    StressMethod2: TRadioButton;
    StressMethod3: TRadioButton;
    GroupBox9: TGroupBox;
    Label17: TLabel;
    Label16: TLabel;
    InfoMoveX: TEdit;
    InfoMoveY: TEdit;
    GroupBox4: TGroupBox;
    Mover: TTrackBar;
    Panel5: TPanel;
    Label8: TLabel;
    EditMover: TEdit;
    Group4: TGroupBox;
    UseBuffer: TCheckBox;
    UseLegend: TCheckBox;
    UseForce: TCheckBox;
    UseBound: TCheckBox;
    UseNumNode: TCheckBox;
    UseNumZone: TCheckBox;
    UseAxes: TCheckBox;
    GroupBox3: TGroupBox;
    LevelNumber: TLabel;
    ChangeLegend: TTrackBar;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    EditScale: TEdit;
    Panel1: TPanel;
    InfoX: TEdit;
    InfoY: TEdit;
    InfoXY: TEdit;
    InfoMax: TEdit;
    InfoMin: TEdit;
    InfoConer: TEdit;
    InfoEcv: TEdit;
    Edit1: TEdit;
    Panel6: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    EditX: TEdit;
    EditY: TEdit;
    Panel7: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Timer1: TTimer;
    TestElements: TCheckBox;
    LabelScale: TLabel;
    UseLines: TCheckBox;
    InfoFiniteElementNumber: TEdit;
    Label13: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupBox1: TGroupBox;
    KENumber: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    MUprug: TEdit;
    Label18: TLabel;
    KoefPuas: TEdit;
    Label19: TLabel;
    DopNapr: TEdit;
    Label20: TLabel;
    thickness: TEdit;
    Label21: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Panel10: TPanel;
    Panel11: TPanel;
    GroupBox6: TGroupBox;
    Label24: TLabel;
    Label26: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    SpeedButton5: TSpeedButton;
    EditMoveX: TEdit;
    EditMoveY: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label25: TLabel;
    UseNumMater: TCheckBox;
    Spin_0_max: TSpinEdit;
    ColorPlus_0: TPanel;
    ColorMinus_0: TPanel;
    Spin_0_min: TSpinEdit;
    CheckBox1: TCheckBox;
    pl: TLabel;
    mi: TLabel;
    Edit7: TEdit;
    Label29: TLabel;
    CheckBox2: TCheckBox;
    ZoneCheckBox: TCheckBox;
    Button1: TButton;
    ColorZeroPluss: TPanel;
    ParamsButton: TSpeedButton;

    PROCEDURE FormCreate(Sender: TObject);
    PROCEDURE FormDestroy(Sender: TObject);
    PROCEDURE FormResize(Sender: TObject);
    PROCEDURE PaintBox1Paint(Sender: TObject);
    PROCEDURE UseLegendClick(Sender: TObject);
    //включает линии уровня
    PROCEDURE UseLinesClick(Sender: TObject);
    PROCEDURE RePaintPlate(Sender: TObject);
    PROCEDURE EditScaleChange(Sender: TObject);
    PROCEDURE TrackBar1Change(Sender: TObject);
    PROCEDURE ChangeLegendChange(Sender: TObject);
    PROCEDURE LegendPaint(Sender: TObject);
    PROCEDURE PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: INTEGER);
    PROCEDURE MoverChange(Sender: TObject);
    PROCEDURE FormClose(Sender: TObject; VAR Action: TCloseAction);
    PROCEDURE ChangeActionClick(Sender: TObject);
    PROCEDURE PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
    PROCEDURE PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
    PROCEDURE BestFitActionClick(Sender: TObject);
    PROCEDURE ChangeColorClick(Sender: TObject);
    //смена цветов плюса и минуса
    //PROCEDURE ChangeColorPlus(Sender: TObject);
    //PROCEDURE ChangeColorMinus(Sender: TObject);

    PROCEDURE EditMoverChange(Sender: TObject);
    PROCEDURE PlusMClick(Sender: TObject);
    PROCEDURE MinusMClick(Sender: TObject);
    PROCEDURE ZeroMClick(Sender: TObject);
    PROCEDURE BkgrMClick(Sender: TObject);
    PROCEDURE ForceMClick(Sender: TObject);
    PROCEDURE UpDown1ChangingEx(Sender: TObject; VAR AllowChange: BOOLEAN; NewValue: Smallint; Direction: TUpDownDirection);
    PROCEDURE EditXChange(Sender: TObject);
    PROCEDURE ForceTrackBarChange(Sender: TObject);
    PROCEDURE UseAxesClick(Sender: TObject);
    PROCEDURE GroupBox6DblClick(Sender: TObject);
    PROCEDURE SpeedButton2Click(Sender: TObject);
    PROCEDURE SpeedButton3Click(Sender: TObject);
    PROCEDURE SpeedButton4Click(Sender: TObject);
    procedure StressMethod1Click(Sender: TObject);
    procedure StressMethod2Click(Sender: TObject);
    procedure StressMethod3Click(Sender: TObject);
    Procedure StressMethodSave(Method: Integer);
    Function  StressMethodLoad(Method: Integer):Integer;
   // FUNCTION StressInElementType(Elem: Integer;VAR st:TStressArray; Typ:Integer):BOOLEAN;
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure ParamsButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure EditMoveXChange(Sender: TObject);
    procedure Spin_0_Exit(Sender: TObject);
    procedure UseNumZoneClick(Sender: TObject);
    procedure UseNumMaterClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ZoneCheckBoxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EditForceChange(Sender: TObject);
    procedure ColorZeroPlussClick(Sender: TObject);
    PROCEDURE CheckOptimization();
    function GetGridOpt():Integer;
    procedure NodeEditInputChange(Sender: TObject);
    procedure InfoFiniteElementNumberChange(Sender: TObject);


  PUBLIC
   DrawSelectedElement: Boolean;
   ChangedFromNodeInput: Boolean;
   DrawSelectedPoint: Boolean;
    dx, dy           : MyReal;
    x, y             : MyReal;
    Updating         : BOOLEAN;
    ActiveToolButton : TToolButton;
    ActiveRadio      : TRadioButton;
    MousePushed      : BOOLEAN;
    Force, BackGR    : TColor;
    ElemInputs : BOOLEAN;

    Error    : WORD;
    PROCEDURE LoadResults(Path:STRING);
    PROCEDURE ChangeDrawSize;
    PROCEDURE Scaling;
    PROCEDURE SetDiapazon;
    PROCEDURE SetScale;
    PROCEDURE MainRePaint;
    PROCEDURE LegendRePaint;
    PROCEDURE ShowElements(Canvas:TCanvas);
    PROCEDURE ShowAxes(Canvas:TCanvas);
    PROCEDURE ShowSelectedPoint(Canvas:TCanvas);
    PROCEDURE ShowElement(Canvas:TCanvas;OneElement:TOneElement);
    PROCEDURE ShowElement1(Canvas:TCanvas;OneElement:TOneElement);
    PROCEDURE ShowElement2(Canvas:TCanvas;OneElement:TOneElement);
    PROCEDURE ShowElementOld(Canvas:TCanvas;OneElement:TOneElement);
    PROCEDURE ShowMaterialColoredElement(Canvas:TCanvas;OneElement:TOneElement);
    procedure ShowOneElement(Element: TOneElement; Canvas : TCanvas);
    procedure ShowOneElementInfo(Canvas:TCanvas);
    FUNCTION StressInElement(OneElement : TOneElement;VAR stress: ElStressArray):BOOLEAN;
    PROCEDURE ShowArrow(Canvas:TCanvas;x,y,long:INTEGER;Alfa:MyReal);
    PROCEDURE ShowBoundForce(Canvas:TCanvas);
    PROCEDURE ShowText(Canvas:TCanvas;x,y:INTEGER;S:STRING);
    PROCEDURE ChengeLegendLevel;
    FUNCTION GenerateColor(Value:word):TColor;
    FUNCTION GenerateColor1(Value:word):TColor;
    FUNCTION GenerateColorOld(Value:word):TColor;
    PROCEDURE ShowForm(ResFile:STRING);
    PROCEDURE SaveForm(Name:STRING);
    PROCEDURE LoadForm(Name:STRING);
    PROCEDURE ZoomAreaRect(x1,y1,x2,y2:MyReal);
    FUNCTION SolveInPoint : Boolean;
    FUNCTION StressInPoint(X,Y:MyReal;VAR st:TStressArray):BOOLEAN;
    FUNCTION StressInPointType(X,Y:MyReal;VAR st:TStressArray; Typ:Integer):BOOLEAN;
    PROCEDURE PaintBox1Click;

    //решение системы линейных уранений методом Гаусса-Жордана
    function solveGJ(var m: Arr; nRows:integer):boolean;
    // Прокофьев
    PROCEDURE LoadMaxMinStress();
    PROCEDURE LoadMaxMinStressInMaterials();

    procedure LoadElemZone(path: string);
    // end Прокофьев

    function  MoveInPoint(X,Y:MyReal;var move_st:TStressArray):boolean;
    PROCEDURE UseTestElements(Canvas:TCanvas);    //  процедура проверки на превышение допустимого напряжения в КЭ
    FUNCTION  HLStoRGB(H,L,S : INTEGER):TColor;
    PROCEDURE RGBtoHLS(Color:TColor;Var H,L,S:INTEGER);
    //процедура рисует контуры зон, на которые изначально была разбита пластина
    procedure PaintZonesContour(Canvas:TCanvas);
  END;

VAR
  ShowMovingsForm : TShowMovingsForm;
  bmpPic : TBitMap;
     ZoneInfo     : TZoneInfo;
     ZoneCount    : integer;
     PrevDim      : integer;
  ElemZone : TElemZone;


IMPLEMENTATION
USES Math, MainInterface, Strfunc, Registry, PrnServ;
 {BrowseFolder in '../Source/BrowseFolder.dcu',
 Registry in '\Source',
 Constants in '\Source',
 TProject in '\Source\TProject';   }

CONST
  paintdx = 10;
  paintdy = 10;
  Error_Text : array [1..10] of string=
     ('Неизвестная ошибка', 'не выполнилось считывание координат', 'не считались граничные условия',
'не считались значения приложенных сил', 'не определились номера узлов после перенумерации', 'не считались перемещения узлов', 'Неизвестная ошибка',
'Неизвестная ошибка', 'Неизвестная ошибка', 'Неизвестная ошибка');

VAR
  DownX,DownY             : INTEGER;
  CenterX,CenterY         : INTEGER;
  PaintWidth, PaintHeight : INTEGER;
  OffsetX,OffsetY         : MyReal;
  SOffsetX,SOffsetY       : MyReal;
  FigureX,FigureY         : MyReal;
  Scale                   : MyReal;
  MouseX, MouseY          : MyReal;
  Level                   : MyReal;
  Level_plus              : MyReal;  //шаг уровней в +
  Level_minus             : MyReal;  //шаг уровней в -
  Level_zero              : INTEGER;  //уровень с 0
  NegativeLevels          : WORD;
  CM                      : MyReal;
  MoverK                  : MyReal;
  ForceK                  : MyReal;
  OnlyUpdate              : BOOLEAN;
  FloatFormat             : STRING;
  StressMethod            : INTEGER;
  //показывать линии уровня
  LinesShow               : BOOLEAN;
  Pointed                 : BOOLEAN;
  //мигание
  DataPath                : STRING;
  Prd                     : INTEGER;
  DopStress               : Real;
  SigmaLocation : STRING;
   SigmaIni : TIniFile;

  //цвета
  //CPlus,CMinus    : TColor;
  //LinesCPlus,LinesCMinus : TColor;
{$R *.DFM}

{************обрезание строки до 2 знаков после ',' ***********}
{FUNCTION CutStr(x:STRING):STRING;
VAR
 i,j : INTEGER;
 y   : STRING;

BEGIN
  y:='';
  FOR i:=1 TO Length(x) DO BEGIN
    IF x[i]=',' THEN BEGIN
      j:=i+2;
      y:=copy(x,1,j);
      BREAK;
    END;
  END;
  Result:=y;
END;}


FUNCTION MyFloatToStr(X:MyReal):STRING;
BEGIN
  Result:=FormatFloat(FloatFormat,X);
{  ShowMessage(FloatFormat);}
END;


FUNCTION MyDiv(x,y:MyReal):MyReal;
BEGIN
  IF ABS(y)<0.1E-4900 THEN Result:=0.1E-4900
  ELSE Result:=x/y;
END;


FUNCTION Xreal2Xpaint(x:MyReal):INTEGER;
VAR
  xx : MyReal;

BEGIN
  xx:=(OffsetX+(x-FigureX))*Scale*CM;
  IF xx>32000 THEN xx:=32000;
  Result:=CenterX+ROUND(xx);
END;


FUNCTION Yreal2Ypaint(y:MyReal):INTEGER;
VAR
  yy : MyReal;

BEGIN
  yy:=(OffsetY+(y-FigureY))*Scale*CM;
  IF yy>32000 THEN yy:=32000;
  Result:=CenterY-ROUND(yy);
END;


FUNCTION Xpaint2Xreal(x:INTEGER):MyReal;
BEGIN
  IF ABS(Scale)<0.1E-15 THEN Scale:=0.1E-15;
  Result:=MyDiv((x-CenterX),Scale*CM)-OffsetX+FigureX;
END;


FUNCTION Yp2Yr(y:INTEGER):MyReal;
BEGIN
  IF ABS(Scale)<0.1E-15 THEN Scale:=0.1E-15;
  Result:=MyDiv((y-CenterY),Scale*CM)-OffsetY+FigureY;
END;


FUNCTION Ypaint2Yreal(y:INTEGER):MyReal;
BEGIN
  Result:=Yp2Yr(PaintHeight-y);
END;

function LoadCountMaterial( var Error:Integer): Integer;
VAR
//  i         : INTEGER;
//  s         : string;
//  F         : Text;
//  DopStress : Real;
  MP        : TMainParams;
  MPM       : TMainParamsMaterial;
BEGIN

Form_Load(Project_GetFormFile);

MP:=GetMainParam;

Error:=0;
Result:=MP.CountMaterial;

end;

// Load Save form
PROCEDURE TShowMovingsForm.LoadForm(Name:STRING);
VAR
  Registry:TRegistry;
  error : integer;

  FUNCTION ReadSTRING(Name:STRING;Def:STRING):STRING;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadSTRING(Name) ELSE Result:=def;
  END;

  FUNCTION ReadInteger(Name:STRING;Def:INTEGER):INTEGER;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadInteger(Name) ELSE Result:=def;
  END;

  FUNCTION ReadFloat(Name:STRING;Def:MyReal):MyReal;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadFloat(Name) ELSE Result:=def;
  END;

  FUNCTION ReadBool(Name:STRING;Def:BOOLEAN):BOOLEAN;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadBool(Name) ELSE Result:=def;
  END;

BEGIN
DrawSelectedElement:= TRUE;
  Form1.Visible := true;
  // заполнение поля числа зон, узлов, элементов и свойств в окне настроек
   Form1.ZonesNumLbl.Caption := IntToStr(ZoneContour.GetNumberOfZones());
   Form1.NodesNumLbl.Caption := IntToStr(Nodes_result.GetCountOfNodes);
   Form1.ElemNumLbl.Caption :=   IntToStr(Elements_Result.GetNumElements);
   Form1.PropNumLbl.Caption := IntToStr(LoadCountMaterial(error));
   
   SigmaLocation   :=LowerCase(ExtractFilePath(ParamStr(0)));
  SigmaIni:=TIniFile.Create(SigmaLocation+'sigma32.ini');
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  IF Registry.OpenKeyReadOnly(STRINGReg+'\'+Name) THEN BEGIN
    WindowState:=wsNormal;
    Top:=ReadInteger('Top',Top);
    Left:=ReadInteger('Left',Left);
    Width:=ReadInteger('Width',Width);
    Height:=ReadInteger('Height',Height);
    IF ReadBool('Maximized',FALSE) THEN WindowState:=wsMaximized ELSE WindowState:=wsNormal;
    ColorZero.color:=StringToColor(ReadSTRING('ColorZero','clWhite'));
    ColorPlus.Color:=StringToColor(ReadSTRING('ColorPlus','clRed'));
    ColorMinus.Color:=StringToColor(ReadSTRING('ColorMinus','$00FF8000'));
    ColorPlus_0.Color:=StringToColor(ReadSTRING('ColorPlus_0','clYellow'));
    ColorMinus_0.Color:=StringToColor(ReadSTRING('ColorMinus_0','clLime'));
    Spin_0_max.Value:=ReadInteger('Spin_0_max',500);
    Spin_0_min.Value:=ReadInteger('Spin_0_min',-500);
    //
    //LinesCPlus:=StringToColor(ReadSTRING('LinesColorPlus','clRed'));
    //LinesCMinus:=StringToColor(ReadSTRING('LinesColorMinus','clGreen'));
    UseLines.Checked:=ReadBool('UseLines',FALSE);

    Force:=StringToColor(ReadSTRING('Force','clBlue'));
    BackGR:=StringToColor(ReadSTRING('BackGROUND','clWhite'));
    EditForce.Text:=IntToStr(100);//ReadInteger('ForceK',5));
    ForceTrackBar.Position:= ForceTrackBar.min;
   // ForceTrackBar.Position:=ReadInteger('ForcePos',ROUND(ForceTrackBar.Max/2));
    EditMover.Text:=FloatToStr(ReadFloat('MoverK',10));
    UseLegend.Checked:=ReadBool('UseLegend',TRUE);
    UseForce.Checked:=ReadBool('UseForce',FALSE);
    UseBound.Checked:=ReadBool('UseBound',FALSE);
    UseNumNode.Checked:=ReadBool('UseNumNode',FALSE);
    UseNumZone.Checked:=ReadBool('UseNumZone',FALSE);
    UseBuffer.Checked:=ReadBool('UseBuffer',FALSE);
  END;
  IF Registry.OpenKeyReadOnly(STRINGReg) THEN FloatFormat:=Registry.ReadSTRING('FloatFormat');
  LegendPanel.Color:=BackGR;
  Panel2.Color:=BackGR;
  Registry.Free;
  MainRePaint;
  //
  //if UseLines.Checked = false then
  //begin
  //  ColorPlus.Color:=CPlus;
  //  ColorMinus.Color:=CMinus;
  //end;
END;

function LoadDopStress( var Error:Integer): TStress;
VAR
//  i         : INTEGER;
//  s         : string;
//  F         : Text;
//  DopStress : Real;
  MP        : TMainParams;
  MPM       : TMainParamsMaterial;
BEGIN

Form_Load(Project_GetFormFile);

MP:=GetMainParam;
MPM:=GetMainParamMaterial;

Error:=0;
Result[1]:=MP.SB;
Result[2]:=MPM.ORT10;
Result[3]:=MPM.ORT17;

end;



function LoadDopNegStress( var Error:Integer): TStress;
VAR
  MPM       : TMainParamsMaterial;
BEGIN

Form_Load(Project_GetFormFile);

MPM:=GetMainParamMaterial;

Error:=0;
Result[1]:=MPM.ORT4;
Result[2]:=MPM.ORT11;
Result[3]:=MPM.ORT18;
end;

PROCEDURE TShowMovingsForm.SaveForm(Name:STRING);
VAR
  Registry:TRegistry;

BEGIN
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  IF Registry.OpenKey(STRINGReg+'\'+Name,TRUE) THEN BEGIN
    Registry.WriteBool('Maximized',WindowState=wsMaximized);
    IF WindowState=wsMaximized THEN WindowState:=wsNormal;
    Registry.WriteInteger('Top',Top);
    Registry.WriteInteger('Left',Left);
    Registry.WriteInteger('Width',Width);
    Registry.WriteInteger('Height',Height);
    Registry.WriteString('ColorZero',ColorToSTRING(ColorZero.color));
    Registry.WriteString('ColorPlus',ColorToSTRING(ColorPlus.Color));
    Registry.WriteString('ColorMinus',ColorToSTRING(ColorMinus.Color));
    Registry.WriteString('ColorPlus_0',ColorToSTRING(ColorPlus_0.Color));
    Registry.WriteString('ColorMinus_0',ColorToSTRING(ColorMinus_0.Color));
    Registry.WriteInteger('Spin_0_max',Spin_0_max.Value);
    Registry.WriteInteger('Spin_0_min',Spin_0_min.Value);
    //
    //Registry.WriteString('LinesColorPlus',ColorToSTRING(LinesCPlus));
    //Registry.WriteString('LinesColorMinus',ColorToSTRING(LinesCMinus));
    Registry.WriteBool('UseLines',UseLines.Checked);

    Registry.WriteString('Force',ColorToSTRING(Force));
    Registry.WriteString('BackGROUND',ColorToSTRING(BackGR));
    Registry.WriteFloat('MoverK',MoverK);
    Registry.WriteInteger('ForceK',strtoint(EditForce.Text));
    Registry.WriteInteger('ForcePos',ForceTrackBar.Position);
    Registry.WriteBool('UseLegend',UseLegend.Checked);
    Registry.WriteBool('UseForce',UseForce.Checked);
    Registry.WriteBool('UseBound',UseBound.Checked);
    Registry.WriteBool('UseNumNode',UseNumNode.Checked);
    Registry.WriteBool('UseNumZone',UseNumZone.Checked);
    Registry.WriteBool('UseBuffer',UseBuffer.Checked);
  END;
//  IF Registry.OpenKey(STRINGReg,TRUE) THEN Registry.WriteString('FloatFormat',FloatFormat);
  Registry.free;
END;


// Actions
PROCEDURE TShowMovingsForm.Scaling;
BEGIN
  IF Scale=0 THEN Scale:=0.1E-17;
  IF Scale>=1 THEN Form1.LabelScale.Caption:=MyFloatToStr(Scale)+' : 1'      //refering to Form1 not to ShowMowings (2012)
  ELSE Form1.LabelScale.Caption:='1 : '+MyFloatToStr(1/Scale);
  ChangeDrawSize;
END;


PROCEDURE TShowMovingsForm.SetDiapazon;
VAR
  value : INTEGER;

BEGIN
  value:=6;
  //IF CheckInt(Form1.EditScale.text,value) THEN BEGIN     //refering to Form1 not to ShowMowings     (2012)
    //IF (Value<2) THEN BEGIN
    //  Form1.EditScale.text:='2';
   //   Value:=2;
  //  END;
    Form1.TrackBar1.Max:=(value-1)*2;
    SetScale;
//  END;
END;


PROCEDURE TShowMovingsForm.SetScale;
VAR
  Half  : INTEGER;
  Value : MyReal;
//Нужно посмотреть, проверить и, скорее всего, удалить, так как отказались от задания масштаба в TextEdit EditScale

BEGIN                                                                //refering to Form1 not to ShowMowings  (2012)
  Half:=ROUND(Form1.TrackBar1.Max/2);
  IF Scale>=1 THEN Value:=Scale ELSE Value:=MyDiv(1,Scale);
  IF Half<Value THEN BEGIN
    Half:=ROUND(Value);
    Form1.TrackBar1.Max:=2*Half;
   // Form1.EditScale.text:=inttostr(Half);
  END;
  IF Scale>=1 THEN Form1.TrackBar1.Position:=ROUND(Half+Value-1)
  ELSE Form1.TrackBar1.Position:=ROUND(Half-Value+1);
  Scaling;
END;


PROCEDURE TShowMovingsForm.ChangeDrawSize;
BEGIN
  Nodes_Result.UpDateWithMove(Form1.Mover.Position*MoverK);
END;


PROCEDURE TShowMovingsForm.MainRePaint;
BEGIN
  IF OnlyUpdate THEN exit;
  IF UseBuffer.Checked THEN PaintBox1Paint(Nil) ELSE PaintBox1.Repaint;
END;


PROCEDURE TShowMovingsForm.LegendRePaint;
BEGIN
  IF UseBuffer.Checked THEN LegendPaint(Nil) ELSE Legend.Repaint;
END;

// Давыдова Ю.А."Графическое отображение"
procedure TShowMovingsForm.CheckBox2Click(Sender: TObject);
begin
if Form1.CheckBox2.checked = true then
    begin
      Form1.UseNumMater.Checked:=false;
      Form1.UseLines.Checked:=false;
      Form1.CheckBox1.Checked:=false;
      Form1.TestElements.Checked:=false;
      Form1.Checkbox2.Checked:=true;
      Colorminus.Caption:='1';
      Colorzero.Caption:='2';
      Colorplus.Caption:='3';
      mi.Visible := false;
      pl.Visible := false;
      Spin_0_max.Visible := false;
      Spin_0_min.Visible := false;
      ColorMinus_0.Visible := false;
      ColorPlus_0.Visible := false;


    end
else
    begin
    Colorzero.Caption:='0';
    Colorminus.Caption:='-';
    Colorplus.Caption:='+';
    end;
    MainRepaint;

end;

//Начало "Зоны", Давыдова Ю.А., 2011г.
procedure TShowMovingsForm.ZoneCheckBoxClick(Sender: TObject);
begin
  MainRepaint;
  UseLegendClick(Sender);

end;

procedure TShowMovingsForm.PaintZonesContour(Canvas:TCanvas);
var
    inrg          : Shortint;
    i,j           : Shortint;
    x1,x2,y1,y2,rX,rY   : Integer;
    ZonePoints    : Array[1..16] of Double;
    tempStyle     : TPenStyle;
    tempWidth,tmpSize     : Integer;
    tempColor,tmpPenColor,tmpBrushColor     : TColor;
    tempMode      : TPenMode;
    tmpBrushStyle: TBrushStyle;
begin
    inrg := ZoneContour.GetNumberOfZones();
    //свойства карандаша
    if ZoneCheckBox.checked = true then begin
    //сохраним предыдущие свойства стиля
      tempStyle:=Canvas.Pen.Style;
      tempWidth:=Canvas.Pen.Width;
      tempColor:=Canvas.Pen.Color;
      tempMode:=Canvas.Pen.Mode;
      Canvas.Pen.Style := psSolid;
      Canvas.Pen.Width := 3;
      Canvas.Pen.Color:=StringToColor(SigmaIni.ReadString('ColorSets','zonesLineColor','0'));
      Canvas.Pen.Mode := pmCopy;
      if inrg >= 0 then begin
        for i := 1 to inrg do begin
          ZoneContour.GetZonePoints(i,ZonePoints); // получение данных о зоне (номер; массив точек, составляющих зону)
                         rX:=0;
                         rY:=0;
          for j := 1 to 7 do begin

            x1:=Xreal2Xpaint(ZonePoints[2*j-1]);
            y1:=Yreal2Ypaint(ZonePoints[2*j]);
            x2:=Xreal2Xpaint(ZonePoints[2*j+1]);
            y2:=Yreal2Ypaint(ZonePoints[2*j+2]);
            rX:=rX+x1;
            rY:=rY+y1;



        //рисвание по двум точкам
            Canvas.MoveTo(x1,y1); Canvas.LineTo(x2,y2);
          end;

          // опеделение центра зоны
          rX:=ROUND(rX/7);
          rY:=ROUND(rY/7);
          // вывод номера зоны текстом
          tmpPenColor := Canvas.Font.Color;
          tmpBrushColor := Canvas.Brush.Color;
          tmpBrushStyle := Canvas.Brush.Style;
          tmpSize := Canvas.Font.Size;
             if Unit1.Form1.CheckBoxZonesNum.Checked then
          begin
          Canvas.Font.Color := StringToColor(SigmaIni.ReadString('ColorSets','ZonesFontColor','0'));
          Canvas.Font.Size := StrToInt(SigmaIni.ReadString('ColorSets','ComboBoxZoneFontSize','20'));
          Canvas.Brush.Style:=bsClear;
          ShowText(Canvas,ROUND(rX),ROUND(rY),inttostr(i));
          Canvas.Font.Color := tmpPenColor;
          Canvas.Font.Size :=tmpSize;
          end;

          Canvas.Brush.Color := tmpBrushColor;
          Canvas.Brush.Style := tmpBrushStyle;
          x1:=x2;
          y1:=y2;
          x2:=Xreal2Xpaint(ZonePoints[1]);
          y2:=Yreal2Ypaint(ZonePoints[2]);
          Canvas.MoveTo(x1,y1); Canvas.LineTo(x2,y2);
        end;
      end;
      //свойства карандаша
      Canvas.Pen.Style := tempStyle;
      Canvas.Pen.Width := tempWidth;
      Canvas.Pen.Color := tempColor;
      Canvas.Pen.Mode := tempMode;
    end;
end;

//Конец "Зоны"

PROCEDURE TShowMovingsForm.ChengeLegendLevel;
var
  st: string;
  z : integer;
BEGIN
  z := Form1.ChangeLegend.Position;                              //теперь работаем с Form1 (2012)
  if (Form1.UseLines.Checked = true) and (Form1.CheckBox1.Checked = true) then z := 4;
  level:=(Elements_Result.max[Form1.StressType.ItemIndex+1]-Elements_Result.min[Form1.StressType.ItemIndex+1])/z;

  level_zero := trunc(z/2);
  level_plus := abs(Elements_Result.max[Form1.StressType.ItemIndex+1]/level_zero);
  level_minus := abs(Elements_Result.min[Form1.StressType.ItemIndex+1]/level_zero);
  //showmessage(inttostr(level_zero));
  if Elements_Result.min[Form1.StressType.ItemIndex+1]>=0 then
  begin
        level_zero := 0;
        if (Form1.CheckBox1.Checked = true) then level_zero := 2;
        level_plus := abs(Elements_Result.max[Form1.StressType.ItemIndex+1]/z-1);
        level_minus := 1;
  end;
  if Elements_Result.max[Form1.StressType.ItemIndex+1]<=0 then
  begin
        level_zero := z;
        if (Form1.CheckBox1.Checked = true) then level_zero := 2;
        level_plus := 1;
        level_minus := abs(Elements_Result.min[Form1.StressType.ItemIndex+1]/level_zero);
  end;

  IF Elements_Result.min[Form1.StressType.ItemIndex+1]>=0 THEN NegativeLevels:=0
  ELSE NegativeLevels:=trunc(MyDiv(-Elements_Result.min[Form1.StressType.ItemIndex+1],Level));

  END;

PROCEDURE TShowMovingsForm.LoadResults(Path:STRING);
VAR
  i         : INTEGER;
  Node      : TOneNode;
  SumX,SumY,Rez : MyReal;
  a       :string;

BEGIN
  Error    := 1;
  FOR i:=Length(Path) DOWNTO 1 DO
  IF (Path[i]='\') Or (Path[i]=':') THEN BREAK;
  SetLength(Path,i);
  Nodes_Result.LoadNodes(Path+'RESULT1.BIN');
  IF Nodes_Result.Error<>0 THEN EXIT;
  Elements_Result.LoadElements(Path+'RESULT2.BIN');
  IF Elements_Result.Error<>0 THEN EXIT;
  ZoneContour.LoadZones(Path+'RESULT2.BIN');
  if ZoneContour.Error<>0 then EXIT;
  // Прокофьев. Загрузить соответствие элментов зонам
  LoadElemZone(Path + 'zoneelem.dat');

  ChengeLegendLevel;
  WITH Nodes_Result, Form1.StringGrid1 DO BEGIN           //load table on Form1
    RowCount:=1;
    Cells[0,0]:='№';
    Cells[1,0]:='X';
    Cells[2,0]:='Y';
    Cells[3,0]:='Force X';
    Cells[4,0]:='Force Y';
    Cells[5,0]:='Рез. сила';
    ColWidths[1]:=45;
    ColWidths[2]:=45;
    ColWidths[0]:=30;
    ColWidths[5]:=60;
    SetFirstElement;
    i:=0;
    SumX:=0;
    SumY:=0;
    REPEAT
      Node:=GetNode(GetCurrentElement);
      IF (Node.ForceX<>0) or (Node.ForceY<>0) THEN BEGIN
        SumX:=SumX+Node.ForceX;
        SumY:=SumY+Node.ForceY;
        Rez:= Rez + sqrt(sqr(Node.ForceY)+sqr(Node.ForceX));
        inc(i);
        RowCount:=i+1;
        Cells[0,i]:=IntToStr(Node.RenumNum);
        Cells[1,i]:=MyFloatToStr(Node.x);
        Cells[2,i]:=MyFloatToStr(Node.y);
        Cells[3,i]:=(MyFloatToStr(Node.ForceX));
        Cells[4,i]:=MyFloatToStr(Node.ForceY);
        Cells[5,i]:=MyFloatToStr(sqrt(sqr(Node.ForceY)+sqr(Node.ForceX)));
      END;
    UNTIL NOT SetNextElement;
    i:=RowCount;
    RowCount:=i+1;
    Cells[3,i]:=MyFloatToStr(SumX);
    Cells[4,i]:=MyFloatToStr(SumY);
    Cells[5,i]:=MyFloatToStr(Rez);
    Cells[0,i]:='Сумма';
    FixedRows:=1;
  END;
  Form1.Edit2.Text :=MyFloatToStr(SumX);
  Form1.Edit3.text :=MyFloatToStr(SumY);
  Form1.Edit7.text :=MyFloatToStr(Rez);

  // Прокофьев 2012
  LoadMaxMinStress;
  LoadMaxMinStressInMaterials;
  CheckOptimization();
  // end Прокофьев

  Error    := 0;
END;

//преобразование цветов из HLS в RGB
FUNCTION TShowMovingsForm.HLStoRGB;
const
  HLSMAX = 240;
  RGBMAX = 255;
  UNDEFINED = (HLSMAX*2) div 3;

var
  Magic1, Magic2: single;
  R, G, B: integer;

  function HueToRGB(n1, n2, hue: single): single;
  begin
    if (hue < 0) then
      hue := hue+HLSMAX;
    if (hue > HLSMAX) then
      hue:=hue - HLSMAX;
    if (hue < (HLSMAX/6)) then
      result:= ( n1 + (((n2-n1)*hue+(HLSMAX/12))/(HLSMAX/6)) )
    else
    if (hue < (HLSMAX/2)) then
      result:=n2
    else
    if (hue < ((HLSMAX*2)/3)) then
      result:= ( n1 + (((n2-n1)*(((HLSMAX*2)/3)-hue)+(HLSMAX/12))/(HLSMAX/6)))
    else
      result:= ( n1 );
  end;

begin
  if (S = 0) then
  begin
    B:=round( (L*RGBMAX)/HLSMAX );
    R:=B;
    G:=B;
  end
  else
  begin
    if (L <= (HLSMAX/2)) then
      Magic2 := (L*(HLSMAX + S) + (HLSMAX/2))/HLSMAX
    else
      Magic2 := L + S - ((L*S) + (HLSMAX/2))/HLSMAX;
    Magic1 := 2*L-Magic2;
    R := round( (HueToRGB(Magic1,Magic2,H+(HLSMAX/3))*RGBMAX + (HLSMAX/2))/HLSMAX );
    G := round( (HueToRGB(Magic1,Magic2,H)*RGBMAX + (HLSMAX/2)) / HLSMAX );
    B := round( (HueToRGB(Magic1,Magic2,H-(HLSMAX/3))*RGBMAX + (HLSMAX/2))/HLSMAX );
  end;
  if R<0 then
    R:=0;
  if R>RGBMAX then
    R:=RGBMAX;
  if G<0 then
    G:=0;
  if G>RGBMAX then
    G:=RGBMAX;
  if B<0 then
    B:=0;
  if B>RGBMAX then
    B:=RGBMAX;
  Result:=RGB(R,G,B);
end;

//преобразование цветов из RGB в HLS
PROCEDURE TShowMovingsForm.RGBtoHLS;
const
  HLSMAX = 240;
  RGBMAX = 255;
  UNDEFINED = (HLSMAX*2) div 3;

var
  cMax, cMin: integer;
  Rdelta, Gdelta, Bdelta: single;
  R, G, B: integer;
begin
  r:=GetRValue(Color);
  g:=GetGValue(Color);
  b:=GetBValue(Color);
  cMax := max( max(R,G), B);
  cMin := min( min(R,G), B);
  L := round( ( ((cMax+cMin)*HLSMAX) + RGBMAX )/(2*RGBMAX) );

  if (cMax = cMin) then
  begin
    S := 0;
    H := UNDEFINED;
  end
  else
  begin
    if (L <= (HLSMAX/2)) then
      S := round( ( ((cMax-cMin)*HLSMAX) + ((cMax+cMin)/2) ) / (cMax+cMin) )
    else
      S := round( ( ((cMax-cMin)*HLSMAX) + ((2*RGBMAX-cMax-cMin)/2) ) 
      / (2*RGBMAX-cMax-cMin) );
    Rdelta := ( ((cMax-R)*(HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin);
    Gdelta := ( ((cMax-G)*(HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin);
    Bdelta := ( ((cMax-B)*(HLSMAX/6)) + ((cMax-cMin)/2) ) / (cMax-cMin);
    if (R = cMax) then
      H := round(Bdelta - Gdelta)
    else
    if (G = cMax) then
      H := round( (HLSMAX/3) + Rdelta - Bdelta)
    else
      H := round( ((2*HLSMAX)/3) + Gdelta - Rdelta );
    if (H < 0) then
      H:=H + HLSMAX;
    if (H > HLSMAX) then
      H:= H - HLSMAX;
  end;
  if S<0 then
    S:=0;
  if S>HLSMAX then
    S:=HLSMAX;
  if L<0 then
    L:=0;
  if L>HLSMAX then
    L:=HLSMAX;

end;

//получение цвета напряжения
FUNCTION TShowMovingsForm.GenerateColor(Value:word):TColor;
VAR
  HM,LM,SM :INTEGER;
  HP,LP,SP :INTEGER;
  st : string;
BEGIN
        //if (Value >= level_zero - 1 - abs(spin_0_min.Value)/level_minus) and
        //   (Value <= abs(spin_0_max.Value)/level_plus + level_zero) then
        //begin
        //        Result:=colorzero.Color;
        //        exit;
        //end;
        //showmessage(inttostr(level_zero));
        if (Form1.UseLines.Checked = true) and (Form1.CheckBox1.Checked = true) then begin
             if Value = 0 then Result:=colorminus.Color
             else if Value = 1 then Result:=colorminus_0.Color
             else if Value = 2 then Result:=colorplus_0.Color
             else if Value = 3 then Result:=colorplus.Color;
             exit;
        end;
        if Value >= level_zero then begin
                Value := Value - level_zero;
                RGBtoHLS(ColorPlus.Color,HP,LP,SP);
                RGBtoHLS(ColorPlus_0.Color,HM,LM,SM);
                if level_zero <> 0 then begin
                HM:=HM + Trunc((HP-HM)*Value/(level_zero));
                LM:=LM + Trunc((LP-LM)*Value/(level_zero));
                SM:=SM + Trunc((SP-SM)*Value/(level_zero));
                end
                else
                begin
                HM:=HM + Trunc((HP-HM)*Value/(Form1.ChangeLegend.Position-1));
                LM:=LM + Trunc((LP-LM)*Value/(Form1.ChangeLegend.Position-1));
                SM:=SM + Trunc((SP-SM)*Value/(Form1.ChangeLegend.Position-1));
                end;
                Result:=HLStoRGB(HM,LM,SM);
        end
        else
        begin
                RGBtoHLS(ColorMinus_0.Color,HP,LP,SP);
                RGBtoHLS(ColorMinus.Color,HM,LM,SM);
                HM:=HM + Trunc((HP-HM)*Value/(level_zero-1));
                LM:=LM + Trunc((LP-LM)*Value/(level_zero-1));
                SM:=SM + Trunc((SP-SM)*Value/(level_zero-1));
                Result:=HLStoRGB(HM,LM,SM);
        end;
END;

FUNCTION TShowMovingsForm.GenerateColor1(Value:word):TColor;
VAR
  HM,LM,SM :INTEGER;
  HP,LP,SP :INTEGER;
BEGIN
  RGBtoHLS(ColorPlus.Color,HP,LP,SP);
  RGBtoHLS(ColorMinus.Color,HM,LM,SM);
  HM:=HM + Trunc((HP-HM)*Value/(Form1.ChangeLegend.Position-1));
  LM:=LM + Trunc((LP-LM)*Value/(Form1.ChangeLegend.Position-1));
  SM:=SM + Trunc((SP-SM)*Value/(Form1.ChangeLegend.Position-1));
  Result:=HLStoRGB(HM,LM,SM);
END;

//получение цвета напряжения
FUNCTION TShowMovingsForm.GenerateColorOld(Value:word):TColor;
VAR
  Color : INTEGER;
  y     : MyReal;
  r1,r0,g1,g0,b1,b0,r2,b2,g2 : BYTE;

  FUNCTION Gradient(color1,color2,pos:BYTE):BYTE;
  BEGIN
    Result:=ROUND(Color1+(Color2-Color1)*pos/255);
  END;

BEGIN
  r0:=GetRValue(ColorZero.Color);
  g0:=GetGValue(ColorZero.Color);
  b0:=GetBValue(ColorZero.Color);
  r2:=GetRValue(ColorZeroPluss.Color);
  g2:=GetGValue(ColorZeroPluss.Color);
  b2:=GetBValue(ColorZeroPluss.Color);
//  color:=ROUND(MyDiv((Value-NegativeLevels)*255,-NegativeLevels));
//  r2:=Gradient(r0,r2,color);
//  g2:=Gradient(g0,g2,color);
//  b2:=Gradient(b0,b2,color);
  y:=Value*Level+Elements_Result.min[Form1.StressType.ItemIndex+1];
  IF y+Level<0 THEN
  BEGIN
    //отрицательная область
    r1:=GetRValue(ColorMinus.Color);
    g1:=GetGValue(ColorMinus.Color);
    b1:=GetBValue(ColorMinus.Color);
    color:=ROUND(MyDiv((Value-NegativeLevels)*255,-NegativeLevels));
    r1:=Gradient(r0,r1,color);
    g1:=Gradient(g0,g1,color);
    b1:=Gradient(b0,b1,color);
    Result:=RGB(r1,g1,b1);
  END
  ELSE BEGIN
    //положительная область и ноль
    r1:=GetRValue(ColorPlus.Color);
    g1:=GetGValue(ColorPlus.Color);
    b1:=GetBValue(ColorPlus.Color);
    color:=ROUND(MyDiv((Value-NegativeLevels)*255,Form1.ChangeLegend.Position-NegativeLevels));
    r1:=Gradient(r2,r1,color);
    g1:=Gradient(g2,g1,color);
    b1:=Gradient(b2,b1,color);
    Result:=RGB(r1,g1,b1);
  END;
END;

PROCEDURE TShowMovingsForm.ShowArrow;
CONST Coner=PI/12;
VAR
  xx, yy,k     : INTEGER;
  PointLong, A : MyReal;

BEGIN
  Canvas.Pen.Color:=Force;
  PointLong:=Long/7;
  k:=3;//ROUND(ForceK/2);
  Canvas.MoveTo(x,y);
  xx:=ROUND(x+long*cos(Alfa));
  yy:=ROUND(y-long*sin(Alfa));
  Canvas.LineTo(xx,yy);
  A:=pi+Alfa-coner;
  Canvas.LineTo(ROUND(xx+PointLong*cos(A)),ROUND(yy-PointLong*sin(A)));
  A:=pi+Alfa+coner;
  Canvas.MoveTo(xx,yy);
  Canvas.LineTo(ROUND(xx+PointLong*cos(A)),ROUND(yy-PointLong*sin(A)));
  Canvas.Brush.Color:=Force;
  Canvas.Ellipse(x-k,y-k,x+k,y+k);
END;


PROCEDURE TShowMovingsForm.ShowText;
VAR
  h,w:INTEGER;

BEGIN
  h:=ROUND(Canvas.TextHeight(s)/2);
  w:=ROUND(Canvas.TextWidth(s)/2);
  Canvas.TextOut(x-w,y-h,s);
END;


PROCEDURE TShowMovingsForm.ShowBoundForce;
  FUNCTION vector(x,y:MyReal):INTEGER;
  BEGIN
    Result:=ROUND((sqrt(sqr(x)+sqr(y)))*Scale*ForceK);
  END;

VAR
  OneNode : TOneNode;
  x, y    : INTEGER;
  Bitmap  : TBitMap;
  Long    : INTEGER;

BEGIN
  WITH Nodes_Result DO BEGIN
    IF Nodes_Result.SetFirstElement THEN BEGIN
      Bitmap := TBitmap.Create;
      REPEAT
        OneNode:=GetMovedNode(GetCurrentElement,Form1.Mover.Position*MoverK);
        x:=Xreal2Xpaint(OneNode.x);
        y:=Yreal2Ypaint(OneNode.y);
        IF UseForce.Checked THEN BEGIN
          Long:=vector(OneNode.ForceX,OneNode.ForceY);
          IF Long<>0 THEN ShowArrow(Canvas,x,y,long,ArcTan2(OneNode.ForceY,OneNode.ForceX));
        END;
        IF UseBound.Checked THEN BEGIN
          CASE OneNode.BondType OF
             1 : Bitmap.Handle:=LoadBitmap(HInstance,'BOUND01');
            10 : Bitmap.Handle:=LoadBitmap(HInstance,'BOUND10');
            11 : Bitmap.Handle:=LoadBitmap(HInstance,'BOUND11');
          END;
          IF OneNode.BondType<>0 THEN BEGIN
            Bitmap.Transparent := TRUE;
            Bitmap.TransparentMode := tmAuto;
            x:=ROUND(x-Bitmap.Width/2);
            y:=ROUND(y-Bitmap.Height/2);
            Canvas.Draw(x,y,Bitmap);
          END;
        END;
        IF UseNumNode.Checked THEN BEGIN
          Canvas.Brush.Color:=clWhite;
          ShowText(Canvas,x,y,IntToStr(OneNode.RenumNum));
        END;
      UNTIL NOT Nodes_Result.SetNextElement;
      Bitmap.Free;
    END;
  END;
END;

//показывает один элемент
PROCEDURE TShowMovingsForm.ShowElement(Canvas:TCanvas;OneElement:TOneElement);
VAR
  OneNode : TOneNode;
  K_M     : MyReal;
  i,beg,off       : INTEGER;
  x, y    : ARRAY [1..360] OF INTEGER; //координаты узлов
  LevNode : ARRAY [1..360] OF INTEGER; //номер уровня в узлах
  ID      : ARRAY [1..360] OF INTEGER;
  stress  : ElStressArray; //текущее напряжение в узлах
  Kol     : INTEGER; //количество записей
  ID_now,d :  INTEGER;
  x1,y1   : ARRAY [1..3] OF INTEGER;
  st : string;

BEGIN
  //как рисовать
  Canvas.Pen.Style:=psClear;

  //находим напряжения в узлах в текущем элементе
  StressInElement(OneElement,stress);
  //Координаты узлов элемента
  K_M:=Form1.Mover.Position*MoverK;
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node1,K_M);
  x[1]:=Xreal2Xpaint(OneNode.x);
  y[1]:=Yreal2Ypaint(OneNode.y);
  x1[1]:=x[1]; y1[1]:=y[1];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node2,K_M);
  x[2]:=Xreal2Xpaint(OneNode.x);
  y[2]:=Yreal2Ypaint(OneNode.y);
  x1[2]:=x[2]; y1[2]:=y[2];                 
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node3,K_M);
  x[3]:=Xreal2Xpaint(OneNode.x);
  y[3]:=Yreal2Ypaint(OneNode.y);
  x1[3]:=x[3]; y1[3]:=y[3];
  //Определяем номера уровней в узлах
  //st := 'i ' + IntToStr(level_zero);
  //ShowMessage(st);
  FOR i:=1 TO 3 DO BEGIN
    if stress[i] >= 0 then
    begin
        LevNode[i]:= abs(Trunc(stress[i]/Level_plus)) + level_zero;
        if stress[i] >= abs(spin_0_max.Value) then LevNode[i] := 3
        else LevNode[i] := 2;
        //if LevNode[i] = 2 then begin
        //st := 'p ' + IntToStr(LevNode[i]) +' '+ CurrToStr(stress[i]);
        //ShowMessage(st);
        //end;
    end
    else
    begin
        LevNode[i]:= abs(Trunc((Elements_Result.min[Form1.StressType.ItemIndex+1]-stress[i])/Level_minus));
        if stress[i] <= -abs(spin_0_min.Value) then LevNode[i] := 0
        else LevNode[i] := 1;
        //if LevNode[i] = -1 then begin
        //st := 'm ' + IntToStr(LevNode[i]) +' '+ CurrToStr(stress[i]);
        //ShowMessage(st);
        //end;
    end;



  END;
  //Заполнение координат и уровней промежуточных точек
  Kol:=3;
  ID[1]:=0;
  ID_now:=0;
  //1
  if LevNode[1] > LevNode[2] then
    begin beg:= 2; off:= 1; d:=-1; ID_now:=LevNode[1]-LevNode[2]+1; end
  else
    begin beg:= 1; off:= 2; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN

   //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        //K_M:=(i-level_zero)*Level_plus;
        if i = 2 then K_M:=0;
        if i = 3 then K_M:=abs(spin_0_max.Value);
        if K_M > stress[off] then K_M:=stress[off];
        //st := 'm3 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        //K_M:=Elements_Result.min[StressType.ItemIndex+1]+((i)*Level_minus);
        if i = 1 then K_M:=-abs(spin_0_min.Value);
        if i = 0 then K_M:=stress[off];
        //if K_M < stress[off] then K_M:=stress[off];
        //st := 'm3 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;

    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=LevNode[off]-LevNode[beg]+1;
  ID[2]:=ID_now;
  //2
  if LevNode[2] > LevNode[3] then
    begin beg:= 3; off:= 2; d:=-1; ID_now:=ID_now + LevNode[2]-LevNode[3]+1; end
  else
    begin beg:= 2; off:= 3; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        //K_M:=(i-level_zero)*Level_plus;
      if i = 2 then K_M:=0;
        if i = 3 then K_M:=abs(spin_0_max.Value);
        if K_M > stress[off] then K_M:=stress[off];
        //st := 'm4 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        //K_M:=Elements_Result.min[StressType.ItemIndex+1]+((i)*Level_minus);
        if i = 1 then K_M:=-abs(spin_0_min.Value);
        if i = 0 then K_M:=stress[off];
        //if K_M < stress[off] then K_M:=stress[off];
        //st := 'm4 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;

    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=ID[2] + LevNode[off]-LevNode[beg]+1;
  ID[3]:=ID_now;
  //3
  if LevNode[3] > LevNode[1] then
    begin beg:= 1; off:= 3; d:=-1; ID_now:=ID_now + LevNode[3]-LevNode[1]+1; end
  else
    begin beg:= 3; off:= 1; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
   //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        //K_M:=(i-level_zero)*Level_plus;
       if i = 2 then K_M:=0;
        if i = 3 then K_M:=abs(spin_0_max.Value);
        if K_M > stress[off] then K_M:=stress[off];
        //st := 'm5 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        //K_M:=Elements_Result.min[StressType.ItemIndex+1]+((i)*Level_minus);
        if i = 1 then K_M:=-abs(spin_0_min.Value);
        if i = 0 then K_M:=stress[off];
        //if K_M < stress[off] then K_M:=stress[off];
        //st := 'm5 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  //сортировка
  FOR beg:=1 TO Kol DO BEGIN
  FOR i:=1 TO Kol-1 DO BEGIN
    if LevNode[i] > LevNode[i+1] then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
    if (LevNode[i] = LevNode[i+1]) and (ID[i]>ID[i+1]) then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
  end;
  end;
  //Рисование элементов
  LevNode[Kol+1]:=-1;
  off:=LevNode[1];
  beg:=0;
  for i:=1 to Kol+1 do begin
    inc(beg);
    //if LevNode[i] = 0 then begin
    //st := 'm1 ' + IntToStr(LevNode[i]);
    //ShowMessage(st);
    //end;
    if off<>LevNode[i] then begin
      Canvas.Brush.Color:=GenerateColor(LevNode[i-1]);
      if beg = 4 then
        Canvas.Polygon([point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      if beg = 5 then begin
        Canvas.Polygon([point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      if beg = 6 then begin
        Canvas.Polygon([point(x[i-5],y[i-5]),point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      off:=LevNode[i];
      beg:=1;
    end;
  end;
  Canvas.Pen.Style:=psSolid;
  Canvas.PolyLine([point(x1[1],y1[1]),point(x1[2],y1[2]),point(x1[3],y1[3]),point(x1[1],y1[1])]);
  IF UseNumZone.Checked THEN ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Number));

  IF UseNumMater.Checked THEN begin
   Canvas.Brush.Style:=bsClear;
   ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Material));
  END;
END;

PROCEDURE TShowMovingsForm.ShowElement1(Canvas:TCanvas;OneElement:TOneElement);
VAR
  OneNode : TOneNode;
  K_M     : MyReal;
  i,beg,off       : INTEGER;
  x, y    : ARRAY [1..360] OF INTEGER; //координаты узлов
  LevNode : ARRAY [1..360] OF INTEGER; //номер уровня в узлах
  ID      : ARRAY [1..360] OF INTEGER;
  stress  : ElStressArray; //текущее напряжение в узлах
  Kol     : INTEGER; //количество записей
  ID_now,d :  INTEGER;
  x1,y1   : ARRAY [1..3] OF INTEGER;
  st : string;

BEGIN
  //как рисовать
  Canvas.Pen.Style:=psClear;

  //находим напряжения в узлах в текущем элементе
  StressInElement(OneElement,stress);
  //Координаты узлов элемента
  K_M:=Form1.Mover.Position*MoverK;
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node1,K_M);
  x[1]:=Xreal2Xpaint(OneNode.x);
  y[1]:=Yreal2Ypaint(OneNode.y);
  x1[1]:=x[1]; y1[1]:=y[1];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node2,K_M);
  x[2]:=Xreal2Xpaint(OneNode.x);
  y[2]:=Yreal2Ypaint(OneNode.y);
  x1[2]:=x[2]; y1[2]:=y[2];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node3,K_M);
  x[3]:=Xreal2Xpaint(OneNode.x);
  y[3]:=Yreal2Ypaint(OneNode.y);
  x1[3]:=x[3]; y1[3]:=y[3];
  //Определяем номера уровней в узлах
  FOR i:=1 TO 3 DO BEGIN
    if stress[i] >= 0 then
    begin
        LevNode[i]:= abs(Trunc(stress[i]/Level_plus)) + level_zero;
        //st := 'p ' + IntToStr(LevNode[i]) +' '+ CurrToStr(stress[i]);
        //ShowMessage(st);
    end
    else
    begin
        LevNode[i]:= abs(Trunc((Elements_Result.min[Form1.StressType.ItemIndex+1]-stress[i])/Level_minus));
        //st := 'm ' + IntToStr(LevNode[i]) +' '+ CurrToStr(stress[i]);
        //ShowMessage(st);
    end;
  END;
  //Заполнение координат и уровней промежуточных точек
  Kol:=3;
  ID[1]:=0;
  ID_now:=0;
  //1
  if LevNode[1] > LevNode[2] then
    begin beg:= 2; off:= 1; d:=-1; ID_now:=LevNode[1]-LevNode[2]+1; end
  else
    begin beg:= 1; off:= 2; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        K_M:=(i-level_zero)*Level_plus;
        //st := 'm3 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        K_M:=Elements_Result.min[Form1.StressType.ItemIndex+1]+((i)*Level_minus);
        //st := 'm3 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=LevNode[off]-LevNode[beg]+1;
  ID[2]:=ID_now;
  //2
  if LevNode[2] > LevNode[3] then
    begin beg:= 3; off:= 2; d:=-1; ID_now:=ID_now + LevNode[2]-LevNode[3]+1; end
  else
    begin beg:= 2; off:= 3; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        K_M:=(i-level_zero)*Level_plus;
        //st := 'm4 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        K_M:=Elements_Result.min[Form1.StressType.ItemIndex+1]+(i*Level_minus);
        //st := 'm4 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;

    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=ID[2] + LevNode[off]-LevNode[beg]+1;
  ID[3]:=ID_now;
  //3
  if LevNode[3] > LevNode[1] then
    begin beg:= 1; off:= 3; d:=-1; ID_now:=ID_now + LevNode[3]-LevNode[1]+1; end
  else
    begin beg:= 3; off:= 1; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    //K_M:=Elements_Result.min[StressType.ItemIndex+1]+i*Level;
    //K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    if i >= level_zero then
    begin
        K_M:=(i-level_zero)*Level_plus;
        //st := 'm5 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end
    else
    begin
        K_M:=Elements_Result.min[Form1.StressType.ItemIndex+1]+(i*Level_minus);
        //st := 'm5 ' + CurrToStr(K_M);
        //ShowMessage(st);
        K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    end;
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  //сортировка
  FOR beg:=1 TO Kol DO BEGIN
  FOR i:=1 TO Kol-1 DO BEGIN
    if LevNode[i] > LevNode[i+1] then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
    if (LevNode[i] = LevNode[i+1]) and (ID[i]>ID[i+1]) then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
  end;
  end;
  //Рисование элементов
  LevNode[Kol+1]:=-1;
  off:=LevNode[1];
  beg:=0;
  for i:=1 to Kol+1 do begin
    inc(beg);
    if off<>LevNode[i] then begin
      Canvas.Brush.Color:=GenerateColor(LevNode[i-1]);
      if beg = 4 then
        Canvas.Polygon([point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      if beg = 5 then begin
        Canvas.Polygon([point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      if beg = 6 then begin
        Canvas.Polygon([point(x[i-5],y[i-5]),point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      off:=LevNode[i];
      beg:=1;
    end;
  end;
  Canvas.Pen.Style:=psSolid;
  Canvas.PolyLine([point(x1[1],y1[1]),point(x1[2],y1[2]),point(x1[3],y1[3]),point(x1[1],y1[1])]);
  IF UseNumZone.Checked THEN ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Number));

  IF UseNumMater.Checked THEN begin
   Canvas.Brush.Color:=clYellow;
   ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Material));
  END;
END;

PROCEDURE TShowMovingsForm.ShowElement2(Canvas:TCanvas;OneElement:TOneElement);
VAR
  OneNode : TOneNode;
  K_M     : MyReal;
  i,beg,off       : INTEGER;
  x, y    : ARRAY [1..360] OF INTEGER; //координаты узлов
  LevNode : ARRAY [1..360] OF INTEGER; //номер уровня в узлах
  ID      : ARRAY [1..360] OF INTEGER;
  stress  : ElStressArray; //текущее напряжение в узлах
  Kol     : INTEGER; //количество записей
  ID_now,d :  INTEGER;
  x1,y1   : ARRAY [1..3] OF INTEGER;
  st : string;

BEGIN
  //как рисовать
  Canvas.Pen.Style:=psClear;

  //находим напряжения в узлах в текущем элементе
  StressInElement(OneElement,stress);
  //Координаты узлов элемента
  K_M:=Form1.Mover.Position*MoverK;
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node1,K_M);
  x[1]:=Xreal2Xpaint(OneNode.x);
  y[1]:=Yreal2Ypaint(OneNode.y);
  x1[1]:=x[1]; y1[1]:=y[1];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node2,K_M);
  x[2]:=Xreal2Xpaint(OneNode.x);
  y[2]:=Yreal2Ypaint(OneNode.y);
  x1[2]:=x[2]; y1[2]:=y[2];
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node3,K_M);
  x[3]:=Xreal2Xpaint(OneNode.x);
  y[3]:=Yreal2Ypaint(OneNode.y);
  x1[3]:=x[3]; y1[3]:=y[3];
  //Определяем номера уровней в узлах
  FOR i:=1 TO 3 DO BEGIN
        LevNode[i]:= Trunc((stress[i] - Elements_Result.min[Form1.StressType.ItemIndex+1])/Level);
  END;
  //Заполнение координат и уровней промежуточных точек
  Kol:=3;
  ID[1]:=0;
  ID_now:=0;
  //1
  if LevNode[1] > LevNode[2] then
    begin beg:= 2; off:= 1; d:=-1; ID_now:=LevNode[1]-LevNode[2]+1; end
  else
    begin beg:= 1; off:= 2; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    K_M:=Elements_Result.min[Form1.StressType.ItemIndex+1]+i*Level;
    K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=LevNode[off]-LevNode[beg]+1;
  ID[2]:=ID_now;
  //2
  if LevNode[2] > LevNode[3] then
    begin beg:= 3; off:= 2; d:=-1; ID_now:=ID_now + LevNode[2]-LevNode[3]+1; end
  else
    begin beg:= 2; off:= 3; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    K_M:=Elements_Result.min[Form1.StressType.ItemIndex+1]+i*Level;
    K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  ID_now:=ID[2] + LevNode[off]-LevNode[beg]+1;
  ID[3]:=ID_now;
  //3
  if LevNode[3] > LevNode[1] then
    begin beg:= 1; off:= 3; d:=-1; ID_now:=ID_now + LevNode[3]-LevNode[1]+1; end
  else
    begin beg:= 3; off:= 1; d:= 1; end;
  FOR i:=LevNode[beg]+1 TO LevNode[off] DO BEGIN
    K_M:=Elements_Result.min[Form1.StressType.ItemIndex+1]+i*Level;
    K_M:=(K_M-stress[beg])/(stress[off]-stress[beg]);
    ID_now:=ID_now + d;
    x[kol+1]:=Trunc(x[beg]+ (x[off]-x[beg])*K_M);
    y[kol+1]:=Trunc(y[beg]+ (y[off]-y[beg])*K_M);
    LevNode[kol+1]:=i-1;
    ID[kol+1]:=ID_now;
    x[kol+2]:=x[kol+1];
    y[kol+2]:=y[kol+1];
    LevNode[kol+2]:=i;
    ID[kol+2]:=ID[kol+1];
    Kol:=Kol+2;
  END;
  //сортировка
  FOR beg:=1 TO Kol DO BEGIN
  FOR i:=1 TO Kol-1 DO BEGIN
    if LevNode[i] > LevNode[i+1] then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
    if (LevNode[i] = LevNode[i+1]) and (ID[i]>ID[i+1]) then
    begin
      off:=LevNode[i]; LevNode[i]:=LevNode[i+1]; LevNode[i+1]:=off;
      off:=x[i]; x[i]:=x[i+1]; x[i+1]:=off;
      off:=y[i]; y[i]:=y[i+1]; y[i+1]:=off;
      off:=ID[i]; ID[i]:=ID[i+1]; ID[i+1]:=off;
    end;
  end;
  end;
  //Рисование элементов
  LevNode[Kol+1]:=-1;
  off:=LevNode[1];
  beg:=0;
  for i:=1 to Kol+1 do begin
    inc(beg);
    if off<>LevNode[i] then begin
      Canvas.Brush.Color:=GenerateColor1(LevNode[i-1]);
      if beg = 4 then
        Canvas.Polygon([point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      if beg = 5 then begin
        Canvas.Polygon([point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      if beg = 6 then begin
        Canvas.Polygon([point(x[i-5],y[i-5]),point(x[i-4],y[i-4]),point(x[i-3],y[i-3]),point(x[i-2],y[i-2]),point(x[i-1],y[i-1])]);
      end;
      off:=LevNode[i];
      beg:=1;
    end;
  end;
  Canvas.Pen.Style:=psSolid;
  Canvas.PolyLine([point(x1[1],y1[1]),point(x1[2],y1[2]),point(x1[3],y1[3]),point(x1[1],y1[1])]);
  IF UseNumZone.Checked THEN ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Number));

  IF UseNumMater.Checked THEN begin
   Canvas.Brush.Color:=clYellow;
   ShowText(Canvas,ROUND((x1[1]+x1[2]+x1[3])/3),ROUND((y1[1]+y1[2]+y1[3])/3),inttostr(OneElement.Material));
  END;
END;

//Давыдова Ю.А.
PROCEDURE TShowMovingsForm.ShowMaterialColoredElement(Canvas:TCanvas;OneElement:TOneElement);
VAR
  x1,x2,x3,y1,y2,y3   : Integer;
  OneNode             : TOneNode;
  TempBrushColor      : TColor;
  TempPenColor        : TColor;

BEGIN

  OneNode:=Nodes_Result.GetNode(OneElement.Node1);
  x1:=Xreal2Xpaint(OneNode.x);
  y1:=Yreal2Ypaint(OneNode.y);
  OneNode:=Nodes_Result.GetNode(OneElement.Node2);
  x2:=Xreal2Xpaint(OneNode.x);
  y2:=Yreal2Ypaint(OneNode.y);
  OneNode:=Nodes_Result.GetNode(OneElement.Node3);
  x3:=Xreal2Xpaint(OneNode.x);
  y3:=Yreal2Ypaint(OneNode.y);
  TempBrushColor:=Canvas.Brush.Color;
  TempPenColor:=Canvas.Pen.Color;
  Canvas.Pen.Color := clBlack;
  case OneElement.Material of
    1: Canvas.Brush.Color :=  ColorMinus.Color;
    2: Canvas.Brush.Color :=  ColorZero.Color;
    3: Canvas.Brush.Color :=  ColorPlus.Color;
  end;
  Canvas.Polygon([point(x1,y1),point(x2,y2),point(x3,y3)]);
  Canvas.Brush.Color:=TempBrushColor;
  Canvas.Pen.Color:=TempPenColor;

END;

PROCEDURE TShowMovingsForm.ShowElementOld;
VAR
  OneNode : TOneNode;
  x1, y1  : INTEGER;
  x2, y2  : INTEGER;
  x3, y3  : INTEGER;
  K_M     : MyReal;

BEGIN
  K_M:=Form1.Mover.Position*MoverK;
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node1,K_M);
  x1:=Xreal2Xpaint(OneNode.x);
  y1:=Yreal2Ypaint(OneNode.y);
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node2,K_M);
  x2:=Xreal2Xpaint(OneNode.x);
  y2:=Yreal2Ypaint(OneNode.y);
  OneNode:=Nodes_Result.GetMovedNode(OneElement.Node3,K_M);
  x3:=Xreal2Xpaint(OneNode.x);
  y3:=Yreal2Ypaint(OneNode.y);
  Canvas.Polygon([point(x1,y1),point(x2,y2),point(x3,y3)]);
  IF UseNumZone.Checked THEN ShowText(Canvas,ROUND((x1+x2+x3)/3),ROUND((y1+y2+y3)/3),inttostr(OneElement.Number));

  IF UseNumMater.Checked THEN begin
   Canvas.Brush.Style:=bsClear;
   ShowText(Canvas,ROUND((x1+x2+x3)/3),ROUND((y1+y2+y3)/3),inttostr(OneElement.Material));
  END;
END;

//значение текущего напряжения в узлах элемента
FUNCTION TShowMovingsForm.StressInElement(OneElement : TOneElement;VAR stress : ElStressArray):BOOLEAN;
VAR
  Count      : ARRAY [1..3] OF BYTE;
  K          : ARRAY [1..3] OF MyReal;
  Node       : ARRAY [1..3] OF TOneNode;
  Strain     : ARRAY [1..3] OF MyReal;
  X,Y,X_OPT,Y_OPT        : MyReal;
  RX,RY      : MyReal;
  i,j        : BYTE;
  z,Num      : INTEGER;

BEGIN
  // Определяем координаты узлов, которые образуют КЭ.
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);

  j:= Form1.StressType.ItemIndex+1;

  FOR i:=1 TO 3 DO BEGIN
    Strain[i]:=0;
    Count[i]:=0;
  END;
  // Определяем сумму напряжений в каждом из 3-х узлов.
  Num := Elements_Result.GetNumElements;
  FOR z:=1 TO Num DO BEGIN
    OneElement:=Elements_Result.GetElement(z);
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        Strain[i]:=Strain[i]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  END;
  // Определяем среднее напряжение в каждом из 3-х узлов.
  FOR i:=1 TO 3 DO Strain[i]:=MyDiv(Strain[i], Count[i]);
  // Определяем точку равнодействующей напряжний в 3-х узлах.
  RX:=MyDiv(Node[1].X*Strain[1]+Node[2].X*Strain[2]+Node[3].X*Strain[3], Strain[1]+Strain[2]+Strain[3]);
  RY:=MyDiv(Node[1].Y*Strain[1]+Node[2].Y*Strain[2]+Node[3].Y*Strain[3], Strain[1]+Strain[2]+Strain[3]);
  // Средняя точка
  X_OPT:=(node[1].x+node[2].x+node[3].x)/3;
  Y_OPT:=(node[1].y+node[2].y+node[3].y)/3;
  FOR z:=1 to 3 do begin
    X:=node[z].x + (X_OPT-node[z].x)/10000;
    Y:=node[z].y + (Y_OPT-node[z].y)/10000;
    // Для каждой из 3-х вершин определяем коэффициент ее влияния на напряжение в ТОЧКЕ.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // Определяем напряжение в ТОЧКЕ.
    stress[z]:=MyDiv(Strain[1]*K[1]+Strain[2]*K[2]+Strain[3]*K[3], K[1]+K[2]+K[3]);
  end;
  Result:=TRUE;
END;


PROCEDURE TShowMovingsForm.ShowAxes;
BEGIN
  IF (UseAxes.Checked) THEN BEGIN
    WITH Canvas DO BEGIN
      Pen.Color:=clBlack;
      Brush.Style:=bsClear;
      Moveto(0,Yreal2Ypaint(0));
      LineTo(PaintWidth,Yreal2Ypaint(0));
      Moveto(Xreal2Xpaint(0),0);
      LineTo(Xreal2Xpaint(0),PaintHeight);
    END;
  END;
END;

PROCEDURE TShowMovingsForm.ShowSelectedPoint;
VAR Xi, Yi : Integer;
BEGIN
      IF ( NOT DrawSelectedPoint ) THEN
        exit;
      Xi := Xreal2Xpaint(X);
      Yi := Yreal2Ypaint(Y);
      WITH Canvas DO BEGIN
        Canvas.Brush.Color := clRed;
        //Brush.Color := clRed;
        //Brush.Style := bsClear;
        Ellipse(Xi - 3, Yi - 3, Xi + 3, Yi + 3);
      END;
END;

//показывает все элементы
PROCEDURE TShowMovingsForm.ShowElements(Canvas:TCanvas);
VAR
  OneElement : TOneElement;
  my : integer;
  findlevel : integer;

BEGIN
  WITH Canvas DO BEGIN
    Brush.Color:=BackGR;
    FillRect(ClipRect);
    //for my:=63 to 64 do begin
    if LinesShow = true then
    begin
        if Form1.CheckBox1.Checked = true then
        begin
                for my:=1 to Elements_Result.GetNumElements do
                begin
                        OneElement:=Elements_Result.GetElement(my);
                        ShowElement(Canvas,OneElement);
                end
        end
        else
        begin
                for my:=1 to Elements_Result.GetNumElements do
                begin
                        OneElement:=Elements_Result.GetElement(my);
                        ShowElement1(Canvas,OneElement);
                end
        end
    end else begin
      if not(Form1.CheckBox2.Checked=True) then begin
        for my:=1 to Elements_Result.GetNumElements do begin
          OneElement:=Elements_Result.GetElement(my);
          //Изменено Маковецким А.О. 30.05.2009
          //Суть изменения: - изменен расчет номера уровня. А именно: приведение к нулю сделано идеалогически верно.
          //Из текущего напряжения я отнимаю минимальное напряжение данного типа, таким образом минимальное значение
          //напряжения соответвует нулевому уровню шкалы.
          IF OneElement.strain[Form1.StressType.ItemIndex+1]=Elements_Result.max[Form1.StressType.ItemIndex+1] THEN findlevel:=Form1.ChangeLegend.Position
          ELSE findlevel:=Trunc(MyDiv((OneElement.strain[Form1.StressType.ItemIndex+1]-(Elements_Result.min[Form1.StressType.ItemIndex+1])),Level))+1;
          Brush.Color:=GenerateColorOld(findlevel-1);
          ShowElementOld(Canvas,OneElement);
        end;
      end else begin
        //добавлено Давыдовой Ю.А.
        for my := 1 to Elements_Result.GetNumElements do begin
          OneElement:=Elements_Result.GetElement(my);
          ShowMaterialColoredElement(Canvas,OneElement);
        end;
      end;
    end;
  END;
  If Prd=1 Then UseTestElements(Canvas);

  PaintZonesContour(Canvas);
  ShowBoundForce(Canvas);
  IF (Form1.InfoFiniteElementNumber.Text<>'')  then ShowOneElementInfo(Canvas);
  ShowAxes(Canvas);
  ShowSelectedPoint(Canvas);
END;

// Функция получения имени файла с размерностью
function getDimFileName(f:string):string;
var
     i : integer;
     s, s1 : string;
begin
     i := 0;
     s1 := f;
     while pos('.',s1) > 0 do
     begin
          i := i + pos('.',s1);
          delete(s1,1,pos('.',s1));
     end;
     s := copy(f,1,i-1);
     Result := s;
end;

{
Функция для получение
имени проекта из
полного пути к файлу проекта
который лежит в реестре
}
function GetProjectName:String;
var
  projName:String;
  tempStr:String;
  slashPos:Integer;
  Registry:TRegistry;
begin
      projName := '';
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg, true) then
     begin
          if Registry.ValueExists('InputFileName') then
          begin
          // Получаем полный путь до файла проекта
            tempStr:=Registry.ReadString('InputFileName');

            // Получаем только имя файла проекта
            while(Pos('\',tempStr) <> 0) do
            begin
              slashPos:= Pos('\',tempStr);
              Delete(tempStr,1,slashPos);
            end;
            Delete(tempStr,Pos('.',tempStr),Length(tempStr));
            // Удаляем расширение и получаем имя проекта
            projName:= tempStr;
          end;
     end;
     Result := projName;
End;

PROCEDURE TShowMovingsForm.FormCreate(Sender:TObject);
var
     MainParams,MP    : TMainParams;
     MPM              : TMainParamsMaterial;
BEGIN
ScrollBox1.Visible:=False;
    // создать панель настроек, но пока не показывать
    Form1 := TForm1.Create(Self);
Caption:=Caption + ' ' +GetProjectName;
Form1.Caption:= Form1.Caption + ' проекта ' +GetProjectName;
//--------------------------------------//
  with TZonesClass.Create do
  begin
    Load(Project_GetFormFile);
    //перенесено в группированную таблицу (2018)
    Form1.NRCNum.Caption:=IntToStr(MainParamsClass.MainParams.NRC);
    Form1.ForceLbl.Caption:=GetSilaName(GetSila);
    Form1.DimLbl.Caption:=GetDimensionName(GetCurDim);
   // Form1.Edit4.Text:=IntToStr(MainParamsClass.MainParams.NRC);               //отображение результата на новой форме (2012)
   // Form1.Edit5.Text:=GetSilaName(GetSila);
    //Form1.Edit6.Text:=GetDimensionName(GetCurDim);
    Free;
  end;
//--------------------------------------//
  bmpPic:=Tbitmap.Create;
  Updating:=FALSE;
  Force:=clBlue;
  BackGR:=clWhite;
  OnlyUpdate:=TRUE;
  MousePushed:=FALSE;
  CM:=Screen.PixelsPerInch/CM_Inch;
  Nodes_Result:=TNodes.Create;
  Elements_Result:=TElements.Create;
  ZoneContour:=ZoneContourPoints.Create;
  Left:=0;
  Top:=60;
  OffsetX:=0;
  OffsetY:=0;
  ActiveToolButton:=DefaultAction;
  Scale:=1;
  OnlyUpdate:=FALSE;
  StressMethod := StressMethodLoad(1);
  DrawSelectedPoint := False;  
  //начальные цвета
  //CPlus:=RGB(255,0,0);
  //CMinus:=RGB(0,255,0);
  //LinesCPlus:=RGB(255,0,0);
  //LinesCMinus:=RGB(255,0,255);

  case StressMethod of
  1: Form1.StressMethod1.Checked :=True;
  2: Form1.StressMethod2.Checked :=True;
  3: Form1.StressMethod3.Checked :=True;
  end;
END;

PROCEDURE TShowMovingsForm.FormDestroy(Sender:TObject);
BEGIN
  Nodes_Result.Free;
  Elements_Result.Free;
END;


PROCEDURE TShowMovingsForm.FormResize(Sender:TObject);
VAR
  dop : INTEGER;
  cfF : TIniFile;
  SigmaLocation:string;
  i:integer;
BEGIN
  // Сохранение параметов формы
  dop:=0;
  top:=0;
       //определение места расположения Сигмы
     SigmaLocation   :=LowerCase(ExtractFilePath(ParamStr(0)));
     i:=pos('\bin',SigmaLocation);
     if i>0 then SetLength(SigmaLocation,i);
     cfF:=TIniFile.Create(SigmaLocation+'bin\sforms.ini');

//  cfF:=TIniFile.Create('sforms.ini');
  TRY
    dop:=CfF.ReadInteger('Главная','Высота',top);
    top:=dop-StatusBar1.Height-8;
    left:=0;
    Height:=Screen.Height-dop;
    cfF.Free;
  EXCEPT
    MessageDlg('Не могу прочитать файл sforms.ini!',mtError,[mbOk],0);
  END;
  Constraints.MaxHeight:=Screen.Height-dop;
  top:=dop-StatusBar1.Height-8;
  ChangeDrawSize;
END;


PROCEDURE TShowMovingsForm.PaintBox1Paint(Sender: TObject);
VAR
  Bitmap : TBitMap;

BEGIN
  IF OnlyUpdate THEN EXIT;
  PaintWidth:=PaintBox1.Width;
  PaintHeight:=PaintBox1.Height;
  CenterX:=Trunc(PaintWidth/2);
  CenterY:=Trunc(PaintHeight/2);
  PaintBox1.Canvas.Lock;
  TRY
    IF UseBuffer.Checked THEN BEGIN
      Bitmap := TBitmap.Create;
      Bitmap.Width:=PaintBox1.Width;
      Bitmap.Height:=PaintBox1.Height;
    END;
    IF UseBuffer.Checked THEN BEGIN
      ShowElements(BitMap.Canvas);
      paintbox1.Canvas.Draw(0,0,BitMap);
    END
    ELSE ShowElements(PaintBox1.Canvas);
  FINALLY
    IF UseBuffer.Checked THEN BEGIN
      // помещение изображения с формы в переменную
      bmpPic.Width:=Bitmap.Width;
      bmpPic.Height:=Bitmap.Height;
      bmpPic.Canvas.Draw(0,0,BitMap);
      Bitmap.Free;
    END;
  END;
  PaintBox1.Canvas.Unlock;
END;


PROCEDURE TShowMovingsForm.UseLegendClick(Sender: TObject);
BEGIN
  IF UseLegend.Checked THEN BEGIN
    Splitter2.Visible:=TRUE;
    LegendPanel.Visible:=TRUE;
  END
  ELSE BEGIN
    Splitter2.Visible:=FALSE;
    LegendPanel.Visible:=FALSE;
  END;
  ChangeDrawSize;
END;

PROCEDURE TShowMovingsForm.UseLinesClick(Sender: TObject);
VAR
  z : integer;
BEGIN

if (Form1.UseLines.Checked) then Form1.TestElements.Checked:=false;
if Form1.checkbox1.Checked then Form1.checkbox2.Checked:=false; //Давыдова Ю.А.

if Form1.useLines.Checked then Form1.checkbox2.Checked:=false; //Давыдова Ю.А.

  if (Sender = Form1.UseLines) and (Form1.UseLines.Checked = false) then
        Form1.CheckBox1.Checked := false;
  if (Sender = Form1.CheckBox1) and (Form1.CheckBox1.Checked = true) then begin
        Form1.CheckBox1.Checked := true;
        Form1.UseLines.Checked := true;
  end;

    IF Form1.CheckBox1.Checked = false THEN BEGIN
        Spin_0_max.Visible := false;
        Spin_0_min.Visible := false;
        mi.Visible := false;
        pl.Visible := false;
  end
  else begin
        Spin_0_max.Visible := true;
        Spin_0_min.Visible := true;
        mi.Visible := true;
        pl.Visible := true;
  end;

  IF Form1.UseLines.Checked = true THEN BEGIN
      LinesShow:=true;
      Form1.ChangeLegend.Max := 60;
      if Form1.ChangeLegend.Position > 60 then
        Form1.ChangeLegend.Position:=60;
      ColorMinus_0.Visible := true;
      ColorPlus_0.Visible := true;
      ColorZero.Visible := false;
      ColorZeroPluss.Visible:=false;
      //added in 2012
     // Spin_0_max.Visible := true;
      //Spin_0_min.Visible := true;
      //ColorPlus.Color:=LinesCPlus;
      //ColorMinus.Color:=LinesCMinus;
      //ColorZero.Enabled:=false;
  END
  ELSE BEGIN
      LinesShow:=false;
      Form1.ChangeLegend.Max := 255;
      ColorZeroPluss.Visible:=true;
      ColorZero.Visible := true;

      ColorPlus_0.Visible := false;
      ColorMinus_0.Visible := false;
      Spin_0_max.Visible := false;
      Spin_0_min.Visible := false;

      //ColorPlus.Color:=CPlus;
      //ColorMinus.Color:=CMinus;
      //ColorZero.Enabled:=true;
  END;



  z := Form1.ChangeLegend.Position;
  if (Form1.UseLines.Checked = true) and (Form1.CheckBox1.Checked = true) then z := 4;
  Form1.ChangeLegend.Hint:=inttostr(z);
  Form1.LevelNumber.Caption:= Form1.ChangeLegend.Hint;
  ChengeLegendLevel;
  LegendRePaint;
  MainRePaint;
END;

PROCEDURE TShowMovingsForm.RePaintPlate(Sender: TObject);
BEGIN
  if UseBuffer.Checked then DoubleBuffered:=true else DoubleBuffered:=false;
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.EditScaleChange(Sender: TObject);
BEGIN
  SetDiapazon;
END;


PROCEDURE TShowMovingsForm.TrackBar1Change(Sender: TObject);
VAR
  Half,Value : MyReal;

BEGIN
  Half:=ROUND((TrackBar1.Max)/2);
  Value:=ABS(Form1.TrackBar1.Position-Half);
  IF Form1.TrackBar1.Position>=Half THEN Scale:=1+Value ELSE Scale:=1/(1+Value);
  Scaling;
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.ChangeLegendChange(Sender: TObject);
VAR
   z:integer;
BEGIN
if (Spin_0_max.text = '') then exit;
if (Spin_0_min.text = '') then exit;
  z := Form1.ChangeLegend.Position;
  if (Form1.UseLines.Checked = true) and (Form1.CheckBox1.Checked = true) then z := 4;

  Form1.ChangeLegend.Hint:=inttostr(z);
  Form1.LevelNumber.Caption:= Form1.ChangeLegend.Hint;             //теперь ползунок "количество цветовых градаций" на основной форме бессмыслененн...
  ChengeLegendLevel;
  MainRePaint;
  LegendRePaint;
END;




// вывод легенды
PROCEDURE TShowMovingsForm.LegendPaint(Sender: TObject);

  PROCEDURE ShowLegendHints(Canvas:TCanvas;Left,Top:INTEGER);
  VAR
    long,k              : MyReal;
    pos                 : INTEGER;
    dop,dop1,dop2       : INTEGER; //dop - для середины, 1dop - между max и dop, 2dop - между dop и min
    dopp,dopp1,dopp2    : MyReal;
    dopSt,dopSt1,dopSt2 : STRING;
    len,dlevel          : MyReal;
    koef                : INTEGER;
    text                : STRING;
  BEGIN
    len:=(Legend.Height- 2*Top)/Form1.ChangeLegend.Position;
    dlevel:= (Elements_Result.Max[Form1.StressType.ItemIndex+1] - Elements_Result.Min[Form1.StressType.ItemIndex+1])/Form1.ChangeLegend.Position;
    pos:=0;
    koef:=1 + trunc(30/len);
    while pos < Form1.ChangeLegend.Position + 1 - trunc(1/koef) do
    begin
      text:= MyFloatToStr(Elements_Result.Min[Form1.StressType.ItemIndex+1]+dlevel*pos);
      Canvas.TextOut(left,Legend.Height - 2*Top + 5 - trunc(len*pos),text);
      pos := pos + koef;
    end;
    text:= MyFloatToStr(Elements_Result.Max[Form1.StressType.ItemIndex+1]);
    Canvas.TextOut(left,Legend.Height - 2*Top + 5 - trunc(len*Form1.ChangeLegend.Position),text);

    exit;
    IF Elements_Result.Max[Form1.StressType.ItemIndex+1]>0 THEN BEGIN
      IF Elements_Result.Min[Form1.StressType.ItemIndex+1]>0 THEN BEGIN
        Long:=Elements_Result.Max[Form1.StressType.ItemIndex+1];
        k:=MyDiv((Legend.Height-2*Top),Long);
        pos:=ROUND((Elements_Result.Max[Form1.StressType.ItemIndex+1]-Elements_Result.Min[Form1.StressType.ItemIndex+1])*k);
        Canvas.TextOut(Left,Top-5,MyFloatToStr(Elements_Result.Max[Form1.StressType.ItemIndex+1]));
        Canvas.TextOut(Left,Legend.Height-Top-5,'0');
        Canvas.TextOut(Left,Top+pos-5,MyFloatToStr(Elements_Result.Min[Form1.StressType.ItemIndex+1]));
        dop:=(Legend.Height-10) div 2; //вычисляем середину для выводаа
        dopp:=(Elements_Result.Max[Form1.StressType.ItemIndex+1]+Elements_Result.Min[Form1.StressType.ItemIndex+1])/2;//среднее значение
        dopSt:=MyFloatToStr(dopp);// преобразуем в строку
        {dopSt:=CutStr(dopSt);}
        Canvas.TextOut(Left,dop,dopSt);// вывод на экран
        dop1:=dop-(dop div 2);
        dop2:= dop+(dop div 2);
        dopp1:=dopp+dopp/2;
        dopp2:=dopp-dopp/2;
        dopSt1:=MyFloatToStr(dopp1);
        {dopSt1:=CutStr(dopSt1);}
        dopSt2:=MyFloatToStr(dopp2);
        {dopSt2:=CutStr(dopSt2);}
        Canvas.TextOut(Left,dop1,dopSt1);
        Canvas.TextOut(Left,dop2,dopSt2);
      END
      ELSE BEGIN
        Long:=Elements_Result.Max[Form1.StressType.ItemIndex+1]-Elements_Result.Min[Form1.StressType.ItemIndex+1];
        k:=MyDiv((Legend.Height-2*Top),Long);
        pos:=ROUND((Elements_Result.Max[Form1.StressType.ItemIndex+1])*k);
        Canvas.TextOut(Left,Top-5,MyFloatToStr(Elements_Result.Max[Form1.StressType.ItemIndex+1]));
        Canvas.TextOut(Left,Legend.Height-Top-5,MyFloatToStr(Elements_Result.Min[Form1.StressType.ItemIndex+1]));
        dop:=(Legend.Height-10) div 2; //вычисляем середину для вывода
        dopp:=(Elements_Result.Max[Form1.StressType.ItemIndex+1]+Elements_Result.Min[Form1.StressType.ItemIndex+1])/2;//среднее значение
        dopSt:=MyFloatToStr(dopp);// преобразуем в строку
        {dopSt:=CutStr(dopSt);}
        Canvas.TextOut(Left,dop,dopSt);// вывод на экран
        dop1:= dop-(dop div 2);
        dop2:= dop+(dop div 2);
        dopp1:=dopp+dopp/2;
        dopp2:=dopp-dopp/2;
        dopSt1:=MyFloatToStr(dopp1);
        {dopSt1:=CutStr(dopSt1);}
        dopSt2:=MyFloatToStr(dopp2);
        {dopSt2:=CutStr(dopSt2);}
        Canvas.TextOut(Left,dop1,dopSt1);
        Canvas.TextOut(Left,dop2,dopSt2);
      END;
    END
    ELSE BEGIN
      Long:=-Elements_Result.Min[Form1.StressType.ItemIndex+1];
      k:=MyDiv((Legend.Height-2*Top),Long);
      pos:=ROUND((-Elements_Result.Max[Form1.StressType.ItemIndex+1])*k);
      Canvas.TextOut(Left,Top-5,'0');
      Canvas.TextOut(Left,Legend.Height-Top-5,MyFloatToStr(Elements_Result.Min[Form1.StressType.ItemIndex+1]));
      Canvas.TextOut(Left,Top+pos-5,MyFloatToStr(Elements_Result.Max[Form1.StressType.ItemIndex+1]));
      dop:=(Legend.Height-10) div 2; //вычисляем середину для вывода
      dopp:=(Elements_Result.Max[Form1.StressType.ItemIndex+1]+Elements_Result.Min[Form1.StressType.ItemIndex+1])/2;//среднее значение
      dopSt:=MyFloatToStr(dopp);// преобразуем в строку
      {dopSt:=CutStr(dopSt);}
      Canvas.TextOut(Left,dop,dopSt);// вывод на экран
      dop1:=dop-(dop div 2);
      dop2:=dop+(dop div 2);
      dopp1:=dopp+dopp/2;
      dopp2:=dopp-dopp/2;
      dopSt1:=MyFloatToStr(dopp1);
      dopSt2:=MyFloatToStr(dopp2);
      {dopSt1:=CutStr(dopSt1);}
      {dopSt2:=CutStr(dopSt2);}
      Canvas.TextOut(Left,dop1,dopSt1);
      Canvas.TextOut(Left,dop2,dopSt2);
    END;
  END;

  PROCEDURE ShowLegendHintsNew(Canvas:TCanvas;Left,Top:INTEGER);
  VAR
    long,k              : MyReal;
    pos                 : INTEGER;
    dop,dop1,dop2       : INTEGER; //dop - для середины, 1dop - между max и dop, 2dop - между dop и min
    dopp,dopp1,dopp2    : MyReal;
    dopSt,dopSt1,dopSt2 : STRING;
    len,dlevel          : MyReal;
    koef                : INTEGER;
    text,st             : STRING;
    z : integer;
  BEGIN
    if (Form1.UseLines.Checked = true) and (Form1.CheckBox1.Checked = false) then
    begin
      ShowLegendHints(Canvas, Left, Top);
      exit;
    end;
    z := Form1.ChangeLegend.Position;
    if (Form1.UseLines.Checked = true) and (Form1.CheckBox1.Checked = true) then z := 4;
    len:=(Legend.Height- 2*Top)/z;
    for pos := 0 to z do
    begin
    //st := 'L ' + IntToStr(pos);
    //ShowMessage(st);
    if pos >= level_zero then
    begin
        text:= MyFloatToStr((pos-level_zero) * level_plus);
    end
    else
    begin
        text:= MyFloatToStr(Elements_Result.Min[Form1.StressType.ItemIndex+1]+(pos * level_minus));
    end;
        if (UseLines.Checked = true) and (CheckBox1.Checked = true) then
        begin
                if (pos = 0) then begin
                text := MyFloatToStr(Elements_Result.Min[Form1.StressType.ItemIndex+1]);
                if -abs(Spin_0_min.Value) <= Elements_Result.min[Form1.StressType.ItemIndex+1] then
                text:= MyFloatToStr(-abs(Spin_0_min.Value) - 100);
                end;
                if (pos = 1) then text := '-' + MyFloatToStr(abs(Spin_0_min.Value));
                if (pos = 2) then text := '0';
                if (pos = 3) then text := MyFloatToStr(abs(Spin_0_max.Value));
        end;
    Canvas.TextOut(left,Legend.Height - 2*Top + 5 - trunc(len*pos),text);

    end;
    if Elements_Result.Max[Form1.StressType.ItemIndex+1] >= 0 then
    text:= MyFloatToStr(Elements_Result.Max[Form1.StressType.ItemIndex+1])
    else
    text:= '0,00';
    if (UseLines.Checked = true) and (CheckBox1.Checked = true) and
     (abs(Spin_0_max.Value) >= Elements_Result.Max[Form1.StressType.ItemIndex+1]) then
        text:= MyFloatToStr(abs(Spin_0_max.Value) + 100);
    Canvas.TextOut(left,Legend.Height - 2*Top + 5 - trunc(len*z),text);
  END;

  PROCEDURE ShowLegend(Canvas:TCanvas;Left,Top,Width:INTEGER;Step:MyReal);
  VAR
    i,k  : WORD;
    Rect : TRect;
    z : integer;
  BEGIN
    Canvas.Brush.Color:=BackGR;
    Canvas.FillRect(Canvas.ClipRect);
    Rect.Left:=Left;
    Rect.Right:=Left+Width;
    Canvas.Pen.Color:=clBlack;
    z := Form1.ChangeLegend.Position;
    if (Form1.UseLines.Checked = true) and (Form1.CheckBox1.Checked = true) then z := 4;
    FOR i:=0 TO z-1 DO BEGIN
      k:=z-1-i;
      if LinesShow = true then
        //if CheckBox1.Checked = false then
        Canvas.Brush.Color:=GenerateColor(i)
        //else
        //Canvas.Brush.Color:=GenerateColor1(i)
      else
        Canvas.Brush.Color:=GenerateColorOld(i);
      Rect.Top:=Top+trunc(Step*k);
      Rect.Bottom:=1+Top+trunc(Step*(k+1));
      Canvas.FillRect(Rect);
      Canvas.Brush.Color:=clBlack;
      Canvas.FrameRect(Rect);
    END;
    Canvas.Brush.Color:=BackGR;
        if UseLines.Checked = true then
                ShowLegendHintsNew(Canvas,Rect.Right,Top)
        else
                ShowLegendHints(Canvas,Rect.Right,Top);
  END;

VAR
  Bitmap : TBitMap;
  z : integer;
BEGIN
  TRY
    IF UseBuffer.Checked THEN BEGIN
      Bitmap:=TBitmap.Create;
      Bitmap.Width:=Legend.Width;
      Bitmap.Height:=Legend.Height;
    END;
    z := Form1.ChangeLegend.Position;
    if (Form1.UseLines.Checked = true) and (Form1.CheckBox1.Checked = true) then z := 4;

    IF UseBuffer.Checked THEN BEGIN
      ShowLegend(BitMap.Canvas,paintdx,paintdy,20,(Legend.Height-paintdy*2)/z);
      Legend.Canvas.Draw(0,0,BitMap);
    END
    ELSE ShowLegend(Legend.Canvas,paintdx,paintdy,20,(Legend.Height-paintdy*2)/z);
  FINALLY
    IF UseBuffer.Checked THEN Bitmap.Free;
  END;
END;


PROCEDURE TShowMovingsForm.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: INTEGER);
BEGIN
  IF MousePushed THEN BEGIN
    IF ActiveToolButton=MoveAction THEN BEGIN
      OffsetX:=SOffsetX+(Xpaint2Xreal(X)-Xpaint2Xreal(DownX));
      OffsetY:=SOffsetY+(Ypaint2Yreal(Y)-Ypaint2Yreal(DownY));
      MainRePaint;
    END
    ELSE IF ActiveToolButton=ZoomAreaAction THEN BEGIN
      MainRePaint;
      PaintBox1.Canvas.Brush.Style:=bsClear;
      PaintBox1.Canvas.Pen.Style:=psDash;
      PaintBox1.Canvas.Rectangle(X+cursorcrosdx,Y+cursorcrosdx,DownX+cursorcrosdx,DownY+cursorcrosdx);
    END;
  END;
  IF ActiveToolButton=DefaultAction THEN BEGIN
    MouseX:=Xpaint2Xreal(x);
    MouseY:=Ypaint2Yreal(y);
    StatusBar1.Panels[0].Text:=MyFloatToStr(MouseX);
    StatusBar1.Panels[1].Text:=MyFloatToStr(MouseY);
    IF MousePushed THEN PaintBox1Click;
  END;
END;


PROCEDURE TShowMovingsForm.MoverChange(Sender: TObject);
BEGIN
  ChangeDrawSize;
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.ShowForm;
BEGIN
  LoadResults(ResFile);
  FigureX:=(Nodes_Result.Area.maxx-Nodes_Result.Area.minx)/2;
  FigureY:=(Nodes_Result.Area.maxy-Nodes_Result.Area.miny)/2;
  IF Error<>0 THEN BEGIN
    ShowMessage('Файл результат содержит ошибки: '+ Error_Text[Error]); //imametdinov
    exit;
  END
  ELSE BEGIN
    SetDiapazon;
    Show;
    Form1.ChangeLegend.Position:=4;
    //BestFitActionClick(nil);
  END;
END;


PROCEDURE TShowMovingsForm.FormClose(Sender: TObject; VAR Action: TCloseAction);
BEGIN
  SaveForm('ShowGrafical');
  Action:=caFree;
  ShowMovingsForm:=nil;
  // освобождаем переменную для сохранения и печати
  bmpPic.Free;
  CheckState;
END;


PROCEDURE TShowMovingsForm.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
BEGIN
DrawSelectedElement:=TRUE;
  DownX:=X;
  DownY:=Y;
  IF MoveAction.Down THEN BEGIN
    SOffsetX:=OffsetX;
    SOffsetY:=OffsetY;
    Screen.Cursor:= HandAct;
  END;
  IF ActiveToolButton=DefaultAction THEN PaintBox1Click;
  MousePushed:=TRUE;
END;


PROCEDURE TShowMovingsForm.ZoomAreaRect(x1,y1,x2,y2:MyReal);
VAR
  x,y : MyReal;

BEGIN
  IF x1>x2 THEN BEGIN
    x:=x2;
    x2:=x1;
    x1:=x;
  END;
  IF y1>y2 THEN BEGIN
    y:=y2;
    y2:=y1;
    y1:=y;
  END;
  OffsetX:=FigureX-x1-(x2-x1)/2;
  OffsetY:=FigureY-y1-(y2-y1)/2;
  x:=MyDiv((CenterX*2-2*paintdx),(x2-x1)*CM);
  y:=MyDiv((CenterY*2-2*paintdy),(y2-y1)*CM);
  IF x>y THEN Scale:=y ELSE Scale:=x;
  SetScale;
END;


// отпустили кнопку мышки над объектом
PROCEDURE TShowMovingsForm.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: INTEGER);
BEGIN
DrawSelectedElement:=TRUE;
  IF ActiveToolButton=MoveAction THEN BEGIN
    OffsetX:=SOffsetX+(Xpaint2Xreal(X)-Xpaint2Xreal(DownX));
    OffsetY:=SOffsetY+(Ypaint2Yreal(Y)-Ypaint2Yreal(DownY));
    Screen.Cursor:= crDefault;
  END
  ELSE IF ActiveToolButton=ZoomAreaAction THEN BEGIN
    IF (ABS(X-DownX)>5) AND (ABS(Y-DownY)>5) THEN ZoomAreaRect(Xpaint2Xreal(X+cursorcrosdx), Ypaint2Yreal(Y+cursorcrosdx), Xpaint2Xreal(DownX+cursorcrosdx), Ypaint2Yreal(DownY+cursorcrosdx));
  END
  ELSE IF (ActiveToolButton=ZoomInAction) OR (ActiveToolButton=ZoomOutAction) THEN BEGIN
    OffsetX:=OffsetX+(Xpaint2Xreal(CenterX)-Xpaint2Xreal(X+11));
    OffsetY:=OffsetY+(Ypaint2Yreal(CenterY)-Ypaint2Yreal(Y+11));
    IF (ActiveToolButton=ZoomInAction) THEN Form1.TrackBar1.Position:=Form1.TrackBar1.Position+1         //обращение к ползунку на новой форме (2012)
    ELSE Form1.TrackBar1.Position:=Form1.TrackBar1.Position-1;
  END;
  IF ActiveToolButton<>DefaultAction THEN MainRePaint;
  MousePushed:=FALSE;
END;


// изменилось действие над объектом
PROCEDURE TShowMovingsForm.ChangeActionClick(Sender: TObject);

  PROCEDURE ChangeAction(Sender: TToolButton);
  BEGIN
    ActiveToolButton.Down:=FALSE;
    Sender.Down:=TRUE;
    ActiveToolButton:=Sender;
  END;

BEGIN
  ChangeAction(Sender as TToolButton);
  // перемещение объекта(скроллинг)
  IF ActiveToolButton=MoveAction THEN PaintBox1.Cursor:= HandPas
  // приближение
  ELSE IF ActiveToolButton=ZoomInAction THEN PaintBox1.Cursor:=ZoomIn
  // отдаление
  ELSE IF ActiveToolButton=ZoomOutAction THEN PaintBox1.Cursor:=ZoomOut
  // приблежение окрестности
  ELSE IF ActiveToolButton=ZoomAreaAction THEN PaintBox1.Cursor:=ZoomArea
  // нормальная работа
  ELSE IF ActiveToolButton=DefaultAction THEN PaintBox1.Cursor:= crDefault;
  MainRePaint;
END;


// Изменились единицы измерения
PROCEDURE TShowMovingsForm.BestFitActionClick(Sender: TObject);
BEGIN
  ZoomAreaRect(Nodes_Result.Area.minx,Nodes_Result.Area.miny,Nodes_Result.Area.maxx,Nodes_Result.Area.maxy);
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.ChangeColorClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=(Sender as TPanel).Color;
  IF ColorDialog1.Execute THEN BEGIN
    (Sender as TPanel).Color := ColorDialog1.Color;
    MainRePaint;
    LegendPaint(nil);
  END;
END;

//plus
{PROCEDURE TShowMovingsForm.ChangeColorPlus(Sender: TObject);
BEGIN
  ColorDialog1.Color:=ColorPlus.Color;
  IF ColorDialog1.Execute THEN BEGIN
    ColorPlus.Color := ColorDialog1.Color;
    if LinesShow = true then
      LinesCPlus:=ColorPlus.Color
    else
      CPlus:=ColorPlus.Color;
    MainRePaint;
    LegendPaint(nil);
  END;
END;

//minus
PROCEDURE TShowMovingsForm.ChangeColorMinus(Sender: TObject);
BEGIN
  ColorDialog1.Color:=(Sender as TPanel).Color;
  IF ColorDialog1.Execute THEN BEGIN
    (Sender as TPanel).Color := ColorDialog1.Color;
    if LinesShow = true then
      LinesCMinus:=ColorMinus.Color
    else
      CMinus:=ColorMinus.Color;
    MainRePaint;
    LegendPaint(nil);
  END;

END; }

PROCEDURE TShowMovingsForm.EditMoverChange(Sender: TObject);
VAR
  value : MyReal;

BEGIN
  value:=1;
  IF CheckReal(Form1.EditMover.text,value) THEN BEGIN
    IF (Value<=0) THEN BEGIN
      Form1.EditMover.text:='1';
      Value:=1;
    END;
    MoverK:=Value;
    MoverChange(nil);
  END;
END;



PROCEDURE TShowMovingsForm.PlusMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorPlus);
END;


PROCEDURE TShowMovingsForm.MinusMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorMinus);
END;


PROCEDURE TShowMovingsForm.ZeroMClick(Sender: TObject);
BEGIN
  ChangeColorClick(ColorZero);
END;


PROCEDURE TShowMovingsForm.BkgrMClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=BackGR;
  IF ColorDialog1.Execute THEN BEGIN
    BackGR := ColorDialog1.Color;
    LegendPanel.Color:=BackGR;
    Panel2.Color:=BackGR;
    MainRePaint;
    LegendPaint(nil);
  END;
END;


PROCEDURE TShowMovingsForm.ForceMClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=Force;
  IF ColorDialog1.Execute THEN BEGIN
    Force := ColorDialog1.Color;
    MainRePaint;
  END;
END;


PROCEDURE TShowMovingsForm.UpDown1ChangingEx(Sender: TObject; VAR AllowChange:BOOLEAN; NewValue:SMALLINT; Direction:TUpDownDirection);
CONST
  Step=0.1;

BEGIN
  IF Direction=updDown THEN ForceK:=ForceK-Step;
  IF Direction=updUP THEN ForceK:=ForceK+Step;
  Form1.EditForce.Text:=MyFloatToStr(ForceK);
  AllowChange:=FALSE;
END;


PROCEDURE TShowMovingsForm.EditXChange(Sender: TObject);
VAR
  value : MyReal;

BEGIN
  IF Updating THEN EXIT;
  value:=1;
  IF CheckReal((Sender as TEdit).text,value) THEN BEGIN
    IF Sender = Form1.EditX THEN X:=Value;
    IF Sender = Form1.EditY THEN Y:=Value;
    Pointed:=True;
    DrawSelectedElement:=TRUE;
    SolveInPoint;
    PaintBox1.Repaint;
    Pointed:=False;
  END;
END;

function MyFloatToStr_2(X:MyReal):String;
begin
     Result:=FormatFloat('0.0000E+00',X);
end;

// вывод рультатов в окошки
FUNCTION TShowMovingsForm.SolveInPoint : Boolean;
VAR
  st,move_st:TStressArray;
  Element : Integer;
  OneElement : TOneElement;
BEGIN
//------
  IF StressInPointType(X,Y,st,StressMethod) and MoveInPoint(X,Y, move_st) THEN BEGIN
{    InfoX.text:=cutStr(MyFloatToStr(st[1]));
    InfoY.text:=cutStr(MyFloatToStr(st[2]));
    InfoXY.text:=cutStr(MyFloatToStr(st[3]));
    InfoMax.text:=cutStr(MyFloatToStr(st[4]));
    InfoMin.text:=cutStr(MyFloatToStr(st[5]));
    InfoConer.text:=cutStr(MyFloatToStr(st[6]));     }

    Element := 1 + Elements_Result.FindElementByPoint(X,Y,Form1.Mover.Position*MoverK);
    Form1.InfoFiniteElementNumber.text:= IntToStr(Element);
    Form1.CurElemNum.Caption:= IntToStr(Element);
    Form1.InfoX1.Caption:=MyFloatToStr(st[1]);
    Form1.InfoY1.Caption:=MyFloatToStr(st[2]);
    Form1.InfoXY1.Caption:=MyFloatToStr(st[3]);
    Form1.InfoMax1.Caption:=MyFloatToStr(st[4]);
    Form1.InfoMin1.Caption:=MyFloatToStr(st[5]);
    Form1.InfoConer1.Caption:=MyFloatToStr(st[7]);
    Form1.InfoEcv1.Caption:=MyFloatToStr(st[6]);

    //TODO
    Form1.InfoMoveX.Caption:=MyFloatToStr_2(move_st[1]);
    Form1.InfoMoveY.Caption:=MyFloatToStr_2(move_st[2]);
    // Показываем св-ва КЭ
    OneElement:=Elements_Result.GetElement(Element);
    Form1.KENumber1.Text  := IntToStr(Element);
    Form1.MUprug1.Caption    := MyFloatToStr(Materials[OneElement.Material].E);
    Form1.KoefPuas1.Caption  := MyFloatToStr(Materials[OneElement.Material].Mu);
    Form1.DopNapr1.Caption   := MyFloatToStr(Materials[OneElement.Material].Sg);
    Form1.DopNapr2.Caption   := MyFloatToStr(Materials[OneElement.Material].free4);
    Form1.Thickness1.Caption := MyFloatToStr(Materials[OneElement.Material].Thickness);

    DrawSelectedPoint := True;
    Result := True;
    ShowSelectedPoint(Canvas);
  END
  ELSE BEGIN
    DrawSelectedPoint := False;
    InfoFiniteElementNumber.text:='';
    Form1.InfoX1.Caption:='';
    Form1.InfoY1.Caption:='';
    Form1.InfoXY1.Caption:='';
    Form1.InfoMax1.Caption:='';
    Form1.InfoMin1.Caption:='';
    Form1.InfoConer1.Caption:='';
    Form1.InfoEcv1.Caption:='';
    // Показываем св-ва КЭ
    Form1.KENumber1.Text := '';
    Form1.MUprug1.Caption    := '';
    Form1.KoefPuas1.Caption  := '';
    Form1.DopNapr1.Caption   := '';
    //-----------------------------
    Form1.DopNapr2.Caption   := '';
    Form1.Thickness1.Caption := '';
    Result := False;
  END;
END;

//получение напряжение а точке
FUNCTION TShowMovingsForm.StressInPoint(X,Y:MyReal;VAR st:TStressArray):BOOLEAN;
VAR
  Element    : INTEGER;
  OneElement : TOneElement;
  Count      : ARRAY [1..3] OF BYTE;
  K          : ARRAY [1..3] OF MyReal;
  Node       : ARRAY [1..3] OF TOneNode;
  Strain     : ARRAY [1..3,1..6] OF MyReal;
  RX,RY      : MyReal;
  i,j        : BYTE;

BEGIN
  Result:=FALSE;
  // Определяем, какому КЭ принадлежит ТОЧКА.
  Element:=Elements_Result.FindElementByPoint(X,Y,Form1.Mover.Position*MoverK);
  IF Element=-1 THEN EXIT;
  // Определяем координаты узлов, которые образуют КЭ.
  OneElement:=Elements_Result.GetElement(Element+1);
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
  FOR i:=1 TO 3 DO BEGIN
    FOR j:=1 TO 6 DO Strain[i,j]:=0;
    Count[i]:=0;
  END;
  IF NOT Elements_Result.SetFirstElement THEN EXIT;
  // Определяем сумму напряжений в каждом из 3-х узлов.
  REPEAT
    OneElement:=Elements_Result.GetCurrentElement;
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        FOR j:=1 TO 6 DO Strain[i,j]:=Strain[i,j]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  UNTIL NOT Elements_Result.SetNextElement;
  // Для каждого из 6-и типов напряжений
  FOR j:=1 TO 6 DO BEGIN
    // Определяем среднее напряжение в каждом из 3-х узлов.
    FOR i:=1 TO 3 DO Strain[i,j]:=MyDiv(Strain[i,j], Count[i]);
    // Определяем точку равнодействующей напряжний в 3-х узлах.
    RX:=MyDiv(Node[1].X*Strain[1,j]+Node[2].X*Strain[2,j]+Node[3].X*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    RY:=MyDiv(Node[1].Y*Strain[1,j]+Node[2].Y*Strain[2,j]+Node[3].Y*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    // Для каждой из 3-х вершин определяем коэффициент ее влияния на напряжение в ТОЧКЕ.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // Определяем напряжение в ТОЧКЕ.
    st[j]:=MyDiv(Strain[1,j]*K[1]+Strain[2,j]*K[2]+Strain[3,j]*K[3], K[1]+K[2]+K[3]);
  END;
  Result:=TRUE;
END;

// Метод определения напряжения - опционален
//тип 1 ЦПС
//    2 ЦМ
//    3 КЭ
FUNCTION TShowMovingsForm.StressInPointType(X,Y:MyReal;VAR st:TStressArray; Typ:Integer):BOOLEAN;
VAR
  Element    : INTEGER;
  OneElement : TOneElement;
  Count      : ARRAY [1..3] OF BYTE;
  K          : ARRAY [1..3] OF MyReal;
  Node       : ARRAY [1..3] OF TOneNode;
  Strain     : ARRAY [1..3,1..7] OF MyReal;
  RX,RY      : MyReal;
  i,j        : BYTE;

BEGIN
CASE Typ of
//ЦПС
1:Begin
  Result:=FALSE;
  // Определяем, какому КЭ принадлежит ТОЧКА.
  Element:=Elements_Result.FindElementByPoint(X,Y,Form1.Mover.Position*MoverK);
  IF Element=-1 THEN EXIT;
  // Определяем координаты узлов, которые образуют КЭ.
  OneElement:=Elements_Result.GetElement(Element+1);
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
  FOR i:=1 TO 3 DO BEGIN
    FOR j:=1 TO 7 DO Strain[i,j]:=0;
    Count[i]:=0;
  END;
  IF NOT Elements_Result.SetFirstElement THEN EXIT;
  // Определяем сумму напряжений в каждом из 3-х узлов.
  REPEAT
    OneElement:=Elements_Result.GetCurrentElement;
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        FOR j:=1 TO 7 DO Strain[i,j]:=Strain[i,j]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  UNTIL NOT Elements_Result.SetNextElement;
  // Для каждого из 6-и типов напряжений
  FOR j:=1 TO 7 DO BEGIN
    // Определяем среднее напряжение в каждом из 3-х узлов.
    FOR i:=1 TO 3 DO Strain[i,j]:=MyDiv(Strain[i,j], Count[i]);
    // Определяем точку равнодействующей напряжний в 3-х узлах.
    RX:=MyDiv(Node[1].X*Strain[1,j]+Node[2].X*Strain[2,j]+Node[3].X*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    RY:=MyDiv(Node[1].Y*Strain[1,j]+Node[2].Y*Strain[2,j]+Node[3].Y*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    // Для каждой из 3-х вершин определяем коэффициент ее влияния на напряжение в ТОЧКЕ.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // Определяем напряжение в ТОЧКЕ.
    st[j]:=MyDiv(Strain[1,j]*K[1]+Strain[2,j]*K[2]+Strain[3,j]*K[3], K[1]+K[2]+K[3]);
  END;
  Result:=TRUE;
  End;
2:Begin
  Result:=FALSE;
  // Определяем, какому КЭ принадлежит ТОЧКА.
  Element:=Elements_Result.FindElementByPoint(X,Y,Form1.Mover.Position*MoverK);
  IF Element=-1 THEN EXIT;
  // Определяем координаты узлов, которые образуют КЭ.
  OneElement:=Elements_Result.GetElement(Element+1);
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
  FOR i:=1 TO 3 DO BEGIN
    FOR j:=1 TO 7 DO Strain[i,j]:=0;
    Count[i]:=0;
  END;
  IF NOT Elements_Result.SetFirstElement THEN EXIT;
  // Определяем сумму напряжений в каждом из 3-х узлов.
  REPEAT
    OneElement:=Elements_Result.GetCurrentElement;
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        FOR j:=1 TO 7 DO Strain[i,j]:=Strain[i,j]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  UNTIL NOT Elements_Result.SetNextElement;
  // Определяем центр масс КЭ.
  RX:=(Node[1].X+Node[2].X+Node[3].X)/3;
  RY:=(Node[1].Y+Node[2].Y+Node[3].Y)/3;
  // Для каждого из 7-и типов напряжений
  FOR j:=1 TO 7 DO BEGIN
    // Определяем среднее напряжение в каждом из 3-х узлов.
    FOR i:=1 TO 3 DO Strain[i,j]:=MyDiv(Strain[i,j], Count[i]);
    // Для каждой из 3-х вершин определяем коэффициент ее влияния на напряжение в ТОЧКЕ.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // Определяем напряжение в ТОЧКЕ.
    st[j]:=MyDiv(Strain[1,j]*K[1]+Strain[2,j]*K[2]+Strain[3,j]*K[3], K[1]+K[2]+K[3]);
  END;
  Result:=TRUE;
  End;
3:Begin
  Result:=FALSE;
  Element:=Elements_Result.FindElementByPoint(X,Y,Form1.Mover.Position*MoverK);
  IF Element=-1 THEN EXIT;
  OneElement:=Elements_Result.GetElement(Element+1);
  FOR i:=1 TO 7 DO st[i]:=OneElement.Strain[i];
  Result:=TRUE;
  End;

END;
END;


PROCEDURE TShowMovingsForm.PaintBox1Click;
BEGIN
  Pointed:=True;
  Updating:=TRUE;
  X:=MouseX;
  Y:=MouseY;
{  EditX.Text:=cutStr(MyFloatToStr(X));
  EditY.Text:=cutStr(MyFloatToStr(Y));}
  Form1.EditX.Text:=MyFloatToStr(X);                        //отображение разультатов на новой форме
  Form1.EditY.Text:=MyFloatToStr(Y);
  Form1.EditMoveX.Text:=MyFloatToStr(X);
  Form1.EditMoveY.Text:=MyFloatToStr(Y);
  Form1.NodeEditInput.Text := '';
  // Repaint to show the selected point on the canvas
  IF( SolveInPoint ) then
    PaintBox1.Repaint;
  Updating:=FALSE;
END;


PROCEDURE TShowMovingsForm.ForceTrackBarChange(Sender: TObject);
VAR
  pos,Half : MyReal;

BEGIN
  Half:=(Form1.ForceTrackBar.Max-1)/2;
  pos:=Form1.ForceTrackBar.Position-Half;
  IF pos>=1 THEN ForceK:=pos ELSE ForceK:=1/(2-pos);
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.UseAxesClick(Sender: TObject);
BEGIN
  if (Form1.TestElements.Checked)then Form1.UseLines.Checked:=false;
  if (Form1.TestElements.Checked)then Form1.Checkbox2.Checked:=false;
  MainRePaint;
END;


PROCEDURE TShowMovingsForm.GroupBox6DblClick(Sender: TObject);
VAR
  i,j       : INTEGER;
  x,y       : MyReal;
  w,h       : INTEGER;
  st        : TStressArray;
  stind     : INTEGER;
  findlevel : INTEGER;

BEGIN
  w:=PaintBox1.Width;
  h:=PaintBox1.Height;
  if Form1.useaxes.Checked then Form1.checkbox2.Checked:=false; //Давыдова Ю.А.  &Filippova E.S.(2012)
  FOR j:=0 TO h-1 DO BEGIN
    FOR i:=0 TO w-1 DO BEGIN
      x:=Xpaint2Xreal(i);
      y:=Ypaint2Yreal(j);
      IF StressInPoint(X,Y,st) THEN BEGIN
        stind:=Form1.StressType.ItemIndex+1;
        IF st[stind]=Elements_Result.max[stind] THEN findlevel:=Form1.ChangeLegend.Position
        ELSE findlevel:=Trunc(MyDiv(st[stind]+ABS(Elements_Result.min[stind]),Level))+1;
        PaintBox1.Canvas.Pixels[Xreal2Xpaint(X),Yreal2Ypaint(Y)]:=GenerateColor(findlevel);
      END;
    END;
  END;
END;


// Сохранение изображения только результатов
PROCEDURE TShowMovingsForm.SpeedButton2Click(Sender: TObject);
BEGIN
  IF SavePicDlg.Execute THEN bmpPic.SaveToFile(SavePicDlg.FileName);
END;


// Сохранение изображения всего окна
PROCEDURE TShowMovingsForm.SpeedButton3Click(Sender: TObject);
BEGIN
  IF SavePicDlg.Execute THEN GetFormImage.SaveToFile(SavePicDlg.FileName);
END;


PROCEDURE TShowMovingsForm.SpeedButton4Click(Sender: TObject);
BEGIN
  print;
END;

Procedure TShowMovingsForm.StressMethodSave(Method: Integer);
VAR
  Registry:TRegistry;
Begin
     Registry:=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg+'\ShowGrafical\',true) then
        begin
             Registry.WriteInteger('StressMethod',Method);
        end;
     Registry.CloseKey;
     Registry.Free;
End;

Function TShowMovingsForm.StressMethodLoad(Method: Integer):Integer;
VAR
  Registry:TRegistry;
  Ret:     Integer;
Begin
     Registry:=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg+'\ShowGrafical\',true) then
        begin
             Ret:=Registry.ReadInteger('StressMethod');
             Registry.CloseKey;
             Registry.Free;
        end
     else
        begin
             Ret:=Method;
        end;
     Result:=Ret;
End;

procedure TShowMovingsForm.StressMethod1Click(Sender: TObject);
begin
  StressMethod := 1;
  StressMethodSave(1);
  SolveInPoint;
end;

procedure TShowMovingsForm.StressMethod2Click(Sender: TObject);
begin
  StressMethod := 2;
  StressMethodSave(2);
  SolveInPoint;
end;

procedure TShowMovingsForm.StressMethod3Click(Sender: TObject);
begin
  StressMethod := 3;
  StressMethodSave(3);
  SolveInPoint;
end;

//==========================================================================
// Студент Маркин Н.Н.  - 2012 - (интеграция Парамонов М.В.)
//решение системы линейных уранений методом Гаусса-Жордана
{
m - матрица коэффициентов системы уравнений со столбцом свободных
членов
nRows - число строк матрицы
функция возвращает true если существует точное решение (существует обратная
матрица системы), и false - в обратном случае
решение системы помещается в правый столбец (столбец свободных членов)
}
function TShowMovingsForm.solveGJ(var m: Arr; nRows:integer):boolean;
var
  i,j,k, maxRow : integer;
  c, temp : MyReal;
  eps : MyReal;
begin
  eps := 1E-10;
  for i := 1 to nRows do
  begin
    //ищем строку у которой максимальный элемент в текущем столбце
    maxRow := i;
    for j := i + 1 to nRows do
    begin
      if abs(m[j,i]) > abs(m[maxRow,i]) then
      begin
        maxRow := j;
      end;
    end;
    //переставляем текущую строку с максимальной
    for k := 1 to nRows do
    begin
      temp := m[i,k];
      m[i,k] := m[maxRow, k];
      m[maxRow, k] := temp;
    end;

    if abs(m[i][i]) < eps then
    begin
      Result := false;
    end;

    //отнимаем из ниже лежащих строк элементы текущей строки
    for j := i + 1 to nRows do
    begin
      c := m[j,i] / m[i,i];
      for k := i to nRows + 1 do
      begin
        m[j,k] := m[j,k] - m[i,k]*c;
      end;
    end;
  end;
  //получаем 1 на гланой диагонали и нули в левой квадратной подматрице
  for i := nRows downto 1 do
  begin
    c := m[i,i];
    for j := 1 to i-1 do
    begin
      for k := nRows+1 downto i do
      begin
        m[j,k] := m[j,k] - m[i,k]*m[j,i]/c;
      end;
    end;
    m[i,i] := m[i,i] / c;
    //те же действия для столбца свободных членов
    m[i,nRows+1] := m[i,nRows+1] / c;
  end;

  Result := true;
end;

function TShowMovingsForm.MoveInPoint(X,Y:MyReal;var move_st:TStressArray):boolean;
var
  elementNum, i, j    : integer;
  element : TOneElement;
  Node       : array [1..3] of TOneNode;
  //вертора перемещений узлов элемента
  dx, dy : array [1..3] of MyReal;
  //матрица координат узлов
  A : array[1..3,1..3] of MyReal;
  //матрица системы уравнений
  m : Arr;//array[1..3,1..4] of MyReal;
  //m : array of array of MyReal;
  //коэффициенты интерполирующих полиномов перемещения по x и y
  u, v : array [1..3] of MyReal;
  //перемещения в точке
  uxy, vxy,
  temp        : MyReal;
  solved : bool;
begin
  //получаем номер элемента по координатам выбранной точки
  elementNum := Elements_Result.FindElementByPoint(X,Y,Form1.Mover.Position*MoverK);
  //если точка принадлежит модели, вычисляем значения перемещений в точке
  if elementNum <> -1 then
  begin
    //получаем сам элемент
    element := Elements_Result.GetElement(elementNum + 1);
    //получаем узлы элемента
    Node[1]:=Nodes_Result.GetNode(element.Node1);
    Node[2]:=Nodes_Result.GetNode(element.Node2);
    Node[3]:=Nodes_Result.GetNode(element.Node3);
    //получаем координаты узлов элeмента и перемещения в узлах
    for i := 1 to 3 do
    begin
      A[i,1] := 1.;
      //координаты по x
      A[i,2] := Node[i].x;
      //координаты по y
      A[i,3] := Node[i].y;
      //перемещения
      dx[i] := Node[i].dx;
      dy[i] := Node[i].dy;
    end;

    //получаем коэффициенты интерполирующих полиномов
    for i := 1 to 3 do
    begin
      for j := 1 to 3 do
      begin
        m[i,j] := A[i,j];
      end;
      m[i,4] := dx[i];
    end;

    solved := solveGJ(m, 3);

    if not solved then
    begin
      ShowMessage('Для выбранного КЭ решения не найдено');
      Result := false;
    end;
    //перемещения по x
    for i := 1 to 3 do
    begin
      u[i] := m[i,4];
    end;

    for i := 1 to 3 do
    begin
      for j := 1 to 3 do
      begin
        m[i,j] := A[i,j];
      end;
      m[i,4] := dy[i];
    end;

    solved := solveGJ(m, 3);

    if not solved then
    begin
      ShowMessage('Для выбранного КЭ решения не найдено');
      Result := false;
    end;
    //перемещения по y
    for i := 1 to 3 do
    begin
      v[i] := m[i,4];
    end;

    //вычисляем перемещения в точке
    //x
    uxy := u[1] + u[2] * X + u[3] * Y;
    //y
    vxy := v[1] + v[2] * X + v[3] * Y;

    move_st[1]:= uxy;
    move_st[2]:= vxy;

    Result:=true;
  end;//if elementNum <> -1
end;

//====================================end of code by Markin N.N.============

procedure TShowMovingsForm.FormShow(Sender: TObject);
VAR
  Registry:TRegistry;

  FUNCTION ReadSTRING(Name:STRING;Def:STRING):STRING;
  BEGIN
    IF Registry.ValueExists(Name) THEN Result:=Registry.ReadSTRING(Name) ELSE Result:=def;
  END;

BEGIN
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  // Group2.SetFocus;
 IF Registry.OpenKeyReadOnly(STRINGReg) THEN FloatFormat:=Registry.ReadSTRING('FloatFormat');
end;

procedure TShowMovingsForm.ToolButton1Click(Sender: TObject);
begin
  //Group1.SetFocus;

end;


procedure TShowMovingsForm.SpeedButton7Click(Sender: TObject);
begin
  // Group1.SetFocus;
end;

procedure TShowMovingsForm.SpeedButton6Click(Sender: TObject);
begin
  //Group2.SetFocus;
end;

procedure TShowMovingsForm.ParamsButtonClick(Sender: TObject);
begin
       Form1.Show;
end;

procedure TShowMovingsForm.Timer1Timer(Sender: TObject);
begin
// Тело процедуры будет выполняться если выбрана опция
// "Проверить напряжения в КЭ"
  IF TestElements.Checked THEN   BEGIN
// Замена значения управляющей переменной Prd (если  Prd не равно 0, то
// присвоить ей значение 0, а если равно 0, то присвоить значение 1
  If Prd<>0 then Prd:=0
    else Prd:=1 ;
// перерисовать картинку
   MainRePaint;
   end;
end;

//  процедура проверки на превышение допустимого напряжения в КЭ
PROCEDURE TShowMovingsForm.UseTestElements(Canvas:TCanvas);
 VAR
  OneElement   : TOneElement;
  DopStress    : TStress;
  DopNegStress    : TStress;
  Error        : Integer;
  OneNode      : TOneNode;
  findlevel    : INTEGER;
  flag    : INTEGER;

function GetMaxStress(OneElement   : TOneElement):real;
var
  i:word;
begin
  result:=OneElement.Strain[1];
  for i:=1 to 7 do if Result<OneElement.Strain[i] then Result:=OneElement.Strain[i];
end;
function GetMinStress(OneElement   : TOneElement):real;
var
  i:word;
begin
  result:=0.0;
  for i:=1 to 7 do if Result>OneElement.Strain[i] then Result:=OneElement.Strain[i];
end;

BEGIN
  IF TestElements.Checked THEN   BEGIN
// считываем допустимое напряжения из файла "Data"
   DopStress:=LoadDopStress(Error);
   DopNegStress:=LoadDopNegStress(Error);
   If Error<>0 Then Showmessage('Ошибка при считывании допустимого напряжения');
 WITH Canvas DO BEGIN
    Pen.Color:=clBlack;
    Pen.Style:=psSolid;
    Brush.Color:=BackGR;
    FillRect(ClipRect);
    IF Elements_Result.SetFirstElement THEN BEGIN
 // Перебираем все элементы
      REPEAT
        OneElement:=Elements_Result.GetCurrentElement;
         IF OneElement.strain[Form1.StressType.ItemIndex+1]=Elements_Result.max[Form1.StressType.ItemIndex+1] THEN findlevel:=Form1.ChangeLegend.Position
             ELSE findlevel:=Trunc(MyDiv((OneElement.strain[Form1.StressType.ItemIndex+1]-(Elements_Result.min[Form1.StressType.ItemIndex+1])),Level))+1;
      // в текущем КЭ только и положительное и отрицательное напряжение больше допустимого
      flag:=0;
      IF (Abs(GetMaxStress(OneElement))>DopStress[OneElement.Material]) THEN flag:=flag+1;
      IF (Abs(GetMinStress(OneElement))>Abs(DopNegStress[OneElement.Material])) THEN flag:=flag+2;
      IF (flag>0) THEN
      // если КЭ испытывает напряжения больше допустимого напряжения, то показать сетку
          Begin
            IF (flag=1) THEN Brush.Style:=bsHorizontal;
            IF (flag=2) THEN Brush.Style:=bsVertical;
            IF (flag=3) THEN Brush.Style:=bsCross;
            Brush.Color:=clBlack;
            if LinesShow then
            begin
              ShowElement(Canvas,OneElement);    //kotov
            end
            else
            begin
              ShowElementOld(Canvas,OneElement);    //kotov
            end
          end
         else begin
  // иначе оставить изображение КЭ в исходном виде
             Brush.Style:=bsSolid;
             if LinesShow then begin
                Brush.Color:=GenerateColor1(findlevel-1);  //kotov
                ShowElement(Canvas,OneElement);           //kotov
             end
             else
             begin
                Brush.Color:=GenerateColorOld(findlevel-1);  //kotov
                ShowElementOld(Canvas,OneElement);           //kotov
             end
          end;
      UNTIL NOT Elements_Result.SetNextElement;
    END;
  END;
END;
  ShowBoundForce(Canvas);
  ShowAxes(Canvas);
END;

procedure TShowMovingsForm.EditMoveXChange(Sender: TObject);
VAR
  value : MyReal;
begin
Pointed:=True;
IF Updating THEN EXIT;
  value:=1;
  IF CheckReal((Sender as TEdit).text,value) THEN BEGIN
    IF Sender = Form1.EditMoveX THEN X:=Value;
    IF Sender = Form1.EditMoveY THEN Y:=Value;
    If NOT ElemInputs then
    begin
    Form1.NodeEditInput.Text := '';
                    end;
    IF (NOT ChangedFromNodeInput) THEN BEGIN
    DrawSelectedElement:=TRUE;
    END;
    SolveInPoint;
    PaintBox1.Repaint;
  END;
end;

procedure TShowMovingsForm.Spin_0_Exit(Sender: TObject);
begin
        if (Spin_0_max.text = '') then Spin_0_max.Value := 1;
        if (Spin_0_min.text = '') then Spin_0_min.Value := 1;;
end;

procedure TShowMovingsForm.UseNumZoneClick(Sender: TObject);
begin

  if UseNumZone.Checked then UseNumMater.Checked:=false;     //Imametdinov

  MainRePaint;
  
 end;
procedure TShowMovingsForm.UseNumMaterClick(Sender: TObject);
begin

  if UseNumMater.Checked then UseNumZone.Checked:=false;     //Imametdinov
  if UseNumMater.Checked then Checkbox2.Checked:=false;
  MainRePaint;
end;
                         
procedure TShowMovingsForm.Button1Click(Sender: TObject);
begin

  // отобразить панель, если она скрыта
  if ( Form1.Visible = false ) then
  begin
    // сделать панель видимой
    Form1.Visible := true;
    // обновить видимые параметры
    //UpdateVizParams;
    //btnSetVisiblePanel.Caption := 'Скрыть панель настроек';
  end
  else
  begin
    // скрыть панель
    Form1.Visible := false;
    //btnSetVisiblePanel.Caption := 'Показать панель настроек';
  end;
end;

 // Прокофьев 2012
procedure TShowMovingsForm.LoadMaxMinStress;
var
  i, j, zoneCout, nodeNum, k, countNodes, material : integer;
  curElement : TOneElement;
  stress : double;
  // максимальное положительное напряжение во всей пластине
  maxPosStressP : double;
  // номер КЭ
  maxPosStressPNum : integer;
  // максимальное отрицительное напряжение во всей пластине
  maxNegStressP : double;
  // номер КЭ
  maxNegStressPNum : integer;
  // максимальное положительное напряжение в текущей зонае
  // максимальное положительное напряжение во всей пластине
  maxPosStressAll : double;
  // номер КЭ
  maxPosStressAllNum : integer;
  // максимальное отрицительное напряжение во всей пластине
  maxNegStressAll : double;
  // номер КЭ
  maxNegStressAllNum : integer;
  // максимальное положительное напряжение в текущей зоне
  maxPosStressZ : double;
  // номер КЭ
  maxPosStressZNum : integer;
  // максимальное отрицительное напряжение в текущей зоне
  maxNegStressZ : double;
  // номер КЭ
  maxNegStressZNum : integer;
  curElemNum, curZoneNum : integer;
begin
  Form1.ZoneStress.ColCount := 6;
  // задать заголовок таблицы
  Form1.ZoneStress.Cells[0, 0] := 'Зона';
  Form1.ZoneStress.Cells[1, 0] := 'Св-тво';
  Form1.ZoneStress.Cells[2, 0] := '№ КЭ';
  Form1.ZoneStress.Cells[3, 0] := 'Верхнее';
  Form1.ZoneStress.Cells[4, 0] := '№ КЭ';
  Form1.ZoneStress.Cells[5, 0] := 'Нижнее';

  // Определить количество зон
  zoneCount := ZoneContour.GetNumberOfZones();

  for curZoneNum := 1 to zoneCount do
  begin
    i := 1;
    curElemNum :=  ElemZone[curZoneNum, i];
    curElement := Elements_Result.GetElement(curElemNum) ;
    stress := curElement.Strain[Form1.StressType.ItemIndex + 1] ;
    // максимальное положительное напряжение в текущей зоне
    maxPosStressZ := stress;
    // номер КЭ
    maxPosStressZNum := curElemNum;
    // максимальное отрицительное напряжение в текущей зоне
    maxNegStressZ := stress;
    // номер КЭ
    maxNegStressZNum := curElemNum;


    while curElemNum <> 0 do
    begin

      // получить элемен по его номеру
      curElement := Elements_Result.GetElement(curElemNum) ;
      material := curElement.Material;
      // определить напряжения
      stress := curElement.Strain[Form1.StressType.ItemIndex + 1] ;
      if ( stress > maxPosStressZ ) then
      begin
        maxPosStressZ := stress;
        maxPosStressZNum := curElement.Number;
      end;
      if (stress < maxNegStressZ ) then
      begin
        maxNegStressZ := stress;
        maxNegStressZNum := curElement.Number;
      end;

      inc(i);
      curElemNum := ElemZone[curZoneNum, i];
    end;

    // записать данные для зоны
    // номер зоны
    Form1.ZoneStress.Cells[0, curZoneNum] := IntToStr(curZoneNum);
    Form1.ZoneStress.Cells[1, curZoneNum] := IntToStr(material);
     // номер кэ с макс положит напряж
    Form1.ZoneStress.Cells[2, curZoneNum] := IntToStr(maxPosStressZNum);
    // значение положит
    Form1.ZoneStress.Cells[3, curZoneNum] := MyFloatToStr(maxPosStressZ);
    // номер кэ с макс отриц напряж
    Form1.ZoneStress.Cells[4, curZoneNum] := IntToStr(maxNegStressZNum);
    // значение отриц
    Form1.ZoneStress.Cells[5, curZoneNum] := MyFloatToStr(maxNegStressZ);

  end;


  // определить максимумы для всей пластины
  // начальные значения
  // максимальное положительное напряжение во всей пластине
  maxPosStressP := stress;
  // номер КЭ
  maxPosStressPNum := curElemNum;
  // максимальное отрицительное напряжение во всей пластине
  maxNegStressP := stress;
  // номер КЭ
  maxNegStressPNum :=curElemNum;
  maxPosStressAll := stress;
  // номер КЭ
  maxPosStressAllNum := curElemNum;
  // максимальное отрицательное напряжение во всей пластине
  maxNegStressAll := stress;
  // номер КЭ
  maxNegStressAllNum :=curElemNum;

  Elements_Result.SetFirstElement;
  countNodes := Elements_Result.GetNumElements;
  for j := 1 to countNodes do
  begin
    curElement:=Elements_Result.GetCurrentElement;
    // определить макс и мин для всей пластины
    stress := curElement.Strain[Form1.StressType.ItemIndex + 1] ;
    if ( stress > maxPosStressP ) then
    begin
      maxPosStressP := stress;
      maxPosStressPNum := curElement.Number;
    end;
    if (stress < maxNegStressP ) then
    begin
      maxNegStressP := stress;
      maxNegStressPNum := curElement.Number;
    end;
     for i := 1 to 7 do
     begin
         stress := curElement.Strain[i];
         if ( stress > maxPosStressAll ) then
           begin
              maxPosStressAll := stress;
              maxPosStressAllNum := curElement.Number;
            end;
          if (stress < maxNegStressAll ) then
            begin
               maxNegStressAll := stress;
               maxNegStressAllNum := curElement.Number;
           end;
     end;
    Elements_Result.SetNextElement;
  end;

  Form1.ZoneStress.Cells[0, zoneCount + 1] := 'Макс';
  // номер кэ с макс положит напряж
  Form1.ZoneStress.Cells[2, zoneCount + 1] := IntToStr(maxPosStressPNum);
  // значение положит
  Form1.ZoneStress.Cells[3, zoneCount + 1] := MyFloatToStr(maxPosStressP);
  // номер кэ с макс отриц напряж
  Form1.ZoneStress.Cells[4, zoneCount + 1] := IntToStr(maxNegStressPNum);
  // значение отриц
  Form1.ZoneStress.Cells[5, zoneCount + 1] := MyFloatToStr(maxNegStressP);

  Form1.ZoneStress.RowCount := zoneCount + 2;

  Form1.ZoneStress.Cells[0, zoneCount + 2] := 'ПЛАСТ';
  // номер кэ с макс положит напряж
  Form1.ZoneStress.Cells[2, zoneCount + 2] := IntToStr(maxPosStressAllNum);
  // значение положит
  Form1.ZoneStress.Cells[3, zoneCount + 2] := MyFloatToStr(maxPosStressAll);
  // номер кэ с макс отриц напряж
  Form1.ZoneStress.Cells[4, zoneCount + 2] := IntToStr(maxNegStressAllNum);
  // значение отриц
  Form1.ZoneStress.Cells[5, zoneCount + 2] := MyFloatToStr(maxNegStressAll);
  Form1.ZoneStress.RowCount := zoneCount + 3;
end;


procedure TShowMovingsForm.LoadMaxMinStressInMaterials;
var
  i, j, zoneCout, nodeNum, k, countNodes, curRow, material : integer;
  curElement : TOneElement;
  stress : double;
  MP    :TMainParams;
  // максимальное положительное напряжение во всей пластине
  maxPosStressP : double;
  // номер КЭ
  maxPosStressPNum : integer;
  // максимальное отрицительное напряжение во всей пластине
  maxNegStressP : double;
  // номер КЭ
  maxNegStressPNum : integer;
  // максимальное положительное напряжение в текущей зоне
  // максимальное положительное напряжение во всей пластине
  maxPosStressAll : double;
  // номер КЭ
  maxPosStressAllNum : integer;
  // максимальное отрицительное напряжение во всей пластине
  maxNegStressAll : double;
  // номер КЭ
  maxNegStressAllNum : integer;
  // максимальное положительное напряжение в текущей зоне
  maxPosStressZ : double;
  // номер КЭ
  maxPosStressZNum : integer;
  // максимальное отрицительное напряжение в текущей зоне
  maxNegStressZ : double;
  // номер КЭ
  maxNegStressZNum : integer;
  curElemNum, curZoneNum, countMaterial, error : integer;
begin
  Form1.ZoneStress2.ColCount := 6;
  // задать заголовок таблицы
  Form1.ZoneStress2.Cells[0, 0] := 'Св-тво';
  Form1.ZoneStress2.Cells[1, 0] := 'Зона';
  Form1.ZoneStress2.Cells[2, 0] := '№ КЭ';
  Form1.ZoneStress2.Cells[3, 0] := 'Верхнее';
  Form1.ZoneStress2.Cells[4, 0] := '№ КЭ';
  Form1.ZoneStress2.Cells[5, 0] := 'Нижнее';
  MP := GetMainParam;
  countMaterial := LoadCountMaterial(error);
  // Определить количество зон
  zoneCount := ZoneContour.GetNumberOfZones();
  curRow:=1;
for material := 1 to countMaterial do
begin
  for curZoneNum := 1 to zoneCount do
  begin
    i := 1;
    curElemNum :=  ElemZone[curZoneNum, i];
    curElement := Elements_Result.GetElement(curElemNum) ;
    if (curElement.Material = material) then
      begin
        stress := curElement.Strain[Form1.StressType.ItemIndex + 1] ;
    // максимальное положительное напряжение в текущей зоне
        maxPosStressZ := stress;
    // номер КЭ
        maxPosStressZNum := curElemNum;
    // максимальное отрицительное напряжение в текущей зоне
        maxNegStressZ := stress;
    // номер КЭ
        maxNegStressZNum := curElemNum;
        while curElemNum <> 0 do
        begin
          // получить элемен по его номеру
          curElement := Elements_Result.GetElement(curElemNum) ;
          // определить напряжения
           stress := curElement.Strain[Form1.StressType.ItemIndex + 1] ;
          if ( stress > maxPosStressZ ) then
          begin
            maxPosStressZ := stress;
            maxPosStressZNum := curElement.Number;
          end;
          if (stress < maxNegStressZ ) then
          begin
             maxNegStressZ := stress;
             maxNegStressZNum := curElement.Number;
          end;

        inc(i);
        curElemNum := ElemZone[curZoneNum, i];
        end;
     // записать данные для зоны
    // номер зоны

       Form1.ZoneStress2.Cells[0, curRow] := IntToStr(material);
        Form1.ZoneStress2.Cells[1, curRow] := IntToStr(curZoneNum);
      // номер кэ с макс положит напряж
        Form1.ZoneStress2.Cells[2, curRow] := IntToStr(maxPosStressZNum);
    // значение положит
        Form1.ZoneStress2.Cells[3, curRow] := MyFloatToStr(maxPosStressZ);
    // номер кэ с макс отриц напряж
        Form1.ZoneStress2.Cells[4, curRow] := IntToStr(maxNegStressZNum);
    // значение отриц
        Form1.ZoneStress2.Cells[5, curRow] := MyFloatToStr(maxNegStressZ);
	    inc(curRow);

    end;
  end;
  /// определить максимумы для всей пластины
  // начальные значения
  // максимальное положительное напряжение во всей пластине
  maxPosStressP := stress;
  // номер КЭ
  maxPosStressPNum := curElemNum;
  // максимальное отрицительное напряжение во всей пластине
  maxNegStressP := stress;
  // номер КЭ
  maxNegStressPNum :=curElemNum;
  maxPosStressAll := stress;
  // номер КЭ
  maxPosStressAllNum := curElemNum;
  // максимальное отрицательное напряжение во всей пластине
  maxNegStressAll := stress;
  // номер КЭ
  maxNegStressAllNum :=curElemNum;

  Elements_Result.SetFirstElement;
  countNodes := Elements_Result.GetNumElements;
  for j := 1 to countNodes do
  begin
    curElement:=Elements_Result.GetCurrentElement;
    // определить макс и мин для всей пластины
	if (curElement.Material = material) then
	begin
    stress := curElement.Strain[Form1.StressType.ItemIndex + 1] ;
    if ( stress > maxPosStressP ) then
    begin
      maxPosStressP := stress;
      maxPosStressPNum := curElement.Number;
    end;
    if (stress < maxNegStressP ) then
    begin
      maxNegStressP := stress;
      maxNegStressPNum := curElement.Number;
    end;
     for i := 1 to 7 do
     begin
         stress := curElement.Strain[i];
         if ( stress > maxPosStressAll ) then
           begin
              maxPosStressAll := stress;
              maxPosStressAllNum := curElement.Number;
            end;
          if (stress < maxNegStressAll ) then
            begin
               maxNegStressAll := stress;
               maxNegStressAllNum := curElement.Number;
           end;
     end;
	end;
    Elements_Result.SetNextElement;
  end;


  if ((maxPosStressP<>0.0) and (maxNegStressP<>0.0) and (maxPosStressAll<>0.0) and (maxNegStressAll<>0.0)) then
  begin
  Form1.ZoneStress2.Cells[0, curRow] := 'Макс в св.';
  // номер кэ с макс положит напряж
  Form1.ZoneStress2.Cells[2, curRow] := IntToStr(maxPosStressPNum);
  // значение положит
  Form1.ZoneStress2.Cells[3, curRow] := MyFloatToStr(maxPosStressP);
  // номер кэ с макс отриц напряж
  Form1.ZoneStress2.Cells[4, curRow] := IntToStr(maxNegStressPNum);
  // значение отриц
  Form1.ZoneStress2.Cells[5, curRow] := MyFloatToStr(maxNegStressP);
  inc(curRow);
  Form1.ZoneStress2.RowCount := curRow;

  Form1.ZoneStress2.Cells[0, curRow] := 'Макс в пл.';
  // номер кэ с макс положит напряж
  Form1.ZoneStress2.Cells[2, curRow] := IntToStr(maxPosStressAllNum);
  // значение положит
  Form1.ZoneStress2.Cells[3, curRow] := MyFloatToStr(maxPosStressAll);
  // номер кэ с макс отриц напряж
  Form1.ZoneStress2.Cells[4, curRow] := IntToStr(maxNegStressAllNum);
  // значение отриц
  Form1.ZoneStress2.Cells[5, curRow] := MyFloatToStr(maxNegStressAll);
  inc(curRow);
  Form1.ZoneStress2.RowCount := curRow;
  end;
end;
end;

procedure TShowMovingsForm.LoadElemZone(path:string);
var
  f : File of integer;
  nZone, nElem, i, j : integer;
  temp : integer;
begin
  // открыть файл для чтения
  IF NOT FileExists(path) THEN EXIT;
  AssignFile(f,path);
  Reset(f);
  // количество зон и узлов равно 0
  nZone := 0;
  nElem := 0;
  for i:=1 to 20 do
  begin
	for j:=1 to 10000 do
	begin
		ElemZone[i,j] := 0;
	end;
  end;	
  WHILE NOT Eof(f) DO BEGIN
    Read(f, temp);
    if ( temp = -1 ) then
    begin
      // новая зона
      // для новой зоны число эл-тов равно 0
      nElem := 0;
      Read(f, nZone);
      inc(nElem);
      read(f, temp);
      ElemZone[nZone, nElem] := temp;
    end
    else
    begin
      // записать номер текущего элемента в текущую зону
      inc(nElem);
      ElemZone[nZone, nElem] := temp;
    end;
  END;
///
end;



procedure TShowMovingsForm.EditForceChange(Sender: TObject);
VAR
  value : WORD;
  x     : MyReal;
BEGIN
  value:=1;
  IF CheckWord(Form1.EditForce.text,value) THEN BEGIN
    IF value>0 THEN BEGIN
      x:=Form1.ForceTrackBar.Position/Form1.ForceTrackBar.Max;
      Form1.ForceTrackBar.Max:=2*value+1;
      Form1.ForceTrackBar.Position:=ROUND(x*ForceTrackBar.Max);
    END
    ELSE Form1.EditForce.Text:='1';
  END;
   END;

procedure TShowMovingsForm.ColorZeroPlussClick(Sender: TObject);
BEGIN
  ColorDialog1.Color:=(Sender as TPanel).Color;
  IF ColorDialog1.Execute THEN BEGIN
    (Sender as TPanel).Color := ColorDialog1.Color;
    MainRePaint;
    LegendPaint(nil);
  END;
END;

procedure TShowMovingsForm.CheckOptimization;
var
  GridOpt:integer;
begin
  GridOpt:=GetGridOpt();

  if (GridOpt=-4) or (GridOpt=-3) or
  (GridOpt=1) or (GridOpt=12) or
  (GridOpt=22) or (GridOpt=3) or
  (GridOpt=5) or (GridOpt=14) or
  (GridOpt=24) or (GridOpt=7) or
  (GridOpt=41) or (GridOpt=44) or
  (GridOpt=51) or (GridOpt=54) then
  begin
  Form1.Label31.Caption := 'Сетка оптимизирована (стат.)';
  Form1.Label39.Caption := 'Сетка оптимизирована (стат.)';
  Form1.Label32.Caption := 'Сетка оптимизирована (стат.)';
  end
  else if (GridOpt=31) or (GridOpt=32) or
  (GridOpt=33) or (GridOpt=34) or
  (GridOpt=35) or (GridOpt=36) or
  (GridOpt=37) or (GridOpt=38) or
  (GridOpt=39) or (GridOpt=30) or
  (GridOpt=42) or (GridOpt=45) or
  (GridOpt=52) or (GridOpt=55) then
    begin
    Form1.Label31.Caption := 'Сетка оптимизирована (дин.)';
    Form1.Label39.Caption := 'Сетка оптимизирована (дин.)';
    Form1.Label32.Caption := 'Сетка оптимизирована (дин.)';
    end
    else
    begin
    Form1.Label31.Caption := 'Сетка не оптимизирована';
    Form1.Label39.Caption := 'Сетка не оптимизирована';
    Form1.Label32.Caption := 'Сетка не оптимизирована';
    end;
end;

function TShowMovingsForm.GetGridOpt:integer;
var
  Registry:TRegistry;
begin
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg, false) then
     begin
          if Registry.ValueExists('GridOpt') then
		          begin
			            result:=Registry.ReadInteger('GridOpt');
              end
              else result:=0;
     end else result:= 0;
     Registry.Free;
End;

FUNCTION StressInElementType(Elem: Integer;VAR st:TStressArray; Typ:Integer):BOOLEAN;
VAR
  OneElement : TOneElement;
  Count      : ARRAY [1..3] OF BYTE;
  K          : ARRAY [1..3] OF MyReal;
  Node       : ARRAY [1..3] OF TOneNode;
  Strain     : ARRAY [1..3,1..7] OF MyReal;
  i,j        : BYTE;
  RX,RY,X,Y      : MyReal;

BEGIN
 // Определяем, существование КЭ с таким номером.
 IF (Elem>Elements_Result.GetNumElements) OR (Elem<0) THEN  EXIT;

CASE Typ of
//ЦПС
1:Begin
  Result:=FALSE;
     // Определяем координаты узлов, которые образуют КЭ.
  OneElement:=Elements_Result.GetElement(Elem);
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  X:=Node[1].x;
  Y:=Node[1].y;
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
  FOR i:=1 TO 3 DO BEGIN
    FOR j:=1 TO 7 DO Strain[i,j]:=0;
    Count[i]:=0;
  END;
  IF NOT Elements_Result.SetFirstElement THEN EXIT;
  // Определяем сумму напряжений в каждом из 3-х узлов.
  REPEAT
    OneElement:=Elements_Result.GetCurrentElement;
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        FOR j:=1 TO 7 DO Strain[i,j]:=Strain[i,j]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  UNTIL NOT Elements_Result.SetNextElement;
  // Для каждого из 6-и типов напряжений
  FOR j:=1 TO 7 DO BEGIN
    // Определяем среднее напряжение в каждом из 3-х узлов.
    FOR i:=1 TO 3 DO Strain[i,j]:=MyDiv(Strain[i,j], Count[i]);
    // Определяем точку равнодействующей напряжний в 3-х узлах.
    RX:=MyDiv(Node[1].X*Strain[1,j]+Node[2].X*Strain[2,j]+Node[3].X*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    RY:=MyDiv(Node[1].Y*Strain[1,j]+Node[2].Y*Strain[2,j]+Node[3].Y*Strain[3,j], Strain[1,j]+Strain[2,j]+Strain[3,j]);
    // Для каждой из 3-х вершин определяем коэффициент ее влияния на напряжение в ТОЧКЕ.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // Определяем напряжение в ТОЧКЕ.
    st[j]:=MyDiv(Strain[1,j]*K[1]+Strain[2,j]*K[2]+Strain[3,j]*K[3], K[1]+K[2]+K[3]);
  END;
  Result:=TRUE;
  End;
2:Begin
  Result:=FALSE;
  // Определяем координаты узлов, которые образуют КЭ.
  OneElement:=Elements_Result.GetElement(Elem);
  Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
  Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
  FOR i:=1 TO 3 DO BEGIN
    FOR j:=1 TO 7 DO Strain[i,j]:=0;
    Count[i]:=0;
  END;
  IF NOT Elements_Result.SetFirstElement THEN EXIT;
  // Определяем сумму напряжений в каждом из 3-х узлов.
  REPEAT
    OneElement:=Elements_Result.GetCurrentElement;
    FOR i:=1 TO 3 DO BEGIN
      IF (OneElement.Node1=Node[i].Number) OR (OneElement.Node2=Node[i].Number) OR (OneElement.Node3=Node[i].Number) THEN BEGIN
        FOR j:=1 TO 7 DO Strain[i,j]:=Strain[i,j]+OneElement.Strain[j];
        INC(Count[i]);
      END;
    END;
  UNTIL NOT Elements_Result.SetNextElement;
  // Определяем центр масс КЭ.
  RX:=(Node[1].X+Node[2].X+Node[3].X)/3;
  RY:=(Node[1].Y+Node[2].Y+Node[3].Y)/3;
  // Для каждого из 7-и типов напряжений
  FOR j:=1 TO 7 DO BEGIN
    // Определяем среднее напряжение в каждом из 3-х узлов.
    FOR i:=1 TO 3 DO Strain[i,j]:=MyDiv(Strain[i,j], Count[i]);
    // Для каждой из 3-х вершин определяем коэффициент ее влияния на напряжение в ТОЧКЕ.
    FOR i:=1 TO 3 DO K[i]:=MyDiv(SQRT(SQR(RX-Node[i].X)+SQR(RY-Node[i].Y)), SQRT(SQR(X-Node[i].X)+SQR(Y-Node[i].Y)));
    // Определяем напряжение в ТОЧКЕ.
    st[j]:=MyDiv(Strain[1,j]*K[1]+Strain[2,j]*K[2]+Strain[3,j]*K[3], K[1]+K[2]+K[3]);
  END;
  Result:=TRUE;
  End;
3:Begin
  Result:=FALSE;
  OneElement:=Elements_Result.GetElement(Elem);
  FOR i:=1 TO 7 DO st[i]:=OneElement.Strain[i];
  Result:=TRUE;
  End;

END;
END;

// отрисовка контура выбранного КЭ и наклонных линий внутри КЭ в граф. результате
procedure TShowMovingsForm.ShowOneElement(Element: TOneElement;Canvas: TCanvas);
var
 x1, y1  : INTEGER;
  x2, y2  : INTEGER;
  x3, y3  : INTEGER;
  TempBrushColor      : TColor;
  TempPenColor        : TColor;
  TempBrushStyle : TBrushStyle;
  Node : array [1..3] of TOneNode;
begin
  Node[1]:=Nodes_Result.GetNode(Element.Node1);
  Node[2]:=Nodes_Result.GetNode(Element.Node2);
  Node[3]:=Nodes_Result.GetNode(Element.Node3);
  x1:=Xreal2Xpaint(Node[1].x);
  y1:=Yreal2Ypaint(Node[1].y);
  x2:=Xreal2Xpaint(Node[2].x);
  y2:=Yreal2Ypaint(Node[2].y);
  x3:=Xreal2Xpaint(Node[3].x);
  y3:=Yreal2Ypaint(Node[3].y);
  With Canvas do
  begin
  TempBrushColor:=Canvas.Brush.Color;
  TempPenColor:=Canvas.Pen.Color;
  TempBrushStyle:=Canvas.Brush.Style;
  Canvas.Pen.Color:=clRed;
  Canvas.Brush.Color:=clBlack;
  Canvas.Brush.Style:=bsFDiagonal;
  Canvas.Polygon([point(x1,y1),point(x2,y2),point(x3,y3)]);
  Canvas.Brush.Color:=TempBrushColor;
  Canvas.Pen.Color:=TempPenColor;
  Canvas.Brush.Style:=TempBrushStyle;
  end;
end;

procedure TShowMovingsForm.ShowOneElementInfo;
var
  ElementToFind : integer;
  st:TStressArray;
  OneElement: TOneElement;
   Node : array [1..3] of TOneNode;
begin

{Поиск и отображение информации по КЭ}
ElementToFind:=-1;
TRY
// считываем значение поля Номер КЭ
       ElementToFind :=  StrToInt(Form1.InfoFiniteElementNumber.text);
 except
  on Exception : EConvertError do
  ShowMessage(Exception.Message);
  end;
  // Считываем напряжения в КЭ
       st[5]:=0;
       st[6]:=0;
       st[7]:=0;
       if (ElementToFind <= Elements_Result.GetNumElements) AND (ElementToFind>0) then
          begin

          If (StressInElementType(ElementToFind,st,StressMethod)) then
              begin
                 // получаем информацию по КЭ
                OneElement:=Elements_Result.GetElement(ElementToFind);
                If Not(Pointed) then
                begin
                 Node[1]:=Nodes_Result.GetNode(OneElement.Node1);
                 Node[2]:=Nodes_Result.GetNode(OneElement.Node2);
                  Node[3]:=Nodes_Result.GetNode(OneElement.Node3);
                 X:=(Node[1].x+Node[2].x+Node[3].x)/3;
                 Y:=(Node[1].y+Node[2].y+Node[3].y)/3;
                 Form1.EditX.Text:=MyFloatTostr(X);
                 Form1.EditY.Text:=MyFloatTostr(Y);
                 SolveInPoint;
                 end;
                // Графический вывод выбранного КЭ
              IF (DrawSelectedElement)  THEN
              BEGIN
                showOneElement(OneElement, Canvas);
                END;
               end;
           end;
     //  Вписываем напряжения в поля
    Form1.InfoX1.caption:=MyFloatToStr(st[1]);
    Form1.InfoY1.caption:=MyFloatToStr(st[2]);
    Form1.InfoXY1.caption:=MyFloatToStr(st[3]);
    Form1.InfoMax1.caption:=MyFloatToStr(st[4]);
    Form1.InfoMin1.caption:=MyFloatToStr(st[5]);
    Form1.InfoConer1.caption:=MyFloatToStr(st[7]);
    Form1.InfoEcv1.caption:=MyFloatToStr(st[6]);


end;

// Если изменилось значение в строке и нажат Enter, то выводим инф-ю по данному КЭ
procedure TShowMovingsForm.InfoFiniteElementNumberChange(Sender: TObject);
begin
DrawSelectedElement:=TRUE;
Pointed:=False;
ShowOneElementInfo(Canvas);
DrawSelectedPoint:=false;
MainRePaint;
end;


// поиск узла по номеру
procedure TShowMovingsForm.NodeEditInputChange(Sender: TObject);
var
node: TOneNode;
BEGIN
ChangedFromNodeInput:=TRUE;
//Pointed:=True;
      ElemInputs :=True;
     node:=nodes_result.GetNode(nodes_result.FindRenumNode(StrToInt(Form1.NodeEditInput.Text)));
     Form1.EditMoveX.Text:=FloatToStr(RoundTo(node.x,-2));
     Form1.EditMoveY.Text:=FloatToStr(RoundTo(node.y,-2));
     DrawSelectedElement:=FALSE;
     SolveInPoint;
     ElemInputs:=False;
     Form1.CurElemNum.Caption := 'выбран узел';
     ChangedFromNodeInput:=FALSE;
  END;

End.
