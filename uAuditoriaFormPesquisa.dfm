inherited fAuditoriaFormPesquisa: TfAuditoriaFormPesquisa
  Caption = 'Auditoria'
  ClientHeight = 421
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 16
  inherited Panel1: TPanel
    inherited btnNovo: TBitBtn
      Left = 398
      Top = 10
      Visible = False
      ExplicitLeft = 398
      ExplicitTop = 10
    end
    inherited btnAlterar: TBitBtn
      Left = 494
      Top = 10
      Visible = False
      ExplicitLeft = 494
      ExplicitTop = 10
    end
    inherited BitBtn3: TBitBtn
      AlignWithMargins = True
      Left = 108
      Top = 7
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alLeft
      ExplicitLeft = 108
      ExplicitTop = 7
    end
    inherited btnVisualizar: TBitBtn
      Left = 590
      Top = 10
      Visible = False
      ExplicitLeft = 590
      ExplicitTop = 10
    end
    inherited pnlModulo: TPanel
      Left = 635
      Width = 148
      Visible = False
      ExplicitLeft = 635
      ExplicitWidth = 148
      inherited Image1: TImage
        Left = 10
        ExplicitLeft = -10
      end
      inherited Label1: TLabel
        Left = 45
        Width = 96
        Caption = 'Auditoria'
        ExplicitLeft = 25
        ExplicitWidth = 96
      end
    end
    object btnImprimir: TBitBtn
      AlignWithMargins = True
      Left = 10
      Top = 7
      Width = 92
      Height = 30
      Margins.Left = 10
      Margins.Top = 7
      Margins.Bottom = 7
      Align = alLeft
      Caption = 'Imprimir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8C8D8DBBBBB7C7B2A1FDF3E8DAD2CBC4BD
        B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5656567676765958584A4A4A979898D4
        CCBFECC5A6ECC5A6F3D6BFF5E0CEEED4BFF5E5D9EADDD1FFFFFFFFFFFF565656
        989899B9B9B9B9B9B9B2B2B26E6C6A93765EBE9575D3A580DAA073D99968ECC5
        A6EBD9C7ADAEADFFFFFFFFFFFF979898AEAFB0D4D5D4D4D5D4CDCECEC8CAC9C1
        C2C2A0A0A0938F8A90867D9987788D78657A7C7BFFFFFFFFFFFFFFFFFFBEC2C1
        C1C2C2ECEDEDE6E8E8DDDEDE6867686E6C6A8C8D8DCDCECEC1C2C2C1C2C2B2B2
        B25DA15A7D847CFFFFFFFFFFFFCDCECEE6E8E8F3F4F4F3F4F4C1C2C2615F6059
        58585957584A4A4A5656567F7F7FD4D5D4BDCEBE959A95FFFFFFFFFFFFC8CAC9
        E0E1E1E5E6E6E5E6E67F7F7F7676767676766E6C6A6E6C6A6E6C6A6E6C6AE6E8
        E8E5E6E6A0A0A0FFFFFFFFFFFFFFFFFFA7A8A8B7B8B87A7C7B6261626261626E
        6C6A6E6C6A706F6F706F6FADAEADF3F4F4ECEDEDFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFE2C2A8E2C2A8C0A8949B8B7E766E685957585957587A7C7BDDDEDEECED
        EDA7A8A8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9DCC4FEE3CDFEE0C6F9DCC4FE
        DABBF5D2B4B3A194B9B9B9B2B2B2ADAEADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        E6C2A7FDF3E8FEF1E5FEEDDEFEE9D7FEE5D0F3D6BFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9CCB5F7EBE1FEFBF8FEF9F4FDF3E8FD
        F3E8F3D6BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFD8C7FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 5
      OnClick = btnImprimirClick
    end
  end
  inherited Panel2: TPanel
    Top = 265
    Height = 156
    ExplicitTop = 265
    ExplicitHeight = 156
    inherited Label3: TLabel
      Left = 622
      Top = 14
      Visible = False
      ExplicitLeft = 622
      ExplicitTop = 14
    end
    inherited Label4: TLabel
      Left = 624
      Top = 36
      Visible = False
      ExplicitLeft = 624
      ExplicitTop = 36
    end
    object lblDataIni: TLabel [2]
      Left = 173
      Top = 6
      Width = 59
      Height = 16
      Caption = 'Data in'#237'cio'
    end
    object lblDataFim: TLabel [3]
      Left = 281
      Top = 8
      Width = 48
      Height = 16
      Caption = 'Data fim'
    end
    object lblHoraIni: TLabel [4]
      Left = 390
      Top = 8
      Width = 60
      Height = 16
      Caption = 'Hora in'#237'cio'
    end
    object lblHoraFim: TLabel [5]
      Left = 490
      Top = 8
      Width = 49
      Height = 16
      Caption = 'Hora fim'
    end
    object lblUsuarioId: TLabel [6]
      Left = 12
      Top = 56
      Width = 59
      Height = 16
      Caption = 'Usu'#225'rio ID'
    end
    object lblUsuarioNome: TLabel [7]
      Left = 172
      Top = 56
      Width = 43
      Height = 16
      Caption = 'Usu'#225'rio'
    end
    object lblTela: TLabel [8]
      Left = 432
      Top = 56
      Width = 41
      Height = 16
      Caption = 'Modulo'
    end
    object lblOperacao: TLabel [9]
      Left = 12
      Top = 104
      Width = 38
      Height = 16
      Caption = 'Evento'
    end
    object lblNarrativa: TLabel [10]
      Left = 172
      Top = 104
      Width = 120
      Height = 16
      Caption = 'Narrativa / Descri'#231#227'o'
    end
    object lblOrdenacao: TLabel [11]
      Left = 612
      Top = 104
      Width = 70
      Height = 16
      Caption = 'Ordenar por'
    end
    inherited pnlFiltro: TPanel
      Height = 152
      ExplicitHeight = 152
    end
    inherited cbFiltro: TComboBoxDN
      Left = 650
      Top = 22
      Width = 34
      Visible = False
      Items.Strings = (
        'Usu'#225'rio ID'
        'Usu'#225'rio Nome')
      Values.Strings = (
        'usuario_id'
        'usuario_nome')
      ExplicitLeft = 650
      ExplicitTop = 22
      ExplicitWidth = 34
    end
    inherited edFiltro: TEdit
      Left = 657
      Top = 36
      Width = 27
      Visible = False
      ExplicitLeft = 657
      ExplicitTop = 36
      ExplicitWidth = 27
    end
    object edtDataIni: TJvDateEdit
      Left = 173
      Top = 24
      Width = 99
      Height = 24
      ShowNullDate = False
      TabOrder = 3
    end
    object edtDataFim: TJvDateEdit
      Left = 281
      Top = 24
      Width = 99
      Height = 24
      ShowNullDate = False
      TabOrder = 4
    end
    object edtHoraIni: TMaskEdit
      Left = 390
      Top = 24
      Width = 90
      Height = 24
      EditMask = '!99:99:99;1;_'
      MaxLength = 8
      TabOrder = 5
      Text = '00:00:00'
      OnExit = edtHoraIniExit
    end
    object edtHoraFim: TMaskEdit
      Left = 490
      Top = 24
      Width = 90
      Height = 24
      EditMask = '!99:99:99;1;_'
      MaxLength = 8
      TabOrder = 6
      Text = '23:59:59'
      OnExit = edtHoraIniExit
    end
    object edtUsuarioId: TEdit
      Left = 12
      Top = 72
      Width = 150
      Height = 24
      TabOrder = 7
    end
    object edtUsuarioNome: TEdit
      Left = 172
      Top = 72
      Width = 250
      Height = 24
      TabOrder = 8
    end
    object edtModulo: TEdit
      Left = 432
      Top = 72
      Width = 343
      Height = 24
      TabOrder = 9
    end
    object edtEvento: TEdit
      Left = 12
      Top = 120
      Width = 150
      Height = 24
      TabOrder = 10
    end
    object edtNarrativa: TEdit
      Left = 172
      Top = 120
      Width = 430
      Height = 24
      TabOrder = 11
    end
    object cbOrdenacao: TComboBoxDN
      Left = 612
      Top = 120
      Width = 163
      Height = 24
      Style = csDropDownList
      TabOrder = 12
      Items.Strings = (
        'Data (mais recente)'
        'Data (mais antiga)'
        'Hora'
        'Usu'#225'rio (Nome)'
        'Usu'#225'rio (ID)')
    end
    object btnVisualizarCargo: TBitBtn
      Tag = 1
      Left = 12
      Top = 19
      Width = 150
      Height = 29
      Caption = ' Filtrar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        333333773337777333333078F8F87033333337F3333337F33333778F8F8F8773
        333337333333373F333307F8F8F8F70333337F33FFFFF37F3333078F8F8F8703
        33337F377777337F333307F8F8F8F703333373F3333333733333778F8F8F8773
        333337F3333337F333333078F8F870333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      NumGlyphs = 2
      TabOrder = 13
      OnClick = btnVisualizarCargoClick
    end
  end
  inherited DBGrid1: TJvDbGridZebrado
    Top = 48
    Width = 475
    Height = 217
    Align = alClient
    DataSource = dmDados.dsCp_Auditoria
    Columns = <
      item
        Expanded = False
        FieldName = 'datahora_acao'
        Title.Caption = 'Data/Hora'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'usuario_nome'
        Title.Caption = 'Usu'#225'rio'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'evento'
        Title.Caption = 'Evento'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'modulo'
        Title.Caption = 'M'#243'dulo'
        Width = 150
        Visible = True
      end>
  end
  object pnContainerDescricao: TPanel
    AlignWithMargins = True
    Left = 475
    Top = 48
    Width = 312
    Height = 217
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alRight
    TabOrder = 3
    object Label5: TLabel
      Left = 1
      Top = 1
      Width = 310
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = 'Resumo do Evento'
      ExplicitWidth = 106
    end
    object DBRichEdit1: TDBRichEdit
      Left = 1
      Top = 17
      Width = 310
      Height = 199
      Align = alClient
      DataField = 'narrativa'
      DataSource = dmDados.dsCp_Auditoria
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      Zoom = 100
    end
  end
end
