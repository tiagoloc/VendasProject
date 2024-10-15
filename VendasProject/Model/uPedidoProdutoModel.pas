unit uPedidoProdutoModel;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, System.Generics.Collections;

type
  TPedidoProdutoModel = class
  private
    FID: Integer;
    FIdProduto: Integer;
    FQuantidade: Integer;
    FValorUnitario: Double;
    FValorTotal: Double;


  public
    property ID: Integer read FID write FID;
    property IdProduto: Integer read FIdProduto write FIdProduto;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property ValorTotal: Double read FValorTotal write FValorTotal;
    function Obter(pIdPedido: Integer): TFDQuery;

    constructor Create;

  end;
implementation

uses
  uPedidoDAO;

constructor TPedidoProdutoModel.Create;
begin
  inherited;
  FID:= 0;
  IdProduto:= 0;
  Quantidade := 0;
  ValorUnitario := 0;
  ValorTotal := 0;
end;


function TPedidoProdutoModel.Obter(pIdPedido: Integer): TFDQuery;
var
  lPedidoDao: TPedidoDao;
begin
  lPedidoDao := TPedidoDao.Create;
  try
    Result := lPedidoDao.ObterPedidoProduto(pIdPedido);
  finally
    lPedidoDao.Free;
  end;
end;


end.
