unit MainInterface;

interface
uses Windows,Graphics;
const
     Sigma32_exe='Sigma32.exe';
     StringReg = '\Software\MAI.609\SIGMA32\3.0';
     Plugin_Edit_Form=1;
     Plugin_Edit_Fortran=2;
type
     MyString=PChar;
//Функции общего назначения

function RegisterImage(Plugin:HModule;Name:PChar;Color:TColor):Integer;stdcall; external Sigma32_exe;
function RegisterMenu(Plugin:HModule;Caption:PChar;BitMap,main:integer;OnClick:PChar):Pointer;stdcall; external Sigma32_exe;
function RegisterToolButton(Plugin:HModule;Caption:PChar;BitMap:integer;ToolBar,OnClick:PChar):Pointer;stdcall; external Sigma32_exe;
procedure SetToolButtonStatus(Button:Pointer;Enable:boolean);stdcall; external Sigma32_exe;
procedure SetMenuStatus(menu:Pointer;Enable:boolean);stdcall; external Sigma32_exe;
procedure RegisterPlugin(Plugin:HModule;PluginType:integer);stdcall; external Sigma32_exe;
function GetPlugin(PluginType:integer):HModule;stdcall; external Sigma32_exe;

//Функуции связнные с пректом
function GetProject_FileName:PChar;stdcall; external Sigma32_exe;
procedure Project_New;stdcall; external Sigma32_exe;
procedure Project_Open(filename:MyString);stdcall; external Sigma32_exe;
procedure Project_Save(filename:MyString);stdcall; external Sigma32_exe;
function  Project_PackFileName(filename:MyString):MyString;stdcall; external Sigma32_exe;
function  Project_UnPackFileName(filename:MyString):MyString;stdcall; external Sigma32_exe;
function  Project_IsModified:boolean;stdcall; external Sigma32_exe;
function  Project_Error:word;stdcall; external Sigma32_exe;
procedure Project_SetSource(PathStr:MyString);stdcall; external Sigma32_exe;
function  Project_GetSource:MyString;stdcall; external Sigma32_exe;
procedure Project_SetFormFile(filename:MyString);stdcall; external Sigma32_exe;
function  Project_GetFormFile:MyString;stdcall; external Sigma32_exe;
procedure Project_Fortran_Add(filename:MyString);stdcall; external Sigma32_exe;
procedure Project_Fortran_Del(filename:MyString);stdcall; external Sigma32_exe;
function  Project_Fortran_Count:word;stdcall; external Sigma32_exe;
procedure Project_Fortran_Set(Index:word;filename:MyString);stdcall; external Sigma32_exe;
function  Project_Fortran_Get(Index:word):MyString;stdcall; external Sigma32_exe;
procedure Project_Fortran_Clear;stdcall; external Sigma32_exe;
procedure CheckState;stdcall; external Sigma32_exe;
implementation
end.











