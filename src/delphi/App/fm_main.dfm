object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 299
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Database'
      ExplicitLeft = 8
      ExplicitTop = 28
      object PageControl2: TPageControl
        Left = 0
        Top = 41
        Width = 627
        Height = 230
        ActivePage = TabSheet2
        Align = alClient
        TabOrder = 0
        object TabSheet2: TTabSheet
          Caption = 'Fiun'#231#245'es'
          object lblTesteHora: TLabel
            Left = 175
            Top = 67
            Width = 94
            Height = 23
            Caption = 'hh:mm:ss'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTesteData: TLabel
            Left = 175
            Top = 36
            Width = 133
            Height = 23
            Caption = 'dd:/mm/yyyy'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblTesteDataHora: TLabel
            Left = 175
            Top = 5
            Width = 215
            Height = 23
            Caption = 'dd/mm/yyy hh:mm:ss'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Button2: TButton
            Left = 3
            Top = 3
            Width = 166
            Height = 25
            Caption = 'Data e Hora'
            TabOrder = 0
            OnClick = Button2Click
          end
          object Button3: TButton
            Left = 3
            Top = 34
            Width = 166
            Height = 25
            Caption = 'Data'
            TabOrder = 1
            OnClick = Button3Click
          end
          object Button4: TButton
            Left = 3
            Top = 65
            Width = 166
            Height = 25
            Caption = 'Hora'
            TabOrder = 2
            OnClick = Button4Click
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 627
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = -5
        object Button1: TButton
          Left = 3
          Top = 8
          Width = 113
          Height = 25
          Caption = 'Connect DB'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
  end
end
