object FormSettings: TFormSettings
  Left = 600
  Top = 88
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 600
  ClientWidth = 270
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 270
    Height = 716
    ActivePage = TabSheet2
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object TabSheet2: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 262
        Height = 95
        Align = alTop
        Caption = #1052#1072#1089#1096#1090#1072#1073
        TabOrder = 0
        object Label4: TLabel
          Left = 10
          Top = 68
          Width = 83
          Height = 13
          Caption = #1059#1074#1077#1083#1080#1095#1077#1085#1080#1077' '#1074
        end
        object LabelScale: TLabel
          Left = 2
          Top = 15
          Width = 258
          Height = 13
          Align = alTop
          Alignment = taCenter
        end
        object TrackBar1: TTrackBar
          Left = 2
          Top = 28
          Width = 258
          Height = 40
          Align = alTop
          Max = 200
          Frequency = 10
          Position = 100
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
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1056#1072#1089#1095#1077#1090' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1081
      ImageIndex = 1
      object GroupBox7: TGroupBox
        Left = 0
        Top = 0
        Width = 262
        Height = 81
        Align = alTop
        TabOrder = 0
        DesignSize = (
          262
          81)
        object btnClosePanelCalc: TButton
          Left = 8
          Top = 16
          Width = 0
          Height = 25
          Anchors = [akLeft, akTop, akRight]
          Caption = #1057#1082#1088#1099#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1088#1072#1089#1089#1095#1077#1090#1072
          TabOrder = 0
        end
        object btnCalcLinear: TButton
          Left = 16
          Top = 48
          Width = 241
          Height = 25
          Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1087#1086' '#1087#1088#1103#1084#1086#1081
          TabOrder = 1
          OnClick = btnCalcLinearClick
        end
        object btnCalcArcLength: TButton
          Left = 16
          Top = 16
          Width = 241
          Height = 25
          Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1088#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1087#1086' '#1076#1091#1075#1077
          TabOrder = 2
          OnClick = btnCalcArcLengthClick
        end
      end
      object pnlLinear: TGroupBox
        Left = 0
        Top = 81
        Width = 262
        Height = 144
        Align = alTop
        Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1087#1086' '#1087#1088#1103#1084#1086#1081
        TabOrder = 1
        Visible = False
        object lblNode1l: TLabel
          Left = 16
          Top = 22
          Width = 46
          Height = 13
          Caption = #1059#1079#1077#1083' 1:'
          Visible = False
        end
        object lblNode2l: TLabel
          Left = 16
          Top = 52
          Width = 46
          Height = 13
          Caption = #1059#1079#1077#1083' 2:'
          Visible = False
        end
        object lblResLinear: TLabel
          Left = 8
          Top = 76
          Width = 164
          Height = 13
          Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080':'
          Visible = False
        end
        object lblNote: TLabel
          Left = 8
          Top = 120
          Width = 250
          Height = 13
          Caption = #1042#1099#1073#1077#1088#1080#1090#1077' 2 '#1091#1079#1083#1072' '#1075#1077#1086#1084#1077#1090#1088#1080#1095#1077#1089#1082#1086#1081' '#1084#1086#1076#1077#1083#1080
          Visible = False
        end
        object resLinear: TEdit
          Left = 8
          Top = 92
          Width = 209
          Height = 21
          ReadOnly = True
          TabOrder = 0
          Visible = False
        end
        object node1Number: TEdit
          Left = 72
          Top = 16
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 1
          Visible = False
        end
        object node2Number: TEdit
          Left = 72
          Top = 48
          Width = 41
          Height = 21
          ReadOnly = True
          TabOrder = 2
          Visible = False
        end
      end
      object pnlArc: TGroupBox
        Left = 0
        Top = 225
        Width = 262
        Height = 352
        Align = alTop
        Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1087#1086' '#1076#1091#1075#1077
        TabOrder = 2
        Visible = False
        object lblNode1a: TLabel
          Left = 16
          Top = 22
          Width = 46
          Height = 13
          Caption = #1059#1079#1077#1083' 1:'
          Visible = False
        end
        object lblNode2a: TLabel
          Left = 16
          Top = 44
          Width = 46
          Height = 13
          Caption = #1059#1079#1077#1083' 2:'
          Visible = False
        end
        object lblResA1: TLabel
          Left = 8
          Top = 180
          Width = 186
          Height = 13
          Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080' 1-2:'
          Visible = False
        end
        object lblNoteA: TLabel
          Left = 8
          Top = 312
          Width = 250
          Height = 13
          Caption = #1042#1099#1073#1077#1088#1080#1090#1077' 3 '#1091#1079#1083#1072' '#1075#1077#1086#1084#1077#1090#1088#1080#1095#1077#1089#1082#1086#1081' '#1084#1086#1076#1077#1083#1080
          Visible = False
        end
        object lblNode3a: TLabel
          Left = 16
          Top = 72
          Width = 46
          Height = 13
          Caption = #1059#1079#1077#1083' 3:'
          Visible = False
        end
        object lblResA2: TLabel
          Left = 8
          Top = 228
          Width = 186
          Height = 13
          Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080' 2-3:'
          Visible = False
        end
        object lblResA3: TLabel
          Left = 8
          Top = 268
          Width = 186
          Height = 13
          Caption = #1056#1072#1089#1089#1090#1086#1103#1085#1080#1077' '#1084#1077#1078#1076#1091' '#1091#1079#1083#1072#1084#1080' 1-3:'
          Visible = False
        end
        object res1a: TEdit
          Left = 8
          Top = 204
          Width = 209
          Height = 21
          ReadOnly = True
          TabOrder = 0
          Visible = False
        end
        object node1NumberA: TEdit
          Left = 72
          Top = 16
          Width = 40
          Height = 21
          ReadOnly = True
          TabOrder = 1
          Visible = False
        end
        object node2NumberA: TEdit
          Left = 72
          Top = 40
          Width = 40
          Height = 21
          ReadOnly = True
          TabOrder = 2
          Visible = False
        end
        object node3NumberA: TEdit
          Left = 73
          Top = 64
          Width = 40
          Height = 21
          TabOrder = 3
          Visible = False
        end
        object res2a: TEdit
          Left = 8
          Top = 244
          Width = 209
          Height = 21
          ReadOnly = True
          TabOrder = 4
          Visible = False
        end
        object res3a: TEdit
          Left = 8
          Top = 284
          Width = 209
          Height = 21
          ReadOnly = True
          TabOrder = 5
          Visible = False
        end
        object lblResRadius: TStaticText
          Left = 8
          Top = 96
          Width = 208
          Height = 49
          AutoSize = False
          Caption = #1056#1072#1076#1080#1091#1089' '#1086#1082#1088#1091#1078#1085#1086#1089#1090#1080' '#1087#1088#1086#1093#1086#1076#1103#1097#1077#1081' '#1095#1077#1088#1077#1079' '#1074#1099#1073#1088#1072#1085#1085#1099#1077' '#1091#1079#1083#1099':'
          TabOrder = 6
          Visible = False
        end
        object resRadius: TEdit
          Left = 8
          Top = 144
          Width = 209
          Height = 21
          TabOrder = 7
          Visible = False
        end
      end
    end
  end
end
