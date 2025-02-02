const db = require("../database/connection"); 
const sql = require("mssql"); 

const bcrypt = require("bcryptjs"); // Usando bcrypt para criptografar as senhas
const jwt = require("jsonwebtoken"); // Autenticação para controle de acesso



module.exports = {

  // Função para listar usuários
  async listarUsuarios(request, response) {
    try {
      const pool = await db.connect(); // Conectando ao banco de dados

      // Realizando a consulta SQL
      const resultado = await pool.request().query('SELECT * FROM usuarios');

      const usuarios = resultado.recordset; // Armazenando os usuários retornados
      const nItens = usuarios.length; // Contando o número de itens

      // Respondendo com sucesso
      return response.status(200).json({
        sucesso: true,
        mensagem: "Lista de usuários.",
        dados: usuarios,
        nItens,
      });
    } catch (error) {
      // Em caso de erro
      return response.status(500).json({
        sucesso: false,
        mensagem: "Erro na requisição.",
        dados: error.message,
      });
    }
  },

  async listarUsuarioUnico(request, response) {
    try {
      const pool = await db.connect(); // Conectando ao banco de dados

      // Realizando a consulta SQL
      const resultado = await pool.request().query('SELECT * FROM usuarios');

      const usuarios = resultado.recordset; // Armazenando os usuários retornados
      const nItens = usuarios.length; // Contando o número de itens

      // Respondendo com sucesso
      return response.status(200).json({
        sucesso: true,
        mensagem: "Lista de usuários.",
        dados: usuarios,
        nItens,
      });
    } catch (error) {
      // Em caso de erro
      return response.status(500).json({
        sucesso: false,
        mensagem: "Erro na requisição.",
        dados: error.message,
      });
    }
  },

  // Função para cadastrar usuário
  async cadastrarUsuarios(request, response) {
    try {
      // Desestruturando os dados da requisição
      const { usu_nome, usu_email, usu_senha } = request.body;
  
      // Verificando se os campos obrigatórios foram fornecidos
      if (!usu_nome || !usu_email || !usu_senha) {
        return response.status(400).json({
          sucesso: false,
          mensagem: "Nome, e-mail e senha são obrigatórios.",
        });
      }
  
      const pool = await db.connect(); // Conectando ao banco de dados
  
      // Verificando se o e-mail já existe
      const checkEmailSql = "SELECT COUNT(*) AS count FROM usuarios WHERE usu_email = @usu_email";
      const result = await pool.request()
        .input("usu_email", db.sql.VarChar(100), usu_email)  // Usando db.sql.VarChar
        .query(checkEmailSql);
  
      if (result.recordset[0].count > 0) {
        return response.status(409).json({
          sucesso: false,
          mensagem: "E-mail já cadastrado.",
        });
      }
  
      // Criptografando a senha antes de salvar
      const hashedPassword = await bcrypt.hash(usu_senha, 10); // Usando bcrypt para gerar hash da senha
  
      // Inserindo o novo usuário no banco
      const insertSql = `
        INSERT INTO usuarios (usu_nome, usu_email, usu_senha, usu_data_cadastro, usu_senha_provisoria)
        VALUES (@usu_nome, @usu_email, @usu_senha, GETDATE(), 0);
      `;
      const insertResult = await pool.request()
        .input("usu_nome", db.sql.VarChar(100), usu_nome)
        .input("usu_email", db.sql.VarChar(100), usu_email)
        .input("usu_senha", db.sql.VarChar(255), hashedPassword)  // Usando a senha criptografada
        .query(insertSql);
  
      // Retornando a resposta de sucesso
      return response.status(201).json({
        sucesso: true,
        mensagem: "Usuário cadastrado com sucesso.",
        dados: {
          usu_nome,
          usu_email,
        },
      });
    } catch (error) {
      // Tratamento de erros
      console.error("Erro ao cadastrar usuário:", error);
      return response.status(500).json({
        sucesso: false,
        mensagem: "Erro interno no servidor.",
        dados: error.message,
      });
    }
  },

  //função para login do usuario
  async loginUsuario(request, response) {
    const { usu_email, usu_senha } = request.body;

    try {
        const pool = await db.connect(); // Usando sua conexão já configurada

        const sqlQuery = `
            SELECT usu_id, usu_nome, usu_email, usu_senha 
            FROM usuarios 
            WHERE usu_email = @usu_email
        `;

        const result = await pool.request()
            .input("usu_email", sql.VarChar, usu_email)
            .query(sqlQuery);

        if (result.recordset.length === 0) {
            return response.status(401).json({
                sucesso: false,
                mensagem: "Email ou senha incorretos."
            });
        }

        const usuarioEncontrado = result.recordset[0];

        const senhaValida = await bcrypt.compare(usu_senha, usuarioEncontrado.usu_senha);

        if (!senhaValida) {
            return response.status(401).json({
                sucesso: false,
                mensagem: "Email ou senha incorretos."
            });
        }

        return response.status(200).json({
            sucesso: true,
            mensagem: "Login efetuado com sucesso.",
            dados: {
                usu_id: usuarioEncontrado.usu_id,
                usu_nome: usuarioEncontrado.usu_nome,
                usu_email: usuarioEncontrado.usu_email
            }
        });

    } catch (error) {
        console.error("Erro na requisição:", error);
        return response.status(500).json({
            sucesso: false,
            mensagem: "Erro na requisição.",
            erro: error.message
        });
    }
},

};


//funções
