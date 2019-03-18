// Export to Ansys (Written by: Shevchenko T.L., 26.11.2005) -->
library ExportAnsys;

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,ResultsArrays,MainInterface,inifiles,Ansys;

{$E plg}                  

const
     PluginName = 'Экспорт в Ansys';

var
     Button,Menu:Pointer;     

procedure StartExport;stdcall;
var
     exp,path,res:string;
     Handle:TextFile;
     Formated:string;
     time:SystemTime;
begin
     res:=String(GetProject_FileName);

     exp:=ChangeFileExt(res,'.cdb');
     path:=ExtractFilePath(res);

     AssignFile(Handle,exp);
     Rewrite(Handle);
     Nodes_Result:=TNodes.Create;
     Nodes_Result.LoadNodes(path+'RESULT1.BIN');
     Elements_Result:=TElements.Create;
     Elements_Result.LoadElements(path+'RESULT2.BIN');

     NAddNodesToElements();

     IF Nodes_Result.Error<>0 THEN
        begin
        MessageDlg('При считывании данных произошла ошибка!', mtError,[mbYes],0);
       EXIT;
        end;

// Write to file *.cdb ----->

// ----- Write title ----->
     GetLocalTime(time);
     Formated:=Format('%02d:%02d:%02d    %02d/%02d/%04d',
                        [time.wHour, time.wMinute, time.wSecond, time.wDay, time.wMonth, time.wYear]);
     Writeln(Handle, '/COM,ANSYS RELEASE  7.0    UP20021010       '+ Formated);
     Writeln(Handle, '/PREP7');
     Writeln(Handle, '/NOPR');
     Writeln(Handle, '/TITLE,');
     Writeln(Handle, '*IF,_CDRDOFF,EQ,1,THEN     !if solid model was read in');
     Writeln(Handle, '_CDRDOFF=             !reset flag, numoffs already performed');
     Writeln(Handle, '*ELSE              !offset database for the following FE model');
     Writeln(Handle, 'NUMOFF,NODE,'+ Format('%8d',[Nodes_Result.CountOfNodes]));
     Writeln(Handle, 'NUMOFF,ELEM,'+ Format('%8d',[Elements_Result.CountOfElements]));
     Writeln(Handle, 'NUMOFF,MAT ,       1');
     Writeln(Handle, 'NUMOFF,REAL,       1');
     Writeln(Handle, 'NUMOFF,TYPE,       1');
     Writeln(Handle, '*ENDIF');
     Writeln(Handle, '*SET,_BUTTON ,  0.000000000000');
     Writeln(Handle, '*SET,_CHKMSH ,  0.000000000000');
     Writeln(Handle, '*SET,_ET_NEXT,  2.000000000000');
     Writeln(Handle, '*SET,_ET_TYPE,  1.000000000000');
     Writeln(Handle, '*SET,_GUI_CLR_BG,'' systemButtonFace               ''');
     Writeln(Handle, '*SET,_GUI_CLR_FG,'' systemButtonText               ''');
     Writeln(Handle, '*SET,_GUI_CLR_INFOBG,'' systemInfoBackground           ''');
     Writeln(Handle, '*SET,_GUI_CLR_SEL,'' systemHighlight                ''');
     Writeln(Handle, '*SET,_GUI_CLR_SELBG,'' systemHighlight                ''');
     Writeln(Handle, '*SET,_GUI_CLR_SELFG,'' systemHighlightText            ''');
     Writeln(Handle, '*SET,_GUI_CLR_WIN,'' systemWindow                   ''');
     Writeln(Handle, '*SET,_GUI_FNT_FMLY,''Tahoma                          ''');
     Writeln(Handle, '*SET,_GUI_FNT_PXLS,  11.00000000000    ');
     Writeln(Handle, '*SET,_GUI_FNT_SLNT,''r                               ''');
     Writeln(Handle, '*SET,_GUI_FNT_WEGT,''medium                          ''');
     Writeln(Handle, '*SET,_RC_SET ,  1.000000000000    ');
     Writeln(Handle, '*SET,_RETURN ,  0.000000000000    ');
     Writeln(Handle, '*SET,_STATUS ,  0.000000000000    ');
     Writeln(Handle, '*SET,_TOPLEVEL_WIN,''001101CE                        ''');
     Writeln(Handle, '*SET,_UIQR   ,  0.000000000000    ');
     Writeln(Handle, '*SET,_ZX     ,''                                ''');
     Writeln(Handle, 'ET,       1,  2');
     Writeln(Handle, 'KEYOP,   1, 3,        3');
     Writeln(Handle, 'RLBLOCK,       1,       1,       6,       7');
     Writeln(Handle, '(2i8,6g16.9)');
     Writeln(Handle, '(7g16.9)');
     Writeln(Handle, NWidthFormat(path+'data'));
     Writeln(Handle, 'NBLOCK,6,SOLID');
     Writeln(Handle, '(3i8,6e16.9)');
// ----- Write title -----<
// ----- Write body ------>
// -- description of nodes from first (1) to N (theirs coordinates) -->
     NNodes(Handle);
// -- description of nodes from first (1) to N (theirs coordinates) --<

     Writeln(Handle, 'N,R5.3,LOC,     -1,');
     Writeln(Handle, 'EBLOCK,19,SOLID,'+ Format('%8d',[Elements_Result.CountOfElements]));
     Writeln(Handle, '(19i8)');

// -- description of elements from first (1) to N (nodes marking them) -->
     NElements(Handle);
// -- description of elements from first (1) to N (nodes marking them) --<

     Writeln(Handle, '      -1');
     Writeln(Handle, 'MPTEMP,R5.0, 1, 1,  0.00000000    ,');
     Writeln(Handle, NModuleEFormat(path+'data'));           // module of elasticity
     Writeln(Handle, 'MPTEMP,R5.0, 1, 1,  0.00000000    ,');
     Writeln(Handle, NPuassonFormat(path+'data'));           // coefficient of Puasson
     Writeln(Handle, 'EXTOPT,ATTR,  0,  0,  0');
     Writeln(Handle, 'EXTOPT,ESIZE,  0,  0.0000');
     Writeln(Handle, 'EXTOPT,ACLEAR,  0');
     Writeln(Handle, 'BFUNIF,TEMP,_TINY');
     Writeln(Handle, ''); // empty string
     Writeln(Handle, 'KUSE,     0');
     Writeln(Handle, 'TIME,  0.00000000');
     Writeln(Handle, 'TREF,  0.00000000');
     Writeln(Handle, 'ALPHAD,  0.00000000');
     Writeln(Handle, 'BETAD,  0.00000000');
     Writeln(Handle, 'DMPRAT,  0.00000000');
     Writeln(Handle, '');  // empty string
     Writeln(Handle, '');  // empty string
     Writeln(Handle, '');  // empty string
     Writeln(Handle, '');  // empty string
     Writeln(Handle, '');  // empty string
     Writeln(Handle, 'CRPLIM, 0.100000000    ,   0');
     Writeln(Handle, 'CRPLIM,  0.00000000    ,   1');
     Writeln(Handle, 'NCNV,     1,  0.00000000    ,     0,  0.00000000    ,  0.00000000');
     Writeln(Handle, '');  // empty string
     Writeln(Handle, 'NEQIT,     0');
     Writeln(Handle, '');  // empty string
     Writeln(Handle, 'ERESX,DEFA');
     Writeln(Handle, 'ACEL,  0.00000000    ,  0.00000000    ,  0.00000000');
     Writeln(Handle, 'OMEGA,  0.00000000    ,  0.00000000    ,  0.00000000    ,     0');
     Writeln(Handle, 'DOMEGA,  0.00000000    ,  0.00000000    ,  0.00000000');
     Writeln(Handle, 'CGLOC,  0.00000000    ,  0.00000000    ,  0.00000000');
     Writeln(Handle, 'CGOMEGA,  0.00000000    ,  0.00000000    ,  0.00000000');
     Writeln(Handle, 'DCGOMG,  0.00000000    ,  0.00000000    ,  0.00000000');
     Writeln(Handle, 'IRLF,  0');
     Writeln(Handle, '');  // empty string
     
// -- loads -->
     NBounds(Handle);
// -- loads --<
// -- forces -->
     NForces(Handle);
// -- forces --<
// ----- Write body ------<
     Writeln(Handle, '/GO');
     Writeln(Handle, 'FINISH');
// Write to file *.cdb -----<

     CloseFile(Handle);
     showmessage('В директории текущего проекта создан файл '+ExtractFileName(exp));

end;

procedure InitializeDLL(Plugin:HModule;Handle:THandle);stdcall;
begin
     Menu:=RegisterMenu(Plugin,PChar(PluginName),112,5,PChar('StartExport'));
     Button:=RegisterToolButton(Plugin,PChar(PluginName),112,PChar('Экспорт'),PChar('StartExport'));
     RegisterPlugin(Plugin,3);
end;

procedure FinalizeDLL;stdcall;
begin
     //Application:=OldApplication;
end;

function GetPluginName:PChar;stdcall;
begin
     Result:=PChar(PluginName);
end;

function Can_Close:boolean;stdcall;
begin
     Result:=true;
end;

procedure CheckState;stdcall;
begin
     if FileExists(ExtractFilePath(String(GetProject_FileName))+'RESULT1.BIN') then
     begin
          SetMenuStatus(menu,True);
          SetToolButtonStatus(Button,True);
     end
     else begin
          SetMenuStatus(menu,False);
          SetToolButtonStatus(Button,False);
     end;
end;

exports InitializeDLL,FinalizeDLL,StartExport,GetPluginName,Can_Close,CheckState;
end.

// Export to Ansys (Written by: Shevchenko T.L., 26.11.2005) <--
