{*********************************************************************}
{                                                                     }
{                    Московский Авиационный Институт                  }
{                                                                     }
{                               кафедра 609                           }
{                                                                     }
{                    Копылов Антон Анатольевич 2001                   }
{                                                                     }
{*********************************************************************}
Unit MainParam;

Interface

Uses
     Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     ExtCtrls, StdCtrls, Buttons, ComObj, Registry;

Type
     TMainParamsForm = Class(TForm)
               Bevel1      : TBevel;
               Label4      : TLabel;
               Label5      : TLabel;
               Label16     : TLabel;
               Label17     : TLabel;
               Label19     : TLabel;
               OKBtn       : TBitBtn;
               CancelBtn   : TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label14: TLabel;
    ORT1: TEdit;
    Label26: TLabel;
    ORT8: TEdit;
    Label27: TLabel;
    ORT15: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    ORT2: TEdit;
    Label35: TLabel;
    ORT9: TEdit;
    ORT16: TEdit;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    ORT3: TEdit;
    ORT10: TEdit;
    Label41: TLabel;
    ORT17: TEdit;
    Label42: TLabel;
    ORT4: TEdit;
    Label43: TLabel;
    ORT11: TEdit;
    Label44: TLabel;
    ORT18: TEdit;
    Label45: TLabel;
    Label46: TLabel;
    ORT7: TEdit;
    ORT14: TEdit;
    Label48: TLabel;
    ORT21: TEdit;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label8: TLabel;
    ForceY: TEdit;
    ForceX: TEdit;
    Radius: TEdit;
    Label6: TLabel;
    PRM1: TEdit;
    Label7: TLabel;
    PRM2: TEdit;
    Label15: TLabel;
    PRM3: TEdit;
    Label18: TLabel;
    L: TEdit;
    Label22: TLabel;
    Button1: TButton;
    PRM4: TEdit;
    Label52: TLabel;
    PRM5: TEdit;
    Label53: TLabel;
    Label54: TLabel;
    RadioButton4: TRadioButton;
    CheckBox1: TCheckBox;
    RadioButton3: TRadioButton;
    RadioButton5: TRadioButton;
    GroupBox5: TGroupBox;
    chb_grid_opt_dynamic: TCheckBox;
    chb_grid_opt: TCheckBox;
    CheckBox2: TRadioButton;
    Bevel2: TBevel;
    Lentmetods: TGroupBox;
    genrzn: TRadioButton;
    ProfilMethods: TGroupBox;
    genkng: TRadioButton;
    UnRazMethods: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label25: TLabel;
    Label40: TLabel;
    //////////////////
    Width: TLabel;
    INBP: TLabel;
    INRG: TLabel;
    Height: TLabel;
    GroupBox4: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    GroupBox6: TGroupBox;
    NMAT: TEdit;
    Label13: TLabel;
    NRC: TEdit;
    Label3: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    NLD: TEdit;
    NDF: TEdit;
    NCN: TEdit;
     // Жеребцов. Поменял на Label 4 параметра
               Procedure CancelBtnClick(Sender: TObject);
               Procedure OKBtnClick(Sender: TObject);
               procedure FormClose(Sender: TObject; var Action: TCloseAction);
               procedure FormCreate(Sender: TObject);
               procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure chb_grid_optClick(Sender: TObject);
    procedure chb_grid_opt_dynamicClick(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure genrznClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure genkngClick(Sender: TObject);
   
   


          private
               { Private declarations }
          public
               { Public declarations }
               Procedure LoadParams;
     End;

Var
     MainParamsForm : TMainParamsForm;
     typp: STRING;

Implementation
Uses strfunc, MainInterface, TSigmaForm, SetForm;


{
Функция для получение
имени проекта из
полного пути к файлу проекта
который лежит в реестре
}
function GetProjectName:String;
var
  projName:String;
  tempStr:String;
  slashPos:Integer;
  Registry:TRegistry;
begin
      projName := '';
     Registry        :=TRegistry.Create;
     Registry.RootKey:=HKEY_CURRENT_USER;
     if Registry.OpenKey(StringReg, true) then
     begin
          if Registry.ValueExists('InputFileName') then
          begin
          // Получаем полный путь до файла проекта
            tempStr:=Registry.ReadString('InputFileName');

            // Получаем только имя файла проекта
            while(Pos('\',tempStr) <> 0) do
            begin
              slashPos:= Pos('\',tempStr);
              Delete(tempStr,1,slashPos);
            end;
            Delete(tempStr,Pos('.',tempStr),Length(tempStr));
            // Удаляем расширение и получаем имя проекта
            projName:= tempStr;
          end;
     end;
     Result := projName;
End;

{$R *.DFM}

Procedure TMainParamsForm.LoadParams;
var
     MP:TMainParams;
     MPM:TMainParamsMaterial;
     ms:TMain_Settings;
     prName:String;
Begin
  if FileExists(Project_GetFormFile) then
  begin
   with TZonesClass.Create do
   begin
    Load(Project_GetFormFile);
    prName:= GetProjectName;

     Caption := Caption +' '+ prName;
     typp:=inttostr(MainParamsClass.MainParams.TaskType);
   //  Variant.text:=inttostr(MainParamsClass.MainParams.Variant);
     NRC.text:=inttostr(MainParamsClass.MainParams.NRC);
     Width.Caption:=floattostr(MainParamsClass.MainParams.DB);
     Height.Caption:=floattostr(MainParamsClass.MainParams.DH);
     Radius.text:=floattostr(MainParamsClass.MainParams.DR);
     ORT7.text:=floattostr(MainParamsClass.MainParams.DD);
     ForceX.text:=floattostr(MainParamsClass.MainParams.RSUMX);
     ForceY.text:=floattostr(MainParamsClass.MainParams.RSUMY);
     NLD.text:=inttostr(MainParamsClass.MainParams.CountStress);
     NDF.text:=inttostr(MainParamsClass.MainParams.CountFree);
     NCN.text:=inttostr(MainParamsClass.MainParams.CountElements);
     NMAT.text:=inttostr(MainParamsClass.MainParams.CountMaterial);
     ORT1.text:=floattostr(MainParamsClass.MainParams.E);
     ORT2.text:=floattostr(MainParamsClass.MainParams.Mju);
     ORT3.text:=floattostr(MainParamsClass.MainParams.SB);
     L.text:=floattostr(MainParamsClass.MainParams.L);


     // Добавление материалов (kotov)
     ORT8.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT8);
     ORT9.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT9);
     ORT10.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT10);
     ORT14.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT14);
     ORT15.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT15);
     ORT16.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT16);
     ORT17.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT17);
     ORT21.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT21);
     ORT4.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT4);
     ORT11.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT11);
     ORT18.text:=floattostr(MainParamsClass.MainParamsMaterial.ORT18);
     PRM1.text:=floattostr(MainParamsClass.MainParamsMaterial.PRM1);
     PRM2.text:=floattostr(MainParamsClass.MainParamsMaterial.PRM2);
     PRM3.text:=floattostr(MainParamsClass.MainParamsMaterial.PRM3);
     //PRM4.text:=floattostr(MainParamsClass.MainParamsMaterial.PRM4);
     //PRM5.text:=floattostr(MainParamsClass.MainParamsMaterial.PRM5);


    Free;
    MP:=GetMainParam;
    Width.Caption:=floattostr(MP.DB);
    Height.Caption:=floattostr(MP.DH);
    INRG.Caption:=floattostr(MP.INRG);
    INBP.Caption:=floattostr(MP.INBP);
   end;
  end
  else
  begin
     MP:=GetMainParam;
     MPM:=GetMainParamMaterial;

     typp:=inttostr(MP.TaskType);
  //   Variant.text:=inttostr(MP.Variant);  
     NRC.text:=inttostr(MP.NRC);
     Width.Caption:=floattostr(MP.DB);
     Height.Caption:=floattostr(MP.DH);
     Radius.text:=floattostr(MP.DR);
     ORT7.text:=floattostr(MP.DD);
     ForceX.text:=floattostr(MP.RSUMX);
     ForceY.text:=floattostr(MP.RSUMY);
     NLD.text:=inttostr(MP.CountStress);
     NDF.text:=inttostr(MP.CountFree);
     NCN.text:=inttostr(MP.CountElements);
     NMAT.text:=inttostr(MP.CountMaterial);
     ORT1.text:=floattostr(MP.E);
     ORT2.text:=floattostr(MP.Mju);
     ORT3.text:=floattostr(MP.SB);
     L.text:=floattostr(MP.L);
     INRG.Caption:=floattostr(MP.INRG);
     INBP.Caption:=floattostr(MP.INBP);

     // Добавление материалов (kotov)
     ORT8.text:=floattostr(MPM.ORT8);
     ORT9.text:=floattostr(MPM.ORT9);
     ORT10.text:=floattostr(MPM.ORT10);
     ORT14.text:=floattostr(MPM.ORT14);
     ORT15.text:=floattostr(MPM.ORT15);
     ORT16.text:=floattostr(MPM.ORT16);
     ORT17.text:=floattostr(MPM.ORT17);
     ORT21.text:=floattostr(MPM.ORT21);
     ORT4.text:=floattostr(MPM.ORT4);
     ORT11.text:=floattostr(MPM.ORT11);
     ORT18.text:=floattostr(MPM.ORT18);
     PRM1.text:=floattostr(MPM.PRM1);
     PRM2.text:=floattostr(MPM.PRM2);
     PRM3.text:=floattostr(MPM.PRM3);
     //PRM4.text:=floattostr(MPM.PRM4);
     //PRM5.text:=floattostr(MPM.PRM5);
  end;
//--------------------
//   Plotnikov
     ms:=get_main_sets;
{     if Ms.opt_grid_calc = 1 then begin
         chb_grid_opt.Checked:=TRUE;
      end
     else if Ms.opt_grid_calc = 0 then begin
         chb_grid_opt.Checked:=FALSE;
     end; }
     case (Ms.opt_grid_calc) of
-4: begin
       CheckBox1.Checked :=false;
       chb_grid_opt.Checked:=true;
       chb_grid_opt_dynamic.Checked:=false;
       RadioButton1.Checked:=true;
       RadioButton2.Checked:=false;
//       ShowMessage('-4');
    end;

-3: begin
       CheckBox1.Checked :=false;
       chb_grid_opt.Checked:=true;
       chb_grid_opt_dynamic.Checked:=false;
       RadioButton1.Checked:=false;
       RadioButton2.Checked:=true;
//       ShowMessage('-3');
    end;

-2: begin
       CheckBox1.Checked :=false;
       chb_grid_opt.Checked:=false;
       chb_grid_opt_dynamic.Checked:=false;
       RadioButton1.Checked:=true;
       RadioButton2.Checked:=false;
//       ShowMessage('-2');
    end;

-1: begin
       CheckBox1.Checked :=false;
       chb_grid_opt.Checked:=false;
       chb_grid_opt_dynamic.Checked:=false;
       RadioButton1.Checked:=false;
       RadioButton2.Checked:=true;
//       ShowMessage('-1');
    end;

0:begin
CheckBox1.Checked :=true;
  chb_grid_opt.Checked:=false;
  chb_grid_opt_dynamic.Checked:=false;
  radiobutton1.Checked := true;
  radiobutton2.Checked := false;
  radiobutton3.Checked := true;
  radiobutton4.Checked := false;
  CheckBox2.Checked := false;
  RadioButton5.Checked := false;
  genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('0');
  end;

//Прямой КМ
    11:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := true;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
    genrzn.Checked:=false;
      end;

// Э(А) и У
    21:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := true;
      genkng.Checked:=false;
    genrzn.Checked:=false;
      end;

1:begin
CheckBox1.Checked :=true;
  chb_grid_opt.Checked:=true;
  chb_grid_opt_dynamic.Checked:=false;
  radiobutton1.Checked := true;
  radiobutton2.Checked := false;
  radiobutton3.Checked := true;
  radiobutton4.Checked := false;
  CheckBox2.Checked := false;
  RadioButton5.Checked := false;
  genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('1');
  end;

    12:begin
      CheckBox1.Checked :=true;
        chb_grid_opt.Checked:=true;
        chb_grid_opt_dynamic.Checked:=false;
        radiobutton1.Checked := true;
        radiobutton2.Checked := false;
        radiobutton4.Checked := false;
        CheckBox2.Checked := true;
        RadioButton5.Checked := false;
        genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

    22:begin
      CheckBox1.Checked :=true;
        chb_grid_opt.Checked:=true;
        chb_grid_opt_dynamic.Checked:=false;
        radiobutton1.Checked := true;
        radiobutton2.Checked := false;
        radiobutton3.Checked := false;
        radiobutton4.Checked := false;
        CheckBox2.Checked := false;
        RadioButton5.Checked := true;
        genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

2:begin
CheckBox1.Checked :=true;
  chb_grid_opt.Checked:=false;
  chb_grid_opt_dynamic.Checked:=false;
  radiobutton1.Checked := true;
  radiobutton2.Checked := false;
  radiobutton3.Checked := false;
  radiobutton4.Checked := true;
  CheckBox2.Checked := false;
  RadioButton5.Checked := false;
  genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('2');
  end;

3:begin
CheckBox1.Checked :=true;
  chb_grid_opt.Checked:=true;
  chb_grid_opt_dynamic.Checked:=false;
  radiobutton1.Checked := true;
  radiobutton2.Checked := false;
  radiobutton3.Checked := false;
  radiobutton4.Checked := true;
  CheckBox2.Checked := false;
  RadioButton5.Checked := false;
  genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('3');
  end;

4:begin
CheckBox1.Checked :=true;
  chb_grid_opt.Checked:=false;
  chb_grid_opt_dynamic.Checked:=false;
  radiobutton1.Checked := false;
  radiobutton2.Checked := true;
  radiobutton3.Checked := true;
  radiobutton4.Checked := false;
  CheckBox2.Checked := false;
  RadioButton5.Checked := false;
  genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('4');
  end;

  13:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton4.Checked := false;
      CheckBox2.Checked := true;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

  23:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := true;
      genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

5:begin
CheckBox1.Checked :=true;
  chb_grid_opt.Checked:=true;
  chb_grid_opt_dynamic.Checked:=false;
  radiobutton1.Checked := false;
  radiobutton2.Checked := true;
  radiobutton3.Checked := true;
  radiobutton4.Checked := false;
  CheckBox2.Checked := false;
  RadioButton5.Checked := false;
  genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('5');
  end;

  14:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=true;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton4.Checked := false;
      CheckBox2.Checked := true;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

  24:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=true;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := true;
      genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

6:begin
CheckBox1.Checked :=true;
  chb_grid_opt.Checked:=false;
  chb_grid_opt_dynamic.Checked:=false;
  radiobutton1.Checked := false;
  radiobutton2.Checked := true;
  radiobutton3.Checked := false;
  radiobutton4.Checked := true; 
  CheckBox2.Checked := false;
  RadioButton5.Checked := false;
  genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('6');
  end;

7:begin
CheckBox1.Checked :=true;
  chb_grid_opt.Checked:=true;
  chb_grid_opt_dynamic.Checked:=false;
  radiobutton1.Checked := false;
  radiobutton2.Checked := true;
  radiobutton3.Checked := false;
  radiobutton4.Checked := true;
  CheckBox2.Checked := false;
  RadioButton5.Checked := false;
  genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('7');
  end;

// Оптимизация с динамическим шагом
  31:begin
       CheckBox1.Checked :=false;
       chb_grid_opt.Checked:=false;
       chb_grid_opt_dynamic.Checked:=true;
       RadioButton1.Checked:=true;
       RadioButton2.Checked:=false;
    end;

    
  32: begin
       CheckBox1.Checked :=false;
       chb_grid_opt.Checked:=false;
       chb_grid_opt_dynamic.Checked:=true;
       RadioButton1.Checked:=false;
       RadioButton2.Checked:=true;
    end;

  33:begin
  CheckBox1.Checked :=true;
    chb_grid_opt.Checked:=false;
    chb_grid_opt_dynamic.Checked:=true;
    radiobutton1.Checked := true;
    radiobutton2.Checked := false;
    radiobutton3.Checked := true;
    radiobutton4.Checked := false;
    CheckBox2.Checked := false;
    RadioButton5.Checked := false;
    genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('1');
  end;
  
    34:begin
      CheckBox1.Checked :=true;
        chb_grid_opt.Checked:=false;
        chb_grid_opt_dynamic.Checked:=true;
        radiobutton1.Checked := true;
        radiobutton2.Checked := false;
        radiobutton4.Checked := false;
        CheckBox2.Checked := true;
        RadioButton5.Checked := false;
        genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

     35:begin
      CheckBox1.Checked :=true;
        chb_grid_opt.Checked:=false;
        chb_grid_opt_dynamic.Checked:=true;
        radiobutton1.Checked := true;
        radiobutton2.Checked := false;
        radiobutton3.Checked := false;
        radiobutton4.Checked := false;
        CheckBox2.Checked := false;
        RadioButton5.Checked := true;
        genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

    
    36:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=true;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton3.Checked := false;
      radiobutton4.Checked := true;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

    
  37:begin
    CheckBox1.Checked :=true;
    chb_grid_opt.Checked:=false;
    chb_grid_opt_dynamic.Checked:=true;
    radiobutton1.Checked := false;
    radiobutton2.Checked := true;
    radiobutton3.Checked := true;
    radiobutton4.Checked := false;
    CheckBox2.Checked := false;
    RadioButton5.Checked := false;
    genkng.Checked:=false;
    genrzn.Checked:=false;
  end;

  
  38:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=true;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton4.Checked := false;
      CheckBox2.Checked := true;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

    
  39:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=true;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := true;
      genkng.Checked:=false;
    genrzn.Checked:=false;
    end;

  30:begin
  CheckBox1.Checked :=true;
    chb_grid_opt.Checked:=false;
    chb_grid_opt_dynamic.Checked:=true;
    radiobutton1.Checked := false;
    radiobutton2.Checked := true;
    radiobutton3.Checked := false;
    radiobutton4.Checked := true;
    CheckBox2.Checked := false;
    RadioButton5.Checked := false;
    genkng.Checked:=false;
    genrzn.Checked:=false;
//  ShowMessage('7');
  end;

    40:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=true;
      genrzn.Checked:=false;
    end;

    41:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=true;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=true;
      genrzn.Checked:=false;
    end;

    42:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=true;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=true;
      genrzn.Checked:=false;
    end;
    43:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=true;
      genrzn.Checked:=false;
    end;
    44:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=true;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=true;
      genrzn.Checked:=false;
    end;
    45:begin
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=true;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=true;
      genrzn.Checked:=false;
    end;

    50:begin
    CheckBox1.Checked :=true;
    Lentmetods.Enabled:=true;
    ProfilMethods.Enabled:=false;
    UnRazMethods.Enabled:=false;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
      genrzn.Checked:=true;
    end;
    51:begin
    CheckBox1.Checked :=true;
    Lentmetods.Enabled:=true;
    ProfilMethods.Enabled:=false;
    UnRazMethods.Enabled:=false;
      chb_grid_opt.Checked:=true;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
      genrzn.Checked:=true;
    end;
    52:begin
    CheckBox1.Checked :=true;
    Lentmetods.Enabled:=true;
    ProfilMethods.Enabled:=false;
    UnRazMethods.Enabled:=false;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=true;
      radiobutton1.Checked := true;
      radiobutton2.Checked := false;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
      genrzn.Checked:=true;
    end;
    53:begin
    CheckBox1.Checked :=true;
    Lentmetods.Enabled:=true;
    ProfilMethods.Enabled:=false;
    UnRazMethods.Enabled:=false;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
      genrzn.Checked:=true;
    end;
    54:begin
    CheckBox1.Checked :=true;
    Lentmetods.Enabled:=true;
    ProfilMethods.Enabled:=false;
    UnRazMethods.Enabled:=false;
      chb_grid_opt.Checked:=true;
      chb_grid_opt_dynamic.Checked:=false;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
      genrzn.Checked:=true;
    end;
    55:begin
    Lentmetods.Enabled:=true;
    ProfilMethods.Enabled:=false;
    UnRazMethods.Enabled:=false;
    CheckBox1.Checked :=true;
      chb_grid_opt.Checked:=false;
      chb_grid_opt_dynamic.Checked:=true;
      radiobutton1.Checked := false;
      radiobutton2.Checked := true;
      radiobutton3.Checked := false;
      radiobutton4.Checked := false;
      CheckBox2.Checked := false;
      RadioButton5.Checked := false;
      genkng.Checked:=false;
      genrzn.Checked:=true;
    end;
end;
//--------------------

end;
Procedure TMainParamsForm.CancelBtnClick(Sender: TObject);
Begin
     close;
End;

Procedure GetZoneInfo_2;  // Яговкин
        Var
             MainParams         : TMainParams;
             CountOfNodes, i, j : word;
             OneNode            : TNode;
             CountOfEdges       : word;
             ex                 : textfile;
             s                  : string;
             e                  : real;
        Begin

             assignfile(ex,'Delone.txt');
             rewrite(ex);
             MainParams:=GetMainParam;
         showmessage(inttostr(MainParams.NRC));
             CountOfNodes:=Form_CountOfNodesInZone;
             CountOfEdges:=round(CountOfNodes/(MainParams.CountElements-1));
             ZoneCount := MainParams.INRG;
             writeln(ex,String(ExtractFilePath(Project_GetFormFile)));
             writeln(ex,inttostr(MainParams.NRC));
             If MainParams.INRG>0 Then
             Begin
                  For i:=0 To MainParams.INRG-1 Do
                  Begin
                       For j:=0 To CountOfNodes-1 Do
                       Begin
                            OneNode:=Form_GetNodeValue(Form_GetNodeNumber(i,j));
                            ZoneInfo[i].ZoneNum := i;
                            ZoneInfo[i].NodesNum[j] := OneNode.Number;

                            ZoneInfo[i].NodesCoord[0,j] := OneNode.x;
                            ZoneInfo[i].NodesCoord[1,j] := OneNode.y;
//              ShowMessage(floattostr(OneNode.y)+'   '+floattostr(OneNode.x));
    //          writeln(ex,(OneNode.number));
  //            writeln(ex,floattostr(OneNode.x));
//              writeln(ex,floattostr(OneNode.y));
             writeln(ex,(OneNode.number));
              writeln(ex,(OneNode.x/3));
              writeln(ex,(OneNode.y/3));

                       End;
                  End;
             End;
//reset(ex);
//              readln(ex,s);
 //             showmessage(s);
  //            readln(ex,e);
   //           For i:=0 To 20 Do
    //              Begin
         //     showmessage(floattostr(e));
    //          readln(ex,e);
//end;
             closefile(ex);



End;              //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Procedure TMainParamsForm.OKBtnClick(Sender: TObject);
Const
     messeges: Array[1..21] Of String= (
     'Неверно задан тип задачи.',
     'Неверно задан вариант.',
     'Неверно задан параметр NRC. Он должен быть больше 2.',
     'Неверно задана ширина.',
     'Неверно задана высота.',

     'Неверно задан радиус отверстия.',
     'Неверно задана толщина.',
     'Неверно задана суммарная нагрузка по X.',
     'Неверно задана суммарная нагрузка по Y.',
     'Неверно задано число случаев нагружения.',

     'Неверно задано число степеней свободы.',
     'Неверно задано число узлов в элементе.',// Оно должен быть больше 2.',
     'Неверно задано число материалов.','','','','',
     'В одном из материалов неверно задан модуль E.',
     'В одном из материалов неверно задан модуль Мю.',

     'В одном из материалов неверно задано допускаемое напряжение.',
     'В одном из материалов неверно задана толщина.'
     );
Var
     Error : word;
     MainParams,MP    : TMainParams;
     MPM              : TMainParamsMaterial;
     MS               : TMain_Settings;
     FFileName:string;
     Registry :TRegistry;
PlugExec : function(): boolean;
      handle : Thandle;
      ex                 : textfile;
      FindRes : integer;
      SR: TSearchRec;
label
a1,a2;
Begin
     MainParams:=GetMainParam;
     MP:=MainParams;
     MPM:=GetMainParamMaterial;
     Error:=0;
     If (Error=0) And (Not CheckByte(typp, MP.TaskType)) Then Error:=1;
   //  If (Error=0) And (Not CheckByte(Variant.text, MP.Variant)) Then Error:=2;
     If (Error=0) And (Not CheckWord(NRC.text, MP.NRC)) Then Error:=3;
     If (Error=0) And (Not CheckReal(Width.Caption, MP.DB)) Then Error:=4;
     If (Error=0) And (Not CheckReal(Height.Caption, MP.DH)) Then Error:=5;
     If (Error=0) And (Not CheckReal(Radius.text, MP.DR)) Then Error:=6;
     If (Error=0) And (Not CheckReal(ORT7.text, MP.DD)) Then Error:=21;
     If (Error=0) And (Not CheckReal(ForceX.text, MP.RSUMX)) Then Error:=8;
     If (Error=0) And (Not CheckReal(ForceY.text, MP.RSUMY)) Then Error:=9;
     If (Error=0) And (Not CheckInt(NLD.text, MP.CountStress)) Then Error:=10;
     If (Error=0) And (Not CheckInt(NDF.text, MP.CountFree)) Then Error:=11;
     If (Error=0) And (Not CheckInt(NCN.text, MP.CountElements)) Then Error:=12;
     If (Error=0) And (Not CheckInt(NMAT.text, MP.CountMaterial)) Then Error:=13;
     If (Error=0) And (Not CheckReal(ORT1.text, MP.E)) Then Error:=18;
     If (Error=0) And (Not CheckReal(ORT2.text, MP.Mju)) Then Error:=19;
     If (Error=0) And (Not CheckReal(ORT3.text, MP.SB)) Then Error:=20;

     If (Error=0) And (Not CheckReal(ORT8.text, MPM.ORT8)) Then Error:=18;
     If (Error=0) And (Not CheckReal(ORT9.text, MPM.ORT9)) Then Error:=19;
     If (Error=0) And (Not CheckReal(ORT10.text, MPM.ORT10)) Then Error:=20;
     If (Error=0) And (Not CheckReal(ORT14.text, MPM.ORT14)) Then Error:=21;

     If (Error=0) And (Not CheckReal(ORT15.text, MPM.ORT15)) Then Error:=18;
     If (Error=0) And (Not CheckReal(ORT16.text, MPM.ORT16)) Then Error:=19;
     If (Error=0) And (Not CheckReal(ORT17.text, MPM.ORT17)) Then Error:=20;
     If (Error=0) And (Not CheckReal(ORT21.text, MPM.ORT21)) Then Error:=21;

     If (Error=0) And (Not CheckReal(ORT4.text, MPM.ORT4)) Then Error:=20;
     If (Error=0) And (Not CheckReal(ORT11.text, MPM.ORT11)) Then Error:=20;
     If (Error=0) And (Not CheckReal(ORT18.text, MPM.ORT18)) Then Error:=20;
//--- Выбор расчёт с оптимизацией сетки и без неё
//      Musolov
{     if chb_grid_opt.Checked then begin
         Ms.opt_grid_calc := 1;
      end
     else begin
         Ms.opt_grid_calc := 0;
      end;   }
      {Plotnikov}
if checkbox1.Checked then goto a1;
if RadioButton1.Checked then ms.opt_grid_calc := -2;
if RadioButton2.Checked then ms.opt_grid_calc := -1;
if chb_grid_opt.Checked and RadioButton1.Checked then
ms.opt_grid_calc := -4;
if chb_grid_opt.Checked and RadioButton2.Checked then
ms.opt_grid_calc := -3;

if chb_grid_opt_dynamic.Checked and RadioButton2.Checked then
ms.opt_grid_calc := 32;
if chb_grid_opt_dynamic.Checked and RadioButton1.Checked then
ms.opt_grid_calc := 31;
goto a2;

a1:
if chb_grid_opt.Checked then ms.opt_grid_calc := 1;
if RadioButton4.Checked then ms.opt_grid_calc := 2;
if chb_grid_opt.Checked and RadioButton4.Checked then ms.opt_grid_calc := 3;
if RadioButton2.Checked then ms.opt_grid_calc := 4;
if chb_grid_opt.Checked and RadioButton2.Checked then ms.opt_grid_calc := 5;
if RadioButton4.Checked and RadioButton2.Checked then ms.opt_grid_calc := 6;
if chb_grid_opt.Checked and RadioButton4.Checked and RadioButton2.Checked then
      ms.opt_grid_calc := 7;
if chb_grid_opt.Checked and CheckBox2.Checked and RadioButton2.Checked
     then ms.opt_grid_calc := 14;
if chb_grid_opt.Checked and CheckBox2.Checked
     then ms.opt_grid_calc := 12;
if not(chb_grid_opt.Checked) and CheckBox2.Checked and RadioButton2.Checked
     then ms.opt_grid_calc := 13;
if not(chb_grid_opt.Checked) and CheckBox2.Checked
     then ms.opt_grid_calc := 11;
if chb_grid_opt.Checked and RadioButton5.Checked and RadioButton2.Checked
     then ms.opt_grid_calc := 24;
if chb_grid_opt.Checked and RadioButton5.Checked
     then ms.opt_grid_calc := 22;
if not(chb_grid_opt.Checked) and RadioButton5.Checked and RadioButton2.Checked
     then ms.opt_grid_calc := 23;
if not(chb_grid_opt.Checked) and RadioButton5.Checked
     then ms.opt_grid_calc := 21;

//для алгоритма кинга
if genkng.Checked and RadioButton1.Checked then
      ms.opt_grid_calc:=40;
if genkng.Checked and RadioButton1.Checked and chb_grid_opt.Checked then
      ms.opt_grid_calc:=41;
if genkng.Checked and RadioButton1.Checked and chb_grid_opt_dynamic.Checked then
      ms.opt_grid_calc:=42;
if genkng.Checked and RadioButton2.Checked then
      ms.opt_grid_calc:=43;
if genkng.Checked and RadioButton2.Checked and chb_grid_opt.Checked then
      ms.opt_grid_calc:=44;
if genkng.Checked and RadioButton2.Checked and chb_grid_opt_dynamic.Checked then
      ms.opt_grid_calc:=45;

//для алгоритма Розена
if genrzn.Checked and RadioButton1.Checked then
      ms.opt_grid_calc:=50;
if genrzn.Checked and RadioButton1.Checked and chb_grid_opt.Checked then
      ms.opt_grid_calc:=51;
if genrzn.Checked and RadioButton1.Checked and chb_grid_opt_dynamic.Checked then
      ms.opt_grid_calc:=52;
if genrzn.Checked and RadioButton2.Checked then
      ms.opt_grid_calc:=53;
if genrzn.Checked and RadioButton2.Checked and chb_grid_opt.Checked then
      ms.opt_grid_calc:=54;
if genrzn.Checked and RadioButton2.Checked and chb_grid_opt_dynamic.Checked then
      ms.opt_grid_calc:=55;




if chb_grid_opt_dynamic.Checked and RadioButton4.Checked and RadioButton2.Checked then
      ms.opt_grid_calc := 30;
if chb_grid_opt_dynamic.Checked and RadioButton5.Checked and RadioButton2.Checked
     then ms.opt_grid_calc := 39;
if chb_grid_opt_dynamic.Checked and CheckBox2.Checked and RadioButton2.Checked
     then ms.opt_grid_calc := 38;
if chb_grid_opt_dynamic.Checked and RadioButton3.Checked and RadioButton2.Checked
      then ms.opt_grid_calc := 37;
if chb_grid_opt_dynamic.Checked and RadioButton4.Checked then ms.opt_grid_calc := 36;
if chb_grid_opt_dynamic.Checked and RadioButton5.Checked
     then ms.opt_grid_calc := 35;
if chb_grid_opt_dynamic.Checked and RadioButton3.Checked and RadioButton1.Checked
      then ms.opt_grid_calc := 33;
if chb_grid_opt_dynamic.Checked and CheckBox2.Checked and
    RadioButton1.checked then ms.opt_grid_calc := 34;      

a2:

      Set_Main_Sets(ms);
      Registry        :=TRegistry.Create;
      Registry.RootKey:=HKEY_CURRENT_USER;
      if Registry.OpenKey(StringReg, true) then
         begin
             Registry.WriteInteger('GridOpt',ms.opt_grid_calc);
         end;
      Registry.Free;
//----
//--- test
//     if test.Checked then begin
//         ShowMessage('крути педали');
//      end
//     else begin
//         ShowMessage('обломчеГ');
//      end;
//----
     CheckReal(PRM1.text, MPM.PRM1);
     CheckReal(PRM2.text, MPM.PRM2);
     CheckReal(PRM3.text, MPM.PRM3);
     //CheckReal(PRM4.text, MPM.PRM4);
     //CheckReal(PRM5.text, MPM.PRM5);

     If (Error=0) And (Not CheckReal(L.text, MP.L)) Then Error:=17;
     If (Error=0) And (MP.NRC<3) Then Error:=3;
     If (Error=0) And (MP.CountElements<>3) Then Error:=12;
     If Error=0 Then
     Begin
          {If MP.CountElements<>MainParams.CountElements Then
          Begin
               If MessageDlg('Изменение числа узлов в элементе приведет к удалению всей формы.'+#13+'Продолжить?', mtConfirmation,[mbOk,mbCancel], 0) = mrOK Then
               Begin
                    SigmaProject.ClearForm;
               End
               Else Begin
                    Error:=12;//не имеет значения что лишь бы <> 0
                    MP.CountElements:=SigmaProject.MainParams.CountElements;
               End;

          End;}

          If Error=0 Then
          Begin
               SetMainParam(MP);
               SetMainParamMaterial(MPM);  // Добавление материалов (kotov)
             //  SetSila(Sila.ItemIndex);
               SaveSdmFile;
             //  if SetForm1=nil then
             //  begin
                    FFileName:=String(Project_GetFormFile);
                    if (Length(FFileName)>0) and (LowerCase(ExtractFileExt(FFileName))='.sfm') then
                    begin
                         with TZonesClass.Create do
                         begin
                              CountOfNodesInZone:=8;
                              Load(FFileName);
                              MainParamsClass.MainParams:=MP;
                              MainParamsClass.MainParamsMaterial:=MPM;  // Добавление материалов (kotov)
                              Save(FFileName);
                              Free;
                         end;

                                             { with TMain_Settings_Class.Create do
                         begin
                                ShowMessage ('+');
                                Load_Sets(FFileName);
                                ShowMessage ('++');
                                Main_Settings := MS;
                                Save_Sets(FFileName);
                                ShowMessage('+++');
                                Free;
                         end;   }  
                    end;
             //  end;
               Close;
          End;
{
if Delone.Checked then begin
  GetZoneInfo_2;
//*****************************************  Яговкин

  handle := LoadLibrary('Delone.plg');  //????????? dll
   //???? ??? ? ???????, ?? ???? ??????
  if handle <> 0 then
  begin
   @plugExec := GetProcAddress(handle,'PluginExec');
            plugExec;
  end;



//*****************************************
  end
  else begin
       deletefile('c:Delone.txt');
  end;}
end
Else showmessage(messeges[Error]);

End;

// резотта
procedure TMainParamsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
        CheckState;
end;

procedure TMainParamsForm.FormCreate(Sender: TObject);
begin
    LoadParams;
end;

procedure TMainParamsForm.FormDestroy(Sender: TObject);
begin
     MainParamsForm:=nil;
        CheckState;
end;

procedure TMainParamsForm.Button1Click(Sender: TObject);
 var
   Word: OLEVariant;
 begin
   try
     Word := CreateOleObject('Word.Application');
   except
     ShowMessage('Программа MsWord не найдена');
     Exit;
   end;

   Word.Documents.Add;
   Word.Selection.Font.Name := 'Times New Roman';
   Word.Selection.Font.Size := 16;
   Word.Selection.Font.Bold := True;

   Word.Selection.TypeText('Основные параметры:');//Text := edit3.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Name := 'Times New Roman';
   Word.Selection.Font.Size := 12;
   Word.Selection.Font.Bold := false;
 //  Word.Selection.TypeText('Вариант (nvar) :'+Variant.Text);
 // Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Число материалов (nmat):'+NMAT.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Параметр разбиения (nrc):'+NRC.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Число случаев нагружения (nld):'+NLD.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Число степеней свободы (ndf):'+NDF.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Число узлов в элементе (ncn):'+NCN.Text);
   Word.Selection.TypeParagraph;
                                   
   Word.Selection.Font.Bold := True;
   Word.Selection.TypeText('Свойство КЭ');
 //  Word.Selection.TypeParagraph;
   Word.Selection.Font.Bold := false;

  // Word.Selection.TypeText('Используемая сила:'+Sila.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Bold := True;
   Word.Selection.TypeText('Номер материала - 1:');
   Word.Selection.Font.Bold := false;
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Модуль упругости E ORT(1): '+ORT1.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Коэффициент Пуассона ORT(2): '+ORT2.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Допускаемое напряжение ORT(3): '+ORT3.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Допускаемое отриц. напр. ORT(4): '+ORT4.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Толщина ORT(7): '+ORT7.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Bold := True;
   Word.Selection.TypeText('Номер материала - 2:');
   Word.Selection.Font.Bold := false;
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Модуль упругости E ORT(8): '+ORT8.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Коэффициент Пуассона ORT(9): '+ORT9.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Допускаемое напряжение ORT(10): '+ORT10.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Допускаемое отриц. напр. ORT(11): '+ORT11.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Толщина ORT(14): '+ORT14.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Bold := True;
   Word.Selection.TypeText('Номер материала - 3:');
   Word.Selection.Font.Bold := false;
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Модуль упругости E ORT(15): '+ORT15.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Коэффициент Пуассона ORT(16): '+ORT16.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Допускаемое напряжение ORT(17): '+ORT17.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Допускаемое отриц. напр. ORT(18): '+ORT18.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Толщина ORT(21): '+ORT21.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Bold := True;
   Word.Selection.TypeText('Параметры, определяемые автоматически при задании координат пластины и разбивке ее на зоны:');
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Bold := false;
   Word.Selection.TypeText('Максимальная ширина пластины (db): '+Width.Caption);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Максимальная высота пластины (dh): '+Height.Caption);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Общее число точек, задающих пластину (inbp): '+INBP.Caption);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('Количество зон (inrg): '+INRG.Caption);
   Word.Selection.TypeParagraph;
 //  Word.Selection.TypeText('Размерность: '+Dimension.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Bold := True;
   Word.Selection.TypeText('Свободные параметры:');
   Word.Selection.TypeParagraph;
   Word.Selection.Font.Bold := false;
   Word.Selection.TypeText('RSUMX: '+ForceX.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('RSUMY: '+ForceY.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('DR: '+Radius.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('PRM1: '+PRM1.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('PRM2: '+PRM2.Text);
   Word.Selection.TypeParagraph;
   Word.Selection.TypeText('PRM3: '+PRM3.Text);
   Word.Selection.TypeParagraph;
//   Word.Selection.TypeText('PRM4: '+PRM4.Text);
 //  Word.Selection.TypeParagraph;
   //Word.Selection.TypeText('PRM5: '+PRM5.Text);
   //Word.Selection.TypeParagraph;


   Word.Visible := True;
end;



procedure TMainParamsForm.CheckBox1Click(Sender: TObject);

begin
      if (checkbox1.Checked)then
      begin
      RadioButton3.Enabled := true;
      RadioButton3.checked := true;
      Radiobutton4.Enabled := true;
      CheckBox2.Enabled := true;
      RadioButton5.Enabled := true;
      genrzn.Enabled:=true;
      genkng.Enabled:=true;
      //ShowMessage('checked');
      exit;
      end;
      if (not(checkbox1.Checked))then
      RadioButton3.Enabled := false;
      Radiobutton4.Enabled := false;
      CheckBox2.Enabled := false;
      CheckBox2.Checked := false;
      Radiobutton5.Enabled := false;
      genrzn.Enabled:=false;
      genkng.Enabled:=false;
      //ShowMessage('not checked');
      exit;
      end;


procedure TMainParamsForm.chb_grid_optClick(Sender: TObject);
begin
    chb_grid_opt_dynamic.Checked :=False;
end;

procedure TMainParamsForm.chb_grid_opt_dynamicClick(Sender: TObject);
begin
    chb_grid_opt.Checked :=False;
end;

procedure TMainParamsForm.RadioButton5Click(Sender: TObject);
begin
  RadioButton3.Checked:=false;
  genkng.Checked:=false;
  RadioButton4.Checked:=false;
end;

procedure TMainParamsForm.genrznClick(Sender: TObject);
begin
  RadioButton3.Checked:=false;
  genkng.Checked:=false;
  RadioButton4.Checked:=false;
end;

procedure TMainParamsForm.CheckBox2Click(Sender: TObject);
begin
  RadioButton3.Checked:=false;
  genkng.Checked:=false;
  RadioButton4.Checked:=false;
end;

procedure TMainParamsForm.RadioButton4Click(Sender: TObject);
begin
  RadioButton3.Checked:=false;
  genkng.Checked:=false;
  RadioButton5.Checked:=false;
  CheckBox2.Checked:=false;
  genrzn.Checked:=false;
end;

procedure TMainParamsForm.RadioButton3Click(Sender: TObject);
begin
  RadioButton4.Checked:=false;
  RadioButton5.Checked:=false;
  CheckBox2.Checked:=false;
  genrzn.Checked:=false;
end;


procedure TMainParamsForm.genkngClick(Sender: TObject);
begin
  RadioButton4.Checked:=false;
  RadioButton5.Checked:=false;
  CheckBox2.Checked:=false;
  genrzn.Checked:=false;
end;
//test
//test2
End.
