// Модуль "Построение графиков сходимости"
// Written by Shevchenko T. (comments: TSH) 25.02.2006
// Форма "Построение графиков в ЕСК"
// TSH -->
unit Unit11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Unit3,Unit4, OleCtnrs, Chart,Unit2, ExtCtrls, TeeProcs,
  TeEngine, Series;

type
  TForm11 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Ole: TOleContainer;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Chart2: TChart;
    LineSeries1: TLineSeries;
    LineSeries2: TLineSeries;
    LineSeries3: TLineSeries;
    LineSeries4: TLineSeries;
    LineSeries5: TLineSeries;
    LineSeries6: TLineSeries;
    Chart3: TChart;
    LineSeries7: TLineSeries;
    LineSeries8: TLineSeries;
    LineSeries9: TLineSeries;
    LineSeries10: TLineSeries;
    LineSeries11: TLineSeries;
    LineSeries12: TLineSeries;
    Chart4: TChart;
    LineSeries13: TLineSeries;
    LineSeries14: TLineSeries;
    LineSeries15: TLineSeries;
    LineSeries16: TLineSeries;
    LineSeries17: TLineSeries;
    LineSeries18: TLineSeries;
    Chart5: TChart;
    LineSeries19: TLineSeries;
    LineSeries20: TLineSeries;
    LineSeries21: TLineSeries;
    LineSeries22: TLineSeries;
    LineSeries23: TLineSeries;
    LineSeries24: TLineSeries;
    chart6: TChart;
    LineSeries25: TLineSeries;
    LineSeries26: TLineSeries;
    LineSeries27: TLineSeries;
    LineSeries28: TLineSeries;
    LineSeries29: TLineSeries;
    Series7: TLineSeries;
    Series8: TLineSeries;
    Series9: TLineSeries;
    Series10: TLineSeries;
    Series11: TLineSeries;
    ComboBox1: TComboBox;
    Label5: TLabel;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit11: TEdit;
    Edit12: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure Edit11KeyPress(Sender: TObject; var Key: Char);
    procedure Edit12KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit11Change(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    checkedpoints: array[1..5] of integer;
  end;

var
  Form11: TForm11;
  MinMax:array [0..1,0..1] of real;


implementation

uses Unit5, Unit6, Unit7, Unit8, ShowMovings,MainForm, unit12, unit13;


{$R *.dfm}

procedure TForm11.Button2Click(Sender: TObject);
begin
Form11.Close;
end;

procedure TForm11.Button1Click(Sender: TObject);
var   NrcMy:integer;
      n,k,i,count:integer;
      f,FfileName:string;
var TempForm: TShowMovingsForm;
var ole_doc, ole_r, ole_p, ole_s, ole_t, ole_tc, ole_c: Variant;
var maxY,minY,Temp:real;
var userLimits:array [0..1]of boolean;
var S:String;
checkn: integer;
begin
maxY:=-2E10;
minY:=2E10;
TempForm:=TshowMovingsForm.Create(nil);
//TempForm.FormCreate(sender);
F:=MainForm.ProjectFileName;
if FileExists(ChangeFileExt(F,'.res')) then
f:=ChangeFileExt(f,'.res');
FFilename:=f;
f:=ChangeFileExt(f,'.spr');
TempForm.LoadResults(FfileName);
  case checkmethod of
  1:TempForm.StressMethod1Click(sender);
  2:TempForm.StressMethod2Click(sender);
  3:TempForm.StressMethod3Click(sender);
  end;
TempForm.Free;

if RadioButton2.Checked then
begin
 for i:=0 to 1 do
  begin
  MinMax[i,0]:=0;
  MinMax[i,1]:=0;
  end;
end;

for i:=0 to 1 do
begin
   userLimits[i]:= True;
     if  ((MinMax[i,0]=0)and( MinMax[i,1]=0)) then
       begin
       userLimits[i]:= False;
       end
     else if ( MinMax[i,1]>MinMax[i,0]) then
       begin
       temp:=MinMax[i,0];
       MinMax[i,0]:=MinMax[i,1];
       MinMax[i,1]:=temp;
       end
end;
//Проверка количества выбранных точек
count:=0;
 for i:=1 to 5 do   if(checkedpoints[i] = 0 ) then count:=count+1;
 if(count > 3) then
  begin;
    MessageDlg('Количество используемых точек должно быть не менее 2.',mtError,[mbYes],0);
    exit;
  end;

//Проверка введенного максимального NRC
 if ( strtoint(Form3.Edit1.Text)>12)or(strtoint(Form3.Edit1.Text)<3) then
 begin
  //Form3.Label4.Visible:=true;
  Form3.Button7.Enabled:=false;
  Form11.Close;
  exit;
 end;

//Кнопки просмотра результатов в Form3 не активны

Form3.Button1.Enabled:=false;
Form3.Button2.Enabled:=false;
Form3.Button3.Enabled:=false;
Form3.Button4.Enabled:=false;
Form3.Button5.Enabled:=false;
Form3.Button6.Enabled:=false;
Form3.Button9.Enabled:=false;
Form3.Button13.Enabled:=false;
Form3.Button14.Enabled:=false;
//Очистка
grafikx.Series1.Clear;
grafikY.Series1.Clear;
grafikXY.Series1.Clear;
grafikGL.Series1.Clear;
grafikGL2.Series1.Clear;
grafikUg.Series1.Clear;
grafikPerX.Series1.Clear;
grafikPerY.Series1.Clear;
LineSeries1.clear;
LineSeries2.clear;
LineSeries3.clear;
LineSeries4.clear;
LineSeries5.clear;
LineSeries6.clear;
LineSeries7.clear;
LineSeries8.clear;
LineSeries9.clear;
LineSeries10.clear;
LineSeries11.clear;
LineSeries12.clear;
LineSeries13.clear;
LineSeries14.clear;
LineSeries15.clear;
LineSeries16.clear;
LineSeries17.clear;
LineSeries18.clear;
LineSeries19.clear;
LineSeries20.clear;
LineSeries21.clear;
LineSeries22.clear;
LineSeries23.clear;
LineSeries24.clear;
LineSeries25.clear;
LineSeries26.clear;
LineSeries27.clear;
LineSeries28.clear;
LineSeries29.clear;
Series7.clear;
Series8.clear;
Series9.clear;
Series10.clear;
Series11.clear;

//******************************** Первый график ***********
if(Checkbox1.Checked = true) then
begin;

 Form3.EditX.Text:=floattostr(Form3.SelectedPointsX[1]);
 Form3.EditY.Text:=floattostr(Form3.SelectedPointsY[1]);
 n:=130;
 for NrcMy:=3 to strtoint(Form3.Edit1.Text) do
  begin
   Application.ProcessMessages;
   Form3.Vichisl(Form3,NrcMy,n);
   Application.ProcessMessages;
  end;
{  Form3.Vichisl(Form3,NrcOld,n);
  Application.ProcessMessages;}

Series1.AssignValues(GrafikX.Chart1.Series[0]);
 if(maxY < Series1.MaxYValue) then maxY:=Series1.MaxYValue;
 if(minY > Series1.MinYValue) then minY:=Series1.MinYValue;
Series2.AssignValues(GrafikY.Chart1.Series[0]);
 if(maxY < Series2.MaxYValue) then maxY:=Series2.MaxYValue;
 if(minY > Series2.MinYValue) then minY:=Series2.MinYValue;
Series3.AssignValues(GrafikXY.Chart1.Series[0]);
 if(maxY < Series3.MaxYValue) then maxY:=Series3.MaxYValue;
 if(minY > Series3.MinYValue) then minY:=Series3.MinYValue;
Series4.AssignValues(GrafikGL.Chart1.Series[0]);
 if(maxY < Series4.MaxYValue) then maxY:=Series4.MaxYValue;
 if(minY > Series4.MinYValue) then minY:=Series4.MinYValue;
Series5.AssignValues(GrafikGL2.Chart1.Series[0]);
 if(maxY < Series5.MaxYValue) then maxY:=Series5.MaxYValue;
 if(minY > Series5.MinYValue) then minY:=Series5.MinYValue;
Series6.AssignValues(GrafikUg.Chart1.Series[0]);
 if(maxY < Series6.MaxYValue) then maxY:=Series6.MaxYValue;
 if(minY > Series6.MinYValue) then minY:=Series6.MinYValue;
LineSeries25.AssignValues(GrafikPerX.Chart1.Series[0]);
Series7.AssignValues(GrafikPerY.Chart1.Series[0]);

end;

grafikx.Series1.Clear;
grafikY.Series1.Clear;
grafikXY.Series1.Clear;
grafikGL.Series1.Clear;
grafikGL2.Series1.Clear;
grafikUg.Series1.Clear;
grafikPerX.Series1.Clear;
grafikPerY.Series1.Clear;

//******************************** Второй график ***********
if(Checkbox2.Checked = true) then
begin;

 Form3.EditX.Text:=floattostr(Form3.SelectedPointsX[2]);
 Form3.EditY.Text:=floattostr(Form3.SelectedPointsY[2]);
 n:=130;
 for NrcMy:=3 to strtoint(Form3.Edit1.Text) do
  begin
   Application.ProcessMessages;
   Form3.Vichisl(Form3,NrcMy,n);
   Application.ProcessMessages;
  end;
{ Form3.Vichisl(Form3,NrcOld,n);
 Application.ProcessMessages;}


LineSeries1.AssignValues(GrafikX.Chart1.Series[0]);
 if(maxY < LineSeries1.MaxYValue) then maxY:=LineSeries1.MaxYValue;
 if(minY > LineSeries1.MinYValue) then minY:=LineSeries1.MinYValue;
LineSeries2.AssignValues(GrafikY.Chart1.Series[0]);
 if(maxY < LineSeries2.MaxYValue) then maxY:=LineSeries2.MaxYValue;
 if(minY > LineSeries2.MinYValue) then minY:=LineSeries2.MinYValue;
LineSeries3.AssignValues(GrafikXY.Chart1.Series[0]);
 if(maxY < LineSeries3.MaxYValue) then maxY:=LineSeries3.MaxYValue;
 if(minY > LineSeries3.MinYValue) then minY:=LineSeries3.MinYValue;
LineSeries4.AssignValues(GrafikGL.Chart1.Series[0]);
 if(maxY < LineSeries4.MaxYValue) then maxY:=LineSeries4.MaxYValue;
 if(minY > LineSeries4.MinYValue) then minY:=LineSeries4.MinYValue;
LineSeries5.AssignValues(GrafikGL2.Chart1.Series[0]);
 if(maxY < LineSeries5.MaxYValue) then maxY:=LineSeries5.MaxYValue;
 if(minY > LineSeries5.MinYValue) then minY:=LineSeries5.MinYValue;
LineSeries6.AssignValues(GrafikUg.Chart1.Series[0]);
 if(maxY < LineSeries6.MaxYValue) then maxY:=LineSeries6.MaxYValue;
 if(minY > LineSeries6.MinYValue) then minY:=LineSeries6.MinYValue;
LineSeries26.AssignValues(GrafikPerX.Chart1.Series[0]);
Series8.AssignValues(GrafikPerY.Chart1.Series[0]);

end;

grafikx.Series1.Clear;
grafikY.Series1.Clear;
grafikXY.Series1.Clear;
grafikGL.Series1.Clear;
grafikGL2.Series1.Clear;
grafikUg.Series1.Clear;
grafikPerX.Series1.Clear;
grafikPerY.Series1.Clear;
//******************************** Третий график ***********
if(Checkbox3.Checked = true) then
begin;

 Form3.EditX.Text:=floattostr(Form3.SelectedPointsX[3]);
 Form3.EditY.Text:=floattostr(Form3.SelectedPointsY[3]);
 n:=130;
 for NrcMy:=3 to strtoint(Form3.Edit1.Text) do
  begin
   Application.ProcessMessages;
   Form3.Vichisl(Form3,NrcMy,n);
   Application.ProcessMessages;
  end;
{ Form3.Vichisl(Form3,NrcOld,n);
 Application.ProcessMessages;}


LineSeries7.AssignValues(GrafikX.Chart1.Series[0]);
 if(maxY < LineSeries7.MaxYValue) then maxY:=LineSeries7.MaxYValue;
 if(minY > LineSeries7.MinYValue) then minY:=LineSeries7.MinYValue;
LineSeries8.AssignValues(GrafikY.Chart1.Series[0]);
 if(maxY < LineSeries8.MaxYValue) then maxY:=LineSeries8.MaxYValue;
 if(minY > LineSeries8.MinYValue) then minY:=LineSeries8.MinYValue;
LineSeries9.AssignValues(GrafikXY.Chart1.Series[0]);
 if(maxY < LineSeries9.MaxYValue) then maxY:=LineSeries9.MaxYValue;
 if(minY > LineSeries9.MinYValue) then minY:=LineSeries9.MinYValue;
LineSeries10.AssignValues(GrafikGL.Chart1.Series[0]);
 if(maxY < LineSeries10.MaxYValue) then maxY:=LineSeries10.MaxYValue;
 if(minY > LineSeries10.MinYValue) then minY:=LineSeries10.MinYValue;
LineSeries11.AssignValues(GrafikGL2.Chart1.Series[0]);
 if(maxY < LineSeries11.MaxYValue) then maxY:=LineSeries11.MaxYValue;
 if(minY > LineSeries11.MinYValue) then minY:=LineSeries11.MinYValue;
LineSeries12.AssignValues(GrafikUg.Chart1.Series[0]);
 if(maxY < LineSeries12.MaxYValue) then maxY:=LineSeries12.MaxYValue;
 if(minY > LineSeries12.MinYValue) then minY:=LineSeries12.MinYValue;
LineSeries27.AssignValues(GrafikPerX.Chart1.Series[0]);
Series9.AssignValues(GrafikPerY.Chart1.Series[0]);

end;

grafikx.Series1.Clear;
grafikY.Series1.Clear;
grafikXY.Series1.Clear;
grafikGL.Series1.Clear;
grafikGL2.Series1.Clear;
grafikUg.Series1.Clear;
grafikPerX.Series1.Clear;
grafikPerY.Series1.Clear;
//******************************** Четвертый график ***********
if(Checkbox4.Checked = true) then
begin;

 Form3.EditX.Text:=floattostr(Form3.SelectedPointsX[4]);
 Form3.EditY.Text:=floattostr(Form3.SelectedPointsY[4]);
 n:=130;
 for NrcMy:=3 to strtoint(Form3.Edit1.Text) do
  begin
   Application.ProcessMessages;
   Form3.Vichisl(Form3,NrcMy,n);
   Application.ProcessMessages;
  end;
{ Form3.Vichisl(Form3,NrcOld,n);
 Application.ProcessMessages;}


LineSeries13.AssignValues(GrafikX.Chart1.Series[0]);
 if(maxY < LineSeries13.MaxYValue) then maxY:=LineSeries13.MaxYValue;
 if(minY > LineSeries13.MinYValue) then minY:=LineSeries13.MinYValue;
LineSeries14.AssignValues(GrafikY.Chart1.Series[0]);
 if(maxY < LineSeries14.MaxYValue) then maxY:=LineSeries14.MaxYValue;
 if(minY > LineSeries14.MinYValue) then minY:=LineSeries14.MinYValue;
LineSeries15.AssignValues(GrafikXY.Chart1.Series[0]);
 if(maxY < LineSeries15.MaxYValue) then maxY:=LineSeries15.MaxYValue;
 if(minY > LineSeries15.MinYValue) then minY:=LineSeries15.MinYValue;
LineSeries16.AssignValues(GrafikGL.Chart1.Series[0]);
 if(maxY < LineSeries16.MaxYValue) then maxY:=LineSeries16.MaxYValue;
 if(minY > LineSeries16.MinYValue) then minY:=LineSeries16.MinYValue;
LineSeries17.AssignValues(GrafikGL2.Chart1.Series[0]);
 if(maxY < LineSeries17.MaxYValue) then maxY:=LineSeries17.MaxYValue;
 if(minY > LineSeries17.MinYValue) then minY:=LineSeries17.MinYValue;
LineSeries18.AssignValues(GrafikUg.Chart1.Series[0]);
 if(maxY < LineSeries18.MaxYValue) then maxY:=LineSeries18.MaxYValue;
 if(minY > LineSeries18.MinYValue) then minY:=LineSeries18.MinYValue;
LineSeries28.AssignValues(GrafikPerX.Chart1.Series[0]);
Series10.AssignValues(GrafikPerY.Chart1.Series[0]);
end;

grafikx.Series1.Clear;
grafikY.Series1.Clear;
grafikXY.Series1.Clear;
grafikGL.Series1.Clear;
grafikGL2.Series1.Clear;
grafikUg.Series1.Clear;
grafikPerX.Series1.Clear;
grafikPerY.Series1.Clear;
//******************************** Пятый график ***********
if(Checkbox5.Checked = true) then
begin;

 Form3.EditX.Text:=floattostr(Form3.SelectedPointsX[5]);
 Form3.EditY.Text:=floattostr(Form3.SelectedPointsY[5]);
 n:=130;
 for NrcMy:=3 to strtoint(Form3.Edit1.Text) do
  begin
   Application.ProcessMessages;
   Form3.Vichisl(Form3,NrcMy,n);
   Application.ProcessMessages;
  end;
{ Form3.Vichisl(Form3,NrcOld,n);
 Application.ProcessMessages;}


LineSeries19.AssignValues(GrafikX.Chart1.Series[0]);
 if(maxY < LineSeries19.MaxYValue) then maxY:=LineSeries19.MaxYValue;
 if(minY > LineSeries19.MinYValue) then minY:=LineSeries19.MinYValue;
LineSeries20.AssignValues(GrafikY.Chart1.Series[0]);
 if(maxY < LineSeries20.MaxYValue) then maxY:=LineSeries20.MaxYValue;
 if(minY > LineSeries20.MinYValue) then minY:=LineSeries20.MinYValue;
LineSeries21.AssignValues(GrafikXY.Chart1.Series[0]);
 if(maxY < LineSeries21.MaxYValue) then maxY:=LineSeries21.MaxYValue;
 if(minY > LineSeries21.MinYValue) then minY:=LineSeries21.MinYValue;
LineSeries22.AssignValues(GrafikGL.Chart1.Series[0]);
 if(maxY < LineSeries22.MaxYValue) then maxY:=LineSeries22.MaxYValue;
 if(minY > LineSeries22.MinYValue) then minY:=LineSeries22.MinYValue;
LineSeries23.AssignValues(GrafikGL2.Chart1.Series[0]);
 if(maxY < LineSeries23.MaxYValue) then maxY:=LineSeries23.MaxYValue;
 if(minY > LineSeries23.MinYValue) then minY:=LineSeries23.MinYValue;
LineSeries24.AssignValues(GrafikUg.Chart1.Series[0]);
 if(maxY < LineSeries24.MaxYValue) then maxY:=LineSeries24.MaxYValue;
 if(minY > LineSeries24.MinYValue) then minY:=LineSeries24.MinYValue;
LineSeries29.AssignValues(GrafikPerX.Chart1.Series[0]);
Series11.AssignValues(GrafikPerY.Chart1.Series[0]);
end;

ole.CreateObject('word.application', true);
ole.OleObject.documents.Add;
ole_doc := ole.OleObject.ActiveDocument;
ole_r := ole_doc.Content;
ole_r.Select;

// Формирование таблицы обозначений напряжений
ole_t:=ole_doc.Tables.Add(ole_r,7,2);
ole_tc:=ole_t.Columns.Item(1);
ole_tc.Width:=200;
ole_tc:=ole_t.Columns.Item(2);
ole_tc.Width:=100;

    ole_c:=ole_t.Cell(1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Вид напряжения');

    ole_c:=ole_t.Cell(1,2);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Цвет');

    ole_c:=ole_t.Cell(2,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Напряжение по Х');

    ole_c:=ole_t.Cell(2,2);
    ole_c.Shading.BackgroundPatternColor:=clRed;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Красный');

    ole_c:=ole_t.Cell(3,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Напряжение по Y');

    ole_c:=ole_t.Cell(3,2);
    ole_c.Shading.BackgroundPatternColor:=clGreen;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Зеленый');

    ole_c:=ole_t.Cell(4,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Касательное напряжение');

    ole_c:=ole_t.Cell(4,2);
    ole_c.Shading.BackgroundPatternColor:=clYellow;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clBlack;
    ole_s.TypeText('Желтый');

    ole_c:=ole_t.Cell(5,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('1-ое главное напряжение');

    ole_c:=ole_t.Cell(5,2);
    ole_c.Shading.BackgroundPatternColor:=clBlue;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Синий');

    ole_c:=ole_t.Cell(6,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('2-ое главное напряжение');

    ole_c:=ole_t.Cell(6,2);
    ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clBlack;
    ole_s.TypeText('Белый');

    ole_c:=ole_t.Cell(7,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Эквивалентное напряжение');

    ole_c:=ole_t.Cell(7,2);
    ole_c.Shading.BackgroundPatternColor:=clGray;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Серый');

 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;

if(Checkbox1.Checked = true) then
begin;
  if (UserLimits[0]=True)and(MinMax[0,1]<0) then
    begin
    chart1.LeftAxis.Automatic:=False;
    Chart1.LeftAxis.Minimum:=MinMax[0,1];
    Chart1.LeftAxis.Maximum:=MinMax[0,0];
  end
  else if (UserLimits[0]=True) then
    begin
    chart1.LeftAxis.Automatic:=False;
    Chart1.LeftAxis.Maximum:=MinMax[0,0];
    Chart1.LeftAxis.Minimum:=MinMax[0,1];
  end
  else
    begin
      if minY<0 then
       begin
       chart1.LeftAxis.Automatic:=False;
       Chart1.LeftAxis.Minimum:=minY;
       Chart1.LeftAxis.Maximum:=maxY;
       end
      else
       begin
       chart1.LeftAxis.Automatic:=False;
       Chart1.LeftAxis.Maximum:=maxY;
       Chart1.LeftAxis.Minimum:=minY;
       end ;
  end;
 Chart1.CopyToClipboardBitmap;
 ole_s:=ole_doc.application.Selection;
 S:='X = ' + floattostr(Form3.SelectedPointsX[1]) + '    Y = ' + floattostr(Form3.SelectedPointsY[1]);
 ole_s.TypeText(S);
 ole_r := ole_doc.Content;
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
 ole_r.Paste;
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
end;

if(Checkbox2.Checked = true) then
begin;
  if (UserLimits[0]=True)and(MinMax[0,1]<0) then
    begin
    chart2.LeftAxis.Automatic:=False;
    Chart2.LeftAxis.Minimum:=MinMax[0,1];
    Chart2.LeftAxis.Maximum:=MinMax[0,0];
  end
  else if (UserLimits[0]=True) then
    begin
    chart2.LeftAxis.Automatic:=False;
    Chart2.LeftAxis.Maximum:=MinMax[0,0];
    Chart2.LeftAxis.Minimum:=MinMax[0,1];
  end
  else
    begin
      if minY<0 then
       begin
       chart2.LeftAxis.Automatic:=False;
       Chart2.LeftAxis.Minimum:=minY;
       Chart2.LeftAxis.Maximum:=maxY;
       end
      else
       begin
       chart2.LeftAxis.Automatic:=False;
       Chart2.LeftAxis.Maximum:=maxY;
       Chart2.LeftAxis.Minimum:=minY;
       end ;
  end;
 Chart2.CopyToClipboardBitmap;
 ole_s:=ole_doc.application.Selection;
 S:='X = ' + floattostr(Form3.SelectedPointsX[2]) + '    Y = ' + floattostr(Form3.SelectedPointsY[2]);
 ole_s.TypeText(S);
 ole_r := ole_doc.Content;
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
 ole_r.Paste;
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
end;

if(Checkbox3.Checked = true) then
begin;
  if (UserLimits[0]=True)and(MinMax[0,1]<0) then
    begin
    chart3.LeftAxis.Automatic:=False;
    Chart3.LeftAxis.Minimum:=MinMax[0,1];
    Chart3.LeftAxis.Maximum:=MinMax[0,0];
  end
  else if (UserLimits[0]=True) then
    begin
    chart3.LeftAxis.Automatic:=False;
    Chart3.LeftAxis.Maximum:=MinMax[0,0];
    Chart3.LeftAxis.Minimum:=MinMax[0,1];
  end
  else
    begin
      if minY<0 then
       begin
       chart3.LeftAxis.Automatic:=False;
       Chart3.LeftAxis.Minimum:=minY;
       Chart3.LeftAxis.Maximum:=maxY;
       end
      else
       begin
       chart3.LeftAxis.Automatic:=False;
       Chart3.LeftAxis.Maximum:=maxY;
       Chart3.LeftAxis.Minimum:=minY;
       end ;
  end;
 Chart3.CopyToClipboardBitmap;
 ole_s:=ole_doc.application.Selection;
 S:='X = ' + floattostr(Form3.SelectedPointsX[3]) + '    Y = ' + floattostr(Form3.SelectedPointsY[3]);
 ole_s.TypeText(S);
 ole_r := ole_doc.Content;
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
 ole_r.Paste;
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
end;

if(Checkbox4.Checked = true) then
begin;
  if (UserLimits[0]=True)and(MinMax[0,1]<0) then
    begin
    chart4.LeftAxis.Automatic:=False;
    Chart4.LeftAxis.Minimum:=MinMax[0,1];
    Chart4.LeftAxis.Maximum:=MinMax[0,0];
  end
  else if (UserLimits[0]=True) then
    begin
    chart4.LeftAxis.Automatic:=False;
    Chart4.LeftAxis.Maximum:=MinMax[0,0];
    Chart4.LeftAxis.Minimum:=MinMax[0,1];
  end
  else
    begin
      if minY<0 then
       begin
       chart4.LeftAxis.Automatic:=False;
       Chart4.LeftAxis.Minimum:=minY;
       Chart4.LeftAxis.Maximum:=maxY;
       end
      else
       begin
       chart4.LeftAxis.Automatic:=False;
       Chart4.LeftAxis.Maximum:=maxY;
       Chart4.LeftAxis.Minimum:=minY;
       end;
  end;
 Chart4.CopyToClipboardBitmap;
 ole_s:=ole_doc.application.Selection;
 S:='X = ' + floattostr(Form3.SelectedPointsX[4]) + '    Y = ' + floattostr(Form3.SelectedPointsY[4]);
 ole_s.TypeText(S);
 ole_r := ole_doc.Content;
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
 ole_r.Paste;
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
end;

if(Checkbox5.Checked = true) then
begin
  if (UserLimits[0]=True)and(MinMax[0,1]<0) then
    begin
    chart5.LeftAxis.Automatic:=False;
    Chart5.LeftAxis.Minimum:=MinMax[0,1];
    Chart5.LeftAxis.Maximum:=MinMax[0,0];
  end
  else if (UserLimits[0]=True) then
    begin
    chart5.LeftAxis.Automatic:=False;
    Chart5.LeftAxis.Maximum:=MinMax[0,0];
    Chart5.LeftAxis.Minimum:=MinMax[0,1];
  end
  else
    begin
      if minY<0 then
       begin
       chart5.LeftAxis.Automatic:=False;
       Chart5.LeftAxis.Minimum:=minY;
       Chart5.LeftAxis.Maximum:=maxY;
       end
      else
       begin
       chart5.LeftAxis.Automatic:=False;
       Chart5.LeftAxis.Maximum:=maxY;
       Chart5.LeftAxis.Minimum:=minY;
       end;
  end;
 Chart5.CopyToClipboardBitmap;
 ole_s:=ole_doc.application.Selection;
 S:='X = ' + floattostr(Form3.SelectedPointsX[5]) + '    Y = ' + floattostr(Form3.SelectedPointsY[5]);
 ole_s.TypeText(S);
 ole_r := ole_doc.Content;
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
 ole_r.Paste;
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
end;

 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;
 
// Формирование таблицы перемещений
checkn := 0;
if checkBox1.Checked then Inc(checkn);
if checkBox2.Checked then Inc(checkn);
if checkBox3.Checked then Inc(checkn);
if checkBox4.Checked then Inc(checkn);
if checkBox5.Checked then Inc(checkn);


ole_t:=ole_doc.Tables.Add(ole_r,checkn*2 + 1,2);
ole_tc:=ole_t.Columns.Item(1);
ole_tc.Width:=300;
ole_tc:=ole_t.Columns.Item(2);
ole_tc.Width:=100;

    ole_c:=ole_t.Cell(1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Вид перемещения');

    ole_c:=ole_t.Cell(1,2);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Цвет');

checkn := 2;
if(Checkbox1.Checked = true) then
begin
    ole_c:=ole_t.Cell(checkn,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Х, точка №1 (X = '+
      floattostr(Form3.SelectedPointsX[1])+';  Y= '+
      floattostr(Form3.SelectedPointsY[1])+' )');

    ole_c:=ole_t.Cell(checkn,2);
    ole_c.Shading.BackgroundPatternColor:=clRed;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Красный');

    ole_c:=ole_t.Cell(checkn+1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Y, точка №1 (X = '+
      floattostr(Form3.SelectedPointsX[1])+';  Y= '+
      floattostr(Form3.SelectedPointsY[1])+' )');

    ole_c:=ole_t.Cell(checkn+1,2);
    ole_c.Shading.BackgroundPatternColor:=clGray;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Серый');
    Inc(checkn,2);
end;

if(Checkbox2.Checked = true) then
begin
    ole_c:=ole_t.Cell(checkn,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Х, точка №2 (X = '+
      floattostr(Form3.SelectedPointsX[2])+';  Y= '+
      floattostr(Form3.SelectedPointsY[2])+' )');

    ole_c:=ole_t.Cell(checkn,2);
    ole_c.Shading.BackgroundPatternColor:=clGreen;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Зелёный');

    ole_c:=ole_t.Cell(checkn+1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Y, точка №2 (X = '+
      floattostr(Form3.SelectedPointsX[2])+';  Y= '+
      floattostr(Form3.SelectedPointsY[2])+' )');

    ole_c:=ole_t.Cell(checkn+1,2);
    ole_c.Shading.BackgroundPatternColor:=clFuchsia;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Фиолетовый');
    Inc(checkn,2)
end;

if(Checkbox3.Checked = true) then
begin
    ole_c:=ole_t.Cell(checkn,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Х, точка №3 (X = '+
      floattostr(Form3.SelectedPointsX[3])+';  Y= '+
      floattostr(Form3.SelectedPointsY[3])+' )');

    ole_c:=ole_t.Cell(checkn,2);
    ole_c.Shading.BackgroundPatternColor:=clYellow;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clBlack;
    ole_s.TypeText('Желтый');

    ole_c:=ole_t.Cell(checkn+1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Y, точка №3 (X = '+
      floattostr(Form3.SelectedPointsX[3])+';  Y= '+
      floattostr(Form3.SelectedPointsY[3])+' )');

    ole_c:=ole_t.Cell(checkn+1,2);
    ole_c.Shading.BackgroundPatternColor:=clAqua;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clBlack;
    ole_s.TypeText('Голубой');
  Inc(checkn,2);
end;

if(Checkbox4.Checked = true) then
begin
    ole_c:=ole_t.Cell(checkn,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Х, точка №4 (X = '+
      floattostr(Form3.SelectedPointsX[4])+';  Y= '+
      floattostr(Form3.SelectedPointsY[4])+' )');

    ole_c:=ole_t.Cell(checkn,2);
    ole_c.Shading.BackgroundPatternColor:=clBlue;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Синий');

    ole_c:=ole_t.Cell(checkn+1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Y, точка №4 (X = '+
      floattostr(Form3.SelectedPointsX[4])+';  Y= '+
      floattostr(Form3.SelectedPointsY[4])+' )');

    ole_c:=ole_t.Cell(checkn+1,2);
    ole_c.Shading.BackgroundPatternColor:=clNavy;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clWhite;
    ole_s.TypeText('Темно-синий');
  Inc(checkn,2);
end;

if(Checkbox5.Checked = true) then
begin
    ole_c:=ole_t.Cell(checkn,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Х, точка №5 (X = '+
      floattostr(Form3.SelectedPointsX[5])+';  Y= '+
      floattostr(Form3.SelectedPointsY[5])+' )');

    ole_c:=ole_t.Cell(checkn,2);
    ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clBlack;
    ole_s.TypeText('Белый');

    ole_c:=ole_t.Cell(checkn+1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('Перемещение по Y, точка №5 (X = '+
      floattostr(Form3.SelectedPointsX[5])+';  Y= '+
      floattostr(Form3.SelectedPointsY[5])+' )');

    ole_c:=ole_t.Cell(checkn+1,2);
    ole_c.Shading.BackgroundPatternColor:=clLime;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.Font.Color := clBlack;
    ole_s.TypeText('Светло-зеленый');
end;

 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_s:=ole_doc.application.Selection;
 ole_r := ole_doc.Content;
 ole_r.Collapse(0);
 ole_r.Paragraphs.Add(ole_r);
 ole_r.Collapse(0);
 ole_r.Select;

 if (UserLimits[1]=True)and(MinMax[1,1]<0) then
  begin
  chart6.LeftAxis.Automatic:=False;
  Chart6.LeftAxis.Minimum:=MinMax[1,1];
  Chart6.LeftAxis.Maximum:=MinMax[1,0];
  end
  else if (UserLimits[1]=True)and(MinMax[1,1]>0) then
  begin
  chart6.LeftAxis.Automatic:=False;
  Chart6.LeftAxis.Maximum:=MinMax[1,0];
  Chart6.LeftAxis.Minimum:=MinMax[1,1];
  end ;

 chart6.CopyToClipboardBitmap;
 ole_r.Paste;



ole_doc.Application.Visible := True;
Form11.Close;

end;

procedure TForm11.CheckBox1Click(Sender: TObject);
begin
if(CheckBox1.Checked = true) then checkedpoints[1]:=1
else checkedpoints[1]:=0;

end;

procedure TForm11.CheckBox2Click(Sender: TObject);
begin
if(CheckBox2.Checked = true) then checkedpoints[2]:=1
else checkedpoints[2]:=0;

end;

procedure TForm11.CheckBox3Click(Sender: TObject);
begin
if(CheckBox3.Checked = true) then checkedpoints[3]:=1
else checkedpoints[3]:=0;

end;

procedure TForm11.CheckBox4Click(Sender: TObject);
begin
if(CheckBox4.Checked = true) then checkedpoints[4]:=1
else checkedpoints[4]:=0;

end;

procedure TForm11.CheckBox5Click(Sender: TObject);
begin
if(CheckBox5.Checked = true) then checkedpoints[5]:=1
else checkedpoints[5]:=0;

end;
// TSH --<
procedure TForm11.Edit11KeyPress(Sender: TObject; var Key: Char);
begin
if not (((Ord(Key)>=44)and(Ord(Key)<58))or(Ord(Key)=8)) then
    begin
      Beep;
      Key:=#0;
    end;
end;

procedure TForm11.Edit12KeyPress(Sender: TObject; var Key: Char);
begin
if not (((Ord(Key)>=44)and(Ord(Key)<58))or(Ord(Key)=8)) then
    begin
      Beep;
      Key:=#0;
    end;
end;

procedure TForm11.ComboBox1Change(Sender: TObject);
begin
    Edit11.Text:= FloatToStr(MinMax[ComboBox1.ItemIndex, 0]) ;
    Edit12.Text:= FloatToStr(MinMax[ComboBox1.ItemIndex, 1]) ;
end;

procedure TForm11.Edit11Change(Sender: TObject);
begin
try
    MinMax[ComboBox1.ItemIndex, 0] := StrToFloat(Edit11.Text);
  except
  end;
end;

procedure TForm11.Edit12Change(Sender: TObject);
begin
try
    MinMax[ComboBox1.ItemIndex, 1] := StrToFloat(Edit12.Text);
  except
  end;
end;

procedure TForm11.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
 for i:=0 to 1 do
 begin
 MinMax[i,0]:=0;
 MinMax[i,1]:=0;
 end;
end;

procedure TForm11.RadioButton1Click(Sender: TObject);
begin
  Edit11.Enabled:=RadioButton1.Checked;
  Edit12.Enabled:=RadioButton1.Checked;
end;


end.
