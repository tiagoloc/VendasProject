unit uClienteModel;

interface

uses
  FireDAC.Comp.Client;
type
  TClienteModel = class
  private
    FID: Integer;
    FNome: string;
  public
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;

    function Obter(lFiltro: string): TFDQuery;
  end;
implementation

uses uClienteDao;


function TClienteModel.Obter(lFiltro: string): TFDQuery;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create;
  try
    Result := lClienteDao.Obter(lFiltro);
  finally
    lClienteDao.Free;
  end;
end;



end.
