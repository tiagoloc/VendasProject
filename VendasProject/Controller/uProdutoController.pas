unit uProdutoController;

interface

uses
  uProdutoModel, System.SysUtils, FireDAC.Comp.Client;

type
  TProdutoController = class
  private
    FProdutoModel: TProdutoModel;
  public
    constructor Create;
    destructor Destroy; override;
    function Obter(p_filtro: string): TFDQuery;
    procedure SetProduto(p_id: integer; p_descricao: string; p_preco_unitario: Double);
    property ProdutoModel: TProdutoModel read FProdutoModel write FProdutoModel;
  end;

implementation

constructor TProdutoController.Create;
begin
  FProdutoModel := TProdutoModel.Create;
end;

destructor TProdutoController.Destroy;
begin
  FProdutoModel.Free;
  inherited;
end;

function TProdutoController.Obter(p_filtro: string): TFDQuery;
begin
  Result := FProdutoModel.Obter(p_filtro);
end;

procedure TProdutoController.SetProduto(p_id: integer; p_descricao: string; p_preco_unitario: Double);
begin
  FProdutoModel.ID := p_id;
  FProdutoModel.Descricao := p_descricao;
  FProdutoModel.PrecoUnitario := p_preco_unitario;
end;

end.

