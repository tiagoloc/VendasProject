unit uPedidoController;

interface

uses
  uPedidoModel, System.SysUtils, FireDAC.Comp.Client, uPedidoProdutoModel;

type
  TPedidoController = class
  private
    FPedidoModel: TPedidoModel;
    FPedidoProdutoModel: TPedidoProdutoModel;
  public
    constructor Create; overload;
    constructor Create(pIdCliente: Integer; pValorTotal: Double); overload;
    destructor Destroy; override;
    function Obter(pFiltro: string): TFDQuery; overload;
    function ObterPedidoProduto(pIdPedido: integer): TFDQuery;
    property PedidoModel: TPedidoModel read FPedidoModel write FPedidoModel;
    function GravarListaPedido: Boolean;
    function CancelarPedido(pIdPedido: Integer): Boolean;
    procedure AdicionarProdutoPedido(pIdProduto, pQuantidade: Integer; pValorUnitario, pValorTotal: Double);
  end;

implementation

constructor TPedidoController.Create;
begin
  inherited;
  FPedidoModel := TPedidoModel.Create;
  FPedidoProdutoModel := TPedidoProdutoModel.Create;
end;

constructor TPedidoController.Create(pIdCliente: Integer; pValorTotal: Double);
begin
  FPedidoModel := TPedidoModel.Create;
  FPedidoModel.IdCliente := pIdCliente;
  FPedidoModel.ValorTotal := pValorTotal
end;

destructor TPedidoController.Destroy;
begin
  FPedidoModel.Free;
  inherited;
end;

procedure TPedidoController.AdicionarProdutoPedido(pIdProduto, pQuantidade: Integer; pValorUnitario, pValorTotal: Double);
var
  lPedidoProduto: TPedidoProdutoModel;
begin
  lPedidoProduto := TPedidoProdutoModel.Create;
  lPedidoProduto.IdProduto := pIdProduto;
  lPedidoProduto.Quantidade := pQuantidade;
  lPedidoProduto.ValorUnitario := pValorUnitario;
  lPedidoProduto.ValorTotal := pValorTotal;

  FPedidoModel.AdicionarListaProduto(lPedidoProduto);
end;

function TPedidoController.GravarListaPedido: Boolean;
begin
  Result := FPedidoModel.Gravar;
end;

function TPedidoController.CancelarPedido(pIdPedido: Integer): Boolean;
begin
  Result := FPedidoModel.Cancelar(pIdPedido);
end;

function TPedidoController.Obter(pFiltro: string): TFDQuery;
begin
  Result := FPedidoModel.Obter(pFiltro);
end;

function TPedidoController.ObterPedidoProduto(pIdPedido: integer): TFDQuery;
begin
  Result := FPedidoProdutoModel.Obter(pIdPedido);
end;

end.

