unit uPedidoDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uPedidoProdutoModel, uPedidoModel,
  System.SysUtils, System.Generics.Collections;

type
  TPedidoDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;
    function Obter(pFiltro: string): TFDQuery;
    function ObterPedidoProduto(pIdPedido: Integer): TFDQuery;
    function Incluir(pPedido: TPedidoModel): Boolean;
    function Excluir(pIdPedido: Integer): Boolean;
  end;

implementation

uses
  uConexaoController;

constructor TPedidoDAO.Create;
begin
  FConexao := TConexaoController.GetInstance().Conexao;
end;

function TPedidoDAO.Obter(pFiltro: string): TFDQuery;
var
  lQrPedido: TFDQuery;
  lWhere: string;
begin
  lQrPedido := FConexao.CriarQuery();

  if StrToIntDef(pFiltro, 0) <> 0 then
    lWhere := ' where ped.id_pedido = :filtro'
  else
  begin
    lWhere := ' where cli.nome like :filtro ';
    pFiltro := '%' + pFiltro + '%'
  end;

  lQrPedido.SQL.Text := ' SELECT ped.id_pedido,                                                                                       ' + ' 	     concat("#00",ped.id_pedido, " - (" , ped.dt_pedido ,") " ,cli.nome, IFNULL(concat(" / ", cid.nome, "-", cid.uf), ""))   descricao ' + ' FROM   db_vendas.pedido ped inner join                                                                                ' + ' 	     db_vendas.cliente cli                      ' + '        on   ped.id_cliente = cli.id_cliente                                                                                   ' + '      left join  db_vendas.cidade cid    on cid.id_cidade = cli.id_cidade                                                                             ' + lWhere;

  lQrPedido.ParamByName('filtro').Value := pFiltro;
  lQrPedido.Prepare;
  lQrPedido.Open;

  Result := lQrPedido;

end;

function TPedidoDAO.ObterPedidoProduto(pIdPedido: Integer): TFDQuery;
var
  lQrPedidoProduto: TFDQuery;
begin
  lQrPedidoProduto := FConexao.CriarQuery();

  lQrPedidoProduto.SQL.Text := ' SELECT ped.id_pedido_produto,       ' + '        ped.id_pedido,               ' + '        ped.id_produto,              ' + '        ped.quantidade,              ' + '        ped.valor_unidade,           ' + '        ped.valor_total,             ' + '        pro.descricao                ' + ' FROM   db_vendas.pedido_produto ped, ' + '        db_vendas.produto pro         ' + ' WHERE  pro.id_produto = ped.id_produto ' + '        and ped.id_pedido = :pIdPedidos  ';

  lQrPedidoProduto.ParamByName('pIdPedidos').Value := pIdPedido;
  lQrPedidoProduto.Prepare;
  lQrPedidoProduto.Open;

  Result := lQrPedidoProduto;
end;

function TPedidoDAO.Incluir(pPedido: TPedidoModel): Boolean;
var
  lQryPedido: TFDQuery;
  lPedidoProduto: TPedidoProdutoModel;
begin
  lQryPedido := FConexao.CriarQuery();
  try
    FConexao.GetConexao.StartTransaction;
    lQryPedido.ExecSQL(' INSERT INTO db_vendas.pedido (id_cliente, valor_total) VALUES (:id_cliente , :valor_total)', [pPedido.IdCliente, pPedido.ValorTotal]);
    pPedido.ID := FConexao.GetConexao.GetLastAutoGenValue('id_pedido');
    for lPedidoProduto in pPedido.ListaPedidoProduto do
    begin
      lQryPedido.ExecSQL(' INSERT INTO db_vendas.pedido_produto (id_pedido,id_produto,quantidade,valor_unidade) ' + ' VALUES (:id_pedido,:id_produto,:quantidade,:valor_unidade) ', [pPedido.ID, lPedidoProduto.IdProduto, lPedidoProduto.Quantidade, lPedidoProduto.ValorUnitario]);
    end;
    FConexao.GetConexao.Commit;
    Result := True;
  except
    lQryPedido.Free;
    FConexao.GetConexao.Rollback;
    Result := False;
  end;
end;

function TPedidoDAO.Excluir(pIdPedido: Integer): Boolean;
var
  lQryPedido: TFDQuery;
begin
  lQryPedido := FConexao.CriarQuery();
  try
    FConexao.GetConexao.StartTransaction;
    lQryPedido.ExecSQL('DELETE FROM db_vendas.pedido_produto WHERE id_pedido = :id_pedido', [pIdPedido]);
    lQryPedido.ExecSQL('DELETE FROM db_vendas.pedido WHERE id_pedido = :id_pedido', [pIdPedido]);

    FConexao.GetConexao.Commit;
    Result := True;
  except
    lQryPedido.Free;
    FConexao.GetConexao.Rollback;
    Result := False;
  end;
end;

end.

