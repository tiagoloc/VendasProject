unit uSistemaController;

interface

uses
  uConexao, System.SysUtils, uClienteModel;

type
  TSistemaControl = class
  private
    FConexao     : TConexao;
    FClienteModel: TClienteModel;

    class var FInstance: TSistemaControl;

  public
    constructor Create();
    destructor Destroy; override;

    procedure CarregarEmpresa(ACodigoEmpresa: Integer);

    class function GetInstance: TSistemaControl;

     property Conexao: TConexao read FConexao write FConexao;
     property ClienteModel: TClienteModel read FClienteModel write FClienteModel;
  end;

implementation

{ TSistemaControl }

procedure TSistemaControl.CarregarEmpresa(ACodigoEmpresa: Integer);
begin
  EmpresaModel.Carregar(ACodigoEmpresa);
end;

constructor TSistemaControl.Create();
begin
  FConexao     := TConexao.Create;
  EmpresaModel := TEmpresaModel.Create();
end;

destructor TSistemaControl.Destroy;
begin
  FEmpresaModel.Free;
  FConexao.Free;

  inherited;
end;

class function TSistemaControl.GetInstance: TSistemaControl;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance := TSistemaControl.Create();
  end;

  Result := Self.FInstance;
end;

end.
