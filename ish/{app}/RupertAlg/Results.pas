{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{                                изменения:                           }
{                                                                     }
{                 Петроченков Михаил Александрович 2003               }
{                                                                     }
{                     Цветаев Борис Михайлович 2004                   }
{                                                                     }
{*********************************************************************}

UNIT Results;
INTERFACE
TYPE
  TNodeOne = RECORD
    Number        : INTEGER;
    x,y           : Real;
    ForceX,ForceY : Real;
    BondType      : BYTE;
    DX,DY         : Real;
    RenumNum      : INTEGER;
  END;
  TofMaterial = RECORD
    E,Mu,Sg,Thickness : Real;
    free4,free5,free6 : Real;
  END;
  TElementOne = RECORD
    Number            : INTEGER;
    Node1,Node2,Node3 : INTEGER;
    Strain            : ARRAY [1..7] OF Real;
    // Добавляем св-ва материала КЭ   kotov
    Material          : INTEGER;

  END;
  TofArea = RECORD
    MaxX,MaxY,MinX,MinY : Real;
  END;

  TofNodes = CLASS
  PROTECTED
    CountOfNodes : INTEGER;
    ArrayOfNodes : ARRAY OF TNodeOne;
    CurrentNode  : WORD;
  PUBLIC
    Area  : TofArea;
    Error : WORD;
    CONSTRUCTOR Create;
{*****>}
    destructor Destroy;
{<*****}
    PROCEDURE LoadNodes(Path:STRING);
    PROCEDURE AddNode(OneNode:TNodeOne);
    PROCEDURE EditNode(Number:INTEGER;OneNode:TNodeOne);
    FUNCTION FindNode(x,y:Real):INTEGER;
    FUNCTION GetNode(n:INTEGER):TNodeOne;
    FUNCTION GetMovedNode(n:INTEGER;Move:Real):TNodeOne;
    FUNCTION FindRenumNode(n:INTEGER):INTEGER;
    PROCEDURE UpDateWithMove(Move:Real);
    FUNCTION SetFirstElement:BOOLEAN;
    FUNCTION SetNextElement:BOOLEAN;
    FUNCTION GetCurrentElement:WORD;
{*****>}
    FUNCTION GetNodeCordX(N:INTEGER):Real;
    FUNCTION GetNodeCordY(N:INTEGER):Real;
    FUNCTION GetCount():Integer;
    FUNCTION GetNodeRenum(n:INTEGER):INTEGER;
    FUNCTION GetCopyNode(n:INTEGER):TNodeOne;
    PROCEDURE SetCopyNode(n:INTEGER;OneNode:TNodeOne);
    FUNCTION FormFindResNode(x,y,Epsilon:Real):TNodeOne;
    procedure FormSetNodeValue(Number:integer;x,y:Real);
{<*****}
 END;

  TofElements = CLASS
  PROTECTED
    CountOfElements : INTEGER;
    ArrayOfElements : ARRAY OF TElementOne;
    CurrentElement  : WORD;
  PUBLIC
    Error    : WORD;
    Max, Min : ARRAY [1..7] OF Real;
    CONSTRUCTOR Create;
{*****>}
    destructor Destroy;
{<*****}
    PROCEDURE LoadElements(Path:STRING);
    PROCEDURE AddElement(OneElement:TElementOne);
    PROCEDURE EditElement(Number:INTEGER;OneElement:TElementOne);
    FUNCTION FindElement(n:INTEGER):INTEGER;
    FUNCTION GetElement(n:INTEGER):TElementOne;
    // возврещает количество элементов
    FUNCTION GetNumElements:INTEGER;
    FUNCTION SetFirstElement:BOOLEAN;
    FUNCTION SetNextElement:BOOLEAN;
    FUNCTION GetCurrentElement:TElementOne;
    FUNCTION FindElementByPoint(x,y:Real;Move:Real):INTEGER;
  END;


VAR
  FileRes                : FILE OF BYTE;
  Nodes                  : TofNodes;
  Elems                  : TofElements;
  coner1, coner2, coner3 : Real;
  Materials              : array[1..3] of TofMaterial; // Добавляем материалы (kotov)


TYPE
  TA = ARRAY [1..9] OF BYTE;
  pTA = ^TA;


IMPLEMENTATION
USES Sysutils, Math,Dialogs;


PROCEDURE MyREAD(pX:pTA; n:BYTE);
VAR i : BYTE;
BEGIN
  FOR i:=1 TO n DO READ(FileRes,pX^[i]);
END;


CONSTRUCTOR TofNodes.Create;
BEGIN
END;

{*****>}
Destructor TofNodes.Destroy;
Begin
end;
{<*****}


PROCEDURE TofNodes.LoadNodes(Path:STRING);
VAR
  OneNode      : TNodeOne;
  m, n         : INTEGER;
  x, y         : DOUBLE;

BEGIN
  Error:=1;
  CountOfNodes:=0;
  SetLength(ArrayOfNodes,0);
  IF NOT FileExists(Path) THEN EXIT;
  AssignFile(FileRes,Path);
  Reset(FileRes);
  // считываем координаты узлов
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    MyREAD(ADDR(y),8);
    OneNode.Number:=CountOfNodes+1;
    OneNode.x:=x;
    OneNode.y:=y;
    OneNode.ForceX:=0;
    OneNode.ForceY:=0;
    OneNode.BondType:=0;
    OneNode.DX:=0;
    OneNode.DY:=0;
    OneNode.RenumNum:=0;
    AddNode(OneNode);
  END;
  IF CountOfNodes=0 THEN EXIT;
  // считываем граничные условия
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    MyREAD(ADDR(y),8);
    n:=FindNode(x,y);
    IF n = 0 THEN EXIT;
    OneNode:=GetNode(n);
    MyREAD(ADDR(OneNode.BondType),1);
    EditNode(n,OneNode);
  END;
  // считываем значения приложенных сил
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    MyREAD(ADDR(y),8);
    n:=FindNode(x,y);
    IF n = 0 THEN EXIT;
    OneNode:=GetNode(n);
    MyREAD(ADDR(x),8);
    MyREAD(ADDR(y),8);
    OneNode.ForceX:=x;
    OneNode.ForceY:=y;
    EditNode(n,OneNode);
  END;
  m:=0;
  // определяем номера узлов после перенумерации
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    INC(m);
    MyREAD(ADDR(y),8);
    n:=FindNode(x,y);
    IF n = 0 THEN EXIT;
    OneNode:=GetNode(n);
    OneNode.RenumNum:=m;
    EditNode(n,OneNode);
  END;
  m:=0;
  // считываем перемещения узлов
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    INC(m);
    MyREAD(ADDR(y),8);
    n:=FindRenumNode(m);
    IF n=0 THEN CONTINUE;
    OneNode:=GetNode(n);
    OneNode.dx:=x;
    OneNode.dy:=y;
    EditNode(n,OneNode);
  END;
  Close(FileRes);  
  Error:=0;

END;


PROCEDURE TofNodes.AddNode(OneNode:TNodeOne);
BEGIN
  IF CountOfNodes<1 THEN BEGIN
    Area.MaxX:=OneNode.x;
    Area.MaxY:=OneNode.y;
    Area.MinX:=OneNode.x;
    Area.MinY:=OneNode.y;
  END
  ELSE BEGIN
    IF Area.MaxX<OneNode.x THEN Area.MaxX:=OneNode.x;
    IF Area.MinX>OneNode.x THEN Area.MinX:=OneNode.x;
    IF Area.MaxY<OneNode.y THEN Area.MaxY:=OneNode.y;
    IF Area.MinY>OneNode.y THEN Area.MinY:=OneNode.y;
  END;
  INC(CountOfNodes);
  SetLength(ArrayOfNodes,CountOfNodes);
  ArrayOfNodes[CountOfNodes-1]:=OneNode;
END;


PROCEDURE TofNodes.UpDateWithMove(Move:Real);
VAR
  OneNode : TNodeOne;
  i       : WORD;

BEGIN
  IF CountOfNodes<1 THEN BEGIN
    Area.MaxX:=0;
    Area.MaxY:=0;
    Area.MinX:=0;
    Area.MinY:=0;
  END
  ELSE BEGIN
    FOR i:=0 To CountOfNodes-1 DO BEGIN
      OneNode:=GetMovedNode(i+1,Move);
      IF i=1 THEN BEGIN
        Area.MaxX:=OneNode.x;
        Area.MaxY:=OneNode.y;
        Area.MinX:=OneNode.x;
        Area.MinY:=OneNode.y;
      END
      ELSE BEGIN
        IF Area.MaxX<OneNode.x THEN Area.MaxX:=OneNode.x;
        IF Area.MinX>OneNode.x THEN Area.MinX:=OneNode.x;
        IF Area.MaxY<OneNode.y THEN Area.MaxY:=OneNode.y;
        IF Area.MinY>OneNode.y THEN Area.MinY:=OneNode.y;
      END;
    END;
  END;
END;


PROCEDURE TofNodes.EditNode(Number:INTEGER;OneNode:TNodeOne);
BEGIN
  IF CountOfNodes<2 THEN BEGIN
    Area.MaxX:=OneNode.x;
    Area.MaxY:=OneNode.y;
    Area.MinX:=OneNode.x;
    Area.MinY:=OneNode.y;
  END
  ELSE BEGIN
    IF Area.MaxX<OneNode.x THEN Area.MaxX:=OneNode.x;
    IF Area.MinX>OneNode.x THEN Area.MinX:=OneNode.x;
    IF Area.MaxY<OneNode.y THEN Area.MaxY:=OneNode.y;
    IF Area.MinY>OneNode.y THEN Area.MinY:=OneNode.y;
  END;
  ArrayOfNodes[Number-1]:=OneNode;
END;


FUNCTION TofNodes.GetNode(n:INTEGER):TNodeOne;
BEGIN
  Result:=ArrayOfNodes[n-1];
END;


FUNCTION TofNodes.GetMovedNode;
VAR OneNode : TNodeOne;
BEGIN
  OneNode:=GetNode(n);
  OneNode.x:=OneNode.x+OneNode.DX*Move/10;
  OneNode.y:=OneNode.y+OneNode.DY*Move/10;
  Result:=OneNode;
END;

{*****>}
FUNCTION TofNodes.GetNodeCordX(N: Integer):Real;
  BEGIN Result:= ArrayOfNodes[n-1].x; END;

FUNCTION TofNodes.GetNodeCordY(N: Integer):Real;
  BEGIN Result:= ArrayOfNodes[n-1].y; END;

FUNCTION TofNodes.GetCount():Integer;
  BEGIN result:= CountOfNodes; END;

FUNCTION TofNodes.GetNodeRenum(n:INTEGER):INTEGER;
  VAR i,r : INTEGER;
  BEGIN Result:=ArrayOfNodes[n-1].RenumNum; END;

FUNCTION TofNodes.GetCopyNode(n:INTEGER):TNodeOne;
  BEGIN result:=ArrayOfNodes[n-1]; END;

PROCEDURE TofNodes.SetCopyNode(n: Integer; OneNode:TNodeOne);
  BEGIN
    ArrayOfNodes[OneNode.Number-1]:=OneNode;
    ArrayOfNodes[OneNode.Number-1].RenumNum:=n;
  END;

procedure TofNodes.FormSetNodeValue(Number:integer;x,y:Real);
begin
    ArrayOfNodes[Number-1].Number:=Number;
    ArrayOfNodes[Number-1].x:=x;
    ArrayOfNodes[Number-1].y:=y;
end;

FUNCTION TofNodes.FormFindResNode;//(x,y,Epsilon:Real):TNodeOne;
Var
     i        : word;
     res      : TNodeOne;
     vec, Min : Real;
     Function Vector(px,py,x,y:Real):Real;
     Begin
          Result:=sqrt(sqr(px-x)+sqr(py-y));
     End;
Var
     Node : TNodeOne;
     MaxNum: integer;
Begin
     res.Number:=0;
     res.x:=0;
     res.y:=0;
     min:=Epsilon;
     MaxNum:=0;
     If CountOfNodes>0 Then
     Begin
          For i:=0 To CountOfNodes Do
          Begin
               Node:=Nodes.GetNode(i);
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

{<*****}
FUNCTION TofNodes.FindNode(x,y:Real):INTEGER;
{*****>}
//CONST tochn = 0.01;
CONST tochn = 0.1;
{<*****}
VAR
  i,r     : INTEGER;
  xxx,yyy : Real;

BEGIN
  r:=0;
  FOR i:=1 TO CountOfNodes DO BEGIN
    xxx:=ABS(ArrayOfNodes[i-1].x-x);
    yyy:=ABS(ArrayOfNodes[i-1].y-y);
    IF (xxx<=tochn) AND (yyy<=tochn) THEN r:=i;
  END;
  Result:=r;
END;

FUNCTION TofNodes.FindRenumNode(n:INTEGER):INTEGER;
VAR i,r : INTEGER;
BEGIN
  r:=0;
  FOR i:=1 TO CountOfNodes DO
  IF ArrayOfNodes[i-1].RenumNum=n THEN r:=i;
  Result:=r;
END;

FUNCTION TofNodes.SetFirstElement;
BEGIN
  IF CountOfNodes<0 THEN Result:=False
  ELSE BEGIN
    CurrentNode:=0;
    Result:=True;
  END;
END;

FUNCTION TofNodes.SetNextElement;
BEGIN
  IF CountOfNodes<0 THEN Result:=False
  ELSE BEGIN
    IF CurrentNode>=CountOfNodes-1 THEN BEGIN
      CurrentNode:=0;
      Result:=False;
    END
    ELSE BEGIN
      INC(CurrentNode);
      Result:=True;
    END;
  END;
END;

FUNCTION TofNodes.GetCurrentElement;
  BEGIN  Result:=CurrentNode+1; END;

CONSTRUCTOR TofElements.Create;
  BEGIN END;
{*****>}
Destructor TofElements.Destroy;
  BEGIN END;
{<*****}
//-----------------------------------------------------------------------------
PROCEDURE TofElements.LoadElements(Path:STRING);
VAR
  OneElement : TElementOne;
  x          : DOUBLE;
  j          : BYTE;
  i,n,n1     : WORD;

BEGIN
  Error:=1;
  CountOfElements:=0;
  SetLength(ArrayOfElements,0);
  IF NOT FileExists(Path) THEN EXIT;
  AssignFile(FileRes,Path);
  Reset(FileRes);
  // считываем координаты узлов, составляющих КЭ
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(n),2);
    IF n = 65535 THEN BREAK;
    OneElement.Number:=CountOfElements+1;
    OneElement.Node1:=n;
    MyREAD(ADDR(n),2);
    OneElement.Node2:=n;
    MyREAD(ADDR(n),2);
    OneElement.Node3:=n;
    FOR j:=1 TO 7 DO OneElement.strain[j]:=0;
    AddElement(OneElement);
  END;
  IF CountOfElements=0 THEN EXIT;
  n:=0;
  // считываем значения напряжений в КЭ
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    INC(n);
    OneElement:=GetElement(n);
    OneElement.strain[1]:=x;
    MyREAD(ADDR(x),8);
    OneElement.strain[2]:=x;
    MyREAD(ADDR(x),8);
    OneElement.strain[3]:=x;
    MyREAD(ADDR(x),8);
    OneElement.strain[4]:=x;
    MyREAD(ADDR(x),8);
    OneElement.strain[5]:=x;
    MyREAD(ADDR(x),8);
    OneElement.strain[6]:=x;
    MyREAD(ADDR(x),8);
    OneElement.strain[7]:=x;
    EditElement(n,OneElement);
  END;
  // Считываем св-ва материала КЭ   kotov
  n:=0;
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    INC(n);
    Materials[n].E := x;
    MyREAD(ADDR(x),8);
    Materials[n].Mu := x;
    MyREAD(ADDR(x),8);
    Materials[n].Sg := x;
    MyREAD(ADDR(x),8);
    Materials[n].free4 := x;
    MyREAD(ADDR(x),8);
    Materials[n].free5 := x;
    MyREAD(ADDR(x),8);
    Materials[n].free6 := x;
    MyREAD(ADDR(x),8);
    Materials[n].Thickness := x;
  END;
  n:=0;
  WHILE NOT Eof(FileRes) DO BEGIN
    MyREAD(ADDR(n1),2);
    IF n1 = 65535 THEN BREAK;
//    IF n = CountOfElements THEN BREAK;
    INC(n);
    OneElement:=GetElement(n);
    OneElement.Material:=n1;
    EditElement(n,OneElement);
  END;
  Close(FileRes);
  FOR i:=0 TO CountOfElements-1 DO BEGIN
    IF i=0 THEN BEGIN
      FOR j:=1 TO 7 DO BEGIN
        max[j]:=ArrayOfElements[i].strain[j];
        min[j]:=ArrayOfElements[i].strain[j];
      END;
    END
    ELSE BEGIN
      FOR j:=1 TO 7 DO BEGIN
        IF max[j]<ArrayOfElements[i].strain[j] THEN max[j]:=ArrayOfElements[i].strain[j];
        IF min[j]>ArrayOfElements[i].strain[j] THEN min[j]:=ArrayOfElements[i].strain[j];
      END;
    END;
  END;
  Error:=0;
END;


PROCEDURE TofElements.AddElement(OneElement:TElementOne);
BEGIN
  INC(CountOfElements);
  SetLength(ArrayOfElements,CountOfElements);
  ArrayOfElements[CountOfElements-1]:=OneElement;
END;


PROCEDURE TofElements.EditElement(Number:INTEGER;OneElement:TElementOne);
  BEGIN  ArrayOfElements[Number-1]:=OneElement; END;


FUNCTION TofElements.GetElement(n:INTEGER):TElementOne;
  BEGIN Result:=ArrayOfElements[n-1]; END;

// возврещает количество элементов
FUNCTION TofElements.GetNumElements():INTEGER;
  BEGIN  Result:=CountOfElements; END;

FUNCTION TofElements.FindElement(n:INTEGER):INTEGER;
VAR
  i   : WORD;
  res : INTEGER;

BEGIN
  IF CountOfElements>0 THEN BEGIN
    Res:=-1;
    FOR i:=0 TO CountOfElements-1 DO BEGIN
      IF ArrayOfElements[i].Number=n THEN res:=i;
    END;
  END ELSE Res:=-1;
  Result:=Res+1;
END;


FUNCTION TofElements.SetFirstElement;
BEGIN
  IF CountOfElements<0 THEN Result:=False
  ELSE BEGIN
    CurrentElement:=0;
    Result:=True;
  END;
END;


FUNCTION TofElements.SetNextElement;
BEGIN
  IF CountOfElements<0 THEN Result:=False
  ELSE BEGIN
    IF CurrentElement>=CountOfElements-1 THEN BEGIN
      CurrentElement:=0;
      Result:=False;
    END
    ELSE BEGIN
      INC(CurrentElement);
      Result:=True;
    END;
  END;
END;


FUNCTION TofElements.GetCurrentElement;
BEGIN
  Result:=ArrayOfElements[CurrentElement];
END;


// Определение угла между двумя векторами имеющими общую точку (x1,y1)
FUNCTION MyDiv(x,y:Real):Real;
BEGIN
  IF ABS(y)<0.1E-4900 THEN Result:=0.1E-4900 ELSE Result:=x/y;
END;


FUNCTION Coner(x1,y1,x2,y2,x3,y3:Real):Real;
BEGIN
  TRY
  Result:=ArcCos(MyDiv((x2-x1)*(x3-x1)+(y2-y1)*(y3-y1),sqrt((sqr(x2-x1)+sqr(y2-y1))*(sqr(x3-x1)+sqr(y3-y1)))));
  EXCEPT
    ON EMathError DO Result:=Pi;
    ON EInvalidOp DO Result:=Pi;
  END;
END;


// Проверка угол c1 больше ли угла c2
FUNCTION Is_BiggerConer(c1,c2:Real):BOOLEAN;
BEGIN
  IF C1<0 THEN C1:=C1+(2*Pi);
  IF C2<0 THEN C2:=C2+(2*Pi);
  IF C1>=C2 THEN Result:=true
  ELSE Result:=false;
END;


// Проверка принадлежит ли точка (x,y) треугольнику (x1,y1),(x2,y2),(x3,y3)
FUNCTION TestTriangle(x,y,x1,y1,x2,y2,x3,y3:Real):BOOLEAN;
VAR c1,c2,c3 : BOOLEAN;
BEGIN
  IF Is_BiggerConer(coner(x1,y1,x2,y2,x3,y3),coner(x1,y1,x2,y2,x,y)) THEN c1:=True ELSE c1:=False;
  IF Is_BiggerConer(coner(x2,y2,x3,y3,x1,y1),coner(x2,y2,x3,y3,x,y)) THEN c2:=True ELSE c2:=False;
  IF Is_BiggerConer(coner(x3,y3,x1,y1,x2,y2),coner(x3,y3,x1,y1,x,y)) THEN c3:=True ELSE c3:=False;
  Result:=c1 AND c2 AND c3;
END;


FUNCTION TofElements.FindElementByPoint;
VAR
  OneNode  : TNodeOne;
  x1,x2,x3 : Real;
  y1,y2,y3 : Real;
  Res      : INTEGER;
  i        : WORD;

BEGIN
  Res:=-1;
  IF CountOfElements>0 THEN BEGIN
    FOR i:=0 To CountOfElements-1 DO BEGIN
      Nodes.GetNode(ArrayOfElements[i].Node1);
      OneNode:=Nodes.GetMovedNode(ArrayOfElements[i].Node1,Move);
      x1:=OneNode.x;
      y1:=OneNode.y;
      OneNode:=Nodes.GetMovedNode(ArrayOfElements[i].Node2,Move);
      x2:=OneNode.x;
      y2:=OneNode.y;
      OneNode:=Nodes.GetMovedNode(ArrayOfElements[i].Node3,Move);
      x3:=OneNode.x;
      y3:=OneNode.y;
      IF TestTriangle(x,y,x1,y1,x2,y2,x3,y3) THEN Res:=i;
    END;
  END;
  Result:=Res;
END;

END.




















