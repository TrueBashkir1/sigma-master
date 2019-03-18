{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
library Nastran;

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
  ExportNastran,
  ResultsArrays in 'ResultsArrays.pas',
  ChooseCalc in 'ChooseCalc.pas' {ChooseCalcForm};
//  MSXML2_TLB in 'C:\Program Files\Borland\Delphi6\Imports\MSXML2_TLB.pas';

//,
  //Unit1 in 'Unit1.pas' {Form1};
{$E plg}
const
     IniFileName='Sigma32.ini';
{$R *.RES}
const
     PluginName = 'Экспорт в NASTRAN.';
     StringReg  = '\Software\MAI.609\SIGMA32\3.0';
     NastranKey = 'NastranFile';
var
     Button,Menu:Pointer;
procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     Menu:=RegisterMenu(Plugin,PChar(PluginName),55,5,PChar('ShowForm'));
     Button:=RegisterToolButton(Plugin,PChar(PluginName),55,PChar('Экспорт'),PChar('ShowForm'));
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
     //Application:=OldApplication;
end;
function GetDOSFileName(FileName:string):string;
var
     buf:array[1..255] of char;
     count:word;
     s:string;
begin
     count:=GetShortPathName(PChar(FileName),@buf, SizeOf(buf));
     s:=Buf;
     SetLength(s,count);
     Result:=s;
end;
procedure NastranSolve(Nastran,FileName:string);
Var
     zCurDir  : array [0..255] Of char;
     StartupInfo     : TStartupInfo;
     ProcessInfo     : TProcessInformation;
begin
     if FileExists(Nastran) and FileExists(FileName) then
     begin

          StrPCopy(zCurDir,ExtractFileDir(FileName));
          FillChar(StartupInfo,Sizeof(StartupInfo),#0);
          StartupInfo.cb         :=Sizeof(StartupInfo);
          StartupInfo.dwFlags    :=STARTF_USESHOWWINDOW;
          StartupInfo.wShowWindow:=SW_SHOWNORMAL;
          {Clipboard.Open;
          Clipboard.SetTextBuf(PChar(Nastran+' '+FileName));
          Clipboard.Close;}
          //CreateProcess(PChar(Nastran), PChar(Nastran+' '+'gjjhgjgjhgj'), nil, nil, false, CREATE_NEW_CONSOLE Or NORMAL_PRIORITY_CLASS, nil, zCurDir, StartupInfo, ProcessInfo);
          CreateProcess(nil, PChar(Nastran+' '+GetDOSFileName(FileName)), nil, nil, false, CREATE_NEW_CONSOLE Or NORMAL_PRIORITY_CLASS, nil, zCurDir, StartupInfo, ProcessInfo);
     end;
End;

procedure ShowForm;stdcall;
var
     exp,path,res:string;
     Registry:TRegistry;                 
begin
     res:=String(GetProject_FileName);

     exp:=ChangeFileExt(res,'.dat');
     path:=ExtractFilePath(res);
     NastranExport(exp,path);

     if ChooseCalcForm.ModalResult=2 then exit;

     Registry:=TRegistry.Create;
     Registry.RootKey:=HKEY_LOCAL_MACHINE;
     if Registry.OpenKey(StringReg, true) then
     begin
          res:=Registry.ReadString(NastranKey);
//          if not FileExists(res) then
          begin
               with TOpenDialog.Create(nil) do
               begin
                    FileName:=res;
                    Title:='Укажите место располажения nastran.exe';
                    DefaultExt:='*.exe';
                    Filter:='Исполняемые файлы (*.exe)|*.exe|Все файлы *.*|*.*';
                    if Execute then res:=FileName;
                    free;
               end;
          end;
          NastranSolve(res,exp);
          if FileExists(res) then Registry.WriteString(NastranKey,res);
     end;
     Registry.free;
     {if Form1=nil then
     begin
          Form1:=TForm1.Create(nil);
          Form1.Icon.Handle:=LoadIcon(HInstance,'MAINICON');
     end;
     Form1.Show;}
end;
function GetPluginName:PChar;stdcall;
begin
     Result:=PChar(PluginName);
end;
function Can_Close:boolean;stdcall;
begin
     //if Form1<>nil then Form1.Close;
     Result:=true;
end;
exports InitializeDLL, FinalizeDLL,ShowForm,GetPluginName,Can_Close,CheckState;

end.
