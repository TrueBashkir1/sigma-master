unit FormSettingsUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, TSigmaForm, Math, Buttons ;

type
  TFormSettings = class(TForm)
    ScrollBox2: TScrollBox;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    CurNode: TComboBox;
    EditX: TEdit;
    EditY: TEdit;
    Button4: TButton;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    AddZone: TButton;
    DelZone: TButton;
    CurZone: TComboBox;
    Button2: TButton;
    GroupBox6: TGroupBox;
    SpeedButton6: TSpeedButton;
    UseNodeNum: TCheckBox;
    UseZoneNum: TCheckBox;
    GroupBox2: TGroupBox;
    SpeedButton1: TSpeedButton;
    UseGridEps: TCheckBox;
    UseGrid: TCheckBox;
    UseBuffer: TCheckBox;
    GroupBox5: TGroupBox;
    bntClose: TButton;
    btnSave: TButton;
    btnReset: TButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    LabelScale: TLabel;
    TrackBar1: TTrackBar;
    EditScale: TEdit;
    procedure TrackBar1Change(Sender: TObject);
    procedure EditScaleExit(Sender: TObject);
    procedure EditScaleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure UseGridClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure UseNodeNumClick(Sender: TObject);
    procedure UseZoneNumClick(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure AddZoneClick(Sender: TObject);
    procedure DelZoneClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CurNodeChange(Sender: TObject);
    procedure EditXExit(Sender: TObject);
    procedure EditXKeyPress(Sender: TObject; var Key: Char);
    procedure EditYExit(Sender: TObject);
    procedure EditYKeyPress(Sender: TObject; var Key: Char);
    procedure bntCloseClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;

implementation

uses SetForm;



{$R *.dfm}

procedure TFormSettings.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // сделать кнопку открыти€ панели видимой
  //SetForm1.btnSetVisiblePanel.Caption := 'Ќастроки';
  // сделать панель невидимой
  Self.Visible := false;
end;

procedure TFormSettings.TrackBar1Change(Sender: TObject);
begin
  SetForm1.TrackBar1Change(Sender);
end;

procedure TFormSettings.EditScaleExit(Sender: TObject);
begin
  FormSettings.EditScaleExit(Sender);
end;

procedure TFormSettings.EditScaleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  SetForm1.EditScaleKeyDown(Sender, Key , Shift);
end;
procedure TFormSettings.UseGridClick(Sender: TObject);
begin
  SetForm1.UseGridClick(Sender);
end;

procedure TFormSettings.SpeedButton1Click(Sender: TObject);
begin
  SetForm1.SpeedButton1Click(Sender);
end;

procedure TFormSettings.UseNodeNumClick(Sender: TObject);
begin
  SetForm1.UseNodeNumClick(Sender);
end;

procedure TFormSettings.UseZoneNumClick(Sender: TObject);
begin
  SetForm1.UseZoneNumClick(Sender);
end;

procedure TFormSettings.SpeedButton6Click(Sender: TObject);
begin
  SetForm1.SpeedButton6Click(Sender);
end;

procedure TFormSettings.Button2Click(Sender: TObject);
begin
  SetForm1.Button2Click(Sender);
end;

procedure TFormSettings.AddZoneClick(Sender: TObject);
begin
  SetForm1.AddZoneClick(Sender);
end;

procedure TFormSettings.DelZoneClick(Sender: TObject);
begin
  SetForm1.DelZoneClick(Sender);
end;

procedure TFormSettings.Button4Click(Sender: TObject);
begin
  SetForm1.Button4Click(Sender);
end;

procedure TFormSettings.CurNodeChange(Sender: TObject);
begin
  SetForm1.CurNodeChange(Sender);
end;

procedure TFormSettings.EditXExit(Sender: TObject);
begin
  SetForm1.EditXExit(Sender);
end;

procedure TFormSettings.EditXKeyPress(Sender: TObject; var Key: Char);
begin
  SetForm1.EditXKeyPress(Sender, Key);
end;

procedure TFormSettings.EditYExit(Sender: TObject);
begin
  SetForm1.EditYExit(Sender);
end;



procedure TFormSettings.EditYKeyPress(Sender: TObject; var Key: Char);
begin
  SetForm1.EditXKeyPress(Sender, Key);
end;

procedure TFormSettings.bntCloseClick(Sender: TObject);
begin
  SetForm1.Button1Click(Sender);
end;

procedure TFormSettings.btnSaveClick(Sender: TObject);
begin
  SetForm1.SaveBtnClick(Sender);
end;

procedure TFormSettings.btnResetClick(Sender: TObject);
begin
  SetForm1.RepearBtnClick(Sender);
end;

end.
