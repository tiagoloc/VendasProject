program VendasProject;

uses
  Vcl.Forms,
  uClienteDAO in '..\DAO\uClienteDAO.pas',
  uConexao in '..\DAO\uConexao.pas',
  uClienteModel in '..\Model\uClienteModel.pas',
  uClienteController in '..\Controller\uClienteController.pas',
  uConexaoController in '..\Controller\uConexaoController.pas',
  uFrmVendaView in '..\View\uFrmVendaView.pas' {frmVendaView},
  uProdutoDAO in '..\DAO\uProdutoDAO.pas',
  uProdutoModel in '..\Model\uProdutoModel.pas',
  uProdutoController in '..\Controller\uProdutoController.pas',
  uPedidoModel in '..\Model\uPedidoModel.pas',
  uPedidoController in '..\Controller\uPedidoController.pas',
  uPedidoProdutoModel in '..\Model\uPedidoProdutoModel.pas',
  uPedidoDAO in '..\DAO\uPedidoDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmVendaView, frmVendaView);
  Application.Run;
end.
