unit GrafX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,MainParam;

type
  TGrafikX = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GrafikX: TGrafikX;

implementation
Uses strfunc, MainInterface, TSigmaForm, SetForm;
{$R *.dfm}

// log;



procedure TGrafikX.Button1Click(Sender: TObject);
 var  MainParams,MP:TMainParams; FFileName:string;
begin

       MainParams:=GetMainParam;
       MP:=GetMainParam;
       label1.Caption:=inttostr(MainParams.NRC);
       MP.NRC:=strtoint(edit1.text);

       SetMainParam(MP);
       if SetForm1=nil then
               begin
                    FFileName:=String(Project_GetFormFile);
                    if (Length(FFileName)>0) and (LowerCase(ExtractFileExt(FFileName))='.sfm') then
                    begin
                         with TZonesClass.Create do
                         begin
                              CountOfNodesInZone:=8;
                              Load(FFileName);
                              MainParamsClass.MainParams:=MP;
                              Save(FFileName);
                              Free;
                         end;
                    end;
               end;

      //MainParam.TMainParamsForm.OKBtnClick(Sender);
end;

end.
