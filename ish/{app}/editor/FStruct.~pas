unit FStruct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, SetForm, TSigmaForm;


type
  TCellDrag = record
    BeginCol : integer;
    BeginRow : integer;
    EndCol   : integer;
    EndRow   : integer;
  end;

  TStringGridHack = class(TStringGrid)
  public 
    procedure MoveColumn(FromIndex, ToIndex: Longint); 
    procedure MoveRow(FromIndex, ToIndex: Longint); 
  end;
  TfrmZoneStruct = class(TForm)
    stgZones: TStringGrid;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure stgZonesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure stgZonesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure stgZonesGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure stgZonesSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure stgZonesKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
     ZoneInfo     : TZoneInfo;
     ZoneCount    : integer;
    { Public declarations }
  end;

var
  frmZoneStruct: TfrmZoneStruct;
  ColDrag     : Boolean;
  CellDrag    : TCellDrag;
  One,Two     : String;
implementation


{$R *.dfm}

procedure TStringGridHack.MoveColumn(FromIndex, ToIndex: Integer);
begin
  inherited;
end;

procedure TStringGridHack.MoveRow(FromIndex, ToIndex: Integer);
begin
  inherited;
end;

// Нажатие кнопки "Закрыть"
procedure TfrmZoneStruct.btnCloseClick(Sender: TObject);
begin
     Close;
end;

// Процедура на событие закрытия формы
procedure TfrmZoneStruct.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     Action := caFree;
     frmZoneStruct := nil;
end;

// Отображение таблицы со структурой зон
procedure TfrmZoneStruct.FormShow(Sender: TObject);
var
     i, j : integer;
begin

     stgZones.RowCount := ZoneCount+1;
     stgZones.Rows[0].Text := 'Зона';
     stgZones.ColCount := 10;
     for i:=1 to 8 do
     begin
          stgZones.Rows[0].Add('Узел '+IntToStr(i));
     end;
     stgZones.Rows[0].Add('Площадь');
     stgZones.ColWidths[9] := 50;

     for j:=1 to ZoneCount+1 do
     begin
          stgZones.Rows[j].Text := IntToStr(ZoneInfo[j-1].ZoneNum+1);
          for i:=1 to 8 do
          begin
               stgZones.Rows[j].Add(IntToStr(ZoneInfo[j-1].NodesNum[i-1]));
          end;
          stgZones.Rows[j].Add(FloatToStr(ZoneInfo[j-1].ZoneS));
     end;

end;

procedure TfrmZoneStruct.stgZonesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  col,row:integer;
begin
    stgZones.MouseToCell(x,y,col,row);
        if (col = 0) and (row<>0 ) and (ColDrag=false) then
        begin
          ColDrag:=true;
          CellDrag.BeginRow:=row;
          Screen.Cursor:=crDrag;
        end;
end;

procedure TfrmZoneStruct.stgZonesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  col,row:integer;
begin
    stgZones.MouseToCell(x,y,col,row);
    CellDrag.EndRow:=Row;
    if  ColDrag=true then
    begin
      try
        if (CellDrag.BeginRow<>CellDrag.EndRow) and (CellDrag.EndRow<>0) then
        begin
          AddBeckUp;
          TStringGridHack(stgZones).Moverow(CellDrag.BeginRow,CellDrag.EndRow);
          Form_SwapZone(CellDrag.BeginRow-1,CellDrag.EndRow-1);
          SetForm1.UpdateVizParams;
          SetForm1.MainRePaint;
          GetZoneInfo(ZoneInfo,ZoneCount);
          frmZoneStruct.FormShow(frmZoneStruct);
        end;
      except
      end;
      ColDrag:=false;
    end;
    Screen.Cursor:=crDefault;
end;

procedure TfrmZoneStruct.stgZonesGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
   one:=Value;
end;

procedure TfrmZoneStruct.stgZonesSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  two:=Value;
end;

procedure TfrmZoneStruct.stgZonesKeyPress(Sender: TObject; var Key: Char);
var
  n,m : word;
  t: TNode;
begin
  if key=#13 then
  begin
    N:=strtoint(One);
    M:=strtoint(Two);
    if Form_GetNodeValue(M).Number>0 then
    begin
      AddBeckUp;
      Form_SetNodeNumber(Form_GetNodeValue(M).Number,999);
      Form_SetNodeNumber(N,M);
      Form_SetNodeNumber(999,N);
    end else
    begin
      AddBeckUp;
      Form_SetNodeNumber(N,M);
    end;
    SetForm1.UpdateVizParams;
    SetForm1.MainRePaint;
    GetZoneInfo(ZoneInfo,ZoneCount);
    frmZoneStruct.FormShow(frmZoneStruct);
  end
  else if not (key in ['0'..'9']) then key:=#0;
end;

procedure TfrmZoneStruct.FormActivate(Sender: TObject);
begin
          SetForm1.UpdateVizParams;
          SetForm1.MainRePaint;
          GetZoneInfo(ZoneInfo,ZoneCount);
          frmZoneStruct.FormShow(frmZoneStruct);
end;

end.
