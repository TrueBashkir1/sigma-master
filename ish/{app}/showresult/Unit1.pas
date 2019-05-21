unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls, ComCtrls,Clipbrd;

type
  TForm1 = class(TForm)
    ScrollBox1: TScrollBox;
    GroupBox2: TGroupBox;
    LabelScale: TLabel;
    TrackBar1: TTrackBar;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox9: TGroupBox;
    Label17: TLabel;
    Label16: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    EditMoveX: TEdit;
    EditMoveY: TEdit;
    TabSheet2: TTabSheet;
    StressType: TRadioGroup;
    GroupBox8: TGroupBox;
    Panel9: TPanel;
    Edit1: TEdit;
    Panel1: TPanel;
    InfoFiniteElementNumber: TEdit;
    Panel6: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label25: TLabel;
    EditX: TEdit;
    EditY: TEdit;
    StressMethod1: TRadioButton;
    StressMethod2: TRadioButton;
    StressMethod3: TRadioButton;
    Panel7: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    TabSheet3: TTabSheet;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label29: TLabel;
    GroupBox5: TGroupBox;
    Label9: TLabel;
    EditForce: TEdit;
    ForceTrackBar: TTrackBar;
    GroupBox7: TGroupBox;
    StringGrid1: TStringGrid;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit7: TEdit;
    TabSheet4: TTabSheet;
    GroupBox1: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    CheckBox2: TCheckBox;
    ZoneCheckBox: TCheckBox;
    TabSheet5: TTabSheet;
    StressType1: TRadioGroup;
    GroupBox10: TGroupBox;
    ZoneStress: TStringGrid;
    Label30: TLabel;
    TabSheet6: TTabSheet;
    StressType2: TRadioGroup;
    GroupBox11: TGroupBox;
    ZoneStress2: TStringGrid;
    Label31: TLabel;
    GroupBox4: TGroupBox;
    Mover: TTrackBar;
    Panel5: TPanel;
    Label8: TLabel;
    EditMover: TEdit;
    Group4: TGroupBox;
    GroupBox3: TGroupBox;
    LevelNumber: TLabel;
    ChangeLegend: TTrackBar;
    UseAxes: TCheckBox;
    UseNumZone: TCheckBox;
    UseNumNode: TCheckBox;
    UseLines: TCheckBox;
    UseLegend: TCheckBox;
    UseForce: TCheckBox;
    UseBound: TCheckBox;
    TestElements: TCheckBox;
    UseNumMater: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBoxZonesNum: TCheckBox;
    ZonesNumLbl: TLabel;
    NodesNumLbl: TLabel;
    ElemNumLbl: TLabel;
    PropNumLbl: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    GroupBox12: TGroupBox;
    Label37: TLabel;
    NRCNum: TLabel;
    Label38: TLabel;
    ForceLbl: TLabel;
    DimLbl: TLabel;
    Label24: TLabel;
    CurElemNum: TLabel;
    InfoMoveX: TLabel;
    InfoMoveY: TLabel;
    NodeEditInput: TEdit;
    Label26: TLabel;
    MUprug1: TLabel;
    KoefPuas1: TLabel;
    thickness1: TLabel;
    DopNapr1: TLabel;
    InfoX1: TLabel;
    InfoY1: TLabel;
    InfoXY1: TLabel;
    InfoMax1: TLabel;
    InfoMin1: TLabel;
    InfoEcv1: TLabel;
    InfoConer1: TLabel;
    Label32: TLabel;
    Label39: TLabel;
    KENumber1: TEdit;
    Label1: TLabel;
    DopNapr2: TLabel;
    CaptPropNum: TLabel;
    PropNum: TLabel;
    LabelMaxZnach: TLabel;
    LabelMinZhach: TLabel;
    KonElNumMaxNapr: TLabel;
    KonElNumMinNapr: TLabel;
    MaxZnachPlast: TLabel;
    MinZnachPlast: TLabel;
    MaxNaprPlast: TLabel;
    MinNaprPlast: TLabel;
    MaxNaprPlast1: TLabel;
    MinNaprPlast1: TLabel;
    MaxZnachPlast2: TLabel;
    MinZnachPlast2: TLabel;
    procedure ZoneCheckBoxClick(Sender: TObject);
    procedure UseLegendClick(Sender: TObject);
    procedure UseForceClick(Sender: TObject);
    procedure UseBoundClick(Sender: TObject);
    procedure UseNumNodeClick(Sender: TObject);
    procedure UseNumZoneClick(Sender: TObject);
    procedure UseNumMaterClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure UseAxesClick(Sender: TObject);
    procedure TestElementsClick(Sender: TObject);
    procedure UseLinesClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ChangeLegendChange(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure EditScaleChange(Sender: TObject);
    procedure MoverChange(Sender: TObject);
    procedure EditMoverChange(Sender: TObject);
    procedure StressMethod1Click(Sender: TObject);
    procedure StressMethod2Click(Sender: TObject);
    procedure StressMethod3Click(Sender: TObject);
    procedure ForceTrackBarChange(Sender: TObject);
    procedure StressType1Click(Sender: TObject);
    procedure StressTypeClick(Sender: TObject);
    procedure StressType2Click(Sender: TObject);
    procedure EditForceChange(Sender: TObject);
    procedure EditXChange(Sender: TObject);
    procedure EditYChange(Sender: TObject);
    procedure EditMoveXChange(Sender: TObject);
    procedure EditMoveYChange(Sender: TObject);
    procedure CheckBoxZonesNumClick(Sender: TObject);
    procedure InfoFiniteElementNumberKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure StringGrid1Click(Sender: TObject);
    procedure NodeEditInputChange(Sender: TObject);
    procedure KENumber1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);




  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

uses ShowMovings;

{$R *.dfm}

procedure TForm1.ZoneCheckBoxClick(Sender: TObject);
begin
  // dad
  ShowMovingsForm.ZoneCheckBoxClick(Sender);
  //инверсия//
  if ShowMovingsForm.ZoneCheckBox.Checked then
     ShowMovingsForm.ZoneCheckBox.Checked:=False
     else
      ShowMovingsForm.ZoneCheckBox.Checked:=True;


end;

procedure TForm1.UseLegendClick(Sender: TObject);
begin
      // dad
  ShowMovingsForm.UseLegendClick(Sender);
  //инверсия//
  IF ShowMovingsForm.UseLegend.Checked THEN BEGIN
    ShowMovingsForm.UseLegend.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.UseLegend.Checked:=True;
  END;
end;

procedure TForm1.UseForceClick(Sender: TObject);
begin
        ShowMovingsForm.RePaintPlate(Sender);
  IF ShowMovingsForm.UseForce.Checked THEN BEGIN
    ShowMovingsForm.UseForce.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.UseForce.Checked:=True;
  END;
  ShowMovingsForm.RePaintPlate(Sender);
end;

procedure TForm1.UseBoundClick(Sender: TObject);
begin
   ShowMovingsForm.RePaintPlate(Sender);
  IF ShowMovingsForm.UseBound.Checked THEN BEGIN
    ShowMovingsForm.UseBound.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.UseBound.Checked:=True;
  END;
end;

procedure TForm1.UseNumNodeClick(Sender: TObject);
begin
  ShowMovingsForm.RePaintPlate(Sender);
  IF ShowMovingsForm.UseNumNode.Checked THEN BEGIN
    ShowMovingsForm.UseNumNode.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.UseNumNode.Checked:=True;
  END;
end;

procedure TForm1.UseNumZoneClick(Sender: TObject);
begin
  ShowMovingsForm.UseNumZoneClick(Sender);
   IF ShowMovingsForm.UseNumZone.Checked THEN BEGIN
    ShowMovingsForm.UseNumZone.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.UseNumZone.Checked:=True;
  END;
end;

procedure TForm1.UseNumMaterClick(Sender: TObject);
begin
    ShowMovingsForm.UseNumMaterClick(Sender);
 IF ShowMovingsForm.UseNumMater.Checked THEN BEGIN
    ShowMovingsForm.UseNumMater.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.UseNumMater.Checked:=True;
  END;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  ShowMovingsForm.CheckBox2Click(Sender);
  IF ShowMovingsForm.CheckBox2.Checked THEN BEGIN
    ShowMovingsForm.CheckBox2.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.CheckBox2.Checked:=True;
  END;
end;

procedure TForm1.UseAxesClick(Sender: TObject);
begin
  ShowMovingsForm.UseAxesClick(Sender);
  IF ShowMovingsForm.UseAxes.Checked THEN BEGIN
    ShowMovingsForm.UseAxes.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.UseAxes.Checked:=True;
  END;

end;

procedure TForm1.TestElementsClick(Sender: TObject);
begin
   ShowMovingsForm.UseAxesClick(Sender);
  IF ShowMovingsForm.TestElements.Checked THEN BEGIN
    ShowMovingsForm.TestElements.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.TestElements.Checked:=True;
  END;
end;

procedure TForm1.UseLinesClick(Sender: TObject);
begin
   ShowMovingsForm.UseLinesClick(Sender);
  IF ShowMovingsForm.UseLines.Checked THEN BEGIN
    ShowMovingsForm.UseLines.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.UseLines.Checked:=True;
  END;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  ShowMovingsForm.UseLinesClick(Sender);
  IF ShowMovingsForm.CheckBox1.Checked THEN BEGIN
    ShowMovingsForm.CheckBox1.Checked:=False;
  END
  ELSE BEGIN
    ShowMovingsForm.CheckBox1.Checked:=True;
  END;
end;

procedure TForm1.ChangeLegendChange(Sender: TObject);
VAR
   z:integer;
BEGIN
ShowMovingsForm.ChangeLegendChange(Sender);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  ShowMovingsForm.TrackBar1Change(Sender);
end;

procedure TForm1.EditScaleChange(Sender: TObject);
begin
  ShowMovingsForm.EditScaleChange(Sender);
end;

procedure TForm1.MoverChange(Sender: TObject);
begin
  ShowMovingsForm.MoverChange(Sender);
end;

procedure TForm1.EditMoverChange(Sender: TObject);
begin
  ShowMovingsForm.EditMoverChange(Sender);
end;



procedure TForm1.StressMethod1Click(Sender: TObject);
begin
  ShowMovingsForm.StressMethod1Click(Sender);
end;

procedure TForm1.StressMethod2Click(Sender: TObject);
begin
  ShowMovingsForm.StressMethod2Click(Sender);
end;

procedure TForm1.StressMethod3Click(Sender: TObject);
begin
  ShowMovingsForm.StressMethod3Click(Sender);
end;

procedure TForm1.ForceTrackBarChange(Sender: TObject);
begin
  ShowMovingsForm.ForceTrackBarChange(Sender);
end;

procedure TForm1.StressType1Click(Sender: TObject);
begin
  //Fedorova 2019
 { If (((StressType1.ItemIndex + 1 = 8) or (StressType1.ItemIndex + 1 = 9)) and  CheckBox1.Checked = false) then
  begin
    ShowMessage('Пересечение и объединение областей можно использовать только при включении опции "Области"');
    StressType1.ItemIndex := 0;
  end;                      }
  //end Fedorova

  //ShowMovingsForm.StressType.ItemIndex := StressType1.ItemIndex;
  ShowMovingsForm.LoadMaxMinStress;
//ZHEREBTSOV 2019
//ADD LABEL OF STRESSTYPE IN WINDOW OF GRAPHICAL RESULT
StressType.ItemIndex := StressType1.ItemIndex;
StressType2.ItemIndex := StressType1.ItemIndex;

If StressType1.ItemIndex + 1 = 1 then ShowMovingsForm.TypeStress.Caption := 'Напряжение по Х';
If StressType1.ItemIndex + 1 = 2 then ShowMovingsForm.TypeStress.Caption := 'Напряжение по Y';
If StressType1.ItemIndex + 1 = 3 then ShowMovingsForm.TypeStress.Caption := 'Касательное';
If StressType1.ItemIndex + 1 = 4 then ShowMovingsForm.TypeStress.Caption := '1-ое главное';
If StressType1.ItemIndex + 1 = 5 then ShowMovingsForm.TypeStress.Caption := '2-ое главное';
If StressType1.ItemIndex + 1 = 6 then ShowMovingsForm.TypeStress.Caption := 'Эквивалентное';
If StressType1.ItemIndex + 1 = 7 then ShowMovingsForm.TypeStress.Caption := 'Угол наклона к оси Х';
If StressType1.ItemIndex + 1 = 8 then ShowMovingsForm.TypeStress.Caption := 'Пересечение';  //Fedorova 2019
If StressType1.ItemIndex + 1 = 9 then ShowMovingsForm.TypeStress.Caption := 'Объединение';  //Fedorova 2019
//END ZHEREBTSOV
end;

procedure TForm1.StressType2Click(Sender: TObject);
begin
  //Fedorova 2019
 { If (((StressType2.ItemIndex + 1 = 8) or (StressType2.ItemIndex + 1 = 9)) and  CheckBox1.Checked = false) then
  begin
    ShowMessage('Пересечение и объединение областей можно использовать только при включении опции "Области"');
    StressType2.ItemIndex := 0;
  end;                }
  //end Fedorova

  //ShowMovingsForm.StressType.ItemIndex := StressType1.ItemIndex;
  ShowMovingsForm.LoadMaxMinStressInMaterials;
//ZHEREBTSOV 2019
//ADD LABEL OF STRESSTYPE IN WINDOW OF GRAPHICAL RESULT
  StressType.ItemIndex := StressType2.ItemIndex;
  StressType1.ItemIndex := StressType2.ItemIndex;

If StressType2.ItemIndex + 1 = 1 then ShowMovingsForm.TypeStress.Caption := 'Напряжение по Х';
If StressType2.ItemIndex + 1 = 2 then ShowMovingsForm.TypeStress.Caption := 'Напряжение по Y';
If StressType2.ItemIndex + 1 = 3 then ShowMovingsForm.TypeStress.Caption := 'Касательное';
If StressType2.ItemIndex + 1 = 4 then ShowMovingsForm.TypeStress.Caption := '1-ое главное';
If StressType2.ItemIndex + 1 = 5 then ShowMovingsForm.TypeStress.Caption := '2-ое главное';
If StressType2.ItemIndex + 1 = 6 then ShowMovingsForm.TypeStress.Caption := 'Эквивалентное';
If StressType2.ItemIndex + 1 = 7 then ShowMovingsForm.TypeStress.Caption := 'Угол наклона к оси Х';
If StressType2.ItemIndex + 1 = 8 then ShowMovingsForm.TypeStress.Caption := 'Пересечение';  //Fedorova 2019
If StressType2.ItemIndex + 1 = 9 then ShowMovingsForm.TypeStress.Caption := 'Объединение';  //Fedorova 2019//END ZHEREBTSOV
end;

procedure TForm1.StressTypeClick(Sender: TObject);
begin

  //Fedorova 2019
 { If (((StressType.ItemIndex + 1 = 8) or (StressType.ItemIndex + 1 = 9)) and  CheckBox1.Checked = false) then
  begin
    ShowMessage('Пересечение и объединение областей можно использовать только при включении опции "Области"');
    StressType.ItemIndex := 0;
  end;              }
  //end Fedorova

ShowMovingsForm.ChengeLegendLevel;
ShowMovingsForm.LoadMaxMinStress;
ShowMovingsForm.LoadMaxMinStressInMaterials;
ShowMovingsForm.MainRePaint;
ShowMovingsForm.LegendRePaint;
//ZHEREBTSOV 2019
//ADD LABEL OF STRESSTYPE IN WINDOW OF GRAPHICAL RESULT

StressType1.ItemIndex := StressType.ItemIndex;
StressType2.ItemIndex := StressType.ItemIndex;

If StressType.ItemIndex + 1 = 1 then ShowMovingsForm.TypeStress.Caption := 'Напряжение по Х';
If StressType.ItemIndex + 1 = 2 then ShowMovingsForm.TypeStress.Caption := 'Напряжение по Y';
If StressType.ItemIndex + 1 = 3 then ShowMovingsForm.TypeStress.Caption := 'Касательное';
If StressType.ItemIndex + 1 = 4 then ShowMovingsForm.TypeStress.Caption := '1-ое главное';
If StressType.ItemIndex + 1 = 5 then ShowMovingsForm.TypeStress.Caption := '2-ое главное';
If StressType.ItemIndex + 1 = 6 then ShowMovingsForm.TypeStress.Caption := 'Эквивалентное';
If StressType.ItemIndex + 1 = 7 then ShowMovingsForm.TypeStress.Caption := 'Угол наклона к оси Х';
If StressType.ItemIndex + 1 = 8 then ShowMovingsForm.TypeStress.Caption := 'Пересечение';  //Fedorova 2019
If StressType.ItemIndex + 1 = 9 then ShowMovingsForm.TypeStress.Caption := 'Объединение';  //Fedorova 2019
//END ZHEREBTSOV

end;



procedure TForm1.EditForceChange(Sender: TObject);
begin
ShowMovingsForm.EditForceChange(Sender);
end;

procedure TForm1.EditXChange(Sender: TObject);
BEGIN
ShowMovingsForm.EditXChange(Sender);
end;

procedure TForm1.EditYChange(Sender: TObject);
BEGIN
ShowMovingsForm.EditXChange(Sender);

end;

procedure TForm1.EditMoveXChange(Sender: TObject);
begin
ShowMovingsForm.EditMoveXChange(Sender);
end;

procedure TForm1.EditMoveYChange(Sender: TObject);
begin
ShowMovingsForm.EditMoveXChange(Sender);
end;

procedure TForm1.CheckBoxZonesNumClick(Sender: TObject);
begin
 ShowMovingsForm.ZoneCheckBoxClick(Sender);
end;


procedure TForm1.InfoFiniteElementNumberKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = 13 then
    ShowMovingsForm.InfoFiniteElementNumberChange(Sender);
end;

// копирование выделенных(-ной) ячеек(-ки) в буфер обмена кликом мыши
procedure TForm1.StringGrid1Click(Sender: TObject);
var i,j: word;
    myRect: TGridRect;
    res: string;
begin
res:='';
myrect:=StringGrid1.Selection;
for j:=myrect.Top to myrect.Bottom do
begin
//  внесение в будущий буфер номера элемента
res:=res+StringGrid1.Cells[0,j]+#9;
for i:=myrect.Left to myrect.Right do
// внесение в будущий буфер выделенных ячеек построчно
if i=myrect.Right then res:=res+StringGrid1.Cells[i,j]
else res:=res+StringGrid1.Cells[i,j]+#9; // разделитель ячеек
    res:=res+#13#10;                     //признак конца строки
  end;
  // внесение полученной строки в буфер обмена
  ClipBoard.AsText:=Res;
end;





procedure TForm1.NodeEditInputChange(Sender: TObject);
begin
// поиск узла по номеру
if NodeEditInput.Text <> '' then
ShowMovingsForm.NodeEditInputChange(Sender);
end;





procedure TForm1.KENumber1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
         if Key = 13 then
         begin
         InfoFiniteElementNumber.Text:=KENumber1.Text;
    ShowMovingsForm.InfoFiniteElementNumberChange(Sender);
    end;
end;
end.
