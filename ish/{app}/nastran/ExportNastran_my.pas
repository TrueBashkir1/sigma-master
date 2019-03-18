unit ExportNastran_my;

interface

uses ResultsArrays, ChooseCalc,MSXML,ComObj,Dialogs,IdGlobal;
//uses ResultsArrays, ChooseCalc,MSXML2_TLB,ComObj;

type MyReal=real;
Var
     StartCoordinates : String;
     StartForce       : String;
     StartBound       : String;
     StartRenum       : String;
     StartElements    : String;
     StartWidth       : String;
procedure NastranExport(ResultFile,FilePath:string);
implementation
uses SysUtils,Windows;
Function DelSpaces(s:String):String;
Var
     i, n, l : integer;
Begin
     L:=length(s);
     n:=0;
     For I:=1 To l Do
     Begin
          If (S[i]<>' ') Then
          Begin
               inc(n);
               S[n]:=S[i];
          End;
     End;
     SetLength(s,n);
     result:=s;
End;
Function StrToMyReal(Var s:String; st,l:integer; Var Err:integer):MyReal;
Var
     x : MyReal;
Begin
     val(DelSpaces(copy(S,st,l)),x,Err);
     Result:=x;
End;
Function StrToInteger(Var s:String; st,l:integer; Var Err:integer):Integer;
Var
     x : Integer;
Begin
     val(DelSpaces(copy(S,st,l)),x,Err);
     Result:=x;
End;
{=========================================}
{Процедура конвертирования в Nastran}
procedure Header(var Handle:TextFile);{ == Запись шапки ==== }
var
     Formated:string;
     time:SystemTime;
begin
     GetLocalTime(time);
     Formated:=Format('%02d %02d %04d %02d:%02d:%02d',[time.wDay, time.wMonth, time.wYear, time.wHour, time.wMinute, time.wSecond]);
     Writeln(Handle, 'ID SIGMA32,FEMAP');
     Writeln(Handle, 'SOL SESTATICS');
     Writeln(Handle, 'TIME 10000');
     Writeln(Handle, 'CEND');
     Writeln(Handle, '  ECHO = NONE');
     Writeln(Handle, '  DISPLACEMENT(PLOT) = ALL');
     Writeln(Handle, '  SPCFORCE(PLOT) = ALL');
     Writeln(Handle, '  OLOAD(PLOT) = ALL');
     Writeln(Handle, '  FORCE(PLOT,CORNER) = ALL');
     Writeln(Handle, '  STRESS(PLOT,CORNER) = ALL');
     Writeln(Handle, '  SPC = 1');
     Writeln(Handle, '  LOAD = 1');
     Writeln(Handle, 'BEGIN BULK');
     Writeln(Handle, '$ ***************************************************************************');
     Writeln(Handle, '$   Written by : FEMAP');
     Writeln(Handle, '$   Version    : 6.00');
     Writeln(Handle, '$   Translator : MSC/NASTRAN');
     Writeln(Handle, '$   From Model : Sigma32_MODEL');
     Writeln(Handle, '$   Date       : '+Formated);
     Writeln(Handle, '$ ***************************************************************************');
     Writeln(Handle, '$');
     Writeln(Handle, 'PARAM,POST,-1');
     Writeln(Handle, 'PARAM,OGEOM,NO');
     Writeln(Handle, 'PARAM,AUTOSPC,YES');
     Writeln(Handle, 'PARAM,GRDPNT,0');
     Writeln(Handle, 'CORD2C         1       0      0.      0.      0.      0.      0.      1.+FEMAPC1');
     Writeln(Handle, '+FEMAPC1      1.      0.      1.');
     Writeln(Handle, 'CORD2S         2       0      0.      0.      0.      0.      0.      1.+FEMAPC2');
     Writeln(Handle, '+FEMAPC2      1.      0.      1.');
end;
function toPoint(S:String{const form:String; x:MyReal}): String;
var
     {s,}r:String;
     i,l:integer;
begin
     //s:=Format(form,[x]);
     l:=Length(s);
     r:='';
     for i:=1 to l do if s[i]=',' then r:=r+'.' else r:=r+s[i];
     Result:=r;
end;

function ForceFormat(N:Integer; RX,RY:MyReal):String;
begin//FORCE          1{номер узла}       0      1.{нагрузка по X}{нагрузка по Y}     0.
     Result:=toPoint(Format('FORCE          1%8d       0      1.%8.1f%8.1f     0.',[N, RX, RY]));
end;
function BoundFormat(N:Integer; boundtype:byte):String;
var
     bound:integer;
begin//SPC            1{номер узла}{ограничение}      0.
     case boundtype of
      1: bound:=23456;
     10: bound:=13456;
     11: bound:=123456
     else bound:=36;
     end;{case}
     Result:=toPoint(Format('SPC            1%8d%8d      0.',[N, bound]));
end;
function WidthFormat(Width:MyReal):String;
begin//PSHELL         1       1{толщина}       1               1              0.
     Result:=toPoint(Format('PSHELL         1       1%8f       1               1              0.',[Width]));
end;
function KoordFormat(N:Integer; X,Y:MyReal):String;
begin//GRID      {номер узла}       0{X}{Y}      0.       0
     Result:=toPoint(Format('GRID    %8d       0%8f%8f      0.       0',[N, X, Y]));
end;
function ElementFormat(N,n1,n2,n3:Integer):String;
begin//CTRIA3       {номер элемента}       0{узел1}{узел2}{узел3}      0.       0
     Result:=toPoint(Format('CTRIA3  %8d       1%8d%8d%8d',[N, n1,n2,n3]));
end;

function ElementFormat_angle(N,n1,n2,n3:Integer; angle:MyReal):String;
begin//CTRIA3       {номер элемента}       0{узел1}{узел2}{узел3}      0.       0
     Result:=toPoint(Format('CTRIA3  %8d       1%8d%8d%8d%8f',[N, n1,n2,n3,angle]));
end;

procedure NForces(var Handle:TextFile);{ ===  Запись NFORCE  == }
var
     i:integer;
     Node : TOneNode;
begin
//FORCE          1     225       0      1.     0.0  3000.0     0.

     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         if (Node.ForceX<>0) or (Node.ForceY<>0) then
                        Writeln(Handle,ForceFormat(Node.RenumNum,Node.ForceX,Node.ForceY));
     end;
end;

procedure NBounds(var Handle:TextFile);{ ===  Запись FORCE  == }
var
     i,old:integer;
     Node : TOneNode;
begin
     old:=0;
     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         if (Node.BondType <> 0) then begin
                if (old<>0) then begin
                        inc(old);
                        while old<Node.RenumNum do begin
                                Writeln(Handle,BoundFormat(old,0));
                                inc(old);
                        end;
                end;
                Writeln(Handle,BoundFormat(Node.RenumNum,Node.BondType));
                old:=Node.RenumNum;
          end;
    end;
end;

procedure NMaterial(var Handle:TextFile);
begin
     {  ===  Копирование материала  - разобраться с тем что собирался доделать предыдущей программер "ДОДЕЛАТЬ, материал переименовать"}
     Writeln(Handle, '$ FEMAP Material 1 : AISI 4340 Steel');
     Writeln(Handle, 'MAT1           1  2.9E+7  1.1E+7    0.327.331E-4  6.6E-6     70.        +MT    1');
     Writeln(Handle, '+MT    1 215000. 240000. 156000.');
     Writeln(Handle, 'MAT4           14.861E-4   38.647.331E-4');
end;

procedure NewProperty(var Handle:TextFile; FilePath:String);
var
s1,s2,s3,s4: string;
F: TextFile;
i: Integer;
res: string;
begin
    AssignFile(F,FilePath+'nastran.ns0');
    Reset(F);
    i:=2;
  WHILE NOT Eof(F) DO BEGIN
    Readln(F, s1); // ORT(1)
    Readln(F, s2); // ORT(2)
    Readln(F, s3); // ORT(3)
    Readln(F, s4); // ORT(7)
    res:='$ FEMAP Property '+IntToStr(i)+' : Sigma_Property_'+IntToStr(i);
    Writeln(Handle,res);
    res:='PCOMP          '+IntToStr(i)+'              0.                                        +';
    Writeln(Handle,res);
    res:='+              '+IntToStr(i)+'     '+s4+'    0.     YES';
    Writeln(Handle,res);
    i:=i+1;
  end;
    CloseFile(F);
end;

procedure NewMaterial(var Handle:TextFile; FilePath:String);
var
s1,s2,s3,s4: string;
F: TextFile;
i: Integer;
res: string;
begin
     {  ===  Копирование материала  - разобраться с тем что собирался доделать предыдущей программер "ДОДЕЛАТЬ, материал переименовать"}
     Writeln(Handle, '$ FEMAP Material 1 : AISI 4340 Steel');
     Writeln(Handle, 'MAT1           1  2.9E+7  1.1E+7    0.327.331E-4  6.6E-6     70.        +MT    1');
     Writeln(Handle, '+MT    1 215000. 240000. 156000.');
     Writeln(Handle, 'MAT4           14.861E-4   38.647.331E-4');
    AssignFile(F,FilePath+'nastran.ns0');
    Reset(F);
    i:=2;
  WHILE NOT Eof(F) DO BEGIN
    Readln(F, s1); // ORT(1)
    Readln(F, s2); // ORT(2)
    Readln(F, s3); // ORT(3)
    Readln(F, s4); // ORT(7)
    res:='$ FEMAP Material '+IntToStr(i)+' : Sigma_Material_'+IntToStr(i);
    Writeln(Handle,res);
    res:='MAT1           '+s1+'             '+s2+'      0.      0.      0.        +MT    '+IntToStr(i);
    Writeln(Handle,res);
    res:='+MT    '+IntToStr(i)+' '+s3;
    Writeln(Handle,res);
    i:=i+1;
  end;
    CloseFile(F);
end;

procedure NKoords(var Handle:TextFile);{  ===== Координаты узлов   ===== }
var
     i:integer;
     Node : TOneNode;
begin
     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         Writeln(Handle,KoordFormat(Node.RenumNum,Node.x,Node.y));
     end;
end;

procedure NElements(var Handle:TextFile);{ === Запись Элементов === }
var
     Element: TOneElement;
     Node:    TOneNode;
     enum1,enum2,enum3:integer;
     i:Integer;
begin

     for i:=0 to Elements_Result.CountOfElements-1 do begin
           Element:= Elements_Result.GetElement(i+1);
           Node:=Nodes_Result.GetNode(Element.Node1);enum1:=Node.RenumNum;
           Node:=Nodes_Result.GetNode(Element.Node2);enum2:=Node.RenumNum;
           Node:=Nodes_Result.GetNode(Element.Node3);enum3:=Node.RenumNum;
           Writeln(Handle,ElementFormat(Element.Number,enum1,enum2,enum3));
     end;
end;

procedure New_NElements(var Nastran:TextFile; Path: String);
var                                             { === Корректная запись элементов === }
                                                { с учетом номеров свойств материала  }
     F: TextFile;
     S1,S2: String;
begin
    AssignFile(F,Path+'nastran.ns1');
    Reset(F);
  WHILE NOT Eof(F) DO BEGIN
    Readln(F, S1);
    S2:='CTRIA3      '+S1;
    Writeln(Nastran,S2);
    end;
    CloseFile(F);
end;

procedure NElements_angle(var Handle:TextFile);{ === Запись Элементов === }
var
     Element: TOneElement;
     Node1,Node2,Node3:    TOneNode;
     angle : MyReal;
     enum1,enum2,enum3:integer;
     i:Integer;
begin
     for i:=0 to Elements_Result.CountOfElements-1 do begin
           Element:= Elements_Result.GetElement(i+1);
           Node1:=Nodes_Result.GetNode(Element.Node1);enum1:=Node1.RenumNum;
           Node2:=Nodes_Result.GetNode(Element.Node2);enum2:=Node2.RenumNum;
           Node3:=Nodes_Result.GetNode(Element.Node3);enum3:=Node3.RenumNum;
           if ((Node2.x - Node1.x)<>0) then  begin
                angle := arctan((Node2.y - Node1.y)/(Node2.x - Node1.x))*180/3.1415926;
           end else begin
                if (Node2.y>Node1.y) then angle := 90
                        else angle:=-90;
           end;
           Writeln(Handle,ElementFormat_angle(Element.Number,enum1,enum2,enum3,-angle));
     end;
end;

function NWidthFormat_angle(ReadFile:string):String;
var
        RHandle:TextFile;
        Width: MyReal;
        s,sverify:string;
        Err: integer;
begin
        Width:=0;
        AssignFile(RHandle,Readfile);
        Reset(RHandle);
        while (not EOF(RHandle)) do begin
            readln (RHandle,s);
            sverify := copy(s,8,length(s)-1);
            if (sverify = '- DD (THICKNESS)') then begin
                Width:=StrToMyReal(s,0,5,Err);
                break;
            end;

        end;
        Close(RHandle);
      {
    AssignFile(F,FilePath+'nastran.ns0');
    Reset(F);
  WHILE NOT Eof(F) DO BEGIN
    Readln(F, s1); // ORT(1)
    Readln(F, s2); // ORT(2)
    Readln(F, s3); // ORT(3)
    Readln(F, s4); // ORT(7)
  end;
    CloseFile(F);
     Width:= 1.10;
       }
        Result:=toPoint(Format('+              1%8f      0.     YES',[Width]));
end;

function NWidthFormat(ReadFile:string):String;
var
        RHandle:TextFile;
        Width: MyReal;
        s,sverify:string;
        Err: integer;
begin
        Width:=0;
        AssignFile(RHandle,Readfile);
        Reset(RHandle);
        while (not EOF(RHandle)) do begin
            readln (RHandle,s);
            sverify := copy(s,11,length(s)-1);
            if (sverify = '- DD (THICKNESS)') then begin
                Width:=StrToMyReal(s,0,10,Err);
                break;
            end;

        end;
        Close(RHandle);

    {
    AssignFile(F,FilePath+'nastran.ns0');
    Reset(F);
  WHILE NOT Eof(F) DO BEGIN
    Readln(F, s1); // ORT(1)
    Readln(F, s2); // ORT(2)
    Readln(F, s3); // ORT(3)
    Readln(F, s4); // ORT(7)
  end;
    CloseFile(F);
     Width:= 1.10;
     }

//PSHELL         1       1{толщина}       1               1              0.
        Result:=toPoint(Format('PSHELL         1       1%8f       1               1              0.',[Width]));
end;

procedure XML_export(FilePath:string);
var doc                 : IXMLDOMDocument;
    root, child, child1 : IXMLDOMElement;
    child2              : IXMLDOMElement;
    xml                 : String;
    i                   : integer;
    enum1,enum2,enum3   : integer;
    angle               : MyReal;
    Node                : TOneNode;
    Node1,Node2,Node3   : TOneNode;
    Element             : TOneElement;
begin
     xml  :='Sigma';
     doc  := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
     doc.appendChild(doc.createProcessingInstruction('xml','version="1.0"'));
     doc.appendChild(doc.createComment('Это тестовая версия генерируемого XML-файла.'));
     root := doc.createElement(xml);
     root.normalize;
     root.setAttribute('Version','4.71');
     root.setAttribute('ReleaseDate','10 мая 2004');
     root.appendChild(doc.createComment('В принципе, сюда можно добавлять любую информацию, касающуюся работы и свойств Сигмы'));
     doc.appendchild(root);
     child:= doc.createElement('Points_Data');
     child.appendChild(doc.createComment('Информация, относящаяся к точкам'));
     root.appendchild(child);
     child1 := doc.createElement('Coordinates');
     child1.appendChild(doc.createComment('Координаты точек.'));
     child1.appendChild(doc.createComment('RenumNum - номер точки после сортировки и перенумерации'));
     child.appendchild(child1);

     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         child2:=doc.createElement('Point');
         child2.setAttribute('Number',Node.Number);
         child2.setAttribute('X',Node.x);
         child2.setAttribute('Y',Node.y);
         child2.setAttribute('RenumNum',Node.RenumNum);
         child1.appendChild(child2);
     end;
     child1 := doc.createElement('Forces');
     child1.appendChild(doc.createComment('Силы, действующие на точки'));
     child.appendchild(child1);
     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         if (Node.ForceX<>0) or (Node.ForceY<>0) then begin
                child2:=doc.createElement('Force');
                child2.setAttribute('RenumNum',Node.RenumNum);
                child2.setAttribute('ForceX',Node.ForceX);
                child2.setAttribute('ForceY',Node.ForceY);
                child1.appendChild(child2);
         end
     end;
     child1 := doc.createElement('Bounds');
     child1.appendChild(doc.createComment('Закрепления точек.'));
     child.appendchild(child1);
     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         if (Node.BondType<>0) then begin
                child2:=doc.createElement('Bound');
                child2.setAttribute('RenumNum',Node.RenumNum);
                child2.setAttribute('Bondtype',Node.BondType);
                if (Node.BondType=1) then
                        child2.appendChild(doc.createTextNode('Закрепление по оси Х'))
                else if (Node.BondType=10) then
                        child2.appendChild(doc.createTextNode('Закрепление по оси Y'))
                else if (Node.BondType=11) then
                        child2.appendChild(doc.createTextNode('Закрепление по обоим осям'));

                child1.appendChild(child2);
         end;
     end;
     child1 := doc.createElement('Shifts');
     child1.appendChild(doc.createComment('Смещение точек относительно осей X и Y.'));
     child.appendchild(child1);
     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         child2:=doc.createElement('Shift');
         child2.setAttribute('RenumNum',Node.RenumNum);
         child2.setAttribute('SX',Node.DX);
         child2.setAttribute('SY',Node.DY);
         child1.appendChild(child2);
     end;
     child:= doc.createElement('Elements_Data');
     child.appendChild(doc.createComment('Информация, относящаяся к элементам'));
     root.appendchild(child);

     child1 := doc.createElement('Elements_Nodes');
     child1.appendChild(doc.createComment('Узлы, из которых состоят элементы'));
     child1.appendChild(doc.createComment('Значение Angle указано в градусах и считается по часовой стрелке (как для экспорта в Femap)'));
     child.appendchild(child1);
     for i:=0 to Elements_Result.CountOfElements-1 do begin
           Element:= Elements_Result.GetElement(i+1);
           Node1:=Nodes_Result.GetNode(Element.Node1);enum1:=Node1.RenumNum;
           Node2:=Nodes_Result.GetNode(Element.Node2);enum2:=Node2.RenumNum;
           Node3:=Nodes_Result.GetNode(Element.Node3);enum3:=Node3.RenumNum;
           child2:=doc.createElement('Element');
           child2.setAttribute('Node1',enum1);
           child2.setAttribute('Node2',enum2);
           child2.setAttribute('Node3',enum3);
           if ((Node2.x - Node1.x)<>0) then  begin
                angle := arctan((Node2.y - Node1.y)/(Node2.x - Node1.x))*180/3.1415926;
           end else begin
                if (Node2.y>Node1.y) then angle := 90
                        else angle:=-90;
           end;
           child2.setAttribute('Angle',-angle);
           child1.appendChild(child2);
     end;

     child1 := doc.createElement('Strains');
     child1.appendChild(doc.createComment('Напряжения в элементах.'));
     child1.appendChild(doc.createComment('Strain1 - Напряжение по Х.'));
     child1.appendChild(doc.createComment('Strain2 - Напряжение по Y.'));
     child1.appendChild(doc.createComment('Strain3 - Касательное напряжение.'));
     child1.appendChild(doc.createComment('Strain4 - 1-ое главное напряжение.'));
     child1.appendChild(doc.createComment('Strain5 - 2-ое главное напряжение.'));
     child1.appendChild(doc.createComment('Strain6 - Эквивалентное напряжение.'));
     child1.appendChild(doc.createComment('Strain7 - Угол.'));
     child.appendchild(child1);
     for i:=0 to Elements_Result.CountOfElements-1 do begin
           Element:= Elements_Result.GetElement(i+1);
           child2:=doc.createElement('Strain');
           child2.setAttribute('Number',Element.Number);
           child2.setAttribute('Strain1',Element.strain[1]);
           child2.setAttribute('Strain2',Element.strain[2]);
           child2.setAttribute('Strain3',Element.strain[3]);
           child2.setAttribute('Strain4',Element.strain[4]);
           child2.setAttribute('Strain5',Element.strain[5]);
           child2.setAttribute('Strain6',Element.strain[6]);
           child2.setAttribute('Strain7',Element.strain[7]);
           child1.appendChild(child2);
     end;
     root.normalize;
     doc.save(FilePath+xml+'.xml');
end;

procedure NastranExport(ResultFile,FilePath:string);
var
        Handle  :TextFile;
        Nastran :TextFile;
begin

     ChoosecalcForm := TChooseCalcForm.Create(nil);
     ChooseCalcForm.Icon.Handle:=LoadIcon(HInstance,'MAINICON');
     ChooseCalcForm.ShowModal;
//     AssignFile(Handle,FilePath+'example.dat');
     AssignFile(Handle,ResultFile);
     Rewrite(Handle);
     Header(Handle);
     Writeln(Handle, '$ FEMAP Load Set 1 : Sigma32 1');
     Nodes_Result:=TNodes.Create;
     Nodes_Result.LoadNodes(FilePath+'RESULT1.BIN');
     IF Nodes_Result.Error<>0 THEN EXIT;
     NForces(Handle);
     Writeln(Handle, '$ FEMAP Constraint Set 1 : Sigma32 SPC 1');
     NBounds(Handle);

     if (ChooseCalcForm.RadioButton1.Checked) then begin
        Writeln(Handle, '$ FEMAP Property 1 : Untitled');
        Writeln(Handle, NWidthFormat(FilePath+'data'));
        NMaterial(Handle);
     end else if (ChooseCalcForm.RadioButton2.Checked) then begin
        Writeln(Handle, '$ FEMAP Property 1 : laminate');
        Writeln(Handle, 'PCOMP          1              0.                                        +       ');
        Writeln(Handle, NWidthFormat_angle(FilePath+'data'));
        NMaterial(Handle);
     end else if (ChooseCalcForm.RadioButton3.Checked) then begin
        Writeln(Handle, '$ FEMAP Property 1 : Untitled');
        Writeln(Handle, NWidthFormat(FilePath+'data'));
        NewProperty(Handle,FilePath);
        NewMaterial(Handle,FilePath);
     end;
     NKoords(Handle);
     Elements_Result:=TElements.Create;
     Elements_Result.LoadElements(FilePath+'RESULT2.BIN');

     if (ChooseCalcForm.RadioButton1.Checked) then NElements(Handle)
     else if (ChooseCalcForm.RadioButton2.Checked) then NElements_angle(Handle)
     else if (ChooseCalcForm.RadioButton3.Checked) then New_NElements(Handle,FilePath);
     Writeln(Handle,'ENDDATA');
     CloseFile(Handle);
{***** моё ******}
     CloseFile(Nastran);
{***** моё ******}
     ChooseCalcForm.Close;
     ChooseCalcForm.Destroy;

     //----XML EXPORT---///
//     XML_Export(FilePath);

end;
end.