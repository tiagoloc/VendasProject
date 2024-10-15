unit uClienteDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uClienteModel, System.SysUtils;

type
  TClienteDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;
    function Obter(pFiltro: string): TFDQuery;
  end;

implementation

uses
  uConexaoController;

constructor TClienteDao.Create;
begin
  FConexao := TConexaoController.GetInstance().Conexao;
end;

function TClienteDao.Obter(pFiltro: string): TFDQuery;
var
  lQrCliente: TFDQuery;
  lWhere: string;
begin
  lQrCliente := FConexao.CriarQuery();

  if StrToIntDef(pFiltro, 0) <> 0 then
    lWhere := ' where cli.id_cliente = :filtro'
  else
  begin
    lWhere := ' where cli.nome like :filtro ';
    pFiltro := '%' + pFiltro + '%'
  end;

  lQrCliente.SQL.Text := ' select cli.id_cliente,		           ' + '        concat(cli.id_cliente, " - " ,cli.nome, IFNULL(concat(" / ", cid.nome, "-", cid.uf), ""))  descricao,  ' + '        cli.nome                      ' + ' from   db_vendas.cliente cli left join 	       ' + '   	   db_vendas.cidade cid          ' + ' on   cid.id_cidade = cli.id_cidade ' + lWhere;

  lQrCliente.ParamByName('filtro').Value := pFiltro;
  lQrCliente.Prepare;
  lQrCliente.Open;

  Result := lQrCliente;

end;

end.

