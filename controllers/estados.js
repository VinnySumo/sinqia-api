const db = require('../database/connection');


module.exports = {

    async listarEstados(request, response) {
        try {
            // Conecta ao banco
            const pool = await db.connect();  
    
            // Executa a consulta
            const resultado = await pool.request().query('SELECT * FROM estados');
    
            // Retorna a resposta com os dados dos estados
            return response.status(200).json({
                sucesso: true,
                mensagem: "Lista de Estados.",
                dados: resultado.recordset,  // Aqui você usa resultado.recordset que contém os dados
                nItens: resultado.recordset.length  // Aqui você também usa resultado.recordset.length para contar os itens
            });
        } catch (error) {
            return response.status(500).json({
                sucesso: false,
                mensagem: "Erro na requisição.",
                dados: error.message
            });
        }
    },
    

      async cadastrarEstado(request, response) {
        try {
            const { pont_nome, pont_descricao, pont_localizacao, pont_cidade, pont_estado, usu_id } = request.body;
    
            // Ajusta a data para o fuso horário de São Paulo
            const pont_data_inclusao = moment().tz("America/Sao_Paulo").format("YYYY-MM-DD HH:mm:ss");
    
            // Conecta ao banco
            const pool = await db.connect();
    
            // Insere o ponto turístico com a data convertida para o fuso horário correto
            await pool.request()
                .input("pont_nome", pont_nome)
                .input("pont_descricao", pont_descricao)
                .input("pont_localizacao", pont_localizacao)
                .input("pont_cidade", pont_cidade)
                .input("pont_estado", pont_estado)
                .input("pont_data_inclusao", pont_data_inclusao) // Passando a data correta
                .input("usu_id", usu_id)
                .query(`
                    INSERT INTO pontosturisticos (pont_nome, pont_descricao, pont_localizacao, pont_cidade, pont_estado, pont_data_inclusao, usu_id)
                    VALUES (@pont_nome, @pont_descricao, @pont_localizacao, @pont_cidade, @pont_estado, @pont_data_inclusao, @usu_id)
                `);
    
            return response.status(201).json({
                sucesso: true,
                mensagem: "Ponto turístico cadastrado com sucesso."
            });
        } catch (error) {
            return response.status(500).json({
                sucesso: false,
                mensagem: "Erro ao cadastrar ponto turístico.",
                dados: error.message
            });
        }
    },
    

    async editarEstado(request, response) {
        try {
            const { pont_id } = request.params; // Obtém o ID do ponto turístico da URL
            const { pont_nome, pont_descricao, pont_localizacao, pont_cidade, pont_estado } = request.body; // Dados enviados na requisição
    
            // Conectar ao banco
            const pool = await db.connect();
    
            // Executar a atualização
            const resultado = await pool.request()
                .input("pont_id", pont_id)
                .input("pont_nome", pont_nome)
                .input("pont_descricao", pont_descricao)
                .input("pont_localizacao", pont_localizacao)
                .input("pont_cidade", pont_cidade)
                .input("pont_estado", pont_estado)
                .query(`
                    UPDATE pontosturisticos 
                    SET pont_nome = @pont_nome, 
                        pont_descricao = @pont_descricao, 
                        pont_localizacao = @pont_localizacao, 
                        pont_cidade = @pont_cidade, 
                        pont_estado = @pont_estado 
                    WHERE pont_id = @pont_id
                `);
    
            if (resultado.rowsAffected[0] > 0) {
                return response.status(200).json({
                    sucesso: true,
                    mensagem: "Ponto turístico atualizado com sucesso."
                });
            } else {
                return response.status(404).json({
                    sucesso: false,
                    mensagem: "Ponto turístico não encontrado."
                });
            }
        } catch (error) {
            return response.status(500).json({
                sucesso: false,
                mensagem: "Erro ao atualizar o ponto turístico.",
                erro: error.message
            });

        }
    },
    

    async apagarEstado(request, response) {
        try {
            const { p } = request.params; // Obtém o ID do ponto turístico da URL
    
            // Conectar ao banco
            const pool = await db.connect();
    
            // Executar a exclusão
            const resultado = await pool.request()
                .input("pont_id", pont_id)
                .query("DELETE FROM pontosturisticos WHERE pont_id = @pont_id");
    
            if (resultado.rowsAffected[0] > 0) {
                return response.status(200).json({
                    sucesso: true,
                    mensagem: "Ponto turístico removido com sucesso."
                });
            } else {
                return response.status(404).json({
                    sucesso: false,
                    mensagem: "Ponto turístico não encontrado."
                });
            }
        } catch (error) {
            return response.status(500).json({
                sucesso: false,
                mensagem: "Erro ao remover o ponto turístico.",
                erro: error.message
            });
        }
    },
    
}
