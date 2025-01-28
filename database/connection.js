const sql = require('mssql');

const bd_usuario = 'sa';
const bd_senha = '123456';
const bd_servidor = 'localhost\\VINNYRAFA';

const bd_porta = 1433;  // Porta do SQL Server deve ser número
const bd_banco = 'banco@sinqia';

// Configuração da conexão com o SQL Server
const config = {
    user: bd_usuario,
    password: bd_senha,
    server: bd_servidor,
    port: bd_porta,  // Porta do SQL Server, agora definida como número
    database: bd_banco,
    options: {
        encrypt: true,  // Use true se estiver usando criptografia (SSL)
        trustServerCertificate: true,  // Use true para desabilitar a verificação de certificado
    }
};

let pool;

try {
    // Criar uma pool de conexões com o banco de dados
    pool = sql.connect(config).then(pool => {
        console.log('Conectado ao SQL Server');
        return pool;
    }).catch(error => {
        console.error('Erro ao conectar ao SQL Server:', error);
    });
} catch (error) {
    console.log('Erro ao inicializar a conexão:', error);
}

module.exports = pool;
