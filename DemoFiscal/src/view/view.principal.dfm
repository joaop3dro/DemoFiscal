object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'DemoFiscal'
  ClientHeight = 496
  ClientWidth = 725
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object btnSimular: TButton
    AlignWithMargins = True
    Left = 3
    Top = 437
    Width = 719
    Height = 25
    Align = alBottom
    Caption = 'Gerar NFe (Exemplo da chamada da classe)'
    TabOrder = 0
    OnClick = btnSimularClick
  end
  object Button1: TButton
    AlignWithMargins = True
    Left = 3
    Top = 468
    Width = 719
    Height = 25
    Align = alBottom
    Caption = 'Imprimir (Exemplo da chamada do helper de impress'#227'o)'
    TabOrder = 1
    OnClick = Button1Click
  end
  object btnSalvar: TButton
    AlignWithMargins = True
    Left = 3
    Top = 406
    Width = 719
    Height = 25
    Align = alBottom
    Caption = 'Salvar Venda (Exemplo da chamada da classe de venda)'
    TabOrder = 2
    OnClick = btnSalvarClick
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 725
    Height = 403
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = 'Emitente'
      object Label1: TLabel
        Left = 20
        Top = 20
        Width = 30
        Height = 15
        Caption = 'CNPJ:'
      end
      object Label2: TLabel
        Left = 20
        Top = 56
        Width = 68
        Height = 15
        Caption = 'Raz'#227'o Social:'
      end
      object Label3: TLabel
        Left = 20
        Top = 92
        Width = 82
        Height = 15
        Caption = 'Nome Fantasia:'
      end
      object Label4: TLabel
        Left = 20
        Top = 128
        Width = 52
        Height = 15
        Caption = 'Endere'#231'o:'
      end
      object edCNPJ: TEdit
        Left = 100
        Top = 17
        Width = 200
        Height = 23
        TabOrder = 0
      end
      object edRazaoSocial: TEdit
        Left = 100
        Top = 53
        Width = 400
        Height = 23
        TabOrder = 1
      end
      object edNomeFantasia: TEdit
        Left = 100
        Top = 89
        Width = 400
        Height = 23
        TabOrder = 2
      end
      object edEndereco: TEdit
        Left = 100
        Top = 125
        Width = 400
        Height = 23
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Destinat'#225'rio'
      ImageIndex = 1
      object Label5: TLabel
        Left = 28
        Top = 28
        Width = 30
        Height = 15
        Caption = 'CNPJ:'
      end
      object Label6: TLabel
        Left = 28
        Top = 136
        Width = 52
        Height = 15
        Caption = 'Endere'#231'o:'
      end
      object Label7: TLabel
        Left = 28
        Top = 100
        Width = 82
        Height = 15
        Caption = 'Nome Fantasia:'
      end
      object Label8: TLabel
        Left = 28
        Top = 64
        Width = 68
        Height = 15
        Caption = 'Raz'#227'o Social:'
      end
      object edDestCNPJ: TEdit
        Left = 108
        Top = 25
        Width = 200
        Height = 23
        TabOrder = 0
      end
      object edDestRazaoSocial: TEdit
        Left = 108
        Top = 61
        Width = 400
        Height = 23
        TabOrder = 1
      end
      object edDestNomeFantasia: TEdit
        Left = 108
        Top = 97
        Width = 400
        Height = 23
        TabOrder = 2
      end
      object edDestEndereco: TEdit
        Left = 108
        Top = 133
        Width = 400
        Height = 23
        TabOrder = 3
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Produtos'
      ImageIndex = 2
      object GridProdutos: TStringGrid
        Left = 0
        Top = 0
        Width = 717
        Height = 348
        Align = alClient
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        ColWidths = (
          64
          200
          80
          80
          80)
      end
      object btnAdicionarProduto: TButton
        Left = 0
        Top = 348
        Width = 717
        Height = 25
        Align = alBottom
        Caption = 'Adicionar Produto'
        TabOrder = 1
        OnClick = btnAdicionarProdutoClick
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Totais'
      ImageIndex = 3
      object Label9: TLabel
        Left = 30
        Top = 36
        Width = 80
        Height = 15
        Caption = 'Valor Produtos:'
      end
      object Label10: TLabel
        Left = 30
        Top = 72
        Width = 58
        Height = 15
        Caption = 'Valor Frete:'
      end
      object Label11: TLabel
        Left = 30
        Top = 108
        Width = 82
        Height = 15
        Caption = 'Valor Desconto:'
      end
      object Label12: TLabel
        Left = 30
        Top = 144
        Width = 60
        Height = 15
        Caption = 'Valor ICMS:'
      end
      object Label13: TLabel
        Left = 30
        Top = 180
        Width = 45
        Height = 15
        Caption = 'Valor IPI:'
      end
      object Label14: TLabel
        Left = 30
        Top = 216
        Width = 58
        Height = 15
        Caption = 'Valor Total:'
      end
      object edValorProdutos: TEdit
        Left = 116
        Top = 33
        Width = 200
        Height = 23
        TabOrder = 0
      end
      object edValorFrete: TEdit
        Left = 116
        Top = 69
        Width = 400
        Height = 23
        TabOrder = 1
      end
      object edValorDesconto: TEdit
        Left = 116
        Top = 105
        Width = 400
        Height = 23
        TabOrder = 2
      end
      object edValorICMS: TEdit
        Left = 116
        Top = 141
        Width = 400
        Height = 23
        TabOrder = 3
      end
      object edValorIPI: TEdit
        Left = 116
        Top = 177
        Width = 400
        Height = 23
        TabOrder = 4
      end
      object edValorTotal: TEdit
        Left = 116
        Top = 213
        Width = 400
        Height = 23
        TabOrder = 5
      end
    end
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libNone
    Configuracoes.Geral.SSLCryptLib = cryNone
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.RespTec.IdCSRT = 0
    DANFE = ACBrNFeDANFEFR1
    Left = 536
    Top = 16
  end
  object ACBrNFeDANFEFR1: TACBrNFeDANFEFR
    Sistema = 'Projeto ACBr - www.projetoacbr.com.br'
    MargemInferior = 8.000000000000000000
    MargemSuperior = 8.000000000000000000
    MargemEsquerda = 6.000000000000000000
    MargemDireita = 5.100000000000000000
    ExpandeLogoMarcaConfig.Altura = 0
    ExpandeLogoMarcaConfig.Esquerda = 0
    ExpandeLogoMarcaConfig.Topo = 0
    ExpandeLogoMarcaConfig.Largura = 0
    ExpandeLogoMarcaConfig.Dimensionar = False
    ExpandeLogoMarcaConfig.Esticar = True
    CasasDecimais.Formato = tdetInteger
    CasasDecimais.qCom = 2
    CasasDecimais.vUnCom = 2
    CasasDecimais.MaskqCom = ',0.00'
    CasasDecimais.MaskvUnCom = ',0.00'
    CasasDecimais.Aliquota = 2
    CasasDecimais.MaskAliquota = ',0.00'
    ACBrNFe = ACBrNFe1
    EspessuraBorda = 1
    BorderIcon = [biSystemMenu, biMinimize, biMaximize]
    ThreadSafe = False
    Left = 637
    Top = 16
  end
end
