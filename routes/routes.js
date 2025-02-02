const express = require("express");
const router = express.Router();

// referência a controllers que serão utilizados nas rotas
const UsuariosController = require("../controllers/usuarios");
const ComentariosController = require("../controllers/comentarios");
const PontoTuristicoController = require("../controllers/pontoturistico");
const EstadosController = require("../controllers/estados");



//Usuarios
router.post("/loginUsuario", UsuariosController.loginUsuario); //login
router.get("/usuarios", UsuariosController.listarUsuarioUnico); //listar usuarios 
router.get("/usuarios/:usu_id", UsuariosController.listarUsuarios); //listar unico usuario
router.post("/usuarioscadastro", UsuariosController.cadastrarUsuarios); // cadastrar usuario

//Estados
router.get("/estados", EstadosController.listarEstados); //listar 
// router.post("/estadocadastro", EstadosController.cadastrarUsuarios); // cadastrar 
// router.patch("/estado/:es_id", EstadosController.loginUsuario); // atualizar 
// router.delete("/estado/:es_id", EstadosController.loginUsuario); // apagar

//Comentarios 
router.get("/comentario", ComentariosController.listarComentarios); //listar 
router.post("/comentario", ComentariosController.cadastrarTipoEndereco); //cadastrar
router.patch("/comentario/:ten_cod", ComentariosController.editarTipoEndereco); // atualizar
router.delete("/comentario/:ten_cod", ComentariosController.apagarTipoEndereco); // apagar


//Pontos Turisticos
router.get("/pturistico",PontoTuristicoController.listarPontoTuristicos); //listar 
router.get("/pturistico/:pont_id",PontoTuristicoController.listarPontoUnico); //listar unico
router.post("/pturistico/cadastro",PontoTuristicoController.cadastrarPontoTuristico);  //cadastrar
router.patch("/pturistico/:pont_id",PontoTuristicoController.editarPontoTuristico); // atualizar
router.delete("/pturistico/:pont_id",PontoTuristicoController.apagarPontoTuristico); // apagar


module.exports = router;
