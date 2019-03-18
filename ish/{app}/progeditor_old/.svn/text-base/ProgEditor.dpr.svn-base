{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
library ProgEditor;

uses
  Windows,
  Classes,
  Forms,
  Dialogs,
  Graphics,
  MainInterface,
  Sysutils,
  ProgramForm in 'ProgramForm.pas' {ProgramForm1};
{$P+,S-,W-,R-,T-,H+,X+}
{$C PRELOAD}
{$E plg}
{$R *.RES}
{$LIBSUFFIX 'Old'}

var
     Button,Menu:Pointer;
     OldHandle:THandle;
     //OldApplication:TApplication;
procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     OldHandle:=Application.Handle;
     Application.Handle:=Handle;
     Menu:=RegisterMenu(Plugin,PChar('Редактирование фортрановских модулей'),93,1,PChar('ShowForm'));
     Button:=RegisterToolButton(Plugin,PChar('Редактирование фортрановских модулей'),93,'Редактирование',PChar('ShowForm'));
     RegisterPlugin(Plugin,Plugin_Edit_Fortran);
     ProgramForm1:=nil;
end;
procedure FinalizeDLL;stdcall;
begin
     if ProgramForm1<>nil then ProgramForm1.Free;
     Application.Handle:=OldHandle;
     //Application:=OldApplication;
end;
procedure CheckState;stdcall;
begin
     //SetMenuStatus(menu,false);
     //SetToolButtonStatus(Button,false);
end;
procedure ShowForm;stdcall;
Begin
     if ProgramForm1=nil then
     begin
          ProgramForm1:=TProgramForm1.Create(nil);
          ProgramForm1.Icon.Handle:=LoadIcon(HInstance,'MAINICON');
     end;
     ProgramForm1.Show;

//     if ProgramForm1<>nil then
  //   begin
    //      SetMenuStatus(menu,False);
      //    SetToolButtonStatus(Button,False);
     //end

end;
function GetPluginName:PChar;stdcall;
begin
     Result:=PChar('Редактор ыть =)');
end;
procedure ShowError(FileName:PChar);stdcall;
var
     s:string;
begin
     s:=StrPas(FileName);
     if not((ProgramForm1=nil) and (s='')) then
     begin
          ShowForm;
          if (s='') then
          begin
               ProgramForm1.Splitter1.Hide;
               ProgramForm1.Memo1.Hide
          end else
          begin
               with ProgramForm1.Memo1 do
               begin
                    Lines.BeginUpdate;
                    Lines.LoadFromFile(s);
                    Lines.EndUpdate;
                    Show;
               end;
               ProgramForm1.Splitter1.show;
          end;
     end;
end;
function Can_Close:boolean;stdcall;
begin   
     if ProgramForm1=nil then Result:=true
     else Result:=ProgramForm1.CanClose;
end;
exports InitializeDLL, CheckState, FinalizeDLL,ShowForm,
     GetPluginName,Can_Close,ShowError;

end.
