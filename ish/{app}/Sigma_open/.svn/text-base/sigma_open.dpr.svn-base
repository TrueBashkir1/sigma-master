library sigma_open;
         
uses
  Windows,
  SysUtils,
  Classes,
  Forms,
  Dialogs,
  Graphics,
  MainInterface,
   Unit1 in 'Unit1.pas'{Form1};

{$E plg}
{$R *.RES}
const
     PluginName='Загрузка результатов';
var
     Menu:Pointer;
     Button:Pointer;
     OldHandle:THandle;
     fname1:string;


procedure CopyFile2(fpath1:PChar; fpath2:PChar);
 var
  F1, F2: TextFile;
  Ch: Char;
begin
    AssignFile(F1, fpath1);
    Reset(F1);
    AssignFile(F2, fpath2);
    Rewrite(F2);
    while not Eof(F1) do
      begin
        Read(F1, Ch);
        Write(F2, Ch);
      end;
      CloseFile(F2);
      CloseFile(F1);
end;

procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     OldHandle:=Application.Handle;
     Application.Handle:=Handle;

     Button:=RegisterToolButton(Plugin,PChar('Открыть файл отчета'),91,PChar('Открытие результатов'),PChar('ShowForm'));
     Menu:=RegisterMenu(Plugin,PChar(PluginName),91,5,PChar('ShowForm'));
     RegisterPlugin(Plugin,3);

end;

procedure CheckState;stdcall;
begin
if FileExists(ChangeFileExt(String(GetProject_FileName), '.spr')) then
  begin
        SetMenuStatus(menu,True);
        SetToolButtonStatus(Button,True);
  end
  else
  begin
        SetMenuStatus(menu,false);
        SetToolButtonStatus(Button,false);
  end;

end;


procedure FinalizeDLL;stdcall;
begin
    
     if Form1<>nil then Form1.Free;
     Application.Handle:=OldHandle;
end;

procedure ShowForm;stdcall;
begin

      if form1=nil then form1:=Tform1.Create(nil);

     if form1.OpenDialog1.Execute then
     begin
           if FileExists(ChangeFileExt(String(GetProject_FileName), '.res')) then
           begin
           CopyFile2(PChar(ChangeFileExt(String(GetProject_FileName), '.res')),
           PChar(ChangeFileExt(String(GetProject_FileName), '.tmp')));
           end;
     fname1:=form1.OpenDialog1.FileName;
         CopyFile2(PChar(fname1),
                  PChar(ChangeFileExt(String(GetProject_FileName), '.res')));
     end;

end;

function GetPluginName:PChar;stdcall;
begin
     Result:=PChar(PluginName);
end;

function Can_Close:boolean;stdcall;
begin
      Result:=true;
end;




exports InitializeDLL, FinalizeDLL,ShowForm,GetPluginName,Can_Close,CheckState;
end.



