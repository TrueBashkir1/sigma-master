{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
Unit WaitForm;

Interface

Uses
     Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     ExtCtrls, StdCtrls, Buttons, ComCtrls;

Type
     TWaitForm1 = Class(TForm)
               Timer1    : TTimer;
               Panel1    : TPanel;
               Label1: TLabel;
               PaintBox1: TPaintBox;
               Panel2: TPanel;
               Termenate: TBitBtn;
    Bar: TProgressBar;
               Procedure PaintBox1Paint(Sender: TObject);
               Procedure Timer1Timer(Sender: TObject);
               Procedure TermenateClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
          private
               { Private declarations }
          public
               { Public declarations }
               AfterRun     : Procedure;
               FileExecuted : boolean;
               FileName     : String;
               Procedure StartShow(text:String);
     End;

Var
     WaitForm1 : TWaitForm1;
Procedure TimeQuant;
Implementation
{$R *.DFM}
Uses MainForm;
Const
     StepCount= 60;
Var
     Coner : integer;
     inv:boolean;
Procedure TimeQuant;
Begin
     inc(Coner);
     If Coner>StepCount-1 Then
     begin
          Coner:=0;
          inv:=not inv;
     end;
End;

Procedure TWaitForm1.StartShow;
Begin
     Caption:=text;
     Label1.Caption:=text;
     Timer1.Enabled:=true;
     Show;
End;
Procedure TWaitForm1.PaintBox1Paint(Sender: TObject);
const
     PI_2=pi/2;
     PI2=2*pi;
     step=PI2/StepCount;
var
     Canvas:TCanvas;
     h, w : integer;
     half:integer;
     procedure Triangle(id:integer);
     var
          x1,y1,x2,y2:integer;
          p:integer;
     begin
          if id<>0 then
          begin
               x1:=trunc(w+cos(PI_2-id*step)*0.9*w);
               y1:=trunc(h-sin(PI_2-id*step)*0.9*h);
               x2:=trunc(w+cos(PI_2-(id-1)*step)*0.9*w);
               y2:=trunc(h-sin(PI_2-(id-1)*step)*0.9*h);
             {  p:=id-half;}
               if id<=half then
               begin
                    p:=trunc(id/StepCount*765);
                    Canvas.Brush.Color:=RGB(0,255-(255-p),255-p);
               end else
               begin
                    if id<=2*half then
                    begin
                         p:=trunc((id-half)/StepCount*765);
                         Canvas.Brush.Color:=RGB(255-(255-p),255-p,0);
                    end else
                    begin
                         p:=trunc((id-2*half)/(StepCount+1)*765);
                         Canvas.Brush.Color:=RGB(255-p,0,255-(255-p));
                    end;
               end;
               Canvas.Pen.Color:=Canvas.Brush.Color;
               Canvas.Polygon([point(w,h),point(x2,y2),point(x1,y1)]);
          end;
     end;
Var
     start,stop,i:integer;
     Bitmap : TBitMap;
Begin
     h:=trunc(PaintBox1.Height/2);
     w:=trunc(PaintBox1.Width/2);
     half:=trunc(StepCount/3);
     if inv then
     begin
          start:=coner;
          stop:=StepCount;
     end else
     begin
          start:=0;
          stop:=coner;
     end;
     Bitmap := TBitmap.Create;
     Bitmap.Width:=PaintBox1.Width;
     Bitmap.Height:=PaintBox1.Height;
     Canvas:=Bitmap.Canvas;
     with Bitmap.Canvas do
     begin
          Brush.Color:=WaitForm1.Color;
          Brush.Style:=bsSolid;
          FillRect(Bitmap.Canvas.ClipRect);
     end;
     for i:=start to stop do
     begin
         if Bar.Position <> 10000 then begin
            Bar.StepIt
         end
         else
         begin
            Bar.Position := 0;
         end;
         Triangle(i);
     end;
//     Bar.Position := 1000;
     paintbox1.Canvas.Draw(0,0,BitMap);
     Bitmap.Free;
End;

{
Simple magic представляет
кто автори сия творенья неизвестно,
но он - гений.
}
Procedure TWaitForm1.Timer1Timer(Sender: TObject);
     procedure Finish;
     var
     i: Integer;
     begin
          FileExecuted:=false;
          Timer1.Enabled:=false;
          repeat
                Bar.Position:=Bar.Position + 100
          until Bar.Position = 10000;
          Sleep(50);
          hide;
          AfterRun;
     end;
     procedure Continue;
     begin
          TimeQuant;
          PaintBox1Paint(nil);
     end;
Var
     ExitCode : Cardinal;
    { x1,x2:DWORD;}
Begin
     If FileExecuted Then
     Begin
          GetExitCodeProcess(ProcessInfo.hProcess,ExitCode);
          If ExitCode=259 Then
          Begin
               if FileExists(FileName) then Continue
               Else
               begin
                    TerminateProcess(ProcessInfo.hProcess,0);
                    Finish;
               end;
          End Else Begin
                Finish;
                End;
     End;
End;

Procedure TWaitForm1.TermenateClick(Sender: TObject);
Begin
     if not TerminateProcess(ProcessInfo.hProcess,0) then ShowMessage('Не удалось остановить выполнение программы.')
     else Timer1Timer(nil);
End;

procedure TWaitForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     TerminateProcess(ProcessInfo.hProcess,0);
     Action:=caHide;
end;

procedure TWaitForm1.FormShow(Sender: TObject);
begin
Bar.Position := 0;
end;

End.

