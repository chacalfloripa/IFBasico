object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 548
  ClientWidth = 1136
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1136
    Height = 548
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Database'
      object PageControl2: TPageControl
        Left = 0
        Top = 41
        Width = 1128
        Height = 479
        ActivePage = TabSheet2
        Align = alClient
        TabOrder = 0
        object TabSheet2: TTabSheet
          Caption = 'Fiun'#231#245'es'
          ExplicitLeft = 3
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
        object TabSheet3: TTabSheet
          Caption = 'Estrutura de Dados'
          ImageIndex = 1
          object GroupBox2: TGroupBox
            Left = 3
            Top = 167
            Width = 646
            Height = 170
            Caption = 'Testa se campo existe na tabela'
            TabOrder = 0
            object Label2: TLabel
              Left = 175
              Top = 20
              Width = 62
              Height = 13
              Caption = 'Nome Tabela'
            end
            object Label3: TLabel
              Left = 399
              Top = 20
              Width = 63
              Height = 13
              Caption = 'Nome Campo'
            end
            object Label4: TLabel
              Left = 175
              Top = 85
              Width = 91
              Height = 13
              Caption = 'Novo Nome Campo'
            end
            object Button6: TButton
              Left = 3
              Top = 21
              Width = 166
              Height = 25
              Caption = 'Existe Campo'
              TabOrder = 0
            end
            object edtExistFieldNomeTabela: TEdit
              Left = 175
              Top = 39
              Width = 218
              Height = 21
              TabOrder = 1
            end
            object dtExistFieldNomeCampo: TEdit
              Left = 399
              Top = 39
              Width = 234
              Height = 21
              TabOrder = 2
            end
            object Button7: TButton
              Left = 3
              Top = 83
              Width = 166
              Height = 45
              Caption = 'Renomar Campo'
              TabOrder = 3
            end
            object Edit1: TEdit
              Left = 175
              Top = 104
              Width = 218
              Height = 21
              TabOrder = 4
            end
            object Button10: TButton
              Left = 3
              Top = 134
              Width = 166
              Height = 25
              Caption = 'Eliminar Campo'
              TabOrder = 5
            end
            object Button12: TButton
              Left = 3
              Top = 52
              Width = 166
              Height = 25
              Caption = 'Criar Campo'
              TabOrder = 6
            end
          end
          object GroupBox1: TGroupBox
            Left = 3
            Top = 3
            Width = 406
            Height = 158
            Caption = 'Testa se tabela existe'
            TabOrder = 1
            object Label1: TLabel
              Left = 175
              Top = 16
              Width = 62
              Height = 13
              Caption = 'Nome Tabela'
            end
            object Label5: TLabel
              Left = 175
              Top = 79
              Width = 90
              Height = 13
              Caption = 'Novo Nome Tabela'
            end
            object Button5: TButton
              Left = 3
              Top = 20
              Width = 166
              Height = 25
              Caption = 'Existe Tabela'
              TabOrder = 0
              OnClick = Button5Click
            end
            object edtExistTabela: TEdit
              Left = 175
              Top = 35
              Width = 218
              Height = 21
              TabOrder = 1
            end
            object Button8: TButton
              Left = 3
              Top = 81
              Width = 166
              Height = 39
              Caption = 'Renomear tabela'
              TabOrder = 2
            end
            object Button9: TButton
              Left = 3
              Top = 126
              Width = 166
              Height = 25
              Caption = 'Eliminar Tabela'
              TabOrder = 3
            end
            object Edit2: TEdit
              Left = 175
              Top = 98
              Width = 218
              Height = 21
              TabOrder = 4
            end
            object Button11: TButton
              Left = 3
              Top = 48
              Width = 166
              Height = 25
              Caption = 'Criar Tabela'
              TabOrder = 5
              OnClick = Button11Click
            end
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1128
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
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
