unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    StaticText1: TStaticText;
    Label2: TLabel;
    Label3: TLabel;
    procedure AboutCreate(Sender: TObject);
    procedure CloseAbout(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.AboutCreate(Sender: TObject);
begin
StaticText1.Caption:='Плагин для автоматического формирования файла с результатами рассчетов' +
' для передачи на обработку в пакет SigmaPlot.'+#13#10'Обработка данных происходит путем вызова' +
' соответсвующего макроса в SigmaPlot.'+#13#10'Плагин тестировался на работу с Sigma 6.0h и SigmaPlot 11.0.'
end;

procedure TForm3.CloseAbout(Sender: TObject);
begin
Form3.Close;
end;

end.
