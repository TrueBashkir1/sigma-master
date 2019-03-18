{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
Unit Mak_File;

Interface
Uses classes, Windows;
Var
     MainDirectory:string;
//Module:=GetPlugin(1);
Procedure Create_Mak_File(FileName,OutDir:String);
Procedure Create_Compile_Bat(FileName,OutDir:String);
Procedure Create_Data_Files(OutDir: String);//Module: HModule;
Procedure Create_Run_Bat(FileName,ProjectFile:String);
//Procedure Create_Fortran_Form(Module: HModule; FileName: String);
Implementation
Uses SysUtils, MainForm, TProject,Dialogs, Sets, Registry, Constants, strfunc;
type
     MyReal=real;
     TMainParams=Record
          TaskType      : byte;
          Variant       : byte;
          NRC           : Word;
          DB            : MyReal;
          DH            : MyReal;
          DR            : MyReal;
          DD            : MyReal;
          RSUMX         : MyReal;
          RSUMY         : MyReal;
          CountStress   : integer;
          CountFree     : integer;
          CountElements : integer;
          CountMaterial : integer;
          E             : MyReal;
          Mju           : MyReal;
          SB            : MyReal;
          L             : MyReal;
          INRG          : integer;
          INBP          : integer;
     End;
     TNode=Record
          Number : word;
          x,y    : MyReal;
     End;
function GetDOSFileName(FileName:string):string;
var
     buf:array[1..255] of char;
     count:word;
     s:string;
begin

//\\?\
//MAX_PATH
//GetShortPathNameW
     count:=GetShortPathName(PChar(FileName),@buf, SizeOf(buf));
     s:=Buf;
     SetLength(s,count);
     Result:=s;
end;
Function ChangeExt(FileName,ext:String):String;
Var
     name : String;
     i    : Integer;
Begin
     name:=ExtractFileName(FileName);
     i:=pos(ExtractFileExt(FileName),name);
     If i>0 Then SetLength(name,i-1);
     Result:=name+ext;
End;
function Project_Name:String;
var
   res    : String;
begin
     res:=ChangeExt(ExtractFileName(GetDOSFileName(ProjectFileName)),'.exe');
     Result:=copy(res,1,Length(res)-4);
end;
//создание файла последовательности компиляции проекта
Procedure Create_Mak_File;
Var
     Handle : TextFile;
     i      : integer;
     count  : word;
     s      : string;
     res    : String;
Begin
     res:=Project_Name;
     outdir:=GetDOSFileName(outdir);
     AssignFile(Handle,FileName);
     rewrite(Handle);
     writeln(Handle,'# Microsoft Developer Studio Generated NMAKE File, Format Version 4.00');
     writeln(Handle,'# ** DO NOT EDIT **');
     writeln(Handle,'');
     writeln(Handle,'# TARGTYPE "Win32 (x86) Console Application" 0x0103');
     writeln(Handle,'');
     writeln(Handle,'!IF "$(CFG)" == ""');
     writeln(Handle,'CFG='+res+' - Win32 Debug');
     writeln(Handle,'!MESSAGE No configuration specified.  Defaulting to '+res+' - Win32 Debug.');
     writeln(Handle,'!ENDIF ');
     writeln(Handle,'');
     writeln(Handle,'!IF "$(CFG)" != "'+res+' - Win32 Release" && "$(CFG)" != "'+res+' - Win32 Debug"');
     writeln(Handle,'!MESSAGE Invalid configuration "$(CFG)" specified.');
     writeln(Handle,'!MESSAGE You can specify a configuration when running NMAKE on this makefile');
     writeln(Handle,'!MESSAGE by defining the macro CFG on the command line.  For example:');
     writeln(Handle,'!MESSAGE ');
     writeln(Handle,'!MESSAGE NMAKE /f "'+res+'.mak" CFG="'+res+' - Win32 Debug"');
     writeln(Handle,'!MESSAGE ');
     writeln(Handle,'!MESSAGE Possible choices for configuration are:');
     writeln(Handle,'!MESSAGE ');
     writeln(Handle,'!MESSAGE "'+res+' - Win32 Release" (based on "Win32 (x86) Console Application")');
     writeln(Handle,'!MESSAGE "'+res+' - Win32 Debug" (based on "Win32 (x86) Console Application")');
     writeln(Handle,'!MESSAGE ');
     writeln(Handle,'!ERROR An invalid configuration is specified.');
     writeln(Handle,'!ENDIF ');
     writeln(Handle,'');
     writeln(Handle,'!IF "$(OS)" == "Windows_NT"');
     writeln(Handle,'NULL=');
     writeln(Handle,'!ELSE ');
     writeln(Handle,'NULL=nul');
     writeln(Handle,'!ENDIF ');
     writeln(Handle,'################################################################################');
     writeln(Handle,'# Begin Project');
     writeln(Handle,'F90=fl32.exe');
     writeln(Handle,'RSC=rc.exe');
     writeln(Handle,'');
     writeln(Handle,'!IF  "$(CFG)" == "'+res+' - Win32 Release"');
     writeln(Handle,'');
     writeln(Handle,'# PROP BASE Use_MFC 0');
     writeln(Handle,'# PROP BASE Use_Debug_Libraries 0');
     writeln(Handle,'# PROP BASE Output_Dir "Release"');
     writeln(Handle,'# PROP BASE Intermediate_Dir "Release"');
     writeln(Handle,'# PROP BASE Target_Dir ""');
     writeln(Handle,'# PROP Use_MFC 0');
     writeln(Handle,'# PROP Use_Debug_Libraries 0');
     writeln(Handle,'# PROP Output_Dir "Release"');
     writeln(Handle,'# PROP Intermediate_Dir "Release"');
     writeln(Handle,'# PROP Target_Dir ""');
     writeln(Handle,'OUTDIR=.\Release');
     writeln(Handle,'INTDIR=.\Release');
     writeln(Handle,'');
     writeln(Handle,'ALL : "$(OUTDIR)\'+res+'.exe"');
     writeln(Handle,'');
     writeln(Handle,'CLEAN : ');
     writeln(Handle,'	-@erase ".\Release\'+res+'.exe"');
     count:=Project_Fortran_Count;
     If count>0 Then
     Begin
          For i:=1 To Count Do writeln(Handle,'	-@erase ".\Release\'+
          ChangeExt(GetDOSFileName(Project_Fortran_Get(i)),'.obj')+'"');
     End;
     writeln(Handle,'');
     writeln(Handle,'"$(OUTDIR)" :');
     writeln(Handle,'    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"');
     writeln(Handle,'');
     writeln(Handle,'# ADD BASE F90 /Ox /I "Release/" /c /nologo');
     writeln(Handle,'# ADD F90 /Ox /I "Release/" /c /nologo');
     writeln(Handle,'F90_PROJ=/Ox /I "Release/" /c /nologo /Fo"Release/" ');
     writeln(Handle,'F90_OBJS=.\Release/');
     writeln(Handle,'# ADD BASE RSC /l 0x419 /d "NDEBUG"');
     writeln(Handle,'# ADD RSC /l 0x419 /d "NDEBUG"');
     writeln(Handle,'BSC32=bscmake.exe');
     writeln(Handle,'# ADD BASE BSC32 /nologo');
     writeln(Handle,'# ADD BSC32 /nologo');
     writeln(Handle,'BSC32_FLAGS=/nologo /o"$(OUTDIR)/'+res+'.bsc" ');
     writeln(Handle,'BSC32_SBRS=');
     writeln(Handle,'LINK32=link.exe');
     writeln(Handle,'# ADD BASE LINK32 kernel32.lib /nologo /subsystem:console /machine:I386');
     writeln(Handle,'# ADD LINK32 kernel32.lib /nologo /subsystem:console /machine:I386');
     writeln(Handle,'LINK32_FLAGS=kernel32.lib /nologo /subsystem:console /incremental:no\');
     writeln(Handle,' /pdb:"$(OUTDIR)/'+res+'.pdb" /machine:I386 /out:"$(OUTDIR)/'+res+'.exe" ');
     writeln(Handle,'LINK32_OBJS= \');
     If Count>0 Then
     Begin
          For i:=1 To Count Do
          If i=Count Then
               writeln(Handle,'	"$(INTDIR)/'+
               ChangeExt(GetDOSFileName(Project_Fortran_Get(i)),'.obj')+'"')
          Else
               writeln(Handle,'	"$(INTDIR)/'+
               ChangeExt(GetDOSFileName(Project_Fortran_Get(i)),'.obj')+'" \');
     End;
     writeln(Handle,'');
     writeln(Handle,'"$(OUTDIR)\'+res+'.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)');
     writeln(Handle,'    $(LINK32) @<<');
     writeln(Handle,'  $(LINK32_FLAGS) $(LINK32_OBJS)');
     writeln(Handle,'<<');
     writeln(Handle,'');
     writeln(Handle,'!ELSEIF  "$(CFG)" == "'+res+' - Win32 Debug"');
     writeln(Handle,'');
     writeln(Handle,'# PROP BASE Use_MFC 0');
     writeln(Handle,'# PROP BASE Use_Debug_Libraries 1');
     writeln(Handle,'# PROP BASE Output_Dir "'+outdir+'"');
     writeln(Handle,'# PROP BASE Intermediate_Dir "'+outdir+'"');
     writeln(Handle,'# PROP BASE Target_Dir ""');
     writeln(Handle,'# PROP Use_MFC 0');
     writeln(Handle,'# PROP Use_Debug_Libraries 1');
     writeln(Handle,'# PROP Output_Dir "'+outdir+'"');
     writeln(Handle,'# PROP Intermediate_Dir "'+outdir+'"');
     writeln(Handle,'# PROP Target_Dir ""');
     writeln(Handle,'OUTDIR='+outdir);
     writeln(Handle,'INTDIR='+outdir);
     writeln(Handle,'');
     writeln(Handle,'ALL : "$(OUTDIR)\'+res+'.exe"');
     writeln(Handle,'');
     writeln(Handle,'CLEAN : ');
     writeln(Handle,'	-@erase "'+outdir+'\'+res+'.exe"');
     If Count>0 Then
     Begin
          For i:=1 To Count Do writeln(Handle,'	-@erase "'+outdir+'\'+
          ChangeExt(GetDOSFileName(Project_Fortran_Get(i)),'.obj')+'"');
     End;
     writeln(Handle,'');
     writeln(Handle,'"$(OUTDIR)" :');
     writeln(Handle,'    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"');
     writeln(Handle,'');
     writeln(Handle,'# ADD BASE F90 /Zi /I "'+outdir+'/" /c /nologo');
     writeln(Handle,'# ADD F90 /Zi /I "'+outdir+'/" /c /nologo');
     writeln(Handle,'F90_PROJ=/Zi /I "'+outdir+'/" /c /nologo /Fo"'+outdir+'/" /Fd"'+outdir+'\'+res+'.pdb" ');
     writeln(Handle,'F90_OBJS='+outdir+'/');
     writeln(Handle,'# ADD BASE RSC /l 0x419 /d "_DEBUG"');
     writeln(Handle,'# ADD RSC /l 0x419 /d "_DEBUG"');
     writeln(Handle,'BSC32=bscmake.exe');
     writeln(Handle,'# ADD BASE BSC32 /nologo');
     writeln(Handle,'# ADD BSC32 /nologo');
     writeln(Handle,'BSC32_FLAGS=/nologo /o"$(OUTDIR)/'+res+'.bsc" ');
     writeln(Handle,'BSC32_SBRS=');
     writeln(Handle,'LINK32=link.exe');
     writeln(Handle,'# ADD BASE LINK32 kernel32.lib /nologo /subsystem:console /debug /machine:I386');
     writeln(Handle,'# ADD LINK32 kernel32.lib /nologo /subsystem:console /debug /machine:I386');
     writeln(Handle,'LINK32_FLAGS=kernel32.lib /nologo /subsystem:console /incremental:yes\');
     writeln(Handle,' /pdb:"$(OUTDIR)/'+res+'.pdb" /debug /machine:I386 /out:"$(OUTDIR)/'+res+'.exe" ');
     writeln(Handle,'LINK32_OBJS= \');
     If Count>0 Then
     Begin
          For i:=1 To Count Do
               If i=Count Then
                    writeln(Handle,'	"$(INTDIR)\'+
                    ChangeExt(GetDOSFileName(Project_Fortran_Get(i)),'.obj')+'"')
               Else
                    writeln(Handle,'	"$(INTDIR)\'+
                    ChangeExt(GetDOSFileName(Project_Fortran_Get(i)),'.obj')+'" \');
     End;
     writeln(Handle,'');
     writeln(Handle,'"$(OUTDIR)\'+res+'.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)');
     writeln(Handle,'    $(LINK32) @<<');
     writeln(Handle,'  $(LINK32_FLAGS) $(LINK32_OBJS)');
     writeln(Handle,'<<');
     writeln(Handle,'');
     writeln(Handle,'!ENDIF ');
     writeln(Handle,'');
     writeln(Handle,'.for{$(F90_OBJS)}.obj:');
     writeln(Handle,'   $(F90) $(F90_PROJ) $<  ');
     writeln(Handle,'');
     writeln(Handle,'.f{$(F90_OBJS)}.obj:');
     writeln(Handle,'   $(F90) $(F90_PROJ) $<  ');
     writeln(Handle,'');
     writeln(Handle,'.f90{$(F90_OBJS)}.obj:');
     writeln(Handle,'   $(F90) $(F90_PROJ) $<  ');
     writeln(Handle,'');
     writeln(Handle,'################################################################################');
     writeln(Handle,'# Begin Target');
     writeln(Handle,'');
     writeln(Handle,'# Name "'+res+' - Win32 Release"');
     writeln(Handle,'# Name "'+res+' - Win32 Debug"');
     writeln(Handle,'');
     writeln(Handle,'!IF  "$(CFG)" == "'+res+' - Win32 Release"');
     writeln(Handle,'');
     writeln(Handle,'!ELSEIF  "$(CFG)" == "'+res+' - Win32 Debug"');
     writeln(Handle,'');
     writeln(Handle,'!ENDIF ');
     writeln(Handle,'');
     If Count>0 Then
     Begin
          For i:=1 To Count Do
          Begin
               s:=GetDOSFileName(Project_Fortran_Get(i));
               writeln(Handle,'################################################################################');
               writeln(Handle,'# Begin Source File');
               writeln(Handle,'');
               writeln(Handle,'SOURCE="'+s+'"');
               writeln(Handle,'');
               writeln(Handle,'"$(INTDIR)\'+ChangeExt(s,'.obj')+'" : $(SOURCE) "$(INTDIR)"');
               writeln(Handle,'   $(F90) $(F90_PROJ) $(SOURCE)');
               writeln(Handle,'');
               writeln(Handle,'');
               writeln(Handle,'# End Source File');
          End;
     End;
     writeln(Handle,'# End Target');
     writeln(Handle,'# End Project');
     writeln(Handle,'################################################################################');
     closeFile(Handle);
End;
//создание бат-файла для компиляции проекта
Procedure Create_Compile_Bat;
Var
     Handle : TextFile;
     ButDir : String;
     Registry  : TRegistry;
     mak:string;
     ODir:String;

Begin
     mak:='"'+Win2Dos(GetDOSFileName(ChangeFileExt(ProjectFileName,'.mak')))+'"';
     ButDir:=Win2Dos(GetDOSFileName(ExtractFilePath(FileName)));
     SetLength(ButDir,Length(ButDir)-1);
     AssignFile(Handle,FileName);
     rewrite(Handle);
     writeln(Handle,'del '+ButDir+'\msdev\lib\'+'~errtmp');   {kotov}
     writeln(Handle,'set BIN='+ButDir+'\msdev\bin');
     writeln(Handle,'set LIB='+ButDir+'\msdev\lib');
     writeln(Handle,'set PATH='+ButDir+'\msdev\bin');
     //writeln(Handle,'copy ' + ExtractFilePath(ProjectFileName) + '*.for '  + OutDir);
     writeln(Handle,'nmake '+mak+' CFG="'+Win2Dos(Project_Name)+' - Win32 Debug" >~errtmp');
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg, true) then
     begin
          if Registry.ValueExists(DelMakReg) then
               if Registry.ReadBool(DelMakReg) then writeln(Handle,'del '+mak);
          if Registry.ValueExists(DelObjReg) then begin
               if Registry.ReadBool(DelObjReg) then begin
                  writeln(Handle,'del '+Win2Dos(GetDOSFileName(OutDir))+'\*.obj');
                  writeln(Handle,'del '+Win2Dos(GetDOSFileName(OutDir))+'\*.ilk');
                  writeln(Handle,'del '+Win2Dos(GetDOSFileName(OutDir))+'\*.pdb');
               end;
          End;
     End;
     Registry.Free;
     //WriteLn(Handle,'del '+Win2Dos(GetDOSFileName(ChangeFileExt(ProjectFileName,'.pdb'))));
     Writeln(Handle,'copy ' +'"'+OutDir+'\' + ChangeFileExt(ExtractFileName(ProjectFileName),'.exe')+'"' + ' ' + '"'+ChangeFileExt(ProjectFileName,'.exe')+'"');
     Writeln(Handle,'del '+Win2Dos(GetDOSFileName(FileName)));
     CloseFile(Handle);
End;
//создание файла параметров печати. Не создается если файл уже существует
Procedure Create_Print_File(FileName:String);
Var
     Handle : TextFile;
     i:integer;
Begin
     //If Not FileExists(FileName) Then
     //Begin
          AssignFile(Handle,FileName);
          Rewrite(Handle);
          writeln(Handle,'* Comment');
          for i:=1 to MsgCount do
          begin
               if SigmaIni.ReadString('FortranPrint',InttoStr(i),'NO')='YES' then Write(Handle,' YES')
               else Write(Handle,' NO ');
               Writeln(Handle,Format('   - (%2d) %s',[i,CheckHints[i]]));
               //CheckHints
          end;
          writeln(Handle,' END');
          writeln(Handle,'');
          close(Handle);
     //End;
End;

//бат файл для запуска расчета
Procedure Create_Run_Bat(FileName,ProjectFile:String);
Var
     Handle : TextFile;
     Registry  : TRegistry;
     res:String;
Begin
     AssignFile(Handle,FileName);
     rewrite(Handle);
     res:=Win2Dos(Project_Name);
     writeln(Handle,res+'.exe'+' <data> '+ChangeExt(ProjectFile,'.res'));
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg, true) then
     begin
          if Registry.ValueExists(DelTmpReg) then
               if Registry.ReadBool(DelTmpReg) then
               begin
                    Writeln(Handle,'del '+res+'.ilk');
                    Writeln(Handle,'del Printit.npf');
//  Writeln(Handle,'del data');  ** Файл нужен для работы экспорта в Nastran   
                    Writeln(Handle,'del form_xy');
                    Writeln(Handle,'del FORT.3');
                    //Writeln(Handle,'del '+res+'.pdb');
               end;
     End;
     Registry.Free;
     Writeln(Handle,'del '+Win2Dos(GetDOSFileName(FileName)));
     close(Handle);
End;


Procedure Create_Data_Files;
var
     Module:HModule;
     Create_Data_File:procedure (FileName:PChar);stdcall;
     Create_Fortran_Form:procedure (FileName:PChar);stdcall;
Begin
     Module:=GetPlugin(1);
     //ShowMessage(OutDir);
     //Form_Load(Project_GetFormFile);
     Create_Print_File(OutDir+'\Printit.npf');
     if (Module<>0) then
     begin
          Create_Data_File:=GetProcAddress(Module,'Create_Data_File');
          Create_Fortran_Form:=GetProcAddress(Module,'Create_Fortran_Form');
          if Assigned(Create_Data_File) then Create_Data_File(PChar(OutDir+'\data'));
          if Assigned(Create_Fortran_Form) then Create_Fortran_Form(PChar(OutDir+'\form_xy'));
     end;
End;
End.
