unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, MainInterface, Buttons, Registry,FileCtrl,
  INIfiles;

type
  TForm1 = class(TForm)
    ChaptersList: TListBox;
    AddChapter: TButton;
    DeleteChapter: TButton;
    EditChapter: TButton;
    Label1: TLabel;
    About: TBitBtn;
    ProcessIt: TSpeedButton;
    Label2: TLabel;
    HintText: TStaticText;
    OpenDialog1: TOpenDialog;
    DeleteTempFiles: TBitBtn;
    Configure: TBitBtn;
    procedure ShowAbout(Sender: TObject);
    procedure AddChapterClick(Sender: TObject);
    procedure DeleteChapterClick(Sender: TObject);
    procedure EditChapterClick(Sender: TObject);
    procedure InitForm(Sender: TObject);
    procedure DestroyForm(Sender: TObject);
    function AddSpaces (s1:string):string;
    procedure Process(Sender: TObject);
    procedure DeleteTempFilesClick(Sender: TObject);
    procedure ConfigureClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  PChapter = ^TChapter;
  TChapter = record
    name: string;
    dataType: integer;
    actionType: integer;
    usingNRC: array [0..9] of boolean;
    prevChapter, nextChapter: PChapter;
  end;

const
     StringReg  = '\Software\MAI.609\SIGMA32\3.0';

var
     Form1: TForm1;
     FirstChapter: PChapter;
     CurrentChapter: PChapter;
     TempChapter: PChapter;
     PathToProject: String;
     PathToSPW: String;
implementation

uses Unit3, Unit2,ShellAPI;

{$R *.dfm}

procedure TForm1.ShowAbout(Sender: TObject);
begin
  If Form3=nil then form3:=Tform3.Create(nil);
  Form3.ShowModal;
end;

procedure TForm1.AddChapterClick(Sender: TObject);
var i:integer;
begin
  If Form2=nil then form2:=TForm2.Create(nil);
  TempChapter:=CurrentChapter;
  If Form2.ShowModal=mrOk then
    begin
      if form1.ChaptersList.Items.Count=0 then
        begin
          new(FirstChapter);
          CurrentChapter:=FirstChapter;
          FirstChapter^.PrevChapter:=nil;
          FirstChapter^.NextChapter:=nil;
        end
      else
        begin
          new(TempChapter);
          TempChapter^.NextChapter:=nil;
          TempChapter^.PrevChapter:=CurrentChapter;
          CurrentChapter^.NextChapter:=TempChapter;
          CurrentChapter:=TempChapter;
        end;
      CurrentChapter^.dataType:=Form2.DataType.ItemIndex;
      CurrentChapter^.actionType:=Form2.ActionType.ItemIndex;
      for i:=0 to 9 do
      if Form2.NRCList.Checked[i] then CurrentChapter^.usingNrc[i]:=true else CurrentChapter^.usingNrc[i]:=false;
      CurrentChapter^.Name:=Form2.NameField.Text;
      Form1.ChaptersList.Items.Add(CurrentChapter^.Name);
    end;
  if FirstChapter<>nil then
    begin
      Form1.EditChapter.Enabled:=True;
      Form1.DeleteChapter.Enabled:=True;
      Form1.ProcessIt.Enabled:=True;
    end;
end;

procedure TForm1.DeleteChapterClick(Sender: TObject);
begin
if ChaptersList.ItemIndex<>-1 then
   begin
     TempChapter:=FirstChapter;
     While TempChapter<>nil do
       begin
         if TempChapter^.name=ChaptersList.Items.Strings[ChaptersList.ItemIndex] then break
         else TempChapter:=TempChapter^.nextChapter;
       end;
     If TempChapter<>FirstChapter then
       begin
         TempChapter^.prevChapter^.nextChapter:=TempChapter^.nextChapter;
         dispose(TempChapter);
         ChaptersList.DeleteSelected;
       end
     else
       begin
         If TempChapter^.nextChapter=nil then
           begin
             dispose(TempChapter);
             ChaptersList.DeleteSelected;
             FirstChapter:=nil;
           end
         else
           begin
             FirstChapter:=TempChapter^.nextChapter;
             dispose(TempChapter);
             ChaptersList.DeleteSelected;
           end;
       end;
   end;
if FirstChapter=nil then
  begin
    Form1.EditChapter.Enabled:=false;
    Form1.DeleteChapter.Enabled:=False;
    Form1.ProcessIt.Enabled:=false;
  end;
end;

procedure TForm1.EditChapterClick(Sender: TObject);
var i:integer;
begin
if ChaptersList.ItemIndex<>-1 then
   begin
     TempChapter:=FirstChapter;
     While TempChapter<>nil do
       begin
         if TempChapter^.name=ChaptersList.Items.Strings[ChaptersList.ItemIndex] then break
         else TempChapter:=TempChapter^.nextChapter;
       end;
     If Form2.showmodal=mrOk then
       begin
         TempChapter^.dataType:=Form2.DataType.ItemIndex;
         TempChapter^.actionType:=Form2.ActionType.ItemIndex;
         for i:=0 to 9 do
         if Form2.NRCList.Checked[i] then TempChapter^.usingNrc[i]:=true else TempChapter^.usingNrc[i]:=false;
         TempChapter^.Name:=Form2.NameField.Text;
       end;
   end;
end;

procedure TForm1.InitForm(Sender: TObject);
begin
FirstChapter:=nil;
TempCHapter:=nil;
CurrentChapter:=nil;
HintText.Caption:='Сформируйте список глав, после чего зафиксируйте список';
//if FirstChapter=nil then
//  begin
//    Form1.EditChapter.Enabled:=false;
//    Form1.DeleteChapter.Enabled:=False;
//    Form1.BuildQuery.Enabled:=false;
//  end;
end;

procedure TForm1.DestroyForm(Sender: TObject);
begin
   if form3<>nil then Form3.Destroy;
   if form2<>nil then Form2.Destroy;
   If firstchapter<> nil then
     begin
       tempchapter:=firstchapter;
       while tempchapter<>nil do
         begin
           tempchapter:=firstchapter^.nextChapter;
           dispose(firstchapter);
           firstchapter:=tempchapter;
         end;
     end;
end;

  {if FirstChapter<>nil then
    begin
      Reg:=TRegistry.Create;
      Reg.RootKey:=HKEY_CURRENT_USER;
      if Reg.OpenKey(StringReg,false) then
        begin
          PathToProject:=ExtractFilePath(Reg.ReadString('InputFileName'));
          Reg.CloseKey;
          Reg.Free;
        end
      else
        begin
          SelectDirectory('Укажите папку с проектом','C:\',PathToProject);
          Reg.Free;
        end;
      If FileExists(PathToProject+'SPWQuery.txt') then
        begin
          AssignFile(QueryFile,PathToProject+'SPWQuery.txt');
          Rewrite(QueryFile);
        end
      else
        begin
          FileCreate(PathToProject+'SPWQuery.txt');
          AssignFile(QueryFile,PathToProject+'SPWQuery.txt');
        end;
      WriteLn(QueryFile,AddSpaces(IntToStr(Form1.ChaptersList.Items.Count)));
      TempChapter:=FirstChapter;
      While TempChapter<>nil do
        begin
          WriteLn(queryfile,AddSpaces(TempChapter^.Name));
          case TempChapter^.dataType of
            0: begin
                 writeln(queryFile,AddSpaces(inttostr(3)));
                 j:=0;
                 for i:=0 to 9 do
                   if tempChapter^.usingNRC[i] then J:=J+1;
                 writeln(queryFile,AddSpaces(inttostr(j)));
               end;
         1..3: begin
                 writeln(queryFile,AddSpaces(inttostr(6)));
                 j:=0;
                 for i:=0 to 9 do
                   if tempChapter^.usingNRC[i] then J:=J+1;
                 writeln(queryFile,AddSpaces(inttostr(j)));
               end;
          end;
          WriteLn(QueryFile,AddSpaces(inttostr(TempChapter^.dataType)));
          WriteLn(QueryFile,AddSpaces(IntToStr(TempChapter^.actionType)));
          for i:=0 to 9 do
            begin
              if TempCHapter^.usingNRC[i] then j:=1 else j:=0;
              Writeln(QueryFile,AddSpaces(IntToStr(j)));
            end;
          TempCHapter:=TempChapter^.nextChapter;
        end;
      CloseFile(QueryFile);
    end;}

function TForm1.AddSpaces(s1:string):string;
var s2:string[20];
begin
   s2:='                    ';
   insert(s1,s2,0);
   result:=s2;
end;

procedure TForm1.Process(Sender: TObject);
var goodRun: boolean;
    reg: Tregistry;
    i,k: integer;
    NRCFiles: array[0..9] of textfile;
    ResultFile: textfile;
    numRows,numCols: integer;
    ActionString,NameString,TableHeader,TempString,ErrorNRC: string;
begin
   goodrun:=false;

   if processit.down then
     begin
        Reg:=TRegistry.Create;
        Reg.RootKey:=HKEY_CURRENT_USER;
        if Reg.OpenKey(StringReg,false) then
          begin
            PathToProject:=ExtractFilePath(Reg.ReadString('InputFileName'));
            Reg.CloseKey;
            Reg.Free;
          end
        else
          begin
            OpenDialog1.Title:='Укажите любой файл в папке проекта';
            OpenDialog1.Execute;
            PathToProject:=extractfilepath(OpenDialog1.FileName);
            Reg.Free;
          end;
        HintText.Caption:='Рассчитайте проект для всех NRC стандартным способом. После отожмите кнопку';
        AddChapter.Enabled:=false;
        DeleteChapter.Enabled:=false;
        EditChapter.Enabled:=false;
        DeleteTempFiles.Enabled:=false;
        ProcessIt.Caption:='Обработать в SPW';
     end;

   if not(processit.Down) then
     begin
       ErrorNRC:=' ';
       for i:=0 to 9 do
         begin
           goodrun:=true;
           if not(FileExists(PathToProject+'\SPW'+inttostr(i)+'.txt')) then
             begin
               goodRun:=false;
               if errorNRC=' ' then
                ErrorNRC:=' '+inttostr(i+3)
               else
                ErrorNRC:=ErrorNRC+', '+inttostr(i+3);
             end;
         end;

       if goodRun then
         begin
           AssignFile(ResultFile,PathToProject+'SPWResult.txt');
           Rewrite(ResultFile);

           for k:=0 to 9 do
             begin
               AssignFile(NRCFiles[k],PathToProject+'\SPW'+inttostr(k)+'.txt');
             end;

           TempChapter:=FirstChapter;
           while TempChapter<>nil do
             begin
               Writeln(ResultFile,'CHAPTER');
               case TempChapter^.dataType of
                 0: begin
                      numCols:=4;
                      TableHeader:='NRC X Y SUM';
                    end;
                 1: begin
                      numCols:=7;
                      TableHeader:='NRC X Y Tan 1st 2nd Equiv';
                    end;
                 2: begin
                      numCols:=7;
                      TableHeader:='NRC X Y Tan 1st 2nd Equiv';
                    end;
               end;
               case TempCHapter^.actionType of
                 0: ActionString:='SINGLEGRAPH';
                 1: ActionString:='MULTIPLEGRAPH';
                 2: ActionString:='FIT';
               end;
               numRows:=1;
               for k:=0 to 9 do
                 begin
                   if TempChapter^.usingNRC[k] then numRows:=numRows+1;
                 end;
               NameString:=TempChapter^.name;
               Writeln(ResultFile,inttostr(numCols)+' '+inttostr(numRows)+' '+ActionString+' '+NameString);
               WriteLn(ResultFile,TableHeader);
               For k:=0 to 9 do
                 begin
                   if Tempchapter^.usingNRC[k] then
                     begin
                       Reset(NRCFiles[k]);
                       case TempChapter^.dataType of
                         0:ReadLn(NRCFiles[k],TempString);
                         1:begin
                           ReadLn(NRCFiles[k],TempString);
                           ReadLn(NRCFiles[k],TempString);
                           end;
                         2:begin
                           ReadLn(NRCFiles[k],TempString);
                           ReadLn(NRCFiles[k],TempString);
                           ReadLn(NRCFiles[k],TempString);
                           end;
                       end;
                       CloseFile(NRCFiles[k]);
                       WriteLn(ResultFile,inttostr(k+3)+' '+TempString);
                     end;
                 end;
               WriteLn(ResultFile,'END');
               TempChapter:=TempChapter^.nextChapter;
             end;

           CloseFile(ResultFile);

           if MessageDlg('Продолжить рассчет в SigmaPlot?',mtConfirmation,mbOkCancel,0)=mrOk then
             begin
               Reg:=TRegistry.Create;
               Reg.RootKey:=HKEY_LOCAL_MACHINE;
               if reg.OpenKeyReadOnly('\SOFTWARE\Wow6432Node\SYSTAT Software Inc.\SigmaPlot\11.0') then
                   PathToSPW:=reg.ReadString('InstallPath')
               else
                 if reg.OpenKeyReadOnly('HKEY_LOCAL_MACHINE\SOFTWARE\SYSTAT Software Inc.\SigmaPlot\11.0') then
                   PathToSPW:=reg.ReadString('InstallPath')
                 else
                   begin
                     OpenDialog1.Title:='Укажите любой файл в папке с SigmaPlot';
                     OpenDialog1.Execute;
                     PathToSPW:=extractfilepath(OpenDialog1.FileName);
                   end;
               Reg.CloseKey;
               Reg.Free;
               CopyFile(PChar(PathToProject+'SPWresult.txt'),PChar(PathToSPW+'SPWResult.txt'),false);
               WinExec(PChar(PathToSPW+'spw.exe /runmacro:SigmaResults'),SW_ShowNormal);
               ProcessIt.Caption:='Зафиксировать список';
               AddChapter.Enabled:=true;
               DeleteChapter.Enabled:=true;
               EditChapter.Enabled:=true;
               DeleteTempFiles.Enabled:=true;
             end
           else
             begin
               ShowMessage('Файл результатов сохранен в корне проекта.'+#13#10'Можно рассчитать, запустив макрос SigmaPlotProcessing вручную из SigmaPlot');
               ProcessIt.Caption:='Зафиксировать список';
               AddChapter.Enabled:=true;
               DeleteChapter.Enabled:=true;
               EditChapter.Enabled:=true;
               DeleteTempFiles.Enabled:=true;
             end;
           HintText.Caption:='Сформируйте список глав, после чего зафиксируйте список';
         end
       else
         begin
           if MessageDlg('Рассчет не полный. Отсутствуют NRC:'+ErrorNRC+'.'+#13#10'Вернуться к редактированию списка?',mtConfirmation,mbOkCancel,0)=mrCancel then
             begin
               processit.Down:=true;
             end
           else
             begin
               AddChapter.Enabled:=true;
               DeleteChapter.Enabled:=true;
               EditChapter.Enabled:=true;
               DeleteTempFiles.Enabled:=true;
               HintText.Caption:='Сформируйте список глав, после чего зафиксируйте список';
             end;
         end;
     end;
end;

procedure TForm1.DeleteTempFilesClick(Sender: TObject);
var i: integer;
    reg: Tregistry;
begin
  If MessageDlg('Удалить все файлы результатов из корня проекта?'+#13#10'Внимание! Потребуются повторные рассчеты проекта!',mtConfirmation,mbOkCancel,0)=mrOk then
    begin
      Reg:=TRegistry.Create;
      Reg.RootKey:=HKEY_CURRENT_USER;
      if Reg.OpenKey(StringReg,false) then
        begin
          PathToProject:=ExtractFilePath(Reg.ReadString('InputFileName'));
          Reg.CloseKey;
          Reg.Free;
        end
      else
        begin
          OpenDialog1.Title:='Укажите любой файл в папке проекта';
          OpenDialog1.Execute;
          PathToProject:=extractfilepath(OpenDialog1.FileName);
          Reg.Free;
        end;
      for i:=0 to 9 do
        begin
          if FileExists(PathToProject+'\SPW'+INTTOSTR(i)+'.txt') then
            deletefile(PathToProject+'\SPW'+INTTOSTR(i)+'.txt');
        end;
      if FileExists(PathToProject+'\SPWResult.txt') then
            deletefile(PathToProject+'\SPWResult.txt');
    end;
end;

procedure TForm1.ConfigureClick(Sender: TObject);
var PathToSPWDocs: string;
    UserName: String;
    UserNameLen: dword;
    SPWini:TIniFile;
begin
  If MessageDlg('Произведется попытка автоматически настроить SigmaPlot для работы.'+#13#10'Подробности смотрите в инструкции',mtConfirmation,mbOkCancel,0)=mrOk then
    begin
      UserNameLen:=15;
      SetLength(UserName,UserNameLen);
      GetUserName(PChar(UserName), UserNameLen);
      UserName:=Trim(UserName);
      PathToSPWDocs:='C:\Users\'+UserName;
      PathToSPWDocs:=PathToSPWDocs+'\Documents\SigmaPlor\SPW11';
      If fileexists(PathToSPWDocs+'\spw.ini') then
        begin
          if fileexists(PathToSpwDocs+'\SigmaResults.jnb') then
            begin
              SPWini:=TIniFile.Create(PathToSPWDocs+'\spw.ini');
              SPWini.WriteString('Macro Preferences', 'MacroDefaultNotebook',PathToSPWDocs+'\SigmaResults.jnb');
              SPWini.Free;
            end
          else
            Showmessage('Файл с макросом SigmaResults.jnb отсутствует в директории '+PathToSPWDocs);
        end
      else
        begin
          OpenDialog1.Title:='Укажите путь к документам SigmaPlot.'+#13#10'Примерное расположение: C:\Users\%username%\Documents\SigmaPlot\SPW11\';
          if OpenDialog1.Execute then
            begin
              PathToSpwDocs:=extractfilepath(OpenDialog1.FileName);
              if fileexists(PathToSpwDocs+'SigmaResults.jnb') then
                begin
                  SPWini:=TIniFile.Create(PathToSPWDocs+'spw.ini');
                  SPWini.WriteString('Macro Preferences', 'MacroDefaultNotebook',PathToSPWDocs+'SigmaResults.jnb');
                  SPWini.Free;
                end
              else
                Showmessage('Файл с макросом SigmaResults.jnb отсутствует в директории '+PathToSPWDocs);
            end;
        end;
    end;
end;

end.
