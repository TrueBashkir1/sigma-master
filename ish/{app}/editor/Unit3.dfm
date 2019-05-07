object Form3: TForm3
  Left = 1144
  Top = 331
  Width = 724
  Height = 410
  AlphaBlend = True
  Caption = #1055#1086#1089#1090#1088#1086#1077#1085#1080#1077' '#1075#1088#1072#1092#1080#1082#1086#1074' '#1089#1093#1086#1076#1080#1084#1086#1089#1090#1080
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 16
    Top = 8
    Width = 73
    Height = 20
    Caption = #1055#1088#1086#1077#1082#1090': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 32
    Width = 313
    Height = 249
    Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 64
      Width = 107
      Height = 16
      Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1072' '#1061':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 88
      Width = 108
      Height = 16
      Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1072' Y:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 8
      Top = 216
      Width = 146
      Height = 16
      Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' NRC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 16
      Width = 90
      Height = 13
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1090#1086#1095#1082#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EditX: TEdit
      Left = 152
      Top = 64
      Width = 81
      Height = 21
      Enabled = False
      TabOrder = 0
      OnChange = EditXChange
    end
    object EditY: TEdit
      Left = 152
      Top = 88
      Width = 81
      Height = 21
      Enabled = False
      TabOrder = 1
      OnChange = EditYChange
    end
    object Edit1: TEdit
      Left = 176
      Top = 216
      Width = 49
      Height = 21
      TabOrder = 2
      Text = '12'
      Visible = False
      OnChange = Edit1Change
    end
    object ComboBoxEx1: TComboBoxEx
      Left = 8
      Top = 32
      Width = 105
      Height = 22
      ItemsEx = <>
      Ctl3D = False
      ItemHeight = 16
      ParentCtl3D = False
      TabOrder = 3
      OnSelect = ComboBoxEx1Select
      DropDownCount = 8
    end
    object Button10: TButton
      Left = 120
      Top = 30
      Width = 89
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1090#1086#1095#1082#1091
      TabOrder = 4
      OnClick = Button10Click
    end
    object Button11: TButton
      Left = 216
      Top = 30
      Width = 89
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1090#1086#1095#1082#1091
      Enabled = False
      TabOrder = 5
      OnClick = Button11Click
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 120
      Width = 297
      Height = 41
      Caption = #1052#1077#1090#1086#1076' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' '#1074' '#1090#1086#1095#1082#1077
      TabOrder = 6
      object StressMethod1: TRadioButton
        Left = 8
        Top = 17
        Width = 49
        Height = 16
        Caption = #1062#1055#1057
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = StressMethod1Click
      end
      object StressMethod2: TRadioButton
        Left = 96
        Top = 18
        Width = 57
        Height = 15
        Caption = #1062#1052
        TabOrder = 1
        OnClick = StressMethod2Click
      end
      object StressMethod3: TRadioButton
        Left = 184
        Top = 18
        Width = 49
        Height = 15
        Caption = #1050#1069
        TabOrder = 2
        OnClick = StressMethod3Click
      end
    end
    object GroupBox6: TGroupBox
      Left = 8
      Top = 168
      Width = 297
      Height = 41
      Caption = #1048#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1077' NRC'
      TabOrder = 7
      object RadioButton4: TRadioButton
        Left = 8
        Top = 16
        Width = 49
        Height = 17
        Caption = #1042#1089#1077
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object RadioButton5: TRadioButton
        Left = 96
        Top = 16
        Width = 65
        Height = 17
        Caption = #1063#1077#1090#1085#1099#1077
        TabOrder = 1
      end
      object RadioButton6: TRadioButton
        Left = 184
        Top = 16
        Width = 73
        Height = 17
        Caption = #1053#1077#1095#1077#1090#1085#1099#1077
        TabOrder = 2
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 344
    Top = 32
    Width = 337
    Height = 249
    Caption = #1043#1088#1072#1092#1080#1082#1080' '#1089#1093#1086#1076#1080#1084#1086#1089#1090#1080
    TabOrder = 1
    object Button1: TButton
      Left = 24
      Top = 17
      Width = 145
      Height = 25
      Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' '#1061
      Enabled = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 176
      Top = 17
      Width = 145
      Height = 25
      Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077'  '#1087#1086' Y'
      Enabled = False
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 24
      Top = 48
      Width = 145
      Height = 25
      Caption = #1050#1072#1089#1072#1090#1077#1083#1100#1085#1086#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1077
      Enabled = False
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 176
      Top = 48
      Width = 145
      Height = 25
      Caption = '1-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1077
      Enabled = False
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 24
      Top = 79
      Width = 145
      Height = 25
      Caption = '2-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1077
      Enabled = False
      TabOrder = 4
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 135
      Top = 142
      Width = 75
      Height = 25
      Caption = 'MS Word'
      Enabled = False
      TabOrder = 5
      OnClick = Button6Click
    end
    object Button9: TButton
      Left = 176
      Top = 79
      Width = 145
      Height = 25
      Caption = #1069#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1086#1077
      Enabled = False
      TabOrder = 6
      OnClick = Button9Click
    end
    object Button13: TButton
      Left = 24
      Top = 112
      Width = 145
      Height = 25
      Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1087#1086' '#1061
      Enabled = False
      TabOrder = 7
      OnClick = Button13Click
    end
    object Button14: TButton
      Left = 176
      Top = 112
      Width = 145
      Height = 25
      Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1087#1086' Y'
      Enabled = False
      TabOrder = 8
      OnClick = Button14Click
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 184
      Width = 321
      Height = 57
      Caption = #1060#1086#1088#1084#1072#1090' '#1074#1077#1097#1077#1089#1090#1074#1077#1085#1085#1099#1093' '#1095#1080#1089#1077#1083' [ '#1087#1088#1080' '#1101#1082#1089#1087#1086#1088#1090#1077' '#1074' Word ]'
      TabOrder = 9
      object Label6: TLabel
        Left = 8
        Top = 24
        Width = 64
        Height = 13
        Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077
      end
      object Label7: TLabel
        Left = 184
        Top = 24
        Width = 73
        Height = 13
        Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077
      end
      object Edit2: TEdit
        Left = 88
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 0
        Text = '0'
        OnChange = Edit2Change
      end
      object Edit3: TEdit
        Left = 264
        Top = 24
        Width = 41
        Height = 21
        TabOrder = 1
        Text = '5'
        OnChange = Edit3Change
      end
    end
  end
  object Button7: TButton
    Left = 16
    Top = 295
    Width = 209
    Height = 34
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092#1080#1082#1080
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 480
    Top = 295
    Width = 209
    Height = 34
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button8Click
  end
  object Ole: TOleContainer
    Left = 328
    Top = 192
    Width = 17
    Height = 17
    Caption = 'Ole'
    TabOrder = 4
    Visible = False
  end
  object Button12: TButton
    Left = 248
    Top = 296
    Width = 209
    Height = 33
    Caption = #1055#1086#1089#1090#1088#1086#1080#1090#1100' '#1075#1088#1072#1092#1080#1082#1080' '#1074' '#1045#1057#1050
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
    OnClick = Button12Click
  end
  object ComboBox1: TComboBox
    Left = 192
    Top = 248
    Width = 97
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = '12'
    OnChange = ComboBox1Change
    Items.Strings = (
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12')
  end
  object MainMenu1: TMainMenu
    Left = 328
    Top = 152
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100'...'
        Enabled = False
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100'...'
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object N5: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        OnClick = Button8Click
      end
    end
  end
  object sdSave: TSaveDialog
    DefaultExt = 'gfk'
    Filter = #1060#1072#1081#1083#1099' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' (*.gfk)|*.gfk'
    Left = 328
    Top = 120
  end
  object odOpen: TOpenDialog
    DefaultExt = 'gfk'
    Filter = #1060#1072#1081#1083#1099' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074' (*.gfk)|*.gfk'
    Left = 328
    Top = 88
  end
end
