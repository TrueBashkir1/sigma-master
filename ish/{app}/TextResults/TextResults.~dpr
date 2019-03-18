{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
library TextResults;

uses
  Windows,
  SysUtils,
  Classes,
  Forms,
  Dialogs,
  Graphics,
  MainInterface,
  Unit1 in 'Unit1.pas' {Form1};
{$E plg}
{$R *.RES}
const
     PluginName='Текстовый результат';
var
     Button,Menu:Pointer;
     OldHandle:THandle;
     //SigmaIni : TIniFile;
procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     OldHandle:=Application.Handle;
     Application.Handle:=Handle;

     Menu:=RegisterMenu(Plugin,PChar(PluginName),74,4,PChar('ShowForm'));
     Button:=RegisterToolButton(Plugin,PChar(PluginName),74,PChar('Результат'),PChar('ShowForm'));
     RegisterPlugin(Plugin,3);
end;
procedure CheckState;stdcall;
begin
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
procedure ShowForm;stdcall;
begin
     FileName:=ChangeFileExt(GetProject_FileName, '.res');
     if Form1=nil then
     begin
          Form1:=TForm1.Create(nil);
          Form1.Icon.Handle:=LoadIcon(HInstance,'MAINICON');
     end;
     Form1.Show;
end;
function GetPluginName:PChar;stdcall;
begin
     Result:=PChar(PluginName);
end;
function Can_Close:boolean;stdcall;
begin
     if Form1<>nil then Form1.Close;
     Result:=true;
end;
exports InitializeDLL, FinalizeDLL,ShowForm,GetPluginName,Can_Close,CheckState;

end.
