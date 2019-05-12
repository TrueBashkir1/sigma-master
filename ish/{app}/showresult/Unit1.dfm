object Form1: TForm1
  Left = 885
  Top = 0
  Width = 488
  Height = 735
  Caption = 'Sigma 7.4 - '#1055#1072#1088#1072#1084#1077#1090#1088#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 472
    Height = 696
    VertScrollBar.Position = 31
    Align = alClient
    BevelOuter = bvRaised
    BevelKind = bkSoft
    BorderStyle = bsNone
    Constraints.MinWidth = 350
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 0
      Top = -31
      Width = 451
      Height = 73
      Align = alTop
      Caption = #1052#1072#1089#1096#1090#1072#1073' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object LabelScale: TLabel
        Left = 2
        Top = 15
        Width = 447
        Height = 13
        Align = alTop
        Alignment = taCenter
        Caption = 'LabelScale'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object TrackBar1: TTrackBar
        Left = 2
        Top = 28
        Width = 447
        Height = 37
        Align = alTop
        Max = 20
        Position = 10
        TabOrder = 0
        OnChange = TrackBar1Change
      end
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 298
      Width = 451
      Height = 420
      ActivePage = TabSheet1
      Align = alTop
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object TabSheet1: TTabSheet
        BorderWidth = 3
        Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        object GroupBox9: TGroupBox
          Left = 0
          Top = 0
          Width = 437
          Height = 177
          Align = alTop
          Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1099' '#1090#1086#1095#1082#1080' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label17: TLabel
            Left = 8
            Top = 144
            Width = 101
            Height = 13
            Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1087#1086' Y:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label16: TLabel
            Left = 8
            Top = 118
            Width = 101
            Height = 13
            Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077' '#1087#1086' X:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label27: TLabel
            Left = 9
            Top = 24
            Width = 10
            Height = 13
            Caption = 'X:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label28: TLabel
            Left = 9
            Top = 48
            Width = 10
            Height = 13
            Caption = 'Y:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label30: TLabel
            Left = 8
            Top = 96
            Width = 54
            Height = 13
            Hint = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' X'
            Caption = #1053#1086#1084#1077#1088' '#1050#1069':'
            ParentShowHint = False
            ShowHint = True
          end
          object Label31: TLabel
            Left = 245
            Top = 52
            Width = 38
            Height = 13
            Caption = 'Label31'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object CurElemNum: TLabel
            Left = 72
            Top = 96
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object InfoMoveX: TLabel
            Left = 128
            Top = 118
            Width = 92
            Height = 13
            Caption = #1058#1086#1095#1082#1072' '#1085#1077' '#1074#1099#1073#1088#1072#1085#1072
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object InfoMoveY: TLabel
            Left = 128
            Top = 144
            Width = 3
            Height = 13
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label26: TLabel
            Left = 245
            Top = 24
            Width = 63
            Height = 13
            Hint = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' X'
            Caption = #1053#1086#1084#1077#1088' '#1091#1079#1083#1072':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
          end
          object EditMoveX: TEdit
            Left = 22
            Top = 21
            Width = 98
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = EditMoveXChange
          end
          object EditMoveY: TEdit
            Left = 22
            Top = 46
            Width = 98
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnChange = EditMoveYChange
          end
          object NodeEditInput: TEdit
            Left = 320
            Top = 22
            Width = 98
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnChange = NodeEditInputChange
          end
        end
        object GroupBox4: TGroupBox
          Left = 0
          Top = 177
          Width = 437
          Height = 80
          Align = alTop
          Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1103' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object Mover: TTrackBar
            Left = 2
            Top = 15
            Width = 433
            Height = 34
            Align = alTop
            Max = 100
            TabOrder = 0
            OnChange = MoverChange
          end
          object Panel5: TPanel
            Left = 2
            Top = 49
            Width = 433
            Height = 29
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            object Label8: TLabel
              Left = 8
              Top = 6
              Width = 73
              Height = 13
              Hint = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090
              Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
            end
            object EditMover: TEdit
              Left = 91
              Top = 3
              Width = 75
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Text = '1'
              OnChange = EditMoverChange
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        BorderWidth = 3
        Caption = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1103
        ImageIndex = 1
        object StressType: TRadioGroup
          Left = 0
          Top = 0
          Width = 437
          Height = 80
          Align = alTop
          Caption = #1058#1080#1087' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1081' '
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' X'
            #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' Y'
            #1050#1072#1089#1072#1090#1077#1083#1100#1085#1086#1077
            '1-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077
            '2-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077
            #1069#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1086#1077
            #1059#1075#1086#1083' '#1085#1072#1082#1083#1086#1085#1072' '#1082' '#1086#1089#1080' '#1061' '#1074#1077#1082#1090#1086#1088#1072' 2-'#1075#1086' '#1075#1083'. '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103)
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = StressTypeClick
        end
        object GroupBox8: TGroupBox
          Left = 0
          Top = 80
          Width = 437
          Height = 305
          Align = alTop
          Caption = #1052#1077#1090#1086#1076' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' '#1074' '#1090#1086#1095#1082#1077' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object Panel9: TPanel
            Left = 2
            Top = 15
            Width = 433
            Height = 288
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object Edit1: TEdit
              Left = 80
              Top = 32
              Width = 80
              Height = 21
              TabOrder = 0
              Text = 'Edit1'
            end
            object Panel1: TPanel
              Left = 329
              Top = 91
              Width = 104
              Height = 197
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
              object InfoFiniteElementNumber: TEdit
                Left = 0
                Top = 8
                Width = 89
                Height = 21
                TabOrder = 0
                OnKeyDown = InfoFiniteElementNumberKeyDown
              end
            end
            object Panel6: TPanel
              Left = 0
              Top = 0
              Width = 433
              Height = 91
              Align = alTop
              BevelOuter = bvNone
              TabOrder = 2
              object Label10: TLabel
                Left = 9
                Top = 48
                Width = 10
                Height = 13
                Caption = 'X:'
              end
              object Label11: TLabel
                Left = 9
                Top = 72
                Width = 10
                Height = 13
                Caption = 'Y:'
              end
              object Label25: TLabel
                Left = 8
                Top = 26
                Width = 96
                Height = 13
                Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1099' '#1090#1086#1095#1082#1080':'
              end
              object Label32: TLabel
                Left = 232
                Top = 72
                Width = 38
                Height = 13
                Caption = 'Label32'
              end
              object LabelMaxZnach: TLabel
                Left = 232
                Top = 16
                Width = 102
                Height = 13
                Caption = #1050#1069' '#1084#1072#1082#1089'.'#1087#1086' '#1085#1072#1087#1088#1103#1078':'
              end
              object LabelMinZhach: TLabel
                Left = 232
                Top = 40
                Width = 99
                Height = 13
                Caption = #1050#1069' '#1084#1080#1085'. '#1087#1086' '#1085#1072#1087#1088#1103#1078':'
              end
              object KonElNumMaxNapr: TLabel
                Left = 336
                Top = 16
                Width = 93
                Height = 13
                Caption = 'KonElNumMaxNapr'
              end
              object KonElNumMinNapr: TLabel
                Left = 336
                Top = 40
                Width = 90
                Height = 13
                Caption = 'KonElNumMinNapr'
              end
              object EditX: TEdit
                Left = 22
                Top = 45
                Width = 98
                Height = 21
                TabOrder = 0
                OnChange = EditXChange
              end
              object EditY: TEdit
                Left = 22
                Top = 70
                Width = 98
                Height = 21
                TabOrder = 1
                OnChange = EditYChange
              end
              object StressMethod1: TRadioButton
                Left = 8
                Top = 5
                Width = 49
                Height = 16
                Caption = #1062#1055#1057
                Checked = True
                TabOrder = 2
                TabStop = True
                OnClick = StressMethod1Click
              end
              object StressMethod2: TRadioButton
                Left = 80
                Top = 5
                Width = 57
                Height = 15
                Caption = #1062#1052
                TabOrder = 3
                OnClick = StressMethod2Click
              end
              object StressMethod3: TRadioButton
                Left = 152
                Top = 5
                Width = 49
                Height = 15
                Caption = #1050#1069
                TabOrder = 4
                OnClick = StressMethod3Click
              end
            end
            object Panel7: TPanel
              Left = 0
              Top = 91
              Width = 329
              Height = 197
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 3
              object Label2: TLabel
                Left = 5
                Top = 31
                Width = 27
                Height = 13
                Hint = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' X'
                Caption = #1055#1086' X:'
                ParentShowHint = False
                ShowHint = True
              end
              object Label3: TLabel
                Left = 5
                Top = 55
                Width = 27
                Height = 13
                Hint = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' Y'
                Caption = #1055#1086' Y:'
                ParentShowHint = False
                ShowHint = True
              end
              object Label4: TLabel
                Left = 5
                Top = 80
                Width = 69
                Height = 13
                Hint = #1050#1072#1089#1072#1090#1077#1083#1100#1085#1086#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1077
                Caption = #1050#1072#1089#1072#1090#1077#1083#1100#1085#1086#1077':'
                ParentShowHint = False
                ShowHint = True
              end
              object Label5: TLabel
                Left = 5
                Top = 104
                Width = 68
                Height = 13
                Hint = '1-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1077
                Caption = '1-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077':'
                ParentShowHint = False
                ShowHint = True
              end
              object Label6: TLabel
                Left = 5
                Top = 129
                Width = 68
                Height = 13
                Hint = '2-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1077
                Caption = '2-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077':'
                ParentShowHint = False
                ShowHint = True
              end
              object Label7: TLabel
                Left = 5
                Top = 152
                Width = 67
                Height = 13
                Hint = #1059#1075#1086#1083
                Caption = #1069#1082#1074#1080#1074#1072#1083'-'#1085#1086#1077':'
                ParentShowHint = False
                ShowHint = True
              end
              object Label12: TLabel
                Left = 5
                Top = 172
                Width = 28
                Height = 13
                Hint = #1059#1075#1086#1083
                Caption = #1059#1075#1086#1083':'
                ParentShowHint = False
                ShowHint = True
              end
              object Label13: TLabel
                Left = 5
                Top = 8
                Width = 54
                Height = 13
                Hint = #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' X'
                Caption = #1053#1086#1084#1077#1088' '#1050#1069':'
                ParentShowHint = False
                ShowHint = True
              end
              object InfoX1: TLabel
                Left = 160
                Top = 32
                Width = 3
                Height = 13
              end
              object InfoY1: TLabel
                Left = 160
                Top = 56
                Width = 3
                Height = 13
              end
              object InfoXY1: TLabel
                Left = 160
                Top = 80
                Width = 3
                Height = 13
              end
              object InfoMax1: TLabel
                Left = 160
                Top = 104
                Width = 3
                Height = 13
              end
              object InfoMin1: TLabel
                Left = 160
                Top = 128
                Width = 3
                Height = 13
              end
              object InfoEcv1: TLabel
                Left = 160
                Top = 152
                Width = 3
                Height = 13
              end
              object InfoConer1: TLabel
                Left = 160
                Top = 176
                Width = 3
                Height = 13
              end
            end
          end
        end
      end
      object TabSheet3: TTabSheet
        BorderWidth = 3
        Caption = #1057#1080#1083#1099
        ImageIndex = 2
        object Label21: TLabel
          Left = 0
          Top = 320
          Width = 87
          Height = 13
          Caption = #1057#1091#1084#1084#1072' '#1089#1080#1083' '#1087#1086':'
        end
        object Label22: TLabel
          Left = 0
          Top = 344
          Width = 9
          Height = 13
          Caption = 'X'
        end
        object Label23: TLabel
          Left = 88
          Top = 344
          Width = 9
          Height = 13
          Caption = 'Y'
        end
        object Label29: TLabel
          Left = 184
          Top = 344
          Width = 53
          Height = 13
          Caption = #1056#1077#1079#1091#1083#1100#1090'.'
        end
        object GroupBox5: TGroupBox
          Left = 0
          Top = 0
          Width = 366
          Height = 67
          Align = alTop
          Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1074#1077#1082#1090#1086#1088#1072' '#1089#1080#1083#1099' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label9: TLabel
            Left = 8
            Top = 46
            Width = 73
            Height = 13
            Hint = #1044#1083#1080#1085#1072' '#1086#1076#1085#1086#1081' '#1077#1076#1080#1085#1080#1094#1099' '#1089#1080#1083#1099' ('#1074' '#1077#1076#1080#1085#1080#1094#1099#1093' '#1076#1083#1080#1085#1099')'
            Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090':'
            ParentShowHint = False
            ShowHint = True
          end
          object EditForce: TEdit
            Left = 88
            Top = 42
            Width = 81
            Height = 21
            TabOrder = 0
            Text = '100'
            OnChange = EditForceChange
          end
          object ForceTrackBar: TTrackBar
            Left = 2
            Top = 15
            Width = 362
            Height = 25
            Align = alTop
            Max = 7
            Min = 1
            Position = 4
            TabOrder = 1
            OnChange = ForceTrackBarChange
          end
        end
        object GroupBox7: TGroupBox
          Left = 0
          Top = 67
          Width = 366
          Height = 246
          Align = alTop
          Caption = #1055#1088#1080#1083#1086#1078#1077#1085#1085#1099#1077' '#1089#1080#1083#1099' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object StringGrid1: TStringGrid
            Left = 2
            Top = 15
            Width = 362
            Height = 229
            Align = alClient
            ColCount = 6
            DefaultColWidth = 36
            DefaultRowHeight = 18
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goTabs]
            TabOrder = 0
            OnClick = StringGrid1Click
            ColWidths = (
              40
              60
              60
              60
              60
              36)
            RowHeights = (
              18
              18
              18
              18
              18)
          end
        end
        object Edit2: TEdit
          Left = 16
          Top = 340
          Width = 65
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = 'Edit2'
        end
        object Edit3: TEdit
          Left = 104
          Top = 340
          Width = 65
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = 'Edit3'
        end
        object Edit7: TEdit
          Left = 240
          Top = 340
          Width = 65
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Text = 'Edit7'
        end
      end
      object TabSheet4: TTabSheet
        Caption = 'C'#1074'-'#1074#1072' '#1050#1069
        ImageIndex = 3
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 441
          Height = 249
          Caption = #1057#1074#1086#1081#1089#1090#1074#1072' '#1082#1086#1085#1077#1095#1085#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label14: TLabel
            Left = 8
            Top = 26
            Width = 54
            Height = 13
            Caption = #1053#1086#1084#1077#1088' '#1050#1069':'
          end
          object Label15: TLabel
            Left = 8
            Top = 56
            Width = 104
            Height = 13
            Caption = #1052#1086#1076#1091#1083#1100' '#1091#1087#1088#1091#1075#1086#1089#1090#1080' E:'
          end
          object Label18: TLabel
            Left = 8
            Top = 88
            Width = 145
            Height = 13
            Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090' '#1055#1091#1072#1089#1089#1086#1085#1072' '#1052#1102':'
          end
          object Label19: TLabel
            Left = 8
            Top = 120
            Width = 188
            Height = 13
            Caption = #1044#1086#1087#1091#1089#1082#1072#1077#1084#1086#1077' '#1085#1072#1087#1088'-'#1077' '#1085#1072' '#1088#1072#1089#1090#1103#1078#1077#1085#1080#1077':'
          end
          object Label20: TLabel
            Left = 8
            Top = 184
            Width = 49
            Height = 13
            Caption = #1058#1086#1083#1097#1080#1085#1072':'
          end
          object MUprug1: TLabel
            Left = 208
            Top = 56
            Width = 3
            Height = 13
          end
          object KoefPuas1: TLabel
            Left = 208
            Top = 88
            Width = 3
            Height = 13
          end
          object thickness1: TLabel
            Left = 208
            Top = 184
            Width = 3
            Height = 13
          end
          object DopNapr1: TLabel
            Left = 208
            Top = 120
            Width = 3
            Height = 13
          end
          object Label1: TLabel
            Left = 8
            Top = 152
            Width = 164
            Height = 13
            Caption = #1044#1086#1087#1091#1089#1082#1072#1077#1084#1086#1077' '#1085#1072#1087#1088'-'#1077' '#1085#1072' '#1089#1078#1072#1090#1080#1077':'
          end
          object DopNapr2: TLabel
            Left = 208
            Top = 152
            Width = 3
            Height = 13
          end
          object CaptPropNum: TLabel
            Left = 8
            Top = 216
            Width = 87
            Height = 13
            Caption = #1053#1086#1084#1077#1088' '#1089#1074#1086#1081#1089#1090#1074#1072':'
          end
          object PropNum: TLabel
            Left = 208
            Top = 216
            Width = 3
            Height = 13
          end
          object KENumber1: TEdit
            Left = 208
            Top = 24
            Width = 89
            Height = 21
            TabOrder = 0
            OnKeyDown = KENumber1KeyDown
          end
        end
      end
      object TabSheet5: TTabSheet
        Caption = #1044#1080#1072#1087#1072#1079#1086#1085#1099' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1081' '#1074' '#1079#1086#1085#1072#1093
        ImageIndex = 4
        object MaxZnachPlast: TLabel
          Left = 16
          Top = 336
          Width = 122
          Height = 13
          Caption = #1050#1069' '#1084#1072#1082#1089'. '#1079#1085#1072#1095'. '#1074' '#1087#1083#1072#1089#1090'.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object MinZnachPlast: TLabel
          Left = 248
          Top = 336
          Width = 116
          Height = 13
          Caption = #1050#1069' '#1084#1080#1085'. '#1079#1085#1072#1095'. '#1074' '#1087#1083#1072#1089#1090'.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object MaxNaprPlast: TLabel
          Left = 144
          Top = 336
          Width = 66
          Height = 13
          Caption = 'MaxNaprPlast'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object MinNaprPlast: TLabel
          Left = 368
          Top = 336
          Width = 63
          Height = 13
          Caption = 'MinNaprPlast'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object StressType1: TRadioGroup
          Left = 0
          Top = 0
          Width = 443
          Height = 80
          Align = alTop
          Caption = #1058#1080#1087' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1081' '
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' X'
            #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' Y'
            #1050#1072#1089#1072#1090#1077#1083#1100#1085#1086#1077
            '1-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077
            '2-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077
            #1069#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1086#1077
            #1059#1075#1086#1083' '#1085#1072#1082#1083#1086#1085#1072' '#1082' '#1086#1089#1080' '#1061' '#1074#1077#1082#1090#1086#1088#1072' 2-'#1075#1086' '#1075#1083'. '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103)
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = StressType1Click
        end
        object GroupBox10: TGroupBox
          Left = 0
          Top = 80
          Width = 443
          Height = 246
          Align = alTop
          Caption = #1042#1077#1088#1093#1085#1077#1077' '#1080' '#1085#1080#1078#1085#1077#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' '#1074' '#1079#1086#1085#1072#1093' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object ZoneStress: TStringGrid
            Left = 2
            Top = 15
            Width = 439
            Height = 229
            Align = alClient
            ColCount = 8
            DefaultColWidth = 36
            DefaultRowHeight = 18
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing, goTabs]
            TabOrder = 0
            ColWidths = (
              40
              40
              33
              60
              33
              60
              73
              70)
            RowHeights = (
              18
              18
              18
              18
              18)
          end
        end
      end
      object TabSheet6: TTabSheet
        Caption = #1044#1080#1072#1087#1072#1079#1086#1085#1099' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1081' '#1074' '#1089#1074#1086#1081#1089#1090#1074#1072#1093
        ImageIndex = 5
        object MaxNaprPlast1: TLabel
          Left = 144
          Top = 336
          Width = 72
          Height = 13
          Caption = 'MaxNaprPlast1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object MinNaprPlast1: TLabel
          Left = 368
          Top = 336
          Width = 69
          Height = 13
          Caption = 'MinNaprPlast1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object MaxZnachPlast2: TLabel
          Left = 16
          Top = 336
          Width = 122
          Height = 13
          Caption = #1050#1069' '#1084#1072#1082#1089'. '#1079#1085#1072#1095'. '#1074' '#1087#1083#1072#1089#1090'.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object MinZnachPlast2: TLabel
          Left = 248
          Top = 336
          Width = 116
          Height = 13
          Caption = #1050#1069' '#1084#1080#1085'. '#1079#1085#1072#1095'. '#1074' '#1087#1083#1072#1089#1090'.:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object StressType2: TRadioGroup
          Left = 0
          Top = 0
          Width = 443
          Height = 80
          Align = alTop
          Caption = #1058#1080#1087' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1081' '
          Columns = 2
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemIndex = 0
          Items.Strings = (
            #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' X'
            #1053#1072#1087#1088#1103#1078#1077#1085#1080#1077' '#1087#1086' Y'
            #1050#1072#1089#1072#1090#1077#1083#1100#1085#1086#1077
            '1-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077
            '2-'#1086#1077' '#1075#1083#1072#1074#1085#1086#1077
            #1069#1082#1074#1080#1074#1072#1083#1077#1085#1090#1085#1086#1077
            #1059#1075#1086#1083' 2-'#1075#1086' '#1075#1083'. '#1085#1072#1087'. '#1082' '#1086#1089#1080' '#1061' ')
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = StressType2Click
        end
        object GroupBox11: TGroupBox
          Left = 0
          Top = 80
          Width = 443
          Height = 246
          Align = alTop
          Caption = #1042#1077#1088#1093#1085#1077#1077' '#1080' '#1085#1080#1078#1085#1077#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' '#1074' '#1089#1074#1086#1081#1089#1090#1074#1072#1093
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object ZoneStress2: TStringGrid
            Left = 2
            Top = 15
            Width = 439
            Height = 229
            Align = alClient
            ColCount = 6
            DefaultColWidth = 36
            DefaultRowHeight = 18
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing, goTabs]
            TabOrder = 0
            ColWidths = (
              60
              40
              40
              60
              40
              60)
            RowHeights = (
              18
              18
              18
              18
              18)
          end
        end
      end
    end
    object Group4: TGroupBox
      Left = 0
      Top = 42
      Width = 451
      Height = 256
      Align = alTop
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 2
      object GroupBox3: TGroupBox
        Left = 2
        Top = 197
        Width = 447
        Height = 57
        Align = alBottom
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1094#1074#1077#1090#1086#1074#1099#1093' '#1075#1088#1072#1076#1072#1094#1080#1081
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        object LevelNumber: TLabel
          Left = 2
          Top = 42
          Width = 443
          Height = 13
          Align = alBottom
          Alignment = taCenter
          Caption = '4'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ChangeLegend: TTrackBar
          Left = 2
          Top = 15
          Width = 443
          Height = 27
          Align = alClient
          Anchors = [akLeft, akRight, akBottom]
          Max = 255
          Min = 4
          ParentShowHint = False
          Position = 4
          ShowHint = True
          TabOrder = 0
          OnChange = ChangeLegendChange
        end
      end
      object UseAxes: TCheckBox
        Left = 205
        Top = 16
        Width = 139
        Height = 17
        Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1086#1089#1080' '#1082#1086#1086#1088#1076#1080#1085#1072#1090
        Caption = #1054#1089#1080' '#1082#1086#1086#1088#1076#1080#1085#1072#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = UseAxesClick
      end
      object UseNumZone: TCheckBox
        Left = 6
        Top = 94
        Width = 127
        Height = 17
        Hint = #1053#1086#1084#1077#1088#1072' '#1079#1086#1085
        Caption = #1053#1086#1084#1077#1088#1072' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = UseNumZoneClick
      end
      object UseNumNode: TCheckBox
        Left = 6
        Top = 78
        Width = 104
        Height = 17
        Hint = #1053#1086#1084#1077#1088#1072' '#1091#1079#1083#1086#1074
        Caption = #1053#1086#1084#1077#1088#1072' '#1091#1079#1083#1086#1074
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = UseNumNodeClick
      end
      object UseLines: TCheckBox
        Left = 6
        Top = 158
        Width = 139
        Height = 17
        Hint = #1051#1080#1085#1080#1080' '#1091#1088#1086#1074#1085#1103
        TabStop = False
        Caption = #1051#1080#1085#1080#1080' '#1091#1088#1086#1074#1085#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = UseLinesClick
      end
      object UseLegend: TCheckBox
        Left = 6
        Top = 31
        Width = 115
        Height = 17
        Hint = #1062#1074#1077#1090#1086#1074#1072#1103' '#1096#1082#1072#1083#1072
        Caption = #1062#1074#1077#1090#1086#1074#1072#1103' '#1096#1082#1072#1083#1072
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 5
        OnClick = UseLegendClick
      end
      object UseForce: TCheckBox
        Left = 6
        Top = 46
        Width = 98
        Height = 17
        Hint = #1053#1072#1075#1088#1091#1079#1082#1080
        Caption = #1053#1072#1075#1088#1091#1079#1082#1080
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 6
        OnClick = UseForceClick
      end
      object UseBound: TCheckBox
        Left = 6
        Top = 62
        Width = 130
        Height = 17
        Hint = #1043#1088#1072#1085#1080#1095#1085#1099#1077' '#1091#1089#1083#1086#1074#1080#1103
        Caption = #1043#1088#1072#1085#1080#1095#1085#1099#1077' '#1091#1089#1083#1086#1074#1080#1103
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 7
        OnClick = UseBoundClick
      end
      object TestElements: TCheckBox
        Left = 6
        Top = 142
        Width = 150
        Height = 17
        Hint = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1085#1072#1087#1088#1103#1078#1077#1085#1080#1103' '#1074' '#1050#1069
        Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1085#1072' '#1088#1072#1079#1088#1091#1096#1077#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        OnClick = TestElementsClick
      end
      object UseNumMater: TCheckBox
        Left = 6
        Top = 110
        Width = 127
        Height = 17
        Hint = #1053#1086#1084#1077#1088#1072' '#1089#1074#1086#1081#1089#1090#1074' '#1050#1069
        Caption = #1053#1086#1084#1077#1088#1072' '#1089#1074#1086#1081#1089#1090#1074' '#1050#1069
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        OnClick = UseNumMaterClick
      end
      object CheckBox1: TCheckBox
        Left = 6
        Top = 174
        Width = 81
        Height = 17
        TabStop = False
        Caption = #1047#1086#1085#1072' '#1085#1091#1083#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 6
        Top = 127
        Width = 211
        Height = 17
        Hint = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '#1094#1074#1077#1090#1086#1084
        Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1089#1074#1086#1081#1089#1090#1074' '#1094#1074#1077#1090#1086#1084
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = CheckBox2Click
      end
      object ZoneCheckBox: TCheckBox
        Left = 6
        Top = 17
        Width = 59
        Height = 17
        Hint = #1055#1086#1082#1072#1079#1072#1090#1100' '#1080#1089#1093#1086#1076#1085#1086#1077' '#1088#1072#1079#1073#1080#1077#1085#1080#1077
        Caption = #1047#1086#1085#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 12
        OnClick = ZoneCheckBoxClick
      end
      object CheckBoxZonesNum: TCheckBox
        Left = 101
        Top = 16
        Width = 100
        Height = 17
        Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1086#1084#1077#1088#1072' '#1079#1086#1085' '
        Caption = #1053#1086#1084#1077#1088#1072' '#1079#1086#1085
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
        OnClick = CheckBoxZonesNumClick
      end
      object GroupBox12: TGroupBox
        Left = 232
        Top = 40
        Width = 193
        Height = 144
        Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103
        TabOrder = 14
        object Label36: TLabel
          Left = 8
          Top = 36
          Width = 62
          Height = 13
          Caption = #1063#1080#1089#1083#1086' '#1079#1086#1085' ='
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object PropNumLbl: TLabel
          Left = 112
          Top = 52
          Width = 23
          Height = 13
          Caption = '(20)'
        end
        object NodesNumLbl: TLabel
          Left = 112
          Top = 84
          Width = 23
          Height = 13
          Caption = '(20)'
        end
        object Label35: TLabel
          Left = 8
          Top = 52
          Width = 88
          Height = 13
          Caption = #1063#1080#1089#1083#1086' '#1089#1074#1086#1081#1089#1090#1074' = '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label34: TLabel
          Left = 8
          Top = 68
          Width = 102
          Height = 13
          Caption = #1063#1080#1089#1083#1086' '#1101#1083#1077#1084#1077#1085#1090#1086#1074' = '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label33: TLabel
          Left = 8
          Top = 84
          Width = 76
          Height = 13
          Caption = #1063#1080#1089#1083#1086' '#1091#1079#1083#1086#1074' = '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ElemNumLbl: TLabel
          Left = 112
          Top = 68
          Width = 23
          Height = 13
          Caption = '(20)'
        end
        object ZonesNumLbl: TLabel
          Left = 112
          Top = 36
          Width = 23
          Height = 13
          Caption = '(20)'
        end
        object Label37: TLabel
          Left = 8
          Top = 100
          Width = 35
          Height = 13
          Caption = 'NRC = '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object NRCNum: TLabel
          Left = 112
          Top = 100
          Width = 23
          Height = 13
          Caption = '(20)'
        end
        object Label38: TLabel
          Left = 8
          Top = 20
          Width = 71
          Height = 13
          Caption = #1056#1072#1079#1084#1077#1088#1085#1086#1089#1090#1100':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object ForceLbl: TLabel
          Left = 88
          Top = 20
          Width = 23
          Height = 13
          Caption = '(20)'
        end
        object DimLbl: TLabel
          Left = 144
          Top = 20
          Width = 23
          Height = 13
          Caption = '(20)'
        end
        object Label24: TLabel
          Left = 136
          Top = 20
          Width = 5
          Height = 13
          Caption = ','
        end
        object Label39: TLabel
          Left = 8
          Top = 120
          Width = 46
          Height = 13
          Caption = 'Label39'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
end
