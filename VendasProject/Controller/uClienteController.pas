unit uClienteController;

interface

uses
  uClienteModel, System.SysUtils, FireDAC.Comp.Client;

type
  TClienteController = class
  private
    FClienteModel: TClienteModel;
  public
    constructor Create;
    destructor Destroy; override;
    function Obter(p_filtro: string): TFDQuery;
    procedure SetCliente(p_id: integer; p_nome: string);
    property ClienteModel: TClienteModel read FClienteModel write FClienteModel;
  end;

implementation

constructor TClienteController.Create;
begin
  FClienteModel := TClienteModel.Create;
end;

destructor TClienteController.Destroy;
begin
  FClienteModel.Free;
  inherited;
end;

function TClienteController.Obter(p_filtro: string): TFDQuery;
begin
  Result := FClienteModel.Obter(p_filtro);
end;

procedure TClienteController.SetCliente(p_id: integer; p_nome: string);
begin
  FClienteModel.ID := p_id;
  FClienteModel.Nome := p_nome;
end;

end.

