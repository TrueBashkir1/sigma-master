object PluginList: TPluginList
  Left = 205
  Top = 215
  Width = 344
  Height = 204
  Caption = 'Sigma 7.4.4 - '#1053#1072#1073#1086#1088' '#1079#1072#1075#1088#1091#1078#1077#1085#1085#1099#1093' '#1084#1086#1076#1091#1083#1077#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 336
    Height = 129
    Align = alClient
    TabOrder = 0
    object ListBox1: TListBox
      Left = 8
      Top = 16
      Width = 313
      Height = 73
      ItemHeight = 13
      TabOrder = 0
      OnClick = ListBox1Click
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 96
      Width = 312
      Height = 17
      AutoSize = False
      BorderStyle = sbsSunken
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 129
    Width = 336
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 128
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
end
