{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
Unit ProgramForm;

Interface

Uses
     Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     ComCtrls, StdCtrls, ExtCtrls, Menus, IniFiles, PrnServ, Printers;

Type
     TProgramForm1 = Class(TForm)
               Splitter1      : TSplitter;
               PopupMenu1     : TPopupMenu;
               MenuUndo       : TMenuItem;
               N1             : TMenuItem;
               MenuCut        : TMenuItem;
               MenuCopy       : TMenuItem;
               MenuPaste      : TMenuItem;
               MenuDelete     : TMenuItem;
               N2             : TMenuItem;
               MenuSelectAll  : TMenuItem;
               FontDialog1    : TFontDialog;
               SaveDialog1    : TSaveDialog;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure FormResize(Sender: TObject);
          private
               { Private declarations }
          public
               { Public declarations }
          procedure LoadForm(Name:string);

     End;

Var
     ProgramForm1 : TProgramForm1;
     dop :integer;
procedure ReloadFile(FileName:string);stdcall;
exports
       ReloadFile;
Implementation
Uses RichEdit, MainInterface, UFortranEdit, Registry, StrUtils;


{$R *.DFM}
procedure ReloadFile(FileName:string);stdcall;
begin
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

procedure TProgramForm1.LoadForm(Name:string);
var
     Registry:TRegistry;
     FileName:array[0..100] of Char;
     str2,str1,setting,s,path,hnotepad:string;
     poz,i:integer;
     w1:Word;
     a:TPoint;
begin
//Из ключа реестра определяем где установлена программа
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKeyReadOnly(StringReg+'\'+Name) then
     begin
     i:=0;
     str1:=Registry.ReadString('SigmaSource');
     while i<= Length(str1) do
     begin
        if str1[i]='S'then
        if str1[i+1]='o'then Break;
        i:=i+1;
     end;
     str2:=Copy(str1,0,i-1);
//Дописываем путь к блокноту
     str2:=str2+'bin\notepad\';
     StrPCopy(FileName,str2+'notepad++.exe');
//В настроечном файле блокнота выставляем размеры и положение
setting:='        ';
setting:=setting+'<GUIConfig name="AppPosition" x="1" y="97" ';
Height :=memo1.Height+35;
top:=Screen.Height-Height-35;
hnotepad:=IntToStr(top-100);
setting:=setting+'width="850" '+'height="'+hnotepad+'"';
setting:=setting+'isMaximized="no" />';
     with ProgramForm1.memo2 do
               begin
                    Lines.BeginUpdate;
                    Lines.LoadFromFile(str2+'config.xml');
                    memo2.Lines.Delete(15);
                    Lines.Insert(15,setting);
                    Lines.EndUpdate;
                    Memo2.Lines.SaveToFile(str2+'config.xml');
               end;
//Из конфигурационного файла сигмы смотрим какие файлы будут редактироваться
//в реестре это ключ InputFileName
str1:=Registry.ReadString('InputFileName');
with ProgramForm1.memo2 do
               begin
                    Lines.BeginUpdate;
                    Lines.LoadFromFile(str1);
                    //memo2.Lines.Count;
                    Lines.EndUpdate;
               end;
                    for i:=1 to memo2.Lines.Count-1 do
                    begin
                       s:=memo2.Lines.Strings[i];
                       if s[1]<>'*' then
                       begin
                          memo1.Lines.Add ( memo2.Lines.Strings [i]);
                       end;
                       s:=memo2.Lines.Strings[i+1];
                       if s[1]='#'then Break;
                    end;
                    memo2.Lines.Clear;
//Создаем файл сесии
                    memo2.Lines.Add('<NotepadPlus>');
                    memo2.Lines.Add('    <Session activeView="0">');
                    memo2.Lines.Add('        <mainView activeIndex="1">');
                    s:=Registry.ReadString('InputFileName');
                    s:=ReverseString(s);
                    i:=0;
                    while s[i]<>'\'do
                    begin
                      i:=i+1;
                    end;
                    s:=ReverseString(s);
                    path:=Copy(s,0,(Length(s)-i+1));
                    for i:=0 to memo1.Lines.Count-1 do
                    begin
                    s:='            <File firstVisibleLine="0" xOffset="0"';
                    s:=s+' scrollWidth="1704" startPos="524" endPos="524" ';
                    s:=s+'selMode="0" lang="Fortran" filename="';
                    s:=s+path;
                    s:=s+memo1.Lines.Strings[i];
                    s:=s+'" />';
                    memo2.Lines.add(s);
                    end;
                    memo2.Lines.Add('        </mainView>');
                    memo2.Lines.Add('        <subView activeIndex="0" />');
                    memo2.Lines.Add('    </Session>');
                    memo2.Lines.Add('</NotepadPlus>');
//пишем в файл конфигурации открываемые файлы
                    memo2.Lines.SaveToFile(str2+'session.xml');
                    memo1.Lines.clear;
//Запускаем блокнот :)
     //w1 := WinExec(FileName, SW_Restore);
     a.x:=0;
     a.y:=0;
     ChildWindowFromPoint(WinExec(FileName, SW_Restore),a);
     end;
//Завершаем работу с реестром
     Registry.free;
end;

procedure TProgramForm1.FormResize(Sender: TObject);
var
cfF: TIniFile;
begin
Height :=memo1.Height+35;
Width:=memo1.Width+9;
Left:= 0;
//ProgramForm1.top:=Screen.Height-(Screen.Height-ProgramForm1.Height);
top:=Screen.Height-Height-35;


//ProgramForm1.ListBox1.Height:=150-StatusBar1.Height ;
{     dop:=0;
     top:=0;
      cfF:=TIniFile.Create('sforms.ini');
      try
                dop:=CfF.ReadInteger('Главная','Высота',top);
                top:=dop-StatusBar1.Height-8;
                left:=0;
                Height:=Screen.Height-dop;
                cfF.Free;
      except
                MessageDlg('Не могу прочитать файл sforms.ini!',mtError,[mbOk],0);
      end;
     Constraints.MaxHeight:=Screen.Height-dop;
     top:=dop-StatusBar1.Height-8;     }
end;
End.
