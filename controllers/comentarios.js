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

    async cadastrarTipoEndereco(request, response) {
        try {
            const { ten_descricao } = request.body;
            const sql = 'INSERT INTO tipo_endereco (ten_descricao) VALUES (?);';
            const values = [ten_descricao];
            const execSql = await db.query(sql, values);
            const ten_cod = execSql[0].insertId;

            return response.status(200).json({
                sucesso: true,
                mensagem: 'Cadastro de tipo de endereço efetuado com sucesso.',
                dados: ten_cod
            });
        } catch (error) {
            return response.status(500).json({
                sucesso: false,
                mensagem: 'Erro na requisição.',
                dados: error.message
            });
        }
    },

    async editarTipoEndereco(request, response) {
        try {
            const { ten_descricao } = request.body;
            const { ten_cod } = request.params;
            const sql = 'UPDATE tipo_endereco SET ten_descricao = ? WHERE ten_cod = ?;';
            const values = [ten_descricao, ten_cod];
            const atualizaDados = await db.query(sql, values);

            return response.status(200).json({
                sucesso: true,
                mensagem: `Tipo de endereço ${ten_cod} atualizado com sucesso!`,
                dados: atualizaDados[0].affectedRows
            });
        } catch (error) {
            return response.status(500).json({
                sucesso: false,
                mensagem: 'Erro na requisição.',
                dados: error.message
            });
        }
    },

    async apagarTipoEndereco(request, response) {
        try {
            const { ten_cod } = request.params;
            const sql = 'DELETE FROM tipo_endereco WHERE ten_cod = ?;';
            const values = [ten_cod];
            const excluir = await db.query(sql, values);

            return response.status(200).json({
                sucesso: true,
                mensagem: `Tipo de endereço ${ten_cod} excluído com sucesso.`,
                dados: excluir[0].affectedRows
            });
        } catch (error) {
            return response.status(500).json({
                sucesso: false,
                mensagem: 'Erro na requisição.',
                dados: error.message
            });
        }
    }
}
