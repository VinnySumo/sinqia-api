const db = require('../database/connection');

module.exports = {
 async listarComentarios(request, response) {
         try {
           
           // Chama a função de conexão para obter a pool
           const pool = await db.connect();  
     
           // Realiza a consulta SQL
           const resultado = await pool.request().query('SELECT * FROM comentarios');
     
           // Resultado da consulta
           const comentario = resultado.recordset;  
           const nItens = comentario.length;
     
           return response.status(200).json({
             sucesso: true,
             mensagem: "Lista de comentarios do pontos turisticos.",
             dados: comentario,
             nItens,
           });
         } catch (error) {
           return response.status(500).json({
             sucesso: false,
             mensagem: "Erro na requisição.",
             dados: error.message,
           });
         }
       },
}
