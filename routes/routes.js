const express = require("express");
const router = express.Router();

// referência a controllers que serão utilizados nas rotas
const UsuariosController = require("../controllers/usuarios");
const TiposEnderecoController = require("../controllers/tipoendereco");
const TipoPagCompraController = require("../controllers/tipopagcompra");



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

module.exports = router;
