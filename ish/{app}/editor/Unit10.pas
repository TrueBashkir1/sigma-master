// Модуль "Построение графиков сходимости"
// Written by Shevchenko T. (comments: TSH) 25.02.2006
// Форма "Удаление точки"
// TSH -->
unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Unit3;

type
  TForm10 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    OK: TButton;
    Cancel: TButton;
    procedure CancelClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.CancelClick(Sender: TObject);
begin
Form10.Close;
end;

procedure TForm10.OKClick(Sender: TObject);
var i,j,delPoint:integer;
var tmpX: array[1..5] of real;
var tmpY: array[1..5] of real;
begin
Form3.ComboBoxEx1.Text:= Form10.ComboBox1.Text;
delpoint:=strtoint(Form3.ComboBoxEx1.Text);
Form3.ComboBoxEx1.Items.Delete(Form3.ComboBoxEx1.Items.IndexOf(Form3.ComboBoxEx1.Text));
Form10.ComboBox1.Items.Delete(Form10.ComboBox1.Items.IndexOf(Form10.ComboBox1.Text));

if Form3.ComboBoxEx1.Items.Count =  0 then
 begin;
  Form3.ComboBoxEx1.Clear;
  Form3.EditX.Clear;
  Form3.EditY.Clear;
  Form3.Button11.Enabled:=false;
  Form3.Button7.Enabled:=false;
  Form10.ComboBox1.Clear;
  for i:=1 to 5 do begin;
   Form3.SelectedPointsX[i]:=0;
   Form3.SelectedPointsY[i]:=0;
  end;
 end
else
 begin;
  Form3.CurPoint:=Form3.CurPoint-1;
  Form3.Button10.Enabled:=true;
  if(Form3.CurPoint <= 2) then Form3.Button12.Enabled:=false;

//Переназначение индексов
  j:=1;
  for i:=1 to Form3.CurPoint-1 do begin;
   if(i = delpoint) then
    begin;
     tmpX[i]:=Form3.SelectedPointsX[j+1];
     tmpY[i]:=Form3.SelectedPointsY[j+1];
     j:=j+1;
    end
   else
    begin;
     tmpX[i]:=Form3.SelectedPointsX[j];
     tmpY[i]:=Form3.SelectedPointsY[j];
    end;
    j:=j+1;
  end;

//Создание новых ComboBox с учетом удаления
  for i:=1 to 5 do begin;
   Form3.SelectedPointsX[i]:=0;
   Form3.SelectedPointsY[i]:=0;
  end;
  Form3.ComboBoxEx1.Clear;
  for i:=1 to Form3.CurPoint-1 do begin;
   Form3.ComboBoxEx1.Items.Add(inttostr(i));
   Form3.SelectedPointsX[i]:=tmpX[i];
   Form3.SelectedPointsY[i]:=tmpY[i];
  end;
  Form3.ComboBoxEx1.Text := Form3.ComboBoxEx1.Items[0];
  Form3.EditX.Text := floattostr(Form3.SelectedPointsX[strtoint(Form3.ComboBoxEx1.Text)]);
  Form3.EditY.Text := floattostr(Form3.SelectedPointsY[strtoint(Form3.ComboBoxEx1.Text)]);
  Form3.EditX.Refresh;
  Form3.EditY.Refresh;
 end;
Form10.Close;
end;
// TSH --<
end.
