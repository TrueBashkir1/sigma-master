library MatrixImage;

{$E plg}

uses
  Windows,
  SysUtils,
  Classes,
  Forms,
  Dialogs,
  Graphics,
  MainInterface,
  ShowMatrixForm in 'ShowMatrixForm.pas' {MatrixForm};

{$R *.res}

const
  PluginName = 'Графическое изображение образа матрицы';
var
  Button:Pointer;
  OldHandle:THandle;
procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
  OldHandle:=Application.Handle;
  Application.Handle:=Handle;

  Button:=RegisterToolButton(Plugin,PChar(PluginName),95,PChar('Результат'),PChar('ShowForm'));
  RegisterPlugin(Plugin,3);
end;
procedure ShowForm;stdcall;
begin
  if MatrixForm=nil then MatrixForm:=TMatrixForm.Create(nil);
  MatrixForm.ShowForm(String(GetProject_FileName));

  
end;
function GetPluginName:PChar;stdcall;
begin
     Result:=PChar(PluginName);
end;
procedure CheckState;stdcall;
begin
     if FileExists(ChangeFileExt(String(GetProject_FileName), '.res')) then
     begin
          SetToolButtonStatus(Button,True);
     end
     else begin
          SetToolButtonStatus(Button,False);
     end;
end;

function Can_Close:boolean;stdcall;
begin
     if MatrixForm<>nil then MatrixForm.Close;
     Result:=true;
end;

procedure FinalizeDLL;stdcall;
begin
     Application.Handle:=OldHandle;
end;

exports InitializeDLL, FinalizeDLL,GetPluginName,Can_Close,CheckState, ShowForm;

begin
end.
