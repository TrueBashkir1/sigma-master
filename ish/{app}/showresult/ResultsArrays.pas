{*********************************************************************}
{                                                                     }
{                    ���������� ����������� ��������                  }
{                                                                     }
{                               ������� 609                           }
{                                                                     }
{                    ������� ����� ����������� 2001                   }
{                                                                     }
{                                ���������:                           }
{                                                                     }
{                 ����������� ������ ������������� 2003               }
{                                                                     }
{                     ������� ����� ���������� 2004                   }
{                                                                     }
{*********************************************************************}
         
UNIT ResultsArrays;
INTERFACE
TYPE
  MyReal = REAL;
  TOneNode = RECORD
    Number        : INTEGER;
    x,y           : MyReal;
    ForceX,ForceY : MyReal;
    BondType      : BYTE;
    DX,DY         : MyReal;
    RenumNum      : INTEGER;
  END;
  TMaterial = RECORD
  //----------------------------------------
    E,Mu,Sg,Thickness : MyReal;
    free4,free5,free6 : MyReal;
  END;
  TOneElement = RECORD
    Number            : INTEGER;
    Node1,Node2,Node3 : INTEGER;
    Strain            : ARRAY [1..7] OF MyReal;
    // ��������� ��-�� ��������� ��   kotov
    Material          : INTEGER;

  END;
  TArea = RECORD
    MaxX,MaxY,MinX,MinY : MyReal;
  END;

  TNodes = CLASS
  PROTECTED
    CountOfNodes : INTEGER;
    ArrayOfNodes : ARRAY OF TOneNode;
    CurrentNode  : WORD;
  PUBLIC
    Area  : TArea;
    Error : WORD;
    CONSTRUCTOR Create;
    PROCEDURE LoadNodes(Path:STRING);
    PROCEDURE AddNode(OneNode:TOneNode);
    PROCEDURE EditNode(Number:INTEGER;OneNode:TOneNode);
    FUNCTION FindNode(x,y:MyReal):INTEGER;
    FUNCTION GetNode(n:INTEGER):TOneNode;
    FUNCTION GetMovedNode(n:INTEGER;Move:MyReal):TOneNode;
    FUNCTION FindRenumNode(n:INTEGER):INTEGER;
    PROCEDURE UpDateWithMove(Move:MyReal);
    FUNCTION SetFirstElement:BOOLEAN;
    FUNCTION SetNextElement:BOOLEAN;
    FUNCTION GetCurrentElement:WORD;
    FUNCTION GetCountOfNodes:Integer;
  END;

  TElements = CLASS
  PROTECTED
    CountOfElements : INTEGER;
    ArrayOfElements : ARRAY OF TOneElement;
    CurrentElement  : WORD;
  PUBLIC
    Error    : WORD;
    Max, Min : ARRAY [1..7] OF MyReal;
    CONSTRUCTOR Create;
    PROCEDURE LoadElements(Path:STRING);
    PROCEDURE AddElement(OneElement:TOneElement);
    PROCEDURE EditElement(Number:INTEGER;OneElement:TOneElement);
    FUNCTION FindElement(n:INTEGER):INTEGER;
    FUNCTION GetElement(n:INTEGER):TOneElement;
    // ���������� ���������� ���������
    FUNCTION GetNumElements:INTEGER;
    FUNCTION SetFirstElement:BOOLEAN;
    FUNCTION SetNextElement:BOOLEAN;
    FUNCTION GetCurrentElement:TOneElement;
    FUNCTION FindElementByPoint(x,y:MyReal;Move:MyReal):INTEGER;
  END;

//����� ��� �������� ������� �����, �� ������� �������� ����.
//�������� �.�. ��� 2011�.
  ZoneContourPoints = CLASS
  PROTECTED
    //������ ������ ��� 20 ��������� ��� �� 8 �����, ������� �������� 2 ������������
    ArrayOfPoints : ARRAY [1..20,1..16] OF Double;
    NumberOfZones : Shortint;
    //������ �����, �� ������� �������� ������ ���� ��� ������������ �������
    PROCEDURE SetZonePoints(Number:Shortint; Points:ARRAY OF Double);
  PUBLIC
    Error : WORD;
    CONSTRUCTOR Create;
    FUNCTION GetNumberOfZones : Shortint;
    PROCEDURE LoadZones(Path:STRING);                                
    //���������� ������ ��������� ��� ���������� ������� ���� � ������������ �������
    PROCEDURE GetZonePoints(Number:Shortint; var Points:ARRAY OF Double);
  END;
// �����

VAR
  F                      : FILE OF BYTE;
  Nodes_Result           : TNodes;
  Elements_Result        : TElements;
  ZoneContour            : ZoneContourPoints;
  coner1, coner2, coner3 : MyReal;
  Materials              : array[1..3] of TMaterial; // ��������� ��������� (kotov)
  ContourPoints          : ZoneContourPoints;



TYPE
  TA = ARRAY [1..9] OF BYTE;
  pTA = ^TA;


IMPLEMENTATION
USES Sysutils, Math,Dialogs,ShowMovings;


PROCEDURE MyREAD(pX:pTA; n:BYTE);
VAR i : BYTE;
BEGIN
  FOR i:=1 TO n DO READ(F,pX^[i]);
END;


CONSTRUCTOR TNodes.Create;
BEGIN
END;


PROCEDURE TNodes.LoadNodes(Path:STRING);
VAR
  OneNode      : TOneNode;
  m, n         : INTEGER;
  x, y         : DOUBLE;
  vipoln         : INTEGER; // ���������, ��� �������� ����������� ���� �� ���.

BEGIN
  Error:=1;
  CountOfNodes:=0;
  SetLength(ArrayOfNodes,0);
  IF NOT FileExists(Path) THEN EXIT;
  AssignFile(F,Path);
  Reset(F);
  // ��������� ���������� �����
  vipoln := 0 ; // ��������� ���������� ���������� ���������
  WHILE NOT Eof(F) DO BEGIN
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
    vipoln := 1;           // ����������� ���������� ���������
  END;
  IF CountOfNodes=0 THEN EXIT;
  IF vipoln=0 THEN
  begin
  ShowMovingsForm.Error := 2;
  EXIT; // �������� �� ���� �� �����������
  end;

  // ��������� ��������� �������
  vipoln := 0 ; // ��������� ����������
  WHILE NOT Eof(F) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    MyREAD(ADDR(y),8);
    n:=FindNode(x,y);
    IF n = 0 THEN EXIT;
    OneNode:=GetNode(n);
    MyREAD(ADDR(OneNode.BondType),1);
    EditNode(n,OneNode);
    vipoln := 1;           // �����������
  END;
    IF vipoln=0 THEN
  begin
  ShowMovingsForm.Error := 3;
  EXIT; // �������� �� ���� �� �����������
  end;

  // ��������� �������� ����������� ���
  vipoln := 0 ; // ��������� ����������
  WHILE NOT Eof(F) DO BEGIN
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
    vipoln := 1;           // �����������
  END;
  IF vipoln=0 THEN
  begin
  ShowMovingsForm.Error := 4;
  EXIT; // �������� �� ���� �� �����������
  end;

  m:=0;
  // ���������� ������ ����� ����� �������������
  vipoln := 0 ; // ��������� ����������
  WHILE NOT Eof(F) DO BEGIN
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
    INC(m);
    MyREAD(ADDR(y),8);
    n:=FindNode(x,y);
    IF n = 0 THEN EXIT;
    OneNode:=GetNode(n);
    OneNode.RenumNum:=m;
    EditNode(n,OneNode);
    vipoln := 1;           // �����������
  END;
    IF vipoln=0 THEN
  begin
  ShowMovingsForm.Error := 5;
  EXIT; // �������� �� ���� �� �����������
  end;

  m:=0;
  // ��������� ����������� �����
   vipoln := 0 ; // ��������� ����������
  WHILE NOT Eof(F) DO BEGIN
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
    vipoln := 1;           // �����������
  END;
  IF vipoln=0 THEN
  begin
  ShowMovingsForm.Error := 6;
  EXIT; // �������� �� ���� �� �����������
  end;
  Close(F);  
  Error:=0;

END;


PROCEDURE TNodes.AddNode(OneNode:TOneNode);
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


PROCEDURE TNodes.UpDateWithMove(Move:MyReal);
VAR
  OneNode : TOneNode;
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


PROCEDURE TNodes.EditNode(Number:INTEGER;OneNode:TOneNode);
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


FUNCTION TNodes.GetNode(n:INTEGER):TOneNode;
BEGIN
  Result:=ArrayOfNodes[n-1];
END;


FUNCTION TNodes.GetMovedNode;
VAR OneNode : TOneNode;
BEGIN
  OneNode:=GetNode(n);
  OneNode.x:=OneNode.x+OneNode.DX*Move/10;
  OneNode.y:=OneNode.y+OneNode.DY*Move/10;
  Result:=OneNode;
END;


FUNCTION TNodes.FindNode(x,y:MyReal):INTEGER;
CONST tochn = 0.01;
VAR
  i,r     : INTEGER;
  xxx,yyy : MyReal;

BEGIN
  r:=0;
  FOR i:=1 TO CountOfNodes DO BEGIN
    xxx:=ABS(ArrayOfNodes[i-1].x-x);
    yyy:=ABS(ArrayOfNodes[i-1].y-y);
    IF (xxx<=tochn) AND (yyy<=tochn) THEN r:=i;
  END;
  Result:=r;
END;


FUNCTION TNodes.FindRenumNode(n:INTEGER):INTEGER;
VAR i,r : INTEGER;
BEGIN
  r:=0;
  FOR i:=1 TO CountOfNodes DO
  IF ArrayOfNodes[i-1].RenumNum=n THEN r:=i;
  Result:=r;
END;


FUNCTION TNodes.SetFirstElement;
BEGIN
  IF CountOfNodes<0 THEN Result:=False
  ELSE BEGIN
    CurrentNode:=0;
    Result:=True;
  END;
END;


FUNCTION TNodes.SetNextElement;
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


FUNCTION TNodes.GetCurrentElement;
BEGIN
  Result:=CurrentNode+1;
END;

FUNCTION TNodes.GetCountOfNodes;
Begin
Result:=CountOfNodes;
END;


CONSTRUCTOR TElements.Create;
BEGIN
END;


//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------


PROCEDURE TElements.LoadElements(Path:STRING);
VAR
  OneElement : TOneElement;
  x          : DOUBLE;
  j          : BYTE;
  i,n,n1     : WORD;


BEGIN
  Error:=1;
  CountOfElements:=0;
  SetLength(ArrayOfElements,0);
  IF NOT FileExists(Path) THEN EXIT;
  AssignFile(F,Path);
  Reset(F);
  // ��������� ���������� �����, ������������ ��
  WHILE NOT Eof(F) DO BEGIN
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
  // ��������� �������� ���������� � ��
  WHILE NOT Eof(F) DO BEGIN
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
  // ��������� ��-�� ��������� ��   kotov
  n:=0;
  WHILE NOT Eof(F) DO BEGIN
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
  WHILE NOT Eof(F) DO BEGIN
    MyREAD(ADDR(n1),2);
    IF n1 = 65535 THEN BREAK;
    INC(n);
    OneElement:=GetElement(n);
    OneElement.Material:=n1;
    EditElement(n,OneElement);
  END;

  Close(F);
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


PROCEDURE TElements.AddElement(OneElement:TOneElement);
BEGIN
  INC(CountOfElements);
  SetLength(ArrayOfElements,CountOfElements);
  ArrayOfElements[CountOfElements-1]:=OneElement;
END;


PROCEDURE TElements.EditElement(Number:INTEGER;OneElement:TOneElement);
BEGIN
  ArrayOfElements[Number-1]:=OneElement;    
END;


FUNCTION TElements.GetElement(n:INTEGER):TOneElement;
BEGIN
  Result:=ArrayOfElements[n-1];
END;

// ���������� ���������� ���������
FUNCTION TElements.GetNumElements():INTEGER;
BEGIN
  Result:=CountOfElements;
END;

FUNCTION TElements.FindElement(n:INTEGER):INTEGER;
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


FUNCTION TElements.SetFirstElement;
BEGIN
  IF CountOfElements<0 THEN Result:=False
  ELSE BEGIN
    CurrentElement:=0;
    Result:=True;
  END;
END;


FUNCTION TElements.SetNextElement;
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


FUNCTION TElements.GetCurrentElement;
BEGIN
  Result:=ArrayOfElements[CurrentElement];
END;


// ����������� ���� ����� ����� ��������� �������� ����� ����� (x1,y1)
FUNCTION MyDiv(x,y:MyReal):MyReal;
BEGIN
  IF ABS(y)<0.1E-4900 THEN Result:=0.1E-4900 ELSE Result:=x/y;
END;


FUNCTION Coner(x1,y1,x2,y2,x3,y3:MyReal):MyReal;
BEGIN
  TRY
  Result:=ArcCos(MyDiv((x2-x1)*(x3-x1)+(y2-y1)*(y3-y1),sqrt((sqr(x2-x1)+sqr(y2-y1))*(sqr(x3-x1)+sqr(y3-y1)))));
  EXCEPT
    ON EMathError DO Result:=Pi;
    ON EInvalidOp DO Result:=Pi;
  END;
END;


// �������� ���� c1 ������ �� ���� c2
FUNCTION Is_BiggerConer(c1,c2:MyReal):BOOLEAN;
BEGIN
  IF C1<0 THEN C1:=C1+(2*Pi);
  IF C2<0 THEN C2:=C2+(2*Pi);
  IF C1>=C2 THEN Result:=true
  ELSE Result:=false;
END;


// �������� ����������� �� ����� (x,y) ������������ (x1,y1),(x2,y2),(x3,y3)
FUNCTION TestTriangle(x,y,x1,y1,x2,y2,x3,y3:MyReal):BOOLEAN;
VAR c1,c2,c3 : BOOLEAN;
BEGIN
  IF Is_BiggerConer(coner(x1,y1,x2,y2,x3,y3),coner(x1,y1,x2,y2,x,y)) THEN c1:=True ELSE c1:=False;
  IF Is_BiggerConer(coner(x2,y2,x3,y3,x1,y1),coner(x2,y2,x3,y3,x,y)) THEN c2:=True ELSE c2:=False;
  IF Is_BiggerConer(coner(x3,y3,x1,y1,x2,y2),coner(x3,y3,x1,y1,x,y)) THEN c3:=True ELSE c3:=False;
  Result:=c1 AND c2 AND c3;
END;


FUNCTION TElements.FindElementByPoint;
VAR
  OneNode  : TOneNode;
  x1,x2,x3 : MyReal;
  y1,y2,y3 : MyReal;
  Res      : INTEGER;
  i        : WORD;

BEGIN
  Res:=-1;
  IF CountOfElements>0 THEN BEGIN
    FOR i:=0 To CountOfElements-1 DO BEGIN
      Nodes_Result.GetNode(ArrayOfElements[i].Node1);
      OneNode:=Nodes_Result.GetMovedNode(ArrayOfElements[i].Node1,Move);
      x1:=OneNode.x;
      y1:=OneNode.y;
      OneNode:=Nodes_Result.GetMovedNode(ArrayOfElements[i].Node2,Move);
      x2:=OneNode.x;
      y2:=OneNode.y;
      OneNode:=Nodes_Result.GetMovedNode(ArrayOfElements[i].Node3,Move);
      x3:=OneNode.x;
      y3:=OneNode.y;
      IF TestTriangle(x,y,x1,y1,x2,y2,x3,y3) THEN Res:=i;
    END;
  END;
  Result:=Res;
END;

CONSTRUCTOR ZoneContourPoints.Create;
BEGIN
END;

PROCEDURE ZoneContourPoints.SetZonePoints(Number: Shortint; Points: array of Double);
var
  i : Shortint;
begin
  if ((Number<=20)and(Number>=1)) then begin
    if (Number > NumberOfZones) then NumberOfZones := Number;
    for i := 1 to 16 do begin
      ArrayOfPoints[Number, i]:=Points[i-1];
    end;
  end;
end;

PROCEDURE ZoneContourPoints.GetZonePoints(Number: Shortint; var Points: array of Double);
var
  i             : Shortint;
begin
  if (Number <= NumberOfZones) then begin
    for i := 1 to 16 do begin
      Points[i-1]:= ArrayOfPoints[Number,i];
    end;
  end
  else begin
    for i := 1 to 16 do begin
      Points[i-1]:=0;
    end;
  end;
end;

PROCEDURE ZoneContourPoints.LoadZones(Path:String);
VAR
  n           : Word;
  k,i         : Word;
  points      : Array[1..16] of Double;
  x           : Double;
BEGIN
  ZoneContour.Error := 1;
  IF NOT FileExists(Path) THEN EXIT;
  AssignFile(F,Path);
  Reset(F);
//���� ������ ����� ��������� ����� -1, ����� ��������� �� ������ �����������
  n:=0;
  while not EOF(F) do begin
    MyREAD (ADDR(n), 2);
    IF n = 65535 THEN BREAK;
  end;
  x:=0;
  while not EOF(F) do begin
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
  end;
  x:=0;
  while not EOF(F) do begin
    MyREAD(ADDR(x),8);
    IF x = -1 THEN BREAK;
  end;
  n:=0;
  while not EOF(F) do begin
    MyREAD (ADDR(n), 2);
    IF n = 65535 THEN BREAK;
  end;
  //��������� ���������� ���, �� ������� ������� ��������
  n:=0;
  while not EOF(F) do begin
    MyREAD (ADDR(n), 2);
    if n=65535 then break;
    k:=n;
  end;
//��������� �����, �������� ��� ����
  k:=0;
  while not Eof(F) do begin
    inc(k);
    for i := 1 to 16 do begin
      MyREAD(ADDR(x),8);
      if x=-1 then break;
      points[i]:=x;
    end;
    if x=-1 then break;
    ZoneContour.SetZonePoints(k,points);
  end;
  Close(F);
  ZoneContour.Error:=0;
END;

FUNCTION ZoneContourPoints.GetNumberOfZones;
begin
  Result := ZoneContour.NumberOfZones;
end;

END.
