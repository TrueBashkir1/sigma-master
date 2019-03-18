{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                         Боков Петр Юрьевич 2008                     }
{                                                                     }
{*********************************************************************}
library RupertAlg;

{ Рабочая версия }

uses
  Windows,
  Forms,
  Dialogs,
  Graphics,
  Sysutils,
  Classes,
  ShowCells in 'ShowCells.pas' {ShowCellsForm},
  TSigmaForm in 'TSigmaForm.pas',
  MainInterface in 'MainInterface.pas',
  AlgForm in 'AlgForm.pas' {AlgForm},
  Main in 'Main.pas' {Form1},
  Segment in 'Segment.pas' {Segment},
  SysSettings in 'SysSettings.pas' {SysSettings},
  ResFunc in 'ResFunc.pas';

{$E plg}
const
     PluginName='Экспорт сетки КЭ в подсистему алгоритма Рапперта';
var
     Button,Menu:Pointer;
     OldHandle:THandle;
procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     OldHandle:=Application.Handle;
     Application.Handle:=Handle;
     Menu:=RegisterMenu(Plugin,PChar(PluginName),113,4,PChar('ShowMainRupert'));
     Button:=RegisterToolButton(Plugin,PChar(PluginName),113,PChar(PluginName),PChar('ShowMainRupert'));
     RegisterPlugin(Plugin,12);
     Screen.Cursors[HandAct]:=LoadCursor(HInstance, 'HANDA');
     Screen.Cursors[HandPas]:=LoadCursor(HInstance, 'HANDP');
     Screen.Cursors[ZoomIn]:=LoadCursor(HInstance, 'ZOOMIN');
     Screen.Cursors[Zoomout]:=LoadCursor(HInstance, 'ZOOMOUT');
     Screen.Cursors[ZoomArea]:=LoadCursor(HInstance, 'ZOOMAREA');
end;

procedure CheckState;stdcall;
begin
// Можно сделать проверку в реестре, если в реестре не стоит переменная, что есть хоть какие-то данные,
// то можно форму подгружать
  if FileExists(ChangeFileExt(String(GetProject_FileName), '.res')) then
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
     Application.Handle:=OldHandle;
end;

procedure ShowMainRupert;stdcall;
begin
  if MainR=nil then MainR:=TMainForm.Create(nil);
  MainR.ShowForm(nil);
end;
function GetPluginName:PChar;stdcall;
    begin
        Result:=PChar(PluginName);
    end;
function Can_Close:boolean;stdcall;
    begin
        if MainR<>nil then MainR.Close;
        Result:=true;
    end;

exports InitializeDLL, FinalizeDLL,ShowMainRupert,GetPluginName,Can_Close,CheckState;
{*****>}
exports CompileNow,RunNow;
{<*****}
end.

