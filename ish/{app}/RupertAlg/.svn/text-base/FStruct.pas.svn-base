unit FStruct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Segment;


type
  TfrmZoneStruct = class(TForm)
    stgZones: TStringGrid;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
     ZoneInfo     : TZoneInfo;
     ZoneCount    : integer;
    { Public declarations }
  end;

var
  frmZoneStruct: TfrmZoneStruct;

implementation

{$R *.dfm}

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
     stgZones.ColCount := 9;
     for i:=1 to 8 do
     begin
          stgZones.Rows[0].Add('Узел '+IntToStr(i));
     end;
     for j:=1 to ZoneCount+1 do
     begin
          stgZones.Rows[j].Text := IntToStr(ZoneInfo[j-1].ZoneNum+1);
          for i:=1 to 8 do
          begin
               stgZones.Rows[j].Add(IntToStr(ZoneInfo[j-1].NodesNum[i-1]));
          end;
     end;

end;

end.
