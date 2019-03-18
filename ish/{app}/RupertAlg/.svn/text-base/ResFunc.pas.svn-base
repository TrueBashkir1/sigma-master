{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                         Боков Петр Юрьевич 2008                     }
{                                                                     }
{*********************************************************************}
Unit ResFunc;
INTERFACE
Type
// Запись для хранения элементов на границе
     TNodeInF = Record
            ZoneNum: integer;
            Blocked: Boolean; // блокированный на границе True
              InOut: Boolean; // узел является внешним 1 (True)
                X,Y: Real;    // координаты проекции узла на границу (перпендикуляром к прямой)
     end;
     TMyNode = Record
             Number: Integer;
                X,Y: Real;
              SeNum: Integer;
                inf: TNodeInF;
     end;
     TMyElement = Record
               Number : INTEGER;
    Node1,Node2,Node3 : INTEGER;
             Material : Integer;
     End;
     MainParams = Record
                  NRC : Integer; // параметр разбиения
         CountOfZones : Integer; // количество зон (INRG)
    CountOfBasePoints : Integer; // число точек образующих зоны (INBP)
     end;
     ListNodes = Record
                Nodes : array of TMyNode;
                InOut : array of Integer;
                Count : Integer;
       CountOfBlocked : Integer;
     CountOfUnBlocked : Integer;
     End;
     ListElements = Record
             Elements : array of TMyElement;
                Count : Integer;
     End;
     TVarables = Record
             ResNodes : ListNodes;
          ResElements : ListElements;
                 Main : MainParams;
     End;
     TVarable = Record
             ResNodes : ListNodes;
          ResElements : ListElements;
                 Name : String;
     End;
     TVariants = Record
              Variant : array of TVarable;
                Count : Integer;
                 Main : MainParams;          
     End;
  TResFunc = class
  private
    { Private declarations }
  public
    constructor Create;
    { Public declarations }
    procedure CreateRes;
    procedure DestroyRes;
    procedure LoaDResult;
    Procedure Params;
    Procedure UploadNodes;
    Procedure UploadElements;
    procedure UploadGeTInOuT;
    procedure GeTInOuT;
    procedure TieInOut;
    procedure CheckInOut;
    Procedure DeleteUpLoadingFiles;
    procedure ReCalculate;
    Procedure CreateNewVariant;
    Procedure DeleteVariant;
    Procedure WriteVariants;
    Procedure ReadVariants;
    Function NumofVariants: Integer;    
    Function GetNameOfVariant(N: integer): String;
    Procedure SetNameOfVariant(N: integer; Name: String);
    Procedure CopyToVariant(Num: Integer);
    Procedure CopyFromVariant(Num: Integer);
    Function Fortran_Format(Const sFormat: String; Const Args: Array Of Const): String;
    FUNCTION FormFindResNode(x,y,Epsilon:Real):Integer;
    FUNCTION Find(n:INTEGER):INTEGER;
    procedure DoIT;
  end;

Var
  UpLoad      : TResFunc;
// текущая сетка
  List        : TVarables;
// варианты сгенерированных сеток
  Variants    : TVariants;
  ErrorM,RFile: Boolean;
  MainVariant : Integer;
      CountVar: Integer;    
IMPLEMENTATION

  USES Results,TSigmaForm,Main,Sysutils, Math,Dialogs, MainInterface;

CONSTRUCTOR TResFunc.Create;
  BEGIN
    ErrorM:=False;
    RFile:=False;
    Variants.Count:=1;    
  END;

procedure TResFunc.DoIT;
begin
  Params;
  UploadGeTInOuT;
  CompileNow;
  RunNow;
  Sleep(3000);
  CreateRes;
  LoadResult;
  DestroyRes;
  Sleep(500);
  GeTInOuT;
  TieInOut;
  CheckInOut;
  Sleep(500);
  DeleteUpLoadingFiles;
end;

procedure TResFunc.CreateRes;
begin
  Nodes:=TofNodes.Create;
  Elems:=TofElements.Create;
end;

procedure TResFunc.DestroyRes;
begin
  Nodes.Free;
  Elems.Free;
end;

Procedure TResFunc.Params;
Var
  MainParams: TMainParams;
Begin
  MainParams:=GetMainParam;
  List.Main.NRC:=MainParams.NRC;
  List.Main.CountOfZones:=MainParams.INRG;
  List.Main.CountOfBasePoints:=MainParams.INBP;
end;
// создание варианта
Procedure TResFunc.CreateNewVariant;
Begin
  Inc(Variants.Count);
  SetLength(Variants.Variant,Variants.Count);
end;
// удаление варианта
Procedure TResFunc.DeleteVariant;
Begin
  Dec(Variants.Count);
  SetLength(Variants.Variant,Variants.Count);
end;
// возвращает количество вариантов
Function TResFunc.NumofVariants: Integer;
Begin
  Result:=Variants.Count;
end;

// возвращает имя вариантов
Function TResFunc.GetNameOfVariant(N: integer): String;
Begin
  Result:=Variants.Variant[n].Name;
end;

// устанавливает имя вариантов
Procedure TResFunc.SetNameOfVariant(N: integer;Name: String);
Begin
  Variants.Variant[n].Name:=Name;
end;


// чтение вариантов из файла
Procedure TResFunc.ReadVariants;
var
  i       : integer;
  IOError : boolean;
  Handle  : TextFile;
  s       : string;
  Procedure ReadVariant(Num: Integer); // пишем отдельный вариант
  Var
    n,e: integer;
  begin
//    Readln(Handle,Variants.Variant[Num].Name);
    Readln(Handle,Variants.Variant[Num].ResNodes.Count);
    SetLength(Variants.Variant[Num].ResNodes.Nodes, Variants.Variant[Num].ResNodes.Count+1);
    SetLength(Variants.Variant[Num].ResNodes.InOut, Variants.Variant[Num].ResNodes.Count+1);
    for n:=1 to Variants.Variant[Num].ResNodes.Count do begin
      Readln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].Number);
      Readln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].X);
      Readln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].Y);
      Readln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].SeNum);
      Readln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].inf.ZoneNum);
      Readln(Handle,s);
      IF s='FALSE' then Variants.Variant[Num].ResNodes.Nodes[n].inf.Blocked:=False
        else Variants.Variant[Num].ResNodes.Nodes[n].inf.Blocked:=True;
      Readln(Handle,s);
      IF s='FALSE' then Variants.Variant[Num].ResNodes.Nodes[n].inf.InOut:=False
        else Variants.Variant[Num].ResNodes.Nodes[n].inf.InOut:=True;
      Readln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].inf.X);
      Readln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].inf.Y);
      Readln(Handle,Variants.Variant[Num].ResNodes.InOut[n]);
      Readln(Handle,Variants.Variant[Num].ResNodes.CountOfBlocked);
      Readln(Handle,Variants.Variant[Num].ResNodes.CountOfUnBlocked);
    end;
      Readln(Handle,Variants.Variant[Num].ResElements.Count);
    SetLength(Variants.Variant[Num].ResElements.Elements, Variants.Variant[Num].ResElements.Count+1);
    for e:=1 to Variants.Variant[Num].ResElements.Count do begin
      Readln(Handle,Variants.Variant[Num].ResElements.Elements[e].Number);
      Readln(Handle,Variants.Variant[Num].ResElements.Elements[e].Node1);
      Readln(Handle,Variants.Variant[Num].ResElements.Elements[e].Node2);
      Readln(Handle,Variants.Variant[Num].ResElements.Elements[e].Node3);
      Readln(Handle,Variants.Variant[Num].ResElements.Elements[e].Material);
    end;
  end;
Begin
  IF FileExists(PLuginReg.Files.NetVariants) then begin
    AssignFile(Handle,PluginReg.Files.NetVariants);
    reset(Handle);
    Readln(Handle,Variants.Count);        {количество вариантов}
    Variants.Count:=Variants.Count;
    Readln(Handle,Variants.Main.NRC);                {параметр NRC}
//    ShowMessage(Format('%d<>%d',[Variants.Main.NRC,List.Main.NRC]));
//    IF Variants.Main.NRC = List.Main.NRC then begin // подхватываем только одинаковые начальные сетки
      RFile:=True;
      SetLength(Variants.Variant, Variants.Count+1);
      Readln(Handle,Variants.Main.CountOfZones);       {параметр кол-во зон}
      Readln(Handle,Variants.Main.CountOfBasePoints);  {параметр кол-во б.точек}
      for i:=2 to Variants.Count-1 do ReadVariant(i);
//    end;
    closeFile(Handle);
//  else MessageDlg('Нет сохраненной версии вариантов сетки', mtInformation,[mbOk], 0);
    IOError:=DeleteFile(PLuginReg.Files.NetVariants);
    If IOError = False then  MessageDlg('False to delete NetVariants file.' +
      'It is used by another application', mtInformation,[mbOk], 0);
  end;
end;
// запись вариантов в файл
Procedure TResFunc.WriteVariants;
var
  i       : integer;
  IOError : boolean;
  Handle  : TextFile;
  Procedure WriteVariant(Num: Integer); // пишем отдельный вариант
  Var
    n,e: integer;
  begin
//    Writeln(Handle,'Вариант №'+IntToStr(Num));
//    Writeln(Handle,Variants.Variant[Num].Name);
    Writeln(Handle,Variants.Variant[Num].ResNodes.Count);
    for n:=1 to Variants.Variant[Num].ResNodes.Count do begin
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].Number);
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].X);
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].Y);
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].SeNum);
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].inf.ZoneNum);
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].inf.Blocked);
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].inf.InOut);
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].inf.X);
      Writeln(Handle,Variants.Variant[Num].ResNodes.Nodes[n].inf.Y);
      Writeln(Handle,Variants.Variant[Num].ResNodes.InOut[n]);
      Writeln(Handle,Variants.Variant[Num].ResNodes.CountOfBlocked);
      Writeln(Handle,Variants.Variant[Num].ResNodes.CountOfUnBlocked);
    end;
    Writeln(Handle,Variants.Variant[Num].ResElements.Count);
    for e:=1 to Variants.Variant[Num].ResElements.Count do begin
      Writeln(Handle,Variants.Variant[Num].ResElements.Elements[e].Number);
      Writeln(Handle,Variants.Variant[Num].ResElements.Elements[e].Node1);
      Writeln(Handle,Variants.Variant[Num].ResElements.Elements[e].Node2);
      Writeln(Handle,Variants.Variant[Num].ResElements.Elements[e].Node3);
      Writeln(Handle,Variants.Variant[Num].ResElements.Elements[e].Material);
    end;
  end;
Begin
  IF FileExists(PLuginReg.Files.NetVariants) then begin
    IOError:=DeleteFile(PLuginReg.Files.NetVariants);
    If IOError = False then  MessageDlg('False to delete NetVariants file.' +
      'It is used by another application', mtInformation,[mbOk], 0);
  end;
  IF not(FileExists(PLuginReg.Files.NetVariants)) then begin
    AssignFile(Handle,PluginReg.Files.NetVariants);
    rewrite(Handle);
    Writeln(Handle,Variants.Count);        {количество вариантов}
    Writeln(Handle,Variants.Main.NRC);                {параметр NRC}
    Writeln(Handle,Variants.Main.CountOfZones);       {параметр кол-во зон}
    Writeln(Handle,Variants.Main.CountOfBasePoints);  {параметр кол-во б.точек}
    for i:=2 to Variants.Count-1 do WriteVariant(i);
    closeFile(Handle);
  end;     
end;

Procedure TResFunc.CopyToVariant(Num: Integer);
Var
  i: Integer;
Begin
  SetLength(Variants.Variant[Num].ResNodes.InOut,List.ResNodes.Count+1);
  SetLength(Variants.Variant[Num].ResNodes.Nodes,List.ResNodes.Count+1);
  SetLength(Variants.Variant[Num].ResElements.Elements,List.ResElements.Count+1);
// Основные параметры
  Variants.Main.NRC:=List.Main.NRC;
  Variants.Main.CountOfZones:=List.Main.CountOfZones;
  Variants.Main.CountOfBasePoints:=List.Main.CountOfBasePoints;
// Узлы
  for i:=1 to List.ResNodes.Count do begin
    Variants.Variant[Num].ResNodes.Nodes[i].Number:=List.ResNodes.Nodes[i].Number;
    Variants.Variant[Num].ResNodes.Nodes[i].X:=List.ResNodes.Nodes[i].X;
    Variants.Variant[Num].ResNodes.Nodes[i].Y:=List.ResNodes.Nodes[i].Y;
    Variants.Variant[Num].ResNodes.Nodes[i].SeNum:=List.ResNodes.Nodes[i].SeNum;
    Variants.Variant[Num].ResNodes.Nodes[i].inf.ZoneNum:=List.ResNodes.Nodes[i].inf.ZoneNum;
    Variants.Variant[Num].ResNodes.Nodes[i].inf.Blocked:=List.ResNodes.Nodes[i].inf.Blocked;
    Variants.Variant[Num].ResNodes.Nodes[i].inf.InOut:=List.ResNodes.Nodes[i].inf.InOut;
    Variants.Variant[Num].ResNodes.Nodes[i].inf.X:=List.ResNodes.Nodes[i].inf.X;
    Variants.Variant[Num].ResNodes.Nodes[i].inf.Y:=List.ResNodes.Nodes[i].inf.Y;
    Variants.Variant[Num].ResNodes.Count:=List.ResNodes.Count;
    Variants.Variant[Num].ResNodes.InOut[i]:=List.ResNodes.InOut[i];
    Variants.Variant[Num].ResNodes.CountOfBlocked:=List.ResNodes.CountOfBlocked;
    Variants.Variant[Num].ResNodes.CountOfUnBlocked:=List.ResNodes.CountOfUnBlocked;
  end;
// Элементы
  For i:=1 to List.ResElements.Count do begin
    Variants.Variant[Num].ResElements.Count:=List.ResElements.Count;
    Variants.Variant[Num].ResElements.Elements[i].Number:=List.ResElements.Elements[i].Number;
    Variants.Variant[Num].ResElements.Elements[i].Node1:=List.ResElements.Elements[i].Node1;
    Variants.Variant[Num].ResElements.Elements[i].Node2:=List.ResElements.Elements[i].Node2;
    Variants.Variant[Num].ResElements.Elements[i].Node3:=List.ResElements.Elements[i].Node3;
    Variants.Variant[Num].ResElements.Elements[i].Material:=List.ResElements.Elements[i].Material;
  end;
end;

Procedure TResFunc.CopyFromVariant(Num: Integer);
Var
  i: Integer;
Begin
  SetLength(List.ResNodes.InOut, Variants.Variant[Num].ResNodes.Count+1);
  SetLength(List.ResNodes.Nodes, Variants.Variant[Num].ResNodes.Count+1);
  SetLength(List.ResElements.Elements, Variants.Variant[Num].ResElements.Count+1);
// Основные параметры
  List.Main.NRC:=Variants.Main.NRC;
  List.Main.CountOfZones:=Variants.Main.CountOfZones;
  List.Main.CountOfBasePoints:=Variants.Main.CountOfBasePoints;
// Узлы
  for i:=1 to Variants.Variant[Num].ResNodes.Count do begin
    List.ResNodes.Nodes[i].Number:=Variants.Variant[Num].ResNodes.Nodes[i].Number;
    List.ResNodes.Nodes[i].X:=Variants.Variant[Num].ResNodes.Nodes[i].X;
    List.ResNodes.Nodes[i].Y:=Variants.Variant[Num].ResNodes.Nodes[i].Y;
    List.ResNodes.Nodes[i].SeNum:=Variants.Variant[Num].ResNodes.Nodes[i].SeNum;
    List.ResNodes.Nodes[i].inf.ZoneNum:=Variants.Variant[Num].ResNodes.Nodes[i].inf.ZoneNum;
    List.ResNodes.Nodes[i].inf.Blocked:=Variants.Variant[Num].ResNodes.Nodes[i].inf.Blocked;
    List.ResNodes.Nodes[i].inf.InOut:=Variants.Variant[Num].ResNodes.Nodes[i].inf.InOut;
    List.ResNodes.Nodes[i].inf.X:=Variants.Variant[Num].ResNodes.Nodes[i].inf.X;
    List.ResNodes.Nodes[i].inf.Y:=Variants.Variant[Num].ResNodes.Nodes[i].inf.Y;
    List.ResNodes.Count:=Variants.Variant[Num].ResNodes.Count;
    List.ResNodes.InOut[i]:=Variants.Variant[Num].ResNodes.InOut[i];
    List.ResNodes.CountOfBlocked:=Variants.Variant[Num].ResNodes.CountOfBlocked;
    List.ResNodes.CountOfUnBlocked:=Variants.Variant[Num].ResNodes.CountOfUnBlocked;
  end;
// Элементы
  For i:=1 to Variants.Variant[Num].ResElements.Count do begin
    List.ResElements.Count:=Variants.Variant[Num].ResElements.Count;
    List.ResElements.Elements[i].Number:=Variants.Variant[Num].ResElements.Elements[i].Number;
    List.ResElements.Elements[i].Node1:=Variants.Variant[Num].ResElements.Elements[i].Node1;
    List.ResElements.Elements[i].Node2:=Variants.Variant[Num].ResElements.Elements[i].Node2;
    List.ResElements.Elements[i].Node3:=Variants.Variant[Num].ResElements.Elements[i].Node3;
    List.ResElements.Elements[i].Material:=Variants.Variant[Num].ResElements.Elements[i].Material;
  end;
end;

procedure TResFunc.LoadResult;
var
  i, Node:  integer;
  ELEMENT:  TElementOne;
begin
  Nodes.LoadNodes(PluginReg.Files.RESULT1BIN);
  IF Nodes.Error<>0 THEN begin ShowMessage('Не смог прочесть'+PluginReg.Files.RESULT1BIN);//MainR.ErrorOut(2);
    ErrorM:=True; end
  else begin
    Elems.LoadElements(PluginReg.Files.RESULT2BIN);
    IF Elems.Error<>0 THEN begin ShowMessage('Не смог прочесть'+PluginReg.Files.RESULT2BIN);//MainR.ErrorOut(3);
    ErrorM:=True; end
    else begin
      IF (Nodes.GetCount>0) and (Elems.GetNumElements>0) then begin
// если всё хорошо с результатами по формальным параметрам, то выделяем память и запонимаем
        List.ResNodes.Count:=Nodes.GetCount;
        List.ResElements.Count:=Elems.GetNumElements;
        SetLength(List.ResNodes.Nodes, List.ResNodes.Count+1);
        SetLength(List.ResElements.Elements, List.ResElements.Count+1);
        for i:=1 to List.ResNodes.Count do begin
          Node:=Nodes.FindRenumNode(i);
          If Node=0 then Begin SHOWMESSAGE('ВНИМАНИЕ! Ошибка обработчика! Нужен РЕСТАРТ подсистемы! ' + IntToStr(i));
            Node:=i;
            ErrorM:=True;
          end;
          List.ResNodes.Nodes[i].Number:=Node;
          List.ResNodes.Nodes[i].X:=Nodes.GetNodeCordX(Node);
          List.ResNodes.Nodes[i].Y:=Nodes.GetNodeCordY(Node);
        end;
        For i:=1 to List.ResElements.Count do begin
          ELEMENT:=Elems.GetElement(i);
          List.ResElements.Elements[i].Number:=ELEMENT.Number;
          List.ResElements.Elements[i].Node1:=ELEMENT.Node1;
          List.ResElements.Elements[i].Node2:=ELEMENT.Node2;
          List.ResElements.Elements[i].Node3:=ELEMENT.Node3;
          List.ResElements.Elements[i].Material:=ELEMENT.Material;
        end;
      end
      else if Nodes.GetCount<=0 then ShowMessage('Количество узлов не может быть меньше или равной 0')
      else if Elems.GetNumElements<=0 then ShowMessage('Количество элементов не может быть меньше или равной 0')
      else  ShowMessage('Количество узлов и элементов не может быть меньше или равной 0');
    end;
  end;
end;
// читаем из файла
procedure TResFunc.GetInOuT;
Var
  i       : integer;
  Handle  : TextFile;
begin
  IF List.Main.NRC>0 then begin
    SetLength(List.ResNodes.InOut,List.ResNodes.Count+1);
    if FileExists(PluginReg.Files.GRIDDMINOUT) then begin
      AssignFile(Handle,PluginReg.Files.GRIDDMINOUT);
      reset(Handle);
      for i:=1 to List.ResNodes.Count do Readln(Handle,List.ResNodes.InOut[i]);
      closeFile(Handle);
    end;
  end;
end;
// ставим флаги внутренний или внешний узел (True - внешний, False - внутренний)
procedure TResFunc.TieInOut;
var
  i: integer;
begin
  for i:=1 to list.ResNodes.Count do begin
    if list.ResNodes.InOut[i]=1 then list.ResNodes.Nodes[Find(i)].inf.InOut:=True
    else if list.ResNodes.InOut[i]=0 then list.ResNodes.Nodes[Find(i)].inf.InOut:=False;
  end;
end;
// Проверяем на наличие лишних внешних узлов. Одиночный внешний узел, то есть не образующий
//  сегмента, считается внутренним.
procedure TResFunc.CheckInOut;
var
  i,n: integer;
  Handle  : TextFile;
  function check(n: integer): boolean;
  var
    j,k1,k2,k3,n1,n2,n3:integer;
    r:boolean;
  begin
    k1:=0;    k2:=0;    k3:=0; r:=False;
    for j:=1 to list.ResElements.Count do begin
      n1:=list.ResElements.Elements[j].Node1;
      n2:=list.ResElements.Elements[j].Node2;
      n3:=list.ResElements.Elements[j].Node3;
      IF (Find(n1)=n) or (Find(n2)=n) or (Find(n3)=n) then begin
        IF list.ResNodes.Nodes[Find(n1)].inf.InOut then k1:=1 else k1:=0;
        IF list.ResNodes.Nodes[Find(n2)].inf.InOut then k2:=1 else k2:=0;
        IF list.ResNodes.Nodes[Find(N3)].inf.InOut then k3:=1 else k3:=0;
        IF (k1+k2+k3)>1 then r:=True;
//        Writeln(Handle,Format('Элемент №%d: %d-%d-%d(%d-%d-%d)',[j,
//          n1,n2,n3, Find(n1), Find(n2), Find(n3)]));
      end;
    end;
    IF r then Result:=True else Result:=False;
  end;
begin
//  AssignFile(Handle,PluginReg.Files.NetVariants);
//  rewrite(Handle);
  for i:=1 to list.ResNodes.Count do begin
    if list.ResNodes.Nodes[i].inf.InOut then begin
//        Writeln(Handle,Format('Внешний узел №%d',[i]));
       IF not check(list.ResNodes.Nodes[Find(i)].Number) then begin list.ResNodes.Nodes[i].inf.InOut:=False; {не прошел проверку}
//        Writeln(Handle,'Не прошел проверку');
      end;
    end;
  end;
//  closeFile(Handle);
end;
// по номеру узла возвращает его индекс.
// индекс - это порядковый номер в result'e (используется в Elements)
// Number - его отображаемый номер
FUNCTION TResFunc.Find(n:INTEGER):INTEGER;
VAR i,r : INTEGER;
BEGIN
  r:=0;
  FOR i:=1 TO List.ResNodes.Count DO IF List.ResNodes.Nodes[i].Number=n THEN r:=i;
    IF r=0 then r:=n;
  Result:=r;
END;

FUNCTION TResFunc.FormFindResNode;//(x,y,Epsilon:Real):TMyNode;
Var
     i        : word;
     res      : TMyNode;
     vec, Min : Real;
     Function Vector(px,py,x,y:Real):Real;
     Begin
          Result:=sqrt(sqr(px-x)+sqr(py-y));
     End;
Var
     Node : TMyNode;
     MaxNum: integer;
Begin
     res.Number:=0;
     res.X:=0;
     res.Y:=0;
     min:=Epsilon;
     MaxNum:=0;
     If List.ResNodes.Count>0 Then
     Begin
       For i:=1 To List.ResNodes.Count Do Begin
         Node:=List.ResNodes.Nodes[i];
         if MaxNum<Node.Number then MaxNum:=Node.Number;
           vec:=Vector(Node.x,Node.y,x,y);
           If (vec<=min) Then Begin
             min:=vec;
             res:=Node;
           End;
         End;
       End;
     Result:=res.Number;
End;

procedure TResFunc.ReCalculate;
begin
  Params;
  UploadNodes;
  UploadElements;
  UploadGeTInOuT;
  CompileNow;
  RunNow;
  Sleep(3000);
  CreateRes;
  LoadResult;
  DestroyRes;
  Sleep(500);
  GeTInOuT;
  TieInOut;
  CheckInOut;
  Sleep(500);
  DeleteUpLoadingFiles;
end;
// выгружаем флаг для получения массива INOUT 
procedure TResFunc.UploadGetInOuT;
Var
  Handle  : TextFile;
  IOError : boolean;
begin
  IF List.Main.NRC>0 then begin
    if FileExists(PluginReg.Files.GRIDDMFINOUT) then begin
      IOError:=DeleteFile(PluginReg.Files.GRIDDMFINOUT);
      If IOError = False then  MessageDlg('False to delete old file.' +
       'It is used by another application', mtInformation,[mbOk], 0);
    end
    else begin
      AssignFile(Handle,PluginReg.Files.GRIDDMFINOUT);
      rewrite(Handle);
      writeln(Handle,'1');
      closeFile(Handle);
    end;
  end;
end;
// выргужаем узлы
procedure TResFunc.UploadNodes;
Var
  Handle  : TextFile;
  res     : string;
  i       : Integer;
  IOError : boolean;
begin
// Пишем в файл новые координаты узлов последовательно
// Должны быть записаны в CORD в той же последовательности
// т.е. просто заменить после формирования сетки на новые
  res:=PluginReg.Files.GRIDDMNODES;
  if FileExists(res) then begin
    IOError:=DeleteFile(res);
    If IOError = False then  MessageDlg('False to delete old nodes file.' +
      'It is used by another application', mtInformation,[mbOk], 0);
  end
  else begin
    AssignFile(Handle,res);
    rewrite(Handle);
    writeln(Handle,list.ResNodes.Count);
    FOR i:=1 TO list.ResNodes.Count DO BEGIN
      writeln(Handle,Fortran_Format('%-7f',[list.ResNodes.Nodes[Upload.find(i)].X]));
      writeln(Handle,Fortran_Format('%-7f',[list.ResNodes.Nodes[Upload.find(i)].Y]));
    end;
    closeFile(Handle);
  end;
end;
// выргужаем узлы
procedure TResFunc.UploadElements;
Var
  Handle  : TextFile;
  res     : string;
  i       : Integer;
  IOError : boolean;
begin
  res:=PluginReg.Files.GRIDDMELEMS;
  if FileExists(res) then begin
    IOError:=DeleteFile(res);
    If IOError = False then  MessageDlg('False to delete old elements file.' +
      'It is used by another application', mtInformation,[mbOk], 0);
  end
  else begin
    AssignFile(Handle,res);
    rewrite(Handle);
    writeln(Handle,list.ResElements.Count);
    FOR i:=1 TO list.ResElements.Count DO BEGIN
      writeln(Handle,Format('%d',[list.ResElements.Elements[i].Node1]));
      writeln(Handle,Format('%d',[list.ResElements.Elements[i].Node2]));
      writeln(Handle,Format('%d',[list.ResElements.Elements[i].Node3]));
    end;
    closeFile(Handle);
  end;
end;

procedure TResFunc.DeleteUpLoadingFiles;
Var
  IOError : boolean;
begin
  if FileExists(PLuginReg.Files.GRIDDMNODES) then begin
    IOError:=DeleteFile(PLuginReg.Files.GRIDDMNODES);
    If IOError = False then  MessageDlg('False to delete nodes file.' +
      'It is used by another application', mtInformation,[mbOk], 0);
  end;
  if FileExists(PLuginReg.Files.GRIDDMFINOUT) then begin
    IOError:=DeleteFile(PLuginReg.Files.GRIDDMFINOUT);
    If IOError = False then  MessageDlg('False to delete file flag for InOut.' +
      'It is used by another application', mtInformation,[mbOk], 0);
  end;
  if FileExists(PLuginReg.Files.GRIDDMINOUT) then begin
    IOError:=DeleteFile(PLuginReg.Files.GRIDDMINOUT);
    If IOError = False then  MessageDlg('False to delete InOut file.' +
      'It is used by another application', mtInformation,[mbOk], 0);
  end;
  if FileExists(PLuginReg.Files.GRIDDMELEMS) then begin
    IOError:=DeleteFile(PLuginReg.Files.GRIDDMELEMS);
    If IOError = False then  MessageDlg('False to delete elements file.' +
      'It is used by another application', mtInformation,[mbOk], 0);
  end
end;

//фортрановский формат чисел
Function TResFunc.Fortran_Format(Const sFormat: String; Const Args: Array Of Const): String;
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



end.