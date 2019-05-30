// ������ "���������� �������� ����������"
// Written by Shevchenko T. (comments: TSH) 25.02.2006
unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ExtCtrls,ImgList, ToolWin,MainForm,Grids,
  TeEngine, Series, TeeProcs, Chart, OleCtnrs,Math;

type
  TGrafikX = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Button2: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Button1: TButton;
    Ole: TOleContainer;
    Button4: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Button3: TButton;
    Label20: TLabel;
    GroupBox6: TGroupBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    Label12: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label15: TLabel;
    Series3: TLineSeries;
    CheckBox11: TCheckBox;
    Series4: TLineSeries;
    Label18: TLabel;
    CheckBox12: TCheckBox;
    Series5: TLineSeries;
    Label19: TLabel;
    Series6: TLineSeries;
    CheckBox13: TCheckBox;
    Label21: TLabel;
    procedure  Ochistka(Sender:TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure  Naris(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure RadioButton6Click(Sender: TObject);
//Dobavil Serafim Meleshko(4 stroki)
    procedure Label12Open(Sender: TObject);
    procedure Inter(Sender: TObject);
    procedure Inter2(Sender: TObject);
    procedure Inter3(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GrafikX: TGrafikX;
//TSH -->
  pointsX: array[1..10] of integer;
//TSH --<

implementation
Uses strfunc, MainInterface,ResultsArrays, TSigmaForm,ShowMovings,
  WaitForm, Unit3;
{$R *.dfm}
// log;
  //������������ ���������� �������� ���������� � �����


procedure TGrafikX.Button1Click(Sender: TObject);
begin
        GrafikX.Close;
end;

procedure TGrafikX.Ochistka(Sender:TObject);
var i:integer;
begin
        Edit3.Visible:=false;
        Edit4.Visible:=false;
        Edit5.Visible:=false;
        Edit6.Visible:=false;
        Edit7.Visible:=false;
        Edit8.Visible:=false;
        Edit9.Visible:=false;
        Edit10.Visible:=false;
        edit11.Visible:=false;
        edit12.Visible:=false;
        Label4.Visible:=False;
        Label5.Visible:=False;
        Label6.Visible:=False;
        Label7.Visible:=False;
        Label8.Visible:=False;
        Label9.Visible:=False;
        Label10.Visible:=False;
        Label11.Visible:=False;
        label16.Visible:=false;
        label17.Visible:=false;
//TSH -->
    CheckBox1.Visible:=false;
    CheckBox2.Visible:=false;
    CheckBox3.Visible:=false;
    CheckBox4.Visible:=false;
    CheckBox5.Visible:=false;
    CheckBox6.Visible:=false;
    CheckBox7.Visible:=false;
    CheckBox8.Visible:=false;
    CheckBox9.Visible:=false;
    CheckBox10.Visible:=false;

    for  i:=1 to 10 do begin
      pointsX[i] := 0;
    end;

    for  i:=1 to strtoint(Form3.Edit1.Text)-2 do begin
      pointsX[i] := 1;
    end;

//TSH --<
        Edit1.Text:='';
        Edit2.Text:='';
end;

procedure TGrafikX.Naris(Sender: TObject);
//TSH -->
var MyNrc :integer;
  begin
     Series1.Clear;
     Series2.Clear;
//Dobavil Serafim Meleshko(7 strok)
     Series3.Clear;
     Series4.Clear;
     Series5.Clear;
     Series6.Clear;
     Label18.Visible:=false;
     Label19.Visible:=false;
     Label21.Visible:=false;
        for  MyNrc:=3 to strtoint(Form3.Edit1.Text) do
        begin
        Case MyNrc of
      3: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit3.Text));
          if CheckBox1.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit3.Text));
             pointsX[1]:=1;
           end
          else pointsX[1]:=0;;
         end;
      4: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit4.Text));
          if CheckBox2.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit4.Text));
             pointsX[2]:=1;
           end
          else pointsX[2]:=0;
         end;
      5: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit5.Text));
          if CheckBox3.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit5.Text));
             pointsX[3]:=1;
           end
          else pointsX[3]:=0;
         end;
      6: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit6.Text));
          if CheckBox4.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit6.Text));
             pointsX[4]:=1;
           end
          else pointsX[4]:=0;
         end;
      7: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit7.Text));
          if CheckBox5.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit7.Text));
             pointsX[5]:=1;
           end
          else pointsX[5]:=0;
         end;
      8: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit8.Text));
          if CheckBox6.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit8.Text));
             pointsX[6]:=1;
           end
          else pointsX[6]:=0;
         end;
      9: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit9.Text));
          if CheckBox7.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit9.Text));
             pointsX[7]:=1;
           end
          else pointsX[7]:=0;
         end;
     10: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit10.Text));
          if CheckBox8.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit10.Text));
             pointsX[8]:=1;
           end
          else pointsX[8]:=0;
         end;
     11: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit11.Text));
          if CheckBox9.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit11.Text));
             pointsX[9]:=1;
           end
          else pointsX[9]:=0;
         end;
     12: begin;
          Series2.AddXY(MyNrc,strtofloat(Edit12.Text));
          if CheckBox10.Checked=true then
           begin;
             Series1.AddXY(MyNrc,strtofloat(Edit12.Text));
             pointsX[10]:=1;
           end
          else pointsX[10]:=0;
            end;
         end;
            end;
end;

procedure TGrafikX.Button2Click(Sender: TObject);
 var  N:integer;
begin
         N:=strtoint(Form3.Edit1.Text);
       case N of
       3: begin
            if    Edit3.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
            if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
       4:  begin
            if    Edit4.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
            if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
       5:  begin
            if    Edit5.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
           if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
       6:  begin
            if    Edit6.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
            if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
       7: begin
            if    Edit7.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
           if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;

       8:  begin
            if    Edit8.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
            if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
       9:   begin
            if    Edit9.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
          if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
       10:  begin
            if    Edit10.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
          if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
       11:   begin
            if    Edit11.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
           if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
        12:   begin
            if    Edit12.Text='' then exit;
//            else
//Dobavil Serafim Meleshko(konstrukciya "if")
           if CheckBox11.Checked=true then
            Inter(Sender)
            else
            if  CheckBox12.Checked=true then
            Inter2(Sender)
            else
            if  CheckBox13.Checked=true then
            Inter3(Sender)
            else
              Naris(Sender);
          end;
             else exit;
                end;
end;

// TSH -->
procedure TgrafikX.Button3Click(Sender:Tobject);
begin
        if  (Edit1.Text='') or (Edit2.Text='') then
        begin

         exit;
        end;
        if strtofloat(Edit1.Text) > strtofloat(Edit2.Text) then
        begin
             chart1.LeftAxis.Automatic:=False;
             Chart1.LeftAxis.Maximum:=Chart1.LeftAxis.Minimum;

             if Chart1.LeftAxis.Maximum < strtofloat(Edit2.Text) then
             begin
                Chart1.LeftAxis.Maximum := strtofloat(Edit2.Text)
             end;
             Chart1.LeftAxis.Minimum:=strtofloat(Edit2.Text);
             Chart1.LeftAxis.Maximum:=strtofloat(Edit1.Text);
        end
        else
        begin
           MessageDlg('�������� �������� ������� �� ����� ���� ������ �������� ������� �������!',mtError,[mbYes],0);
           exit;
        end;
end;
// TSH --<

procedure TGrafikX.Button4Click(Sender: TObject);
//TSH -->
var ole_doc, ole_r,ole_r1, ole_p, ole_s, ole_t, ole_tc, ole_c: Variant;
    N, i, nrc,count,checknrc,j: integer;
    S: String;
begin
N:=strtoint(Form3.Edit1.Text);
count:=0;
for  i:=1 to 10 do begin
  if(pointsX[i] = 1) then count:=count+1;
end;
if(count<3) then
begin;
MessageDlg('���������� ������������ ����� ������ ���� �� ����� 3.',mtError,[mbYes],0);
exit;
end;

     TRY

ole.CreateObject('word.application', true);
ole.OleObject.documents.Add;
ole_doc := ole.OleObject.ActiveDocument;

ole_r := ole_doc.Content;
Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
    ole_r := ole_doc.Content;
    ole_r.Collapse(0);
    ole_r.Select;
    ole_s:=ole_doc.application.Selection;
    S:='X = ' + Label13.Caption + '    Y = ' + Label14.Caption;
    ole_s.TypeText(S);
    ole_r := ole_doc.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
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
    ole_s.TypeText('���������� �� X');

    checknrc:=3;
    j:=1;

for i:=1 to N-2 do begin
    ole_c:=ole_t.Cell(i+1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    nrc:=i+2;
    Str(nrc,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,2);
    if PointsX[i] = 0 then ole_c.Shading.BackgroundPatternColor:=clLTGray
    else ole_c.Shading.BackgroundPatternColor:=clWhite;
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    Str(Series2.YValues.Value[i-1]:15:MantissStress,S);
    ole_s.TypeText(S);

end;

ole_doc.Application.Visible := True;

     EXCEPT
           MessageDlg('������ ��� ������� �������� ���������� � MS Word.',mtError,[mbYes],0);
     END;
//TSH --<

end;

// TSH -->
procedure TGrafikX.Button5Click(Sender: TObject);
begin
   chart1.LeftAxis.Automatic:=true;
   Edit1.Clear;
   Edit2.Clear;
end;
// TSH --<

procedure TGrafikX.RadioButton4Click(Sender: TObject);
begin
CheckBox1.Checked:=True;
CheckBox2.Checked:=True;
CheckBox3.Checked:=True;
CheckBox4.Checked:=True;
CheckBox5.Checked:=True;
CheckBox6.Checked:=True;
CheckBox7.Checked:=True;
CheckBox8.Checked:=True;
CheckBox9.Checked:=True;
CheckBox10.Checked:=True;
end;

procedure TGrafikX.RadioButton5Click(Sender: TObject);
begin
CheckBox1.Checked:=False;
CheckBox3.Checked:=False;
CheckBox5.Checked:=False;
CheckBox7.Checked:=False;
CheckBox9.Checked:=False;
CheckBox2.Checked:=True;
CheckBox4.Checked:=True;
CheckBox6.Checked:=True;
CheckBox8.Checked:=True;
CheckBox10.Checked:=True;
end;

procedure TGrafikX.RadioButton6Click(Sender: TObject);
begin
CheckBox1.Checked:=True;
CheckBox3.Checked:=True;
CheckBox5.Checked:=True;
CheckBox7.Checked:=True;
CheckBox9.Checked:=True;
CheckBox2.Checked:=False;
CheckBox4.Checked:=False;
CheckBox6.Checked:=False;
CheckBox8.Checked:=False;
CheckBox10.Checked:=False;
end;

//Dobavil Serafim Meleshko(1 procedura)
procedure TGrafikX.Label12Open(Sender: TObject);
begin
   Label12.Caption:='������: ' +Unit2GetProjectName;
end;

//Dobavil Serafim Meleshko(1 procedura)
procedure TGrafikX.Inter(Sender: TObject);
//TSH -->
var MyNrc :integer;
  begin
     Series1.Clear;
//     Series2.Clear;   //Proverka
     Series3.Clear;
     Series4.Clear;
     Series5.Clear;
     Series6.Clear;
     Label18.Visible:=true;
     Label19.Visible:=false;
     Label21.Visible:=false;
        for  MyNrc:=3 to strtoint(Form3.Edit1.Text) do
        begin
        Case MyNrc of
      3: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit3.Text));
          if CheckBox1.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit3.Text));
             pointsX[1]:=1;
           end
          else pointsX[1]:=0;
         end;
      4: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit4.Text));
          if CheckBox2.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit4.Text));
             pointsX[2]:=1;
           end
          else pointsX[2]:=0;
         end;
      5: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit5.Text));
          if CheckBox3.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit5.Text));
             pointsX[3]:=1;
           end
          else pointsX[3]:=0;
         end;
      6: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit6.Text));
          if CheckBox4.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit6.Text));
             pointsX[4]:=1;
           end
          else pointsX[4]:=0;
         end;
      7: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit7.Text));
          if CheckBox5.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit7.Text));
             pointsX[5]:=1;
           end
          else pointsX[5]:=0;
         end;
      8: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit8.Text));
          if CheckBox6.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit8.Text));
             pointsX[6]:=1;
           end
          else pointsX[6]:=0;
         end;
      9: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit9.Text));
          if CheckBox7.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit9.Text));
             pointsX[7]:=1;
           end
          else pointsX[7]:=0;
         end;
     10: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit10.Text));
          if CheckBox8.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit10.Text));
             pointsX[8]:=1;
           end
          else pointsX[8]:=0;
         end;
     11: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit11.Text));
          if CheckBox9.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit11.Text));
             pointsX[9]:=1;
           end
          else pointsX[9]:=0;
         end;
     12: begin;
          Series4.AddXY(MyNrc,strtofloat(Edit12.Text));
          if CheckBox10.Checked=true then
           begin;
             Series3.AddXY(MyNrc,strtofloat(Edit12.Text));
             pointsX[10]:=1;
           end
          else pointsX[10]:=0;
            end;
         end;
            end;
end;


//Dobavil Serafim Meleshko(1 procedura)
procedure TGrafikX.Inter2(Sender: TObject);
//TSH -->
var i,j,m,z,k :integer;
prir,toch,pw :real;
znachNRC: array[0..13] of real;
znachNapr: array[0..9] of real;
prome: array[0..1000] of real;
Pmas: array[0..1000] of real;
  begin
     Series1.Clear;
//     Series2.Clear;       //Proverka
     Series3.Clear;
     Series4.Clear;
     Series5.Clear;
     Series6.Clear;
     Label18.Visible:=false;
     Label19.Visible:=true;
     Label21.Visible:=false;
     m:=0;
//Zpolnenie massivov nulyami
     for i:=0 to 13 do
     znachNRC[i]:=0;
     for i:=0 to 9 do
     znachNapr[i]:=0.01;
     for i:=0 to 1000 do
     begin
     prome[i]:=0.01;
     Pmas[i]:=0.01;
     end;
//Zapolnenie massivov
     j:=strtoint(Form3.Edit1.Text)-2;
     k:=3;
     for i:=1 to j do
     begin;
     if (TCheckBox(FindComponent('CheckBox'+IntToStr(i))).Checked=true)  then
     begin;
     znachNRC[m]:=k;
     znachNapr[m]:=strtofloat(TEdit(FindComponent('Edit'+IntToStr(k))).Text);
     m:=m+1;
     end;
     k:=k+1;
     end;
     if (m<2) then exit;
//Podgotovka k postroeniyu grafika interpolyazii
          pw:= 1;
      for j := 0 to m-1 do
        begin
              pw := 1;
              for i := 0 to m-1 do
                begin
                  IF( (i <> j) and (znachNRC[i] <> 0) and (znachNRC[j] <> 0) )THEN pw := pw * ( 1 / (znachNRC[j] - znachNRC[i]) );
                end;
              prome[j] := pw * znachNapr[j];
        end;

       prir := znachNRC[0] - 0.01;
//Postroeniye grafika interpolyacii
     z:=0;
     for z := 0 to m-1 do
       begin
         while (prir < 16) do
           begin
             prir := prir + 0.01;
                toch:=0;
             for j := 0 to m-1 do
               begin
                 pw := 1;
                 for i := 0 to m-1 Do
                   begin
                     if (i <> j) then pw := pw  * (prir - znachNRC[i]);
                   end;
                 Pmas[j] :=  pw * prome[j]; //Polucheniye mnogochlenov
               end;
               for k := 0 to m-1 do
                 begin
                   toch := toch + Pmas[k]; //Summa mnogochlenov
                 end;
               Series5.AddXY(prir, toch);  //Vivod na grafik
           end;
       end;
       for i:=0 to m-1 do
        begin;
        if (znachNRC[i]<3) then Continue;
        Series6.AddXY(znachNRC[i],znachNapr[i]);
        end;
end;

//Dobavil Serafim Meleshko(1 procedura)
procedure TGrafikX.Inter3(Sender: TObject);
//TSH -->
var i,m,k,j,n,z :integer;
prome,h,g,prir,dop :real;
znachNRC: array[0..9] of real;
znachNapr: array[0..9] of real;
Fx: array[1..10,1..10] of Extended; //Matriza znacheniy summ
Fy: array[1..10] of Extended;    //Massiv svobodnich chlenov
rezul: array[1..10] of Extended;
  begin
     Series1.Clear;
//     Series2.Clear;  //Proverka
     Series3.Clear;
     Series4.Clear;
     Series5.Clear;
     Series6.Clear;
     Label18.Visible:=false;
     Label19.Visible:=false;
     Label21.Visible:=true;
     m:=0;//Chiclo tochek
//Zapolnenie massivov
     for i:=0 to 9 do
     begin
     znachNRC[i]:=0;
     znachNapr[i]:=0.01;
     end;
     for i:=1 to 10 do
     begin
     for j:=1 to 10 do
     Fx[i][j]:=0.01;
     Fy[i]:=0.01;
     rezul[i]:=0.01;
     end;
     j:=strtoint(Form3.Edit1.Text)-2;
     k:=3;
     for i:=1 to j do
     begin;
     if (TCheckBox(FindComponent('CheckBox'+IntToStr(i))).Checked=true)  then
     begin;
     znachNRC[m]:=k;
     znachNapr[m]:=strtofloat(TEdit(FindComponent('Edit'+IntToStr(k))).Text);
     m:=m+1;
     end;
     k:=k+1;
     end;
     if (m<2) then exit;
     k:=m-1; //Stepen polinoma
     //Zapolnenie massiva svobodnich chlenov
     Fy[1]:=0;
     for j:=0 to k do
     Fy[1]:=Fy[1]+znachNapr[j];
     Fx[1][1]:=m;
     Fy[2]:=0;
     for i:=2 to m do
     for j:=0 to k do
     Fy[i]:=Fy[i]+exp((i-1)*ln(znachNRC[j]))*znachNapr[j];
     for i:=1 to m do
     for j:=1 to m do     
     begin;
     prome:=0;
     if ((i=1) and (j=1)) then Continue;
     for n:=0 to k do
     begin
     prome:=prome+exp((j+i-2)*ln(znachNRC[n]));
     end;
     Fx[i][j]:=prome;
     end;
//Method Gaussa
//Privedeniye matrizi k treugolnomu vidu
     h:=0;
     for n:=1 to m do
     begin
     for j:=n+1 to m do
     begin
     h:=Fx[j][n]/Fx[n][n];
     for i:=n to m do
     begin
     Fx[j][i]:=Fx[j][i]-h*Fx[n][i];
     end;
     Fy[j]:=Fy[j]-h*Fy[n];
     end;
     end;

//Vichisleniye korney
     for n:=m downto 1 do
     begin
     h:=0;
     for j:=n+1 to m do
     begin
     g:=Fx[n,j]*rezul[j];
     h:=h+g;
     end;
     rezul[n]:=(Fy[n]-h)/Fx[n,n];
     end;

//Vivod
     prir := znachNRC[0] - 0.01;
     z:=0;
     for z := 0 to m-1 do
     begin
     while (prir < 16) do
     begin
     g:=0;
     prir := prir + 0.01;
     for j := 1 to m do
     begin
     dop:=0;
     if (j=1) then
     begin
     g:=g+rezul[j];
     Continue;
     end;
     dop:=exp((j-1)*ln(prir));
     g:=g+rezul[j]*dop;
     end;
     Series5.AddXY(prir, g);  //Vivod na grafik
     end;
     end;
     for i:=0 to m-1 do
     begin;
     if (znachNRC[i]<3) then Continue;
     Series6.AddXY(znachNRC[i],znachNapr[i]);
     end;

end;

end.
