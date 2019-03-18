unit SplitUnit;

interface

type
  TData = Array of String;

function Split(S : String; C : Char): TData;

implementation

function Split(S : String; C : Char): TData;
var
  Data : TData;

  procedure DelC(var S : String);
  var
    i : Integer;
  begin
    i:=0;
    while (Length(s) > 0) and (S[i+1]=C) do
      Inc(i);
    Delete(S, 1, i);
  end;

  procedure Splitting(S : String);
  var
    w : String;
    i : Integer;
    k : Integer;
  begin
    if Length(s) < 1 then
      Exit;
    if S[1] = C then
      DelC(S)
    else
    begin
      w:=''; i:=1;
      while ( s[i] <> C ) and ( i <= Length(S) ) do begin
        w:=w+S[i];
        Inc(i);
      end;
      Delete(S, 1, Length(w));
      k:=Length(Data);
      SetLength(Data,k+1);
      Data[k]:=w;
    end;
    Splitting(S);
  end;

begin
  Splitting(S);
  Result:=Data;
end;

end.
