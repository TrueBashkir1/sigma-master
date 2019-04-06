{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
library FormEditor;
uses
  Windows,
  Forms,
  Dialogs,
  Graphics,
  MainInterface,
  Sysutils,
  TSigmaForm,
  SetForm in 'SetForm.pas' {SetForm1},
  MainParam in 'MainParam.pas' {MainParamsForm},
  untLoadPset in 'untLoadPset.pas' {frmLoadPset},
  FormSettingsUnit in 'FormSettingsUnit.pas' {FormSettings},
  CalcDistanceUnit in 'CalcDistanceUnit.pas' {CalcDistanceForm};

{$E plg}

const
     Category='Импорт';
     Category1='Импорт';
     EditFormName='Геометрическая модель';
     ParamFormName='Основные параметры';
{$R *.RES}

var
     Button,Menu:Pointer;
     Buttonp,Menup:Pointer;
     OldHandle:THandle;
procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     OldHandle:=Application.Handle;
     Application.Handle:=Handle;
     Menu:=RegisterMenu(Plugin,PChar(EditFormName),53,2,PChar('ShowForm'));
     Button:=RegisterToolButton(Plugin,PChar(EditFormName),53,PChar(Category),PChar('ShowForm'));

     Menup:=RegisterMenu(Plugin,PChar(ParamFormName),42,1,PChar('ShowParamsForm'));
     Buttonp:=RegisterToolButton(Plugin,PChar(ParamFormName),42,PChar(Category1),PChar('ShowParamsForm'));
     RegisterPlugin(Plugin,Plugin_Edit_Form);
     Screen.Cursors[HandAct]:=LoadCursor(HInstance, 'HANDA');
     Screen.Cursors[HandPas]:=LoadCursor(HInstance, 'HANDP');
     Screen.Cursors[ZoomIn]:=LoadCursor(HInstance, 'ZOOMIN');
     Screen.Cursors[Zoomout]:=LoadCursor(HInstance, 'ZOOMOUT');
     Screen.Cursors[ZoomArea]:=LoadCursor(HInstance, 'ZOOMAREA');
end;

procedure CheckState;stdcall;
var
     ex:boolean;
begin
     if FileExists(Project_GetFormFile) then ex:=true
     else ex:=false;
     SetMenuStatus(menup,ex);
     SetToolButtonStatus(Buttonp,ex);
	 SetMenuStatus(menu,ex);
     SetToolButtonStatus(Button,ex);
end;
procedure FinalizeDLL;stdcall;
begin
     Application.Handle:=OldHandle;
end;
procedure ShowForm;stdcall;
begin
     if SetForm1=nil then
     begin       {**********}
                SetForm1:=TSetForm1.Create(nil);
          SetForm1.Icon.Handle:=LoadIcon(HInstance,'MAINICON');
     end;
     SetForm1.Show;
end;
procedure ShowParamsForm;stdcall;
begin
     if FileExists(Project_GetFormFile) then
     begin
          if (SetForm1=nil) then Form_Load(Project_GetFormFile);
          if MainParamsForm=nil then
          begin
               MainParamsForm:=TMainParamsForm.Create(nil);
               MainParamsForm.Icon.Handle:=LoadIcon(HInstance,'MAINICON');
          end;
          // Жеребцов. Убрал модальность формы основных параметров проекта.
          MainParamsForm.Show;
     end;
end;
function GetPluginName:PChar;stdcall;
begin
     Result:=PChar(EditFormName);
end;
function Can_Close:boolean;stdcall;
begin
     if MainParamsForm<>nil then MainParamsForm.close;
     if SetForm1<>nil then SetForm1.Close;
     Result:=true;
end;
exports InitializeDLL, FinalizeDLL, CheckState, ShowForm, ShowParamsForm, GetPluginName, Can_Close;

end.
//test 34
