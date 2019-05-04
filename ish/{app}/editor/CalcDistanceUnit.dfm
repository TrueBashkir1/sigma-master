object CalcDistanceForm: TCalcDistanceForm
  Left = 871
  Top = 129
  Width = 236
  Height = 537
  Caption = 'Sigma 7.4 - '#1056#1072#1089#1095#1077#1090' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 220
    Height = 498
    Align = alClient
    TabOrder = 0
    object pnlButtons: TGroupBox
      Left = 0
      Top = 0
      Width = 216
      Height = 81
      Align = alTop
      TabOrder = 0
      object btnCalcLinear: TButton
        Left = 8
        Top = 48
        Width = 201
        Height = 25
        Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1087#1086' '#1087#1088#1103#1084#1086#1081
        TabOrder = 0
        OnClick = btnCalcLinearClick
      end
      object btnCalcArcLength: TButton
        Left = 8
        Top = 16
        Width = 201
        Height = 25
        Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1087#1086' '#1076#1091#1075#1077
        TabOrder = 1
        OnClick = btnCalcArcLengthClick
      end
    end
    object pnlLinear: TGroupBox
      Left = 0
      Top = 353
      Width = 216
      Height = 128
      Align = alTop
      Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1087#1086' '#1087#1088#1103#1084#1086#1081
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      Visible = False
      object lblNode1l: TLabel
        Left = 16
        Top = 20
        Width = 26
        Height = 13
        Caption = #1059#1079#1077#1083
        Visible = False
      end
      object lblNode2l: TLabel
        Left = 110
        Top = 20
        Width = 26
        Height = 13
        Caption = #1059#1079#1077#1083
        Visible = False
      end
      object lblResLinear: TLabel
        Left = 8
        Top = 44
        Width = 139
        Height = 13
        Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080':'
        Visible = False
      end
      object lblNote: TLabel
        Left = 0
        Top = 96
        Width = 217
        Height = 25
        AutoSize = False
        Caption = #1042#1099#1073#1077#1088#1080#1090#1077' 2 '#1091#1079#1083#1072' '#1075#1077#1086#1084#1077#1090#1088#1080#1095#1077#1089#1082#1086#1081' '#1084#1086#1076#1077#1083#1080
        Visible = False
      end
      object resLinear: TEdit
        Left = 8
        Top = 60
        Width = 97
        Height = 21
        ReadOnly = True
        TabOrder = 0
        Visible = False
      end
      object node1Number: TEdit
        Left = 50
        Top = 16
        Width = 41
        Height = 21
        Ctl3D = True
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
        Visible = False
      end
      object node2Number: TEdit
        Left = 144
        Top = 16
        Width = 41
        Height = 21
        ReadOnly = True
        TabOrder = 2
        Visible = False
      end
    end
    object pnlArc: TGroupBox
      Left = 0
      Top = 81
      Width = 216
      Height = 272
      Align = alTop
      Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1087#1086' '#1076#1091#1075#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080
      TabOrder = 2
      Visible = False
      object lblResA1: TLabel
        Left = 8
        Top = 124
        Width = 157
        Height = 13
        Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080' 1-2:'
        Visible = False
      end
      object lblNoteA: TLabel
        Left = 8
        Top = 248
        Width = 212
        Height = 13
        AutoSize = False
        Caption = #1042#1099#1073#1077#1088#1080#1090#1077' 3 '#1091#1079#1083#1072' '#1075#1077#1086#1084#1077#1090#1088#1080#1095#1077#1089#1082#1086#1081' '#1084#1086#1076#1077#1083#1080
        Visible = False
      end
      object lblResA2: TLabel
        Left = 8
        Top = 164
        Width = 157
        Height = 13
        Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080' 2-3:'
        Visible = False
      end
      object lblResA3: TLabel
        Left = 8
        Top = 204
        Width = 157
        Height = 13
        Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080' 1-3:'
        Visible = False
      end
      object lblNodeNum1: TLabel
        Left = 24
        Top = 40
        Width = 6
        Height = 13
        Caption = '1'
        Visible = False
      end
      object lblNodeNum2: TLabel
        Left = 73
        Top = 40
        Width = 6
        Height = 13
        Caption = '2'
        Visible = False
      end
      object lblNodeNum3: TLabel
        Left = 128
        Top = 40
        Width = 6
        Height = 13
        Caption = '3'
        Visible = False
      end
      object res1a: TEdit
        Left = 8
        Top = 140
        Width = 105
        Height = 21
        ReadOnly = True
        TabOrder = 0
        Visible = False
      end
      object node1NumberA: TEdit
        Left = 8
        Top = 16
        Width = 40
        Height = 21
        ReadOnly = True
        TabOrder = 1
        Visible = False
      end
      object node2NumberA: TEdit
        Left = 58
        Top = 16
        Width = 40
        Height = 21
        ReadOnly = True
        TabOrder = 2
        Visible = False
      end
      object node3NumberA: TEdit
        Left = 106
        Top = 16
        Width = 40
        Height = 21
        TabOrder = 3
        Visible = False
      end
      object res2a: TEdit
        Left = 8
        Top = 180
        Width = 105
        Height = 21
        ReadOnly = True
        TabOrder = 4
        Visible = False
      end
      object res3a: TEdit
        Left = 8
        Top = 220
        Width = 105
        Height = 21
        ReadOnly = True
        TabOrder = 5
        Visible = False
      end
      object lblResRadius: TStaticText
        Left = 8
        Top = 64
        Width = 177
        Height = 33
        AutoSize = False
        Caption = #1056#1072#1076#1080#1091#1089' '#1086#1082#1088#1091#1078#1085#1086#1089#1090#1080' '#1087#1088#1086#1093#1086#1076#1103#1097#1077#1081' '#1095#1077#1088#1077#1079' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1091#1079#1083#1099':'
        TabOrder = 6
        Visible = False
      end
      object resRadius: TEdit
        Left = 8
        Top = 96
        Width = 105
        Height = 21
        TabOrder = 7
        Visible = False
      end
    end
  end
end
