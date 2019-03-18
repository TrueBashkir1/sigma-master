unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, Unit1;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DataType: TRadioGroup;
    NRCList: TCheckListBox;
    AllNRC: TButton;
    ActionType: TRadioGroup;
    NameField: TEdit;
    ChapterDone: TButton;
    ChapterCancel: TButton;
    procedure ChapterDoneClick(Sender: TObject);
    procedure ChapterCancelClick(Sender: TObject);
    procedure AllNRCClick(Sender: TObject);
    procedure ActivateForm(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  NumForName:integer;

implementation

{$R *.dfm}

procedure TForm2.ChapterDoneClick(Sender: TObject);
var i:integer;
    goodInput: boolean;
    Temp:PCHapter;
begin
  goodInput:=false;
  for i:=0 to 9 do
    if Form2.NRCList.Checked[i] then goodinput:=true;
  Temp:=FirstChapter;
  While temp<>nil do
    begin
      if Trim(Temp^.name)=Trim(Form2.NameField.Text) then Goodinput:=false;
      Temp:=Temp^.nextChapter;
    end;
  if Trim(Form2.NameField.Text)='' then goodinput:=false;
  if goodInput then
    begin
      Form2.ModalResult:=mrOk;
      NumForName:=NumFOrName+1;
      Form2.Hide;
    end
  else
    beep;
end;

procedure TForm2.ChapterCancelClick(Sender: TObject);

begin
Form2.ModalResult:=mrCancel;
Form2.Hide;
end;

procedure TForm2.AllNRCClick(Sender: TObject);
var i:integer;
begin
  for i:=0 to 9 do
    Form2.NRCList.Checked[i]:=true;
end;

procedure TForm2.ActivateForm(Sender: TObject);
var i: integer;
begin
  if firstChapter <> nil then
    begin
      Form2.DataType.ItemIndex:=TempChapter^.dataType;
      Form2.ActionType.ItemIndex:=TempChapter^.actionType;
      for i:=0 to 9 do
        if TempChapter^.usingNrc[i] then Form2.NRCList.Checked[i]:=true else Form2.NRCList.Checked[i]:=False;
      Form2.NameField.Text:=TempChapter^.name;
    end
  else
    begin
      Form2.DataType.ItemIndex:=0;
      Form2.ActionType.ItemIndex:=0;
      for i:=0 to 9 do
        Form2.NRCList.Checked[i]:=true;
      Form2.NameField.Text:='Chapter1';
    end;
end;

end.
