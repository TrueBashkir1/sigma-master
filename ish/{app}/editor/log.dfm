object logForm: TlogForm
  Left = 234
  Top = 172
  Width = 584
  Height = 296
  Caption = 'logForm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMinimized
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 228
    Width = 576
    Height = 41
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 0
    object Button1: TButton
      Left = 240
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 576
    Height = 228
    Align = alClient
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
end
