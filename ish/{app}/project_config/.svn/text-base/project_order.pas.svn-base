unit project_order;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, ExtCtrls;

type
  TProjectOrderForm = class(TForm)
    GroupBox1: TGroupBox;
    TreeView1: TTreeView;
    Button1: TButton;
    DeleteButton: TButton;
    Button3: TButton;
    Button4: TButton;
    TreeView2: TTreeView;
    ImageList1: TImageList;
    GroupBox2: TGroupBox;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    OrderBevel1: TBevel;
    Button5: TButton;
    OpenDialog1: TOpenDialog;
    SaveButton: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure Button1Click(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DeleteButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadTree();
    function LoadList(List: TListView;Status:String):TListView;

  end;

var
  ProjectOrderForm: TProjectOrderForm;
  ODir:String;
  ProjectPath:String;
  ProjectName:string;
implementation

uses MainForm,TProject,Registry,constants;
{$R *.dfm}

procedure TProjectOrderForm.Button3Click(Sender: TObject);
var
Node, NextNode: TTreeNode;
begin
  Node := TreeView1.Selected;
  if Node <> nil then
  begin;
   if Node.Level = 0 then
   begin
   if not Node.IsFirstNode then
    begin
        Node.MoveTo(Node.getPrevSibling,naInsert);
        Node.Expand(true);
    end;
    TreeView1.SetFocus();
   end
  end;
SaveButton.Enabled:=true;
end;

procedure TProjectOrderForm.Button4Click(Sender: TObject);
var
Node, NextNode: TTreeNode;
begin
  Node := TreeView1.Selected;
  if Node <> nil then
  begin;
   if Node.Level = 0 then
   begin
//     Node.MoveTo(TreeView2.Items.,naInsert);
   NextNode := Node.getNextSibling;
   if NextNode <> nil then
   begin
     NextNode.MoveTo(Node,naInsert);
     NextNode.Expand(true);
   end;
     TreeView1.SetFocus();
   end
  end;
SaveButton.Enabled:=true;
end;

procedure TProjectOrderForm.FormShow(Sender: TObject);
begin
LoadTree;
end;

procedure TProjectOrderForm.Button5Click(Sender: TObject);
var
        Dialog  : word;
begin
          Dialog:=MessageDlg('Вы уверены, что хотите восстановить исходный порядок выполнения модулей?', mtConfirmation,[mbYes,mbNo], 0);
          if Dialog=mrYes then
          begin
                if FileExists(ProjectPath+ProjectName+'_mo.ini') then
                DeleteFile(ProjectPath+ProjectName+'_mo.ini');

                LoadTree;
          end;
          SaveButton.Enabled:=false;
end;


procedure TProjectOrderForm.LoadTree();
var
     idx,idx1: integer;
     Registry:TRegistry;
begin
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg, true) then
     begin
          if Registry.ValueExists('OutDir') then
          ODir:=Registry.ReadString('OutDir');
     end;

     ProjectPath:= ExtractFilePath(Project_Name);
     ProjectName:= ExtractFileName(ChangeFileExt(Project_Name,''));

SaveButton.Enabled:=false;
TreeView1.Items.Clear;
if FileExists(ProjectPath+ProjectName+'_mo.ini') then
begin
     TreeView1.LoadFromFile(ProjectPath+ProjectName+'_mo.ini');
     TreeView1.FullExpand();
     for idx1:=0 to TreeView1.Items.Count-1 do begin

          if MainForm1.FindModule(TreeView1.Items.Item[idx1].Text) <> '' then begin
          TreeView1.Items.Item[idx1].ImageIndex := 1;
          TreeView1.Items.Item[idx1].SelectedIndex := 1;
          end
          else
          begin
          TreeView1.Items.Item[idx1].ImageIndex := 0;
          TreeView1.Items.Item[idx1].SelectedIndex := 0;
          end;

     end;
     TreeView1.Update;
end
else
begin
   if FileExists(SigmaLocation+'bin\'+'modules_order.ini') then  begin
     TreeView1.LoadFromFile(SigmaLocation+'bin\'+'modules_order.ini');
     TreeView1.FullExpand();
     for idx1:=0 to TreeView1.Items.Count-1 do begin
     TreeView1.Items.Item[idx1].ImageIndex := 1;
     TreeView1.Items.Item[idx1].SelectedIndex := 1;
     end;
     TreeView1.Update;
     TreeView1.Repaint;
   end
   else
     MessageDlg('Невозможно загрузить исходный порядок выполнения модулей. Файл modules_order.ini не существует.', mtError,[mbYes],0);
end;

TreeView1.Items.Item[0].Selected:=true;
TreeView1Change(TreeView1.Items.Item[0],TreeView1.Selected);
end;

procedure TProjectOrderForm.TreeView1Change(Sender: TObject;
  Node: TTreeNode);
begin

     Edit1.text := ProjectPath+ODir+'\'+Node.Text+'.dll';
     Edit2.text := MainForm1.FindModule(Node.Text);
   {  if TreeView1.Selected.ImageIndex = 1 then DeleteButton.enabled := false
     else DeleteButton.enabled := true;   }
end;

procedure TProjectOrderForm.Button1Click(Sender: TObject);
begin
OpenDialog1.InitialDir := ProjectPath+ODir+'\';
OpenDialog1.Title:='Выберите файл модуля';
OpenDialog1.Filter := 'Dll files (*.dll)|*.dll';
if OpenDialog1.Execute then
begin
        if LowerCase(ExtractFilePath(OpenDialog1.Files[0])) = LowerCase(ProjectPath+ODir+'\') then  begin
         TreeView1.Items.Add(nil,ExtractfileName(ChangeFileExt(OpenDialog1.Files[0],'')));
         SaveButton.Enabled:=True;
         end
        else
         MessageDlg('Вы можите выбрать модуль только из директории: '+ProjectPath+ODir+'\', mtError,[mbYes],0);
end;
end;

procedure TProjectOrderForm.SaveButtonClick(Sender: TObject);
begin
TreeView1.SaveToFile(ProjectPath+ProjectName+'_mo.ini');
SaveButton.Enabled:=false;
end;

procedure TProjectOrderForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
Dialog:word;
begin
        if SaveButton.Enabled then begin
          Dialog:=MessageDlg('Сохранить изменения?', mtConfirmation,[mbYes,mbNo], 0);
          if Dialog=mrYes then
          begin
               TreeView1.SaveToFile(ProjectPath+ProjectName+'_mo.ini');
          end;
        end

end;

procedure TProjectOrderForm.DeleteButtonClick(Sender: TObject);
begin
       TreeView1.Items.Delete(TreeView1.Selected);
       TreeView1.Update;
       SaveButton.Enabled := true;
end;

function TProjectOrderForm.LoadList(List: TListView;Status:String):TListView;
var
        idx1:integer;
        ListItem      : TListItem;
begin
List.Clear;
List.Repaint;
  with List do
  begin
     for idx1:=0 to TreeView1.Items.Count-1 do begin
        ListItem := List.Items.Add;
        ListItem.Caption := TreeView1.Items.Item[idx1].text;
        ListItem.ImageIndex:= TreeView1.Items.Item[idx1].ImageIndex;
        ListItem.SubItems.Add(Status);
     end;
  end;
  List.Update;
  List.Repaint;
end;

end.
