// Модуль "Построение графиков сходимости"
// Written by Shevchenko T. (comments: TSH) 25.02.2006
// Форма "Добавление точки"
// TSH -->
unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Unit3;

type
  TForm9 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.Button2Click(Sender: TObject);
begin
Form9.Close;
end;

procedure TForm9.Button1Click(Sender: TObject);
begin
Form9.Close;
Form3.AddPoint();
end;

procedure TForm9.Edit1Change(Sender: TObject);
begin
 Button1.Enabled:=true;
end;

procedure TForm9.Edit2Change(Sender: TObject);
begin
 Button1.Enabled:=true;
end;
// TSH --<
end.
