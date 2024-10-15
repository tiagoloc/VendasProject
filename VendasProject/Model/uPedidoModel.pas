unit uPedidoModel;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections, uPedidoProdutoModel;

type
  TPedidoModel = class
  private
    FID: Integer;
    FIdCliente: Integer;
    FValorTotal: Double;
    FListaPedidoProduto: TObjectList<TPedidoProdutoModel>;
  public
    property ID: Integer read FID write FID;
    property IdCliente: Integer read FIdCliente write FIdCliente;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    property ListaPedidoProduto: TObjectList<TPedidoProdutoModel> read FListaPedidoProduto;
    procedure AdicionarListaProduto(pPedidoProduto: TPedidoProdutoModel);
    function Obter(lFiltro: string): TFDQuery;
    function Gravar: Boolean;
    function Cancelar(pIdPedido: Integer): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;
implementation

uses
  uPedidoDAO;

constructor TPedidoModel.Create;
begin
  inherited;
  FID:= 0;
  FIdCliente:= 0;
  FValorTotal := 0;
  FListaPedidoProduto := TObjectList<TPedidoProdutoModel>.Create;
end;

destructor TPedidoModel.Destroy;
begin
  FreeAndNil(FListaPedidoProduto);
  inherited;
end;

procedure TPedidoModel.AdicionarListaProduto(pPedidoProduto: TPedidoProdutoModel);
begin
  FListaPedidoProduto.Add(pPedidoProduto);
end;

function TPedidoModel.Gravar: Boolean;
var
  lPedidoDao: TPedidoDao;
begin
  lPedidoDao := TPedidoDao.Create;
  try
    Result := lPedidoDao.Incluir(Self);
  finally
    lPedidoDao.Free;
  end;
end;

function TPedidoModel.Cancelar(pIdPedido: Integer): Boolean;
var
  lPedidoDao: TPedidoDao;
begin
  lPedidoDao := TPedidoDao.Create;
  try
    Result := lPedidoDao.Excluir(pIdPedido);
  finally
    lPedidoDao.Free;
  end;
end;

function TPedidoModel.Obter(lFiltro: string): TFDQuery;
var
  lPedidoDao: TPedidoDao;
begin
  lPedidoDao := TPedidoDao.Create;
  try
    Result := lPedidoDao.Obter(lFiltro);
  finally
    lPedidoDao.Free;
  end;
end;


end.
