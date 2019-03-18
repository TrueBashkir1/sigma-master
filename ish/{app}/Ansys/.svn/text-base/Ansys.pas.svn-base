// Export to Ansys (Written by: Shevchenko T.L., 26.11.2005) -->
unit Ansys;

interface

uses
  Dialogs,ResultsArrays,SysUtils;

procedure NForces(var Handle:TextFile); //Output of all forces
procedure NBounds(var Handle:TextFile); //Output of all bounds
procedure NElements(var Handle:TextFile); //Output of all elements and nodes making them
procedure NNodes(var Handle:TextFile); // Output of all nodes and their cordinates
procedure NAddNodesToElements(); // Added 3 node to element (Sigma - 3-х узловой КЭ, Ansys - 6-ти узловой)
procedure NAddNodes(x,y:MyReal; n:INTEGER); // Added node to list of nodes
function NWidthFormat(ReadFile:string):String; // Prepare string with "Thickness"
Function StrToMyReal(Var s:String; st,l:integer; Var Err:integer):MyReal;
Function DelSpaces(s:String):String;
function toPoint(S:String): String; // Replace comma to point
function NModuleEFormat(ReadFile:string):String; // Prepare string with module of elasticity
function NPuassonFormat(ReadFile:string):String; // Prepare string with coefficient of Puasson
function calcPrecision(S:String): Integer; // Calculation of precision (for function "Format")

implementation

procedure NForces(var Handle:TextFile);
var
     i:integer;
     Node : TOneNode;
begin
     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         if (Node.ForceX<>0) then
                Writeln(Handle,Format('F,%7d,FX  ,',[Node.RenumNum]) + toPoint(Format('%16.*f',
                        [(16-calcPrecision(floattostr(Node.ForceX))-1),Node.ForceX])) +',  0.00000000    ');
         if (Node.ForceY<>0) then
                Writeln(Handle,Format('F,%7d,FY  ,',[Node.RenumNum]) + toPoint(Format('%16.*f',
                        [(16-calcPrecision(floattostr(Node.ForceY))-1),Node.ForceY])) +',  0.00000000    ');
     end;
end;

procedure NBounds(var Handle:TextFile);
var
     i,old:integer;
     Node : TOneNode;
     sBound:string;
begin
     old:=0;
     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Node:= Nodes_Result.GetNode(i+1);
         if (Node.BondType <> 0) then begin
                if (old<>0) then begin
                        inc(old);
                        while old<Node.RenumNum do begin
                                inc(old);
                        end;
                end;
                case Node.BondType of
// Bounds as Ansys
                10: sBound:='UX';
                1:  sBound:='UY';
// Bounds as Sigma
                { 1: sBound:='UX';
                10: sBound:='UY'; }
                11: sBound:='ALL';
                end;
                if(sBound <> 'ALL') then
                        begin
                        Writeln(Handle,Format('D,%7d,'+sBound+'  ,  0.00000000    ,  0.00000000    ',[Node.RenumNum]));
                        end
                else
                        begin
                        sBound:='UX';
                        Writeln(Handle,Format('D,%7d,'+sBound+'  ,  0.00000000    ,  0.00000000    ',[Node.RenumNum]));
                        sBound:='UY';
                        Writeln(Handle,Format('D,%7d,'+sBound+'  ,  0.00000000    ,  0.00000000    ',[Node.RenumNum]));
                        end;
                old:=Node.RenumNum;
          end;
    end;
end;

procedure NElements(var Handle:TextFile);
var
     Element: TOneElement;
     Node:    TOneNode;
     enum1,enum2,enum3,enum4,enum5,enum6:integer;
     i:Integer;
begin
     for i:=0 to Elements_Result.CountOfElements-1 do begin
           Element:= Elements_Result.GetElement(i+1);
           Node:=Nodes_Result.GetNode(Element.Node1);enum1:=Node.RenumNum;
           Node:=Nodes_Result.GetNode(Element.Node2);enum2:=Node.RenumNum;
           Node:=Nodes_Result.GetNode(Element.Node3);enum3:=Node.RenumNum;
           Node:=Nodes_Result.GetNode(Element.Node4);enum4:=Node.Number;
           Node:=Nodes_Result.GetNode(Element.Node5);enum5:=Node.Number;
           Node:=Nodes_Result.GetNode(Element.Node6);enum6:=Node.Number;
           Writeln(Handle,Format('       1       1       1       1       0       0       0       0       6       0%8d%8d%8d%8d%8d%8d%8d',
           [Element.Number,enum1,enum2,enum3,enum4,enum5,enum6]));
     end;
end;

procedure NNodes(var Handle:TextFile);
var
     Node,Tmp:    TOneNode;
     i:Integer;
begin
     for i:=0 to Nodes_Result.CountOfNodes-1 do begin
         Tmp := Nodes_Result.FindNodeByRenum(i+1);
         if Tmp.Number <> -1 then
         begin
           Node:= Nodes_Result.FindNodeByRenum(i+1);
             Writeln(Handle,toPoint(Format('%8d       0       0  %10.*f      %10.*f',
                                           [Node.RenumNum,(10-calcPrecision(floattostr(Node.x))-1),Node.x,(10-calcPrecision(floattostr(Node.y))-1),Node.y])));

         end
         else
         begin
           Node:= Nodes_Result.GetNode(i+1);
             Writeln(Handle,toPoint(Format('%8d       0       0  %10.*f      %10.*f',
                                           [Node.Number,(10-calcPrecision(floattostr(Node.x))-1),Node.x,(10-calcPrecision(floattostr(Node.y))-1),Node.y])));
         end
     end;
end;

procedure NAddNodesToElements();
var
     OneElement        : TOneElement;
     Node1,Node2,Node3 :    TOneNode;
     i                 :Integer;
     newX,newY         : MyReal;
begin
     for i:=0 to Elements_Result.CountOfElements-1 do begin
           OneElement:= Elements_Result.GetElement(i+1);
           Node1:=Nodes_Result.GetNode(OneElement.Node1);
           Node2:=Nodes_Result.GetNode(OneElement.Node2);
           Node3:=Nodes_Result.GetNode(OneElement.Node3);

           newX := abs(Node1.x-Node2.x)/2;
           if newX = 0 then
           begin newX:=Node1.x; end
           else
           begin
                if(Node1.x < Node2.x) then begin newX:= Node1.x + newX; end
                else begin newX:= Node2.x + newX; end;
           end;

           newY := abs(Node1.y-Node2.y)/2;
           if newY = 0 then
           begin newY:=Node1.y; end
           else
           begin
                if(Node1.y < Node2.y) then begin newY:= Node1.y + newY; end
                else begin newY:= Node2.y + newY; end;
           end;

           if(Nodes_Result.FindNode(newX,newY) = 0) then
                begin
                NAddNodes(newX,newY,Nodes_Result.CountOfNodes);
                OneElement.Node4:=Nodes_Result.CountOfNodes;
                end
           else
                begin
                OneElement.Node4:= Nodes_Result.FindNode(newX,newY);
                end;

           newX := abs(Node2.x-Node3.x)/2;
           if newX = 0 then
           begin newX:=Node2.x; end
           else
           begin
                if(Node2.x < Node3.x) then begin newX:= Node2.x + newX; end
                else begin newX:= Node3.x + newX; end;
           end;

           newY := abs(Node2.y-Node3.y)/2;
           if newY = 0 then
           begin newY:=Node2.y; end
           else
           begin
                if(Node2.y < Node3.y) then begin newY:= Node2.y + newY; end
                else begin newY:= Node3.y + newY; end;
           end;

           if(Nodes_Result.FindNode(newX,newY) = 0) then
                begin
                NAddNodes(newX,newY,Nodes_Result.CountOfNodes);
                OneElement.Node5:=Nodes_Result.CountOfNodes;
                end
           else
                begin
                OneElement.Node5:= Nodes_Result.FindNode(newX,newY);
                end;

           newX := abs(Node3.x-Node1.x)/2;
           if newX = 0 then
           begin newX:=Node3.x; end
           else
           begin
                if(Node3.x < Node1.x) then begin newX:= Node3.x + newX; end
                else begin newX:= Node1.x + newX; end;
           end;

           newY := abs(Node3.y-Node1.y)/2;
           if newY = 0 then
           begin newY:=Node3.y; end
           else
           begin
                if(Node3.y < Node1.y) then begin newY:= Node3.y + newY; end
                else begin newY:= Node1.y + newY; end;
           end;

           if(Nodes_Result.FindNode(newX,newY) = 0) then
                begin
                NAddNodes(newX,newY,Nodes_Result.CountOfNodes);
                OneElement.Node6:=Nodes_Result.CountOfNodes;
                end
           else
                begin
                OneElement.Node6:= Nodes_Result.FindNode(newX,newY);
                end;

          Elements_Result.EditElement(i+1,OneElement);
     end;
end;

procedure NAddNodes(x,y:MyReal; n:INTEGER);
var
     NodeNew :    TOneNode;
begin
        NodeNew.Number:=n+1;
        NodeNew.x:=x;
        NodeNew.y:=y;
        NodeNew.ForceX:=0;
        NodeNew.ForceY:=0;
        NodeNew.BondType:=0;
        NodeNew.DX:=0;
        NodeNew.DY:=0;
        NodeNew.RenumNum:=0;
        Nodes_Result.AddNode(NodeNew);
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
            sverify := copy(s,8,length(s)-1);
            if (sverify = '- DD (THICKNESS)') then begin
                Width:=StrToMyReal(s,0,5,Err);
                break;
            end;

        end;
        Close(RHandle);

        Result:=toPoint(Format('       1       6  %10.*f      0.00000000      0.00000000      0.00000000      0.00000000      0.00000000',
                               [(10-calcPrecision(floattostr(Width))-1),Width]));
end;

function NModuleEFormat(ReadFile:string):String;
var
        RHandle:TextFile;
        ModuleE: MyReal;
        s,sverify:string;
        Err: integer;
begin
        ModuleE:=0;
        AssignFile(RHandle,Readfile);
        Reset(RHandle);
        while (not EOF(RHandle)) do begin
            readln (RHandle,s);
            sverify := copy(s,11,3);
            if (sverify = '- E') then begin
                ModuleE:=StrToMyReal(s,0,10,Err);
                break;
            end;

        end;
        Close(RHandle);

        Result:='MPDATA,R5.0, 1,EX  ,       1, 1,'
                 + toPoint(Format('%16.*f',[(16-calcPrecision(floattostr(ModuleE))-1),ModuleE]))+',';
end;

function NPuassonFormat(ReadFile:string):String;
var
        RHandle:TextFile;
        Puasson: MyReal;
        s,sverify:string;
        Err: integer;
begin
        Puasson:=0;
        AssignFile(RHandle,Readfile);
        Reset(RHandle);
        while (not EOF(RHandle)) do begin
            readln (RHandle,s);
            sverify := copy(s,8,4);
            if (sverify = '- My') then begin
                Puasson:=StrToMyReal(s,0,7,Err);
                break;
            end;

        end;
        Close(RHandle);

        Result:='MPDATA,R5.0, 1,PRXY,       1, 1,'
                + toPoint(Format('%16.*f',[(16-calcPrecision(floattostr(Puasson))-1),Puasson]))+',';
end;

Function StrToMyReal(Var s:String; st,l:integer; Var Err:integer):MyReal;
Var
     x : MyReal;
Begin
     val(DelSpaces(copy(S,st,l)),x,Err);
     Result:=x;
End;

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

function toPoint(S:String): String;
var
     r:String;
     i,l:integer;
begin
     l:=Length(s);
     r:='';
     for i:=1 to l do if s[i]=',' then r:=r+'.' else r:=r+s[i];
     Result:=r;
end;

function calcPrecision(S:String): Integer;
var
     i,countPrec:integer;
begin
     i:=0;
     countPrec:=0;
     while((s[i+1] <> ',') and (i < Length(s)))
        do begin
                i:=i+1;
                countPrec:=countPrec+1;
        end;
     Result:=countPrec;
end;

end.
// Export to Ansys (Written by: Shevchenko T.L., 26.11.2005) <--
