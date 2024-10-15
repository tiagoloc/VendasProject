unit uProdutoModel;

interface

uses
  FireDAC.Comp.Client;
type
  TProdutoModel = class
  private
    FID: Integer;
    FDescricao: string;
    FPrecoUnitario: Double;
  public
    property ID: Integer read FID write FID;
    property Descricao: string read FDescricao write FDescricao;
    property PrecoUnitario: Double read FPrecoUnitario write FPrecoUnitario;

    function Obter(l_filtro: string): TFDQuery;
  end;
implementation

uses uProdutoDao;

function TProdutoModel.Obter(l_filtro: string): TFDQuery;
var
  lProdutoDAO: TProdutoDAO;
begin
  lProdutoDAO := TProdutoDAO.Create;
  try
    Result := lProdutoDAO.Obter(l_filtro);
  finally
    lProdutoDAO.Free;
  end;
end;

end.
