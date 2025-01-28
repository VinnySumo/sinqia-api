const express = require("express");
const router = express.Router();

// referência a controllers que serão utilizados nas rotas
const UsuariosController = require("../controllers/usuarios");
const ComentariosController = require("../controllers/comentarios");
const PontoTuristicoController = require("../controllers/pontoturistico");



//Usuarios

router.post("/loginUsuario", UsuariosController.loginUsuario); //login
router.patch("/usuarios/alterar_senha",UsuariosController.alterarSenha);
router.post("/recuperar_senha", UsuariosController.recuperarSenha);
router.get("/usuarios", UsuariosController.listarUsuarios); //listar usuarios geral
router.post("/usuarioscadastro", UsuariosController.cadastrarUsuarios); //body
router.patch("/usuarios/:usu_id", UsuariosController.editarUsuarios);
router.delete("/usuarios/:usu_id", UsuariosController.apagarUsuarios); // params (URL)
router.patch("/ocultarUsuario/:usu_id", UsuariosController.ocultarUsuario);
router.patch("/ativarUsuario/:usu_id", UsuariosController.AtivarUsuario);


//Comentarios
router.get("/comentario", ComentariosController.listarComentarios);
router.post("/comentario", ComentariosController.cadastrarTipoEndereco); //body
router.patch("/comentario/:ten_cod", ComentariosController.editarTipoEndereco); // params (URL) e body
router.delete("/comentario/:ten_cod", ComentariosController.apagarTipoEndereco); // params (URL)


//Pontos Turisticos
router.get( "/pturistico",PontoTuristicoController.listarPontoTuristicos
);
router.post("/pturistico",PontoTuristicoController.cadastrarTipoPagamentoCompra
); 
router.patch("/pturistico/:tpa_cod",PontoTuristicoController.editarTipoPagamentoCompra
); 
router.delete("/pturistico/:tpa_cod",PontoTuristicoController.apagarTipoPagamentoCompra
); 


module.exports = router;
