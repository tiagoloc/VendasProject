unit uConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.FB, System.SysUtils, FireDAC.DApt, FireDAC.VCLUI.Wait;

type
  TConexao = class
  private
    FConn: TFDConnection;
    FTransanction: TFDTransaction;
    procedure ConfigurarConexao;
  public
    constructor Create;
    destructor Destroy; override;
    function GetConexao: TFDConnection;
    function CriarQuery: TFDQuery;
    function GetTransacao: TFDTransaction;
  end;

implementation

procedure TConexao.ConfigurarConexao;
begin
  FConn.Params.DriverID := 'MySQL';
  FConn.Params.Database := 'db_vendas';
  FConn.Params.UserName := 'appuser';
  FConn.Params.Password := 'us&rappvendas';

  FConn.Params.AddPair('Server', 'db4free.net');
  FConn.Params.AddPair('CharacterSet', 'latin1');
  FConn.LoginPrompt := False;
end;

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);

  FTransanction := TFDTransaction.Create(nil);
  FTransanction.Connection := FConn;
  FTransanction.Options.Isolation := xiReadCommitted;

  Self.ConfigurarConexao();
end;

function TConexao.CriarQuery: TFDQuery;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  lQuery.Connection := FConn;

  Result := lQuery;
end;

destructor TConexao.Destroy;
begin
  FConn.Free;
  FTransanction.Free;
  inherited;
end;

function TConexao.GetConexao: TFDConnection;
begin
  Result := FConn;
end;

function TConexao.GetTransacao: TFDTransaction;
begin
  Result := FTransanction;
end;

end.

