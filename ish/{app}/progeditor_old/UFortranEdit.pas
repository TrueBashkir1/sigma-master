unit UFortranEdit;

interface
uses
     Sysutils,classes,comctrls,Controls,StdCtrls;
Type
     TFortranTab=class(TTabSheet)
     public
          //lb:TListBox;
          RichEdit:TRichEdit;
          FFileName:string;
          LastModified:integer;
          constructor Create(AOwner: TComponent); override;
          destructor Destroy; override;
          procedure Load(FileName:string);
          //procedure RePaintEdit(Sender:TObject);
          procedure MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
          procedure MyKeyPress(Sender: TObject; var Key: Char);
          //procedure ListBox1DblClick(Sender: TObject);
          //procedure ListBox1KeyPress(Sender: TObject; var Key: Char);
     end;
implementation
uses Graphics, Richedit, Windows,IniFiles,ProgramForm,Dialogs;
constructor TFortranTab.Create(AOwner: TComponent);
begin
     inherited Create(AOwner);
     PageControl := (AOwner as TPageControl);
     RichEdit:=TRichEdit.Create(self);
     with RichEdit do
     begin
          Parent := self;
          Align := alClient;
          DefAttributes.Pitch:=fpFixed;
          PlainText:=true;
          Font.Pitch:=fpFixed;
          Font.Name:='Courier New';
          Font.Size:=10;
          WordWrap:=false;
          ScrollBars:=ssBoth;
          WantTabs:=true;
          //OnChange:=RePaintEdit;
          OnKeyDown:=MyKeyDown;
          OnKeyPress:=MyKeyPress;
          {lb:=TListBox.Create(self);
          lb.Parent:=self;
          lb.Visible:=false;
          lb.Items.Add('ddddd');
          lb.OnKeyPress:=ListBox1KeyPress;
          lb.OnDblClick:=ListBox1DblClick;}
     end;
     //InitFortranColor(RichEdit);
end;
destructor TFortranTab.Destroy;
begin
     //lb.free;
     RichEdit.Free;
     inherited Destroy;
end;
{procedure TFortranTab.RePaintEdit(Sender:TObject);
var
     CharFormat: TCharFormat;
     ErrorCode: LongInt;
begin
     FillChar(CharFormat, SizeOf(TCharFormat), 0);
     CharFormat.cbSize := SizeOf(TCharFormat);
     ErrorCode := RichEdit.Perform(EM_GETCHARFORMAT, 0, LPARAM(@CharFormat));
     CharFormat.dwMask := CFM_COLOR;
     CharFormat.dwEffects := CFE_AUTOCOLOR;
     CharFormat.crTextColor := ColorToRGB(clRed);
     ErrorCode := RichEdit.Perform(EM_SETCHARFORMAT, SCF_ALL, LPARAM(@CharFormat));
end;}
procedure TFortranTab.Load;
begin
     FFileName:=FileName;
     LastModified:=FileAge(FileName);
     Caption := ExtractFileName(FileName);
     with RichEdit do
     begin
          //Font:=FontDialog1.Font;
          //PopupMenu:=PopupMenu1;
          Lines.Clear;
          Lines.LoadFromFile(FileName);
          Modified:=False;
          SelStart := 0;
          if FileGetAttr(FileName) and faReadOnly=faReadOnly then ReadOnly:=true
          else ReadOnly:=false;
     end;
end;
procedure TFortranTab.MyKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
     InsertSpace='    ';
var
     RichEdit:TRichEdit;
     procedure Ctrl_Y;
     begin
          RichEdit.Lines.Delete(RichEdit.CaretPos.y);
     end;
     {procedure Ctrl_J;
     var
          //l:integer;
          size:TSize;
          tex:String;
          Canvas:TCanvas;
     begin
          Canvas:=TCanvas.Create;
          Canvas.Handle:=RichEdit.Handle;
          Canvas.Font:=RichEdit.Font;

          Tex:=RichEdit.Lines.Strings[RichEdit.CaretPos.y];
          SetLength(tex,RichEdit.CaretPos.X);

          size.cx:=Canvas.TextWidth(tex);
          size.cy:=Canvas.TextHeight(tex+'H');

          Canvas.free;

          lb.Left := 0;
          lb.Top := 0;
          lb.items.add(inttostr(Font.Height));
          lb.Visible := True;
          lb.SetFocus;
     end;}
     function GetFirst6Chars(s:string): String;
     var
          res:string;
          i,Len:Integer;
          c:byte;
     begin
          c:=0;
          res:='';
          Len:=Length(s);
          i:=0;
          while c<6 do
          begin
               inc(i);
               if i>len then c:=6
               else begin
                    res:=res+s[i];
                    if s[i]=#9 then c:=6
                    else inc(c);
               end;
          end;
          Result:= Res;
     end;

     procedure Ctrl_Move(Right:boolean);
          function AddStr(s:string):String;
          var
               Res:string;
               i,Len:integer;
          begin
               Res:='';
               Len:=Length(s);
               if Len<>0 then
               begin
                    Res:=GetFirst6Chars(s);
                    i:=Length(Res);
                    Res:=Res+InsertSpace;
                    if i<>Len then Res:=Res+Copy(s,i+1,Len-i);
               end;
               Result:=Res;
          end;
          function stripNChars(s:string;n:integer): String;
          const tab='<tab>';
          var
               s1,s2:string;
               empty:boolean;
               i,Len:Integer;
          begin
               Len:=Length(s);
               i:=1;
               Empty:=true;
               s1:='';
               while (i<=Len) and Empty  do
               begin
                    if (s[i] in [#9,' ']) then s1:=s1+s[i]
                    else Empty:=false;
                    inc(i);
               end;
               i:=Length(s1);
               if i=Len then s:=''
               else s:=Copy(s,i+1,Len-i);
               Len:=Length(s1);
               s2:='';
               for i:=1 to Len do
               begin
                    if s1[i]=#9 then s2:=s2+tab else s2:=s2+s1[i];
               end;
               Len:=Length(s2);
               if Len<=n then s2:='' else SetLength(s2,Len-n);
               Result:=s2+s;
          end;
          function DelStr(s:string):String;
          var
               Res:string;
               i,len:integer;
          begin
               Len:=Length(s);
               if Length(s)<>0 then
               begin
                    Res:=GetFirst6Chars(s);
                    i:=Length(Res);
                    if i<>Len then Result:=Res+stripNChars(Copy(s,i+1,Len-i),4);
               end else Result:='';
          end;
     var
          start,fin:TPoint;
          pos:integer;
          i:integer;
     begin
          with RichEdit do
          begin
               pos:=SelStart+SelLength;
               SelLength:=0;
               start:=CaretPos;
               SelStart:=pos;
               SelLength:=0;
               fin:=CaretPos;
               if (fin.x=0) then dec(fin.y);
               for i:=start.y to fin.y do
               begin
                    if Right then Lines.Strings[i]:=AddStr(Lines.Strings[i])
                    else Lines.Strings[i]:=DelStr(Lines.Strings[i]);
               end;
          end;
     end;
Begin
     if (ssCtrl in Shift) then//Ì‡Ê‡ÚCtrl
     begin
          RichEdit:=sender as TRichEdit;
          if (key = Ord('Y')) then Ctrl_Y;
          if (key = 190) then Ctrl_Move(true);
          if (key = 188) then Ctrl_Move(false);
          //if (key <>17) then showmessage(inttostr(key));
          //if (key = Ord('J')) then Ctrl_J;
          key:=0;
     end;
end;

procedure TFortranTab.MyKeyPress(Sender: TObject; var Key: Char);
var
     indent: integer;
     cur:TPoint;
     S: String;
begin
     {if key = #9 then
     begin
          key := #0;
          if RichEdit.c
          RichEdit.SelText:='    ';
     end;}
     if key = #13 then
     begin
          key := #0;
          with sender as TRichEdit do
          begin
               cur:=CaretPos;
               S:= Copy( lines[cur.y], 1, cur.x);
               indent := 0;
               while (indent < length( S )) and (S[indent + 1] in  [' ', #9]) do
                    Inc( indent );
               SetLength(s,indent);
               SelText := #13#10 + S;
          end;
     end;
end;
{procedure TFortranTab.ListBox1DblClick(Sender: TObject);
begin
     RichEdit.SelText:='mouse';
     lb.Visible:=false;
     RichEdit.SetFocus;
end;

procedure TFortranTab.ListBox1KeyPress(Sender: TObject; var Key: Char);
begin
     if key = #13 then
     begin
          key:=#0;
          RichEdit.SelText:='keyboard';
          lb.Visible:=false;
          RichEdit.SetFocus;
     end;
     if key = #27 then
     begin
          lb.Visible:=false;
          RichEdit.SetFocus;
     end;
end;}
initialization

finalization

end.
