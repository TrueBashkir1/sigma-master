{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                               изменения:                            }
{                                                                     }
{                        Цветаев Борис Михайлович                     }
{                                                                     }
{*********************************************************************}

unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ExtCtrls,ImgList,ToolWin,MainForm,Grids,
  TeEngine, Series, TeeProcs, Chart, OleCtnrs, ComCtrls, Menus, untLoadPset, Constants;
   type TMyArray=array [1..8] of Real;
  type
  TForm3 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    EditX: TEdit;
    EditY: TEdit;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    Button8: TButton;
    Button6: TButton;
    Ole: TOleContainer;
    Button9: TButton;
    Label5: TLabel;
    ComboBoxEx1: TComboBoxEx;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    GroupBox3: TGroupBox;
    StressMethod1: TRadioButton;
    StressMethod2: TRadioButton;
    StressMethod3: TRadioButton;
    GroupBox4: TGroupBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    sdSave: TSaveDialog;
    odOpen: TOpenDialog;
    GroupBox6: TGroupBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    ComboBox1: TComboBox;
    procedure Button7Click(Sender: TObject);
    procedure Raschet(Sender: TObject;Var NrcMy: integer);
    Procedure UstanovkaNRC(Sender:TOBject;Var NrcMy:Integer);
    procedure delay(sender:TObject;Var n:integer);
    Procedure Vichisl(Sender:Tobject;Var NrcMy:integer;Var n:integer);
    procedure Button8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);

    procedure AddPoint();
    procedure ComboBoxEx1Select(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure EditXChange(Sender: TObject);
    procedure EditYChange(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StressMethod1Click(Sender: TObject);
    procedure StressMethod2Click(Sender: TObject);
    procedure StressMethod3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);

    procedure GrafikParam(var NrcMy:integer;RezArray:array of real);
    procedure SetGrafikParam();
    procedure GroupFormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);

    private
    { Private declarations }
  public
    { Public declarations }
//TSH
    CurPoint: integer;
    SelectedPointsX: array[1..5] of real;
    SelectedPointsY: array[1..5] of real;
    GRPoint: array[1..5] of integer;
  published
 
//TSH
  end;

var
  Form3: TForm3;
  MyArray1,Myarray2,MyArray3,Myarray4,MyArray5,MyArray6: TMyArray;
  NrcOld,checkmethod,Oldmethod,OldItem,MantissStress, MantissMove: Integer;
  Grdisplay:boolean;
  FloatFormat:String;


implementation

uses Registry,Unit2,  strfunc, MainInterface,ResultsArrays, TSigmaForm, ShowMovings,
  WaitForm, Unit4, Unit5, Unit6, Unit7, Unit8,Unit9,Unit10,Unit11,Unit12,Unit13,
  Main;

var
  Myrez: TShowMovingsForm;
{$R *.dfm}

FUNCTION MyFloatToStr(X:MyReal):STRING;
BEGIN
  Result:=FormatFloat(FloatFormat,X);
{  ShowMessage(FloatFormat);}
END;

procedure TForm3.Raschet(Sender:TObject; Var NrcMy:integer);

 var     f,FfileName:string;
          k:integer;
 var     tmp:real;
 var     s: String;
 var DataArrray  : array[0..7] of real;
       begin
 // редактирование поля EditX и EditY графического резю для получения напрю по Х
        Myrez:=TshowMovingsForm.Create(nil);
        Myrez.Free;
        Myrez:=TshowMovingsForm.Create(nil);
      
      //  Myrez.FormCreate(sender);
        F:=MainForm.ProjectFileName;
        if FileExists(ChangeFileExt(F,'.res')) then
        f:=ChangeFileExt(f,'.res');
        FFilename:=f;
        f:=ChangeFileExt(f,'.spr');

        Myrez.LoadResults(FfileName);
        Myrez.EditX.text:=EditX.text;
        Myrez.EditY.text:=EditY.Text;
       OldItem:=StrToInt(ComboBoxEx1.Text);

        case checkmethod of
        1: begin
        Myrez.StressMethod1Click(sender);Oldmethod:=1;end;
        2: begin
        Myrez.StressMethod2Click(sender);Oldmethod:=2;end;
        3: begin
        Myrez.StressMethod3Click(sender);Oldmethod:=3;end;
        end;

    //

         k:=NrcMy-2;
    //Массив с данными
    if  Myrez.InfoX.Text<>'' then
        DataArrray[0]:=strtofloat(Myrez.InfoX.Text)
    else
        GrafikX.Label20.Visible:=True;
    if  Myrez.InfoY.Text<>'' then
        DataArrray[1]:=strtofloat(Myrez.InfoY.Text)
    else
        GrafikY.Label20.Visible:=True;
    if  Myrez.InfoXY.Text<>'' then
        DataArrray[2]:=strtofloat(Myrez.InfoXY.Text)
    else
        GrafikXY.Label20.Visible:=True;
    if  Myrez.InfoMax.Text<>'' then
        DataArrray[3]:=strtofloat(Myrez.InfoMax.Text)
    else
        GrafikGl.Label20.Visible:=True;
    if  Myrez.InfoMin.Text<>'' then
        DataArrray[4]:=strtofloat(Myrez.InfoMin.Text)
    else
        GrafikGl2.Label20.Visible:=True;
    if  Myrez.InfoEcv.Text<>'' then
        DataArrray[5]:=strtofloat(Myrez.InfoEcv.Text)
    else
        GrafikUg.Label20.Visible:=True;
    if  Myrez.InfoMoveX.Text<>'' then
        DataArrray[6]:=strtofloat(Myrez.InfoMoveX.Text)
    else
        GrafikPerX.Label20.Visible:=True;
    if  Myrez.InfoMoveY.Text<>'' then
        DataArrray[7]:=strtofloat(Myrez.InfoMoveY.Text)
    else
        GrafikPerY.Label20.Visible:=True;
           GrafikParam(NrcMy,DataArrray);
           SetGrafikParam();
       end;

procedure TForm3.GrafikParam(var NrcMy:integer;RezArray:array of real);
var i:integer;
begin
      Case NrcMy of
        3:  begin
        //напряжение по Х
            GrafikX.Edit3.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit3.Visible:=true;
            GrafikX.Label4.Visible:=true;
            GrafikX.CheckBox1.Visible:=true;
            GrafikX.CheckBox1.Checked:=true;
        //напряжение по Y
            GrafikY.Edit3.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit3.Visible:=true;
            GrafikY.Label4.Visible:=true;
            GrafikY.CheckBox1.Visible:=true;
            GrafikY.CheckBox1.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit3.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit3.Visible:=true;
            GrafikXY.Label4.Visible:=true;
            GrafikXY.CheckBox1.Visible:=true;
            GrafikXY.CheckBox1.Checked:=true;
        //1-ое главное напряжения
            GrafikGl.Edit3.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit3.Visible:=true;
            GrafikGl.Label4.Visible:=true;
            GrafikGl.CheckBox1.Visible:=true;
            GrafikGl.CheckBox1.Checked:=true;
        //2-ое главное напряжения
            GrafikGl2.Edit3.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit3.Visible:=true;
            GrafikGl2.Label4.Visible:=true;
            GrafikGl2.CheckBox1.Visible:=true;
            GrafikGl2.CheckBox1.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit3.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit3.Visible:=true;
            GrafikUg.Label4.Visible:=true;
            GrafikUg.CheckBox1.Visible:=true;
            GrafikUg.CheckBox1.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit3.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit3.Visible:=true;
            GrafikPerX.Label4.Visible:=true;
            GrafikPerX.CheckBox1.Visible:=true;
            GrafikPerX.CheckBox1.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit3.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit3.Visible:=true;
            GrafikPerY.Label4.Visible:=true;
            GrafikPerY.CheckBox1.Visible:=true;
            GrafikPerY.CheckBox1.Checked:=true;
        //Отключаем NRC в зависимости от предпочтений четности
            if(Form3.RadioButton5.Checked)
            then
              begin
              GrafikX.CheckBox1.Checked:=False;
              GrafikY.CheckBox1.Checked:=False;
              GrafikXY.CheckBox1.Checked:=False;
              GrafikGl.CheckBox1.Checked:=False;
              GrafikGl2.CheckBox1.Checked:=False;
              GrafikUg.CheckBox1.Checked:=False;
              GrafikPerX.CheckBox1.Checked:=False;
              GrafikPerY.CheckBox1.Checked:=False;
              end
            end;
        4:  begin
        //напряжение по Х
            GrafikX.Edit4.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit4.Visible:=true;
            GrafikX.Label5.Visible:=true;
            GrafikX.CheckBox2.Visible:=true;
            GrafikX.CheckBox2.Checked:=true;
        //напряжение по Y
            GrafikY.Edit4.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit4.Visible:=true;
            GrafikY.Label5.Visible:=true;
            GrafikY.CheckBox2.Visible:=true;
            GrafikY.CheckBox2.Checked:=true;
         //касательное напряжения
            GrafikXY.Edit4.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit4.Visible:=true;
            GrafikXY.Label5.Visible:=true;
            GrafikXY.CheckBox2.Visible:=true;
            GrafikXY.CheckBox2.Checked:=true;
         //1-ое главное напряжения
            GrafikGl.Edit4.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit4.Visible:=true;
            GrafikGl.Label5.Visible:=true;
            GrafikGl.CheckBox2.Visible:=true;
            GrafikGl.CheckBox2.Checked:=true;
         //2-ое главное напряжения
            GrafikGl2.Edit4.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit4.Visible:=true;
            GrafikGl2.Label5.Visible:=true;
            GrafikGl2.CheckBox2.Visible:=true;
            GrafikGl2.CheckBox2.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit4.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit4.Visible:=true;
            GrafikUg.Label5.Visible:=true;
            GrafikUg.CheckBox2.Visible:=true;
            GrafikUg.CheckBox2.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit4.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit4.Visible:=true;
            GrafikPerX.Label5.Visible:=true;
            GrafikPerX.CheckBox2.Visible:=true;
            GrafikPerX.CheckBox2.Checked:=true;
            if(Form3.RadioButton6.Checked)
            then GrafikPerX.CheckBox2.Checked:=False;
        //Перемещения по Y
            GrafikPerY.Edit4.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit4.Visible:=true;
            GrafikPerY.Label5.Visible:=true;
            GrafikPerY.CheckBox2.Visible:=true;
            GrafikPerY.CheckBox2.Checked:=true;
        //Отключаем NRC в зависимости от предпочтений четности
            if(Form3.RadioButton6.Checked)
            then
              begin
              GrafikX.CheckBox2.Checked:=False;
              GrafikY.CheckBox2.Checked:=False;
              GrafikXY.CheckBox2.Checked:=False;
              GrafikGl.CheckBox2.Checked:=False;
              GrafikGl2.CheckBox2.Checked:=False;
              GrafikUg.CheckBox2.Checked:=False;
              GrafikPerX.CheckBox2.Checked:=False;
              GrafikPerY.CheckBox2.Checked:=False;
              end
            end;
        5:  begin
        //напряжение по Х
            GrafikX.Edit5.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit5.Visible:=true;
            GrafikX.Label6.Visible:=true;
            GrafikX.CheckBox3.Visible:=true;
            GrafikX.CheckBox3.Checked:=true;
        //напряжение по Y
            GrafikY.Edit5.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit5.Visible:=true;
            GrafikY.Label6.Visible:=true;
            GrafikY.CheckBox3.Visible:=true;
            GrafikY.CheckBox3.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit5.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit5.Visible:=true;
            GrafikXY.Label6.Visible:=true;
            GrafikXY.CheckBox3.Visible:=true;
            GrafikXY.CheckBox3.Checked:=true;
            if(Form3.RadioButton5.Checked)
            then GrafikXY.CheckBox3.Checked:=False;
         //1-ое главное напряжения
            GrafikGl.Edit5.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit5.Visible:=true;
            GrafikGl.Label6.Visible:=true;
            GrafikGl.CheckBox3.Visible:=true;
            GrafikGl.CheckBox3.Checked:=true;
        //2-ое главное напряжения
            GrafikGl2.Edit5.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit5.Visible:=true;
            GrafikGl2.Label6.Visible:=true;
            GrafikGl2.CheckBox3.Visible:=true;
            GrafikGl2.CheckBox3.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit5.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit5.Visible:=true;
            GrafikUg.Label6.Visible:=true;
            GrafikUg.CheckBox3.Visible:=true;
            GrafikUg.CheckBox3.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit5.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit5.Visible:=true;
            GrafikPerX.Label6.Visible:=true;
            GrafikPerX.CheckBox3.Visible:=true;
            GrafikPerX.CheckBox3.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit5.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit5.Visible:=true;
            GrafikPerY.Label6.Visible:=true;
            GrafikPerY.CheckBox3.Visible:=true;
            GrafikPerY.CheckBox3.Checked:=true;
        //Отключаем NRC в зависимости от выбраной четности:
            if(Form3.RadioButton5.Checked)
            then
              begin
              GrafikX.CheckBox3.Checked:=False;
              GrafikY.CheckBox3.Checked:=False;
              GrafikXY.CheckBox3.Checked:=False;
              GrafikGl.CheckBox3.Checked:=False;
              GrafikGl2.CheckBox3.Checked:=False;
              GrafikUg.CheckBox3.Checked:=False;
              GrafikPerX.CheckBox3.Checked:=False;
              GrafikPerY.CheckBox3.Checked:=False;
              end
            end;
        6:  begin
        //напряжение по Х
            GrafikX.Edit6.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit6.Visible:=true;
            GrafikX.Label7.Visible:=true;
            GrafikX.CheckBox4.Visible:=true;
            GrafikX.CheckBox4.Checked:=true;
        //напряжение по Y
            GrafikY.Edit6.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit6.Visible:=true;
            GrafikY.Label7.Visible:=true;
            GrafikY.CheckBox4.Visible:=true;
            GrafikY.CheckBox4.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit6.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit6.Visible:=true;
            GrafikXY.Label7.Visible:=true;
            GrafikXY.CheckBox4.Visible:=true;
            GrafikXY.CheckBox4.Checked:=true;
        //1-ое главное напряжения
            GrafikGl.Edit6.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit6.Visible:=true;
            GrafikGl.Label7.Visible:=true;
            GrafikGl.CheckBox4.Visible:=true;
            GrafikGl.CheckBox4.Checked:=true;
         //2-ое главное напряжения
            GrafikGl2.Edit6.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit6.Visible:=true;
            GrafikGl2.Label7.Visible:=true;
            GrafikGl2.CheckBox4.Visible:=true;
            GrafikGl2.CheckBox4.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit6.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit6.Visible:=true;
            GrafikUg.Label7.Visible:=true;
            GrafikUg.CheckBox4.Visible:=true;
            GrafikUg.CheckBox4.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit6.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit6.Visible:=true;
            GrafikPerX.Label7.Visible:=true;
            GrafikPerX.CheckBox4.Visible:=true;
            GrafikPerX.CheckBox4.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit6.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit6.Visible:=true;
            GrafikPerY.Label7.Visible:=true;
            GrafikPerY.CheckBox4.Visible:=true;
            GrafikPerY.CheckBox4.Checked:=true;
        //Отключаем NRC в зависимости от выбраной четности:
            if(Form3.RadioButton6.Checked)
            then
              begin
              GrafikX.CheckBox4.Checked:=False;
              GrafikY.CheckBox4.Checked:=False;
              GrafikXY.CheckBox4.Checked:=False;
              GrafikGl.CheckBox4.Checked:=False;
              GrafikGl2.CheckBox4.Checked:=False;
              GrafikUg.CheckBox4.Checked:=False;
              GrafikPerX.CheckBox4.Checked:=False;
              GrafikPerY.CheckBox4.Checked:=False;
              end
            end;
        7:  begin
        //напряжение по Х
            GrafikX.Edit7.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit7.Visible:=true;
            GrafikX.Label8.Visible:=true;
            GrafikX.CheckBox5.Visible:=true;
            GrafikX.CheckBox5.Checked:=true;
        //напряжение по Y
            GrafikY.Edit7.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit7.Visible:=true;
            GrafikY.Label8.Visible:=true;
            GrafikY.CheckBox5.Visible:=true;
            GrafikY.CheckBox5.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit7.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit7.Visible:=true;
            GrafikXY.Label8.Visible:=true;
            GrafikXY.CheckBox5.Visible:=true;
            GrafikXY.CheckBox5.Checked:=true;
         //1-ое главное напряжения
            GrafikGl.Edit7.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit7.Visible:=true;
            GrafikGl.Label8.Visible:=true;
            GrafikGl.CheckBox5.Visible:=true;
            GrafikGl.CheckBox5.Checked:=true;
        //2-ое главное напряжения
            GrafikGl2.Edit7.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit7.Visible:=true;
            GrafikGl2.Label8.Visible:=true;
            GrafikGl2.CheckBox5.Visible:=true;
            GrafikGl2.CheckBox5.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit7.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit7.Visible:=true;
            GrafikUg.Label8.Visible:=true;
            GrafikUg.CheckBox5.Visible:=true;
            GrafikUg.CheckBox5.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit7.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit7.Visible:=true;
            GrafikPerX.Label8.Visible:=true;
            GrafikPerX.CheckBox5.Visible:=true;
            GrafikPerX.CheckBox5.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit7.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit7.Visible:=true;
            GrafikPerY.Label8.Visible:=true;
            GrafikPerY.CheckBox5.Visible:=true;
            GrafikPerY.CheckBox5.Checked:=true;
        //Отключаем NRC в зависимости от выбраной четности:
            if(Form3.RadioButton5.Checked)
            then
              begin
              GrafikX.CheckBox5.Checked:=False;
              GrafikY.CheckBox5.Checked:=False;
              GrafikXY.CheckBox5.Checked:=False;
              GrafikGl.CheckBox5.Checked:=False;
              GrafikGl2.CheckBox5.Checked:=False;
              GrafikUg.CheckBox5.Checked:=False;
              GrafikPerX.CheckBox5.Checked:=False;
              GrafikPerY.CheckBox5.Checked:=False;
              end
            end;
        8:  begin
        //напряжение по Х
            GrafikX.Edit8.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit8.Visible:=true;
            GrafikX.Label9.Visible:=true;
            GrafikX.CheckBox6.Visible:=true;
            GrafikX.CheckBox6.Checked:=true;
        //напряжение по Y
            GrafikY.Edit8.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit8.Visible:=true;
            GrafikY.Label9.Visible:=true;
            GrafikY.CheckBox6.Visible:=true;
            GrafikY.CheckBox6.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit8.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit8.Visible:=true;
            GrafikXY.Label9.Visible:=true;
            GrafikXY.CheckBox6.Visible:=true;
            GrafikXY.CheckBox6.Checked:=true;
        //1-ое главное напряжения
            GrafikGl.Edit8.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit8.Visible:=true;
            GrafikGl.Label9.Visible:=true;
            GrafikGl.CheckBox6.Visible:=true;
            GrafikGl.CheckBox6.Checked:=true;
        //2-ое главное напряжения
            GrafikGl2.Edit8.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit8.Visible:=true;
            GrafikGl2.Label9.Visible:=true;
            GrafikGl2.CheckBox6.Visible:=true;
            GrafikGl2.CheckBox6.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit8.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit8.Visible:=true;
            GrafikUg.Label9.Visible:=true;
            GrafikUg.CheckBox6.Visible:=true;
            GrafikUg.CheckBox6.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit8.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit8.Visible:=true;
            GrafikPerX.Label9.Visible:=true;
            GrafikPerX.CheckBox6.Visible:=true;
            GrafikPerX.CheckBox6.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit8.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit8.Visible:=true;
            GrafikPerY.Label9.Visible:=true;
            GrafikPerY.CheckBox6.Visible:=true;
            GrafikPerY.CheckBox6.Checked:=true;
        //Отключаем NRC в зависимости от выбраной четности:
            if(Form3.RadioButton6.Checked)
            then
              begin
              GrafikX.CheckBox6.Checked:=False;
              GrafikY.CheckBox6.Checked:=False;
              GrafikXY.CheckBox6.Checked:=False;
              GrafikGl.CheckBox6.Checked:=False;
              GrafikGl2.CheckBox6.Checked:=False;
              GrafikUg.CheckBox6.Checked:=False;
              GrafikPerX.CheckBox6.Checked:=False;
              GrafikPerY.CheckBox6.Checked:=False;
              end
            end;
        9:  begin
        //напряжение по Х
            GrafikX.Edit9.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit9.Visible:=true;
            GrafikX.Label10.Visible:=true;
            GrafikX.CheckBox7.Visible:=true;
            GrafikX.CheckBox7.Checked:=true;
        //напряжение по Y
            GrafikY.Edit9.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit9.Visible:=true;
            GrafikY.Label10.Visible:=true;
            GrafikY.CheckBox7.Visible:=true;
            GrafikY.CheckBox7.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit9.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit9.Visible:=true;
            GrafikXY.Label10.Visible:=true;
            GrafikXY.CheckBox7.Visible:=true;
            GrafikXY.CheckBox7.Checked:=true;
        //1-ое главное напряжения
            GrafikGl.Edit9.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit9.Visible:=true;
            GrafikGl.Label10.Visible:=true;
            GrafikGl.CheckBox7.Visible:=true;
            GrafikGl.CheckBox7.Checked:=true;
        //2-ое главное напряжения
            GrafikGl2.Edit9.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit9.Visible:=true;
            GrafikGl2.Label10.Visible:=true;
            GrafikGl2.CheckBox7.Visible:=true;
            GrafikGl2.CheckBox7.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit9.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit9.Visible:=true;
            GrafikUg.Label10.Visible:=true;
            GrafikUg.CheckBox7.Visible:=true;
            GrafikUg.CheckBox7.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit9.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit9.Visible:=true;
            GrafikPerX.Label10.Visible:=true;
            GrafikPerX.CheckBox7.Visible:=true;
            GrafikPerX.CheckBox7.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit9.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit9.Visible:=true;
            GrafikPerY.Label10.Visible:=true;
            GrafikPerY.CheckBox7.Visible:=true;
            GrafikPerY.CheckBox7.Checked:=true;
        //Отключаем NRC в зависимости от выбраной четности:
            if(Form3.RadioButton5.Checked)
            then
              begin
              GrafikX.CheckBox7.Checked:=False;
              GrafikY.CheckBox7.Checked:=False;
              GrafikXY.CheckBox7.Checked:=False;
              GrafikGl.CheckBox7.Checked:=False;
              GrafikGl2.CheckBox7.Checked:=False;
              GrafikUg.CheckBox7.Checked:=False;
              GrafikPerX.CheckBox7.Checked:=False;
              GrafikPerY.CheckBox7.Checked:=False;
              end
            end;
        10: begin
        //напряжение по Х
            GrafikX.Edit10.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit10.Visible:=true;
            GrafikX.Label11.Visible:=true;
            GrafikX.CheckBox8.Visible:=true;
            GrafikX.CheckBox8.Checked:=true;
        //напряжение по Y
            GrafikY.Edit10.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit10.Visible:=true;
            GrafikY.Label11.Visible:=true;
            GrafikY.CheckBox8.Visible:=true;
            GrafikY.CheckBox8.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit10.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit10.Visible:=true;
            GrafikXY.Label11.Visible:=true;
            GrafikXY.CheckBox8.Visible:=true;
            GrafikXY.CheckBox8.Checked:=true;
         //1-ое главное напряжения
            GrafikGl.Edit10.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit10.Visible:=true;
            GrafikGl.Label11.Visible:=true;
            GrafikGl.CheckBox8.Visible:=true;
            GrafikGl.CheckBox8.Checked:=true;
         //2-ое главное напряжения
            GrafikGl2.Edit10.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit10.Visible:=true;
            GrafikGl2.Label11.Visible:=true;
            GrafikGl2.CheckBox8.Visible:=true;
            GrafikGl2.CheckBox8.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit10.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit10.Visible:=true;
            GrafikUg.Label11.Visible:=true;
            GrafikUg.CheckBox8.Visible:=true;
            GrafikUg.CheckBox8.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit10.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit10.Visible:=true;
            GrafikPerX.Label11.Visible:=true;
            GrafikPerX.CheckBox8.Visible:=true;
            GrafikPerX.CheckBox8.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit10.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit10.Visible:=true;
            GrafikPerY.Label11.Visible:=true;
            GrafikPerY.CheckBox8.Visible:=true;
            GrafikPerY.CheckBox8.Checked:=true;
        //Отключаем NRC в зависимости от выбраной четности:
            if(Form3.RadioButton6.Checked)
            then
              begin
              GrafikX.CheckBox8.Checked:=False;
              GrafikY.CheckBox8.Checked:=False;
              GrafikXY.CheckBox8.Checked:=False;
              GrafikGl.CheckBox8.Checked:=False;
              GrafikGl2.CheckBox8.Checked:=False;
              GrafikUg.CheckBox8.Checked:=False;
              GrafikPerX.CheckBox8.Checked:=False;
              GrafikPerY.CheckBox8.Checked:=False;
              end
            end;
        11: begin
        //напряжение по Х
            GrafikX.Edit11.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit11.Visible:=true;
            GrafikX.Label16.Visible:=true;
            GrafikX.CheckBox9.Visible:=true;
            GrafikX.CheckBox9.Checked:=true;
        //напряжение по Y
            GrafikY.Edit11.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit11.Visible:=true;
            GrafikY.Label16.Visible:=true;
            GrafikY.CheckBox9.Visible:=true;
            GrafikY.CheckBox9.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit11.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit11.Visible:=true;
            GrafikXY.Label16.Visible:=true;
            GrafikXY.CheckBox9.Visible:=true;
            GrafikXY.CheckBox9.Checked:=true;
         //1-ое главное напряжения
            GrafikGl.Edit11.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit11.Visible:=true;
            GrafikGl.Label16.Visible:=true;
            GrafikGl.CheckBox9.Visible:=true;
            GrafikGl.CheckBox9.Checked:=true;
        //2-ое главное напряжения
            GrafikGl2.Edit11.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit11.Visible:=true;
            GrafikGl2.Label16.Visible:=true;
            GrafikGl2.CheckBox9.Visible:=true;
            GrafikGl2.CheckBox9.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit11.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit11.Visible:=true;
            GrafikUg.Label16.Visible:=true;
            GrafikUg.CheckBox9.Visible:=true;
            GrafikUg.CheckBox9.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit11.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit11.Visible:=true;
            GrafikPerX.Label16.Visible:=true;
            GrafikPerX.CheckBox9.Visible:=true;
            GrafikPerX.CheckBox9.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit11.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit11.Visible:=true;
            GrafikPerY.Label16.Visible:=true;
            GrafikPerY.CheckBox9.Visible:=true;
            GrafikPerY.CheckBox9.Checked:=true;
        //Отключаем NRC в зависимости от выбраной четности:
            if(Form3.RadioButton5.Checked)
            then
              begin
              GrafikX.CheckBox9.Checked:=False;
              GrafikY.CheckBox9.Checked:=False;
              GrafikXY.CheckBox9.Checked:=False;
              GrafikGl.CheckBox9.Checked:=False;
              GrafikGl2.CheckBox9.Checked:=False;
              GrafikUg.CheckBox9.Checked:=False;
              GrafikPerX.CheckBox9.Checked:=False;
              GrafikPerY.CheckBox9.Checked:=False;
              end
            end;
        12: begin
        //напряжение по Х
            GrafikX.Edit12.Text:=MyfloattoStr(RezArray[0]);
            GrafikX.series1.AddXY(NrcMy,RezArray[0]);
            GrafikX.Edit12.Visible:=true;
            GrafikX.Label17.Visible:=true;
            GrafikX.CheckBox10.Visible:=true;
            GrafikX.CheckBox10.Checked:=true;
        //напряжение по Y
            GrafikY.Edit12.Text:=MyfloattoStr(RezArray[1]);
            GrafikY.series1.AddXY(NrcMy,RezArray[1]);
            GrafikY.Edit12.Visible:=true;
            GrafikY.Label17.Visible:=true;
            GrafikY.CheckBox10.Visible:=true;
            GrafikY.CheckBox10.Checked:=true;
        //касательное напряжения
            GrafikXY.Edit12.Text:=MyfloattoStr(RezArray[2]);
            GrafikXY.series1.AddXY(NrcMy,RezArray[2]);
            GrafikXY.Edit12.Visible:=true;
            GrafikXY.Label17.Visible:=true;
            GrafikXY.CheckBox10.Visible:=true;
            GrafikXY.CheckBox10.Checked:=true;
        //1-ое главное напряжения
            GrafikGl.Edit12.Text:=MyfloattoStr(RezArray[3]);
            GrafikGl.series1.AddXY(NrcMy,RezArray[3]);
            GrafikGl.Edit12.Visible:=true;
            GrafikGl.Label17.Visible:=true;
            GrafikGl.CheckBox10.Visible:=true;
            GrafikGl.CheckBox10.Checked:=true;
        //2-ое главное напряжения
            GrafikGl2.Edit12.Text:=MyfloattoStr(RezArray[4]);
            GrafikGl2.series1.AddXY(NrcMy,RezArray[4]);
            GrafikGl2.Edit12.Visible:=true;
            GrafikGl2.Label17.Visible:=true;
            GrafikGl2.CheckBox10.Visible:=true;
            GrafikGl2.CheckBox10.Checked:=true;
        //Эквивалентное напряжение
            GrafikUg.Edit12.Text:=MyfloattoStr(RezArray[5]);
            GrafikUg.series1.AddXY(NrcMy,RezArray[5]);
            GrafikUg.Edit12.Visible:=true;
            GrafikUg.Label17.Visible:=true;
            GrafikUg.CheckBox10.Visible:=true;
            GrafikUg.CheckBox10.Checked:=true;
        //Перемещения по X
            GrafikPerX.Edit12.Text:=MyfloattoStr(RezArray[6]);
            GrafikPerX.series1.AddXY(NrcMy,RezArray[6]);
            GrafikPerX.Edit12.Visible:=true;
            GrafikPerX.Label17.Visible:=true;
            GrafikPerX.CheckBox10.Visible:=true;
            GrafikPerX.CheckBox10.Checked:=true;
        //Перемещения по Y
            GrafikPerY.Edit12.Text:=MyfloattoStr(RezArray[7]);
            GrafikPerY.series1.AddXY(NrcMy,RezArray[7]);
            GrafikPerY.Edit12.Visible:=true;
            GrafikPerY.Label17.Visible:=true;
            GrafikPerY.CheckBox10.Visible:=true;
            GrafikPerY.CheckBox10.Checked:=true;

        //Отключаем NRC в зависимости от выбраной четности:
            if(Form3.RadioButton6.Checked)
            then
              begin
              GrafikX.CheckBox10.Checked:=False;
              GrafikY.CheckBox10.Checked:=False;
              GrafikXY.CheckBox10.Checked:=False;
              GrafikGl.CheckBox10.Checked:=False;
              GrafikGl2.CheckBox10.Checked:=False;
              GrafikUg.CheckBox10.Checked:=False;
              GrafikPerX.CheckBox10.Checked:=False;
              GrafikPerY.CheckBox10.Checked:=False;
              end
            end;

     end;
end;


Procedure TForm3.UstanovkaNRC(Sender:TOBject;Var NrcMy:Integer);
  var   FMainParams,MP:TMainParams;
        FMainParamsMaterial,MPM:TMainParamsMaterial;
         FFileName,f:string;

        begin
         F:=Project_GetFormFile;
         if FileExists(F) then
         FFilename:=f;

// Вытаскиваем значения NRC, изменяем их и записываем обратно

       if (Length(FFileName)>0) and (LowerCase(ExtractFileExt(FFileName))='.sfm') then
             begin

                  with TZonesClass.Create do
                    begin
                    CountOfNodesInZone:=NrcMy*2 + (NrcMy - 2 )*2;
                    Load(FFileName);
                    FmainParams:=MainParamsClass.MainParams;
                    FmainParamsMaterial:=MainParamsClass.MainParamsMaterial;
                    FMainParams.NRC:=NrcMy;
//                    if NrcMy=3 then NrcOld:=FMainParams.NRC;
                    MainParamsClass.MainParamsMaterial :=FmainParamsMaterial;
                    MainParamsClass.MainParams:=FMainParams;
                    Save(FFileName);
                    Free;
                    end;
             end;
end;


{Имаметдинов}
{ | }
{\ /}
Procedure UstanovkaParametra(Var Param_znach:Integer);
  var   FMainParams,MP:TMainParams;
        FMainParamsMaterial,MPM:TMainParamsMaterial;
         FFileName,f:string;

        begin
         F:=Project_GetFormFile;
         if FileExists(F) then
         FFilename:=f;

// Вытаскиваем значения NRC, изменяем их и записываем обратно

       if (Length(FFileName)>0) and (LowerCase(ExtractFileExt(FFileName))='.sfm') then
             begin

                  with TZonesClass.Create do
                    begin
                    CountOfNodesInZone:=Param_znach*2 + (Param_znach - 2 )*2;
                    Load(FFileName);
                    FmainParams:=MainParamsClass.MainParams;
                    FmainParamsMaterial:=MainParamsClass.MainParamsMaterial;
                    FMainParams.NRC:=Param_znach;
//                    if Param_znach=3 then NrcOld:=FMainParams.NRC;
                    MainParamsClass.MainParamsMaterial :=FmainParamsMaterial;
                    MainParamsClass.MainParams:=FMainParams;
                    Save(FFileName);
                    Free;
                    end;
             end;
end;
{ / \}
{  | }
{Имаметдинов}


procedure TForm3.delay(sender:TObject;Var n:integer);
var i,j,k:integer;
  begin
   for i:=1 to 10000000 do
              begin
               for j:=1 to n do
               begin
              k:=i+1;
               end;
              end;
  end;



Procedure Tform3.Vichisl(Sender:Tobject;Var NrcMy:integer;Var n:integer);
var
        Ret: Integer;
Begin

             Form3.UstanovkaNRC(Form3,NrcMy);//записываем NRC

             MainForm1.RunClick(Form3);// Расчет
             WaitForm1.StartShow('Построение графиков сходимости...');
             Repeat
                Application.ProcessMessages;
             Until WaitForm1.FileExecuted=false;
             Form3.Raschet(MainForm1,NrcMy);//Извлечение значения

             //WaitForm1.Timer1Timer(Form3);
end;

procedure TForm3.Button7Click(Sender: TObject);
 var   NrcMy:integer;
       n,k:integer;

begin
//*************************************************************************


             if MainForm1.ToolButton12.Enabled=False then
              begin
             ShowMessage('Проект необходимо откомпилировать');
             Button7.Enabled:=false;
             exit;
             end;
             if ( strtoint(Edit1.Text)>12)or(strtoint(Edit1.Text)<3) then
              begin
              //Label4.Visible:=true;
              Button7.Enabled:=false;
              exit;
              end;
             N2.Enabled:=True;
             GrafikX.series1.Clear;
             GrafikY.series1.Clear;
             GrafikXY.series1.Clear;
             GrafikGl.series1.Clear;
             GrafikGl2.series1.Clear;
             GrafikUG.series1.Clear;
//             GrafikPerX.series1.Clear;
//             GrafikPerY.series1.Clear;
             GrafikX.series2.Clear;
             GrafikY.series2.Clear;
             GrafikXY.series2.Clear;
             GrafikGl.series2.Clear;
             GrafikGl2.series2.Clear;
             GrafikUG.series2.Clear;
//             GrafikPerX.series2.Clear;
//             GrafikPerY.series2.Clear;
 //создание форм
             GroupFormCreate(Sender);

             n:=130;
             for NrcMy:=3 to strtoint(Edit1.Text) do
             begin
                Application.ProcessMessages;
                Vichisl(Form3,NrcMy,n);
                //Application.ProcessMessages;
             end;
// Ошибка появления 10 NRC при расчете  --TSH
//
{             Vichisl(Form3,NrcOld,n);
             Application.ProcessMessages;}
//  --TSH
             GRPoint[strtoint(ComboBoxEx1.Text)]:=1;
             Button1.Enabled:=true;
             Button2.Enabled:=true;
             Button3.Enabled:=true;
             Button4.Enabled:=true;
             Button5.Enabled:=true;
             Button6.Enabled:=true;
             Button9.Enabled:=true;
             Button13.Enabled:=true;
             Button14.Enabled:=true;


// --TSH  Кнопку "Построить графики"  - не активная после построения
           Button7.Enabled:=False;
  end;

procedure TForm3.Button8Click(Sender: TObject);

begin
        Form3.Close;
//    SelectedPointsX := nil;
//    SelectedPointsYend := nil;

end;

procedure TForm3.Button1Click(Sender: TObject);
begin
     GrafikX.ShowModal;

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
    GrafikY.Showmodal;
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
    grafikXY.ShowModal;
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
    GrafikGl.ShowModal;
end;


procedure TForm3.Edit1Change(Sender: TObject);
begin

             Button1.Enabled:=false;
             Button2.Enabled:=false;
             Button3.Enabled:=false;
             Button4.Enabled:=false;
             Button5.Enabled:=false;
             Button6.Enabled:=false;
             Button9.Enabled:=false;
             Button13.Enabled:=false;
             Button14.Enabled:=false;

             grafikx.Series1.Clear;
             grafikY.Series1.Clear;
             grafikXY.Series1.Clear;
             grafikGL.Series1.Clear;
             grafikGL2.Series1.Clear;
             grafikUg.Series1.Clear;

             {grafikX.Ochistka(GrafikX);
             grafikY.Ochistka(GrafikY);
             GrafikXY.Ochistka(GrafikXY);
             GrafikGl.Ochistka(GrafikGl);
             GrafikGl2.Ochistka(GrafikGl2);
             GrafikUg.Ochistka(GrafikUg);}

             GroupFormCreate(Sender);

             //label4.Visible:=false;
             Button7.Enabled:=true;

end;

procedure TForm3.Button5Click(Sender: TObject);
begin
     grafikGl2.ShowModal;
end;



procedure TForm3.Button6Click(Sender: TObject);
var ole_d,ole_doc: Variant;
    S, X, Y: String;
var ole_r, ole_p, ole_s, ole_t, ole_tc, ole_c: Variant;
    N, i, nrc: integer;
begin
     TRY
X:=EditX.Text;
Y:=EditY.Text;
ole.CreateObject('word.application', true);
ole.OleObject.documents.Add;
ole_d := ole.OleObject.ActiveDocument;
    ole_r := ole_d.Content;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:=' Исследуемая точка:    X = ' + X + '    Y = ' + Y;
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);


N:=strtoint(Form3.Edit1.Text);
ole_r := ole_d.Content;
ole_r.Collapse(0);
ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:='Напряжение по X';
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
GrafikX.Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);

ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:='Напряжение по Y';
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
GrafikY.Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);

ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:='Касательное напряжение';
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
GrafikXY.Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);

ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:='1-ое главное напряжение';
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
GrafikGL.Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);

ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:='2-ое главное напряжение';
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
GrafikGL2.Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);

ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:='Эквивалентное напряжение';
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
GrafikUg.Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);


ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:='Перемещение по Х';
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
GrafikPerX.Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);


ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:='Перемещение по Y';
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
GrafikPerY.Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);

ole_t:=ole_d.Tables.Add(ole_r,N-1,9);
ole_tc:=ole_t.Columns.Item(1);
ole_tc.Width:=45;
ole_tc:=ole_t.Columns.Item(2);
ole_tc.Width:=45;
ole_tc:=ole_t.Columns.Item(3);
ole_tc.Width:=45;
ole_tc:=ole_t.Columns.Item(4);
ole_tc.Width:=45;
ole_tc:=ole_t.Columns.Item(5);
ole_tc.Width:=45;
ole_tc:=ole_t.Columns.Item(6);
ole_tc.Width:=45;
ole_tc:=ole_t.Columns.Item(7);
ole_tc.Width:=45;
ole_tc:=ole_t.Columns.Item(8);
ole_tc.Width:=65;
ole_tc:=ole_t.Columns.Item(9);
ole_tc.Width:=65;
//ole_tc.Width:=70;

    ole_c:=ole_t.Cell(1,1);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('NRC');

    ole_c:=ole_t.Cell(1,2);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('Напряжение по X');

    ole_c:=ole_t.Cell(1,3);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('Напряжение по Y');

    ole_c:=ole_t.Cell(1,4);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('Касательное напряжение');

    ole_c:=ole_t.Cell(1,5);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('1-ое главное напряжение');

    ole_c:=ole_t.Cell(1,6);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('2-ое главное напряжение');

    ole_c:=ole_t.Cell(1,7);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('Эквивалентное напряжение');

    ole_c:=ole_t.Cell(1,8);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('Перемещение по X');

    ole_c:=ole_t.Cell(1,9);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    ole_s.TypeText('Перемещение по Y');



for i:=1 to N-2 do begin
    ole_c:=ole_t.Cell(i+1,1);
    ole_c.Select;
    ole_s:=ole_d.application.Selection;

    nrc:=i+2;
    Str(nrc,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,2);
    if PointsX[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    Str(GrafikX.Chart1.Series[1].YValues.Value[i-1]:15:MantissStress,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,3);
    if PointsY[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    Str(GrafikY.Chart1.Series[1].YValues.Value[i-1]:15:MantissStress,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,4);
    if PointsXY[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    Str(GrafikXY.Chart1.Series[1].YValues.Value[i-1]:15:MantissStress,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,5);
    if PointsGL[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    Str(GrafikGL.Chart1.Series[1].YValues.Value[i-1]:15:MantissStress,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,6);
    if PointsGL2[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    Str(GrafikGL2.Chart1.Series[1].YValues.Value[i-1]:15:MantissStress,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,7);
    if PointsUg[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    Str(GrafikUg.Chart1.Series[1].YValues.Value[i-1]:15:MantissStress,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,8);
    if PointsPerX[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    Str(GrafikPerX.Chart1.Series[1].YValues.Value[i-1]:15:MantissMove,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,9);
    if PointsPerY[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_d.application.Selection;
    Str(GrafikPerY.Chart1.Series[1].YValues.Value[i-1]:15:MantissMove,S);
    ole_s.TypeText(S);

end;
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);


ole_r := ole_d.Content;
ole_r.Collapse(0);

ole_d.Application.Visible := True;

     EXCEPT
           MessageDlg('Ошибка при попытке экспорта информации в MS Word.',mtError,[mbYes],0);
     END;
end;

{
procedure OutGraph(ole_doc: Variant; Chart1: TChart; X, Y, Lab: String);
var ole_r, ole_p, ole_s, ole_t, ole_tc, ole_c: Variant;
    N, i, nrc: integer;
    S: String;
begin
N:=strtoint(Form3.Edit1.Text);
ole_r := ole_doc.Content;
ole_r.Collapse(0);
ole_p := ole_r.Paragraphs.Add(ole_r);
ole_p.Alignment:=1;
    ole_r.Select;
    ole_s:=ole_doc.application.Selection;
    S:=Lab;
    ole_s.TypeText(S);
    ole_r := ole_doc.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
//    ole_r := ole_doc.Content;
//    ole_r.Collapse(0);
//    ole_r.Select;
//    ole_s:=ole_doc.application.Selection;
//    S:='X = ' + X + '    Y = ' + Y;
//    ole_s.TypeText(S);
//   ole_r := ole_doc.Content;
//    ole_r.Collapse(0);
//    ole_r.Paragraphs.Add(ole_r);
//    ole_r.Collapse(0);
//    ole_r.Paragraphs.Add(ole_r);
//    ole_r.Collapse(0);
ole_t:=ole_doc.Tables.Add(ole_r,N-1,2);
ole_tc:=ole_t.Columns.Item(1);
ole_tc.Width:=50;
ole_tc:=ole_t.Columns.Item(2);
ole_tc.Width:=150;

    ole_c:=ole_t.Cell(1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('NRC');

    ole_c:=ole_t.Cell(1,2);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText(Lab);

for i:=1 to N-2 do begin
    ole_c:=ole_t.Cell(i+1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    nrc:=i+2;
    Str(nrc,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,2);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    Str(Chart1.Series[0].YValues.Value[i-1]:1:8,S);
    ole_s.TypeText(S);
end;
    ole_r := ole_doc.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);

end;

begin
     TRY
X:=EditX.Text;
Y:=EditY.Text;
ole.CreateObject('word.application', true);
ole.OleObject.documents.Add;
ole_d := ole.OleObject.ActiveDocument;
    ole_r := ole_d.Content;
    ole_r.Select;
    ole_s:=ole_d.application.Selection;
    S:=' Исследуемая точка:    X = ' + X + '    Y = ' + Y;
    ole_s.TypeText(S);
    ole_r := ole_d.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);

OutGraph(ole_d, GrafikX.Chart1, X, Y,'Напряжение по X');
OutGraph(ole_d, GrafikY.Chart1, X, Y,'Напряжение по Y');
OutGraph(ole_d, GrafikXY.Chart1, X, Y,'Касательное напряжение');
OutGraph(ole_d, GrafikGL.Chart1, X, Y,'1-ое главное напряжение');
OutGraph(ole_d, GrafikGL2.Chart1, X, Y,'2-ое главное напряжение');
OutGraph(ole_d, GrafikUg.Chart1, X, Y,'Эквивалентное напряжение');

ole_r := ole_d.Content;
ole_r.Collapse(0);

ole_d.Application.Visible := True;

     EXCEPT
           MessageDlg('Ошибка при попытке экспорта информации в MS Word.',mtError,[mbYes],0);
     END;
end;
}

procedure TForm3.Button9Click(Sender: TObject);
begin
     grafikUg.ShowModal;
end;


procedure TForm3.Button10Click(Sender: TObject);
begin
Form9.Edit1.Clear;
Form9.Edit2.Clear;
Form9.ShowModal;
if (EditX.Text<>'')and(OldItem<>StrToInt(ComboBoxEx1.Text)) then
 begin
 button1.Enabled:=False;
button2.Enabled:=False;
button3.Enabled:=False;
button4.Enabled:=False;
button5.Enabled:=False;
button6.Enabled:=False;
button9.Enabled:=False;
button13.Enabled:=False;
button14.Enabled:=False;
 end;
end;

procedure TForm3.AddPoint();
var s:String;
begin
if (Form9.Edit1.Text <> '') and (Form9.Edit2.Text <> '') then
 begin
  if ComboBoxEx1.Items.Count = 0 then CurPoint:=1;
  ComboBoxEx1.Items.Add(inttostr(CurPoint));
//Значения из диалога помещаются в поля координат   ---TSH
  SelectedPointsX[CurPoint] := strtofloat(Form9.Edit1.Text);
  SelectedPointsY[CurPoint] := strtofloat(Form9.Edit2.Text);

//Показываем последний элемент   ---TSH
  s := ComboBoxEx1.Items[CurPoint-1];
  ComboBoxEx1.Text := s;
  EditX.Text := floattostr(SelectedPointsX[strtoint(s)]);
  EditY.Text := floattostr(SelectedPointsY[strtoint(s)]);
  if (CurPoint >= 5) then  Button10.Enabled:=false;

//Активация удаления   ---TSH
    Button11.Enabled:=true;
    CurPoint:=CurPoint+1;
//Активация ЕСК   ---TSH
   if(CurPoint > 2) then Button12.Enabled:=true;

 end;
end;

procedure TForm3.ComboBoxEx1Select(Sender: TObject);
var s:String;
    GS:boolean;
begin
   s := ComboBoxEx1.Text;
  EditX.Text := floattostr(SelectedPointsX[strtoint(s)]);
  EditY.Text := floattostr(SelectedPointsY[strtoint(s)]);
  GS:=False;
  if (OldItem=StrToInt(ComboBoxEx1.Text))and (Oldmethod=checkmethod) then
  GS:=True;
  button1.Enabled:=GS;
  button2.Enabled:=GS;
  button3.Enabled:=GS;
  button4.Enabled:=GS;
  button5.Enabled:=GS;
  button6.Enabled:=GS;
  button7.Enabled:=not(GS);
  button9.Enabled:=GS;
  button13.Enabled:=GS;
  button14.Enabled:=GS;
end;

procedure TForm3.Button11Click(Sender: TObject);
var i:integer;
begin
 Form10.ComboBox1.Clear;
for i:=0 to CurPoint-2 do begin
 Form10.ComboBox1.Items.Add(ComboBoxEx1.Items[i]);
end;
 Form10.ComboBox1.Text:=ComboBoxEx1.Text;
 Form10.ShowModal;
 Oldmethod:=0;
 if (EditX.Text = '')or(OldItem<>StrToInt(ComboBoxEx1.Text)) then
 begin
 button1.Enabled:=False;
button2.Enabled:=False;
button3.Enabled:=False;
button4.Enabled:=False;
button5.Enabled:=False;
button6.Enabled:=False;
button7.Enabled:=True;
button9.Enabled:=False;
button13.Enabled:=False;
button12.Enabled:=False;
button14.Enabled:=False;
 end;
 if (EditX.Text = '') then   button7.Enabled:=False;
end;


procedure TForm3.EditXChange(Sender: TObject);
begin
    Button7.Enabled:=true;
end;

procedure TForm3.EditYChange(Sender: TObject);
begin
    Button7.Enabled:=true;
end;

procedure TForm3.Button12Click(Sender: TObject);
var i:integer;
begin

Form11.Free;
Form11 := TForm11.Create(nil);

Form11.CheckBox1.Visible:=false;
Form11.CheckBox1.Checked:=false;
Form11.CheckBox2.Visible:=false;
Form11.CheckBox2.Checked:=false;
Form11.CheckBox3.Visible:=false;
Form11.CheckBox3.Checked:=false;
Form11.CheckBox4.Visible:=false;
Form11.CheckBox4.Checked:=false;
Form11.CheckBox5.Visible:=false;
Form11.CheckBox5.Checked:=false;

Form11.Edit1.Clear;
Form11.Edit2.Clear;
Form11.Edit3.Clear;
Form11.Edit4.Clear;
Form11.Edit5.Clear;
Form11.Edit6.Clear;
Form11.Edit7.Clear;
Form11.Edit8.Clear;
Form11.Edit9.Clear;
Form11.Edit10.Clear;

Form11.Edit1.Visible:=false;
Form11.Edit2.Visible:=false;
Form11.Edit3.Visible:=false;
Form11.Edit4.Visible:=false;
Form11.Edit5.Visible:=false;
Form11.Edit6.Visible:=false;
Form11.Edit7.Visible:=false;
Form11.Edit8.Visible:=false;
Form11.Edit9.Visible:=false;
Form11.Edit10.Visible:=false;

if(ComboBoxEx1.Items.Count >= 2) then Form11.CheckBox1.Visible:=true;
if(ComboBoxEx1.Items.Count >= 2) then Form11.CheckBox1.Checked:=false;
if(ComboBoxEx1.Items.Count >= 2) then Form11.CheckBox2.Visible:=true;
if(ComboBoxEx1.Items.Count >= 2) then Form11.CheckBox2.Checked:=false;
if(ComboBoxEx1.Items.Count >= 3) then Form11.CheckBox3.Visible:=true;
if(ComboBoxEx1.Items.Count >= 3) then Form11.CheckBox3.Checked:=false;
if(ComboBoxEx1.Items.Count >= 4) then Form11.CheckBox4.Visible:=true;
if(ComboBoxEx1.Items.Count >= 4) then Form11.CheckBox4.Checked:=false;
if(ComboBoxEx1.Items.Count >= 5) then Form11.CheckBox5.Visible:=true;
if(ComboBoxEx1.Items.Count >= 5) then Form11.CheckBox5.Checked:=false;

if(ComboBoxEx1.Items.Count >= 2) then Form11.Edit1.Text:=floattostr(SelectedPointsX[1]);
if(ComboBoxEx1.Items.Count >= 2) then Form11.Edit2.Text:=floattostr(SelectedPointsY[1]);
if(ComboBoxEx1.Items.Count >= 2) then Form11.Edit3.Text:=floattostr(SelectedPointsX[2]);
if(ComboBoxEx1.Items.Count >= 2) then Form11.Edit4.Text:=floattostr(SelectedPointsY[2]);
if(ComboBoxEx1.Items.Count >= 3) then Form11.Edit5.Text:=floattostr(SelectedPointsX[3]);
if(ComboBoxEx1.Items.Count >= 3) then Form11.Edit6.Text:=floattostr(SelectedPointsY[3]);
if(ComboBoxEx1.Items.Count >= 4) then Form11.Edit7.Text:=floattostr(SelectedPointsX[4]);
if(ComboBoxEx1.Items.Count >= 4) then Form11.Edit8.Text:=floattostr(SelectedPointsY[4]);
if(ComboBoxEx1.Items.Count >= 5) then Form11.Edit9.Text:=floattostr(SelectedPointsX[5]);
if(ComboBoxEx1.Items.Count >= 5) then Form11.Edit10.Text:=floattostr(SelectedPointsY[5]);

if(ComboBoxEx1.Items.Count >= 2) then Form11.Edit1.Visible:=true;
if(ComboBoxEx1.Items.Count >= 2) then Form11.Edit2.Visible:=true;
if(ComboBoxEx1.Items.Count >= 2) then Form11.Edit3.Visible:=true;
if(ComboBoxEx1.Items.Count >= 2) then Form11.Edit4.Visible:=true;
if(ComboBoxEx1.Items.Count >= 3) then Form11.Edit5.Visible:=true;
if(ComboBoxEx1.Items.Count >= 3) then Form11.Edit6.Visible:=true;
if(ComboBoxEx1.Items.Count >= 4) then Form11.Edit7.Visible:=true;
if(ComboBoxEx1.Items.Count >= 4) then Form11.Edit8.Visible:=true;
if(ComboBoxEx1.Items.Count >= 5) then Form11.Edit9.Visible:=true;
if(ComboBoxEx1.Items.Count >= 5) then Form11.Edit10.Visible:=true;

Form11.ClientHeight:=420;
Form11.ClientWidth:=294;

for i:=1 to 5 do Form11.checkedpoints[i]:=0;

Form11.ShowModal;
end;

procedure TForm3.Button13Click(Sender: TObject);
begin
        GrafikPerX.ShowModal;
end;

procedure TForm3.Button14Click(Sender: TObject);
begin
        GrafikPerY.ShowModal;
end;

procedure TForm3.FormShow(Sender: TObject);
var
  FMainParams,MP:TMainParams;
  FMainParamsMaterial,MPM:TMainParamsMaterial;
  FFileName,f:string;
BEGIN
          Caption:= Caption + ' ' +GetProjectName;
         F:=Project_GetFormFile;
         if FileExists(F) then
         FFilename:=f;

// Вытаскиваем значения NRC, изменяем их и записываем обратно

       if (Length(FFileName)>0) and (LowerCase(ExtractFileExt(FFileName))='.sfm') then
             begin

                  with TZonesClass.Create do
                    begin
                    Load(FFileName);
                    FmainParams:=MainParamsClass.MainParams;
                    FmainParamsMaterial:=MainParamsClass.MainParamsMaterial;
                    NrcOld:=FMainParams.NRC;
                    MainParamsClass.MainParamsMaterial :=FmainParamsMaterial;
                    MainParamsClass.MainParams:=FMainParams;
                    Save(FFileName);
                    Free;
                    end;
             end;
  Button7.Enabled := False;
end;



procedure TForm3.StressMethod1Click(Sender: TObject);
begin
Grdisplay:=False;
if (Oldmethod =1)and(OldItem=StrToInt(ComboBoxEx1.Text)) then
Grdisplay:=True;
if Editx.Text <> '' then
begin
button1.Enabled:=Grdisplay;
button2.Enabled:=Grdisplay;
button3.Enabled:=Grdisplay;
button4.Enabled:=Grdisplay;
button5.Enabled:=Grdisplay;
button6.Enabled:=Grdisplay;
button7.Enabled:=not(Grdisplay);
button9.Enabled:=Grdisplay;
button13.Enabled:=Grdisplay;
button14.Enabled:=Grdisplay;
end;
        checkmethod:=1;
end;

procedure TForm3.StressMethod2Click(Sender: TObject);
begin
Grdisplay:=False;
if (Oldmethod =2)and(OldItem=StrToInt(ComboBoxEx1.Text)) then
Grdisplay:=True;
if Editx.Text <> '' then
begin
button1.Enabled:=Grdisplay;
button2.Enabled:=Grdisplay;
button3.Enabled:=Grdisplay;
button4.Enabled:=Grdisplay;
button5.Enabled:=Grdisplay;
button6.Enabled:=Grdisplay;
button7.Enabled:=not(Grdisplay);
button9.Enabled:=Grdisplay;
button13.Enabled:=Grdisplay;
button14.Enabled:=Grdisplay;
end;
        checkmethod:=2;
end;

procedure TForm3.StressMethod3Click(Sender: TObject);
begin
Grdisplay:=False;
if (Oldmethod =3)and(OldItem=StrToInt(ComboBoxEx1.Text)) then
Grdisplay:=True;
if Editx.Text <> '' then
begin
button1.Enabled:=Grdisplay;
button2.Enabled:=Grdisplay;
button3.Enabled:=Grdisplay;
button4.Enabled:=Grdisplay;
button5.Enabled:=Grdisplay;
button6.Enabled:=Grdisplay;
button7.Enabled:=not(Grdisplay);
button9.Enabled:=Grdisplay;
button13.Enabled:=Grdisplay;
button14.Enabled:=Grdisplay;
end;
        checkmethod:=3;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
checkmethod:=1;
Oldmethod:=0;
OldItem:=-1;
MantissStress:=0;
MantissMove:=5;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
var   n,i:Integer;
begin
  n:=130;
        if button1.Enabled=True  then
          begin
          Vichisl(Form3,NrcOld,n);
          Application.ProcessMessages;
          end;
          for i:=1 to 5 do
          begin
           SelectedPointsX[i]:=0;
           SelectedPointsY[i]:=0;
           GRPoint[i]:=0;
          end;
          MantissStress:=0;
          Edit2.Text:= intToStr(MantissStress);
          MantissMove:=5;
          Edit3.Text:= intToStr(MantissMove);
        button1.Enabled := False;
        button2.Enabled := False;
        button3.Enabled := False;
        button4.Enabled := False;
        button5.Enabled := False;
        button6.Enabled := False;
        button7.Enabled := False;
        button9.Enabled := False;
        button10.Enabled := True;
        button11.Enabled := False;
        button12.Enabled := False;
        button13.Enabled := False;
        button14.Enabled := False;
        editx.Clear;
        edity.Clear;
        ComboBoxEx1.Clear;
end;

procedure TForm3.Edit2Change(Sender: TObject);
begin
  try
    MantissStress := StrToInt(Edit2.Text);
  except
    MantissStress := 0;
  end;
end;

procedure TForm3.Edit3Change(Sender: TObject);
begin
  try
    MantissMove := StrToInt(Edit3.Text);
  except
    MantissMove := 5;
  end;

end;

procedure TForm3.N2Click(Sender: TObject);
var
  f: TextFile;
  s: string;
  NrcMy:integer;
  OldSeparator:Char;
begin
  if not sdSave.Execute then Exit;
  try
    if  FileExists(sdSave.FileName) then
      case MessageBox(0, 'Файл существует. Перезаписать данные?'+#10#13+'Да - перезаписать файл'+
        #10#13+'Нет - добавить данные в файл', 'Запись данных', MB_YESNOCANCEL) of
        IDYES:
          begin
            AssignFile(f, sdSave.FileName);
            Rewrite(f);
          end;
        IDNO:
          begin
            AssignFile(f, sdSave.FileName);
            Append(f);
          end;
        IDCANCEL:   Exit;
      end
    else
    begin
      AssignFile(f, sdSave.FileName);
      Rewrite(f);
    end;
  except
    ShowMessage('Ошибка открытия файла.');
    Exit;
  end;

{  try
    Rewrite(f);
  except
    ShowMessage('Ошибка открытия файла.');
    Exit;
  end;}
  s:='Координата X ='+ GrafikX.Label13.Caption+',Координата Y ='
  + GrafikX.Label14.Caption;
  WriteLn(f,s);
  s:='StressMethod ='+inttostr(Oldmethod);
  WriteLn(f,s);
  s:='NRC,X-HAПPЯЖ,Y-HAПPЯЖ,KACAT-HAПPЯЖ,MAX-HAПP,MIN-HAПP,ЭКВ-НАПРЯЖ,'+
  'X-ПЕРЕМ,Y-ПЕРЕМ ';
  WriteLn(f,s);
  OldSeparator:= DecimalSeparator;
  DecimalSeparator:='.';
  for NrcMy:=3 to StrToInt(Form3.Edit1.Text) do // to StrToInt(GrafikX.Label15.Caption
  begin
    s := intTostr(NrcMy)+','+ FloatToStr(grafikX.Series1.YValues.Value[NrcMy-3])
    +','+FloatToStr(grafikY.Series1.YValues.Value[NrcMy-3])+','+
    FloatToStr(grafikXY.Series1.YValues.Value[NrcMy-3])+','+
    FloatToStr(grafikGL.Series1.YValues.Value[NrcMy-3])+','+
    FloatToStr(grafikGL2.Series1.YValues.Value[NrcMy-3])+','+
    FloatToStr(grafikUg.Series1.YValues.Value[NrcMy-3])+','+
    FloatToStr(grafikPerX.Series1.YValues.Value[NrcMy-3])+','+
    FloatToStr(grafikPerY.Series1.YValues.Value[NrcMy-3]);
    WriteLn(f,s);
  end;
  DecimalSeparator:=OldSeparator;
  CloseFile(f);
end;

procedure TForm3.N3Click(Sender: TObject);
var
  f: TextFile;
  SList: TStringList;
  s,param: String;
  frm: TfrmLoadPset;
  i,j,spos,NrcMy: integer;
  RezArray  : array[0..7] of real;
begin
  if not odOpen.Execute then Exit;
  try
    AssignFile(f, odOpen.FileName);
    Reset(f);
  except
    ShowMessage('Ошибка открытия файла.');
    Exit;
  end;
  sList := TStringList.Create;
  while not EOF(f) do
  begin
    ReadLn(f,s);
    if Pos('Координата',s) <> 0 then
      SList.Add(s);
  end;
  frm := TfrmLoadPset.Create(nil);
  if SList.Count = 0 then
    frm.BitBtn1.Enabled := False;
  with frm do
    for i := 0 to SList.Count - 1 do
      cbxList.AddItem(SList.Strings[i],nil);
  frm.cbxList.ItemIndex := 0;
  case frm.ShowModal of
  mrOK:
    begin
      s:=frm.cbxList.Text;  i:= pos('X =',s)+3;
//добавляем точки
      form9.Edit1.Text:=copy(s,i,pos(',',s)-i);
      form9.Edit2.Text:=copy(s,pos('Y =',s)+3,length(s)-pos('Y =',s)+3);
      form9.Button1Click(nil);
// Создаем формы
       GroupFormCreate(Sender);
//Считываем файл
      Reset(f);
      ReadLn(f,s);
      while not EOF(f)and(s<> frm.cbxList.Text) do
        ReadLn(f,s);
      ReadLn(f,s);
      Oldmethod:=strtoint(copy(s,Pos('=',s)+1,length(s)-Pos('=',s)+1));
      ReadLn(f,s);
      ReadLn(f,s);
      SList.Clear;
      SList.Add(s);
      while not EOF(f)and(Pos('Координата',s) = 0) do
      begin

        ReadLn(f,s);
        if (Pos('Координата',s) =0) then
        SList.Add(s);
      end;
//Заполянем NRC
      Form3.Edit1.Text:=inttostr(Slist.Count+2);

        for i:=0 to Slist.Count-1 do
          begin
          NrcMy:=i+3;
          s:=Slist.Strings[i];
          delete (s,1,Pos(',',s));
          for j:=0 to 6 do
             begin
             spos:=Pos(',',s);
             param := copy(s,1,spos-1);
             param[Pos('.',param)]:=',';
             RezArray[j]:=StrtoFloat(param);
             delete(s,1,spos);
             end;
             param := copy(s,1,spos-1);
             param[Pos('.',param)]:=',';
             RezArray[7]:=StrtoFloat(param);
             Form3.GrafikParam(NrcMy,RezArray);
          end;
          OldItem:=StrToInt(ComboBoxEx1.Text);
          SetGrafikParam();
          Button1.Enabled:=True;
          Button2.Enabled:=True;
          Button3.Enabled:=True;
          Button4.Enabled:=True;
          Button5.Enabled:=True;
          Button6.Enabled:=True;
          Button7.Enabled:=False;
          Button9.Enabled:=True;
          Button13.Enabled:=True;
          Button14.Enabled:=True;
    end;
  mrCancel:
    begin
      frm.Free;
      sList.Free;
      Exit;
    end;
  end;
  sList.Free;
    case Oldmethod of
    1: form3.StressMethod1.Checked:=True;
    2: form3.StressMethod2.Checked:=True;
    3: form3.StressMethod3.Checked:=True;
    end;
end;



procedure TForm3.SetGrafikParam();
begin
         GrafikX.Label13.Caption:=EditX.Text;
         GrafikX.Label14.Caption:=EditY.Text;
         //GrafikX.Label15.Caption:=Edit1.Text;
         GrafikX.Chart1.LeftAxis.Automatic := True;

         GrafikY.Label13.Caption:=EditX.Text;
         GrafikY.Label14.Caption:=EditY.Text;
         //GrafikY.Label15.Caption:=Edit1.Text;
         GrafikY.Chart1.LeftAxis.Automatic := True;

         GrafikXY.Label13.Caption:=EditX.Text;
         GrafikXY.Label14.Caption:=EditY.Text;
         //GrafikXY.Label15.Caption:=Edit1.Text;
         GrafikXY.Chart1.LeftAxis.Automatic := True;

         GrafikGL.Label13.Caption:=EditX.Text;
         GrafikGL.Label14.Caption:=EditY.Text;
         //GrafikGL.Label15.Caption:=Edit1.Text;
         GrafikGL.Chart1.LeftAxis.Automatic := True;

         GrafikGL2.Label13.Caption:=EditX.Text;
         GrafikGL2.Label14.Caption:=EditY.Text;
         //GrafikGL2.Label15.Caption:=Edit1.Text;
         GrafikGL2.Chart1.LeftAxis.Automatic := True;

         GrafikUg.Label13.Caption:=EditX.Text;
         GrafikUg.Label14.Caption:=EditY.Text;
         //GrafikUg.Label15.Caption:=Edit1.Text;
         GrafikUg.Chart1.LeftAxis.Automatic := True;

         GrafikPerX.Label13.Caption:=EditX.Text;
         GrafikPerX.Label14.Caption:=EditY.Text;
         //GrafikPerX.Label15.Caption:=Edit1.Text;
         GrafikPerX.Chart1.LeftAxis.Automatic := True;

         GrafikPerY.Label13.Caption:=EditX.Text;
         GrafikPerY.Label14.Caption:=EditY.Text;
         //GrafikPerY.Label15.Caption:=Edit1.Text;
         GrafikPerY.Chart1.LeftAxis.Automatic := True;


end;

procedure TForm3.GroupFormCreate(Sender: TObject);
begin
   GrafikX.Free;
   GrafikX := TGrafikX.Create(nil);
   GrafikY.Free;
   GrafikY := TGrafikY.Create(nil);
   GrafikXY.Free;
   GrafikXY := TGrafikXY.Create(nil);
   GrafikGl.Free;
   GrafikGl := TGrafikGl.Create(nil);
   GrafikGl2.Free;
   GrafikGl2 := TGrafikGl2.Create(nil);
   GrafikUG.Free;
   GrafikUG := TGrafikUG.Create(nil);
   GrafikPerX.Free;
   GrafikPerX := TGrafikPerX.Create(nil);
   GrafikPerY.Free;
   GrafikPerY := TGrafikPerY.Create(nil);
end;
procedure TForm3.FormActivate(Sender: TObject);
var
  Registry:TRegistry;
BEGIN
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
 IF Registry.OpenKeyReadOnly(STRINGReg) THEN FloatFormat:=Registry.ReadSTRING('FloatFormat');
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
Form3.Edit1.Text:=Form3.ComboBox1.Text;
end;

end.
