const db = require("../database/connection"); 
const sql = require("mssql"); 

const bcrypt = require("bcryptjs"); // Usando bcrypt para criptografar as senhas
const jwt = require("jsonwebtoken"); // Autenticação para controle de acesso

// Importação do serviço de e-mail (caso queira utilizar futuramente)
const sgMail = require("@sendgrid/mail");
// sgMail.setApiKey("YOUR_API_KEY"); // Substitua com sua chave API do SendGrid

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
  
  async ocultarUsuario(request, response) {
    try {
      const { usu_id } = request.params;
      const sql = `UPDATE usuarios SET usu_ativo = 0 where usu_id = ?`;

      const inativa = await db.query(sql, usu_id);

      return response.status(200).json({
        sucesso: true,
        mensagem: `Usuário ${usu_id} inativado com sucesso!`,

        // mensSql: atualizaDados
      });
    } catch (error) {
      return response.status(500).json({
        sucesso: false,
        mensagem: "Erro na requisição.",
        dados: error.message,
      });
    }
  },

  async AtivarUsuario(request, response) {
    try {
      const { usu_id } = request.params;
      const sql = `UPDATE usuarios SET usu_ativo = 1 where usu_id = ?`;

      const inativa = await db.query(sql, usu_id);

      return response.status(200).json({
        sucesso: true,
        mensagem: `Usuário ${usu_id} ativado com sucesso!`,

        // mensSql: atualizaDados
      });
    } catch (error) {
      return response.status(500).json({
        sucesso: false,
        mensagem: "Erro na requisição.",
        dados: error.message,
      });
    }
  },

  async apagarUsuarios(request, response) {
    try {
      // parâmetro passado via url na chamada da api pelo front-end
      const { usu_id } = request.params;
      // comando de exclusão
      const sql = `DELETE FROM usuarios WHERE usu_id = ?`;
      // array com parâmetros da exclusão
      const values = [usu_id];
      // executa instrução no banco de dados
      const excluir = await db.query(sql, values);

      return response.status(200).json({
        sucesso: true,
        mensagem: `Usuário ${usu_id} excluído com sucesso`,
        dados: excluir[0].affectedRows,
      });
    } catch (error) {
      return response.status(500).json({
        sucesso: false,
        mensagem: "Erro na requisição.",
        dados: error.message,
      });
    }
  },

  


  async alterarSenha(request, response) {
    const { senhaAtual, novaSenha, usu_id } = request.body; // Recebe a senha atual, nova senha e o ID do usuário da requisição

    // Verifica se todos os campos necessários foram fornecidos
    if (!senhaAtual || !novaSenha || !usu_id) {
      return response.status(400).json({
        sucesso: false,
        mensagem:
          "Todos os campos (senha atual, nova senha, ID do usuário) devem ser fornecidos.",
      });
    }

    try {
      // 1. Verifique se o usuário existe no banco de dados
      const  usuarioResult  = await db.query(
        `SELECT usu_senha FROM usuarios WHERE usu_id = $1`,
        [usu_id]
      );

      // Extrai os dados do retorno
      const usuario = usuarioResult.rows[0];

      // Verifica se o usuário foi encontrado
      if (!usuario || usuario.length === 0) {
        return response.status(404).json({
          sucesso: false,
          mensagem: "Usuário não encontrado.",
        });
      }

      // 2. Acessando corretamente a senha armazenada
      const senhaArmazenada = usuario[0]?.usu_senha;
      console.log("Senha fornecida: ", senhaAtual);
      console.log("Senha armazenada: ", senhaArmazenada);

      if (!senhaArmazenada) {
        return response.status(500).json({
          sucesso: false,
          mensagem: "A senha atual esta incorreta.",
        });
      }

      // 3. Verifique se a senha atual fornecida corresponde à senha armazenada no banco
      // Comparando diretamente as senhas em texto simples
      const senhaCorreta = senhaAtual === senhaArmazenada;

      if (!senhaCorreta) {
        return response.status(401).json({
          sucesso: false,
          mensagem: "Senha atual incorreta.",
        });
      }

      // 4. Atualize a senha do usuário no banco e defina a flag `usu_senha_provisoria` como 0
      const sql = `
      UPDATE usuarios 
      SET usu_senha = $1, usu_senha_provisoria = 0 
      WHERE usu_id = $2
    `;

      const saltRounds = 10;
      const hashPassword = await bcrypt.hash(novaSenha, saltRounds);
      await db.query(sql, [hashPassword, usu_id]); // A senha é atualizada diretamente como texto simples

      return response.status(200).json({
        sucesso: true,
        mensagem: "Senha alterada com sucesso.",
      });
    } catch (error) {
      console.error("Erro ao alterar a senha:", error);
      return response.status(500).json({
        sucesso: false,
        mensagem: "Ocorreu um erro ao tentar alterar a senha.",
      });
    }
  },

  async recuperarSenha(request, response) {
    const { usu_email } = request.body;

    try {
      // Verifica se o usuário existe
      const sql = `SELECT * FROM usuarios WHERE usu_email = $1`;
      const usuarios = await db.query(sql, [usu_email]);

      // Verifica se a consulta retornou corretamente
    if (!usuarios || !usuarios.rows) {
      return response.status(500).json({ mensagem: "Erro ao buscar usuário no banco de dados." });
    }

    if (usuarios.rows.length === 0) {
      return response.status(404).json({ mensagem: "Email não encontrado." });
    }

      const usuario = usuarios.rows[0];

      // Verifica se o usuário está ativo
      if (usuario.usu_ativo === 0) {
        return response
          .status(403)
          .json({ mensagem: "Usuário inativo. Contate o suporte." });
      }

      // Verifica se o tus_cod é 3
      // if (usuario.tus_cod !== 3) {
      //   return response
      //     .status(403)
      //     .json({ mensagem: "Você não tem permissão para recuperar a senha." });
      // }

      // Chama a função de gerar a senha no banco de dados
      const sqlGerarSenha = `SELECT fn_GerarSenha() AS nova_senha`;
      const resultado = await db.query(sqlGerarSenha);

      const novaSenha = resultado.rows[0].nova_senha; // A senha gerada pela função do banco

      // Atualiza a senha do usuário e ativa a senha provisória
      await db.query(
        `
            UPDATE usuarios 
            SET usu_senha = $1, usu_senha_provisoria = 1 
            WHERE usu_email = $2`,
        [novaSenha, usu_email]
      );

      // Responde ao cliente que a senha foi gerada e enviada
      response.json({
        sucesso: true,
        mensagem: "Uma nova senha foi enviada para seu Email!",
      });

      // Envio do e-mail de forma assíncrona para não bloquear a resposta
      const msg = {
        to: usu_email, // Destinatário do e-mail
        from: {
          email: "satemailenvio@gmail.com", // E-mail de envio
          name: "Sat-Sistema Administrativo", // Nome que aparecerá no campo de envio
        },
        subject: "Recuperação de Senha",
        text: `Olá ${usuario.usu_nome}, sua nova senha é: ${novaSenha}`,
      };

      // Envia o e-mail usando o SendGrid
      try {
        await sgMail.send(msg);
        console.log("E-mail enviado com sucesso!");
      } catch (error) {
        console.error("Erro ao enviar e-mail:", error);
        // Podemos adicionar um tratamento de erro aqui, como registrar no banco ou alertar o admin
      }
    } catch (error) {
      // Em caso de erro no processo geral, retorna um erro 500
      console.error("Erro no processo de recuperação de senha:", error);
      return response
        .status(500)
        .json({ sucesso: false, mensagem: "Erro interno no servidor." });
    }
  },
};


//funções
