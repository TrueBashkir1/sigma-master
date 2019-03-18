unit TSigmaForm;
{$DEFINE MyDebugInfo}
{$UNDEF MyDebugInfo}
//function declaration
interface
const
     EpsilonVicinity = 10;
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
     TMainParamsMaterial=Record   // Добавление материалов (kotov)
          PRM1,PRM2,PRM3,PRM4,PRM5 : MyReal;  
          ORT4             : MyReal;
          ORT8,ORT9,ORT10  : MyReal;
          ORT11,ORT14      : MyReal;
          ORT15,ORT16,ORT17: MyReal;
          ORT18,ORT21      : MyReal;

     End;
//--------------------------------------
//     Musolov  1.01.2007
     TMain_Settings = Record
          opt_grid_calc : integer;
     End;
//--------------------------------------     
     TNode=Record
          Number : word;
          x,y    : MyReal;
     End;
     TArea=Record
          maxx : MyReal;
          maxy : MyReal;
          minx : MyReal;
          miny : MyReal;
     End;
     TZone = Array Of word;
     TMainParamsClass = Class
          private
               FMainParams : TMainParams;
               FMainParamsMaterial : TMainParamsMaterial;    // Добавление материалов (kotov)
               Procedure   SetMainParams(Value:TMainParams);
               Function    GetMainParams:TMainParams;
               Function    GetMainParamsMaterial:TMainParamsMaterial;   // Добавление материалов (kotov)
               Procedure   SetMainParamsMaterial(Value:TMainParamsMaterial);   // Добавление материалов (kotov)

          public
               FZonesClass : TObject;
               // Добавление материалов (kotov)
               Property    MainParamsMaterial:TMainParamsMaterial read GetMainParamsMaterial write SetMainParamsMaterial;
               Property    MainParams:TMainParams read GetMainParams write SetMainParams;
               Procedure   New;
               Procedure   Load(var Handle:File);
               Procedure   Save(var Handle:File);
     End;
//----------------------------------
//      Musolov (1.01.2007)
     TMain_Settings_Class = class
        private
                FMain_Settings : TMain_Settings;
                function Get_main_settings:TMain_Settings;
                procedure Set_main_settings(Settings:TMain_Settings);
        public
                property Main_Settings:TMain_Settings read Get_main_settings write Set_main_settings;
                procedure Load_Sets (var FileName:string);
                procedure Save_Sets (var FileName:String);
     end;
// --------------------------------
     TNodesClass = Class
          private
               FNodes      : Array Of TNode;
               FArea       : TArea;
               MaxNum      : word;
               Procedure   SetNode(Index: Integer;Value:TNode);
               Function    GetNode(Index: Integer):TNode;
               Procedure   CheckArea;
          public
               FZonesClass : TObject;
               Constructor Create;
               Function    AddNode(x,y:MyReal):word;
               Function    DeleteNode(Number:word):boolean;
               procedure   Clear;

               Property    Area:TArea read FArea;
               Function    CountOfNodes : word;
               Property    Nodes[Index: Integer]:TNode read GetNode write SetNode;
               Function    FindNode(x,y,Epsilon:MyReal):TNode;
               Function    FindIndex(Number:word):integer;
               procedure   Save(var Handle:File);
               procedure   Load(var Handle:File;CountNodes:word);
               Destructor  Destroy;override;
     End;
     TZonesClass = Class
          private
               FModified   : boolean;
               CurrentZone : word;
               CurrentNode : word;
               Current     : word; //Текущая зона
               FZones      : Array of TZone;
               FCountOfEdges:word;
               procedure   SetZone(Zone,Node: Integer;Value:word);
               Function    GetZone(Zone,Node: Integer):word;
               procedure   SetCountOfEdges(Value:word);
          public
               CountOfNodesInZone: word;
               MainParamsClass   : TMainParamsClass;
               FNodesClass : TNodesClass;
               Error       : integer;
               Constructor Create;
               property   CurreanOfZone: word read Current write Current;
               property    CountOfEdges:word read FCountOfEdges write SetCountOfEdges;
               Function    CountOfZones : word;
               Property    Zones[Zone,Node: Integer]:word read GetZone write SetZone;
               Property    Modified:boolean read FModified;
               Function    PushNode(x,y:MyReal):boolean;
               procedure   PopNode;
               procedure   DelAllZones;
               Procedure   AddZone;
               function    Finished:boolean;
               Procedure   RemoveZone;
               procedure   RefreshNumber;//Новая нумерация узлов
               Procedure   Clear;
               Procedure   OnLoad(var Handle:file);
               Procedure   Load(FileName:string);
               Procedure   OnSave(FileName:string);
               Procedure   Save(FileName:string);
               Destructor  Destroy;override;
     End;
// main_sets
procedure Set_Main_Sets(ms:TMain_Settings);stdcall;
function Get_Main_Sets:TMain_Settings;stdcall;
procedure Create_MS_Class;stdcall;

//mainparams
procedure SetMainParam(MainParams:TMainParams);stdcall;
function  GetMainParam:TMainParams;stdcall;

procedure SetMainParamMaterial(MainParamsMaterial:TMainParamsMaterial);stdcall;  // Добавление материалов (kotov)
function  GetMainParamMaterial:TMainParamsMaterial;stdcall; // Добавление материалов (kotov)
//form

function  Form_CountOfNodesInZone:word;stdcall;
function  Form_IsModified:Boolean;stdcall;
function  Form_GetNodeNumber(Zone,Node:word):word;stdcall;
//Получение номера текущей зоны
function  Form_GetCurreanZone:word;stdcall;
//Установка номера текущей зоны
function  Form_SetCurreanZone(Zone:word):word;stdcall;
//Меняет две зоны местами
procedure Form_SwapZone(OneZone:word; TwoZone: word);stdcall;
//Присвоение узлу LastNumber нового номера
procedure Form_SetNodeNumber(LastNumber:word;Number:word);stdcall;
function  Form_FindNode(x,y,Epsilon:MyReal):TNode;stdcall;
//Перенумерация узлов
procedure Form_NodeRefresh;stdcall;

procedure Form_SetZonePass(Zone:word);stdcall;

//b:::::::::::::::::::
function  Form_NodeValue(i:word):TNode;stdcall;
function  Form_GetNodeCount:word;stdcall;
function  GetDimension:string;stdcall;
function  GetDimFileName(f:string):string;stdcall;
Procedure Node_ReDimension(n:integer);stdcall;
function  GetCurDim:integer;stdcall;
procedure SetCurDim(value:integer);stdcall;
function  GetSila:integer;stdcall;
procedure SetSila(value:integer);stdcall;
//e:::::::::::::::::::
function  Form_GetNodeValue(Number:word):TNode;stdcall;
procedure Form_SetNodeValue(Number:word;x,y:MyReal);stdcall;
function  Form_GetArea:TArea;stdcall;
function  Form_PushNode(x,y:MyReal):boolean;stdcall;
procedure Form_PopNode;stdcall;
procedure Form_AddZone;stdcall;
function  Form_ZoneFinished:boolean;stdcall;
procedure Form_RemoveLastZone;stdcall;
procedure Form_Clear;stdcall;
procedure Form_Load(FileName:PChar);stdcall;
procedure Form_Save(FileName:PChar);stdcall;
function  Form_Modified:boolean;stdcall;


function GetDimensionName(Dim:integer):string;
function GetSilaName(Dim:integer):string;

Procedure Create_Data_File(FileName: PChar);stdcall;
Procedure Create_Fortran_Form(FileName:PChar);stdcall;
exports
     SetMainParam, GetMainParam, Form_CountOfNodesInZone, Form_SetCurreanZone,Form_GetCurreanZone,Form_IsModified,
     Form_GetNodeNumber, Form_FindNode, Form_GetNodeValue, Form_GetNodeCount, Form_SetNodeValue, 
     Form_GetArea, Form_PushNode, Form_PopNode, Form_NodeRefresh,Form_SwapZone,Form_AddZone, Form_ZoneFinished,
     Form_RemoveLastZone, Form_SetZonePass, Form_Clear, Form_Load, Form_Save, Form_Modified,
     Create_Data_File, Create_Fortran_Form,GetMainParamMaterial,SetMainParamMaterial,
     GetDimensionName,GetSilaName,Get_Main_Sets,Set_Main_Sets,Create_MS_Class;
implementation
uses Sysutils, strfunc, Dialogs, Math
{$IFDEF MyDebugInfo}
, log
{$ENDIF}
;
const
     InitSigmaForm   = 'Sigma Form';
     Version         : array[0..3] of Byte = (3,0,0,0);
     CountOfEdges    = 4;
var
     FormZones : TZonesClass;
     MS_class : Tmain_Settings_class;

//     Dimension : integer;
     Dimension : string;
     CurDim    : integer;
     Sila      : integer;

function GetDimensionName(Dim:integer):string;
begin
  case dim of
    0: result:='мм';
    1: result:='см';
    2: result:='дм';
    3: result:='м';
  end;
end;

function GetSilaName(Dim:integer):string;
begin
  case dim of
    0: result:='Ньютон';
    1: result:='Тонна';
    2: result:='Кг силы';
  end;
end;

//Solve Files
//фортрановский формат чисел
Function Fortran_Format(Const sFormat: String; Const Args: Array Of Const): String;
Var
     s : String;
     i : word;
Begin
     s:=format(sFormat,Args);
     Repeat
          i:=pos(',',s);
          If i<>0 Then s[i]:='.';
     Until i=0;
     Result:=s;
End;
//Начальные данные
Procedure Create_Data_File(FileName: PChar);
Var
     Handle : TextFile;
     MainParams:TMainParams;
     MainParamsMaterial:TMainParamsMaterial; // Добавление материалов (kotov)
     ms : TMain_Settings;
Begin
     MainParams:=GetMainParam;
     MainParamsMaterial:=GetMainParamMaterial; // Добавление материалов (kotov)
     ms:=Get_Main_Sets;
     AssignFile(Handle,String(FileName));
     Rewrite(Handle);
     writeln(Handle,'+++        +++++           +++');
     writeln(Handle,Fortran_Format('%-7d',[ms.opt_grid_calc])+' - GRID OPTIMIZATION');
     writeln(Handle,Fortran_Format('%-7d',[MainParams.TaskType])+'- NTIP (TASK TYPE)');
     writeln(Handle,Fortran_Format('%-7d',[MainParams.Variant])+'- NVAR (VARIANT)');
     writeln(Handle,Fortran_Format('%-7d',[MainParams.NRC])+'- NRC (DIVISION PARAMETER)');
     writeln(Handle,Fortran_Format('%-7f',[MainParams.DB])+'- DB (WIDTH)');
     writeln(Handle,Fortran_Format('%-7f',[MainParams.DH])+'- DH (HEIGHT)');
     writeln(Handle,Fortran_Format('%-10.7f',[MainParams.DR])+'- DR ');

     writeln(Handle,Fortran_Format('%-10.7f',[MainParams.DD])+'- DD (THICKNESS)');
     writeln(Handle,Fortran_Format('%-10.7f',[MainParams.RSUMY])+'- RSUMY ');
     writeln(Handle,Fortran_Format('%-10.7f',[MainParams.RSUMX])+'- RSUMX ');
     writeln(Handle,Fortran_Format('%-7d',[MainParams.CountStress])+'- NLD (NUMBER OF FORCE APPLIANCE)');
     writeln(Handle,Fortran_Format('%-7d',[MainParams.CountFree])+'- NDF (FREEDOM DEGREE)');
     writeln(Handle,Fortran_Format('%-7d',[MainParams.CountElements])+'- NCN (NUMBER OF NODES IN ELEMENT)');
     writeln(Handle,Fortran_Format('%-7d',[MainParams.CountMaterial])+'- NMAT (NUMBER OF MATERIALS)');
     writeln(Handle,Fortran_Format('%-7f',[MainParams.E])+'- E');
     writeln(Handle,Fortran_Format('%-7f',[MainParams.Mju])+'- My');
     writeln(Handle,Fortran_Format('%-7f',[MainParams.SB])+'- SB');
     writeln(Handle,Fortran_Format('%-7f',[MainParams.L])+'- L');
     writeln(Handle,Fortran_Format('%-7f',[MainParamsMaterial.ORT8])+'- ORT8'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-7f',[MainParamsMaterial.ORT9])+'- ORT9'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-7f',[MainParamsMaterial.ORT10])+'- ORT10'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-10.7f',[MainParamsMaterial.ORT14])+'- ORT14'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-7f',[MainParamsMaterial.ORT15])+'- ORT15'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-7f',[MainParamsMaterial.ORT16])+'- ORT16'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-7f',[MainParamsMaterial.ORT17])+'- ORT17'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-10.7f',[MainParamsMaterial.ORT21])+'- ORT21'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-10.7f',[MainParamsMaterial.PRM1])+'- PRM1'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-10.7f',[MainParamsMaterial.PRM2])+'- PRM2'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-10.7f',[MainParamsMaterial.PRM3])+'- PRM3'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-10.7f',[MainParamsMaterial.PRM4])+'- PRM4'); // Добавление материалов (kotov)
     writeln(Handle,Fortran_Format('%-10.7f',[MainParamsMaterial.PRM5])+'- PRM5'); // Добавление материалов (kotov)

     writeln(Handle,'P');
     writeln(Handle,'P');
     writeln(Handle,' N      Е     МЮ      SB        L*      A0      A1');
     writeln(Handle,' 1'+Fortran_Format('%9f%8f%7f%9f',[MainParams.E,MainParams.Mju,
          MainParams.SB,MainParams.L])+'     0.0     0.0');
     writeln(Handle,'+');
     writeln(Handle,'+');
     writeln(Handle,'+');
     CloseFile(Handle);
End;
Procedure Create_Fortran_Form(FileName:PChar);
Var
     INRG         : word;
     MainParams   :TMainParams;
     CountOfEdges :word;
     Function FindContiguity(zone,edge:word):integer;//zone
     Var
          i, j, z : word;
          res     : integer;
          z1, z2  : word;
     Begin
          res:=-1;
          For i:=0 To INRG-1 Do//перебор зон
          Begin
               If res=-1 Then
               Begin
                    If i<>Zone Then
                    Begin
                         For j:=0 To CountOfEdges-1 Do
                         Begin
                              If res=-1 Then
                              Begin
                                   res:=i;
                                   For z:=0 To MainParams.CountElements-1 Do
                                   Begin
                                        z1:=j*(MainParams.CountElements-1)+z;
                                        if z1>Form_CountOfNodesInZone-1 then z1:=0;
                                        z2:=edge*(MainParams.CountElements-1)+MainParams.CountElements-1-z;
                                        if z2>Form_CountOfNodesInZone-1 then z2:=0;
                                        if Form_GetNodeNumber(i,z1)<>Form_GetNodeNumber(zone,z2) then
                                        Begin
                                             res:=-1;
                                        End;
                                   End;
                              End;
                         End;
                    End;
               End;
          End;
          Result:=res;
     End;
Var
     gmp:function:TMainParams;stdcall;
     CountOfNodes : word;
     F            : TextFile;
     i, j         : word;
     OneNode      : TNode;
     con          : word;
Begin
     MainParams:=GetMainParam;
     CountOfNodes:=Form_CountOfNodesInZone;
     CountOfEdges:=round(CountOfNodes/(MainParams.CountElements-1));

     INRG:=MainParams.INRG;
     AssignFile(f,String(FileName));
     rewrite(f);
     WriteLn(f,Fortran_Format('%-4d',[MainParams.INRG]));
     WriteLn(f,Fortran_Format('%-4d',[MainParams.INBP]));
     If INRG>0 Then
     Begin
          For i:=0 To INRG-1 Do
          Begin
               For j:=0 To CountOfNodes-1 Do
               Begin
                    OneNode:=Form_GetNodeValue(Form_GetNodeNumber(i,j));
                    WriteLn(f,Fortran_Format('%-4d',[OneNode.Number]));
                    WriteLn(f,Fortran_Format('%-7f',[OneNode.x]));
                    WriteLn(f,Fortran_Format('%-7f',[OneNode.y]));
               End;
          End;
          For i:=0 To INRG-1 Do
          Begin
               For j:=0 To CountOfEdges-1 Do
               Begin
                    con:=FindContiguity(i,j)+1;
                    WriteLn(f,Fortran_Format('%-4d',[con]));
               End;
          End;
          WriteLn(f);
     End;
     CloseFile(f);
End;
//mainparams
procedure SetMainParam(MainParams:TMainParams);
begin
     FormZones.MainParamsClass.MainParams:=MainParams;
end;
function  GetMainParam:TMainParams;
begin
     Result:=FormZones.MainParamsClass.MainParams;
end;
// Добавление материалов (kotov)
procedure SetMainParamMaterial(MainParamsMaterial:TMainParamsMaterial);
begin
     FormZones.MainParamsClass.MainParamsMaterial:=MainParamsMaterial;
end;
function  GetMainParamMaterial:TMainParamsMaterial;
begin
     Result:=FormZones.MainParamsClass.MainParamsMaterial;
end;
//form
function  Form_CountOfNodesInZone:word;
begin
     Result:=FormZones.CountOfNodesInZone;
end;

function  Form_GetCurreanZone:word;
begin
  Result:=FormZones.Current;
end;

function  Form_SetCurreanZone(Zone:word):word;
begin
  result:=0;
  if Zone<=FormZones.CountOfZones then result:=Zone;
  FormZones.Current:=result;
end;

function  Form_IsModified:Boolean;
begin
     Result:=FormZones.Modified;
end;
function  Form_GetNodeNumber(Zone,Node:word):word;
begin
     Result:=FormZones.Zones[Zone,Node];
end;

//Добавил Серебряков Д.С.
//Меняет направление обхода в заданной зоне
procedure Form_SetZonePass(Zone:word);stdcall;
var
  one:word;
  i:integer;
begin
  for i:=1 to trunc(FormZones.CountOfNodesInZone/2)-1 do
  begin
    one:=FormZones.FZones[Zone][i];
    FormZones.FZones[Zone][i]:=FormZones.FZones[Zone][FormZones.CountOfNodesInZone-i];
    FormZones.FZones[Zone][FormZones.CountOfNodesInZone-i]:=one;
  end;
  FormZones.FModified:=true;
end;

//Добавил Серебряков Д.С.
//Меняет местами две зоны
procedure Form_SwapZone(OneZone:word; TwoZone: word);stdcall;
var
    Temp  : TZone;
begin
  Temp := FormZones.FZones[TwoZone];
  FormZones.FZones[TwoZone]:=FormZones.FZones[OneZone];
  FormZones.FZones[OneZone]:=Temp;
  SetLength(FormZones.FZones,FormZones.CountOfZones);
  FormZones.FModified:=true;
end;

//Добавил Серебряков Д.С.
//Задание узлам новых номеров, идущих по порядку от 1 до последнего номра узла (1,2...)
procedure Form_NodeRefresh;stdcall;
begin
  FormZones.RefreshNumber;
  FormZones.FModified:=true;
end;

//Добавил Серебряков Д.С.
//Возвращает количество узлов
function  Form_GetNodeCount:word;stdcall;
begin
  Result:=FormZones.FNodesClass.CountOfNodes;
end;

//Добавил Серебряков Д.С.
//Присвоение нового номера узлу
procedure Form_SetNodeNumber(LastNumber:word;Number:word);
var
   OneNode,n: TNode;
   i,j,num:integer;
   Zone,Node  : Word;
begin
    i:=0;
    j:=0;
    n.Number:=0;
    while (n.Number<>LastNumber) and (i<FormZones.CountOfZones)  do
    begin
      j:=0;
      while (n.Number<>LastNumber) and (j<Form_CountOfNodesInZone) do
      begin
        N:=Form_GetNodeValue(Form_GetNodeNumber(i,j));
        Inc(j);
      end;
      Inc(i);
    end;
    Zone:=i-1;
    Node:=j-1;
    OneNode:=Form_GetNodeValue(Form_GetNodeNumber(Zone,Node));
    Num:=OneNode.Number;
    OneNode.Number:=Number;
    with FormZones.FNodesClass do
    begin
      Nodes[FindIndex(Form_GetNodeNumber(Zone,Node))]:=OneNode;
      FormZones.FZones[Zone][Node]:=Number;
      For i:=0 To FormZones.CountOfZones-1 Do
        For j:=0 To Form_CountOfNodesInZone-1 Do
        Begin
          N:=Form_GetNodeValue(Form_GetNodeNumber(i,j));
          if n.Number=0 then
          begin
            Nodes[FindIndex(Form_GetNodeNumber(i,j))]:=OneNode;
            FormZones.FZones[i][j]:=Number;
          end;
        End;
    end;
  FormZones.FModified:=true;
end;

function  Form_FindNode(x,y,Epsilon:MyReal):TNode;
begin
     Result:=FormZones.FNodesClass.FindNode(x,y,Epsilon);
end;
//b::::::::::::::::::::::
// Функция получения информации об i-ом узле
function  Form_NodeValue(i:word):TNode;
begin
     Result:=FormZones.FNodesClass.Nodes[i];
end;

// Функция получения значения размерности
function GetDimension:string;
begin
     Result := Dimension;
end;

// Функция получения имени файла с размерностью
function getDimFileName(f:string):string;
var
     i : integer;
     s, s1 : string;
begin
     i := 0;
     s1 := f;
     while pos('.',s1) > 0 do
     begin
          i := i + pos('.',s1);
          delete(s1,1,pos('.',s1));
     end;
     s := copy(f,1,i-1);
     Result := s;
end;

// Процедура пересчета координат в зависимости от размерности
Procedure Node_ReDimension(n:integer);
Var
     NodesNum, i : word;
     Node        : TNode;
     MainParams  : TMainParams;
Begin
     MainParams := GetMainParam;
     NodesNum := FormZones.FNodesClass.CountOfNodes;
     Begin
          If MainParams.INRG>0 Then
          Begin
               For i:=0 To NodesNum-1 Do
               Begin
                    Node := FormZones.FNodesClass.Nodes[i];
                    Node.x := Node.x * IntPower(10,n);
                    Node.y := Node.y * IntPower(10,n);
                    FormZones.FNodesClass.SetNode(i,Node);
               End;
          End;
     End;
     FormZones.FModified:=false;
End;

//Для получения используемой силы
function GetSila:integer;
begin
     Result := Sila;
end;

//Установка используемой силы
procedure SetSila(value:integer);
begin
     Sila := value;
end;

// Функция получения значения текущей размерности
function GetCurDim;
begin
     Result := CurDim;
end;

// Процедура установки значения текущей размерности
procedure SetCurDim(value:integer);
begin
     CurDim := value;
end;
//e::::::::::::::::::::::

function  Form_GetNodeValue(Number:word):TNode;
begin
     with FormZones.FNodesClass do
     begin
          Result:=Nodes[FindIndex(Number)];
     end;
end;
procedure Form_SetNodeValue(Number:word;x,y:MyReal);
var
   N:TNode;
begin
     with FormZones.FNodesClass do
     begin
          N.Number:=Number;
          N.x:=x;
          N.y:=y;
          Nodes[FindIndex(Number)]:=N;
     end;
     FormZones.FModified:=true;
end;
function  Form_GetArea:TArea;
begin
     Result:=FormZones.FNodesClass.Area;
end;
function  Form_PushNode(x,y:MyReal):boolean;
begin
     Result:=FormZones.PushNode(x,y);
end;
procedure Form_PopNode;
begin
     FormZones.PopNode;
end;
procedure Form_AddZone;
begin
     FormZones.AddZone;
end;
function  Form_ZoneFinished:boolean;
begin
     Result:=FormZones.Finished;
end;
procedure Form_RemoveLastZone;
begin
     FormZones.RemoveZone;
end;
procedure Form_Clear;
begin
     FormZones.Clear;
end;
procedure Form_Save;
begin
     FormZones.Save(StrPas(FileName));
end;
procedure Form_Load;
begin
     FormZones.Load(StrPas(FileName));
     //if FormZones.Error<>0 then ShowMessage('Файл формы записан в неверном формате и не был открыт.');
end;
function Form_Modified:boolean;
begin
     Result:=FormZones.Modified;
end;
//-----------------------------------------------
// Musolov 1.01.2007
{***************************************************************************}
{*                        TMain_Settings_Class                             *}
{***************************************************************************}
// Читаем настройки из файла по дискриптору Handle
procedure TMain_Settings_Class.Load_Sets;
Var
     ms        : TMain_Settings;
     Num, size : integer;
     FHandle : file;
Begin
     if FileExists(Filename) then
     begin
          if (LowerCase(ExtractFileExt(FileName))='.sfm') then
          begin
               AssignFile(FHandle,FileName);
               reset(FHandle);
               size:=SizeOf(Main_Settings);
               num := 0;
               BlockRead(FHandle, ms, size, num);
               showmessage('$$$ ' + inttostr(Num));
               If Num<>size Then
                begin
                        Showmessage ('Ошибка !');
//               if FZonesClass<>nil then (FZonesClass as TZonesClass).Error:=4
//              Ошибка !!!
end;
//               end Else Main_Settings:=ms;
               CloseFile(FHandle);
               showmessage('File closed!')  ;
          end;
    end;      
end;
// Пишем настройки в файл по дискриптору
procedure TMain_Settings_Class.Save_Sets;
Var
     Num    : integer;
     FHandle : file;
Begin
     if FileExists(Filename) then
     begin
          if (LowerCase(ExtractFileExt(FileName))='.sfm') then
          begin
               AssignFile(FHandle,FileName);
               reset(FHandle);
               BlockWrite(FHandle, FMain_Settings, SizeOf(TMain_Settings), Num);
               CloseFile(FHandle);
          end;
     end;
//     if FZonesClass<>nil then (FZonesClass as TZonesClass).FModified:=false;
end;
procedure Create_MS_Class;
var
        ms : TMain_Settings;
begin

     if MS_Class = nil then begin
        ms.opt_grid_calc := 0;
        // Вызываем метод срздания класса настроек
        MS_Class:= TMain_Settings_Class.Create;
        MS_Class.Main_Settings := ms;
     end;
end;

procedure Set_Main_Sets (ms:Tmain_Settings);
begin
        MS_Class.Main_Settings := ms;
end;

function Get_Main_Sets;
begin
        Result := MS_Class.Main_Settings;
end;
// Реализация метода для записи/изменения свойства main_settings
procedure TMain_Settings_Class.Set_main_settings;
begin
     If not CompareMem(Addr(FMain_Settings),Addr(Settings),SizeOf(TMain_Settings)) Then
     Begin
        FMain_Settings := Settings;
     end;
end;
// Реализация метода для чтения свойства main_settings
Function Tmain_Settings_Class.Get_main_settings;
begin
        Result := FMain_Settings;
end;
//------------------------------------------------
{***************************************************************************}
{*                        TMainParamsClass                                 *}
{***************************************************************************}
Procedure TMainParamsClass.SetMainParams;
Begin
     If not CompareMem(Addr(FMainParams),Addr(Value),SizeOf(TMainParams)) Then
     Begin
          if FMainParams.CountElements<>Value.CountElements then
          Begin
               if FZonesClass<>nil then (FZonesClass as TZonesClass).Clear;
          end;
          FMainParams := Value;
          if FZonesClass<>nil then (FZonesClass as TZonesClass).FModified:=true;
     End;
End;
function TMainParamsClass.GetMainParams;
begin
     Result:=FMainParams;
end;
// Добавление материалов (kotov)
function TMainParamsClass.GetMainParamsMaterial;
begin
     Result:=FMainParamsMaterial;
end;
Procedure TMainParamsClass.SetMainParamsMaterial;
Begin
     If not CompareMem(Addr(FMainParamsMaterial),Addr(Value),SizeOf(TMainParamsMaterial)) Then
     Begin
          FMainParamsMaterial := Value;
     End;
End;
Procedure TMainParamsClass.New;
Begin
     With FMainParams Do
     Begin
          TaskType:=0;
          Variant:=0;
          NRC:=3;
          DB:=0;
          DH:=0;
          DR:=0;
          DD:=0;
          RSUMX:=0;
          RSUMY:=0;
          CountStress:=1;
          CountFree:=2;
          CountElements:=3;
          CountMaterial:=1;
          E:=0.72E07;
          Mju:=0.3;
          SB:=3200;
          L:=0.8;
          INRG:=0;
          INBP:=0;
     End;
          FMainParamsMaterial.ORT8:=0.72E07; // Добавление материалов (kotov)
          FMainParamsMaterial.ORT9:=0.3; // Добавление материалов (kotov)
          FMainParamsMaterial.ORT10:=3200; // Добавление материалов (kotov)
          FMainParamsMaterial.ORT14:=0; // Добавление материалов (kotov)

          FMainParamsMaterial.ORT15:=0.72E07; // Добавление материалов (kotov)
          FMainParamsMaterial.ORT16:=0.3; // Добавление материалов (kotov)
          FMainParamsMaterial.ORT17:=3200; // Добавление материалов (kotov)
          FMainParamsMaterial.ORT21:=0; // Добавление материалов (kotov)

          FMainParamsMaterial.PRM1:=0; // Добавление материалов (kotov)
          FMainParamsMaterial.PRM2:=0; // Добавление материалов (kotov)
          FMainParamsMaterial.PRM3:=0; // Добавление материалов (kotov)
          FMainParamsMaterial.PRM4:=0; // Добавление материалов (kotov)
          FMainParamsMaterial.PRM5:=0; // Добавление материалов (kotov)

End;
Procedure TMainParamsClass.Load;
Var
     mp        : TMainParams;
     mpm       : TMainParamsMaterial;
     Num, size : integer;
Begin
     size:=SizeOf(MainParams);
     BlockRead(Handle, MP, size, Num);
     If Num<>size Then
     begin
          if FZonesClass<>nil then (FZonesClass as TZonesClass).Error:=4
     end Else MainParams:=mp;

End;
Procedure TMainParamsClass.Save;
Var
     Num    : integer;
Begin
     //BlockWrite(Handle, InitSigmaParams, Length(InitSigmaParams), Num);
     //BlockWrite(Handle, Version, Length(Version), Num);
     BlockWrite(Handle, FMainParams, SizeOf(MainParams), Num);
     if FZonesClass<>nil then (FZonesClass as TZonesClass).FModified:=false;
End;
function Str_Replace(search,replace,S:String):String;
var
     p,l,sl:integer;
     z:string;
begin
     p:=Pos(search,s);
     sl:=Length(search);
     while (p>0) do
     begin
          l:=Length(s);
          s:=copy(s,1,p-1)+replace+copy(s,p+sl,l-sl);
          p:=Pos(search,s);
     end;
     Result:=s;
end;
{***************************************************************************}
{*                             TNodesClass                                 *}
{***************************************************************************}
Constructor TNodesClass.Create;
Begin
     SetLength(FNodes,0);
End;
Function TNodesClass.CountOfNodes;
Begin
     Result:=Length(FNodes);
End;
Procedure TNodesClass.CheckArea;
Var
     i : word;
     Node: TNode;
     MP:TMainParams;
Begin
     If CountOfNodes>0 Then
     Begin
          For i:=0 To CountOfNodes-1 Do
          Begin
               If i=0 Then
               Begin
                    Node:=Nodes[i];
                    FArea.maxx:=Node.x;
                    FArea.minx:=Node.x;
                    FArea.maxy:=Node.y;
                    FArea.miny:=Node.y;
               End
               Else Begin
                    Node:=Nodes[i];
                    If Node.x>FArea.maxx Then FArea.maxx:=Node.x;
                    If Node.x<FArea.minx Then FArea.minx:=Node.x;
                    If Node.y>FArea.maxy Then FArea.maxy:=Node.y;
                    If Node.y<FArea.miny Then FArea.miny:=Node.y;
               End;
          End;
     End;
     MP:=(FZonesClass as TZonesClass).MainParamsClass.GetMainParams;
     MP.DB:=FArea.maxx-FArea.minx;
     MP.DH:=FArea.maxy-FArea.miny;
     (FZonesClass as TZonesClass).MainParamsClass.SetMainParams(MP);
End;
Function TNodesClass.FindIndex;
Var
     i : word;
     r : integer;
     c : word;
Begin
     r:=-1;
     c:=CountOfNodes;
     If C>0 Then
     Begin
          For i:=0 To C-1 Do
          Begin
               if (Nodes[i].Number=Number) then r:=i;
          End;
     End;
     Result:=r;
End;
Procedure TNodesClass.SetNode;
Begin
     if FZonesClass<>nil then (FZonesClass as TZonesClass).Error:=0;
     If (Index<CountOfNodes) and (Index>=0) Then
     Begin
          FNodes[Index]:=Value;
          CheckArea;
          if FZonesClass<>nil then (FZonesClass as TZonesClass).FModified:=true;  
     End
     Else if FZonesClass<>nil then (FZonesClass as TZonesClass).Error:=1;
End;
Function TNodesClass.GetNode;
Var
     res : TNode;
Begin
     res.Number:=0;
     If (Index<CountOfNodes) and (Index>=0) Then
     Begin
          res:=FNodes[Index];
     End;
     Result:=res;
End;
Function TNodesClass.AddNode;
Var
     Node : TNode;
Begin
     Node:=FindNode(x,y,0);
     If Node.Number<>0 Then
     Begin
          Result:=Node.Number;
     End
     Else Begin
          Node.Number:=MaxNum+1;
          Node.x:=x;
          Node.y:=y;
          SetLength(FNodes,CountOfNodes+1);
          Nodes[CountOfNodes-1]:=Node;
          CheckArea;
          Result:=Node.Number;
     End;
End;
Function  TNodesClass.DeleteNode;
var
   Dels,Last:integer;
   r:boolean;
   mp:TMainParams;
begin
     r:=false;
     Last:=CountOfNodes-1;
     if Last>-1 then
     begin
          if Last=0 then
          begin
               SetLength(FNodes,0);
               CheckArea;
               r:=true;
          end else 
          begin
               Dels:=FindIndex(Number);
               if (Dels<>-1) then
               begin
                    FNodes[Dels]:=FNodes[Last];
                    SetLength(FNodes,Last);
                    mp:=(FZonesClass as TZonesClass).MainParamsClass.MainParams;
                    mp.INBP:=Last;
                    (FZonesClass as TZonesClass).MainParamsClass.MainParams:=mp;
                    CheckArea;
                    r:=true;
               end;
          end;
     end;
     Result:=r;
end;
procedure TNodesClass.Save;
Var
     i    : word;
     Num  : integer;
     node : TNode;
Begin
     If CountOfNodes>0 Then
     Begin
          For i:=0 To CountOfNodes-1 Do
          Begin
               node:=Nodes[i];
               BlockWrite(Handle, Node, SizeOf(Node), Num);
          End;
     End;
End;
procedure TNodesClass.Load;
Var
     i    : word;
     Num  : integer;
     node :TNode;
     size :word;
Begin
     Clear;
     SetLength(FNodes,CountNodes);
     If CountNodes>0 Then
     Begin
          size:=SizeOf(Node);
          For i:=0 To CountNodes-1 Do
          Begin
               BlockRead(Handle, Node, size, Num);
               if (size<>Num) then
               begin
                    Clear;
                    if FZonesClass<>nil then (FZonesClass as TZonesClass).Error:=4;
                    exit;
               end;
               FNodes[i]:=Node;
               Node:=FNodes[i];
          End;
     End;
     CheckArea;
End;
procedure TNodesClass.Clear;
begin
     SetLength(FNodes,0);
end;
Function TNodesClass.FindNode;
Var
     i        : word;
     res      : TNode;
     vec, Min : MyReal;
     Function Vector(px,py,x,y:MyReal):MyReal;
     Begin
          Result:=sqrt(sqr(px-x)+sqr(py-y));
     End;
Var
     Node : TNode;
Begin
     res.Number:=0;
     res.x:=0;
     res.y:=0;
     min:=Epsilon;
     MaxNum:=0;
     If CountOfNodes>0 Then
     Begin
          For i:=0 To CountOfNodes-1 Do
          Begin
               Node:=Nodes[i];
               if MaxNum<Node.Number then MaxNum:=Node.Number;
               vec:=Vector(Node.x,Node.y,x,y);
               If (vec<=min) Then
               Begin
                    min:=vec;
                    res:=Node;
               End;
          End;
     End;
     Result:=res;
End;

Destructor TNodesClass.Destroy;
begin
     SetLength(FNodes,0);
end;
{***************************************************************************}
{*                             TZonesClass                                 *}
{***************************************************************************}
constructor TZonesClass.Create;
begin
     FCountOfEdges:=4;
     FNodesClass:=TNodesClass.Create;
     FNodesClass.FZonesClass:=self;
     MainParamsClass:=TMainParamsClass.Create;
     MainParamsClass.FZonesClass:=self;
     MainParamsClass.New;
     CountOfNodesInZone:=(MainParamsClass.MainParams.CountElements-1)*CountOfEdges;
     SetLength(FZones,0);
end;
function TZonesClass.GetZone;
Var
     res : word;
     FormZone:TZone;
Begin
     SetLength(FormZone,0);
     res:=0;
     If (Zone<CountOfZones) and (Zone>=0) Then
     Begin
          FormZone:=FZones[Zone];
          if (Node<Length(FormZone)) and (Node>=0) then res:=FormZone[Node];
     End;
     Result:=res;
End;
procedure TZonesClass.SetZone;
Var
     FormZone:TZone;
Begin
     SetLength(FormZone,0);
     If (Zone<CountOfZones) and (Zone>=0) Then
     Begin
          FormZone:=FZones[Zone];
          if (Node<Length(FormZone)) and (Node>=0) then FZones[Zone][Node]:=Value;
     End;
End;
function TZonesClass.CountOfZones;
begin
     Result:=Length(FZones);
end;
Function TZonesClass.PushNode;
Var
     count   : word;
     i, Node : word;
     Find    : boolean;
     mp      : TMainParams;
Begin
     If CurrentZone>0 Then
     Begin
          Node:=FNodesClass.FindNode(X,Y,0).Number;
          If Node<>0 Then
          Begin
               Find:=false;
               For i:=0 To CountOfNodesInZone-1 Do If FZones[CurrentZone-1,i]=Node Then Find:=true;
          End
          Else Find:=false;
          If not Find Then
          Begin
               FZones[CurrentZone-1,CurrentNode-1]:=FNodesClass.AddNode(x,y);
               inc(CurrentNode);
               If CurrentNode>CountOfNodesInZone Then
               Begin
                    CurrentNode:=0;
                    CurrentZone:=0;
               End;
               count:=CountOfZones;
               mp:=MainParamsClass.MainParams;
               mp.INRG:=count;
               mp.INBP:=FNodesClass.CountOfNodes;
               MainParamsClass.MainParams:=mp;
               FModified:=true;
               Result:=true;
          End else Result:=False;
     End
     Else Result:=False;
End;
procedure TZonesClass.PopNode;
begin
     If (CurrentZone>0) and (CurrentNode>0) Then
     Begin
          FNodesClass.DeleteNode(FZones[CurrentZone-1,CurrentNode-1]);
          dec(CurrentNode);
     end;
end;

procedure TZonesClass.AddZone;
Var
     count, i : word;
     node_s   : TZone;
Begin
     //CountOfNodesInZone:=(MainParams.CountElements-1)*CountOfEdges;
     count:=CountOfZones;
     if CurrentNode=0 then
     Begin
          MainParamsClass.FMainParams.INRG:=count+1;
          SetLength(FZones,count+1);
          SetLength(node_s,CountOfNodesInZone);
          For i:=0 To CountOfNodesInZone-1 Do node_s[i]:=0;
          FZones[count]:=node_s;
          CurrentNode:=1;
          CurrentZone:=count+1;
          FModified:=true;
     End;
end;
function TZonesClass.Finished:boolean;
begin
     if CurrentNode<>0 then Result:=false else Result:=true;
end;

//Серебряков Д.С.
//Ничего умнее выдумать не смог...
procedure TZonesClass.RefreshNumber;
var
    i,j,k        : integer;
    OneNode      : TNode;
    MaxNumber    : word;
begin
  MaxNumber:=0;
  for i:=0 to Form_GetNodeCount-1 do
  begin
    if MaxNumber<Form_NodeValue(i).Number then MaxNumber:=Form_NodeValue(i).Number;
  end;

  MaxNumber:=MaxNumber+1;
  k:=MaxNumber;
  For i:=0 To FormZones.CountOfZones-1 Do
  Begin
    For j:=0 To FormZones.CountOfNodesInZone-1 Do
    Begin
      OneNode:=Form_GetNodeValue(Form_GetNodeNumber(i,j));
      if OneNode.Number<MaxNumber then
      begin
        Form_SetNodeNumber(OneNode.Number,k);
        inc(k);
      end;
    end;
  end;

  k:=1;
  For i:=0 To FormZones.CountOfZones-1 Do
  Begin
    For j:=0 To FormZones.CountOfNodesInZone-1 Do
    Begin
      OneNode:=Form_GetNodeValue(Form_GetNodeNumber(i,j));
      if OneNode.Number>=MaxNumber then
      begin
        Form_SetNodeNumber(OneNode.Number,k);
        inc(k);
      end;
    end;
  end;
  FModified:=true;
end;

procedure TZonesClass.RemoveZone;
Var
     Node_s       : TZone;
     r            : word;
     i, j         : word;
     count        : word;
     Function CheckNode(x:word):word;
     Var
          finded : word;
          I      : word;
     Begin
          finded:=0;
          For i:=0 To CountOfNodesInZone-1 Do
          begin
            If Node_s[i]=x Then Finded:=i+1;
          end;
          Result:=Finded;
     End;
Begin
     count:=CountOfZones;
     If count>0 Then
     Begin
          Node_s:=FZones[FormZones.current-1];
          If count>1 Then
          Begin
               for i:=FormZones.current-1 to count-2 do
               FZones[i]:=FZones[i+1];
               For i:=0 To count-2 Do
               Begin
                    For j:=0 To CountOfNodesInZone-1 Do
                    Begin
                         r:=CheckNode(Zones[i,j]);
                         If r>0 Then
                         Begin
                              Node_s[r-1]:=0;
                         End;
                    End; 
               End;
          End;
          //SetLength(FZones[Count-1],0);
          SetLength(FZones,count-1);
          For I:=0 To CountOfNodesInZone-1 Do If Node_s[i]<>0 Then FNodesClass.DeleteNode(Node_s[i]);
        //  RefreshNumber;
          FModified:=true;
          MainParamsClass.FMainParams.INRG:=count-1;
          CurrentNode:=0;
          CurrentZone:=0;
     End;
End;

Procedure TZonesClass.Clear;
Begin
     FNodesClass.Clear;
     MainParamsClass.New;
     CountOfNodesInZone:=(MainParamsClass.MainParams.CountElements-1)*CountOfEdges;
     DelAllZones;
End;
Procedure TZonesClass.DelAllZones;
Begin
     SetLength(FZones,0);
End;
procedure TZonesClass.SetCountOfEdges(Value:word);
begin
     FCountOfEdges:=Value;
end;
Procedure TZonesClass.Load;
     function toInt(s:string):Integer;
     var
          x:integer;
          e:integer;
     begin
          val(Trim(s),x,e);
          Result:=x;
     end;
     function toFloat(s:string):MyReal;
     var
          x:MyReal;
          e:integer;
     begin
          val(Trim(s),x,e);
          Result:=x;
     end;

var
     Handle     : TextFile;
     FHandle    : file;
//b::::::::::::::
     fhname     : TextFile;
     fname      : string;
//e::::::::::::::
     S          : string;
     MainParams : TMainParams;
     MainParamsMaterial : TMainParamsMaterial;   // Добавление материалов (kotov)

     procedure ReadMainParams;
     begin
          if eof(Handle) then exit;
          Readln(Handle,S);
          MainParams.TaskType:=toInt(copy(s, 1,11));
          MainParams.Variant:=toInt(copy(s,12,11));
          MainParams.NRC:=toInt(copy(s,23,11));
          MainParams.DB:=toFloat(copy(s,34,11));
          MainParams.DH:=toFloat(copy(s,45,11));
          if eof(Handle) then exit;
          Readln(Handle,S);
          MainParams.DR:=toFloat(copy(s, 1,11));
          MainParams.DD:=toFloat(copy(s,12,11));
          MainParams.RSUMX:=toFloat(copy(s,23,11));
          MainParams.RSUMY:=toFloat(copy(s,34,11));
          MainParams.CountStress:=toInt(copy(s,45,11));
          if eof(Handle) then exit;
          Readln(Handle,S);
          MainParams.CountFree:=toInt(copy(s, 1,11));
          MainParams.CountElements:=toInt(copy(s,12,11));
          MainParams.CountMaterial:=toInt(copy(s,23,11));
          MainParams.E:=toFloat(copy(s,34,11));
          MainParams.Mju:=toFloat(copy(s,45,11));
          if eof(Handle) then exit;
          Readln(Handle,S);
          MainParams.SB:=toFloat(copy(s, 1,11));
          MainParams.L:=toFloat(copy(s,12,11));
          MainParamsMaterial.ORT8:=toFloat(copy(s,23,11)); // Добавление материалов (kotov)
          MainParamsMaterial.ORT9:=toFloat(copy(s,34,11)); // Добавление материалов (kotov)
          if eof(Handle) then exit;
          Readln(Handle,S);
          MainParamsMaterial.ORT10:=toFloat(copy(s,1,11)); // Добавление материалов (kotov)
          MainParamsMaterial.ORT14:=toFloat(copy(s,12,11)); // Добавление материалов (kotov)
          MainParamsMaterial.ORT15:=toFloat(copy(s,23,11)); // Добавление материалов (kotov)
          MainParamsMaterial.ORT16:=toFloat(copy(s,34,11)); // Добавление материалов (kotov)
          if eof(Handle) then exit;
          Readln(Handle,S);
          MainParamsMaterial.ORT17:=toFloat(copy(s,1,11)); // Добавление материалов (kotov)
          MainParamsMaterial.ORT21:=toFloat(copy(s,12,11)); // Добавление материалов (kotov)
          MainParamsMaterial.PRM1:=toFloat(copy(s,23,11)); // Добавление материалов (kotov)
          MainParamsMaterial.PRM2:=toFloat(copy(s,34,11)); // Добавление материалов (kotov)
          MainParamsMaterial.PRM3:=toFloat(copy(s,45,11)); // Добавление материалов (kotov)

          MainParamsMaterial.PRM4:=toFloat(copy(s,56,11)); // Добавление материалов (kotov)
          MainParamsMaterial.PRM5:=toFloat(copy(s,67,11)); // Добавление материалов (kotov) 


          MainParams.INRG:=0;//toInt(copy(s,23,11));
          MainParams.INBP:=0;//toInt(copy(s,34,11));
     end;
     Procedure ReadZones;
     var
          X,Y:MyReal;
          err:integer;
     begin
          {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('Add new zone');{$ENDIF}
          AddZone;
          While not eof(Handle) do
          begin
               Readln(Handle,s);
               if s='#' then
               begin
                    {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('remove last zone');{$ENDIF}
                    RemoveZone;
                    exit;
               end;
               if Length(s)=0 then
               begin
                    {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('Add new zone');{$ENDIF}
                    AddZone;
               end else
               begin
                    X:=StrToMyReal(s,1,20,err);
                    if err=0 then Y:=StrToMyReal(s,21,20,err);
                    if err=0 then
                    begin
                         PushNode(X,Y);
                         {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('Add node ('+FloatToStr(X)+', '+FloatToStr(Y)+')');{$ENDIF}
                    end;
               end;
          end;
     end;
     {$IFDEF MyDebugInfo}
     procedure PrintMainParams();
     begin
          with logForm.Memo1.Lines do
          begin
               Add('TaskType = '+inttostr(MainParams.TaskType));
               Add('Variant = '+inttostr(MainParams.Variant));
               Add('NRC = '+inttostr(MainParams.NRC));
               Add('DB = '+floattostr(MainParams.DB));
               Add('DH = '+floattostr(MainParams.DH));
               Add('DR = '+floattostr(MainParams.DR));
               Add('DD = '+floattostr(MainParams.DD));
               Add('RSUMX = '+floattostr(MainParams.RSUMX));
               Add('RSUMY = '+floattostr(MainParams.RSUMY));
               Add('CountStress = '+inttostr(MainParams.CountStress));
               Add('CountFree = '+inttostr(MainParams.CountFree));
               Add('CountElements = '+inttostr(MainParams.CountElements));
               Add('CountMaterial = '+inttostr(MainParams.CountMaterial));
               Add('E = '+floattostr(MainParams.E));
               Add('Mju = '+floattostr(MainParams.Mju));
               Add('SB = '+floattostr(MainParams.SB));
               Add('L = '+floattostr(MainParams.L));
               Add('INRG = '+inttostr(MainParams.INRG));
               Add('INBP = '+inttostr(MainParams.INBP));
          end;
     end;
     {$ENDIF}
begin
     Clear;
     {$IFDEF MyDebugInfo}
          if logForm=nil then logForm:=TlogForm.Create(nil);
          logForm.show;
          logForm.Memo1.Lines.Clear;
          logForm.Memo1.Lines.Add('Opening form '+FileName);
     {$ENDIF}
     if FileExists(Filename) then
     begin
          {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('OK');{$ENDIF}
          if (LowerCase(ExtractFileExt(FileName))='.sfm') then
          begin
               AssignFile(FHandle,FileName);
               {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('opening as new sigma file format');{$ENDIF}
               OnLoad(FHandle);
               {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('OK');{$ENDIF}
               CloseFile(FHandle);
          end
          else begin
               {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('opening as old sigma file format');{$ENDIF}
               S:=ChangeFileExt(FileName,'.gen');
               //s:=Str_Replace('.frm','.gen',FileName);
               {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('open mainparams '+S);{$ENDIF}
               if FileExists(s) then
               begin
                    {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('OK');{$ENDIF}
                    Error:=3;
                    AssignFile(Handle,s);
                    reset(Handle);
                    {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('Reading Mainparams');{$ENDIF}
                    ReadMainParams;
                    {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('OK');{$ENDIF}
                    CloseFile(Handle);
                    MainParamsClass.MainParams:=MainParams;
                    {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('opening zones file '+FileName);{$ENDIF}
                    AssignFile(Handle,FileName);
                    reset(Handle);
                    {$IFDEF MyDebugInfo}logForm.Memo1.Lines.Add('Reading Zones');{$ENDIF}
                    ReadZones;
                    {$IFDEF MyDebugInfo}
                         logForm.Memo1.Lines.Add('OK');
                         MainParams:=MainParamsClass.MainParams;
                         PrintMainParams;
                    {$ENDIF}
                    CloseFile(Handle);
                    Error:=0;
               end;
          end;
     end;
//b:::::::::::::::
// Считывание размерности из файла
     fname := getDimFileName(FileName) + '.sdm';
     if FileExists(fname) then
     begin
          AssignFile(fhname,fname);
          Reset(fhname);
          ReadLn(fhname,Dimension);
          if not eof(fhname) then ReadLn(fhname,S) else S:='0';
          CloseFile(fhname);
     end
     else
     begin
          Dimension := '1';
          S:='0';
     end;
// Установка считанного значения размерности
     CurDim := StrToInt(Dimension);
     Sila   := StrToInt(S);
//e:::::::::::::::
     FModified:=false;
end;
Procedure TZonesClass.OnLoad;
var
     onezone    : TZone;
     num        : Integer;
     count,Size : word;
     i,j,z      : word;
     Vers       : array[0..3] of byte;
     Buf1       : Array[1..Length(InitSigmaForm)] Of Char;
     Buf2       : Array[1..Length(Version)] Of Char;
     MPM        : TMainParamsMaterial;      // Добавление материалов (kotov)
Begin
          FModified:=false;
          Error:=0;
          {$I-}
          Reset(Handle, 1);
          if IOResult<>0 then
          Begin
               Error:=1;
               exit;
          End;
          {$I+}
          BlockRead(Handle, Buf1, Length(InitSigmaForm), Num);
          If String(Buf1)<>InitSigmaForm Then
          Begin
               Error:=1;
               exit;
          End;
          BlockRead(Handle, Vers, Length(Vers), Num);
          if (Vers[0]<>Version[0]) or (Vers[1]<>Version[1]) then
          Begin
               Error:=2;
               exit;
          End;
          //BlockRead(Handle, Buf1, 7, Num);
          BlockRead(Handle, z, SizeOf(z), Num);
          If z<>SizeOf(MyReal) Then
          Begin
               Error:=3;
               exit;
          End;
          MainParamsClass.Load(Handle);
          if Error<>0 then exit;
          FNodesClass.Load(Handle,MainParamsClass.FMainParams.INBP);
          if Error<>0 then exit;
          count:=MainParamsClass.FMainParams.INRG;
          CountOfNodesInZone:=(MainParamsClass.MainParams.CountElements-1)*CountOfEdges;
          SetLength(FZones,Count);
          If count>0 Then
          Begin
               CurrentNode:=0;
               Size:=SizeOf(z);
               For i:=0 To count-1 Do
               Begin
                    SetLength(onezone,CountOfNodesInZone);
                    For j:=0 To CountOfNodesInZone-1 Do
                    Begin
                         BlockRead(Handle, z, Size, Num);
                         if Size<>Num then
                         begin
                              DelAllZones;
                              Error:=4;
                              Exit;
                         end else onezone[j]:=z;
                    End;
                    FZones[i]:=onezone;
               End;
          End;
          FModified:=false;

// Добавление материалов (kotov)
     BlockRead(Handle, MPM, SizeOf(MainParamsClass.MainParamsMaterial), Num);
     If Num=SizeOf(MainParamsClass.MainParamsMaterial) Then MainParamsClass.fMainParamsMaterial:=mpm;

End;
Procedure TZonesClass.Save;
begin
     OnSave(FileName);
end;
Procedure TZonesClass.OnSave;
var
   Handle      : file;
   num         : Integer;
   count,i,j,z : word;
   mp          : TMainParams;
Begin
     If FileName<>'' Then
     Begin
          AssignFile(Handle,FileName);
          Rewrite(Handle, 1);
          BlockWrite(Handle, InitSigmaForm, Length(InitSigmaForm), Num);
          BlockWrite(Handle, Version, Length(Version), Num);
          z:=SizeOf(MyReal);
          BlockWrite(Handle, z, SizeOf(z), Num);
          count:=CountOfZones;
          mp:=MainParamsClass.MainParams;
          mp.INRG:=count;
          mp.INBP:=FNodesClass.CountOfNodes;
          MainParamsClass.MainParams:=mp;
          MainParamsClass.Save(Handle);
          FNodesClass.Save(Handle);
          If count>0 Then
          Begin
               For i:=0 To count-1 Do
               Begin
                    For j:=0 To CountOfNodesInZone-1 Do
                    Begin
                         z:=Zones[i,j];
                         BlockWrite(Handle, z, SizeOf(z), Num);
                    End;
               End;
          End;
// Добавление материалов (kotov)
         num:=0;
         BlockWrite(Handle, MainParamsClass.FMainParamsMaterial, SizeOf(MainParamsClass.MainParamsMaterial), Num);

          CloseFile(Handle);
          FModified:=false;
          SetCurDim(GetCurDim);
     End;
End;
Destructor TZonesClass.Destroy;
Begin
     MainParamsClass.Free;
     FNodesClass.Free;
     SetLength(FZones,0);
End;

initialization
     if FormZones=nil then FormZones:=TZonesClass.Create;
     FormZones.CountOfNodesInZone:=8;
//--------------------------
// Musolov
// 1.01.2007
     Create_MS_Class;
//--------------------------
finalization
     if FormZones<>nil then FormZones.Free;
     if MS_Class<>nil then MS_Class.Free;
end.
