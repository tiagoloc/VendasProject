unit uProdutoDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uClienteModel, System.SysUtils;

type
  TProdutoDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;
    function Obter(pFiltro: string): TFDQuery;
  end;

implementation

uses
  uConexaoController;

constructor TProdutoDAO.Create;
begin
  FConexao := TConexaoController.GetInstance().Conexao;
end;

function TProdutoDAO.Obter(pFiltro: string): TFDQuery;
var
  lQryProduto: TFDQuery;
  lWhere: string;
begin
  lQryProduto := FConexao.CriarQuery();

  if StrToIntDef(pFiltro, 0) <> 0 then
    lWhere := ' where pro.id_produto = :filtro'
  else
  begin
    lWhere := ' where pro.descricao like :filtro ';
    pFiltro := '%' + pFiltro + '%'
  end;

  lQryProduto.SQL.Text := ' SELECT pro.id_produto,       ' + '    	   pro.descricao,         ' + '        concat(pro.id_produto, " - " , pro.descricao)  descricao_prod,  ' + '        pro.preco             ' + ' FROM   db_vendas.produto pro ' + lWhere;

  lQryProduto.ParamByName('filtro').Value := pFiltro;
  lQryProduto.Prepare;
  lQryProduto.Open;

  Result := lQryProduto;
end;

end.

