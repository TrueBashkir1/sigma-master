{*********************************************************************}
{                                                                     }
{                    ���������� ����������� ��������                  }
{                                                                     }
{                               ������� 609                           }
{                                                                     }
{                    ������� ����� ����������� 2001                   }
{                                                                     }
{                     ������� ����� ���������� 2004                   }
{                                                                     }
{*********************************************************************}
library ShowResult;                    


uses
  Windows,
  SysUtils,
  Classes,
  Forms,
  Dialogs,
  Graphics,
  MainInterface,
  ShowMovings in 'ShowMovings.pas' {ShowMovingsForm},
  TSigmaForm in 'TSigmaForm.pas',
  ResultsArrays in 'ResultsArrays.pas',
  Unit1 in 'Unit1.pas' {Settings};


{$E plg}
{$R *.RES}

const
     PluginName='����������� ����������� ����������� �������';
var
     Button,Menu:Pointer;

     OldHandle:THandle;
procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     OldHandle:=Application.Handle;
    Application.Handle:=Handle;
     Menu:=RegisterMenu(Plugin,PChar(PluginName),72,6,PChar('ShowForm'));
     Button:=RegisterToolButton(Plugin,PChar(PluginName),72,PChar('���������'),
     PChar('ShowForm'));
     RegisterPlugin(Plugin,3);
     Screen.Cursors[HandAct]:=LoadCursor(HInstance, 'HANDA');
     Screen.Cursors[HandPas]:=LoadCursor(HInstance, 'HANDP');
     Screen.Cursors[ZoomIn]:=LoadCursor(HInstance, 'ZOOMIN');
     Screen.Cursors[Zoomout]:=LoadCursor(HInstance, 'ZOOMOUT');
     Screen.Cursors[ZoomArea]:=LoadCursor(HInstance, 'ZOOMAREA');
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

procedure ShowForm;stdcall;
begin

    if ShowMovingsForm=nil then
     begin
          ShowMovingsForm:=TShowMovingsForm.Create(nil);
          ShowMovingsForm.Icon.Handle:=LoadIcon(HInstance,'MAINICON');
          ShowMovingsForm.ShowForm(ChangeFileExt(GetProject_FileName, '.res'));
     end;
         ShowMovingsForm.UseLines.Checked := true;
         ShowMovingsForm.ShowForm(ChangeFileExt(GetProject_FileName, '.res'));

   IF ShowMovingsForm.Error<>0 THEN
    BEGIN
      ShowMessage('�������� "������������ ����������� ����������� �������" ����������');
      exit;
    END;
    ShowMovingsForm.LoadForm('ShowGrafical');
       ShowMovingsForm.BestFitActionClick(nil);

     if ShowMovingsForm<>nil then
     begin
          SetMenuStatus(menu,False);
          SetToolButtonStatus(Button,False);
     end     
end;



procedure FinalizeDLL;stdcall;
begin
     Application.Handle:=OldHandle;
end;
function GetPluginName:PChar;stdcall;
begin
     Result:=PChar(PluginName);
end;
function Can_Close:boolean;stdcall;
begin
     if ShowMovingsForm<>nil then ShowMovingsForm.Close;
     Result:=true;
end;
exports InitializeDLL, FinalizeDLL,ShowForm,GetPluginName,Can_Close,CheckState;

End.
