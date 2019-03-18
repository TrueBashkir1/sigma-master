object FormSettings: TFormSettings
  Left = 1055
  Top = 71
  Width = 236
  Height = 691
  BorderIcons = [biSystemMenu]
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox2: TScrollBox
    Left = 0
    Top = 0
    Width = 228
    Height = 657
    Align = alClient
    TabOrder = 0
    object GroupBox4: TGroupBox
      Left = 0
      Top = 325
      Width = 224
      Height = 104
      Align = alTop
      Caption = #1059#1079#1077#1083
      Enabled = False
      TabOrder = 0
      object Label2: TLabel
        Left = 8
        Top = 50
        Width = 13
        Height = 13
        Caption = 'X:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 104
        Top = 50
        Width = 13
        Height = 13
        Caption = 'Y:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 20
        Width = 71
        Height = 13
        Caption = #1058#1077#1082#1091#1097#1080#1081' '#1091#1079#1077#1083
      end
      object CurNode: TComboBox
        Left = 104
        Top = 16
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        Sorted = True
        TabOrder = 2
        OnChange = CurNodeChange
      end
      object EditX: TEdit
        Left = 24
        Top = 48
        Width = 65
        Height = 21
        TabOrder = 0
        OnExit = EditXExit
        OnKeyPress = EditXKeyPress
      end
      object EditY: TEdit
        Left = 120
        Top = 48
        Width = 65
        Height = 21
        TabOrder = 1
        OnExit = EditYExit
        OnKeyPress = EditYKeyPress
      end
      object Button4: TButton
        Left = 8
        Top = 80
        Width = 185
        Height = 17
        Caption = #1042#1074#1077#1089#1090#1080' '#1085#1077#1087#1088#1077#1088#1099#1074#1085#1091#1102' '#1085#1091#1084#1077#1088#1072#1094#1080#1102
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = Button4Click
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 97
      Width = 224
      Height = 110
      Align = alTop
      Caption = #1047#1086#1085#1072
      TabOrder = 1
      object Label5: TLabel
        Left = 8
        Top = 20
        Width = 72
        Height = 13
        Caption = #1058#1077#1082#1091#1097#1072#1103' '#1079#1086#1085#1072
      end
      object AddZone: TButton
        Left = 8
        Top = 72
        Width = 105
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1086#1085#1091
        TabOrder = 0
        OnClick = AddZoneClick
      end
      object DelZone: TButton
        Left = 120
        Top = 72
        Width = 89
        Height = 25
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1089#1083#1077#1076#1085#1102#1102' '#1079#1086#1085#1091
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1086#1085#1091
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = DelZoneClick
      end
      object CurZone: TComboBox
        Left = 104
        Top = 16
        Width = 89
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
      end
      object Button2: TButton
        Left = 8
        Top = 48
        Width = 201
        Height = 17
        Caption = #1057#1084#1077#1085#1080#1090#1100' '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1086#1073#1093#1086#1076#1072
        TabOrder = 3
        OnClick = Button2Click
      end
    end
    object GroupBox6: TGroupBox
      Left = 0
      Top = 429
      Width = 224
      Height = 112
      Align = alTop
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1092#1086#1088#1084#1099
      TabOrder = 2
      object SpeedButton6: TSpeedButton
        Left = 46
        Top = 64
        Width = 97
        Height = 25
        Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1079#1086#1085
        OnClick = SpeedButton6Click
      end
      object UseNodeNum: TCheckBox
        Left = 8
        Top = 20
        Width = 217
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1091#1084#1077#1088#1072#1094#1080#1102' '#1091#1079#1083#1086#1074
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = UseNodeNumClick
      end
      object UseZoneNum: TCheckBox
        Left = 8
        Top = 44
        Width = 209
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1091#1084#1077#1088#1072#1094#1080#1102' '#1079#1086#1085
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = UseZoneNumClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 207
      Width = 224
      Height = 118
      Align = alTop
      Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1085#1072#1089#1090#1088#1086#1081#1082#1080
      TabOrder = 3
      object SpeedButton1: TSpeedButton
        Left = 46
        Top = 88
        Width = 97
        Height = 25
        Hint = #1047#1072#1076#1072#1085#1080#1077' '#1086#1089#1085#1086#1074#1085#1099#1093' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
        AllowAllUp = True
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
      end
      object UseGridEps: TCheckBox
        Left = 8
        Top = 16
        Width = 180
        Height = 17
        Hint = #1055#1088#1080#1074#1103#1079#1072#1090#1100' '#1082' '#1082#1086#1086#1088#1076#1080#1085#1072#1090#1085#1086#1081' '#1089#1077#1090#1082#1077
        Caption = #1055#1088#1080#1074#1103#1079#1072#1090#1100' '#1082' '#1089#1077#1090#1082#1077
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object UseGrid: TCheckBox
        Left = 8
        Top = 40
        Width = 180
        Height = 17
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1089#1077#1090#1082#1091
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = UseGridClick
      end
      object UseBuffer: TCheckBox
        Left = 8
        Top = 64
        Width = 180
        Height = 17
        Caption = #1050#1072#1095#1077#1089#1090#1074#1077#1085#1085#1086#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
    end
    object GroupBox5: TGroupBox
      Left = 0
      Top = 541
      Width = 224
      Height = 89
      Align = alTop
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      TabOrder = 4
      object bntClose: TButton
        Left = 56
        Top = 56
        Width = 113
        Height = 25
        Caption = #1047#1072#1082#1088#1099#1090#1100
        TabOrder = 0
        OnClick = bntCloseClick
      end
      object btnSave: TButton
        Left = 112
        Top = 16
        Width = 97
        Height = 25
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        TabOrder = 1
        OnClick = btnSaveClick
      end
      object btnReset: TButton
        Left = 8
        Top = 16
        Width = 89
        Height = 25
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1096#1072#1075
        Enabled = False
        TabOrder = 2
        OnClick = btnResetClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 224
      Height = 97
      Align = alTop
      Caption = #1052#1072#1089#1096#1090#1072#1073
      TabOrder = 5
      object Label4: TLabel
        Left = 10
        Top = 68
        Width = 70
        Height = 13
        Caption = #1059#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1074
      end
      object LabelScale: TLabel
        Left = 2
        Top = 15
        Width = 220
        Height = 13
        Align = alTop
        Alignment = taCenter
      end
      object TrackBar1: TTrackBar
        Left = 2
        Top = 28
        Width = 220
        Height = 189
        Align = alTop
        Max = 200
        Frequency = 10
        Position = 93
        TabOrder = 0
        OnChange = TrackBar1Change
      end
      object EditScale: TEdit
        Left = 96
        Top = 64
        Width = 97
        Height = 21
        AutoSelect = False
        TabOrder = 1
        Text = '100'
        OnExit = EditScaleExit
        OnKeyDown = EditScaleKeyDown
      end
    end
  end
end
