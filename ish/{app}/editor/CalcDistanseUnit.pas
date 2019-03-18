unit CalcDistanseUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, TSigmaForm, Math, Buttons ;

type
  TFormSettings = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox7: TGroupBox;
    btnClosePanelCalc: TButton;
    btnCalcLinear: TButton;
    pnlLinear: TGroupBox;
    lblNode1l: TLabel;
    lblNode2l: TLabel;
    lblResLinear: TLabel;
    lblNote: TLabel;
    resLinear: TEdit;
    node1Number: TEdit;
    node2Number: TEdit;
    pnlArc: TGroupBox;
    lblNode1a: TLabel;
    lblNode2a: TLabel;
    lblResA1: TLabel;
    lblNoteA: TLabel;
    lblNode3a: TLabel;
    lblResA2: TLabel;
    lblResA3: TLabel;
    res1a: TEdit;
    node1NumberA: TEdit;
    node2NumberA: TEdit;
    node3NumberA: TEdit;
    res2a: TEdit;
    res3a: TEdit;
    lblResRadius: TStaticText;
    resRadius: TEdit;
    btnCalcArcLength: TButton;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    LabelScale: TLabel;
    TrackBar1: TTrackBar;
    EditScale: TEdit;
    procedure btnCalcArcLengthClick(Sender: TObject);
    procedure calculateLinear(nodeList : array of integer);
    procedure calculateArc(nodeList : array of integer);
    procedure btnCalcLinearClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure insertNodeIntoList(MouseX, MouseY, Scale : double);
    procedure TrackBar1Change(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;

implementation

uses SetForm;

var
  CalcLinear : boolean;
     CalcArc    : boolean;
     nodeList   : array[0..2] of integer;
     nodeCount  : integer;

{$R *.dfm}

procedure TFormSettings.btnCalcArcLengthClick(Sender: TObject);
begin
  // установить флаг
  CalcArc := True;
  // сбросить флаг вычисления расстояния по прямой
  CalcLinear := false;
  // сбросить количество узлов, отмеченных пользователем
  nodeCount := 0;

  // показать панельку пользователю
  pnlArc.Visible := true;
  // скрыть панельку расчета расстояния по прямой
  pnlLinear.Visible := false;
  // показать указание пользователю
  lblNoteA.Visible := True;
  // скрыть номера узлов и результат предыдущего расчета
  lblNode1a.Visible := false;
  lblNode2a.Visible := false;
  lblNode3a.Visible := false;
  lblResA1.Visible := false;
  lblResA2.Visible := false;
  lblResA3.Visible := false;
  res1a.Visible := false;
  res2a.Visible := false;
  res3a.Visible := false;
  node1NumberA.Visible := false;
  node2NumberA.Visible := false;
  node3NumberA.Visible := false;
  lblResRadius.Visible := false;
  resRadius.Visible := false;

end;

// Процедура добавляет номер узла в список отмеченных пользователем
procedure TFormSettings.insertNodeIntoList(MouseX, MouseY, Scale : double);
var
  nodeNumber : integer;
begin
  // Определить номер выбранного пользователем узла
  nodeNumber := Form_FindNode(MouseX, MouseY, EpsilonVicinity/Scale).Number;
  // Ничего не делать, если пользователь промахнулся
  if nodeNumber = 0 then
  begin
    exit;
  end;

  // Вставить номер узла в список
  nodeList[nodeCount] := nodeNumber;
  // Увеличить количество выбранных узлов
  nodeCount := nodeCount + 1;

  // отобразить номер выбранного узла
  if CalcLinear then
  begin
    if nodeCount = 1 then
    begin
      node1Number.Text := IntToStr(nodeNumber);
      node1Number.Visible := True;
      lblNode1l.Visible := true;
    end;
    if nodeCount = 2 then
    begin
      node2Number.Text := IntToStr(nodeNumber);
      node2Number.Visible := True;
      lblNode2l.Visible := true;
    end;
  end
  else
  begin
    if nodeCount = 1 then
    begin
      node1NumberA.Text := IntToStr(nodeNumber);
      node1NumberA.Visible := True;
      lblNode1a.Visible := true;
    end;
    if nodeCount = 2 then
    begin
      node2NumberA.Text := IntToStr(nodeNumber);
      node2NumberA.Visible := True;
      lblNode2a.Visible := true;
    end;
    if nodeCount = 3 then
    begin
      node3NumberA.Text := IntToStr(nodeNumber);
      node3NumberA.Visible := True;
      lblNode3a.Visible := true;
    end;
  end;

  // вычислить расстояние если нужно количество узлов уже выбранно
  if CalcLinear and (nodeCount = 2) then
  begin
    calculateLinear(nodeList);
  end;
  if CalcArc and (nodeCount = 3) then
  begin
    calculateArc(nodeList);
  end;
end;

procedure TFormSettings.calculateLinear(nodeList : array of integer);
var
  x1, y1, x2, y2, r : MyReal;
begin
  // получить координаты узлов
  // единица к индексу добавляется, т.к. нумерация узлов начинается с 1
  x1 := Form_GetNodeValue( nodeList[0]).x;
  y1 := Form_GetNodeValue( nodeList[0] ).y;

  x2 := Form_GetNodeValue( nodeList[1] ).x;
  y2 := Form_GetNodeValue( nodeList[1] ).y;
  // вычислить расстояние
  r := sqrt(sqr(x2 - x1) + sqr(y2 - y1));
  // вывести полученное значение пользователю
  resLinear.Text := FormatFloat('.00', r);
  resLinear.Visible := True;
  lblResLinear.Visible := true;
  // спрятать указание пользователю
  lblNote.Visible := false;
end;

function scalarProduct(x1,y1,x2,y2:MyReal) : MyReal;
begin
  Result := x1 * x2 + y1 * y2;
end;

procedure TFormSettings.calculateArc(nodeList : array of integer);
var
  x1, y1, x2, y2, x3, y3, r, a, b, c, p, s, al1, al2, al3, e,
    centrX, centrY, l1, l2, l3, phi, scalarProduct1 : MyReal;
begin
  // получить координаты узлов
  x1 := Form_GetNodeValue(nodeList[0]).x;
  y1 := Form_GetNodeValue(nodeList[0]).y;

  x2 := Form_GetNodeValue(nodeList[1]).x;
  y2 := Form_GetNodeValue(nodeList[1]).y;

  x3 := Form_GetNodeValue(nodeList[2]).x;
  y3 := Form_GetNodeValue(nodeList[2]).y;

  // проверить что узлы не лежат на одной прямой
  e := abs((y2 - y1)*(x3 - x1)  - (x2 - x1)*(y3 - y1));
  if (e < 0.1 ) then
  begin
    // показать сообщение пользователю
    ShowMessage('Выбранные узлы лежат на одной прямой.');
    exit;
  end;

  // вычислить радиус окружности
  // вычислить длины строн треугольника вписанного в окружности
  // вершины которого совпадают с выбранными узлами
  a := sqrt(sqr(x3 - x2) + sqr(y3 - y2));
  b := sqrt(sqr(x3 - x1) + sqr(y3 - y1));
  c := sqrt(sqr(x2 - x1) + sqr(y2 - y1));
  p := (a + b + c) / 2 ;
  r := a*b*c/(4*sqrt(p*(p-a)*(p-b)*(p-c)));

  // отобразить пользователю вычисленный радиус
  resRadius.Text := FormatFloat('.00',r);
  resRadius.Visible := true;
  lblResRadius.Visible := true;

  // вычислить площадь треугольника
  s := sqrt(p*(p-a)*(p-b)*(p-c));

  // вычислить центр окружности проведенной через 3 точки
  // формулы взяты: http://ru.wikipedia.org/wiki/Описанная_окружность
  al1 := sqr(a)/8.0/sqr(s)*scalarProduct((x1-x2),(y1-y2),(x1-x3),(y1-y3));
  al2 := sqr(b)/8.0/sqr(s)*scalarProduct((x2-x1),(y2-y1),(x2-x3),(y2-y3));
  al3 := sqr(c)/8.0/sqr(s)*scalarProduct((x3-x1),(y3-y1),(x3-x2),(y3-y2));

  centrX := al1 * x1 + al2 * x2 + al3 * x3;
  centrY := al1 * y1 + al2 * y2 + al3 * y3;

  // вычислить скалярное произведение векторов-разностей
  // узел1 - центр; узел2 -центр
  scalarProduct1 := scalarProduct((x1 - centrX),(y1 - centrY),(x2 - centrX),(y2 - centrY));
  // вычислить угол между отрезками соодиняющими центр и узлы
  phi := arccos(scalarProduct1/sqr(r));

  // вычислить длину дуги между первым и вторым узлом
  l1 := phi * r;
  // отобразить полученное значение пользователю
  lblResA1.Visible := true;
  res1a.Text := FormatFloat('.00', l1);
  res1a.Visible := true;

  scalarProduct1 := scalarProduct((x3 - centrX),(y3 - centrY),(x2 - centrX),(y2 - centrY));
  // вычислить угол между отрезками соодиняющими центр и узлы
  phi := arccos(scalarProduct1/sqr(r));

  // вычислить длину дуги между третьим и вторым узлом
  l2 := phi * r;
  // отобразить полученное значение пользователю
  lblResA2.Visible := true;
  res2a.Text := FormatFloat('.00',l2);
  res2a.Visible := true;

  scalarProduct1 := scalarProduct((x3 - centrX),(y3 - centrY),(x1 - centrX),(y1 - centrY));
  // вычислить угол между отрезками соодиняющими центр и узлы
  phi := arccos(scalarProduct1/sqr(r));

  // вычислить длину дуги между третьим и вторым узлом
  l3 := phi * r;
  // отобразить полученное значение пользователю
  lblResA3.Visible := true;
  res3a.Text := FormatFloat('.00',l3);
  res3a.Visible := true;

  // спрятать указание пользователю
  lblNoteA.Visible := false;
end;

procedure TFormSettings.btnCalcLinearClick(Sender: TObject);
begin
  // установить флаг
  CalcLinear := True;
  // сбросить флаг расчета расстояния по дуге
  CalcArc := false;
  // сбросить количество узлов, отмеченных пользователем
  nodeCount := 0;

  //показать панельку пользователю
  pnlLinear.Visible := true;
  // скрыть панельку расчета расстояния по дуге
  pnlArc.Visible := false;

  // показать указание пользователю
  lblNote.Visible := True;
  // скрыть номера узлов и результат предыдущего расчета
  lblNode1l.Visible := false;
  lblNode2l.Visible := false;
  lblResLinear.Visible := false;
  resLinear.Visible := false;
  node1Number.Visible := false;
  node2Number.Visible := false;
end;



procedure TFormSettings.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  // сделать кнопку открытия панели видимой
  SetForm1.btnSetVisiblePanel.Visible := true;
  // сделать панель невидимой
  Self.Visible := false;
end;

procedure TFormSettings.TrackBar1Change(Sender: TObject);
begin
  SetForm1.TrackBar1Change(Sender);  
end;

end.
