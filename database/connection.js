const sql = require('mssql');

const bd_usuario = 'sa';
const bd_senha = '123456';
const bd_servidor = 'VINNYRAFA';
const bd_porta = 1433;  // Porta do SQL Server deve ser número
const bd_banco = 'banco@sinqia';

// Configuração da conexão com o SQL Server
const config = {
    user: bd_usuario,
    password: bd_senha,
    server: bd_servidor,
    port: bd_porta,  
    database: bd_banco,
    options: {
        encrypt: true,  
        trustServerCertificate: true, 
    }
};

// Função para conectar e retornar a pool de conexões
const connect = async () => {
    try {
        const pool = await sql.connect(config);  // Aguardando a conexão ser estabelecida
        console.log('Conectado ao SQL Server');
        return pool;  // Retorna o pool para ser usado em outras partes do código
    } catch (error) {
        console.error('Erro ao conectar ao SQL Server:', error);
        throw error;  // Lança o erro para ser tratado na chamada
    }
};

module.exports = { connect };  // Exporta a função para ser usada em outras partes do código
