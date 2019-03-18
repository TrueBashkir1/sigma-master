{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
Unit strfunc;

Interface
Type
     MyReal=real;

Function StrToInteger(Var s:String; st,l:integer; Var Err:integer):Integer;
Function StrToMyReal(Var s:String; st,l:integer; Var Err:integer):MyReal;
Function DelSpaces(s:String):String;
Function RemoveStr(s1,s2:String):String;
Function CheckByte(s:String; Var Value:byte):boolean;
Function CheckWord(s:String; Var Value:word):boolean;
Function CheckInt(s:String; Var Value:integer):boolean;
Function CheckReal(s:String; Var Value:MyReal):boolean;
Function Lower(s:string):string;
//Function StrToMyReal(s:string;var Error:boolean):MyReal;
Implementation
Uses SysUtils, Dialogs;
Function DelSpaces(s:String):String;
//Var
//     i, n, e, l : integer;
Begin
     {L:=length(s);
     n:=0;
     e:=0;
     For I:=1 To l Do
     Begin
          If (S[i]<>' ') Then inc(n)
          Else inc(e);
          If (n<>0) Then S[n]:=S[i];
     End;
     SetLength(s,l-e);}
     result:=Trim(s);
End;
Function StrToMyReal(Var s:String; st,l:integer; Var Err:integer):MyReal;
Var
     x : MyReal;
Begin
     val(Trim(copy(S,st,l)),x,Err);
     Result:=x;
End;
Function StrToInteger(Var s:String; st,l:integer; Var Err:integer):Integer;
Var
     x : Integer;
Begin
     val(Trim(copy(S,st,l)),x,Err);
     Result:=x;
End;
Function RemoveStr(s1,s2:String):String;
Var
     s3            : String;
     l1, l2,  i : byte;   //l3,
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
Function CheckInt(s:String; Var Value:integer):boolean;
Var
     e : integer;
     Show : boolean;
Begin
     if Value=0 then Show:=false else Show:=true;
     Val(s,Value,e);
     If e<>0 Then If Value=0 Then e:=1;
     If e<>0 Then
     Begin
          if Show then ShowMessage('Это должно быть целым числом больше 0');
          Result:=False
     End
     Else Result:=True
End;
Function CheckByte(s:String; Var Value:byte):boolean;
Var
     e : integer;
     Show : boolean;
Begin
     if Value=0 then Show:=false else Show:=true;
     Val(s,Value,e);
     //If e<>0 Then If Value=0 Then e:=1;
     If e<>0 Then
     Begin
          if Show then ShowMessage('Это должно быть целым числом больше 0');
          Result:=False
     End
     Else Result:=True
End;
Function CheckWord(s:String; Var Value:word):boolean;
Var
     e : integer;
     Show : boolean;
Begin
     if Value=0 then Show:=false else Show:=true;
     Val(s,Value,e);
     //If e<>0 Then If Value=0 Then e:=1;
     If e<>0 Then
     Begin
          if Show then ShowMessage('Это должно быть целым числом больше 0');
          Result:=False
     End
     Else Result:=True
End;
Function CheckReal(s:String; Var Value:MyReal):boolean;
Var
     e    : integer;
     Show : boolean;
Begin
     if Value=0 then Show:=false else Show:=true;
     e:=Pos(',',s);
     If e<>0 Then s[e]:='.';
     Val(s,Value,e);
     If e<>0 Then
     Begin
          if Show then ShowMessage('Это должно быть вещественным числом');
          Result:=False
     End
     Else Result:=True
End;
function Lower;
begin
     Result:=String(StrLower(pchar(s)));
end;

End.
