{*********************************************************************}
  {                                                                     }
  {                    Московский Авиационный Институт                  }
  {                                                                     }
  {                               кафедра 609                           }
  {                                                                     }
  {                               изменения:                            }
  {                                                                     }
  {                       Имаметдинов Ренат Ильдарович                  }
  {                                                                     }
  {*********************************************************************}


unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, Spin;

type
  TA  = array [1..9] of Byte;
  pTA = ^TA;
  stress  = array [1..8] of Real;

  TSave_iterac = class
  private
  public
    Nomer_iteracii: Integer;
    Param_Znach: array[0..5] of string;
    Razrushenie: Boolean;
    MAX_stress: array[0..5] of stress;

    constructor Create;
    destructor Destroy; override;
    procedure MyREAD(pX: pTA; n: Byte);
    //читать n-байт из F(набор байтов, ообычно из .bin файла) в pX

    function Iter_results_save(VN_Nomer_Iteracii: Integer): Boolean;
               {
                ->:
                    - Входные параметры на итерации
                    - Файлы с результатами расчёта
                <-:
                    - Максимальное эквивалентное напряжение
                    - Факт разрушения
                    Возвращает:
                       1 - удачно прочитали
                       2 - в ф-ле .res есть ошибки
                }
  end;


  TStatistics_methods_Main = class(TForm)
    normal_law_distribution: TRadioButton;
    equal_law_distribution: TRadioButton;
    distribution: TGroupBox;
    random_number_generator: TGroupBox;
    standart_generator: TRadioButton;
    custom_generator: TRadioButton;
    custom_generator_browse: TButton;
    custom_generator_path: TLabel;
    converter_chose: TGroupBox;
    custom_converter_path: TLabel;
    standart_converter: TRadioButton;
    custom_converter: TRadioButton;
    custom_converter_browse: TButton;
    test_generator: TButton;
    test_converter: TButton;
    Main_param: TGroupBox;
    number_iteration: TEdit;
    number_iteration_Label3: TLabel;
    max_time: TEdit;
    max_time_Label4: TLabel;
    Run: TButton;
    GroupBox1: TGroupBox;
    change_value_1_check: TCheckBox;
    change_value_1_name: TComboBox;
    Label1: TLabel;
    change_value_1_aver_distr: TEdit;
    Label2: TLabel;
    change_value_1_max_diverg: TEdit;
    Label3: TLabel;
    change_value_2_max_diverg: TEdit;
    change_value_2_aver_distr: TEdit;
    change_value_2_name: TComboBox;
    change_value_2_check: TCheckBox;
    change_value_3_max_diverg: TEdit;
    change_value_3_aver_distr: TEdit;
    change_value_3_name: TComboBox;
    change_value_3_check: TCheckBox;
    change_value_4_max_diverg: TEdit;
    change_value_4_aver_distr: TEdit;
    change_value_4_name: TComboBox;
    change_value_4_check: TCheckBox;
    STOP: TButton;
    old_result_show: TButton;
    Dopust_napr_mater3: TEdit;
    Dopust_napr_mater2: TEdit;
    Dopust_napr_mater1: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Dopust_stress: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Normaln_nambers: TLabel;
    Label11: TLabel;
    Ravnomern_nambers: TLabel;

    procedure test_generatorClick(Sender: TObject);
    {проверка генератора случайных чисел}

    procedure RunClick(Sender: TObject);
    {Запускается при нажатии RUN}

    function UstanovkaParametra(Sender: TObject; var Param_Name: string;
      var Param_znach: string): string; // Имаметдинов
    {
    подпрограмма для:
    1) установки к.л. параметра
    2) получения к.л. параметра
    Param_Name - название параметра, возможные значения:
        -'NRC'
        -'RSUMX'
        -'RSUMY'
        -'ORT_7'
        -'PRM1'
        -'PRM2'
        -'PRM3'
        -'DR'
        -'ORT14'
        -'ORT21'
        -'ORT3'
        -'ORT10'
        -'ORT17'
    Param_znach:
        - значение параметра
        - 'Poluchenie' - для его получения
    }

    function Poluchenie_i_ustanovka_random(Sender: TObject;
      var Param_Name: string; var Nachalo_intervala: Real;
      var Konec_intervala: Real): string;// Имаметдинов
    {
    подпрограмма для:
        1) получения равномерного случайного числа
        2) при необходимости, его преобразования в нормальное
        3) приведение к интарвалу
        4) вызова п/п установки необходимого параметра
    }

    function default_znach_po_nazv(var Param_Name: string): string;
        {
        -> имя дефолтного параметра
        <- значение в текстовом формате
        }

    function poluchenie_ravnomern_sluch_chisla(): Real;
        {
        -> инф-ия из гуя
        <- равномерное случайное число от 0 до 1
        }

    function poluchenie_normaln_sluch_chisla(): Real;
        {
        -> инф-ия из гуя
        <- нормальное случайное число от 0 до 1
        }
    function nachln_ustanovka_izm_param(pr1: Integer; pr2: Integer;
      pr3: Integer; pr4: Integer): Real;
        {
        -> инф-ия из файла формы + какие пераметры меняем(в нужном 1)
        <- дефолтные значения в гуе
        }
    function postroenie_graf_res(): Real;
        {
        формирует графики в отображении результатов
        Устанавливает максимальные значения напряжений в окне результатов
        }


    function opredelenie_luchshego_reshenia(): Real;
        {
        ->рузультаты всех итерации (Save_iterac)
        <-в гуе решение в полях Statistics_methods_Run_Result.znach_param_*N*_opt
        }

    function vibor_luchshego(N_pretend: Integer; N_luchsh: Integer): Real;
       {
        -> из Save_iterac:
               N_pretend - номер итерации претендента на лучшую
               N_luchsh - текущая лучшая итерация
        <- vibor_luchshego:
               <= 0, претедент оказался хуже(таким же), N_luchsh не будет изменён
               > 0, претедент оказался лучше, N_luchsh изменён на N_pretend
        }

    function TXT_READ(TXT_NAME: string; TXT_Type: string): Boolean;
                 {
                ->:
                    - название TXT - файла
                    - Тип файла(src - c равномерными или snc - c нормальными)
                <-:
                    - Глобальные массивы RAVNOMERN_CHISLA[10000] или NORMALN_CHISLA[10000]
                    - result: Подходит ли TXT - файл:
                                               True - ДА
                                               False - Нет
                }
    procedure custom_generator_browseClick(Sender: TObject);
    procedure change_value_1_nameChange(Sender: TObject);
    procedure change_value_2_nameChange(Sender: TObject);
    procedure change_value_3_nameChange(Sender: TObject);
    procedure change_value_4_nameChange(Sender: TObject);
    procedure change_value_1_checkClick(Sender: TObject);
    procedure STOPClick(Sender: TObject);
    procedure custom_converterClick(Sender: TObject);
    procedure standart_converterClick(Sender: TObject);
    procedure custom_generatorClick(Sender: TObject);
    procedure standart_generatorClick(Sender: TObject);
    procedure equal_law_distributionClick(Sender: TObject);
    procedure normal_law_distributionClick(Sender: TObject);
    procedure test_converterClick(Sender: TObject);
    procedure custom_converter_browseClick(Sender: TObject);
    procedure old_result_showClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MAX_napr_mater: array[0..5] of Real;
    Ostanovka: Boolean;
    RAVNOMERN_CHISLA, NORMALN_CHISLA: array[0..10000] of Real;
    RAVNOMERN_nomer, NORMALN_nomer, RAVNOMERN_nomer_tek,
    NORMALN_nomer_tek: Integer;
  end;

var
  F: file of Byte;
  Statistics_methods_Main: TStatistics_methods_Main;
  Save_iterac: array[0..1000] of TSave_iterac;
  I_init: Integer;
  Default_NRC: Integer;
  Default_RSUMX, Default_RSUMY, Default__ORT_7, Default__PRM1,
  Default__PRM2, Default__PRM3,Default__DR, Default__ORT14: Real;
  Default__ORT21, Default__ORT3, Default__ORT10, Default__ORT17: Real;
  Luch_parametra: array[0..5] of Real;


implementation

uses test_generator_conf, Run_Result,{MainParam}Unit3, TSigmaForm,
  MainInterface, MainForm, TProject, BrowseFolder, strfunc,
  WaitForm;

{$R *.dfm}

  {Имаметдинов}
  { | }
  {\ /}

// -> ///////////////////////////////////////////////////// !!TStatistics_methods_Main!! /////////////////////////////////////
procedure TStatistics_methods_Main.test_generatorClick(Sender: TObject);
  begin
    //{вызов окна конфигурации тестирования генератора}
    Statistics_methods_test_genrator_conf.Caption :=
        'Настройка анализа равномерных чисел';
    Statistics_methods_test_genrator_conf.Chisl_type.Text :=
        'Равномерные случаные';
    Statistics_methods_test_genrator_conf.average.Text := '0,5';
    Statistics_methods_test_genrator_conf.Dispersia.Text := '0,2887';
    Statistics_methods_test_genrator_conf.Rasch_statistick.Text := '0,5774';
    Statistics_methods_test_genrator_conf.Rasch_Div.Text := '0,5';
    Statistics_methods_test_genrator_conf.Rasch_kv_Div.Text := '0,33';
    Statistics_methods_test_genrator_conf.Show;
  end;


procedure TStatistics_methods_Main.RunClick(Sender: TObject);
  const
    messeges: array[1..5] of
      string = ('Проверьте "Количество итераций" и "Максимальное время работы:", они должны быть целыми числами > 0.',
      'Проверьте Мат ожидания в Изменяемых величинах, они должны быть вещественными числами.',
      'Проверьте Макс. отклонения в Изменяемых величинах, они должны быть вещественными числами >= 0.',
      'Проверьте Допустимые напряжения в основных параметрах, они должны быть вещественными числами >= 0.',
      'Одна и та же величина в двух разных изменяемых параметрах.'
      );
  var
    Name, Znach: string;
    I, Kolichestvo_iteraciy, k_vo_razrushen, ii: Integer;
    Test_int, Error, Vremya_vipolnen: Integer;
    Test_Real, Nachalo_intervala, Konec_intervala: Real;
    Time_Nach, Time_Tek: TDateTime;
  label
    zaversh_rasch;
  begin

  Statistics_methods_Run_Result.Iter.Text:='1';

    ///// проверка всех введённых данных //////
    Error := 0;
    if (not CheckInt(number_iteration.Text, Test_int)) then
      Error := 1;
    number_iteration.Text := IntToStr(Test_int);
    if Test_int < 1 then
      Error := 1;
    if (not CheckInt(max_time.Text, Test_int)) then
      Error := 1;
    max_time.Text := IntToStr(Test_int);
    if Test_int < 1 then
      Error := 1;

    if (not CheckReal(change_value_1_aver_distr.Text, Test_Real)) then
      Error := 2;
    change_value_1_aver_distr.Text := FloatToStr(Test_Real);
    if (not CheckReal(change_value_2_aver_distr.Text, Test_Real)) then
      Error := 2;
    change_value_2_aver_distr.Text := FloatToStr(Test_Real);
    if (not CheckReal(change_value_3_aver_distr.Text, Test_Real)) then
      Error := 2;
    change_value_3_aver_distr.Text := FloatToStr(Test_Real);
    if (not CheckReal(change_value_4_aver_distr.Text, Test_Real)) then
      Error := 2;
    change_value_4_aver_distr.Text := FloatToStr(Test_Real);

    if (not CheckReal(change_value_1_max_diverg.Text, Test_Real)) then
      Error := 3;
    change_value_1_max_diverg.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 3;
    if (not CheckReal(change_value_2_max_diverg.Text, Test_Real)) then
      Error := 3;
    change_value_2_max_diverg.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 3;
    if (not CheckReal(change_value_3_max_diverg.Text, Test_Real)) then
      Error := 3;
    change_value_3_max_diverg.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 3;
    if (not CheckReal(change_value_4_max_diverg.Text, Test_Real)) then
      Error := 3;
    change_value_4_max_diverg.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 3;

    if (not CheckReal(Dopust_napr_mater1.Text, Test_Real)) then
      Error := 4;
    Dopust_napr_mater1.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 4;
    if (not CheckReal(Dopust_napr_mater2.Text, Test_Real)) then
      Error := 4;
    Dopust_napr_mater2.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 4;
    if (not CheckReal(Dopust_napr_mater3.Text, Test_Real)) then
      Error := 4;
    Dopust_napr_mater3.Text := FloatToStr(Test_Real);
    if Test_Real < 0 then
      Error := 4;


    if   ((change_value_1_name.Enabled and change_value_2_name.Enabled and
                     (change_value_1_name.Text = change_value_2_name.Text)) or
         (change_value_1_name.Enabled and change_value_3_name.Enabled and
                     (change_value_1_name.Text = change_value_3_name.Text)) or
         (change_value_1_name.Enabled and change_value_4_name.Enabled and
                     (change_value_1_name.Text = change_value_4_name.Text)) or
         (change_value_2_name.Enabled and change_value_3_name.Enabled and
                     (change_value_2_name.Text = change_value_3_name.Text)) or
         (change_value_2_name.Enabled and change_value_4_name.Enabled and
                     (change_value_2_name.Text = change_value_4_name.Text)) or
         (change_value_3_name.Enabled and change_value_4_name.Enabled and
                     (change_value_3_name.Text = change_value_4_name.Text)))
       then  Error := 5;


    if Error <> 0 then
      begin
        ShowMessage('Ошибка: ' + messeges[Error]);
        Exit;
      end;
    ///// проверка всех введённых данных //////

    /// Запись текущих значений допустимых напряжений.
    // для Материала 1.
    Name := 'ORT3';
    Znach := Dopust_napr_mater1.Text;
    Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
        Name, Znach);
    // для Материала 1.
    // для Материала 2.
    Name := 'ORT10';
    Znach := Dopust_napr_mater2.Text;
    Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
        Name, Znach);
    // для Материала 2.
    // для Материала 3.
    Name := 'ORT17';
    Znach := Dopust_napr_mater3.Text;
    Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
        Name, Znach);
    // для Материала 3.
    /// Запись текущих значений допустимых напряжений.


    if change_value_1_check.Checked or change_value_2_check.Checked or
        change_value_3_check.Checked or change_value_4_check.Checked then
      begin
        Kolichestvo_iteraciy := StrToInt(number_iteration.Text);
        // к-во итераций
        Vremya_vipolnen := StrToInt(max_time.Text);    // макс время работы

        //{->Запомнить время начала работы
        Time_Nach := Time;
        //{<-Запомнить время начала работы


        //Включить кнопку "STOP" Метода     //
        Statistics_methods_Main.Ostanovka    := false;
        Statistics_methods_Main.STOP.Visible := true;

        //на всякий случай выключить все кнопки из главного окна
        Statistics_methods_Main.Run.Enabled := false;
        Statistics_methods_Main.test_converter.Enabled := false;
        Statistics_methods_Main.custom_converter_browse.Enabled := false;
        Statistics_methods_Main.test_generator.Enabled := false;
        Statistics_methods_Main.custom_generator_browse.Enabled := false;
        //на всякий случай выключить все кнопки из главного окна

        //{->Основная работа по преобразованию чисел и запуска расчёта с ними
        for  I := 1 to Kolichestvo_iteraciy do
          begin
            //{->передаём название 1-ой переменной и диапазон, в котором она изменяется
            //NAME := 'RSUMX';
            Name := change_value_1_name.Text;

            if change_value_1_check.Checked then
              begin
                //Nachalo_intervala:= 1;
                Nachalo_intervala := StrToFloat(change_value_1_aver_distr.Text) -
                    StrToFloat(change_value_1_max_diverg.Text);

                //Konec_intervala :=10;
                Konec_intervala := StrToFloat(change_value_1_aver_distr.Text)
                    + StrToFloat(change_value_1_max_diverg.Text);
              end
            else
              begin
              // если параметр не меняется, то ставим в него что-нибудь постоянное...
                Name := 'ORT17';

                Nachalo_intervala := StrToFloat(Dopust_napr_mater3.Text);
                Konec_intervala := Nachalo_intervala;
              end;
            Statistics_methods_Run_Result.Param_1.Caption:= Name;
            Save_iterac[I].Param_Znach[1] :=
                Statistics_methods_Main.Poluchenie_i_ustanovka_random(Statistics_methods_Main,
                Name, Nachalo_intervala, Konec_intervala);
            //{<-передаём название 1-ой переменной и диапозон, в котором она изменяется

            //{->передаём название 2-ой переменной и диапозон, в котором она изменяется
            //NAME := 'RSUMX';
            Name := change_value_2_name.Text;

            if change_value_2_check.Checked then
              begin
                //Nachalo_intervala:= 1;
                Nachalo_intervala := StrToFloat(change_value_2_aver_distr.Text) -
                    StrToFloat(change_value_2_max_diverg.Text);

                //Konec_intervala :=10;
                Konec_intervala := StrToFloat(change_value_2_aver_distr.Text)
                    + StrToFloat(change_value_2_max_diverg.Text);
              end
            else
              begin
              // если параметр не меняется, то ставим в него что-нибудь постоянное...
                Name := 'ORT17';

                Nachalo_intervala := StrToFloat(Dopust_napr_mater3.Text);
                Konec_intervala := Nachalo_intervala;
              end;
            Statistics_methods_Run_Result.Param_2.Caption:= Name;
            Save_iterac[I].Param_Znach[2] :=
                Statistics_methods_Main.Poluchenie_i_ustanovka_random(Statistics_methods_Main,
                Name, Nachalo_intervala, Konec_intervala);
            //{<-передаём название 1-ой переменной и диапозон, в котором она изменяется


            //{->передаём название 3-ой переменной и диапозон, в котором она изменяется
            //NAME := 'RSUMX';
            Name := change_value_3_name.Text;

            if change_value_3_check.Checked then
              begin
                //Nachalo_intervala:= 1;
                Nachalo_intervala := StrToFloat(change_value_3_aver_distr.Text) -
                    StrToFloat(change_value_3_max_diverg.Text);

                //Konec_intervala :=10;
                Konec_intervala := StrToFloat(change_value_3_aver_distr.Text)
                    + StrToFloat(change_value_3_max_diverg.Text);
              end
            else
              begin
                // если параметр не меняется, то ставим в него что-нибудь постоянное...
                Name := 'ORT17';
                Nachalo_intervala := StrToFloat(Dopust_napr_mater3.Text);
                Konec_intervala := Nachalo_intervala;
              end;

            Statistics_methods_Run_Result.Param_3.Caption:= Name;
            Save_iterac[I].Param_Znach[3] :=
                Statistics_methods_Main.Poluchenie_i_ustanovka_random(Statistics_methods_Main,
                Name, Nachalo_intervala, Konec_intervala);
            //{<-передаём название 3-ой переменной и диапозон, в котором она изменяется

            //{->передаём название 4-ой переменной и диапозон, в котором она изменяется
            //NAME := 'RSUMX';
            Name := change_value_4_name.Text;

            if change_value_4_check.Checked then
              begin
                //Nachalo_intervala:= 1;
                Nachalo_intervala := StrToFloat(change_value_4_aver_distr.Text) -
                    StrToFloat(change_value_4_max_diverg.Text);

                //Konec_intervala :=10;
                Konec_intervala := StrToFloat(change_value_4_aver_distr.Text)
                    + StrToFloat(change_value_4_max_diverg.Text);
              end
            else
              begin
              // если параметр не меняется, то ставим в него что-нибудь постоянное...
                Name := 'ORT17';
                Nachalo_intervala := StrToFloat(Dopust_napr_mater3.Text);
                Konec_intervala := Nachalo_intervala;
              end;

            Statistics_methods_Run_Result.Param_4.Caption:= Name;
            Save_iterac[I].Param_Znach[4] :=
                Statistics_methods_Main.Poluchenie_i_ustanovka_random(Statistics_methods_Main,
                Name, Nachalo_intervala, Konec_intervala);
            //{<-передаём название 1-ой переменной и диапозон, в котором она изменяется

            //{->Расчёт с установленными параметрами
            MainForm1.RunClick(Form3);
            WaitForm1.StartShow('Работает метод Статистических испытаний');
            repeat
                Application.ProcessMessages;
            until WaitForm1.FileExecuted = false;
            //{<-Расчёт с установленными параметрами


            //{Вызов функции записи нужной информации/результатов расчёта на текущем шаге//
            if (not (Save_iterac[I].Iter_results_save(I))) then
              begin
                ShowMessage('на шаге= ' + IntToStr(I) + 'ошибка в .res - файле');
                goto zaversh_rasch;
              end;


            //{Проверка времени работы и выход из цикла, если больше чем указано в ГУЕ
            Time_Tek := Time;
            if ((Time_Tek - Time_Nach) * 100000) > Vremya_vipolnen then
              begin
                ShowMessage('Время  = ' + IntToStr(Vremya_vipolnen) +
                    ' секунд истекло');

                //записываем итоговое время выполнения
                Statistics_methods_Run_Result.Time.Text :=
                    TimeToStr((Time_Tek - Time_Nach));

                //записываем итоговое колличество итераций
                Statistics_methods_Run_Result.Iter.Text := IntToStr(I);

                goto zaversh_rasch;
              end;
            //{Проверка времени работы и выход из цикла, если больше чем указано в ГУЕ

            //{Проверка кнопки "STOP" Метода //
            if Statistics_methods_Main.Ostanovka then
              begin
                ShowMessage('прервано пользователем');
                //записываем итоговое время выполнения
                Statistics_methods_Run_Result.Time.Text :=
                    TimeToStr((Time_Tek - Time_Nach));
                //записываем итоговое колличество итераций
                Statistics_methods_Run_Result.Iter.Text := IntToStr(I);
                goto zaversh_rasch;
                //{Проверка кнопки "STOP" Метода //
              end;
          end;

        //{<-Основная работа по преобразованию чисел и запуска расчёта с ними
        ShowMessage('Выполнены все  = ' + IntToStr(Kolichestvo_iteraciy) + ' итераций');
        Time_Tek := Time;
        //записываем итоговое время выполнения
        Statistics_methods_Run_Result.Time.Text := TimeToStr((Time_Tek - Time_Nach));
        //записываем итоговое колличество итераций
        Statistics_methods_Run_Result.Iter.Text := IntToStr(Kolichestvo_iteraciy);

        zaversh_rasch:

        Statistics_methods_Main.STOP.Visible := false;

        //включить все кнопки из главного окна
        Statistics_methods_Main.Run.Enabled := true;
        Statistics_methods_Main.test_converter.Enabled := true;
        Statistics_methods_Main.custom_converter_browse.Enabled := true;
        Statistics_methods_Main.test_generator.Enabled := true;
        Statistics_methods_Main.custom_generator_browse.Enabled := true;
        //включить все кнопки из главного окна


        //{->возвращаем Дэфолтные значения изменяемых параметров
        // для 1-го параметра
        //NAME:='RSUMX';
        Name  := Statistics_methods_Run_Result.Param_1.Caption; // берём из гуя название переменной
        Znach := default_znach_po_nazv(Name);
        Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        // для 1-го параметра

        //{->возвращаем Дэфолтные значения изменяемых параметров
        // для 2-го параметра
        //NAME:='RSUMX';
        Name  := Statistics_methods_Run_Result.Param_2.Caption;   // берём из гуя название переменной
        Znach := default_znach_po_nazv(Name);
        Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        // для 2-го параметра

        //{->возвращаем Дэфолтные значения изменяемых параметров
        // для 3-го параметра
        //NAME:='RSUMX';
        Name  := Statistics_methods_Run_Result.Param_3.Caption;   // берём из гуя название переменной
        Znach := default_znach_po_nazv(Name);
        Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        // для 3-го параметра

        //{->возвращаем Дэфолтные значения изменяемых параметров
        // для 4-го параметра
        //NAME:='RSUMX';
        Name  := Statistics_methods_Run_Result.Param_4.Caption;     // берём из гуя название переменной
        Znach := default_znach_po_nazv(Name);
        Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        // для 4-го параметра
        //{<-возвращаем Дэфолтные значения изменяемых параметров

        /// возвращаем Дэфолтные значения допустимых напряжений.
        // для Материала 1.
        Name := 'ORT3';
        Znach := default_znach_po_nazv(Name);
        Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
           Name, Znach);
        // для Материала 1.
        // для Материла 2.
        Name := 'ORT10';
        Znach := default_znach_po_nazv(Name);
        Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        // для Материала 2.
        // для Материала 3.
        Name := 'ORT17';
        Znach := default_znach_po_nazv(Name);
        Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        // для Материала 3.
        /// возвращаем Дэфолтные значения допустимых напряжений.

        //{->Расчёт с  Дэфолтными параметрами
        MainForm1.RunClick({MainParamsForm}Form3);
        WaitForm1.StartShow('Метод Статист. Испыт. возвращает исходные данные');
        repeat
            Application.ProcessMessages;
        until WaitForm1.FileExecuted = false;
        //{<-Расчёт с  Дэфолтными параметрами


        //{->расчёт вероятности разрушения.
        //посчитать к-во разрушений
        k_vo_razrushen := 0;
        I := StrToInt(Statistics_methods_Run_Result.Iter.Text);
        for  ii := 1 to I do
          begin
            if (Save_iterac[ii].Razrushenie = true) then
              k_vo_razrushen := k_vo_razrushen + 1;
          end;
        //посчитать к-во разрушений

        Statistics_methods_Run_Result.Ver_Dist.Text :=
            FloatToStr((k_vo_razrushen / I) * 100);
        //{<-расчёт вероятности разрушения.


        Statistics_methods_Run_Result.Dopust_napr_mater1.Text :=
            FloatToStr(Statistics_methods_Main.MAX_napr_mater[1]);
        Statistics_methods_Run_Result.Dopust_napr_mater2.Text :=
            FloatToStr(Statistics_methods_Main.MAX_napr_mater[2]);
        Statistics_methods_Run_Result.Dopust_napr_mater3.Text :=
            FloatToStr(Statistics_methods_Main.MAX_napr_mater[3]);

        // выбираем граффик для первого выбранного параметра
        if change_value_1_check.Checked then
          Statistics_methods_Run_Result.Param_1.Checked := true
        else if change_value_2_check.Checked then
          Statistics_methods_Run_Result.Param_2.Checked := true
        else if change_value_3_check.Checked then
          Statistics_methods_Run_Result.Param_3.Checked := true
        else if change_value_4_check.Checked then
          Statistics_methods_Run_Result.Param_4.Checked := true;

        postroenie_graf_res;    // создаём граффик результатов расчёта

        opredelenie_luchshego_reshenia; // находим лучшее решение

        old_result_show.Visible := true;
        //{вызов окна результатов расчёта
        Statistics_methods_Run_Result.Show;
      end
    else
      begin
        ShowMessage('Выберете хотя бы один параметр');
        Exit;
      end;
  end;


// -> ///////////////////////////////////////////////////// Начало ф-ии nachln_ustanovka_izm_param /////////////////////////////////////
function TStatistics_methods_Main.nachln_ustanovka_izm_param(pr1: Integer;
  pr2: Integer; pr3: Integer; pr4: Integer): Real;
        {
        -> инф-ия из файла формы
        <- дефолтные значения в гуе
        }
  var
    Name, Znach, itog: string;
  begin
    Result := 0;

    //{->получаем нужные дефолтные значения изменяемых параметров и устанавливаем их


    // для Допускаемых напряжений
    if (pr1 = 1) and (pr2 = 1) and (pr3 = 1)and (pr4 = 1) then
      begin
      //материал 1.
        Name := 'ORT3';
        Znach := 'Poluchenie';
        itog  := Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        Statistics_methods_Main.Dopust_napr_mater1.Text := itog;
      //материал 1.

      //материал 2.
        Name := 'ORT10';
        Znach := 'Poluchenie';
        itog  := Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        Statistics_methods_Main.Dopust_napr_mater2.Text := itog;
      //материал 2.

      //материал 3.
        Name := 'ORT17';
        Znach := 'Poluchenie';
        itog  := Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        Statistics_methods_Main.Dopust_napr_mater3.Text := itog;
      //материал 3.

      end;
    // для Допускаемых напряжений

    // для 1-го параметра
    if pr1 = 1 then
      begin
        Name := Statistics_methods_Main.change_value_1_name.Text;
        // берём из гуя название переменной
        Znach := 'Poluchenie';
        itog  := Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        Statistics_methods_Main.change_value_1_aver_distr.Text := itog;
        Statistics_methods_Run_Result.znach_param_1.Text := itog;
        Statistics_methods_Main.change_value_1_max_diverg.Text :=
            FloatToStr(Int(Abs(StrToFloat(itog) / 10)));
      end;
    // для 1-го параметра

    // для 2-го параметра
    if pr2 = 1 then
      begin
        Name := Statistics_methods_Main.change_value_2_name.Text;
        // берём из гуя название переменной
        Znach := 'Poluchenie';
        itog  := Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        Statistics_methods_Main.change_value_2_aver_distr.Text := itog;
        Statistics_methods_Run_Result.znach_param_2.Text := itog;
        Statistics_methods_Main.change_value_2_max_diverg.Text :=
            FloatToStr(Int(Abs(StrToFloat(itog) / 10)));
      end;
    // для 2-го параметра

    // для 3-го параметра
    if pr3 = 1 then
      begin
        Name := Statistics_methods_Main.change_value_3_name.Text;
        // берём из гуя название переменной
        Znach := 'Poluchenie';
        itog  := Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        Statistics_methods_Main.change_value_3_aver_distr.Text := itog;
        Statistics_methods_Run_Result.znach_param_3.Text := itog;
        Statistics_methods_Main.change_value_3_max_diverg.Text :=
            FloatToStr(Int(Abs(StrToFloat(itog) / 10)));
      end;
    // для 1-го параметра

    // для 4-го параметра
    if pr4 = 1 then
      begin
        Name := Statistics_methods_Main.change_value_4_name.Text;
        // берём из гуя название переменной
        Znach := 'Poluchenie';
        itog  := Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
            Name, Znach);
        Statistics_methods_Main.change_value_4_aver_distr.Text := itog;
        Statistics_methods_Run_Result.znach_param_4.Text := itog;
        Statistics_methods_Main.change_value_4_max_diverg.Text :=
            FloatToStr(Int(Abs(StrToFloat(itog) / 10)));
      end;
    // для 4-го параметра
    Result := 1;
  end;
// -> ///////////////////////////////////////////////////// Конец ф-ии nachln_ustanovka_izm_param /////////////////////////////////////





// -> ///////////////////////////////////////////////////// Начало ф-ии postroenie_graf_res /////////////////////////////////////
function TStatistics_methods_Main.postroenie_graf_res(): Real;
        {
        формирует графики в отображении результатов
        Устанавливает максимальные значения напряжений в окне результатов
        }
  var
    I, ii,jj: Integer;
    ID_stress,ID_param, ID_mater: Integer;
    Nachalo_intervala, Konec_intervala, X_zn, Y_zn, max_Y_zn, min_Y_zn: Real;
    dopusk_max_napr: Real;
    max_all_stress: array[1..7] of real;
  label
    zaversh_rasch;
  begin
    Result := 0;
    /// Убираем прошлые ряды
    Statistics_methods_Run_Result.Series1.Clear;
    Statistics_methods_Run_Result.Series2.Clear;
    Statistics_methods_Run_Result.Series3.Clear;
    Statistics_methods_Run_Result.Series4.Clear;

    /// Получение основных параметров граффика:
    //ID_stress       //  берётся из Statistics_methods_Run_Result.gr
    ID_stress := 0;
    if Statistics_methods_Run_Result.Stress_1.Checked then
      ID_stress := 1;
    if Statistics_methods_Run_Result.Stress_2.Checked then
      ID_stress := 2;
    if Statistics_methods_Run_Result.Stress_3.Checked then
      ID_stress := 3;
    if Statistics_methods_Run_Result.Stress_4.Checked then
      ID_stress := 4;
    if Statistics_methods_Run_Result.Stress_5.Checked then
      ID_stress := 5;
    if Statistics_methods_Run_Result.Stress_6.Checked then
      ID_stress := 6;
    if Statistics_methods_Run_Result.Stress_7.Checked then
      ID_stress := 7; 
    if ID_stress = 0 then
      ID_stress := 1;


    //ID_mater       //  берётся из Statistics_methods_Run_Result.gr
    ID_mater := 0;
    if Statistics_methods_Run_Result.Mater_1.Checked then
      ID_mater := 1;
    if Statistics_methods_Run_Result.Mater_2.Checked then
      ID_mater := 2;
    if Statistics_methods_Run_Result.Mater_3.Checked then
      ID_mater := 3;
    if ID_mater = 0 then
      ID_mater := 1;

    //ID_param       //  берётся из Statistics_methods_Run_Result.gr
    ID_Param := 0;
    if Statistics_methods_Run_Result.Param_1.Checked then
      ID_Param := 1;
    if Statistics_methods_Run_Result.Param_2.Checked then
      ID_Param := 2;
    if Statistics_methods_Run_Result.Param_3.Checked then
      ID_Param := 3;
    if Statistics_methods_Run_Result.Param_4.Checked then
      ID_Param := 4;
    if ID_Param = 0 then
      ID_Param := 1;

    //dopusk_max_napr
    dopusk_max_napr := Statistics_methods_Main.MAX_napr_mater[ID_mater];

    //MAX_znach_param
    Nachalo_intervala := 0;
    Konec_intervala := 0;
    if ID_param = 1 then
      begin
        Nachalo_intervala := StrToFloat(change_value_1_aver_distr.Text) +
            StrToFloat(change_value_1_max_diverg.Text);
        //MIN_znach_param
        Konec_intervala := StrToFloat(change_value_1_aver_distr.Text)
            - StrToFloat(change_value_1_max_diverg.Text);
      end;
    if ID_param = 2 then
      begin
        Nachalo_intervala := StrToFloat(change_value_2_aver_distr.Text) +
            StrToFloat(change_value_2_max_diverg.Text);
        //MIN_znach_param
        Konec_intervala := StrToFloat(change_value_2_aver_distr.Text)
            - StrToFloat(change_value_2_max_diverg.Text);
      end;
    if ID_param = 3 then
      begin
        Nachalo_intervala := StrToFloat(change_value_3_aver_distr.Text) +
            StrToFloat(change_value_3_max_diverg.Text);
        //MIN_znach_param
        Konec_intervala := StrToFloat(change_value_3_aver_distr.Text)
            - StrToFloat(change_value_3_max_diverg.Text);
      end;
    if ID_param = 4 then
      begin
        Nachalo_intervala := StrToFloat(change_value_4_aver_distr.Text) +
            StrToFloat(change_value_4_max_diverg.Text);
        //Konec_intervala
        Konec_intervala := StrToFloat(change_value_4_aver_distr.Text)
            - StrToFloat(change_value_4_max_diverg.Text);
      end;


    /// Вывод результатов в граффик:
    // выводим границу разрушения
    Statistics_methods_Run_Result.Series2.AddXY(Nachalo_intervala,
        dopusk_max_napr);
    Statistics_methods_Run_Result.Series2.AddXY(Konec_intervala,
        dopusk_max_napr);


    //получаем к-во итераций
    I := StrToInt(Statistics_methods_Run_Result.Iter.Text);

    // выводим пару -  "значение_параметра : максим_эквив_напряж"
    max_Y_zn := 0;
    min_Y_zn := 100000000;
    for  ii := 1 to I do
      begin
        X_zn := StrToFloat(Save_iterac[ii].Param_Znach[ID_param]);
        //Y_zn := Save_iterac[ii].MAX_ekviv_stress[ID_mater];
        Y_zn := abs(Save_iterac[ii].MAX_stress[ID_mater][ID_stress]);  //Строим абсолютное значение напряжений
        Statistics_methods_Run_Result.Series1.AddXY(X_zn, Y_zn);
        if Y_zn > max_Y_zn then
          max_Y_zn := Y_zn;
        if Y_zn < min_Y_zn then
          min_Y_zn := Y_zn;
      end;

    if dopusk_max_napr > max_Y_zn then
      max_Y_zn := dopusk_max_napr;
    if dopusk_max_napr < min_Y_zn then
      min_Y_zn := dopusk_max_napr;
    Statistics_methods_Run_Result.Series3.AddXY(Konec_intervala,
        max_Y_zn + 0.1 * max_Y_zn);
    Statistics_methods_Run_Result.Series4.AddXY(Konec_intervala,
        min_Y_zn - 0.1 * max_Y_zn);

        //////Определение максимального значения напряжений
        // идём по всем итерациям
        for  ii := 1 to I do
          begin
        //идём по всем напряжениям
            for  jj := 1 to 7 do
            begin
             If abs(Save_iterac[ii].MAX_stress[ID_mater][jj]) > abs(max_all_stress[jj]) then
                                      max_all_stress[jj] := Save_iterac[ii].MAX_stress[ID_mater][jj];
            end;
        //идём по всем напряжениям
          end;
        // идём по всем итерациям
        //устанавливаем напряжения
        Statistics_methods_Run_Result.MAX_stress_X.Text
                                      := FloatToStr(abs(max_all_stress[1]));
        Statistics_methods_Run_Result.MAX_stress_Y.Text
                                      := FloatToStr(abs(max_all_stress[2]));
        Statistics_methods_Run_Result.MAX_stress_Kasat.Text
                                      := FloatToStr(abs(max_all_stress[3]));
        Statistics_methods_Run_Result.MAX_stress_1_glavn.Text
                                      := FloatToStr(abs(max_all_stress[4]));
        Statistics_methods_Run_Result.MAX_stress_2_glavn.Text
                                      := FloatToStr(abs(max_all_stress[5]));
        Statistics_methods_Run_Result.MAX_stress_ekviv.Text
                                      := FloatToStr(abs(max_all_stress[6]));
        Statistics_methods_Run_Result.MAX_stress_ugol.Text
                                      := FloatToStr(abs(max_all_stress[7]));
        //устанавливаем напряжения
        // меняем цвет ячейки, если значение > допустимого для материала
         if abs(max_all_stress[1]) > MAX_napr_mater[ID_mater] then
             Statistics_methods_Run_Result.MAX_stress_X.Color := clRed
        else Statistics_methods_Run_Result.MAX_stress_X.Color := clWhite;

        if abs(max_all_stress[2]) > MAX_napr_mater[ID_mater] then
             Statistics_methods_Run_Result.MAX_stress_Y.Color := clRed
        else Statistics_methods_Run_Result.MAX_stress_Y.Color := clWhite;

        if abs(max_all_stress[3]) > MAX_napr_mater[ID_mater] then
             Statistics_methods_Run_Result.MAX_stress_Kasat.Color := clRed
        else Statistics_methods_Run_Result.MAX_stress_Kasat.Color := clWhite;

        if abs(max_all_stress[4]) > MAX_napr_mater[ID_mater] then
             Statistics_methods_Run_Result.MAX_stress_1_glavn.Color := clRed
        else Statistics_methods_Run_Result.MAX_stress_1_glavn.Color := clWhite;

        if abs(max_all_stress[5]) > MAX_napr_mater[ID_mater] then
             Statistics_methods_Run_Result.MAX_stress_2_glavn.Color := clRed
        else Statistics_methods_Run_Result.MAX_stress_2_glavn.Color := clWhite;

        if abs(max_all_stress[6]) > MAX_napr_mater[ID_mater] then
             Statistics_methods_Run_Result.MAX_stress_ekviv.Color := clRed
        else Statistics_methods_Run_Result.MAX_stress_ekviv.Color := clWhite;

        if abs(max_all_stress[7]) > MAX_napr_mater[ID_mater] then
             Statistics_methods_Run_Result.MAX_stress_ugol.Color := clRed
        else Statistics_methods_Run_Result.MAX_stress_ugol.Color := clWhite;
        // меняем цвет ячейки, если значение > допустимого для материала
        //////Определение максимального значения напряжений


    Result := 1;
  end;
// -> ///////////////////////////////////////////////////// Конец ф-ии postroenie_graf_res /////////////////////////////////////



// -> ///////////////////////////////////////////////////// Начало п/п opredelenie_luchshego_reshenia /////////////////////////////////////
function TStatistics_methods_Main.opredelenie_luchshego_reshenia(): Real;
        {
        ->рузультаты всех итерации (Save_iterac)
        <-в гуе решение в полях Statistics_methods_Run_Result.znach_param_*N*_opt
        }
  var
    I, Kolichestvo_iteraciy, N_luchsh: Integer;
    tmp_znach, koef_urovn: Real;
  begin
    Result := 0;

    Kolichestvo_iteraciy := StrToInt(Statistics_methods_Run_Result.Iter.Text);
    N_luchsh := 0;
    // делаем самой лучшей любую итерацию без разрушения
    for  I := 1 to Kolichestvo_iteraciy do
      begin
        if not (Save_iterac[i].Razrushenie) then
          N_luchsh := I;
      end;

    // проверка найденного решения
    if N_luchsh = 0 then
      begin
        //ShowMessage('определение оптимального решения невозможно: пластина разрушается на всех итерациях');
        Exit;
      end;

    // устанавливаем в лучшее значение параметра из любой итерации без разрушения
    for  I := 1 to 4 do
      begin
        Luch_parametra[I] := StrToFloat(Save_iterac[N_luchsh].Param_Znach[I]);
      end;

    // проходим по всем итерациям и ищем более хорошее решение.
    for  I := 1 to Kolichestvo_iteraciy do
      begin
        if (not (Save_iterac[i].Razrushenie)) and (vibor_luchshego(I, N_luchsh) > 0) then
          N_luchsh := I;
      end;


    ////////////////// установка лучшего решения в нужные поля///////////////////
    //для 1-го поля: если изменяется, то из Save_iterac, иначе из условия
    Statistics_methods_Run_Result.znach_param_1_opt.Text :=
        Save_iterac[N_luchsh].Param_Znach[1];

    //для 2-го поля: если изменяется, то из Save_iterac, иначе из условия
    Statistics_methods_Run_Result.znach_param_2_opt.Text :=
        Save_iterac[N_luchsh].Param_Znach[2];

    //для 3-го поля: если изменяется, то из Save_iterac, иначе из условия
    Statistics_methods_Run_Result.znach_param_3_opt.Text :=
        Save_iterac[N_luchsh].Param_Znach[3];

    //для 4-го поля: если изменяется, то из Save_iterac, иначе из условия
    Statistics_methods_Run_Result.znach_param_4_opt.Text :=
        Save_iterac[N_luchsh].Param_Znach[4];
    ////////////////// установка лучшего решения в нужные поля///////////////////


    ////////////////// определение погрешности и установка в нужные поля /////////////
    //для 1-го поля: вычисляем процентную разницу от лучшего значения
    tmp_znach := StrToFloat(Save_iterac[N_luchsh].Param_Znach[1]);
    if Statistics_methods_Run_Result.criter_param_1.Text = ' =' then
      Luch_parametra[1] := tmp_znach;
    koef_urovn := Max(Abs(tmp_znach), Abs(Luch_parametra[1]));
    if koef_urovn = 0 then
      koef_urovn := 1;
    Statistics_methods_Run_Result.param_1_pogr.Text :=
        FloatToStr(100 * Abs(tmp_znach - Luch_parametra[1]) / (koef_urovn));

    //для 2-го поля: вычисляем процентную разницу от лучшего значения
    tmp_znach := StrToFloat(Save_iterac[N_luchsh].Param_Znach[2]);
    koef_urovn := Max(Abs(tmp_znach), Abs(Luch_parametra[2]));
    if koef_urovn = 0 then
      koef_urovn := 1;
    if Statistics_methods_Run_Result.criter_param_2.Text = ' =' then
      Luch_parametra[2] := tmp_znach;
    Statistics_methods_Run_Result.param_2_pogr.Text :=
        FloatToStr(100 * Abs(tmp_znach - Luch_parametra[2]) / (koef_urovn));

    //для 3-го поля: вычисляем процентную разницу от лучшего значения
    tmp_znach := StrToFloat(Save_iterac[N_luchsh].Param_Znach[3]);
    koef_urovn := Max(Abs(tmp_znach), Abs(Luch_parametra[3]));
    if koef_urovn = 0 then
      koef_urovn := 1;
    if Statistics_methods_Run_Result.criter_param_3.Text = ' =' then
      Luch_parametra[3] := tmp_znach;
    Statistics_methods_Run_Result.param_3_pogr.Text :=
        FloatToStr(100 * Abs(tmp_znach - Luch_parametra[3]) / (koef_urovn));

    //для 4-го поля: вычисляем процентную разницу от лучшего значения
    tmp_znach := StrToFloat(Save_iterac[N_luchsh].Param_Znach[4]);
    koef_urovn := Max(Abs(tmp_znach), Abs(Luch_parametra[4]));
    if koef_urovn = 0 then
      koef_urovn := 1;
    if Statistics_methods_Run_Result.criter_param_4.Text = ' =' then
      Luch_parametra[4] := tmp_znach;
    Statistics_methods_Run_Result.param_4_pogr.Text :=
        FloatToStr(100 * Abs(tmp_znach - Luch_parametra[4]) / (koef_urovn));
    ////////////////// определение погрешности и установка в нужные поля /////////////
    Result := 1;
  end;
// -> ///////////////////////////////////////////////////// Конец ф-ии opredelenie_luchshego_reshenia /////////////////////////////////////

// -> ///////////////////////////////////////////////////// Начало ф-ии vibor_luchshego /////////////////////////////////////
function TStatistics_methods_Main.vibor_luchshego(N_pretend: Integer;
  N_luchsh: Integer): Real;
       {
        -> из Save_iterac:
               N_pretend - номер итерации претендента на лучшую
               N_luchsh - текущая лучшая итерация
        <- vibor_luchshego:
               <= 0, претедент оказался хуже(таким же), N_luchsh не будет изменён
               > 0, претедент оказался лучше, N_luchsh изменён на N_pretend
        }
  var
    I: Integer;
    criterii, ves: array[0..5] of Real;
    Znachenie_resultata_criteria, urovn_koef: Real;
  begin
    //// учитываем критерий выбора для каждого параметра
    //для 1-го параметра
    if Statistics_methods_Run_Result.criter_param_1.Text = 'max' then
      criterii[1] := 1
    else if Statistics_methods_Run_Result.criter_param_1.Text = 'min' then
      criterii[1] := -1
    else if Statistics_methods_Run_Result.criter_param_1.Text = ' =' then
      criterii[1] := 0;

    //для 2-го параметра
    if Statistics_methods_Run_Result.criter_param_2.Text = 'max' then
      criterii[2] := 1
    else if Statistics_methods_Run_Result.criter_param_2.Text = 'min' then
      criterii[2] := -1
    else if Statistics_methods_Run_Result.criter_param_2.Text = ' =' then
      criterii[2] := 0;

    //для 3-го параметра
    if Statistics_methods_Run_Result.criter_param_3.Text = 'max' then
      criterii[3] := 1
    else if Statistics_methods_Run_Result.criter_param_3.Text = 'min' then
      criterii[3] := -1
    else if Statistics_methods_Run_Result.criter_param_3.Text = ' =' then
      criterii[3] := 0;

    //для 4-го параметра
    if Statistics_methods_Run_Result.criter_param_4.Text = 'max' then
      criterii[4] := 1
    else if Statistics_methods_Run_Result.criter_param_4.Text = 'min' then
      criterii[4] := -1
    else if Statistics_methods_Run_Result.criter_param_4.Text = ' =' then
      criterii[4] := 0;
    //// учитываем критерий выбора для каждого параметра

    //// получеам вес каждого параметра
    //для 1-го параметра
    ves[1] := StrToFloat(Statistics_methods_Run_Result.Ves_param_1.Text);

    //для 2-го параметра
    ves[2] := StrToFloat(Statistics_methods_Run_Result.Ves_param_2.Text);

    //для 3-го параметра
    ves[3] := StrToFloat(Statistics_methods_Run_Result.Ves_param_3.Text);

    //для 4-го параметра
    ves[4] := StrToFloat(Statistics_methods_Run_Result.Ves_param_4.Text);
    //// получеам вес каждого параметра


    Result := 0;

    // в  Znachenie_resultata складываем вердикт по всем параметрам
    for  I := 1 to 4 do
      begin
        // для всех параметров определяем их лучшее значение без учёта остальных
        if ((criterii[I] * StrToFloat(Save_iterac[N_pretend].Param_Znach[I])) >
            (criterii[I] * Luch_parametra[I])) then
          Luch_parametra[I] := StrToFloat(Save_iterac[N_pretend].Param_Znach[I]);

        // для всех параметров вычитаем из результатов N_pretend результаты N_luchsh
        urovn_koef := Max(Abs(StrToFloat(Save_iterac[N_pretend].Param_Znach[I])),
            Abs(StrToFloat(Save_iterac[N_luchsh].Param_Znach[I])));
        if urovn_koef = 0 then
          urovn_koef := 1;
        Znachenie_resultata_criteria := criterii[I] * ves[I] *
            (StrToFloat(Save_iterac[N_pretend].Param_Znach[I]) -
            StrToFloat(Save_iterac[N_luchsh].Param_Znach[I])) / urovn_koef;
        Result := Result + Znachenie_resultata_criteria;
      end;
  end;

// -> ///////////////////////////////////////////////////// Конец ф-ии vibor_luchshego /////////////////////////////////////



// -> ///////////////////////////////////////////////////// Начало п/п UstanovkaParametra /////////////////////////////////////
function TStatistics_methods_Main.UstanovkaParametra(Sender: TObject;
  var Param_Name: string; var Param_znach: string): string;
    {
    подпрограмма для:
    1) установки к.л. параметра
    2) получения к.л. параметра
    Param_Name - название параметра, возможные значения:
        -'NRC'
        -'RSUMX'
        -'RSUMY'
        -'ORT_7'
        -'PRM1'
        -'PRM2'
        -'PRM3'
        -'DR'
        -'ORT14'
        -'ORT21'
        -'ORT3'
        -'ORT10'
        -'ORT17'
    Param_znach:
        - значение параметра
        - 'Poluchenie' - для его получения
    }
  var
    FMainParams: TMainParams;
    FMainParamsMaterial: TMainParamsMaterial;
    FFileName, f: string;
    NrcMy: Integer;
    RSUMX, RSUMY, ORT_7, PRM1, PRM2, PRM3, DR, ORT14, ORT21,
     ORT3, ORT10, ORT17 {, ORT21}: Real;
  begin
    F := Project_GetFormFile;
    if FileExists(F) then
      FFilename := f;

    Result := '1';  
    NrcMy := 0;
    RSUMX := 0;
    RSUMY := 0;
    ORT_7 := 0;
    PRM1 := 0;
    PRM2 := 0;
    PRM3 := 0;
    DR := 0;
    ORT14 := 0;
    ORT21 := 0;
    ORT3 := 0;
    ORT10 := 0;
    ORT17 := 0;
{
    ORT21 := 0;
}

    // Вытаскивание параметра
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'NRC') then
      NrcMy := StrToInt(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'RSUMX') then
      RSUMX := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'RSUMY') then
      RSUMY := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT_7') then
      ORT_7 := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'PRM1') then
      PRM1 := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'PRM2') then
      PRM2 := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'PRM3') then
      PRM3 := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'DR') then
      DR := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT14') then
      ORT14 := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT21') then
      ORT21 := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT3') then
      ORT3 := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT10') then
      ORT10 := StrToFloat(Param_znach);
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT17') then
      ORT17 := StrToFloat(Param_znach);
{
    if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT21') then
      ORT21 := StrToFloat(Param_znach);
}


    // Вытаскиваем значения Параметра, изменяем их и записываем обратно
    if (Length(FFileName) > 0) and (LowerCase(ExtractFileExt(FFileName)) =
        '.sfm') then
      begin
        with TZonesClass.Create do
          begin
            Load(FFileName);
            FmainParams := MainParamsClass.MainParams;
            FmainParamsMaterial := MainParamsClass.MainParamsMaterial;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'NRC') then
              FMainParams.NRC := NrcMy;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'NRC') then
              begin
                Default_NRC := FMainParams.NRC;
                Result := IntToStr(FMainParams.NRC);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'RSUMX') then
              FMainParams.RSUMX := RSUMX;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'RSUMX') then
              begin
                Default_RSUMX := FMainParams.RSUMX;
                Result := FloatToStr(FMainParams.RSUMX);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'RSUMY') then
              FMainParams.RSUMY := RSUMY;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'RSUMY') then
              begin
                Default_RSUMY := FMainParams.RSUMY;
                Result := FloatToStr(FMainParams.RSUMY);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT_7') then
              FMainParams.DD := ORT_7;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'ORT_7') then
              begin
                Default__ORT_7 := FMainParams.DD;
                Result := FloatToStr(FMainParams.DD);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'PRM1') then
              FmainParamsMaterial.PRM1 := PRM1;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'PRM1') then
              begin
                Default__PRM1 := FmainParamsMaterial.PRM1;
                Result := FloatToStr(FmainParamsMaterial.PRM1);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'PRM2') then
              FmainParamsMaterial.PRM2 := PRM2;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'PRM2') then
              begin
                Default__PRM2 := FmainParamsMaterial.PRM2;
                Result := FloatToStr(FmainParamsMaterial.PRM2);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'PRM3') then
              FmainParamsMaterial.PRM3 := PRM3;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'PRM3') then
              begin
                Default__PRM3 := FmainParamsMaterial.PRM3;
                Result := FloatToStr(FmainParamsMaterial.PRM3);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'DR') then
              FMainParams.DR := DR;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'DR') then
              begin
                Default__DR := FmainParams.DR;
                Result := FloatToStr(FmainParams.DR);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT14') then
              FmainParamsMaterial.ORT14 := ORT14;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'ORT14') then
              begin
                Default__ORT14 := FmainParamsMaterial.ORT14;
                Result := FloatToStr(FmainParamsMaterial.ORT14);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT21') then
              FmainParamsMaterial.ORT21 := ORT21;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'ORT21') then
              begin
                Default__ORT21 := FmainParamsMaterial.ORT21;
                Result := FloatToStr(FmainParamsMaterial.ORT21);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT3') then
              FMainParams.SB := ORT3;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'ORT3') then
              begin
                Default__ORT3 := FMainParams.SB;
                Result := FloatToStr(FMainParams.SB);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT10') then
              FmainParamsMaterial.ORT10 := ORT10;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'ORT10') then
              begin
                Default__ORT10 := FmainParamsMaterial.ORT10;
                Result := FloatToStr(FmainParamsMaterial.ORT10);
              end;

            if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT17') then
              FmainParamsMaterial.ORT17 := ORT17;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'ORT17') then
              begin
                Default__ORT17 := FmainParamsMaterial.ORT17;
                Result := FloatToStr(FmainParamsMaterial.ORT17);
              end;

{
            if (Param_znach <> 'Poluchenie') and (Param_Name = 'ORT21') then
              FmainParamsMaterial.ORT21 := ORT21;
            if (Param_znach = 'Poluchenie') and (Param_Name = 'ORT21') then
              begin
                Default__ORT21 := FmainParamsMaterial.ORT21;
                Result := FloatToStr(FmainParamsMaterial.ORT21);
              end;
}

            MainParamsClass.MainParamsMaterial := FmainParamsMaterial;
            MainParamsClass.MainParams := FMainParams;
            Save(FFileName);
            Free;
          end;
      end;
  end;
// <- ///////////////////////////////////////////////////// Конец п/п UstanovkaParametra /////////////////////////////////////



// -> ///////////////////////////////////////////////////// Ф-ия Poluchenie_i_ustanovka_random /////////////////////////////////////
function TStatistics_methods_Main.Poluchenie_i_ustanovka_random(Sender: TObject;
  var Param_Name: string; var Nachalo_intervala: Real;
  var Konec_intervala: Real): string;
    {
    подпрограмма для:
    1) получения равномерного случайного числа
    2) при необходимости, его преобразования в нормальное
    3) приведение к интарвалу
    4) вызова п/п установки необходимого параметра
    }
  var
    Name, Znach: string;
    Random_chisl: Real;
  begin
    //{->Получение нормального или равномерного случайного числа от 0 до 1
    if normal_law_distribution.Checked = true then
      Random_chisl := poluchenie_normaln_sluch_chisla()
          //{->Получение нормального случайного числа от 0 до 1
    else
      Random_chisl := poluchenie_ravnomern_sluch_chisla();
    //{->Получение равномерного случайного числа от 0 до 1
    //{->Получение равномерного или нормального случайного числа от 0 до 1

    //{->Приведение случайного числа к заданному интервалу
    Random_chisl := Nachalo_intervala + (Konec_intervala - Nachalo_intervala) *
        Random_chisl;
    //{<-Приведение случайного числа к заданному интервалу


    //{->установка параметров
    Name := Param_Name;
    if Param_Name = 'NRC' then
      Znach := FloatToStr(Int(Random_chisl))   // т.к.  NRC - int
    else
      Znach := FloatToStr(Random_chisl);
    // т.к.  все остальные - real
    Statistics_methods_Main.UstanovkaParametra(Statistics_methods_Main,
        Name, Znach);
    Result := Znach;
    //{<-установка параметров
  end;
// <- ///////////////////////////////////////////////////// Конец Ф-ии Poluchenie_i_ustanovka_random /////////////////////////////////////



// -> ///////////////////////////////////////////////////// Ф-ия default_znach_po_nazv /////////////////////////////////////
function TStatistics_methods_Main.default_znach_po_nazv(
  var Param_Name: string): string;
        {
        -> имя дефолтного параметра
        <- значение в текстовом формате
        }
  begin
    if Param_Name = 'NRC' then
      Result := IntToStr(Default_NRC);
    if Param_Name = 'RSUMX' then
      Result := FloatToStr(Default_RSUMX);
    if Param_Name = 'RSUMY' then
      Result := FloatToStr(Default_RSUMY);
    if Param_Name = 'ORT_7' then
      Result := FloatToStr(Default__ORT_7);
    if Param_Name = 'PRM1' then
      Result := FloatToStr(Default__PRM1);
    if Param_Name = 'PRM2' then
      Result := FloatToStr(Default__PRM2);
    if Param_Name = 'PRM3' then
      Result := FloatToStr(Default__PRM3);
    if Param_Name = 'DR' then
      Result := FloatToStr(Default__DR);
    if Param_Name = 'ORT14' then
      Result := FloatToStr(Default__ORT14);
    if Param_Name = 'ORT21' then
      Result := FloatToStr(Default__ORT21);
    if Param_Name = 'ORT3' then
      Result := FloatToStr(Default__ORT3);
    if Param_Name = 'ORT10' then
      Result := FloatToStr(Default__ORT10);
    if Param_Name = 'ORT17' then
      Result := FloatToStr(Default__ORT17);
{
    if Param_Name = 'ORT21' then
      Result := FloatToStr(Default__ORT21);

}
  end;
// <- ///////////////////////////////////////////////////// Конец ф-ии default_znach_po_nazv /////////////////////////////////////


// -> ///////////////////////////////////////////////////// Ф-ия poluchenie_ravnomern_sluch_chisla /////////////////////////////////////
function TStatistics_methods_Main.poluchenie_ravnomern_sluch_chisla(): Real;
        {
        -> инф-ия из гуя
        <- равномерное случайное число от 0 до 1
        }
  var
    Random_chisl_int: Integer;
  begin
    if custom_generator.Checked then
    ////Получение чисел из .src
      begin
        if custom_generator_path.Caption = 'Путь к случайным числам не выбран' then
          custom_generator_browseClick(self);

        RAVNOMERN_nomer_tek := RAVNOMERN_nomer_tek + 1;
        if RAVNOMERN_nomer_tek > RAVNOMERN_nomer then
          RAVNOMERN_nomer_tek := 1;
        Result := RAVNOMERN_CHISLA[RAVNOMERN_nomer_tek];
      end
    else
      begin
        Random_chisl_int := Random(100);
        //стандартная функция Дэлфи
        Result := Random_chisl_int / 100;
      end;
  end;
// <- ///////////////////////////////////////////////////// Конец ф-ии poluchenie_ravnomern_sluch_chisla /////////////////////////////////////


// -> ///////////////////////////////////////////////////// Ф-ия poluchenie_normaln_sluch_chisla /////////////////////////////////////
function TStatistics_methods_Main.poluchenie_normaln_sluch_chisla(): Real;
        {
        -> инф-ия из гуя
        <- нормальное случайное число от 0 до 1
        }
  var
    i, N: Integer;
    summa_sluch, normaln_sluch: Real;
  begin
    if custom_converter.Checked then
      begin
        if custom_converter_path.Caption = 'Путь к нормальным числам не выбран' then
          custom_converter_browseClick(self);
        ////Получение чисел из .snc

        NORMALN_nomer_tek := NORMALN_nomer_tek + 1;
        if NORMALN_nomer_tek > NORMALN_nomer then
          NORMALN_nomer_tek := 1;
        Result := NORMALN_CHISLA[NORMALN_nomer_tek];
      end
    else
      begin
        //////////////реализация метода преобразования: получение из суммы нескольких равномерных ////////////////////////////////////////////
        summa_sluch := 0;
        N           := 6;
        for  I := 1 to N do
          begin
            summa_sluch := summa_sluch + poluchenie_ravnomern_sluch_chisla;
          end;

        normaln_sluch := ((Sqrt(3)) * (2 * summa_sluch - N)) / ((Sqrt(N)));
        // нормальное ?от -4.25 до 4.25?

        //////////////реализация метода преобразования: получение из суммы нескольких равномерных ////////////////////////////////////////////

        Result := (normaln_sluch + 4.25) / (8.5);    // нормальное от 0 до 1
      end;
  end;
// <- ///////////////////////////////////////////////////// Конец ф-ии poluchenie_normaln_sluch_chisla /////////////////////////////////////

  { / \}
  {  | }
  {Имаметдинов}
procedure TStatistics_methods_Main.custom_generator_browseClick(Sender: TObject);
  var
    Dialog: TOpenDialog;
    s, s_type: string;
  begin
    Dialog := TOpenDialog.Create(self);
    Dialog.Title := 'Открыть файл с равномерными случайными числами';
    s_type := 'src';
    if Dialog.Execute then
      begin
        s := Dialog.FileName;
        if TXT_READ(s, s_type) = false then
          begin
            ShowMessage('Файл: "' + s + '" не содержит необходимых чисел.');
            Exit;
          end;
        custom_generator_path.Caption := s;
        Ravnomern_nambers.Caption  := inttostr(RAVNOMERN_nomer);
        Label11.Visible := true;
        Ravnomern_nambers.Visible := true;
      end
    else
      standart_generator.Checked := true;
    Dialog.Free;
  end;

// <- ///////////////////////////////////////////////////// Начало ф-ии TXT_READ /////////////////////////////////////
function TStatistics_methods_Main.TXT_READ(TXT_NAME: string;
  TXT_Type: string): Boolean;
                 {
                ->:
                    - название TXT - файла
                    - Тип файла(src - c равномерными или snc - c нормальными)
                <-:
                    - Глобальные массивы RAVNOMERN_CHISLA[10000] или NORMALN_CHISLA[10000]
                    - result: Подходит ли TXT - файл:
                                               True - ДА
                                               False - Нет
                }
  var
    Tip_chisel, I,RAVNOMERN_nomer_loc,NORMALN_nomer_loc: Integer;
    s, tmp: string;
    F: TextFile;
    Test_Real: Real;
  label
    sled_chislo;
  begin
      //обнуление счётчиков
      RAVNOMERN_nomer_loc := 0;
      NORMALN_nomer_loc := 0;
      //обнуление счётчиков

     if TXT_Type = 'snc' then
      Tip_chisel := 2
    else
      Tip_chisel := 1;
    Result := false;

    AssignFile(F, TXT_NAME);
    Reset(F);
    if not Eof(F) then
      Readln(F, s);
    if ((s = '#Ravnomernie sluchainie chisla') and (Tip_chisel = 1))
        or ((s = '#Normalnie sluchainie chisla') and (Tip_chisel = 2)) then
      begin
       while (not Eof(F)) do begin
          Readln(F, s);
        for  I := 1 to Length(s) do
          begin
            if s[I] <> ';' then
              begin
                tmp := tmp + s[I];
              end
            else
              begin
               if ((not CheckReal(tmp, Test_Real)) and (Test_Real<0) and (Test_Real>1))then
               goto sled_chislo;
               // проверяем корректность числа из файла, если нет, то идём к следующему в файле
                if Tip_chisel = 1 then
                  begin
                    RAVNOMERN_nomer_loc := RAVNOMERN_nomer_loc + 1;
                    if RAVNOMERN_nomer_loc > 10000 then
                      RAVNOMERN_nomer_loc := 9999;
                    RAVNOMERN_CHISLA[RAVNOMERN_nomer_loc] := Test_Real;
                  end
                else
                  begin
                    NORMALN_nomer_loc := NORMALN_nomer_loc + 1;
                    if NORMALN_nomer_loc > 10000 then
                      NORMALN_nomer_loc := 9999;
                    NORMALN_CHISLA[NORMALN_nomer_loc] := Test_Real;
                  end;
                Result := true;
                sled_chislo:
                tmp := '';
              end;
          end;
         end;
      end;
    CloseFile(F);

    //проверка количества случайных чисел в файле. если меньше 10, то вывод предупреждения.
    if (Tip_chisel = 1) and (RAVNOMERN_nomer_loc < 10) and (Result) then
      ShowMessage('Файл: "' + TXT_NAME + '" содержит только ' +
          IntToStr(RAVNOMERN_nomer_loc) + ' равномерных чисел от 0 до 1.');
    if (Tip_chisel = 2) and (NORMALN_nomer_loc < 10) and (Result) then
      ShowMessage('Файл: "' + TXT_NAME + '" содержит только ' +
          IntToStr(NORMALN_nomer_loc) + ' нормальных чисел от 0 до 1.');
    //проверка количества случайных чисел в файле. если меньше 10, то вывод предупреждения.

    //окончательное применение результатов
    if  (Tip_chisel = 1) and (Result) then RAVNOMERN_nomer := RAVNOMERN_nomer_loc;
    if  (Tip_chisel = 2) and (Result) then NORMALN_nomer := NORMALN_nomer_loc;
    //окончательное применение результатов
  end;
// <- ///////////////////////////////////////////////////// Конец ф-ии TXT_READ /////////////////////////////////////

// <- ///////////////////////////////////////////////////// !!TStatistics_methods_Main!! /////////////////////////////////////




// -> ///////////////////////////////////////////////////// !!TSave_iterac!! /////////////////////////////////////

// -> ///////////////////////////////////////////////////// Начало ф-ии Iter_results_save /////////////////////////////////////
function TSave_iterac.Iter_results_save(VN_Nomer_Iteracii: Integer): Boolean;
                 {
                ->:
                    - Входные параметры на итерации
                    - Файлы с результатами расчёта
                <-:
                    - Максимальное эквивалентное напряжение
                    - Факт разрушения
                    Возвращает:
                       True - удачно прочитали
                       False - в ф-ле .res есть ошибки
                }

  var
    x: Double;
    n, n1: Word;
    Path: string;
    vipoln: Integer; // проверяем, что операция выполнилась хотя бы раз.
    Nomer_elementa, Nomer_mater, ii, jj, kk: Integer;
    //Ekviv_stress: array[0..10000] of Real;
    VSE_stress: array[0..10000] of stress;
    Dopust_stress: array[0..4] of Real;
    Nomer_svoystva_element: array[0..10000] of Integer;
    max_stress_mater: array[0..4] of Real;
  begin
    Result := false;

    Nomer_iteracii := VN_Nomer_Iteracii;

    //из Result2.bin получить напряжения всех КЭ и его допутимое значение для каждого материала//////////
    Path := ExtractFilePath(ProjectFileName) + 'RESULT2.BIN';
    if not FileExists(Path) then
      Exit;
    AssignFile(F, Path);
    Reset(F);
    // считываем координаты узлов, составляющих КЭ в пустоту
    vipoln := 0; // обнуление выполнения считывания координат
    while not Eof(F) do
      begin
        MyREAD(Addr(n), 2);
        if n = 65535 then
          Break;
        //OneElement.Number:=CountOfElements+1;
        //OneElement.Node1:=n;
        MyREAD(Addr(n), 2);
        //OneElement.Node2:=n;
        MyREAD(Addr(n), 2);
        //OneElement.Node3:=n;
        //FOR j:=1 TO 7 DO OneElement.strain[j]:=0;
        //AddElement(OneElement);
        vipoln := 1;           // выполнилось считывание координат
      end;
    //IF CountOfElements=0 THEN EXIT;
    if vipoln = 0 then
      Exit; // операция ни разу не выполнялась

    n := 0;
    Nomer_elementa := 0;
    // считываем значения напряжений в КЭ
    vipoln := 0; // обнуление выполнения
    while not Eof(F) do
      begin
        MyREAD(Addr(x), 8);
        if x = -1 then
          Break;
        Inc(n);
        Nomer_elementa := Nomer_elementa + 1;
        //OneElement:=GetElement(n);
        VSE_stress[Nomer_elementa][1] := x;  //запоминаем напряжение Х.
        //OneElement.strain[1]:=x;

        MyREAD(Addr(x), 8);
        VSE_stress[Nomer_elementa][2] := x;  //запоминаем напряжение Y.
        //OneElement.strain[2]:=x;

        MyREAD(Addr(x), 8);
        VSE_stress[Nomer_elementa][3] := x;  //запоминаем касательное напряжение.
        //OneElement.strain[3]:=x;

        MyREAD(Addr(x), 8);
        VSE_stress[Nomer_elementa][4] := x;  //запоминаем 1-ое главное напряжение.
        //OneElement.strain[4]:=x;

        MyREAD(Addr(x), 8);
        VSE_stress[Nomer_elementa][5] := x;  //запоминаем 2-ое главное напряжение.
        //OneElement.strain[5]:=x;

        MyREAD(Addr(x), 8);
        //OneElement.strain[6]:=x;
        //Ekviv_stress[Nomer_elementa] := x;  //запоминаем эквивалентное напряжение.
        VSE_stress[Nomer_elementa][6] := x;  //запоминаем эквивалентное напряжение.

        MyREAD(Addr(x), 8);
        VSE_stress[Nomer_elementa][7] := x;  //запоминаем углов напряжение.
        //OneElement.strain[7]:=x;
        //EditElement(n,OneElement);
        vipoln := 1;           // выполнилось
      end;
    if vipoln = 0 then
      Exit; // операция ни разу не выполнялась

    // Считываем св-ва материала КЭ   kotov , все впустую, кроме допускаемых напряжений для 3-х материалов
    n := 0;
    Nomer_mater := 0;
    vipoln := 0; // обнуление выполнения
    while not Eof(F) do
      begin
        MyREAD(Addr(x), 8);
        if x = -1 then
          Break;
        Inc(n);
        //Materials[n].E := x;
        MyREAD(Addr(x), 8);
        //Materials[n].Mu := x;
        MyREAD(Addr(x), 8);

        Nomer_mater := Nomer_mater + 1;
        Dopust_stress[Nomer_mater] := x;
        //запоминаем допускаемое напряжение для конкретного материала
        //Materials[n].Sg := x;
        MyREAD(Addr(x), 8);
        //Materials[n].free4 := x;
        MyREAD(Addr(x), 8);
        //Materials[n].free5 := x;
        MyREAD(Addr(x), 8);
        //Materials[n].free6 := x;
        MyREAD(Addr(x), 8);
        //Materials[n].Thickness := x;
        vipoln := 1;           // выполнилось
      end;
    if vipoln = 0 then
      Exit; // операция ни разу не выполнялась

    n := 0;
    Nomer_elementa := 0;
    vipoln := 0; // обнуление выполнения
    while not Eof(F) do
      begin
        MyREAD(Addr(n1), 2);
        if x = 65535 then
          Break;
        Inc(n);
        //OneElement:=GetElement(n);

        Nomer_elementa := Nomer_elementa + 1;
        Nomer_svoystva_element[Nomer_elementa] := n1;
        //OneElement.Material:=n1;
        //EditElement(n,OneElement);
        vipoln := 1;           // выполнилось
      end;
    if vipoln = 0 then
      Exit; // операция ни разу не выполнялась
    Close(F);

    Nomer_elementa := Nomer_elementa - 4;
    //ShowMessage('Nomer_elementa  = ' + IntToStr(Nomer_elementa) + ' Nomer_svoystva_element = '+ FloatToStr(Nomer_svoystva_element[Nomer_elementa])+ ' Ekviv_stress = '+ FloatToStr(Ekviv_stress[Nomer_elementa]));
    //из Result2.bin получить эквив напряжения всех КЭ и его допутимое значение для каждого материала//////////


//////Для каждого напряжения////////////////////////////////////////////////////////////////////////////////////
    Razrushenie := false;
    for  kk := 1 to 8 do
    begin

    //найти мах_эквив_напряжение для каждого материала///////////
    max_stress_mater[1] := 0;
    max_stress_mater[2] := 0;
    max_stress_mater[3] := 0;
    for  ii := 1 to 3 do
      begin
        for  jj := 1 to Nomer_elementa do
          begin
            if (Nomer_svoystva_element[jj] = ii) and
                //(Ekviv_stress[jj] > max_Ekviv_mater[ii]) then
                (abs(VSE_stress[jj][kk]) > abs(max_stress_mater[ii])) then //Максимальное считаем по абсолютному значению
              //max_stress_mater[ii] := Ekviv_stress[jj];
              max_stress_mater[ii] := VSE_stress[jj][kk];
          end;
      end;

    //ShowMessage('max_stress_mater[1]='+ FloatToStr(max_stress_mater[1])+'max_stress_mater[2]='+ FloatToStr(max_stress_mater[2])+'max_stress_mater[3]='+ FloatToStr(max_stress_mater[3]));
    //найти мах_эквив_напряжение для каждого материала///////////

    for  ii := 1 to 3 do
      begin
        Statistics_methods_Main.MAX_napr_mater[ii] :=
            Dopust_stress[ii];
      end;
    //сравнить мах_эквив_напряж с допустимым у каждого материала и установить "Razrushenie"/////

    for  ii := 1 to 3 do
      begin
        //MAX_ekviv_stress[ii] := max_stress_mater[ii];
        MAX_stress[ii][kk] := max_stress_mater[ii];
        if (abs(max_stress_mater[ii]) > abs(Dopust_stress[ii])) then   //Разрушение проверяем по абсолютному значению напряжения
          Razrushenie := true;
        //т.е. пластина разрушится в этом материале.
      end;
    //ShowMessage('Razrushenie='+ BoolToStr(Razrushenie));
    //сравнить мах_эквив_напряж с допустимым у каждого материала и установить "Razrushenie"/////



    //сравнить максимально напряжение во всех материала и установить "MAX_ekviv_stress"/////
    //MAX_ekviv_stress[5] := max_stress_mater[1];
    MAX_stress[5][kk] := max_stress_mater[1];
    for  ii := 2 to 3 do
      begin
        //if (max_stress_mater[ii] > MAX_ekviv_stress[5]) then
        if (abs(max_stress_mater[ii]) > abs(MAX_stress[5][kk])) then       //Разрушение проверяем по абсолютному значению напряжения
          //MAX_ekviv_stress[5] := max_stress_mater[ii];
          MAX_stress[5][kk] := max_stress_mater[ii];
      end;
    //ShowMessage('MAX_ekviv_stress'+ floatToStr(MAX_ekviv_stress));
    //сравнить максимально напряжение во всех материала и установить "MAX_ekviv_stress"/////

    end;
//////Для каждого напряжения////////////////////////////////////////////////////////////////////////////////////

    Result := true;
  end;
// <- ///////////////////////////////////////////////////// Конец ф-ии Iter_results_save /////////////////////////////////////


// <- ///////////////////////////////////////////////////// Начало ф-ии MyREAD /////////////////////////////////////
procedure TSave_iterac.MyREAD(pX: pTA; n: Byte);
  var
    i: Byte;
  begin
    for i := 1 to n do
      Read(F, pX^[i]);
  end;
// <- ///////////////////////////////////////////////////// Конец ф-ии MyREAD /////////////////////////////////////


// -> ///////////////////////////////////////////////////// Конструкторы/дискрипторы /////////////////////////////////////
constructor TSave_iterac.Create;
  begin
    //ProgramFiles:=TStringList.Create;
    //ProgramFiles.OnChange:=ListChange;
    //FormZones:=TZonesClass.Create;
  end;

destructor TSave_iterac.Destroy;
  begin
    //ProgramFiles.Free;
  end;

procedure TStatistics_methods_Main.change_value_1_nameChange(Sender: TObject);
  begin
    Statistics_methods_Main.nachln_ustanovka_izm_param(1,0,0,0);
  end;

procedure TStatistics_methods_Main.change_value_2_nameChange(Sender: TObject);
  begin
    Statistics_methods_Main.nachln_ustanovka_izm_param(0,1,0,0);
  end;

procedure TStatistics_methods_Main.change_value_3_nameChange(Sender: TObject);
  begin
    Statistics_methods_Main.nachln_ustanovka_izm_param(0,0,1,0);
  end;

procedure TStatistics_methods_Main.change_value_4_nameChange(Sender: TObject);
  begin
    Statistics_methods_Main.nachln_ustanovka_izm_param(0,0,0,1);
  end;

procedure TStatistics_methods_Main.change_value_1_checkClick(Sender: TObject);
  var
    Kolichestvo_aktiv_param: Integer;
  begin
  Kolichestvo_aktiv_param:=0;
    if change_value_1_check.Checked then
      begin
        Kolichestvo_aktiv_param := Kolichestvo_aktiv_param + 1;
        change_value_1_name.Enabled       := true;
        change_value_1_aver_distr.Enabled := true;
        change_value_1_max_diverg.Enabled := true;
        Statistics_methods_Run_Result.Param_1.Visible := true;
        Statistics_methods_Run_Result.znach_param_1.Visible := true;
        Statistics_methods_Run_Result.criter_param_1.Visible := true;
        Statistics_methods_Run_Result.Ves_param_1.Visible := true;
        Statistics_methods_Run_Result.znach_param_1_opt.Visible := true;
        Statistics_methods_Run_Result.param_1_pogr.Visible := true;
        Statistics_methods_Run_Result.Label10.Visible := true;
      end
    else
      begin
        change_value_1_name.Enabled       := false;
        change_value_1_aver_distr.Enabled := false;
        change_value_1_max_diverg.Enabled := false;
        Statistics_methods_Run_Result.Param_1.Visible := false;
        Statistics_methods_Run_Result.znach_param_1.Visible := false;
        Statistics_methods_Run_Result.criter_param_1.Visible := false;
        Statistics_methods_Run_Result.Ves_param_1.Visible := false;
        Statistics_methods_Run_Result.znach_param_1_opt.Visible := false;
        Statistics_methods_Run_Result.param_1_pogr.Visible := false;
        Statistics_methods_Run_Result.Label10.Visible := false;
      end;

    if change_value_2_check.Checked then
      begin
        Kolichestvo_aktiv_param := Kolichestvo_aktiv_param + 1;
        change_value_2_name.Enabled       := true;
        change_value_2_aver_distr.Enabled := true;
        change_value_2_max_diverg.Enabled := true;
        Statistics_methods_Run_Result.Param_2.Visible := true;
        Statistics_methods_Run_Result.znach_param_2.Visible := true;
        Statistics_methods_Run_Result.criter_param_2.Visible := true;
        Statistics_methods_Run_Result.Ves_param_2.Visible := true;
        Statistics_methods_Run_Result.znach_param_2_opt.Visible := true;
        Statistics_methods_Run_Result.param_2_pogr.Visible := true;
        Statistics_methods_Run_Result.Label11.Visible := true;
      end
    else
      begin
        change_value_2_name.Enabled       := false;
        change_value_2_aver_distr.Enabled := false;
        change_value_2_max_diverg.Enabled := false;
        Statistics_methods_Run_Result.Param_2.Visible := false;
        Statistics_methods_Run_Result.znach_param_2.Visible := false;
        Statistics_methods_Run_Result.criter_param_2.Visible := false;
        Statistics_methods_Run_Result.Ves_param_2.Visible := false;
        Statistics_methods_Run_Result.znach_param_2_opt.Visible := false;
        Statistics_methods_Run_Result.param_2_pogr.Visible := false;
        Statistics_methods_Run_Result.Label11.Visible := false;
      end;

    if change_value_3_check.Checked then
      begin
        Kolichestvo_aktiv_param := Kolichestvo_aktiv_param + 1;
        change_value_3_name.Enabled       := true;
        change_value_3_aver_distr.Enabled := true;
        change_value_3_max_diverg.Enabled := true;
        Statistics_methods_Run_Result.Param_3.Visible := true;
        Statistics_methods_Run_Result.znach_param_3.Visible := true;
        Statistics_methods_Run_Result.criter_param_3.Visible := true;
        Statistics_methods_Run_Result.Ves_param_3.Visible := true;
        Statistics_methods_Run_Result.znach_param_3_opt.Visible := true;
        Statistics_methods_Run_Result.param_3_pogr.Visible := true;
        Statistics_methods_Run_Result.Label12.Visible := true;
      end
    else
      begin
        change_value_3_name.Enabled       := false;
        change_value_3_aver_distr.Enabled := false;
        change_value_3_max_diverg.Enabled := false;
        Statistics_methods_Run_Result.Param_3.Visible := false;
        Statistics_methods_Run_Result.znach_param_3.Visible := false;
        Statistics_methods_Run_Result.criter_param_3.Visible := false;
        Statistics_methods_Run_Result.Ves_param_3.Visible := false;
        Statistics_methods_Run_Result.znach_param_3_opt.Visible := false;
        Statistics_methods_Run_Result.param_3_pogr.Visible := false;
        Statistics_methods_Run_Result.Label12.Visible := false;
      end;
    if change_value_4_check.Checked then
      begin
        Kolichestvo_aktiv_param := Kolichestvo_aktiv_param + 1;
        change_value_4_name.Enabled       := true;
        change_value_4_aver_distr.Enabled := true;
        change_value_4_max_diverg.Enabled := true;
        Statistics_methods_Run_Result.Param_4.Visible := true;
        Statistics_methods_Run_Result.znach_param_4.Visible := true;
        Statistics_methods_Run_Result.criter_param_4.Visible := true;
        Statistics_methods_Run_Result.Ves_param_4.Visible := true;
        Statistics_methods_Run_Result.znach_param_4_opt.Visible := true;
        Statistics_methods_Run_Result.param_4_pogr.Visible := true;
        Statistics_methods_Run_Result.Label13.Visible := true;
      end
    else
      begin
        change_value_4_name.Enabled       := false;
        change_value_4_aver_distr.Enabled := false;
        change_value_4_max_diverg.Enabled := false;
        Statistics_methods_Run_Result.Param_4.Visible := false;
        Statistics_methods_Run_Result.znach_param_4.Visible := false;
        Statistics_methods_Run_Result.criter_param_4.Visible := false;
        Statistics_methods_Run_Result.Ves_param_4.Visible := false;
        Statistics_methods_Run_Result.znach_param_4_opt.Visible := false;
        Statistics_methods_Run_Result.param_4_pogr.Visible := false;
        Statistics_methods_Run_Result.Label13.Visible := false;
      end;

      if Kolichestvo_aktiv_param = 0 then Statistics_methods_Main.Run.Enabled := false
      else Statistics_methods_Main.Run.Enabled := true;

      if Kolichestvo_aktiv_param < 2 then
        begin
        Statistics_methods_Run_Result.Label9.Visible := false;
        Statistics_methods_Run_Result.param_1_pogr.Visible := false;
        Statistics_methods_Run_Result.Label10.Visible := false;
        Statistics_methods_Run_Result.param_2_pogr.Visible := false;
        Statistics_methods_Run_Result.Label11.Visible := false;
        Statistics_methods_Run_Result.param_3_pogr.Visible := false;
        Statistics_methods_Run_Result.Label12.Visible := false;
        Statistics_methods_Run_Result.param_4_pogr.Visible := false;
        Statistics_methods_Run_Result.Label13.Visible := false;
        end
      else
        begin
        Statistics_methods_Run_Result.Label9.Visible := true;
        end;
  end;

procedure TStatistics_methods_Main.STOPClick(Sender: TObject);
  begin
    //выключить кнопку "STOP" Метода
    Statistics_methods_Main.Ostanovka := true;
    Statistics_methods_Main.STOP.Visible := false;
  end;

procedure TStatistics_methods_Main.custom_converterClick(Sender: TObject);
  begin
    custom_converter_browse.Enabled := true;
    custom_converter_path.Enabled := true;
    Label8.Enabled := true;
    Label9.Enabled := true;
    Normaln_nambers.Enabled := true;
    random_number_generator.Visible:=false;
  end;

procedure TStatistics_methods_Main.standart_converterClick(Sender: TObject);
  begin
    custom_converter_browse.Enabled := false;
    custom_converter_path.Enabled := false;
    Label8.Enabled := false;
    Label9.Enabled := false;
    Normaln_nambers.Enabled := false;
    random_number_generator.Visible:=true;
  end;

procedure TStatistics_methods_Main.custom_generatorClick(Sender: TObject);
  begin
    custom_generator_browse.Enabled := true;
    custom_generator_path.Enabled := true;
    Label7.Enabled := true;
    Label11.Enabled := true;
    Ravnomern_nambers.Enabled := true;
  end;

procedure TStatistics_methods_Main.standart_generatorClick(Sender: TObject);
  begin
    custom_generator_browse.Enabled := false;
    custom_generator_path.Enabled := false;
    Label7.Enabled := false;
    Label11.Enabled := false;
    Ravnomern_nambers.Enabled := false;
  end;

procedure TStatistics_methods_Main.equal_law_distributionClick(Sender: TObject);
  begin
    converter_chose.Visible := false;
    random_number_generator.Visible:=true;
  end;

procedure TStatistics_methods_Main.normal_law_distributionClick(Sender: TObject);
  begin
    converter_chose.Visible := true;
    if custom_converter.Checked then random_number_generator.Visible:=false;
  end;

procedure TStatistics_methods_Main.test_converterClick(Sender: TObject);
  begin
    //{вызов окна конфигурации анализа нормальных чисел}
    Statistics_methods_test_genrator_conf.Caption :=
        'Настройка анализа нормальных чисел';
    Statistics_methods_test_genrator_conf.Chisl_type.Text :=
        'Нормальные случаные';
    Statistics_methods_test_genrator_conf.average.Text := '0,5';
    Statistics_methods_test_genrator_conf.Dispersia.Text := '0,2887';
    Statistics_methods_test_genrator_conf.Rasch_statistick.Text := '0,99';
    Statistics_methods_test_genrator_conf.Rasch_Div.Text := '0,5';
    Statistics_methods_test_genrator_conf.Rasch_kv_Div.Text := '0,25';
    Statistics_methods_test_genrator_conf.Show;
  end;

procedure TStatistics_methods_Main.custom_converter_browseClick(Sender: TObject);
  var
    Dialog: TOpenDialog;
    s, s_type: string;
  begin
    Dialog := TOpenDialog.Create(self);
    Dialog.Title := 'Открыть файл с нормальными случайными числами';
    s_type := 'snc';
    if Dialog.Execute then
      begin
        s := Dialog.FileName;
        if TXT_READ(s, s_type) = false then
          begin
            ShowMessage('Файл: ' + s + ' не содержит необходимых чисел');
            Exit;
          end;
        custom_converter_path.Caption := s;
        Normaln_nambers.Caption  := inttostr(Normaln_nomer);
        Label9.Visible := true;
        Normaln_nambers.Visible := true;
      end
    else
      standart_converter.Checked := true;
    Dialog.Free;
  end;

procedure TStatistics_methods_Main.old_result_showClick(Sender: TObject);
  begin
    Statistics_methods_Run_Result.Show;
  end;

initialization
    for  I_init := 0 to 1000 do
      if Save_iterac[I_init] = nil then
          Save_iterac[I_init] := TSave_iterac.Create;

finalization
    for  I_init := 0 to 1000 do
      if Save_iterac[I_init] <> nil then
          Save_iterac[I_init].Free;
    // <- ///////////////////////////////////////////////////// Конструкторы/дискрипторы /////////////////////////////////////
    // <- ///////////////////////////////////////////////////// !!TSave_iterac!! /////////////////////////////////////
  end.
