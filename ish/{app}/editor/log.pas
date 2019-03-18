unit log;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TlogForm = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  logForm: TlogForm;

implementation

{$R *.DFM}

procedure TlogForm.Button1Click(Sender: TObject);
begin
     close;
end;

procedure TlogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     logForm:=nil;
     Action:=caFree;
end;

end.
