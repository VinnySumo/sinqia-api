const express = require("express");
const router = express.Router();

// referência a controllers que serão utilizados nas rotas
const ProdutosController = require("../controllers/produto");
const UsuariosController = require("../controllers/usuarios");
const TiposUsuarioController = require("../controllers/tipousuario");
const TiposEnderecoController = require("../controllers/tipoendereco");
const TipoPagCompraController = require("../controllers/tipopagcompra");
const FornecedoresController = require("../controllers/fornecedor");
const ComprasController = require("../controllers/compras");
const EnderecoController = require("../controllers/endereco");
const UsuarioEndController = require("../controllers/usuarioendereco");
const TelefoneController = require("../controllers/telefones");
const Entrada_ProdutoController = require("../controllers/entrada_produto");
const Pagamento_comprasController = require("../controllers/pagamentos_compras");
const Produto_loteController = require("../controllers/produtolote");
const CategoriaController = require("../controllers/categorias");
const PromocoesController = require("../controllers/promocoes");
const ProdutoPromoController = require("../controllers/produtopromo");
const VendasController = require("../controllers/vendas");
const VendaProdutoController = require("../controllers/vendaproduto");
const PagamentoVendaController = require("../controllers/pagamentovenda");
const QtdProdutoController = require("../controllers/qtdproduto");
const AnaliseProdController = require("../controllers/qtdproduto");
const TransporteController = require("../controllers/transporte");
const DevolucaoController = require("../controllers/devolucoes");
const SalarioController = require("../controllers/salario");
const HoleriteController = require("../controllers/holerite");
const ApiKeyController = require("../controllers/apikey");
const PermissoesController = require("../controllers/permissoes");
const UsuariosPermissoesController = require("../controllers/usuariospermissoes");
const InventarioController = require("../controllers/inventario");
const NotificacaoController = require("../controllers/notificacao");
const RelatorioController = require("../controllers/relatorio");
const BackupController = require("../controllers/backup");
const RecuperarDadosController = require("../controllers/recuperardados");
const HistoricoLoginController = require("../controllers/historicologin");
const ProdutoCategoriaController = require("../controllers/produtocategoria");
const autenticarToken = require("../controllers/autenticador")

//Usuarios

router.post("/loginUsuario", UsuariosController.loginUsuario); //login
router.patch("/usuarios/alterar_senha",UsuariosController.alterarSenha);
router.post("/recuperar_senha", UsuariosController.recuperarSenha);
router.get("/usuarios", UsuariosController.listarUsuarios); //listar usuarios geral
router.get("/usuarios/perfil/:usu_id", UsuariosController.listarPerfil); //listar perfil
//router.get('/loginUsuario',UsuariosController.loginUsuario);
router.get("/usuarios/adms", UsuariosController.listarUsuariosAdministradores); //listas administradores
router.get("/usuarios/totalclientes", UsuariosController.TotalClientes); //contagem de clientes totais
router.get("/usuarios/totalfuncionarios", UsuariosController.TotalFuncionarios); //contagem de funcionarios totais
router.get("/usuarios/cli", UsuariosController.listarClientesAtivos); //listar clientes
router.get("/usuarios/cliPesquisaAtivos",UsuariosController.pesquisarClientesAtivos); //pesquisar clientes ativos
router.get("/clienteUnico/:usu_id", UsuariosController.listarClienteUnico);
router.get("/usuarios/cliInativos", UsuariosController.listarClientesInativos); //listar clientes inativos
router.get("/usuarios/cliPesquisaInativos",UsuariosController.pesquisarClientesInativos); //pesquisar clientes inativos
router.get("/usuarios/funci", UsuariosController.listarFuncionariosAtivos); //listar funcionarios ativos
router.get("/usuarios/funciPesquisaAtivos",UsuariosController.pesquisarFuncionariosAtivos); //pesquisar funcionarios ativos
router.get("/usuarios/funciInativo",UsuariosController.listarFuncionariosInativos); //listar funcionarios inativos
router.get("/usuarios/funciPesquisaInativos",UsuariosController.pesquisarFuncionariosInativos); //pesquisar funcionarios Inativos
router.get( "/funcionarioUnico/:usu_id",UsuariosController.listarFuncionarioUnico); //Listar Funcionario Unico
router.post("/usuarioscadastro", UsuariosController.cadastrarUsuarios); //body
router.patch("/usuarios/:usu_id", UsuariosController.editarUsuarios);
router.patch("/perfil/:usu_id", UsuariosController.editarPerfil); // params (URL) e body
router.delete("/usuarios/:usu_id", UsuariosController.apagarUsuarios); // params (URL)
router.patch("/ocultarUsuario/:usu_id", UsuariosController.ocultarUsuario);
router.patch("/ativarUsuario/:usu_id", UsuariosController.AtivarUsuario);
//router.delete('/usuarios/del/:usu_id',UsuariosController.apagarUsuarios); // params (URL)
//router.post('/usuarios/login',UsuariosController.login); // params (URL)

//Tipo_Usuarios
router.get("/tipousu", TiposUsuarioController.listarTiposUsuario);
router.get("/acessocate/:tus_cod",TiposUsuarioController.listarUsuariosPorCategoria); // Listar Usuarios Pelo Tus_cod( 1=admin 2=cliente 3=funcionario 4=gestor/financeiro 5=gestor/financeiro)
router.post("/tipousu", TiposUsuarioController.cadastrarTipoUsuario); //body
router.patch("/tipousu/:tus_cod", TiposUsuarioController.editarTipoUsuario); // params (URL) e body
router.delete("/tipousu/:tus_cod", TiposUsuarioController.apagarTipoUsuario); // params (URL)

// Novas rotas para usuários
router.patch("/usuarios/:usu_id/:tus_cod", TiposUsuarioController.atualizarTipoUsuario); // Rota para atualizar o tus_code de um usuário (params e body)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Produtos
router.get("/produtos", ProdutosController.listarProdutos);
router.get("/produtosVenda", ProdutosController.listarProdutoVenda);
router.get("/produtoUnico/:prod_id", ProdutosController.listarProdutoUnico);
router.post("/produtos/cadastroproduto", ProdutosController.cadastrarProdutosEstoque);
//router.post('/produtos',ProdutosController.cadastrarProdutos); //body
router.patch("/produtoseditar/:prod_id", ProdutosController.editarProdutos); // params (URL) e body
router.delete("/produtos/:prod_id", ProdutosController.apagarProdutos); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarProdutos); // params (URL)

//Tipos_Enderecos
router.get("/tipoend", TiposEnderecoController.listarTiposEndereco);
router.post("/tipoend", TiposEnderecoController.cadastrarTipoEndereco); //body
router.patch("/tipoend/:ten_cod", TiposEnderecoController.editarTipoEndereco); // params (URL) e body
router.delete("/tipoend/:ten_cod", TiposEnderecoController.apagarTipoEndereco); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarProdutos); // params (URL)

//Tipos_Pag_Compra
router.get(
  "/tipopagcompra",
  TipoPagCompraController.listarTiposPagamentoCompra
);
router.post(
  "/tipopagcompra",
  TipoPagCompraController.cadastrarTipoPagamentoCompra
); //body
router.patch(
  "/tipopagcompra/:tpa_cod",
  TipoPagCompraController.editarTipoPagamentoCompra
); // params (URL) e body
router.delete(
  "/tipopagcompra/:tpa_cod",
  TipoPagCompraController.apagarTipoPagamentoCompra
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarProdutos); // params (URL)

//Fornecedores
router.get("/fornecedor", FornecedoresController.listarFornecedores);
router.get( "/fornecedorUnico/:forn_id", FornecedoresController.listarFornecedorUnico);
router.get( "/fornecedor/Ativos",FornecedoresController.listarFornecedoresAtivos); //lista de fornecedores ativos
router.get(
  "/fornecedor/PesquisaAtivos",
  FornecedoresController.pesquisarFornecedoresAtivos
); //pesquisa de fornecedores ativos
router.get(
  "/fornecedor/Inativos",
  FornecedoresController.listarFornecedoresInativos
); //lista de fornecedores ativos
router.get(
  "/fornecedor/PesquisaInativos",
  FornecedoresController.pesquisarFornecedoresInativos
); //pesquisa de fornecedores ativos
router.post("/fornecedorcadastro", FornecedoresController.cadastrarFornecedor); //body
router.patch(
  "/editarFornecedor/:forn_id",
  FornecedoresController.editarFornecedor
); // params (URL) e body'
router.patch(
  "/ocultarFornecedor/:forn_id",
  FornecedoresController.ocultarFornecedor
);
router.patch(
  `/ativarFornecedor/:forn_id`,
  FornecedoresController.AtivarFornecedor
);
router.delete("/fornecedor/:forn_id", FornecedoresController.apagarFornecedor); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Compras
router.get("/compras", ComprasController.listarCompras);
router.post("/compras", ComprasController.cadastrarCompra); //body
router.patch("/compras/:comp_id", ComprasController.editarCompra); // params (URL) e body
router.delete("/compras/:comp_id", ComprasController.apagarCompra); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Enderecos
router.get("/endereco", EnderecoController.listarEnderecos);
router.post("/endereco", EnderecoController.cadastrarEndereco); //body
router.patch("/endereco/:end_id", EnderecoController.editarEndereco); // params (URL) e body
router.delete("/endereco/:end_id", EnderecoController.apagarEndereco); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Usuario_Endereco
router.get("/usuarioend", UsuarioEndController.listarUsuarioEndereco);
router.post("/usuarioend", UsuarioEndController.cadastrarUsuarioEndereco); //body
router.patch("/usuarioend/:uen_id", UsuarioEndController.editarUsuarioEndereco); // params (URL) e body
router.delete(
  "/usuarioend/:uen_id",
  UsuarioEndController.apagarUsuarioEndereco
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Telefones
router.get("/telefone", TelefoneController.listarTelefones);
router.post("/telefone", TelefoneController.cadastrarTelefone); //body
router.patch("/telefone/:tel_id", TelefoneController.editarTelefone); // params (URL) e body
router.delete("/telefone/:tel_id", TelefoneController.apagarTelefone); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Entrada_Produto
router.get("/entrada_produto", Entrada_ProdutoController.listarEntradaProduto);
router.post(
  "/entrada_produto",
  Entrada_ProdutoController.cadastrarEntradaProduto
); //body
router.patch(
  "/entrada_produto/:ent_prod_id",
  Entrada_ProdutoController.editarEntradaProduto
); // params (URL) e body
router.delete(
  "/entrada_produto/:ent_prod_id",
  Entrada_ProdutoController.apagarEntradaProduto
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Pagamento_compras
router.get(
  "/pagamentos_compras",
  Pagamento_comprasController.listarPagamentosCompras
);
router.post(
  "/pagamentos_compras",
  Pagamento_comprasController.cadastrarPagamentosCompras
); //body
router.patch(
  "/pagamentos_compras/:pag_comp_id",
  Pagamento_comprasController.editarPagamentosCompras
); // params (URL) e body
router.delete(
  "/pagamentos_compras/:pag_comp_id",
  Pagamento_comprasController.apagarPagamentosCompras
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Produto_lote
router.get("/produtolote", Produto_loteController.listarProdutosLote);
router.post("/produtolote", Produto_loteController.cadastrarProdutoLote); //body
router.patch(
  "/produtolote/:prod_lote_id",
  Produto_loteController.editarProdutoLote
); // params (URL) e body
router.delete(
  "/produtolote/:prod_lote_id",
  Produto_loteController.apagarProdutoLote
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Categorias
router.get("/categorias", CategoriaController.listarCategorias);
router.post("/categorias", CategoriaController.cadastrarCategoria); //body
router.patch("/categorias/:cate_id", CategoriaController.editarCategoria); // params (URL) e body
router.delete("/categorias/:cate_id", CategoriaController.apagarCategoria); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Promocoes
router.get("/promocoes", PromocoesController.listarPromocoes);
router.post("/promocoes", PromocoesController.cadastrarPromocao); //body
router.patch("/promocoes/:prom_id", PromocoesController.editarPromocao); // params (URL) e body
router.delete("/promocoes/:prom_id", PromocoesController.apagarPromocao); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Produto_Promo
router.get("/produtopromo", ProdutoPromoController.listarProdutoPromocoes);
router.post("/produtopromo", ProdutoPromoController.cadastrarProdutoPromocao); //body
router.patch(
  "/produtopromo/:prod_prom_id",
  ProdutoPromoController.editarProdutoPromocao
); // params (URL) e body
router.delete(
  "/produtopromo/:prod_prom_id",
  ProdutoPromoController.apagarProdutoPromocao
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Vendas
router.get("/vendas", VendasController.listarVendas);
router.get("/vendas/ultima", VendasController.listarUltimaVenda);
router.get("/vendas/mes", VendasController.totalVendasMes);
router.post("/vendas/cadastro", VendasController.cadastrarVenda); //body
router.patch("/vendas/:venda_id", VendasController.editarVenda); // params (URL) e body
router.delete("/vendas/:venda_id", VendasController.apagarVenda); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Venda_Produto
router.get("/vendaprod", VendaProdutoController.listarVendaProdutos);
router.post("/vendaprod", VendaProdutoController.cadastrarVendaProduto); //body
router.patch(
  "/vendaprod/:venda_prod_id",
  VendaProdutoController.editarVendaProduto
); // params (URL) e body
router.delete(
  "/vendaprod/:venda_prod_id",
  VendaProdutoController.apagarVendaProduto
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Pagamento_Venda
router.get("/pagvenda", PagamentoVendaController.listarPagamentosVendas);
router.post("/pagvenda", PagamentoVendaController.cadastrarPagamentoVenda); //body
router.patch(
  "/pagvenda/:venda_prod_id",
  PagamentoVendaController.editarPagamentoVenda
); // params (URL) e body
router.delete(
  "/pagvenda/:venda_prod_id",
  PagamentoVendaController.apagarPagamentoVenda
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Quantidade_Produto
router.get("/qtdprod", QtdProdutoController.listarQtdProdutos);
router.get("/analiseProd", AnaliseProdController.analiseProd);
router.patch("/prodAtivar/:prod_id", AnaliseProdController.ativarProduto);
router.patch("/prodInativar/:prod_id", AnaliseProdController.ocultarProduto);
router.get("/qtdprod/Ativos", AnaliseProdController.listarProdutosAtivos); // listar os produtos ativos
router.get(
  "/qtdprod/PesquisarAtivos",
  AnaliseProdController.pesquisarProdutosAtivos
); // pesquisar os produtos ativos
router.get("/qtdprod/Inativos", AnaliseProdController.listarProdutosInativos); // listar os produtos inativos
router.get(
  "/qtdprod/PesquisarInativos",
  AnaliseProdController.pesquisarProdutosInativos
); // pesquisar os produtos inativos
router.post("/qtdprod", QtdProdutoController.cadastrarQtdProduto); //body
router.get("/qtdprod/totalprodutos", QtdProdutoController.TotalProdutos);
router.patch("/qtdprod/:qtd_prod_id", QtdProdutoController.editarQtdProduto); // params (URL) e body
router.delete("/qtdprod/:qtd_prod_id", QtdProdutoController.apagarQtdProduto); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Transporte
router.get("/transporte", TransporteController.listarTransportes);
router.post("/transporte", TransporteController.cadastrarTransporte); //body
router.patch("/transporte/:transp_id", TransporteController.editarTransporte); // params (URL) e body
router.delete("/transporte/:transp_id", TransporteController.apagarTransporte); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Devolucoes
router.get("/devolucao", DevolucaoController.listarDevolucoes);
router.post("/devolucao", DevolucaoController.cadastrarDevolucao); //body
router.patch("/devolucao/:transp_id", DevolucaoController.editarDevolucao); // params (URL) e body
router.delete("/devolucao/:transp_id", DevolucaoController.apagarDevolucao); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Salarios
router.get("/salario", SalarioController.listarSalarios);
router.post("/salario", SalarioController.cadastrarSalario); //body
router.patch("/salario/:transp_id", SalarioController.editarSalario); // params (URL) e body
router.delete("/salario/:transp_id", SalarioController.apagarSalario); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Holerites
router.get("/holerite", HoleriteController.listarHolerites);
router.post("/holerite", HoleriteController.cadastrarHolerite); //body
router.patch("/holerite/:holerite_id", HoleriteController.editarHolerite); // params (URL) e body
router.delete("/holerite/:holerite_id", HoleriteController.apagarHolerite); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Api_Key
router.get("/apikey", ApiKeyController.listarApiKeys);
router.post("/apikey", ApiKeyController.cadastrarApiKey); //body
router.patch("/apikey/:api_key_id", ApiKeyController.editarApiKey); // params (URL) e body
router.delete("/apikey/:api_key_id", ApiKeyController.apagarApiKey); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Permissoes
router.get("/permissoes", PermissoesController.listarPermissoes);
router.post("/permissoes", PermissoesController.cadastrarPermissao); //body
router.patch("/permissoes/:api_key_id", PermissoesController.editarPermissao); // params (URL) e body
router.delete("/permissoes/:api_key_id", PermissoesController.apagarPermissao); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Usuarios_Permissoes
router.get(
  "/usupermissoes",
  UsuariosPermissoesController.listarUsuariosPermissoes
);
router.post(
  "/usupermissoes",
  UsuariosPermissoesController.cadastrarUsuarioPermissao
); //body
router.patch(
  "/usupermissoes/:usu_perm_id",
  UsuariosPermissoesController.editarUsuarioPermissao
); // params (URL) e body
router.delete(
  "/usupermissoes/:usu_perm_id",
  UsuariosPermissoesController.apagarUsuarioPermissao
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Inventario
router.get("/inventario", InventarioController.listarInventarios);
router.post("/inventario", InventarioController.cadastrarInventario); //body
router.patch("/inventario/:inv_id", InventarioController.editarInventario); // params (URL) e body
router.delete("/inventario/:inv_id", InventarioController.apagarInventario); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Notificacao
router.get("/notificacao", NotificacaoController.listarNotificacoes);
router.post("/notificacao", NotificacaoController.cadastrarNotificacao); //body
router.patch("/notificacao/:noti_id", NotificacaoController.editarNotificacao); // params (URL) e body
router.delete("/notificacao/:noti_id", NotificacaoController.apagarNotificacao); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Relatorio
router.get("/relatorio", RelatorioController.listarRelatorios);
router.post("/relatorio", RelatorioController.cadastrarRelatorio); //body
router.patch("/relatorio/:relat_id", RelatorioController.editarRelatorio); // params (URL) e body
router.delete("/relatorio/:relat_id", RelatorioController.apagarRelatorio); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Backup
router.get("/backup", BackupController.listarBackups);
router.post("/backup_auto", BackupController.backupAutomatico);
router.post("/backup_recuperar", BackupController.restaurarBackup);
router.get("/backup_download", BackupController.downloadBackup);
router.post("/backup/realizar", BackupController.cadastrarBackup); //body
router.patch("/backup/:backup_id", BackupController.editarBackup); // params (URL) e body
router.delete("/backupdelete/:backup_id", BackupController.apagarBackup); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Recuperar_Dados
router.get("/recuperardados", RecuperarDadosController.listarRecuperacoes);
router.post("/recuperardados", RecuperarDadosController.cadastrarRecuperacao); //body
router.patch(
  "/recuperardados/:rec_dados_id",
  RecuperarDadosController.editarRecuperacao
); // params (URL) e body
router.delete(
  "/recuperardados/:rec_dados_id",
  RecuperarDadosController.apagarRecuperacao
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Historico_Login
router.get("/historicologin", HistoricoLoginController.listarHistoricoLogins);
router.post(
  "/historicologin",
  HistoricoLoginController.cadastrarHistoricoLogin
); //body
router.patch(
  "/historicologin/:rec_dados_id",
  HistoricoLoginController.editarHistoricoLogin
); // params (URL) e body
router.delete(
  "/historicologin/:rec_dados_id",
  HistoricoLoginController.apagarHistoricoLogin
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

//Produto_Categoria
router.get(
  "/produtocategoria",
  ProdutoCategoriaController.listarProdutoCategorias
);
router.post(
  "/produtocategoria",
  ProdutoCategoriaController.cadastrarProdutoCategoria
); //body
router.patch(
  "/produtocategoria/:pca_id",
  ProdutoCategoriaController.editarProdutoCategoria
); // params (URL) e body
router.delete(
  "/produtocategoria/:pca_id",
  ProdutoCategoriaController.apagarProdutoCategoria
); // params (URL)
//router.delete('/produtos/del/:prod_id',ProdutosController.apagarTipoUsuario); // params (URL)

module.exports = router;
