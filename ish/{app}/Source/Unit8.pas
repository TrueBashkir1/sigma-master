unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, OleCtnrs;

type
  TGrafikGl2 = class(TForm)
    GroupBox1: TGroupBox;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Chart1: TChart;
    Series1: TLineSeries;
    Button1: TButton;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Button2: TButton;
    Ole: TOleContainer;
    Button4: TButton;
     procedure  Ochistka(Sender:TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure  Naris(Sender: TObject);
     procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GrafikGl2: TGrafikGl2;

implementation

uses Unit3;

{$R *.dfm}

procedure TGrafikGl2.Button1Click(Sender: TObject);
begin
        GrafikGL2.Close;
end;
procedure TGrafikGl2.Ochistka(Sender:TObject);
begin
        Edit3.Visible:=false;
        Edit4.Visible:=false;
        Edit5.Visible:=false;
        Edit6.Visible:=false;
        Edit7.Visible:=false;
        Edit8.Visible:=false;
        Edit9.Visible:=false;
        Edit10.Visible:=false;
        edit11.Visible:=false;
        edit12.Visible:=false;
        Label4.Visible:=False;
        Label5.Visible:=False;
        Label6.Visible:=False;
        Label7.Visible:=False;
        Label8.Visible:=False;
        Label9.Visible:=False;
        Label10.Visible:=False;
        Label11.Visible:=False;
        label16.Visible:=false;
        label17.Visible:=false;
         Edit1.Text:='';
        Edit2.Text:='';

end;
procedure TGrafikGl2.Naris(Sender: TObject);
var MyNrc :integer;
  begin
     Series1.Clear;
        for  MyNrc:=3 to strtoint(Form3.Edit1.Text) do
        begin
        Case MyNrc of
     3:  Series1.AddXY(MyNrc,strtofloat(Edit3.Text));
      4:  Series1.AddXY(MyNrc,strtofloat(Edit4.Text));
      5:  Series1.AddXY(MyNrc,strtofloat(Edit5.Text));
      6:  Series1.AddXY(MyNrc,strtofloat(Edit6.Text));
      7:  Series1.AddXY(MyNrc,strtofloat(Edit7.Text));
      8:  Series1.AddXY(MyNrc,strtofloat(Edit8.Text));
      9:  Series1.AddXY(MyNrc,strtofloat(Edit9.Text));
     10:  Series1.AddXY(MyNrc,strtofloat(Edit10.Text));
     11:  Series1.AddXY(MyNrc,strtofloat(Edit11.Text));
     12:  Series1.AddXY(MyNrc,strtofloat(Edit12.Text));
            end;

            end;

     end;
procedure TGrafikGl2.Button2Click(Sender: TObject);
 var  N:integer;
begin
         N:=strtoint(Form3.Edit1.Text);
       case N of
       3: begin
            if    Edit3.Text='' then exit
            else
              Naris(Sender);
          end;
       4:  begin
            if    Edit4.Text='' then exit
            else Naris(Sender);
          end;
       5:  begin
            if    Edit5.Text='' then exit
            else Naris(Sender);
          end;
       6:  begin
            if    Edit6.Text='' then exit
            else Naris(Sender);
          end;
       7: begin
            if    Edit7.Text='' then exit
            else Naris(Sender);
          end;

       8:  begin
            if    Edit8.Text='' then exit
            else Naris(Sender);
          end;
       9:   begin
            if    Edit9.Text='' then exit
            else Naris(Sender);
          end;
       10:  begin
            if    Edit10.Text='' then exit
            else Naris(Sender);
          end;
       11:   begin
            if    Edit11.Text='' then exit
            else Naris(Sender);
            end;
        12:   begin
            if    Edit12.Text='' then exit
            else Naris(Sender);
             end;

          else exit;
          end;

     end;

     procedure TgrafikGl2.Button3Click(Sender:Tobject);
begin
        if  (Edit1.Text='') or (Edit2.Text='') then
        begin

         exit;
        end;
        if strtofloat(Edit1.Text) > strtofloat(Edit2.Text) then
        begin
             chart1.LeftAxis.Automatic:=False;
             Chart1.LeftAxis.Maximum:=Chart1.LeftAxis.Minimum;

             if Chart1.LeftAxis.Maximum < strtofloat(Edit2.Text) then
             begin
                Chart1.LeftAxis.Maximum := strtofloat(Edit2.Text)
             end;
             Chart1.LeftAxis.Minimum:=strtofloat(Edit2.Text);
             Chart1.LeftAxis.Maximum:=strtofloat(Edit1.Text);
        end;


end;

procedure TGrafikGl2.Button4Click(Sender: TObject);
var ole_doc, ole_r, ole_p, ole_s, ole_t, ole_tc, ole_c: Variant;
    N, i, nrc: integer;
    S: String;
begin
N:=strtoint(Form3.Edit1.Text);
     TRY
ole.CreateObject('word.application', true);
ole.OleObject.documents.Add;
ole_doc := ole.OleObject.ActiveDocument;

ole_r := ole_doc.Content;
Chart1.CopyToClipboardBitmap;
ole_r.Paste;

ole_p := ole_r.Paragraphs.Item(1);
ole_p.Alignment:=1;
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
ole_r.Paragraphs.Add(ole_r);
ole_r.Collapse(0);
    ole_r := ole_doc.Content;
    ole_r.Collapse(0);
    ole_r.Select;
    ole_s:=ole_doc.application.Selection;
    S:='X = ' + Label13.Caption + '    Y = ' + Label14.Caption;
    ole_s.TypeText(S);
    ole_r := ole_doc.Content;
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
    ole_r.Paragraphs.Add(ole_r);
    ole_r.Collapse(0);
ole_t:=ole_doc.Tables.Add(ole_r,N-1,2);
ole_tc:=ole_t.Columns.Item(1);
ole_tc.Width:=50;
ole_tc:=ole_t.Columns.Item(2);
ole_tc.Width:=150;

    ole_c:=ole_t.Cell(1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('NRC');

    ole_c:=ole_t.Cell(1,2);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    ole_s.TypeText('2-ое главное напряжение');

for i:=1 to N-2 do begin
    ole_c:=ole_t.Cell(i+1,1);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    nrc:=i+2;
    Str(nrc,S);
    ole_s.TypeText(S);

    ole_c:=ole_t.Cell(i+1,2);
    ole_c.Select;
    ole_s:=ole_doc.application.Selection;
    Str(Series1.YValues.Value[i-1]:1:8,S);
    ole_s.TypeText(S);
end;

ole_doc.Application.Visible := True;

     EXCEPT
           MessageDlg('Ошибка при попытке экспорта информации в MS Word.',mtError,[mbYes],0);
     END;


end;

end.

