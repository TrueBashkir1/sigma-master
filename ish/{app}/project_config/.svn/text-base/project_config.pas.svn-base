unit project_config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, StdCtrls, Grids, ExtCtrls, Registry, Constants;

type
  TProject_configForm = class(TForm)
    ImageList1: TImageList;
    ListView1: TListView;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    Edit1: TEdit;
    Button3: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    Edit2: TEdit;
    Button4: TButton;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Edit3: TEdit;
    ConfigRadio: TRadioGroup;

    procedure ListView1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    function getModulePath(module: string):String;

  end;

var
  Project_configForm: TProject_configForm;

implementation

Uses MainForm, TProject;

{$R *.dfm}

procedure TProject_configForm.ListView1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
Edit1.Text := Project_GetSource+Item.Caption+'.for';
if Item.SubItems.Strings[1] = 'user' then begin
Edit3.Text := Item.SubItems.Strings[0];
RadioButton2.Checked := true;
end
else begin
Edit3.Text := '';
RadioButton1.Checked := true;

end;


end;
procedure TProject_configForm.Button3Click(Sender: TObject);
var
        item : TListItem;
begin
OpenDialog1.FileName := ListView1.Selected.Caption;
OpenDialog1.InitialDir := ListView1.Items.Item[0].SubItems.Strings[0];
OpenDialog1.Title:='Выберите файл для модуля '+ListView1.Selected.Caption;
OpenDialog1.Filter := 'Fortran files (*.for)|*.for|C/C++ files (*.cpp)|*.cpp';
item := ListView1.Selected;
if OpenDialog1.Execute then
begin
if StrComp(StrLower(Pchar(ChangeFileExt(ExtractFileName(OpenDialog1.Files[0]),''))),StrLower(Pchar(ListView1.Selected.Caption))) <> 0 then
begin
        MessageDlg('Имя файла "'+StrLower(Pchar(ChangeFileExt(ExtractFileName(OpenDialog1.Files[0]),'')))+'" не совпадает с именем модуля "'+StrLower(Pchar(ListView1.Selected.Caption))+'". Изменение не произведено.', mtError,[mbYes],0);
        item.Selected := true;
end
else
begin
  ListView1.Selected.SubItems.Strings[0] := OpenDialog1.Files[0];
  ListView1.Selected.SubItemImages[1] := 3;
  ListView1.Selected.SubItems.Strings[1] := 'user';
  Edit3.Text := OpenDialog1.Files[0];
end;
item.Selected := true;
end;
end;


procedure TProject_configForm.Button2Click(Sender: TObject);
begin
Project_configForm.Close;
end;
{
Функция для получение
имени проекта из
полного пути к файлу проекта
который лежит в реестре
}
function GetProjectName:String;
var
  projName:String;
  tempStr:String;
  slashPos:Integer;
  Registry:TRegistry;
begin
      projName := '';
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg, true) then
     begin
          if Registry.ValueExists('InputFileName') then
          begin
          // Получаем полный путь до файла проекта
            tempStr:=Registry.ReadString('InputFileName');

            // Получаем только имя файла проекта
            while(Pos('\',tempStr) <> 0) do
            begin
              slashPos:= Pos('\',tempStr);
              Delete(tempStr,1,slashPos);
            end;
            Delete(tempStr,Pos('.',tempStr),Length(tempStr));
            // Удаляем расширение и получаем имя проекта
            projName:= tempStr;
          end;
     end;
     Result := projName;
End;

procedure TProject_configForm.FormShow(Sender: TObject);
var
  I             : Integer;
  ListItem      : TListItem;
  NewColumn1    : TListColumn;
  RHandle       : TextFile;
  s             : string;
  path          : string;

     count  : word;
     FileName : String;
     pac      : String;
begin
Caption:= Caption + ' ' + GetProjectName;
edit2.Text := Project_GetFormFile;

    ListView1.Items.Clear;
     count:=Project_Fortran_Count;
     If Count>0 Then
     Begin
          For i:=1 To Count Do
          Begin
               FileName:=Project_Fortran_Get(i);
               pac:=String(Project_PackFileName(PChar(FileName)));

                    If FileExists(FileName) Then
                    begin
                        ListItem := ListView1.Items.Add;
                        ListItem.Caption := ChangeFileExt(ExtractFileName(FileName),'');
                        if  ExtractFileExt(FileName) = 'for' then  ListItem.ImageIndex := 0;

                         If pac[1]='*' Then begin
                            ListItem.SubItems.Add(FileName);
                            ListItem.SubItemImages[0] := 2;
                            ListItem.SubItemImages[1] := 4;
                            ListItem.SubItems.Add('source');
                         End
                         Else Begin
                         If FileExists(FileName) Then begin
                            ListItem.SubItems.Add(FileName);
                            ListItem.SubItemImages[0] := 2;
                            ListItem.SubItemImages[1] := 3;
                            ListItem.SubItems.Add('user');

                         end
                         Else
                         begin
                           ListItem.ImageIndex := 5;
                           ListItem.SubItems.Add('');
                           ListItem.SubItems.Add('');
                         End
                         end
                    end
                    else
                    begin
                        ListItem := ListView1.Items.Add;
                        ListItem.Caption := ChangeFileExt(ExtractFileName(FileName),'');
                        ListItem.ImageIndex := 5;
                        ListItem.SubItems.Add('');
                        ListItem.SubItems.Add('');
                    end;


          End;
     End;
  ListView1.Items.Item[0].Selected := true;

end;


procedure TProject_configForm.Button4Click(Sender: TObject);
begin
OpenDialog1.FileName := ExtractFileName(edit2.Text);
OpenDialog1.InitialDir := ExtractFilePath(edit2.Text);
OpenDialog1.Title:='Открыть файл формы';
OpenDialog1.Filter := 'Sigma form files (*.sfm)|*.sfm';
if OpenDialog1.Execute then
begin
edit2.Text :=  OpenDialog1.filename;
end

end;

procedure TProject_configForm.Button1Click(Sender: TObject);
Var
     i : integer;
     s:string;
     error:boolean;
Begin
     error := false;
     For i:=0 To ListView1.Items.Count-1 Do
      Begin
          s:=ListView1.Items.Item[i].SubItems.Strings[0];
          if (StrComp(PChar(s),PChar('')) = 0) then begin
          error := true;
          ListView1.Items.Item[i].ImageIndex := 5;
          end
      end;

     if error = true then  begin
     MessageDlg('Конфигурирование выполнено с ошибками. Не для всех модулей заданы исходные файлы.', mtError,[mbYes],0);
     ListView1.Update;
     end
     else
     begin
     Project_SetFormFile(PChar(Edit2.Text));
     Project_Fortran_Clear;
     If ListView1.Items.Count > 0 Then
     Begin
          For i:=0 To ListView1.Items.Count-1 Do
          Begin
               Project_Fortran_Add(PChar(ListView1.Items.Item[i].SubItems.Strings[0]))
          End;
     CheckState;
     close;
     end
     end;
end;

function TProject_configForm.getModulePath(module: string):String;
var
item:TListitem;
begin
item := ListView1.FindCaption(0,module,false,false,true);
if item <> nil then Result := item.SubItems.Strings[0]
else Result := '';
end;

procedure TProject_configForm.RadioButton1Click(Sender: TObject);
begin
Edit3.Text := '';
Button3.Enabled := false;
Edit3.Enabled := false;
ListView1.Selected.SubItemImages[1]:=4;
ListView1.Selected.SubItems.Strings[0]:=Edit1.Text;
ListView1.Selected.SubItems.Strings[1]:='source';
ListView1.Selected.ImageIndex := 0;
ListView1.Selected.Update;
end;

procedure TProject_configForm.RadioButton2Click(Sender: TObject);
var
Dialog :word;
begin
if not FileExists(ExtractFilePath(Project_Name)+ExtractFileName(Edit1.Text)) then begin
CopyFile(pchar(Edit1.Text),pchar(ExtractFilePath(Project_Name)+ExtractFileName(Edit1.Text)),true);
Edit3.Text :=ExtractFilePath(Project_Name)+ExtractFileName(Edit1.Text);
end;


Button3.Enabled := true;
Edit3.Enabled := true;
ListView1.Selected.SubItemImages[1]:=3;
ListView1.Selected.SubItems.Strings[0]:=Edit3.Text;
ListView1.Selected.SubItems.Strings[1]:='user';

ListView1.Selected.Update;
end;

end.
