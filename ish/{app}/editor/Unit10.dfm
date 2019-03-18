object Form10: TForm10
  Left = 263
  Top = 355
  Width = 227
  Height = 165
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1090#1086#1095#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 16
    Width = 100
    Height = 16
    Caption = #1053#1086#1084#1077#1088' '#1090#1086#1095#1082#1080':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ComboBox1: TComboBox
    Left = 48
    Top = 48
    Width = 113
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object OK: TButton
    Left = 8
    Top = 104
    Width = 81
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = OKClick
  end
  object Cancel: TButton
    Left = 128
    Top = 104
    Width = 81
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = CancelClick
  end
end
