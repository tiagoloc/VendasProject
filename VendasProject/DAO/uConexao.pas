unit uConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, System.IniFiles, System.SysUtils,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, Vcl.Dialogs;

type
  TConexao = class
  private
    class var FConn: TFDConnection;
    class procedure ConfigurarConexao;
  public
    constructor Create;
    destructor Destroy; override;
    class function GetConexao: TFDConnection; static;
    function CriarQuery: TFDQuery;
  end;

implementation

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);

  ConfigurarConexao();
end;

destructor TConexao.Destroy;
begin
  FConn.Free;
  inherited;
end;

class function TConexao.GetConexao: TFDConnection;
begin
  if FConn = nil then
    ConfigurarConexao();

  Result := FConn;
end;

class procedure TConexao.ConfigurarConexao;
var
  IniFile: TIniFile;
  ConfigPath, Server, Database, Username, Password: string;
  Port: Integer;
begin
  ConfigPath := ExtractFilePath(ParamStr(0)) + 'config.ini';

  if not FileExists(ConfigPath) then
  begin
    ShowMessage('Erro: Arquivo de configuração "config.ini" não encontrado!');
    Halt;
  end;

  IniFile := TIniFile.Create(ConfigPath);
  try
    Server := IniFile.ReadString('Database', 'Server', '');
    Database := IniFile.ReadString('Database', 'Database', '');
    Username := IniFile.ReadString('Database', 'Username', '');
    Password := IniFile.ReadString('Database', 'Password', '');
    Port := IniFile.ReadInteger('Database', 'Port', 0);

    if (Server = '') or (Database = '') or (Username = '') or (Password = '') or (Port = 0) then
    begin
      ShowMessage('Erro: Configurações inválidas ou incompletas no arquivo "config.ini".');
      Halt;
    end;


    FConn.Params.Clear;
    FConn.Params.AddPair('Server', Server);
    FConn.Params.AddPair('Database', Database);
    FConn.Params.AddPair('User_Name', Username);
    FConn.Params.AddPair('Password', Password);
    FConn.Params.AddPair('Port', IntToStr(Port));
    FConn.DriverName := 'MySQL';
  finally
    IniFile.Free;
  end;
end;

function TConexao.CriarQuery: TFDQuery;
var
  lQuery: TFDQuery;
begin
  lQuery := TFDQuery.Create(nil);
  lQuery.Connection := FConn;

  Result := lQuery;
end;

end.

