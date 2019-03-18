{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
unit UPluginList;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst, ExtCtrls;

type
  TPluginList = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    ListBox1: TListBox;
    Button1: TButton;
    StaticText1: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PluginList: TPluginList;

implementation
uses MainForm;
{$R *.DFM}

procedure TPluginList.Button1Click(Sender: TObject);
begin
     Close;
end;

procedure TPluginList.FormShow(Sender: TObject);
var
     i,Count:integer;
     Module:^HModule;
     func:function :PChar;stdcall;
     PluginName:PChar;
begin
     count:=LinkedPlugins.Count;
     ListBox1.Items.Clear;
     if Count>0 then
     begin
          for i:=0 to count-1 do
          begin
               Module:=LinkedPlugins.Items[i];
               func:=GetProcAddress(Module^,'GetPluginName');
               if Assigned(func) then PluginName:=func
               else PluginName:='Безымянный';
               ListBox1.Items.Add(PluginName);
          end;
     end;
end;

procedure TPluginList.ListBox1Click(Sender: TObject);
var
     Module:^HModule;
     FileName:array[0..200] of char;
begin
     Module:=LinkedPlugins.Items[ListBox1.ItemIndex];
     GetModuleFileName(Module^,@FileName,SizeOf(FileName));
     StaticText1.Caption:=FileName;
end;

end.
