{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
library SigmaPlotProcessing;

uses
  Windows,
  SysUtils,
  Classes,
  Dialogs,
  Graphics,
  MainInterface,
  inifiles,
  Registry,
  clipbrd,
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  strfunc in 'strfunc.pas',
  Constants in 'Constants.pas';

{$E plg}
{$R *.RES}
const
     PluginName = 'Экспорт в SigmaPlot';
     StringReg  = '\Software\MAI.609\SIGMA32\3.0';

var
     Menu,Button:Pointer;
     OldHandle:THandle;

procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     OldHandle:=Application.Handle;
     Application.Handle:=Handle;
     Menu:=RegisterMenu(Plugin,PChar('Экспорт в SigmaPlot'),55,5,PChar('ShowForm2'));
     Button:=RegisterToolButton(Plugin,PChar('Экспорт в SigmaPlot'),55,PChar('Экспорт'),PChar('ShowForm2'));
     RegisterPlugin(Plugin,3);
     FirstChapter:=nil;
end;

procedure CheckState;stdcall;
begin
     if FileExists(ExtractFilePath(String(GetProject_FileName))+'RESULT1.BIN') then
     begin
          SetMenuStatus(menu,True);
          SetToolButtonStatus(Button,True);
     end
     else begin
          SetMenuStatus(menu,False);
          SetToolButtonStatus(Button,False);
     end;
end;
procedure FinalizeDLL;stdcall;
begin
     if Form1<>nil then Form1.Destroy;
     Application.Handle:=OldHandle;
end;

procedure ShowForm2;stdcall;
begin
    If Form1=nil then
      begin
        form1:=Tform1.Create(nil);
      end;
    if firstChapter=nil then
      begin
        Form1.EditChapter.Enabled:=false;
        Form1.DeleteChapter.Enabled:=False;
        Form1.ProcessIt.Enabled:=false;
      end;
    Form1.Show;
end;

function GetPluginName:PChar;stdcall;
begin
     Result:=PChar(PluginName);
end;

function Can_Close:boolean;stdcall;
var t:PCHapter;
begin
    Result:=true;
end;
exports InitializeDLL, FinalizeDLL,ShowForm2,GetPluginName,Can_Close,CheckState;

end.
