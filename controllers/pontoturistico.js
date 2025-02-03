const db = require('../database/connection');

const moment = require("moment-timezone");



module.exports = {

    async listarPontoTuristicos(request, response) {
        
        try {
            // Conecta ao banco
            const pool = await db.connect();  
    
            // Executa a consulta
            const resultado = await pool.request().query('SELECT * FROM pontosturisticos');
    
            // Formata os resultados
            const pturisto = resultado.recordset.map(ponto => ({
                ...ponto,
                pont_data_inclusao: moment.utc(ponto.pont_data_inclusao).tz("America/Sao_Paulo").format("DD/MM/YYYY HH:mm:ss") // Formata a data para o horario e data brasileiro
            }));
    
            return response.status(200).json({
                sucesso: true,
                mensagem: "Lista de pontos turísticos.",
                dados: pturisto,
                nItens: pturisto.length
            });
        } catch (error) {
            return response.status(500).json({
                sucesso: false,
                mensagem: "Erro na requisição.",
                dados: error.message
            });
        }
      },

      async listarPontoUnico(request, response) {
        try {
            // Passo 1: Obter o ID do ponto turístico da URL
            const pontoId = request.params.pont_id; // O parâmetro da URL é 'pont_id'
    
            // Passo 2: Verificar se o pontoId foi fornecido e é válido (número)
            if (!pontoId || isNaN(pontoId)) {
                return response.status(400).json({
                    sucesso: false,
                    mensagem: "ID do ponto turístico inválido ou não fornecido."
                });
            }
    
            // Passo 3: Conectar ao banco de dados
            const pool = await db.connect();
    
            // Passo 4: Fazer a consulta SQL, usando o tipo correto para o parâmetro
            const resultado = await pool.request()
            .query(`SELECT * FROM pontosturisticos WHERE pont_id = ${pontoId}`);
    
            // Passo 5: Verificar se o ponto turístico foi encontrado
            if (resultado.recordset.length === 0) {
                return response.status(404).json({
                    sucesso: false,
                    mensagem: "Ponto turístico não encontrado."
                });
            }
    
            // Passo 6: Formatar a data de inclusão para o formato correto
            const ponto = resultado.recordset[0]; // Só existe um ponto, então pegamos o primeiro
            const pturisto = {
                ...ponto,
                pont_data_inclusao: moment(ponto.pont_data_inclusao)
                    .tz("America/Sao_Paulo")
                    .format("DD/MM/YYYY HH:mm:ss") // Formata para o formato de data brasileiro
            };
    
            // Passo 7: Retornar o ponto turístico encontrado
            return response.status(200).json({
                sucesso: true,
                mensagem: "Ponto turístico encontrado.",
                dados: pturisto
            });
    
        } catch (error) {
            // Passo 8: Capturar erro e retornar mensagem de erro
            return response.status(500).json({
                sucesso: false,
                mensagem: "Erro na requisição.",
                dados: error.message
            });
        }
      },
      
    
      async cadastrarPontoTuristico(request, response) {
        try {
            const { pont_nome, pont_descricao, pont_localizacao, pont_cidade, pont_estado } = request.body;
    
            // Validação dos campos
            if (!pont_nome || !pont_descricao || !pont_localizacao || !pont_cidade || !pont_estado) {
                return response.status(400).json({
                    sucesso: false,
                    mensagem: "Por favor, preencha todos os campos obrigatórios."
                });
            }
    
            // Ajusta a data para o fuso horário de São Paulo
            const pont_data_inclusao = moment().tz("America/Sao_Paulo").format("YYYY-MM-DD HH:mm:ss");
    
            // Conecta ao banco
            const pool = await db.connect();
    
            // Insere o ponto turístico
            await pool.request()
                .input("pont_nome", pont_nome)
                .input("pont_descricao", pont_descricao)
                .input("pont_localizacao", pont_localizacao)
                .input("pont_cidade", pont_cidade)
                .input("pont_estado", pont_estado)
                .input("pont_data_inclusao", pont_data_inclusao)
                .query(
                    `INSERT INTO pontosturisticos (pont_nome, pont_descricao, pont_localizacao, pont_cidade, pont_estado, pont_data_inclusao)
                    VALUES (@pont_nome, @pont_descricao, @pont_localizacao, @pont_cidade, @pont_estado, @pont_data_inclusao)`
                );
    
            return response.status(201).json({
                sucesso: true,
                mensagem: "Ponto turístico cadastrado com sucesso."
            });
        } catch (error) {
            console.error("Erro ao cadastrar ponto turístico:", error);
            return response.status(500).json({
                sucesso: false,
                mensagem: "Erro ao cadastrar ponto turístico.",
                dados: error.message
            });
        }
    },
    

    async editarPontoTuristico(request, response) {
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
    

    async apagarPontoTuristico(request, response) {
        try {
            const { pont_id } = request.params; // Obtém o ID do ponto turístico da URL
    
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
