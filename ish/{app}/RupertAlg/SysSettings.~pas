{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                         Боков Петр Юрьевич 2008                     }
{                                                                     }
{		    	                (Системные настройки)		                    }
{*********************************************************************}
unit SysSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons,ComCtrls;

type
  TSysSettings = class(TForm)
    StatusBar1: TStatusBar;
    Main: TGroupBox;
    Modules: TGroupBox;
    ModulePages: TPageControl;
    pShowCellsForm: TTabSheet;
    pAlgF: TTabSheet;
    pSegF: TTabSheet;
    pSysSettings: TTabSheet;
    pShow: TGroupBox;
    pLoadForm: TCheckBox;
    pSaveForm: TCheckBox;
    AllUseOneSettings: TCheckBox;
    AllUseDefault: TCheckBox;
    MainALL: TGroupBox;
    MainOperations: TGroupBox;
    SaveSettingsToReg: TButton;
    Label1: TLabel;
    Label2: TLabel;
    LoadSettingsFromReg: TButton;
    SettingsToDefault: TButton;
    Label3: TLabel;
    pMenu: TGroupBox;
    pShowMenuRes: TCheckBox;
    pReLoadRegShowForm: TCheckBox;
    SaveSysForm: TCheckBox;
    sReDrawAuto: TCheckBox;
    sWhenShow: TGroupBox;
    sReLoadResWhenShow: TCheckBox;
    pShowSegF: TGroupBox;
    sLoadSegmentF: TCheckBox;
    sSaveSegmentF: TCheckBox;
    pLegendTieColorBar: TCheckBox;
    INFO: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pLoadFormClick(Sender: TObject);
    procedure pSaveFormClick(Sender: TObject);
    procedure AllUseOneSettingsClick(Sender: TObject);
    procedure AllUseDefaultClick(Sender: TObject);
    procedure SaveSettingsToRegClick(Sender: TObject);
    procedure LoadSettingsFromRegClick(Sender: TObject);
    procedure SettingsToDefaultClick(Sender: TObject);
    procedure pShowMenuResClick(Sender: TObject);
    procedure pReLoadRegShowFormClick(Sender: TObject);
    procedure SaveSysFormClick(Sender: TObject);
    procedure sReDrawAutoClick(Sender: TObject);
    procedure sReLoadResWhenShowClick(Sender: TObject);
    procedure sLoadSegmentFClick(Sender: TObject);
    procedure sSaveSegmentFClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pLegendTieColorBarClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetFlags;
    procedure ShowFlags;
    procedure LoadRegistry(Def: String;Uniq: String);
  public
    { Public declarations }
    procedure CheckBaseRegKeysForSys;
    procedure LoadForm;
    procedure SaveForm(Key: String);
  end;

// флаг
  TRegOp = Record
      Key: String;
      Name: String;
      Value: Boolean;
      Default: Boolean;
  end;
// класс обработки флагов
  TFlags = Class
    private
    public
      pLoadForm :TRegOp;
      pSaveForm :TRegOp;
      pShowMenuRes :TRegOp;
      pReLoadRegShowForm:TRegOp;
      pLegendTieColorBar: TRegOp; // связь checkbox Lenend и ColorBar + размерности
      sReDrawAuto:TRegOp;
      sReLoadResWhenShow:TRegOp;
      sLoadSegmentF:TRegOp;
      sSaveSegmentF:TRegOp;
      AllUseOneSettings:TRegOp;
      AllUseDefault:TRegOp;
      SaveSysForm:TRegOp;
      CONSTRUCTOR New;
      procedure FillDefaultFlags;
      Function Write(Name: TRegOp):boolean;
      Function Get(Name: TRegOp):boolean;
    End;

var
  SysSettingF: TSysSettings;
  FReg: TFlags;

implementation

USES Math, MainInterface,Registry, Main, ShowCells;
{$R *.dfm}

CONSTRUCTOR TFlags.New;
BEGIN
END;
Function TFlags.Write(Name: TRegOp):boolean;
Var
Reg: TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_CURRENT_USER;
  Result:=Reg.OpenKey(Name.Key, true);
  IF Result then Reg.WriteBool(Name.Name,Name.Value);
end;
Function TFlags.Get(Name: TRegOp):boolean;
Var
Reg: TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_CURRENT_USER;
  Reg.OpenKey(Name.Key, true);
  IF Reg.ValueExists(Name.Name) then Result:=Reg.readBool(Name.Name) else Result:=Name.Default;
end;

procedure TFlags.FillDefaultFlags;
  Procedure fillkeys;
  begin
            pLoadForm.Key :=PluginReg.ShowFormReg.FullPath;
            pSaveForm.Key :=PluginReg.ShowFormReg.FullPath;
         pShowMenuRes.Key :=PluginReg.ShowFormReg.FullPath;
   pReLoadRegShowForm.Key :=PluginReg.ShowFormReg.FullPath;
   pLegendTieColorBar.Key :=PluginReg.ShowFormReg.FullPath;

          sReDrawAuto.Key :=PluginReg.SegmentsRegF.FullPath;
   sReLoadResWhenShow.Key :=PluginReg.SegmentsRegF.FullPath;
        sLoadSegmentF.Key :=PluginReg.SegmentsRegF.FullPath;
        sSaveSegmentF.Key :=PluginReg.SegmentsRegF.FullPath;

    AllUseOneSettings.Key :=PluginReg.SysSettingsRegF.FullPath;
        AllUseDefault.Key :=PluginReg.SysSettingsRegF.FullPath;
          SaveSysForm.key :=PluginReg.SysSettingsRegF.FullPath;
  end;
  procedure fillnames;
  begin
            pLoadForm.Name :='LoadShowForm';
            pSaveForm.Name :='SaveShowForm';
         pShowMenuRes.Name :='ShowMenuRes';
   pReLoadRegShowForm.Name :='ReLoadRegShowForm';
   pLegendTieColorBar.Name :='LegendTieColorBar';

          sReDrawAuto.Name :='ReDrawAuto';
   sReLoadResWhenShow.Name :='ReLoadResWhenShow';
        sLoadSegmentF.Name :='LoadSegmentF';
        sSaveSegmentF.Name :='SaveSegmentF';

    AllUseOneSettings.Name :='AllUseOneSettings';
        AllUseDefault.Name :='AllUseDefault';
          SaveSysForm.Name :='SaveSysForm';
  end;
  procedure fillvalues;
  begin
            pLoadForm.Default :=False;
            pSaveForm.Default :=False;
         pShowMenuRes.Default :=True;
   pReLoadRegShowForm.Default :=False;
   pLegendTieColorBar.Default :=True;

          sReDrawAuto.Default :=True;
   sReLoadResWhenShow.Default :=False;
        sLoadSegmentF.Default :=False;
        sSaveSegmentF.Default :=False;

    AllUseOneSettings.Default :=False;
        AllUseDefault.Default :=True;
          SaveSysForm.Default :=True;
  end;
Begin
  fillvalues; fillkeys; fillnames;
end;

procedure TSysSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IF Freg.SaveSysForm.Value then SaveForm(PluginReg.SysSettingsRegF.Current);
  Action := caFree;
  IF SysSettingF <> nil then begin
    MainR.ActiveWindow.Items.Delete(MainR.ActiveWindow.items.IndexOf('Системные настройки'));
    MainR.ActiveForm[5]:=-1;MainR.RefreshIndexes;
    SysSettingF := nil;
  end;
  FReg.Free;
end;

procedure TSysSettings.SaveForm(Key: String);
Var
Registry: TRegistry;
begin
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  Registry.OpenKey(Key,true);
    Registry.WriteBool(Freg.pLoadForm.Name,Freg.pLoadForm.Value);
    Registry.WriteBool(Freg.pSaveForm.Name,Freg.pSaveForm.Value);
    Registry.WriteBool(Freg.pShowMenuRes.Name,Freg.pShowMenuRes.Value);
    Registry.WriteBool(Freg.pReLoadRegShowForm.Name,Freg.pReLoadRegShowForm.Value);
    Registry.WriteBool(Freg.pLegendTieColorBar.Name,Freg.pLegendTieColorBar.Value);
    Registry.WriteBool(Freg.sReDrawAuto.Name,Freg.sReDrawAuto.Value);
    Registry.WriteBool(Freg.sReLoadResWhenShow.Name,Freg.sReLoadResWhenShow.Value);
    Registry.WriteBool(Freg.sLoadSegmentF.Name,Freg.sLoadSegmentF.Value);
    Registry.WriteBool(Freg.sSaveSegmentF.Name,Freg.sSaveSegmentF.Value);
  Registry.CloseKey;
  Registry.OpenKey(PluginReg.SysSettingsRegF.FullPath,true);
    Registry.WriteBool(Freg.AllUseOneSettings.Name,Freg.AllUseOneSettings.Value);
    Registry.WriteBool(Freg.AllUseDefault.Name,Freg.AllUseDefault.Value);
    Registry.WriteBool(Freg.SaveSysForm.Name,Freg.SaveSysForm.Value);
  Registry.CloseKey;
end;

procedure TSysSettings.LoadForm;
begin
  LoadRegistry(PluginReg.SysSettingsRegF.Default,PluginReg.SysSettingsRegF.Current);
  SetFlags;
  ShowFlags;
end;

procedure TSysSettings.FormShow(Sender: TObject);
begin
  StatusBar1.Panels[0].Text:={StatusBar1.Panels[0].Text}'Текущий проект:'+Project_GetFormFile;
end;

procedure TSysSettings.FormCreate(Sender: TObject);
begin
  FReg:=TFlags.Create;
  FReg.FillDefaultFlags;
  CheckBaseRegKeysForSys;
  LoadForm;
end;

// проверим наличие ключей, при необходимости создадим их
procedure TSysSettings.CheckBaseRegKeysForSys;
Var
Registry: TRegistry;
  procedure Write(Key: String; I: Integer);
  begin
    Registry.OpenKey(key,true);
    IF I=0 then begin // флаги форм
      Registry.WriteBool(Freg.pLoadForm.Name,Freg.pLoadForm.Default);
      Registry.WriteBool(Freg.pSaveForm.Name,Freg.pSaveForm.Default);
      Registry.WriteBool(Freg.pShowMenuRes.Name,Freg.pShowMenuRes.Default);
      Registry.WriteBool(Freg.pReLoadRegShowForm.Name,Freg.pReLoadRegShowForm.Default);
      Registry.WriteBool(Freg.pLegendTieColorBar.Name,Freg.pLegendTieColorBar.Default);
      Registry.WriteBool(Freg.sReDrawAuto.Name,Freg.sReDrawAuto.Default);
      Registry.WriteBool(Freg.sReLoadResWhenShow.Name,Freg.sReLoadResWhenShow.Default);
      Registry.WriteBool(Freg.sLoadSegmentF.Name,Freg.sLoadSegmentF.Default);
      Registry.WriteBool(Freg.sSaveSegmentF.Name,Freg.sSaveSegmentF.Default);
    end
    else if I=1 then begin // общие флаги
      Registry.WriteBool(Freg.AllUseOneSettings.Name,Freg.AllUseOneSettings.Default);
      Registry.WriteBool(Freg.AllUseDefault.Name,Freg.AllUseDefault.Default);
      Registry.WriteBool(Freg.SaveSysForm.Name,Freg.SaveSysForm.Default);
    end;
  end;
begin
  Registry:=TRegistry.Create;
  Registry.RootKey:=HKEY_CURRENT_USER;
  IF Registry.KeyExists(PluginReg.SysSettingsRegF.FullPath) then begin // есть ли ветка для SysSettings
    IF not(Registry.KeyExists(PluginReg.SysSettingsRegF.Default)) then begin
      Registry.CreateKey(PluginReg.SysSettingsRegF.Default);
      Write(PluginReg.SysSettingsRegF.Default,0);
    end;
    IF not(Registry.KeyExists(PluginReg.SysSettingsRegF.Current)) then begin
      Registry.CreateKey(PluginReg.SysSettingsRegF.Current);
      Write(PluginReg.SysSettingsRegF.Current,0);
    end;
  end
  else begin
    Registry.CreateKey(PluginReg.SysSettingsRegF.FullPath);
    Registry.CreateKey(PluginReg.SysSettingsRegF.Default);
    Registry.CreateKey(PluginReg.SysSettingsRegF.Current);
    Write(PluginReg.SysSettingsRegF.FullPath,1);
    Write(PluginReg.SysSettingsRegF.Default,0);
    Write(PluginReg.SysSettingsRegF.Current,0);
  end;
end;

procedure TSysSettings.LoadRegistry(Def:String; Uniq: String);
  Function Read(Key: String; Name: TRegOp):boolean;
  Var
    Reg: TRegistry;
  begin
    Reg:=TRegistry.Create;
    Reg.RootKey:=HKEY_CURRENT_USER;
    Reg.OpenKey(Key, true);
    IF Reg.ValueExists(Name.Name) then Result:=Reg.readBool(Name.Name) else Result:=Name.Default;
  end;
begin
// Системные флаги
  Freg.AllUseOneSettings.Value  :=Freg.Get(Freg.AllUseOneSettings);
      Freg.AllUseDefault.Value  :=Freg.Get(Freg.AllUseDefault);
        Freg.SaveSysForm.Value  :=Freg.Get(Freg.SaveSysForm);
    // Общие флаги (пользовательская настройка)
  FReg.pLoadForm.Value  :=read(Uniq,FReg.pLoadForm);
  FReg.pSaveForm.Value  :=read(Uniq,FReg.pSaveForm);
  FReg.pShowMenuRes.Value  :=read(Uniq,FReg.pShowMenuRes);
  FReg.pReLoadRegShowForm.Value  :=read(Uniq,FReg.pReLoadRegShowForm);
  FReg.pLegendTieColorBar.Value  :=read(Uniq,FReg.pLegendTieColorBar);
  FReg.sReDrawAuto.Value  :=read(Uniq,FReg.sReDrawAuto);
  FReg.sReLoadResWhenShow.Value  :=read(Uniq,FReg.sReLoadResWhenShow);
  FReg.sLoadSegmentF.Value  :=read(Uniq,FReg.sLoadSegmentF);
  FReg.sSaveSegmentF.Value  :=read(Uniq,FReg.sSaveSegmentF);
    // Общие флаги (по умолчанию)
  FReg.pLoadForm.Default  :=read(Def,FReg.pLoadForm);
  FReg.pSaveForm.Default  :=read(Def,FReg.pSaveForm);
  FReg.pShowMenuRes.Default  :=read(Def,FReg.pShowMenuRes);
  FReg.pReLoadRegShowForm.Default  :=read(Def,FReg.pReLoadRegShowForm);
  FReg.pLegendTieColorBar.Default  :=read(Def,FReg.pLegendTieColorBar);
  FReg.sReDrawAuto.Default  :=read(Def,FReg.sReDrawAuto);
  FReg.sReLoadResWhenShow.Default  :=read(Def,FReg.sReLoadResWhenShow);
  FReg.sLoadSegmentF.Default  :=read(Def,FReg.sLoadSegmentF);
  FReg.sSaveSegmentF.Default  :=read(Def,FReg.sSaveSegmentF);
end;
// Установка внешних флагов
procedure TSysSettings.SetFlags;
  Procedure Sets(Name: TRegOp);
  Var
  flag: boolean;
  begin
    flag:=Name.Value; Name.Value:=Name.Default;
      Freg.Write(Name);
    Name.Value:=flag;
  end;
begin
// Флаги
  IF Freg.AllUseDefault.Value then begin
    Sets(Freg.pLoadForm);
    Sets(Freg.pSaveForm);
    Sets(Freg.pShowMenuRes);
    Sets(Freg.pReLoadRegShowForm);
    Sets(Freg.pLegendTieColorBar);    
    Sets(Freg.sReDrawAuto);
    Sets(Freg.sReLoadResWhenShow);
    Sets(Freg.sLoadSegmentF);
    Sets(Freg.sSaveSegmentF);
  end else begin
    Freg.Write(Freg.pLoadForm);
    Freg.Write(Freg.pSaveForm);
    Freg.Write(Freg.pShowMenuRes);
    Freg.Write(Freg.pReLoadRegShowForm);
    Freg.Write(Freg.pLegendTieColorBar);
    Freg.Write(Freg.sReDrawAuto);
    Freg.Write(Freg.sReLoadResWhenShow);
    Freg.Write(Freg.sLoadSegmentF);
    Freg.Write(Freg.sSaveSegmentF);
  end;
end;

procedure TSysSettings.ShowFlags;
Begin
  AllUseOneSettings.Checked :=Freg.AllUseOneSettings.Value;
      AllUseDefault.Checked :=Freg.AllUseDefault.Value;
      SaveSysForm.Checked :=Freg.SaveSysForm.Value;
// Отображение флагов
  pLoadForm.Enabled:=not(FReg.AllUseDefault.Value);
  pSaveForm.Enabled:=not(FReg.AllUseDefault.Value);
  pShowMenuRes.Enabled:=not(FReg.AllUseDefault.Value);
  pReLoadRegShowForm.Enabled:=not(FReg.AllUseDefault.Value);
  pLegendTieColorBar.Enabled:=not(FReg.AllUseDefault.Value);
  sReDrawAuto.Enabled:=not(FReg.AllUseDefault.Value);
  sReLoadResWhenShow.Enabled:=not(FReg.AllUseDefault.Value);
  sLoadSegmentF.Enabled:=not(FReg.AllUseDefault.Value);
  sSaveSegmentF.Enabled:=not(FReg.AllUseDefault.Value);
// Значения checkboxes
  IF Freg.AllUseDefault.Value then begin
    pLoadForm.Checked:=FReg.pLoadForm.Default;
    pSaveForm.Checked:=FReg.pSaveForm.Default;
    pShowMenuRes.Checked:=FReg.pShowMenuRes.Default;
    pReLoadRegShowForm.Checked:=FReg.pReLoadRegShowForm.Default;
    pLegendTieColorBar.Checked:=FReg.pLegendTieColorBar.Default;
    sReDrawAuto.Checked:=FReg.sReDrawAuto.Default;
    sReLoadResWhenShow.Checked:=FReg.sReLoadResWhenShow.Default;
    sLoadSegmentF.Checked:=FReg.sLoadSegmentF.Default;
    sSaveSegmentF.Checked:=FReg.sSaveSegmentF.Default;
    INFO.Visible:=False;
  end
  else begin
    pLoadForm.Checked:=FReg.pLoadForm.Value;
    pSaveForm.Checked:=FReg.pSaveForm.Value;
    pShowMenuRes.Checked:=FReg.pShowMenuRes.Value;
    pReLoadRegShowForm.Checked:=FReg.pReLoadRegShowForm.Value;
    pLegendTieColorBar.Checked:=FReg.pLegendTieColorBar.Value;
    sReDrawAuto.Checked:=FReg.sReDrawAuto.Value;
    sReLoadResWhenShow.Checked:=FReg.sReLoadResWhenShow.Value;
    sLoadSegmentF.Checked:=FReg.sLoadSegmentF.Value;
    sSaveSegmentF.Checked:=FReg.sSaveSegmentF.Value;
    INFO.Visible:=True;
  end;
end;

procedure TSysSettings.pLoadFormClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.pLoadForm.Value:=pLoadForm.Checked;
    FReg.Write(FReg.pLoadForm);
  end;
end;

procedure TSysSettings.pSaveFormClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.pSaveForm.Value:=pSaveForm.Checked;
    FReg.Write(FReg.pSaveForm);
  end;
end;

procedure TSysSettings.AllUseOneSettingsClick(Sender: TObject);
begin
  FReg.AllUseOneSettings.Value:=AllUseOneSettings.Checked;
  FReg.Write(FReg.AllUseOneSettings);
end;

procedure TSysSettings.AllUseDefaultClick(Sender: TObject);
begin
  FReg.AllUseDefault.Value:=AllUseDefault.Checked;
  FReg.Write(FReg.AllUseDefault);
  SetFlags;
  ShowFlags;
end;

procedure TSysSettings.SaveSettingsToRegClick(Sender: TObject);
begin
  SaveForm(PluginReg.SysSettingsRegF.Default);
  LoadForm;
end;

procedure TSysSettings.LoadSettingsFromRegClick(Sender: TObject);
begin
  FReg.FillDefaultFlags;
  LoadRegistry(PluginReg.SysSettingsRegF.Default,PluginReg.SysSettingsRegF.Default);
  SaveForm(PluginReg.SysSettingsRegF.Current);
  LoadForm;
end;

procedure TSysSettings.SettingsToDefaultClick(Sender: TObject);
  Procedure fill;
  begin
    Freg.pLoadForm.Value:=Freg.pLoadForm.Default;
    Freg.pSaveForm.Value:=Freg.pSaveForm.Default;
    Freg.pShowMenuRes.Value:=Freg.pShowMenuRes.Default;
    Freg.pReLoadRegShowForm.Value:=Freg.pReLoadRegShowForm.Default;
    Freg.pLegendTieColorBar.Value:=Freg.pLegendTieColorBar.Default;    
    Freg.sReDrawAuto.Value:=Freg.sReDrawAuto.Default;
    Freg.sReLoadResWhenShow.Value:=Freg.sReLoadResWhenShow.Default;
    Freg.sLoadSegmentF.Value:=Freg.sLoadSegmentF.Default;
    Freg.sSaveSegmentF.Value:=Freg.sSaveSegmentF.Default;
    Freg.SaveSysForm.Value:=Freg.SaveSysForm.Default;
    Freg.AllUseOneSettings.Value:=Freg.AllUseOneSettings.Default;
    Freg.AllUseDefault.Value:=Freg.AllUseOneSettings.Default;
  end;
begin
  Freg.FillDefaultFlags;
  Fill;
  ShowFlags;
  SaveForm(PluginReg.SysSettingsRegF.Default);
  LoadForm;
end;

procedure TSysSettings.pShowMenuResClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.pShowMenuRes.Value:=pShowMenuRes.Checked;
    FReg.Write(FReg.pShowMenuRes);
  end;
end;

procedure TSysSettings.pReLoadRegShowFormClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.pReLoadRegShowForm.Value:=pReLoadRegShowForm.Checked;
    FReg.Write(FReg.pReLoadRegShowForm);
  end;
end;

procedure TSysSettings.pLegendTieColorBarClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.pLegendTieColorBar.Value:=pLegendTieColorBar.Checked;
    FReg.Write(FReg.pLegendTieColorBar);
  end;
end;

procedure TSysSettings.SaveSysFormClick(Sender: TObject);
begin
    FReg.SaveSysForm.Value:=SaveSysForm.Checked;
    FReg.Write(FReg.SaveSysForm);
end;

procedure TSysSettings.sReDrawAutoClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.sReDrawAuto.Value:=sReDrawAuto.Checked;
    FReg.Write(FReg.sReDrawAuto);
  end;
end;

procedure TSysSettings.sReLoadResWhenShowClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.sReLoadResWhenShow.Value:=sReLoadResWhenShow.Checked;
    FReg.Write(FReg.sReLoadResWhenShow);
  end;
end;

procedure TSysSettings.sLoadSegmentFClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.sLoadSegmentF.Value:=sLoadSegmentF.Checked;
    FReg.Write(FReg.sLoadSegmentF);
  end;
end;

procedure TSysSettings.sSaveSegmentFClick(Sender: TObject);
begin
  IF not(Freg.AllUseDefault.Value) then begin
    FReg.sSaveSegmentF.Value:=sSaveSegmentF.Checked;
    FReg.Write(FReg.sSaveSegmentF);
  end;
end;



procedure TSysSettings.FormResize(Sender: TObject);
begin
  Width:=600;
  Height:=300;
//  Top  :=530;
//  Left :=Screen.Width-600;
end;



end.
