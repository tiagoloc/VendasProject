unit uConexaoController;

interface

uses
  uConexao, System.SysUtils;

type
  TConexaoController = class
  private
    FConexao: TConexao;
    class var
      FInstance: TConexaoController;
  public
    constructor Create();
    destructor Destroy; override;
    class function GetInstance: TConexaoController;
    property Conexao: TConexao read FConexao write FConexao;
  end;

implementation

constructor TConexaoController.Create();
begin
  FConexao := TConexao.Create;
end;

destructor TConexaoController.Destroy;
begin
  FConexao.Free;

  inherited;
end;

class function TConexaoController.GetInstance: TConexaoController;
begin
  if not Assigned(Self.FInstance) then
  begin
    Self.FInstance := TConexaoController.Create();
  end;

  Result := Self.FInstance;
end;

end.

