object frmVendaView: TfrmVendaView
  Left = 0
  Top = 0
  Caption = 'Sistema de Pedidos Venda'
  ClientHeight = 468
  ClientWidth = 1095
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPesquisaProduto: TPanel
    Left = 0
    Top = 89
    Width = 519
    Height = 379
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object lblProduto: TLabel
      Left = 4
      Top = 26
      Width = 63
      Height = 21
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblValorUnitario: TLabel
      Left = 166
      Top = 114
      Width = 107
      Height = 21
      Caption = 'Valor Unit'#225'rio:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblValorTotal: TLabel
      Left = 186
      Top = 157
      Width = 87
      Height = 21
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblQuantidade: TLabel
      Left = 182
      Top = 67
      Width = 91
      Height = 21
      Caption = 'Quantidade:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtProduto: TEdit
      Left = 72
      Top = 23
      Width = 441
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnExit = edtProdutoExit
      OnKeyUp = edtProdutoKeyUp
    end
    object edtQuantidade: TEdit
      Left = 279
      Top = 67
      Width = 70
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 4
      NumbersOnly = True
      ParentFont = False
      TabOrder = 1
      OnChange = edtQuantidadeChange
    end
    object edtValorTotal: TEdit
      Left = 279
      Top = 154
      Width = 73
      Height = 27
      TabStop = False
      Color = cl3DLight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnKeyUp = edtFiltroKeyUp
    end
    object edtValorUnitario: TEdit
      Left = 279
      Top = 109
      Width = 73
      Height = 27
      TabStop = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 9
      ParentFont = False
      TabOrder = 2
      OnChange = edtValorUnitarioChange
      OnKeyPress = edtValorUnitarioKeyPress
    end
    object btnAdicionarProduto: TButton
      Left = 139
      Top = 207
      Width = 241
      Height = 47
      Caption = 'ADICIONAR PRODUTO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnAdicionarProdutoClick
    end
  end
  object pnlListaPedidos: TPanel
    Left = 519
    Top = 89
    Width = 576
    Height = 379
    Align = alRight
    BevelOuter = bvNone
    Color = 16720418
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    TabOrder = 2
    object lblValorPedido: TLabel
      Left = 344
      Top = 344
      Width = 111
      Height = 23
      Caption = 'Valor Pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dbgrdDetalhePedido: TDBGrid
      Left = 6
      Top = 6
      Width = 563
      Height = 328
      Color = clWhite
      DataSource = dtsDetalhePedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyUp = dbgrdDetalhePedidoKeyUp
      Columns = <
        item
          Expanded = False
          FieldName = 'descricao'
          Title.Caption = 'Produto'
          Width = 305
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantidade'
          Title.Caption = 'Quantidade'
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_unidade'
          Title.Caption = 'Valor Unit'#225'rio'
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'valor_total'
          Title.Caption = 'Valor Total'
          Width = 67
          Visible = True
        end>
    end
    object dbedtTotalPedido: TDBEdit
      Left = 458
      Top = 340
      Width = 111
      Height = 29
      TabStop = False
      Color = cl3DLight
      DataField = 'tota_pedido'
      DataSource = dtsDetalhePedido
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object btnAcaoPedido: TButton
      Left = 6
      Top = 340
      Width = 155
      Height = 32
      Caption = 'FINALIZAR PEDIDO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnAcaoPedidoClick
    end
  end
  object pnlPesquisaFiltro: TPanel
    Left = 0
    Top = 0
    Width = 1095
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    Color = 10485760
    ParentBackground = False
    TabOrder = 0
    object lblFiltro: TLabel
      Left = 36
      Top = 16
      Width = 59
      Height = 21
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = rbPedidoClick
    end
    object lblPedido: TLabel
      Left = 124
      Top = 16
      Width = 59
      Height = 21
      Caption = 'Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = rbPedidoClick
    end
    object edtFiltro: TEdit
      Left = 10
      Top = 43
      Width = 659
      Height = 29
      TabStop = False
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyUp = edtFiltroKeyUp
    end
    object rbCliente: TRadioButton
      Left = 15
      Top = 13
      Width = 16
      Height = 28
      ParentCustomHint = False
      BiDiMode = bdLeftToRight
      Checked = True
      Color = 10485760
      Ctl3D = True
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      TabStop = True
      OnClick = rbClienteClick
    end
    object rbPedido: TRadioButton
      Left = 106
      Top = 13
      Width = 16
      Height = 28
      ParentCustomHint = False
      BiDiMode = bdLeftToRight
      Color = 10485760
      Ctl3D = True
      DoubleBuffered = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBiDiMode = False
      ParentColor = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
      OnClick = rbPedidoClick
    end
  end
  object dbgrdProduto: TDBGrid
    Left = 72
    Top = 142
    Width = 32
    Height = 27
    TabStop = False
    DataSource = dtsProduto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
    ParentFont = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgrdProdutoDblClick
    OnKeyUp = dbgrdProdutoKeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'descricao_prod'
        Width = 361
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'preco'
        Width = 47
        Visible = True
      end>
  end
  object dbgrdFiltro: TDBGrid
    Left = 10
    Top = 43
    Width = 20
    Height = 29
    TabStop = False
    DataSource = dtsFiltro
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgrdFiltroDblClick
    OnKeyUp = dbgrdFiltroKeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'descricao'
        Width = 214
        Visible = True
      end>
  end
  object dtsFiltro: TDataSource
    Left = 432
    Top = 49
  end
  object dtsProduto: TDataSource
    Left = 440
    Top = 353
  end
  object dtsDetalhePedido: TDataSource
    DataSet = fdmtblDetalhePedido
    Left = 680
    Top = 161
  end
  object fdmtblDetalhePedido: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    AggregatesActive = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    FormatOptions.AssignedValues = [fvMaxBcdPrecision, fvMaxBcdScale]
    FormatOptions.MaxBcdPrecision = 2147483647
    FormatOptions.MaxBcdScale = 1073741823
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 651
    Top = 281
    object fdmtblDetalhePedidoid_produto: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'id_produto'
    end
    object fdmtblDetalhePedidoquantidade: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'quantidade'
      Required = True
    end
    object fdmtblDetalhePedidovalor_unidade: TBCDField
      FieldName = 'valor_unidade'
      Required = True
      currency = True
      Precision = 12
      Size = 2
    end
    object fdmtblDetalhePedidodescricao: TStringField
      FieldName = 'descricao'
      Required = True
      Size = 150
    end
    object fdmtblDetalhePedidovalor_total: TBCDField
      FieldName = 'valor_total'
      Required = True
      currency = True
      Precision = 12
      Size = 2
    end
    object fdmtblDetalhePedidotota_pedido: TAggregateField
      FieldName = 'tota_pedido'
      Active = True
      currency = True
      DisplayName = ''
      Expression = 'SUM(valor_total)'
    end
  end
end
