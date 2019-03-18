unit ProjectRunUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ComCtrls, Grids, ExtCtrls,Registry,Constants,
  ImgList;
{
                   NFL,   NFP, IPR, ORT, NMAT, NCN, NDF, NRC, DD, DB, DH,
C     >               DR,
C     >             RSUMX, RSUMY, INRG, INBP, XP, YP, ZP, JT, NDD, NOP,
C     >		   NP, NE, CORD, PERM, INVP, XADJ, ADJNCY, NB, NBC,
C     >		   NFIX, RSUM, R, XENV, ENVSZE, BANDW, NSTRT, NSZF,
C     >		   PSIGMA, DIAG, IMAT, ENV, BBB, IERR,ESIGMA
}
type
  TA = ARRAY [1..9] OF BYTE;
  pTA = ^TA;
  FileB = File of BYTE;

// Main parameters
  TMainParam4200        = array [1..4200] of Single;
  TMainParam50          = array [1..50] of boolean;
  TMainParam1000r       = array [1..1000] of Single;
  TMainParam40          = array [1..40] of Single;
//  TMainParam20_4r       = array [1..20,1..4] of Single;
//  TMainParam8_20i       = array [1..8,1..20] of integer;
  TMainParam20_4r       = array [1..4,1..20] of Single;
  TMainParam8_20i       = array [1..20,1..8] of integer;

  TMainParam3000i       = array [1..3000] of integer;
  TMainParam6000r       = array [1..6000] of Single;
  TMainParam2000        = array [1..2000] of integer;
  TMainParam1000i       = array [1..1000] of integer;
  TMainParam6000i       = array [1..6000] of integer;
  TMainParam3000r       = array [1..3000] of Single;
  TMainParam30000       = array [1..30000] of Single;
//  TMainParam3_6         = array [1..3,1..6] of Single;
  TMainParam3_6         = array [1..6,1..3] of Single;

  TProjectRun = class(TForm)
    ListView1: TListView;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    ImageList1: TImageList;
    Label2: TLabel;
    Label3: TLabel;
    procedure Run;
    procedure RewriteStatus(dllName,status : string);
    procedure NextStep(delta : integer);
    procedure NextPercent(Percent : integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
           status : integer;
   function LoadDLL(dllname : PChar;procname : PChar):integer;

  end;

var

  ProjectRun: TProjectRun;
  MyImportProc: function(var NFP: integer;
                         IPR: TMainParam50;
                         ORT : TMainParam1000r;
                         var NMAT, NCN, NDF, NRC: integer;
                         var DD, DB, DH, DR, RSUMX, RSUMY : Single;
                         var INRG, INBP : integer;
                         XP,YP,ZP:TMainParam40;
                         JT:TMainParam20_4r;
                         NDD:TMainParam8_20i;
                         NOP:TMainParam3000i;
                         var NP, NE:integer;
                         CORD:TMainParam6000r;
                         PERM, INVP:TMainParam2000;
                         XADJ:TMainParam1000i;
                         ADJNCY:TMainParam6000i;
                         var NB:integer;
                         NBC,NFIX:TMainParam1000i;
                         var RSUM: Single;
                         R:TMainParam3000r;
                         XENV:TMainParam2000;
                         var ENVSZE, BANDW, NSTRT, NSZF: integer;
                         PSIGMA:TMainParam30000;
                         DIAG:TMainParam1000r;
                         IMAT:TMainParam1000i;
                         ENV:TMainParam30000;
                         BBB:TMainParam3_6;
                         var IERR:integer;
                         var NFL: integer;
                         ESIGMA:TMainParam4200;
                         CORDP:TMainParam6000r;
                         NFIXP:TMainParam1000i;
                         RP:TMainParam3000r;
                         NOPP:TMainParam3000i):Integer; stdcall;


// Main parameters
  NFP,NMAT,NCN,NDF,NRC,NP,NE,NB,ENVSZE,BANDW,NSTRT,NSZF,IERR,NFL,INRG,INBP : integer;
  DD,DB,DH,DR,RSUMX,RSUMY,RSUM : Single;
  IPR                : TMainParam50;
  ORT,DIAG           : TMainParam1000r;
  XP,YP,ZP           : TMainParam40;
  JT                 : TMainParam20_4r;
  NDD                : TMainParam8_20i;
  NOP,NOPP           : TMainParam3000i;
  CORD,CORDP         : TMainParam6000r;
  PERM,INVP,XENV     : TMainParam2000;
  XADJ,NBC,NFIX,IMAT,NFIXP : TMainParam1000i;
  ADJNCY             : TMainParam6000i;
  R,RP               : TMainParam3000r;
  PSIGMA,ENV         : TMainParam30000;
  BBB                : TMainParam3_6;
  ESIGMA             : TMainParam4200;
// Var (thsve)
  CountDLL           : integer;
// Constants (tshev)
const
  StatusDone = '¬€œŒÀÕ≈ÕŒ';
  StatusError = 'Œÿ»¡ ¿';
  StatusCompile = '— ŒÃœ»À»–Œ¬¿ÕŒ';

PROCEDURE MyWRITE(var F:FILEB;pX:pTA; n:BYTE);
Procedure WriteBinaryFiles(path:String);

implementation
{$R *.dfm}
uses MainForm,project_order,Mak_File,tproject;

procedure TProjectRun.Run;
var
 i,j:integer;
 xnode,ynode,wEnd : double;
 wEnd2 : smallint;
 r1,r2 : double;
 boundtype: BYTE;
 F33,F34           : FILEB;
 delta, percentDone : integer;
 OutDir,ODir,module,ProjectDir:String;
 Registry:TRegistry;
 Form_Load: procedure (FileName:PChar);stdcall;
 PModule:HModule;
 Handle : TextFile;
begin

percentDone := 0;
NextPercent(percentDone);
ProgressBar1.Position := 0;
//delta := strToInt(FloatToStr(ProgressBar1.Max div CountDLL));

for I := 1 to 3000 do  R[I] := 0.0;
for I := 1 to 1000 do  IMAT[I] := 1;
for I := 1 to 50 do    IPR[I] := FALSE;
for I := 1 to 30000 do PSIGMA[I] := 0.0;
RSUMX := 0.0;
RSUMY := 0.0;

wEnd := -1;
wEnd2 := -1;

Registry        :=TRegistry.Create;
Registry.RootKey:=HKEY_CURRENT_USER;
if Registry.OpenKey(StringReg, true) then
begin
   if Registry.ValueExists('OutDir') then
   ODir:=Registry.ReadString('OutDir');
end;
OutDir := GetDosFileName(ExtractFilePath(ProjectFileName)+ODir+'\');

PModule:=GetPlugin(1);
Form_Load:=GetProcAddress(PModule,'Form_Load');
Form_Load(PChar(Project_GetFormFile));
SetCurrentDir(OutDir);
Create_Data_Files(OutDir);
ProjectRun.status:=1;
  for I:=0 to ProjectOrderForm.TreeView1.Items.Count-1 do begin
  module := ProjectOrderForm.TreeView1.Items.Item[I].Text;
 // LoadDLL(PChar(OutDir+module+'.dll'),StrUpper(PChar(module)));

      if(LoadDLL(PChar(OutDir+module+'.dll'),StrUpper(PChar(module))) <> 0) then
        RewriteStatus(module,statusDone)
      else begin RewriteStatus(module,statusError); ProjectRun.status:=0; end;

  percentDone := percentDone + delta;
  NextPercent(percentDone);
  NextStep(delta);

  end;

// Last step
  Progressbar1.Position := 100;
  NextPercent(100);


   if ProjectRun.status =1 then begin
   // «‡ÔËÒ¸ ·ËÌ‡Ì˚ı Ù‡ÈÎÓ‚ ÂÁÛÎ¸Ú‡Ú‡
   WriteBinaryFiles(ExtractFilePath(ProjectFileName));

   ProjectRun.close;
   end
 //MessageDlg(' Done', mtConfirmation,[mbYes],0);
end;

function TProjectRun.LoadDLL(dllname : PChar;procname : PChar):integer;
var
  Handle : THandle;
  RHandle:TextFile;
begin

Handle:=LoadLibrary(dllname);
if Handle <> 0 then begin

 @MyImportProc:=GetProcAddress(Handle,procname);

 if @MyImportProc<>nil then
 begin
 //MessageDlg(procname+' Yess', mtConfirmation,[mbYes],0);

  MyImportProc(NFP,IPR,ORT,NMAT, NCN, NDF, NRC, DD, DB, DH, DR, RSUMX, RSUMY, INRG, INBP,
               XP,YP,ZP,JT,NDD, NOP,NP, NE,CORD, PERM, INVP, XADJ, ADJNCY, NB, NBC, NFIX,
               RSUM, R, XENV, ENVSZE, BANDW, NSTRT, NSZF,PSIGMA, DIAG, IMAT, ENV, BBB, IERR,NFL,ESIGMA,
               CORDP, NFIXP, RP, NOPP);

 LoadDLL:= 1;
 end
 else
 begin
 //MessageDlg('No', mtConfirmation,[mbYes],0);
 LoadDLL:= 0;
 end;
end
else LoadDLL:= 0;
FreeLibrary(Handle);
end;


PROCEDURE MyWRITE(var F : FILEB;pX:pTA; n:BYTE);
VAR i : BYTE;
BEGIN
  FOR i:=1 TO n DO WRITE(F,pX^[i]);
END;

procedure TProjectRun.RewriteStatus(dllName,status : string);
var
  I     : Integer;
begin
    for i:=0 to ListView1.Items.Count-1 do begin
        if(ListView1.Items.Item[i].Caption = dllName) then
        begin
           ListView1.Items.Item[i].SubItems.Text := status;
           if(status = StatusDone) then ListView1.Items.Item[i].Checked := true;
        end
    end;
    ListView1.Update;
end;

procedure TProjectRun.NextStep(delta : integer);
begin
   ProgressBar1.StepBy(delta);
end;

procedure TProjectRun.NextPercent(Percent : integer);
begin
   Label1.Caption := IntToStr(Percent) + ' %';
   Label1.Refresh;
end;

procedure TProjectRun.FormShow(Sender: TObject);
begin
  with ListView1 do
  begin

    ViewStyle := vsReport;
    BorderStyle := bsSingle;
    GridLines := true;

  end;
    ProjectOrderForm.LoadTree;
    ProjectOrderForm.LoadList(ListView1,StatusCompile);
    CountDll :=ListView1.Items.Count;
   
end;

procedure TProjectRun.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caFree
end;

Procedure WriteBinaryFiles(path:String);
var
 i,j:integer;
 xnode,ynode,wEnd : double;
 wEnd2,smi : smallint;
 r1,r2 : double;
 es1,es2,es3,es4,es5,es6,es7 : double;
 F33,F34           : FILEB;
  boundtype: BYTE;
begin
wEnd := -1;
wEnd2 := -1;

  AssignFile(F33,path+'result1.bin');
  Rewrite(F33);
  AssignFile(F34,path+'result2.bin');
  Rewrite(F34);

  // result 1
     for i := 1 to NP do begin
     xnode := CORDP[2*(I-1)+1];
     ynode := CORDP[2*(I-1)+2];
     MyWRITE(F33,ADDR(xnode),8);
     MyWRITE(F33,ADDR(ynode),8);
   end;
     MyWRITE(F33,ADDR(wEnd),8);

   for i := 1 to NB do begin
     xnode := CORD[2*(NBC[I]-1)+1];
     ynode := CORD[2*(NBC[I]-1)+2];
     MyWRITE(F33,ADDR(xnode),8);
     MyWRITE(F33,ADDR(ynode),8);
     boundtype := NFIXP[I];
     MyWRITE(F33,ADDR(boundtype),1);
   end;
     MyWRITE(F33,ADDR(wEnd),8);

   for i := 1 to NP do begin
     r1 := RP[(I-1)*NDF+1];
     r2 := RP[(I-1)*NDF+2];
     if (r1 = 0) and (r2 = 0) then continue;
     xnode := CORD[2*(I-1)+1];
     ynode := CORD[2*(I-1)+2];
     MyWRITE(F33,ADDR(xnode),8);
     MyWRITE(F33,ADDR(ynode),8);
     MyWRITE(F33,ADDR(r1),8);
     MyWRITE(F33,ADDR(r2),8);
   end;
     MyWRITE(F33,ADDR(wEnd),8);

   for i := 1 to NP do begin
     xnode := CORD[2*(I-1)+1];
     ynode := CORD[2*(I-1)+2];
     MyWRITE(F33,ADDR(xnode),8);
     MyWRITE(F33,ADDR(ynode),8);
   end;
     MyWRITE(F33,ADDR(wEnd),8);

   for i := 1 to NP do begin
     r1 := R[(I-1)*NDF+1];
     r2 := R[(I-1)*NDF+2];
     MyWRITE(F33,ADDR(r1),8);
     MyWRITE(F33,ADDR(r2),8);
   end;
     MyWRITE(F33,ADDR(wEnd),8);

// result 2
   for i := 1 to NE do begin
     MyWRITE(F34,ADDR(NOPP[NCN*(I-1)+1]),2);
     MyWRITE(F34,ADDR(NOPP[NCN*(I-1)+2]),2);
     MyWRITE(F34,ADDR(NOPP[NCN*(I-1)+3]),2);
   end;
     MyWRITE(F34,ADDR(wEnd2),2);

   for i := 1 to NE do begin
     es1 := ESIGMA[7*(I-1)+1];
     es2 := ESIGMA[7*(I-1)+2];
     es3 := ESIGMA[7*(I-1)+3];
     es4 := ESIGMA[7*(I-1)+4];
     es5 := ESIGMA[7*(I-1)+5];
     es6 := ESIGMA[7*(I-1)+6];
     es7 := ESIGMA[7*(I-1)+7];

     MyWRITE(F34,ADDR(es1),8);
     MyWRITE(F34,ADDR(es2),8);
     MyWRITE(F34,ADDR(es3),8);
     MyWRITE(F34,ADDR(es4),8);
     MyWRITE(F34,ADDR(es5),8);
     MyWRITE(F34,ADDR(es6),8);
     MyWRITE(F34,ADDR(es7),8);
   end;
     MyWRITE(F34,ADDR(wEnd),8);

   for i := 1 to 21 do begin
     es1 := ORT[I];
     MyWRITE(F34,ADDR(es1),8);
   end;
     MyWRITE(F34,ADDR(wEnd),8);

   for i := 1 to NE do begin
     smi := IMAT[I];
     MyWRITE(F34,ADDR(smi),2);
   end;
     MyWRITE(F34,ADDR(wEnd),8);  

   CloseFile(F33);
   CloseFile(F34);
end;

end.
