unit uFrmVendaView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uClienteController,
  uProdutoController, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Stan.StorageBin, Vcl.Mask, Vcl.DBCtrls,
  uPedidoController;

type
  TAcao = (tacCadastroPedido, tacEditarProduto, tacSelecionarCliente, tacSelecionarPedido, tacEditarPedido);

type
  TfrmVendaView = class(TForm)
    pnlListaPedidos: TPanel;
    dbgrdFiltro: TDBGrid;
    pnlPesquisaFiltro: TPanel;
    lblFiltro: TLabel;
    edtFiltro: TEdit;
    dtsFiltro: TDataSource;
    dbgrdDetalhePedido: TDBGrid;
    lblValorPedido: TLabel;
    dbgrdProduto: TDBGrid;
    dtsProduto: TDataSource;
    dtsDetalhePedido: TDataSource;
    pnlPesquisaProduto: TPanel;
    edtProduto: TEdit;
    edtQuantidade: TEdit;
    edtValorTotal: TEdit;
    edtValorUnitario: TEdit;
    lblProduto: TLabel;
    lblValorUnitario: TLabel;
    lblValorTotal: TLabel;
    lblQuantidade: TLabel;
    btnAdicionarProduto: TButton;
    fdmtblDetalhePedido: TFDMemTable;
    fdmtblDetalhePedidoid_produto: TIntegerField;
    fdmtblDetalhePedidoquantidade: TIntegerField;
    fdmtblDetalhePedidovalor_unidade: TBCDField;
    fdmtblDetalhePedidodescricao: TStringField;
    fdmtblDetalhePedidovalor_total: TBCDField;
    fdmtblDetalhePedidotota_pedido: TAggregateField;
    dbedtTotalPedido: TDBEdit;
    btnAcaoPedido: TButton;
    rbCliente: TRadioButton;
    lblPedido: TLabel;
    rbPedido: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure edtFiltroKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdFiltroKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdFiltroDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure dbgrdProdutoDblClick(Sender: TObject);
    procedure btnAdicionarProdutoClick(Sender: TObject);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitarioChange(Sender: TObject);
    procedure edtProdutoExit(Sender: TObject);
    procedure dbgrdDetalhePedidoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAcaoPedidoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConsultarFiltroClick(Sender: TObject);
    procedure rbClienteClick(Sender: TObject);
    procedure rbPedidoClick(Sender: TObject);
  private
    { Private declarations }
    FAcaoTela: TAcao;
    FClienteController: TClienteController;
    FProdutoController: TProdutoController;
    FPedidoController: TPedidoController;
    procedure CarregarClientes;
    procedure OcultarGridPesquisa;
    procedure SelecionarCliente;
    procedure CarregarProdutos;
    procedure SelecionarProduto;
    procedure CalcularTotalProduto;
    function ValidaProdutoPedido: Boolean;
    procedure LimparProdutoPedido;
    procedure SetAcaoTela(p_acao_tela: TAcao);
    procedure LimparListaPedido;
    procedure SelecionarPedido;
    procedure CarregarPedido;
    procedure SelecionarFiltro;
  public
    { Public declarations }
  end;

var
  frmVendaView: TfrmVendaView;

implementation

uses
  uConexaoController;


{$R *.dfm}

procedure TfrmVendaView.FormCreate(Sender: TObject);
begin
  FClienteController := TClienteController.Create;
  FProdutoController := TProdutoController.Create;
  FPedidoController := TPedidoController.Create;
end;

procedure TfrmVendaView.SetAcaoTela(p_acao_tela: TAcao);
begin
  FAcaoTela := p_acao_tela;

  case FAcaoTela of
    tacCadastroPedido:
    begin
      pnlPesquisaProduto.Enabled := True;
      pnlPesquisaFiltro.Enabled := False;
      pnlListaPedidos.Enabled := True;

      edtProduto.Enabled := True;

      edtFiltro.ReadOnly := True;
      edtFiltro.Color := clSilver;

      OcultarGridPesquisa;
      edtProduto.SetFocus;

      rbCliente.Checked := True;

      rbCliente.Enabled := False;
      rbPedido.Enabled := False;

      btnAcaoPedido.Enabled := True;

      btnAdicionarProduto.Caption := 'ADICIONAR PRODUTO';
      btnAcaoPedido.Caption := 'FINALIZAR PEDIDO';
    end;
    tacEditarProduto:
    begin
      pnlPesquisaProduto.Enabled := True;
      pnlPesquisaFiltro.Enabled := False;
      pnlListaPedidos.Enabled := False;

      edtProduto.Enabled := False;
      rbCliente.Checked := True;

      rbCliente.Enabled := False;
      rbPedido.Enabled := False;

      btnAcaoPedido.Enabled := False;
      edtFiltro.Color := clWhite;
      btnAdicionarProduto.Caption := 'ALTERAR PRODUTO';
      btnAcaoPedido.Caption := 'FINALIZAR PEDIDO';
    end;
    tacSelecionarCliente:
    begin
      LimparProdutoPedido;
      LimparListaPedido;

      pnlPesquisaProduto.Enabled := False;
      pnlPesquisaFiltro.Enabled := True;
      pnlListaPedidos.Enabled := False;
      OcultarGridPesquisa;


      rbCliente.Enabled := True;
      rbPedido.Enabled := True;
      btnAcaoPedido.Enabled := False;

      rbCliente.Checked := True;

      edtFiltro.ReadOnly := false;
      edtFiltro.Color := clWhite;
      edtFiltro.Clear;
      edtFiltro.SetFocus;

      edtFiltro.Color := clWhite;

      btnAdicionarProduto.Caption := 'ADICIONAR PRODUTO';

      btnAcaoPedido.Caption := 'FINALIZAR PEDIDO';
    end;
    tacSelecionarPedido:
    begin
      LimparProdutoPedido;
      LimparListaPedido;

      pnlPesquisaProduto.Enabled := False;
      pnlPesquisaFiltro.Enabled := True;
      pnlListaPedidos.Enabled := False;
      OcultarGridPesquisa;

      rbCliente.Enabled := True;
      rbPedido.Enabled := True;
      btnAcaoPedido.Enabled := False;

      edtFiltro.ReadOnly := false;
      edtFiltro.Color := clWhite;
      edtFiltro.Clear;
      edtFiltro.SetFocus;

      rbPedido.Checked := True;
      edtFiltro.Color := clInfoBk;

      btnAdicionarProduto.Caption := 'ADICIONAR PRODUTO';

      btnAcaoPedido.Caption := 'CANCELAR PEDIDO';
    end;
    tacEditarPedido:
    begin
      LimparProdutoPedido;
      LimparListaPedido;

      pnlPesquisaProduto.Enabled := False;
      pnlPesquisaFiltro.Enabled := True;
      pnlListaPedidos.Enabled := True;
      OcultarGridPesquisa;

      rbCliente.Enabled := True;
      rbPedido.Enabled := True;
      btnAcaoPedido.Enabled := True;

      edtFiltro.ReadOnly := false;
      edtFiltro.Color := clWhite;

      rbPedido.Checked := True;

      edtFiltro.Color := clInfoBk;
      btnAdicionarProduto.Caption := 'ADICIONAR PRODUTO';

      btnAcaoPedido.Caption := 'CANCELAR PEDIDO';
    end;
  end;
end;

procedure TfrmVendaView.FormDestroy(Sender: TObject);
begin
  FClienteController.Free;
  FProdutoController.Free;
  FPedidoController.Free;
  TConexaoController.GetInstance.Destroy();
end;

procedure TfrmVendaView.FormShow(Sender: TObject);
begin
  SetAcaoTela(tacSelecionarCliente);
  OcultarGridPesquisa;
end;

procedure TfrmVendaView.OcultarGridPesquisa;
begin
  dbgrdFiltro.Visible := False;
  dbgrdProduto.Visible := False;
end;

procedure TfrmVendaView.rbClienteClick(Sender: TObject);
begin
 if FAcaoTela in [tacSelecionarPedido, tacEditarPedido] then
    SetAcaoTela(tacSelecionarCliente);
end;

procedure TfrmVendaView.rbPedidoClick(Sender: TObject);
begin
  if FAcaoTela = tacSelecionarCliente then
    SetAcaoTela(tacSelecionarPedido);
end;

procedure TfrmVendaView.btnAdicionarProdutoClick(Sender: TObject);
begin
  if ValidaProdutoPedido then
  begin
    if not (fdmtblDetalhePedido.Active) then
      fdmtblDetalhePedido.Active := True;

    if FAcaoTela = tacCadastroPedido then
    begin
      fdmtblDetalhePedido.Append;
      fdmtblDetalhePedidoquantidade.AsFloat := StrToFloatDef(edtQuantidade.Text, 0);
      fdmtblDetalhePedidovalor_unidade.AsFloat := StrToFloatDef(edtValorUnitario.Text, 0);
      fdmtblDetalhePedidovalor_total.AsFloat := StrToFloatDef(edtValorTotal.Text, 0);
      fdmtblDetalhePedidoid_produto.AsInteger := FProdutoController.ProdutoModel.ID;
      fdmtblDetalhePedidodescricao.AsString := FProdutoController.ProdutoModel.Descricao;
      fdmtblDetalhePedido.Post;

      edtProduto.SetFocus;
    end
    else if FAcaoTela = tacEditarProduto then
    begin
      fdmtblDetalhePedido.Edit;
      fdmtblDetalhePedidoquantidade.AsFloat := StrToFloatDef(edtQuantidade.Text, 0);
      fdmtblDetalhePedidovalor_unidade.AsFloat := StrToFloatDef(edtValorUnitario.Text, 0);
      fdmtblDetalhePedidovalor_total.AsFloat := StrToFloatDef(edtValorTotal.Text, 0);
      fdmtblDetalhePedido.Post;

      SetAcaoTela(tacCadastroPedido);
    end;

    LimparProdutoPedido;
  end;
end;

procedure TfrmVendaView.btnConsultarFiltroClick(Sender: TObject);
begin
  if FAcaoTela = tacSelecionarCliente then
    SetAcaoTela(tacSelecionarPedido)
  else if FAcaoTela in [tacSelecionarPedido, tacEditarPedido] then
    SetAcaoTela(tacSelecionarCliente);
end;

function TfrmVendaView.ValidaProdutoPedido: Boolean;
begin
  if (Trim(edtProduto.Text) = '') then
  begin
    ShowMessage('Informe o produto!');
    edtProduto.SetFocus;
    Result := False;
  end
  else if (StrToFloatDef(edtQuantidade.Text, 0) <= 0) then
  begin
    ShowMessage('Informe a quantidade do produto!');
    edtQuantidade.SetFocus;
    Result := False;
  end
  else if (StrToFloatDef(edtValorUnitario.Text, 0) <= 0) then
  begin
    ShowMessage('Informe a valor unitário do produto!');
    edtValorUnitario.SetFocus;
    Result := False;
  end
  else
    Result := True;
end;

procedure TfrmVendaView.CarregarClientes;
var
  l_qry_cliente: TFDQuery;
begin
  l_qry_cliente := FClienteController.Obter(edtFiltro.Text);
  dtsFiltro.DataSet := l_qry_cliente;
end;

procedure TfrmVendaView.CarregarPedido;
var
  l_qry_pedido: TFDQuery;
begin
  l_qry_pedido := FPedidoController.Obter(edtFiltro.Text);
  dtsFiltro.DataSet := l_qry_pedido;
end;

procedure TfrmVendaView.CarregarProdutos;
var
  l_qry_produto: TFDQuery;
begin
  l_qry_produto := FProdutoController.Obter(edtProduto.Text);
  dtsProduto.DataSet := l_qry_produto;
end;

procedure TfrmVendaView.dbgrdFiltroDblClick(Sender: TObject);
begin
  SelecionarFiltro;
end;

procedure TfrmVendaView.dbgrdFiltroKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) and (dbgrdFiltro.DataSource.DataSet.Bof) then
    edtFiltro.SetFocus;

  if (Key = VK_RETURN) then
    SelecionarFiltro;

  if (Key = VK_ESCAPE) then
    dbgrdFiltro.Visible := False;
end;

procedure TfrmVendaView.SelecionarFiltro;
begin
  if FAcaoTela = tacSelecionarCliente then
    SelecionarCliente
  else if FAcaoTela in [tacSelecionarPedido, tacEditarPedido] then
    SelecionarPedido;
end;

procedure TfrmVendaView.dbgrdDetalhePedidoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (FAcaoTela = tacCadastroPedido) then
  begin
    if (fdmtblDetalhePedido.RecordCount > 0) and (fdmtblDetalhePedido.FieldByName('id_produto').AsInteger > 0) then
    begin
      FProdutoController.SetProduto(fdmtblDetalhePedido.FieldByName('id_produto').AsInteger, fdmtblDetalhePedido.FieldByName('descricao').AsString, fdmtblDetalhePedido.FieldByName('valor_unidade').AsFloat);

      edtQuantidade.Text := fdmtblDetalhePedido.FieldByName('quantidade').AsString;
      edtProduto.Text := fdmtblDetalhePedido.FieldByName('descricao').AsString;
      edtValorUnitario.Text := fdmtblDetalhePedido.FieldByName('valor_unidade').AsString;
      SetAcaoTela(tacEditarProduto);
    end;
  end
  else if (Key = VK_DELETE) and (FAcaoTela = tacCadastroPedido) then
  begin
    if MessageDlg('Você tem certeza que deseja excluir o Produto?' + #13 + fdmtblDetalhePedido.FieldByName('descricao').AsString, mtConfirmation, [mbyes, mbno], 0) = mryes then
      fdmtblDetalhePedido.Delete;
  end;
end;

procedure TfrmVendaView.dbgrdProdutoDblClick(Sender: TObject);
begin
  SelecionarProduto;
end;

procedure TfrmVendaView.dbgrdProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) and (dbgrdProduto.DataSource.DataSet.Bof) then
  begin
    edtProduto.SetFocus;
  end;

  if (Key = VK_RETURN) then
  begin
    SelecionarProduto;
  end;

  if (Key = VK_ESCAPE) then
  begin
    dbgrdProduto.Visible := False;
  end;
end;

procedure TfrmVendaView.SelecionarCliente;
begin
  SetAcaoTela(tacCadastroPedido);
  LimparProdutoPedido;
  LimparListaPedido;
  with dbgrdFiltro.DataSource.DataSet do
  begin
    if FieldByName('id_cliente').AsInteger > 0 then
    begin
      FClienteController.SetCliente(FieldByName('id_cliente').AsInteger, FieldByName('nome').AsString);
      edtFiltro.Text := FieldByName('descricao').AsString;
    end;
  end;
end;

procedure TfrmVendaView.SelecionarPedido;
var
  lQrPedidoProdutos: TFDQuery;
begin
  SetAcaoTela(tacEditarPedido);
  LimparProdutoPedido;
  LimparListaPedido;
  with dbgrdFiltro.DataSource.DataSet do
  begin
    if FieldByName('id_pedido').AsInteger > 0 then
    begin
      edtFiltro.Text := FieldByName('descricao').AsString;
      FPedidoController.PedidoModel.ID := FieldByName('id_pedido').AsInteger;

      lQrPedidoProdutos := FPedidoController.ObterPedidoProduto(FieldByName('id_pedido').AsInteger);

      fdmtblDetalhePedido.DisableControls;
      fdmtblDetalhePedido.Open;
      lQrPedidoProdutos.First;

      while not lQrPedidoProdutos.Eof do
      begin
        fdmtblDetalhePedido.Append;
        fdmtblDetalhePedido.CopyRecord(lQrPedidoProdutos);
        fdmtblDetalhePedido.Post;

        lQrPedidoProdutos.Next;
      end;

      fdmtblDetalhePedido.EnableControls;
    end;
  end;
end;

procedure TfrmVendaView.SelecionarProduto;
begin
  with dbgrdProduto.DataSource.DataSet do
  begin
    if FieldByName('id_produto').AsInteger > 0 then
    begin
      FProdutoController.SetProduto(FieldByName('id_produto').AsInteger, FieldByName('descricao').AsString, FieldByName('preco').AsFloat);

      edtProduto.Text := FieldByName('descricao').AsString;
      edtValorUnitario.Text := FieldByName('preco').AsString;

      dbgrdProduto.Visible := False;
      edtQuantidade.SetFocus;
    end;
  end;
end;

procedure TfrmVendaView.edtFiltroKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dbgrdFiltro.Visible := False;

  if (Trim(edtFiltro.Text) <> '') and not (edtFiltro.ReadOnly) then
  begin

    if FAcaoTela = tacSelecionarCliente then
      CarregarClientes
    else if FAcaoTela in [tacSelecionarPedido, tacEditarPedido] then
      CarregarPedido;

    with dbgrdFiltro do
    begin
      if not (DataSource.DataSet.IsEmpty) then
      begin
        Visible := True;
        Top := edtFiltro.Top + 30;
        Left := edtFiltro.Left;
        Width := edtFiltro.Width;
        Columns[0].Width := edtFiltro.Width;

        Font.Size := edtFiltro.Font.Size;
        Height := edtFiltro.Height * 4;
      end;
    end;

  end;

  if Key = VK_DOWN then
  begin
    dbgrdFiltro.SetFocus;
  end;

  if (Key = VK_ESCAPE) then
  begin
    dbgrdFiltro.Visible := False;
  end;
end;

procedure TfrmVendaView.edtProdutoExit(Sender: TObject);
begin
  if (Trim(edtProduto.Text) = '') and (FProdutoController.ProdutoModel.ID = 0) then
    LimparProdutoPedido
  else if not dbgrdProduto.Focused then
    edtProduto.Text := FProdutoController.ProdutoModel.Descricao;
end;

procedure TfrmVendaView.LimparProdutoPedido;
begin
  edtProduto.Clear;
  edtQuantidade.Clear;
  edtValorUnitario.Clear;
  edtValorTotal.Clear;

  FProdutoController.SetProduto(0, '', 0);
end;

procedure TfrmVendaView.LimparListaPedido;
begin
  try
    fdmtblDetalhePedido.Close;
    fdmtblDetalhePedido.Open;
    fdmtblDetalhePedido.EmptyDataSet;
  except
    ShowMessage('Erro ao limpar pedido!')
  end;
end;

procedure TfrmVendaView.edtProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  dbgrdProduto.Visible := False;

  if (Trim(edtProduto.Text) <> '') and not (edtProduto.ReadOnly) then
  begin
    CarregarProdutos;

    with dbgrdProduto do
    begin
      if not (DataSource.DataSet.IsEmpty) then
      begin
        Visible := True;
        Top := edtProduto.Top + 110;
        Left := edtProduto.Left;
        Width := edtProduto.Width;
        Font.Size := 10;
        Height := edtProduto.Height * 4;
      end;
    end;
  end;

  if Key = VK_DOWN then
  begin
    dbgrdProduto.SetFocus;
  end;

  if (Key = VK_ESCAPE) then
  begin
    dbgrdProduto.Visible := False;
  end;
end;

procedure TfrmVendaView.edtQuantidadeChange(Sender: TObject);
begin
  CalcularTotalProduto;
end;

procedure TfrmVendaView.btnAcaoPedidoClick(Sender: TObject);
var
  lPedidoController: TPedidoController;
begin
  if FAcaoTela = tacCadastroPedido then
  begin

    if fdmtblDetalhePedido.RecordCount > 0 then
    begin
      try
        with fdmtblDetalhePedido do
        begin
          lPedidoController := TPedidoController.Create(FClienteController.ClienteModel.ID, StrToFloatDef(FieldByName('tota_pedido').AsString, 0));

          First;

          while not Eof do
          begin
            lPedidoController.AdicionarProdutoPedido(FieldByName('id_produto').AsInteger, FieldByName('quantidade').AsInteger, FieldByName('valor_unidade').AsFloat, FieldByName('valor_total').AsFloat);
            Next;
          end;
        end;

        if lPedidoController.GravarListaPedido then
          ShowMessage('Pedido gravado com sucesso!')
        else
          ShowMessage('Erro ao gravar pedido!');
      finally
        lPedidoController.Free;
      end;
    end;

    SetAcaoTela(tacSelecionarCliente);
  end
  else
  if FAcaoTela in [tacSelecionarPedido, tacEditarPedido] then
  begin
    if MessageDlg('Você tem certeza que deseja cancelar este pedido?', mtConfirmation, [mbyes, mbno], 0) = mryes then
    begin
      FPedidoController.CancelarPedido(FPedidoController.PedidoModel.ID);
      SetAcaoTela(tacSelecionarPedido);
    end;
  end;
end;

procedure TfrmVendaView.CalcularTotalProduto;
begin
  if (StrToFloatDef(edtQuantidade.Text, 0) > 0) and (StrToFloatDef(edtValorUnitario.Text, 0) > 0) then
    edtValorTotal.Text := FormatFloat('0.00', StrToFloatDef(edtQuantidade.Text, 0) * StrToFloatDef(edtValorUnitario.Text, 0))
  else
    edtValorTotal.Text := '';
end;

procedure TfrmVendaView.edtValorUnitarioChange(Sender: TObject);
begin
  CalcularTotalProduto;
end;

procedure TfrmVendaView.edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key <> #8) and (Pos(',', TEdit(Sender).Text) > 0) and ((Length(TEdit(Sender).Text) - Pos(',', TEdit(Sender).Text)) = 2) then
    Abort
  else
  begin
    if (Key = #46) then
      Key := Formatsettings.DecimalSeparator;

    if not (CharInSet(Key, ['0'..'9', Chr(8), Formatsettings.DecimalSeparator])) then
      Key := #0
    else if (Key = Formatsettings.DecimalSeparator) and (Pos(Key, TEdit(Sender).Text) > 0) then
      Key := #0;
  end;
end;

end.

