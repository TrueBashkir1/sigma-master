
Unit TProject;

Interface
Uses classes;
Type
     TProjectClass = Class
          private
               FProjectPath  : string;
               ProjectName  : string;
               fModified    : boolean;
               fFormFile    : String;
               procedure    SetFormFile(Value:String);
               procedure    SetProjectPath(Value:String);
          public
               ProgramFiles : TStringList;
               Error        : word;
               Source       : string;
               IniFile      : string;
               property     FormFile : String read fFormFile write SetFormFile;
               property     ProjectPath: string read FProjectPath write SetProjectPath;
               property     Modified : boolean read fModified;
               constructor  Create;
               function     PackFileName(FileName:string):String;
               function     UnPackFileName(FileName:string):String;
               procedure    New;
               Procedure    Save(FileName:string);
               Procedure    Load(FileName:string);
               Destructor   Destroy;override;
               procedure    ListChange(Sender: TObject);
               procedure    AddFile(FileName:string;OldProject:boolean);
     End;
     MyString=PChar;
//описать все экспортные функции для работы с классом
procedure Project_New;stdcall;
procedure Project_Open(filename:MyString);stdcall;
procedure Project_Save(filename:MyString);stdcall;
function  Project_PackFileName(filename:MyString):MyString;stdcall;
function  Project_UnPackFileName(filename:MyString):MyString;stdcall;
function  Project_IsModified:boolean;stdcall;
function  Project_Error:word;stdcall;
procedure Project_SetSource(PathStr:MyString);stdcall;
function  Project_GetSource:MyString;stdcall;
procedure Project_SetFormFile(filename:MyString);stdcall;
function  Project_GetFormFile:MyString;stdcall;
procedure Project_Fortran_Add(filename:MyString);stdcall;
procedure Project_Fortran_Del(filename:MyString);stdcall;
function  Project_Fortran_Count:word;stdcall;
procedure Project_Fortran_Set(Index:word;filename:MyString);stdcall;
function  Project_Fortran_Get(Index:word):MyString;stdcall;
procedure Project_Fortran_Clear;stdcall;
procedure Project_NotModified;
procedure SetIniFile(FileName:String);
//TSH(Ошибка при работе с проектом) -->
procedure Project_Clear;stdcall;  {kotov}
function  Project_Name:string;stdcall; {kotov}
//TSH(Ошибка при работе с проектом) <--
exports
       Project_New, Project_Open, Project_Save, Project_PackFileName,
       Project_UnPackFileName, Project_IsModified, Project_Error,
       Project_SetSource, Project_SetSource, Project_SetFormFile,
       Project_GetFormFile, Project_Fortran_Add, Project_Fortran_Del,
       Project_Fortran_Count, Project_Fortran_Set, Project_Fortran_Get,
       Project_Fortran_Clear,{TSH(Ошибка при работе с проектом) =>}Project_Clear,Project_Name;
Implementation
Uses SysUtils,{}sets,MainForm{},Constants, strfunc, IniFiles, Dialogs{TSH(Ошибка при работе с проектом) =>},Registry,windows;

var
   Project:TProjectClass;
procedure SetIniFile;
begin
     Project.IniFile:=FileName;
end;
//TSH(Ошибка при работе с проектом) -->
function Project_Name;
begin
     result := Project.fProjectPath+Project.ProjectName;
end;
procedure Project_Clear;
begin
     Project_NotModified;
     Project.fProjectPath:='';
     Project.ProjectName:='';
end;
//TSH(Ошибка при работе с проектом) <--
procedure Project_New;
begin
     Project.New;
end;
procedure Project_Open(filename:MyString);
begin
     Project.Load(StrPas(FileName));
end;
procedure Project_Save(filename:MyString);
begin
     Project.Save(StrPas(FileName));
end;
function  Project_PackFileName(filename:MyString):MyString;
var
     s:array[0..255] of char;
     X:string;
begin
     x:=Project.PackFileName(StrPas(FileName));
     StrPCopy(s,x);
     Result:=s;
end;
function  Project_UnPackFileName(filename:MyString):MyString;
var
     s:array[0..255] of char;
     X:string;
begin
     x:=Project.UnPackFileName(StrPas(FileName));
     StrPCopy(s,x);
     Result:=s;
end;
function  Project_IsModified:boolean;
begin
     Result:=Project.Modified;
end;
function  Project_Error:word;
begin
     Result:=Project.Error;
end;
procedure Project_SetSource(PathStr:MyString);
var
   l:word;
   s:string;
begin
     s:=String(PathStr);
     l:=Length(S);
     if l>0 then
     begin
          if s[l]<>'\' then s:=s+'\';
     end;
     Project.Source:=s;
end;
function  Project_GetSource:MyString;
var
     s:array[0..255] of char;
begin
     StrPCopy(s,Project.Source);
     Result:=s;
end;
procedure Project_SetFormFile(filename:MyString);
begin
     Project.FormFile:=Project.PackFileName(FileName);
end;
function  Project_GetFormFile:MyString;
var
     s:array[0..255] of char;
     X:string;
begin
     x:=Project.UnPackFileName(Project.FormFile);
     StrPCopy(s,x);
     //TSH(Ошибка при работе с проектом) -->
     if ExtractFileName(s) <> '' then Result:=s
     else Result:='';
     //TSH(Ошибка при работе с проектом) <--
end;
procedure Project_Fortran_Add(filename:MyString);
begin
     Project.ProgramFiles.Add(Project.PackFileName(StrPas(FileName)));
end;
procedure Project_Fortran_Del(filename:MyString);
begin
     with Project.ProgramFiles do
     begin
          Delete(IndexOf(Project.PackFileName(StrPas(FileName))));
     end;
end;
function  Project_Fortran_Count:word;
begin
     Result:=Project.ProgramFiles.Count;
end;
procedure Project_Fortran_Set(Index:word;filename:MyString);
begin
     with Project.ProgramFiles do
     begin
          if Index<=Count then Strings[Index-1]:=Project.PackFileName(StrPas(FileName));
     end;
end;
function  Project_Fortran_Get(Index:word):MyString;
var
     s:array[0..255] of Char;
begin
     with Project.ProgramFiles do
     begin
          if Index<=Count then
          begin
               StrPCopy(s, Project.UnPackFileName(Strings[Index-1]));
               Result:=s;
          end
          else Result:=PChar('');
     end;
end;
procedure Project_Fortran_Clear;
begin
     Project.ProgramFiles.Clear;
end;
procedure Project_NotModified;
begin
     Project.fModified:=false;
end;
{***************************************************************************}
{*                           TProjectClass                                 *}
{***************************************************************************}
Function RemoveStr(s1,s2:String):String;
Var
     s3        : String;
     l1, l2, i : byte;
Begin
     l1:=Length(s1);
     l2:=Length(s2);
     If l2<l1 Then
     Begin
          s3:=s1;
          //l3:=Length(s3);
          SetLength(s3,l2);
          If String(StrLower(pchar(s3)))=String(StrLower(pchar(s2))) Then
          Begin
               For i:=l2+1 To l1 Do s1[i-l2]:=s1[i];
               SetLength(s1,l1-l2);
               Result:=s1;
          End
          Else Result:=s1
     End
     Else Result:=s1;
End;
constructor TProjectClass.Create;
begin
     ProgramFiles:=TStringList.Create;
     ProgramFiles.OnChange:=ListChange;
     //FormZones:=TZonesClass.Create;
end;
procedure TProjectClass.ListChange(Sender: TObject);
begin
     fModified:=true;
end;
procedure TProjectClass.SetFormFile(Value:String);
begin
     if fFormFile<>Value then
     begin
          fModified:=true;
          fFormFile:=Value;
     end;
end;
procedure TProjectClass.SetProjectPath(Value:String);
var
     i,l:integer;
begin
     if FProjectPath<>Value then
     begin
//          if Length(FProjectPath)=0 then FProjectPath:=GetCurrentDir;
          if Length(FProjectPath)=0 then FProjectPath:=Value;
          if (FProjectPath[Length(FProjectPath)]<>'\') then
                                         FProjectPath:=FProjectPath+'\';
          //ShowMessage('project path changed'+#13+'old "'+FProjectPath+'"'+#13+'new "'+Value+'"');
          with ProgramFiles do
          begin
               L:=Count-1;
               if L>0 then
               begin
                    //ShowMessage(ExpandFileName(UnPackFileName(Strings[0])));
                    for i:=0 to L do Strings[i]:=ExpandFileName(UnPackFileName(Strings[i]));
                    FormFile:=ExpandFileName(UnPackFileName(FormFile));
                    FProjectPath:=Value;
                    for i:=0 to L do Strings[i]:=PackFileName(Strings[i]);
                    FormFile:=PackFileName(FormFile);
               end;
          end;
     end;
end;
function  TProjectClass.PackFileName;
Var
   s1, s2 : String;
Begin
     if FileName='' then Result:='' else
     begin
          s1:=RemoveStr(FileName,Source);
          s2:=RemoveStr(s1,FProjectPath);
          If s1<>FileName Then Result:='*'+s1
          Else Result:=s2;
     end;
End;
function  TProjectClass.UnPackFileName;
Begin
     if FileName='' then Result:='' else
     begin
          If filename[1]='*' Then Result:=Source+RemoveStr(filename,'*')
          Else Begin
               If filename[2]=':' Then Result:=filename
               else
               begin
                    if (filename[1]='\') and (filename[2]='\') then Result:=filename
                    else Result:=FProjectPath+filename;
               end;
          End;
     End;
End;
procedure TProjectClass.New;
var
     s:string;
     SI:TIniFile;
     i, count : word;

     Registry:TRegistry; {kotov}
begin
     ProjectPath:='';
     ProjectName:='';
     SI:=TIniFile.Create(IniFile);
     { dll version ... kotov ->}
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;

     if Registry.OpenKey(StringReg, true) then
     begin
     if Registry.ReadBool('CalcModule') = true then
     begin
             s:=SI.ReadString('Default_dll', 'CountofFiles', 'ERROR');
             if s<>'ERROR' then
             begin
                  ProgramFiles.Clear;
                  count:=strtoint(s);
                  For i:=1 To count Do
                  begin
                       s:=SI.ReadString('Default_dll', 'file'+inttostr(i), 'ERROR');
                       if s<>'ERROR' then ProgramFiles.Add('*'+s);
                  End;
             End;
     end
     else
     begin
             s:=SI.ReadString('Default', 'CountofFiles', 'ERROR');
             if s<>'ERROR' then
             begin
                  ProgramFiles.Clear;
                  count:=strtoint(s);
                  For i:=1 To count Do
                  begin
                       s:=SI.ReadString('Default', 'file'+inttostr(i), 'ERROR');
                       if s<>'ERROR' then ProgramFiles.Add('*'+s);
                  End;
             End;
     end;
     end;
     {<-  dll version ... kotov}
     SI.Free;
     fModified:=false;
end;

Procedure TProjectClass.Save;
var
   Handle:TextFile;
   I : Word;
   Registry:TRegistry;    {dll version ... kotov}
begin
     Registry        :=TRegistry.Create;     {dll version ... kotov}
     Registry.RootKey:=HKEY_CURRENT_USER;    {dll version ... kotov}

     if (Length(FileName)>0) and (LowerCase(ExtractFileExt(FileName))='.spr') then
     begin
          ProjectPath:=ExtractFilePath(FileName);
          ProjectName:=ExtractFileName(FileName);
          Assign(Handle,FileName);
          Rewrite(Handle);
          {dll version ... kotov ->}
          if (Registry.OpenKey(StringReg, true)) and (Registry.ReadBool('CalcModule')) = true then
          writeln(Handle,InitSigmaProjectDll)
          else writeln(Handle,InitSigmaProject);
          {<- dll version ... kotov}
          if ProgramFiles.Count>0 then For i:=0 To ProgramFiles.Count-1 Do writeln(Handle,ProgramFiles.Strings[i])
          else showmessage('В проекте нет ни одного Фортрановского модуля!');                                       //[Имаметдинов]
          writeln(Handle,AdditionalFiles);
          writeln(Handle,FormFile);
          Close(Handle);
          fModified:=false;
     end;
end;
//Procedure TProjectClass.Load;
Procedure TProjectClass.Load (Filename:string);
     procedure CopyOldFile(s:String);
     var
          d:string;
          l:string;
          r,w: TextFile;
     begin
          d:=ChangeFileExt(s,'Win.for');
          if FileExists(ProjectPath+s) then
          begin
               AssignFile(r,ProjectPath+s);
               reset(r);
               AssignFile(w,ProjectPath+d);
               Rewrite(w);
               while not eof(r) do
               begin
                    Readln(r,l);
                    l:=Dos2Win(l);
                    Writeln(w,l);
               end;
               CloseFile(w);
               CloseFile(r);
          end;
     end;
var
   Handle:TextFile;
   s : string;
   ext: string;
   l:byte;
   OldProject:boolean;
   Registry:TRegistry;  {dll version ... kotov}
begin
     l:=Length(FileName);
     OldProject:=true;
     if l>4 then
     begin
          if (LowerCase(copy(FileName,l-2,3))='spr') then OldProject:=false; 

     end;
     Error:=0;
     If Not FileExists(FileName) Then
     Begin
          Error:=2;//file not found
     End
     Else Begin
          //New; //TSH(Ошибка при работе с проектом)
          ProjectPath:=ExtractFilePath(FileName);
          ProjectName:=ExtractFileName(FileName);

          //ProgramFiles.Clear;//                                                                     *****
          AssignFile(Handle,FileName);
          Reset(Handle);
          if OldProject then s:=InitSigmaProject
          else
          begin
               If Not EOF(Handle) Then Readln(Handle,s);
          end;

         {dll version ... kotov ->}
          Registry        :=TRegistry.Create;
          Registry.RootKey:=HKEY_CURRENT_USER;

          if (Registry.OpenKey(StringReg, true)) and (Registry.ReadBool('CalcModule')) = true then begin
           if s = InitSigmaProject then begin

           Registry.WriteBool ('CalcModule', False);                            // ставим признак унифицированного расчётного блока в реестре       [Имаметдинов]
           Project_SetSource(PChar(Registry.ReadString(SigmaSource)));          // меняем конфигурацию проекта на унифицированный                    [Имаметдинов]
//WriteFiles;
           //            showmessage('Проект создан для простого расчетного блока. Измените настройку в меню Сервис/Конфигурирование комплекса и откройте проект заново.');
 {           ProjectPath:='';
            FProjectPath:='';
            ProjectName:='';
            Project_NotModified;
            Project_Fortran_Clear;
            CloseFile(Handle);
            exit;  }
           end
          end
          else begin

           if s = InitSigmaProjectDll then begin   // проверям тип проекта(простой расчётный блок/унифицированный) и Конфигурирование комплекса

           Registry.WriteBool('CalcModule',True);                               // ставим признак унифицированного расчётного блока в реестре [Имаметдинов]
           Project_SetSource(PChar(Registry.ReadString(SigmaSourceDll)));       // меняем конфигурацию проекта на унифицированный  [Имаметдинов]

           //            showmessage('Проект создан для унифицированного расчетного блока. Измените настройку в меню Сервис/Конфигурирование комплекса и откройте проект заново.');
  {          ProjectPath:='';
            FProjectPath:='';
            ProjectName:='';
            Project_NotModified;
            Project_Fortran_Clear;
            CloseFile(Handle);
            exit;   }
           end
          end;
          If (s=InitSigmaProject) or (s = InitSigmaProjectDll) Then
          {<- dll version ... kotov}
          Begin
          ProgramFiles.Clear;
               While Not EOF(Handle) Do
               Begin
                    Readln(Handle,s);
                    If s<>'' Then
                    Begin
                         If s[1]<>'#' Then
                         Begin
                              if OldProject then
                              begin
                                   Ext:=LowerCase(s);
                                   l:=pos('\forfiles\',ext);
                                   if l<>0 then s:=''//'*'+copy(s,11,length(s)-10)
                                   else begin
                                        s:=ChangeFileExt(ProjectName,'')+'\'+ExtractFileName(s);
                                        CopyOldFile(s);
                                   end;
                              end;
                              if Length(s)>0 then
                              begin
                                   //showmessage(s);
                                   Ext:=LowerCase(ExtractFileExt(s));
                                   If Ext='.for' Then AddFile(s,OldProject);//showmessage(s);//ProgramFiles.Add(PackFileName(s));
                                   If Ext='.sfm' Then FormFile:=s;
                                   If Ext='.frm' Then FormFile:=ExtractFileName(s);//старый проект
                              end;
                         End;
                    End;
               End;
          End
          Else Error:=1;
          CloseFile(Handle);
          //If Error=0 Then FormZones.Load(UnPackFileName(FormFile));                         ****
          fModified:=OldProject;
     End;
end;
procedure TProjectClass.AddFile;
var
     inlower:string;
     s:string;
     i,c,Index:Integer;
     function OnlyFile(S:String):String;
     begin
          Result:=LowerCase(ExtractFileName(Str_Replace('*','',s)));
     end;
begin
     inlower:=OnlyFile(FileName);
     c:=ProgramFiles.Count;
     Index:=-1;
     if C>0 then
     begin
          for i:=0 to c-1 do
          begin
               s:=OnlyFile(ProgramFiles.Strings[i]);
               if s=inlower then Index:=i;
          end;
     end;
     if Index>=0 then
     begin
          if OldProject then FileName:=ChangeFileExt(FileName,'Win.for');
          ProgramFiles.Strings[Index]:=FileName;
     end else ProgramFiles.Add(FileName);
end;
Destructor  TProjectClass.Destroy;
begin
     ProgramFiles.Free;
end;
initialization
     if Project=nil then Project:=TProjectClass.Create;
finalization
     if Project<>nil then Project.Free;
end.
