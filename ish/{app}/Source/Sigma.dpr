{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
program Sigma;
{$R '_Sigma32.res' '_Sigma32.rc'}

uses
  Forms,
  Windows,
  Messages,
  Classes,
  SysUtils,
  Controls,
  Comctrls,
  Graphics,
  MainForm in 'MainForm.pas' {MainForm1},
  UPluginList in 'UPluginList.pas' {PluginList},
  AddFile in 'AddFile.pas' {AddFileForm},
  WaitForm in 'WaitForm.pas' {WaitForm1},
  Splash in 'Splash.pas' {SplashHigh},
  Unit3 in '..\editor\Unit3.pas' {Form3},
  Unit2 in '..\editor\Unit2.pas' {GrafikX},
  Unit4 in '..\editor\Unit4.pas' {GrafikY},
  Unit5 in '..\editor\Unit5.pas' {GrafikXY},
  Unit6 in '..\editor\Unit6.pas' {GrafikGL},
  About in 'About.pas' {FAbout},
  Unit7 in '..\editor\Unit7.pas' {GrafikGl2},
  Unit8 in '..\editor\Unit8.pas' {GrafikUg},
  Unit9 in '..\editor\Unit9.pas' {Form9},
  Unit10 in '..\editor\Unit10.pas' {Form10},
  Unit11 in '..\editor\Unit11.pas' {Form11},
  project_config in '..\project_config\project_config.pas' {Project_configForm},
  project_order in '..\project_config\project_order.pas' {ProjectOrderForm},
  ProjectRunUnit in '..\project_run\ProjectRunUnit.pas' {ProjectRun},
  Main in '..\Statistics_methods__Monte_Karlo\Main.pas' {Statistics_methods_Main},
  test_generator_conf in '..\Statistics_methods__Monte_Karlo\test_generator_conf.pas' {Statistics_methods_test_genrator_conf},
  test_generator_result in '..\Statistics_methods__Monte_Karlo\test_generator_result.pas' {Statistics_methods_test_genrator_result},
  Run_Result in '..\Statistics_methods__Monte_Karlo\Run_Result.pas' {Statistics_methods_Run_Result},
  Unit12 in '..\editor\Unit12.pas',
  Unit13 in '..\editor\Unit13.pas' {GrafikPerY};

{$R *.RES}
//Регистация новой картинки в списке картинок
function RegisterImage(Plugin:HModule;Name:PChar;Color:TColor):Integer;stdcall;
var
     Image:TBitmap;
     Rect:TRect;

begin


     Image:=TBitmap.Create;
     Image.LoadFromResourceName(Plugin,Name);
     Rect.Left:=0;
     Rect.Top:=0;
     Rect.Right:=16;
     Rect.Bottom:=16;
     Image.Canvas.StretchDraw(Rect,Image);
     Result:=mainform1.ActiveImageList.AddMasked(Image,Color);
     Image.Free;
end;
//Регистрация нового пункта меню
function RegisterMenu(Plugin:HModule;Caption:PChar;BitMap,main:integer;OnClick:PChar):TObject;stdcall;
var
     menu:TMyMenuItem;
begin
     if (main>MainForm1.Menu.Items.Count) or (main=0) then main:=5;
     menu:=TMyMenuItem.Create(nil);
     menu.Caption:=Caption;
     menu.Hint:=Caption;
     menu.OnClick:=MainForm1.PluginMenuClick;
     menu.ImageIndex:=BitMap;
     if OnClick<>nil then menu.MyonClick:=GetProcAddress(Plugin,OnClick);
     MainForm1.Menu.Items[main].Add(menu);
     Result:=menu;
end;
//Регистрация новой кнопки на заданной панельке
function RegisterToolButton(Plugin:HModule;Caption:PChar;BitMap:integer;ToolBar,OnClick:PChar):TObject;stdcall;
var
     i,count:integer;
     tb:TToolBar;
     button:TMyToolButton;
     maxx:integer;
begin
     count:=MainForm1.ControlBar1.ControlCount;
     tb:=nil;
     maxx:=408;
     if Count>0 then
     begin
          for i:=0 to Count-1 do
          begin
               with (MainForm1.ControlBar1.Controls[i] as TToolBar) do
               begin
                   if Caption=ToolBar then tb:=(MainForm1.ControlBar1.Controls[i] as TToolBar);
                   if Width+Left>maxx then maxx:=Width+Left;
               end;
          end;
     end;
     if tb=nil then
     begin
          tb:=TToolBar.Create(MainForm1.ControlBar1);
          tb.Parent      :=MainForm1.ControlBar1;
          tb.AutoSize    :=true;
          tb.Caption     :=ToolBar;
          tb.Hint        :=ToolBar;
          tb.EdgeBorders := [];
          tb.Flat        := True;
          tb.Images      := MainForm1.ActiveImageList;
          tb.ParentShowHint:= False;
          tb.ShowHint    := True;
          tb.TabOrder    := 0;
          tb.Name:='Toolbar_'+inttostr(count);
          tb.DragMode:=dmAutomatic;
          tb.DragKind:=dkDock;
          tb.OnResize:=MainForm1.AutoSizeToolBar;
     end;          
     button:=TMyToolButton.Create(tb);
     button.Parent:=tb;
     button.Caption:=Caption;
     button.Hint:=Caption;
     button.ShowHint:=true;
     button.Height:=22;
     button.Width:=23;
     button.OnClick:=MainForm1.PluginButtonClick;
     if OnClick<>nil then button.MyonClick:=GetProcAddress(Plugin,OnClick);
     button.ImageIndex:=BitMap;
     Result:=button;
end;
//Установка состочяния кнопки
procedure SetToolButtonStatus(Button:TObject;Enable:boolean);stdcall;
begin
     (Button as TMyToolButton).Enabled:=Enable;
end;
//установка состояния меню
procedure SetMenuStatus(menu:TObject;Enable:boolean);stdcall;
begin
     (menu as TMyMenuItem).Enabled:=Enable;
end;
//регистарция назначения плагинки. Если не известно то PluginType=0
procedure RegisterPlugin(Plugin:HModule;PluginType:integer);stdcall;
var
     count:integer;
begin
     if PluginType<>0 then
     begin
          if GetPlugin(PluginType)=0 then
          begin
               count:=Length(PluginsTypes);
               SetLength(PluginsTypes,count+1);
               PluginsTypes[count].PluginType:=PluginType;
               PluginsTypes[count].Module:=Plugin;
          end;
     end
end;

//список экспортирумых функций
exports
     RegisterImage, RegisterMenu, RegisterToolButton,
     RegisterPlugin, GetPlugin, CheckState,
     SetToolButtonStatus, SetMenuStatus;

{*************************************************************************}
{                         Load dll files                                  }
{*************************************************************************}
//загружаем dll-ки
procedure IncludePlugin(FileName:String);
var
     func:procedure(Plugin:HModule;Handle:THandle);stdcall;
     Plugin:^HModule;
begin
     new(Plugin);
     Plugin^:=LoadLibrary(PChar(FileName));
     LinkedPlugins.Add(Plugin);
     func:=GetProcAddress(Plugin^,'InitializeDLL');
     if Assigned(func) then func(Plugin^,Application.Handle);
end;
//выбераем из заданной директории все файлы с расширенем dll
procedure IncludePlugins;
var
     SearchRec: TSearchRec;
begin
     if FindFirst(ExtractFilePath(Paramstr(0))+'*.plg',
           faAnyFile-faDirectory, SearchRec) = 0 then
     begin
          IncludePlugin(SearchRec.Name);
          while FindNext(SearchRec) = 0 do
          begin
               //SplashHigh.StatusBar1.Panels[0].Text:=SearchRec.Name;
               IncludePlugin(SearchRec.Name);
          end;
          FindClose(SearchRec);
     end;
end;
//выгружаем из памяти Plugin
procedure ExcludePlugins;
var
     Plugin:^HModule;
     FinDLL : procedure;stdcall;

begin
     while LinkedPlugins.Count>0 do
     begin
          Plugin:=LinkedPlugins.Items[0];
          FinDLL:=GetProcAddress(Plugin^,'FinalizeDLL');
          if Assigned(FinDLL) then FinDLL;
          FreeLibrary(Plugin^);
          LinkedPlugins.Remove(Plugin);
          dispose(Plugin);
     end;
end;


begin
     SplashHigh:=TSplashHigh.Create(nil);
     SplashHigh.Ver.Caption:=GetAppVersion;
     SplashHigh.show;
     SendMessage(SplashHigh.Handle,wm_Paint,0,0);
     Application.Initialize;
     LinkedPlugins:=TList.Create;
     Application.Title := 'Sigma';
  Application.HelpFile := '..\help\FAQ.HLP';
  Application.CreateForm(TMainForm1, MainForm1);
  MainForm1.Caption :='САЕ'+Splash.AppTitle+' '+Splash.app_version+' - система конечно-элементного анализа';
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TGrafikX, GrafikX);
  Application.CreateForm(TPluginList, PluginList);
  Application.CreateForm(TAddFileForm, AddFileForm);
  Application.CreateForm(TWaitForm1, WaitForm1);
  Application.CreateForm(TGrafikY, GrafikY);
  Application.CreateForm(TGrafikXY, GrafikXY);
  Application.CreateForm(TGrafikGL, GrafikGL);
  Application.CreateForm(TFAbout, FAbout);
  FAbout.Label2.Caption:=  Splash.AppTitle;
  FAbout.ver.Caption:= Splash.app_version;
  FAbout.Version.Caption:='Версия от '+Splash.app_version_date;
  Application.CreateForm(TGrafikGl2, GrafikGl2);
  Application.CreateForm(TGrafikUg, GrafikUg);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TProject_configForm, Project_configForm);
  Application.CreateForm(TProjectOrderForm, ProjectOrderForm);
  Application.CreateForm(TProjectRun, ProjectRun);
  Application.CreateForm(TStatistics_methods_Main, Statistics_methods_Main);
  Application.CreateForm(TStatistics_methods_test_genrator_conf, Statistics_methods_test_genrator_conf);
  Application.CreateForm(TStatistics_methods_test_genrator_result, Statistics_methods_test_genrator_result);
  Application.CreateForm(TStatistics_methods_Run_Result, Statistics_methods_Run_Result);
  Application.CreateForm(TGrafikPerY, GrafikPerY);
  SetLength(PluginsTypes,0);
     IncludePlugins;
     CheckState;
      //SplashHigh.close;
     Application.Run;
     ExcludePlugins;
     LinkedPlugins.Free;
end.
