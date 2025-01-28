const db = require("../database/connection");


const bcrypt = require("bcryptjs");
//deixar a senha com criptografia

// Importação do serviço de e-mail
const sgMail = require("@sendgrid/mail");

// Configurando a chave API do envio de e-mail
// sgMail.setApiKey(
//   ""
// ); // Substitua com a sua chave API do SendGrid

module.exports = {
  async listarUsuarios(request, response) {
    try {

      // Chama a função de conexão para obter a pool
      const pool = await db.connect();  

      // Realiza a consulta SQL
      const resultado = await pool.request().query('SELECT * FROM usuarios');

      // Resultado da consulta
      const usuarios = resultado.recordset;  
      const nItens = usuarios.length;

      return response.status(200).json({
        sucesso: true,
        mensagem: "Lista de usuários.",
        dados: usuarios,
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


  async cadastrarUsuarios(request, response) {
    try {
      const {
        usu_nome,
        usu_sexo,
        usu_data_nascimento,
        usu_email,
        usu_senha, // Essa variável será usada para armazenar a senha gerada, se necessário
        tus_cod,
        usu_cpf,
        end_logradouro,
        end_cidade,
        end_estado,
        end_cep,
        tel_primario,
      } = request.body;

      // Verifica se todos os campos obrigatórios foram fornecidos, exceto senha quando tus_cod é 2 (cliente)
      if (
        !usu_nome ||
        !usu_email ||
        !usu_data_nascimento ||
        !tus_cod ||
        !end_logradouro ||
        !end_cidade ||
        !end_estado ||
        !end_cep
      ) {
        return response.status(400).json({
          sucesso: false,
          mensagem: "Todos os campos são obrigatórios.",
          dados: null,
        });
      }

      // Verifica se já existe um usuário com o mesmo e-mail
      const checkEmailSql =
        "SELECT COUNT(*) AS count FROM usuarios WHERE usu_email = $1";
      const [checkEmailResult] = await db.query(checkEmailSql, [usu_email]);

      if (checkEmailResult[0].count > 0) {
        return response.status(409).json({
          sucesso: false,
          mensagem: "E-mail já cadastrado.",
          dados: null,
        });
      }

      // Cadastro do endereço
      const enderecoSql = `INSERT INTO enderecos 
                            (end_logradouro, end_cidade, end_estado, end_cep) 
                            VALUES ($1, $2, $3, $4)`;
      const enderecoValues = [end_logradouro, end_cidade, end_estado, end_cep];
      const [enderecoResult] = await db.query(enderecoSql, enderecoValues);
      const end_id = enderecoResult.insertId;

      // Se tus_cod for 3 (funcionário), gera uma senha provisória
      let senha = usu_senha; // Define a senha inicial como a senha fornecida
      let usu_senha_provisoria = 0; // 0 para inativo por padrão

      if (tus_cod === 3 && !usu_senha) {
        // Gera uma senha provisória se tus_cod for 3 e a senha não foi fornecida
        const [senhaResult] = await db.query("SELECT fn_GerarSenha() AS senha");
        senha = senhaResult[0].senha;
        usu_senha_provisoria = 1; // Marca como senha provisória
      } else if (tus_cod === 2) {
        // Se for um cliente (tus_cod = 2), a senha permanece nula
        senha = null;
      }

      // Cadastro do telefone primário
      const telefoneSql = `INSERT INTO telefones (tel_primario) VALUES ($1)`;
      const [telefoneResult] = await db.query(telefoneSql, [tel_primario]);
      const tel_id = telefoneResult.insertId;

      // Cadastro do usuário com o ID do telefone e do endereço
      const usuarioSql = `INSERT INTO usuarios 
                            (usu_nome, usu_sexo, usu_data_nascimento, usu_email, usu_senha, 
                             usu_data_cadastro, tus_cod, usu_ativo, usu_cpf, end_id, tel_id, usu_senha_provisoria) 
                            VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)`;
      const usuarioValues = [
        usu_nome,
        usu_sexo,
        new Date(usu_data_nascimento).toISOString().split("T")[0],
        usu_email,
        senha, // A senha gerada automaticamente será usada aqui, se aplicável
        new Date().toISOString().split("T")[0],
        tus_cod,
        usu_cpf,
        end_id,
        tel_id,
        usu_senha_provisoria, // O status de senha provisória será usado aqui
      ];
      const [usuarioResult] = await db.query(usuarioSql, usuarioValues);
      const usu_id = usuarioResult.insertId;

      // Atualiza o telefone com o ID do usuário
      const atualizarTelefoneSql = `UPDATE telefones SET usu_id = $1 WHERE tel_id = $2`;
      await db.query(atualizarTelefoneSql, [usu_id, tel_id]);

      // Enviar o e-mail para o funcionário se for um funcionário (tus_cod = 3)
      if (tus_cod === 3 && senha) {
        const msg = {
          to: usu_email, // Destinatário do e-mail
          from: {
            email: "satemailenvio@gmail.com", // E-mail de envio
            name: "Sat-Sistema Administrativo", // Nome que aparecerá no campo de envio
          },
          subject: "Sua senha provisória",
          text: `Olá ${usu_nome},\n\nSua senha provisória é: ${senha}\n\nPor favor, altere sua senha assim que possível.`,
          html: `<p>Olá ${usu_nome},</p><p>Sua senha provisória é: <strong>${senha}</strong></p><p>Por favor, altere sua senha assim que possível.</p>`,
        };

        // Envia o e-mail usando o SendGrid
        try {
          await sgMail.send(msg);
          console.log("E-mail enviado com sucesso!");
        } catch (error) {
          console.error("Erro ao enviar e-mail:", error);
        }
      }

      // Retorna sucesso ao final do processo
      return response.status(200).json({
        sucesso: true,
        mensagem:
          "Cadastro de usuário, endereço e telefone efetuado com sucesso.",
        dados: { usu_id, end_id, tel_id },
      });
    } catch (error) {
      console.error("Erro ao cadastrar usuário, endereço e telefone:", error);
      return response.status(500).json({
        sucesso: false,
        mensagem: "Erro na requisição.",
        dados: error.message,
      });
    }
  },

  async editarUsuarios(request, response) {
    try {
      const { usu_perfil_foto, usu_nome, usu_sexo, usu_email, usu_cpf } =
        request.body;
      const { usu_id } = request.params;

      if (!usu_email || !usu_sexo) {
        return response.status(400).json({
          sucesso: false,
          mensagem:
            "Campos obrigatórios (email, sexo, senha) não podem estar vazios.",
        });
      }

      const sql = `UPDATE usuarios SET
                    usu_perfil_foto = ?,
                    usu_nome = ?, 
                    usu_sexo = ?, 
                    usu_email = ?,            
                    usu_cpf = ?
                  WHERE usu_id = ?`;

      const values = [
        usu_perfil_foto || null, // Idem para a foto
        usu_nome,
        usu_sexo,
        usu_email,

        usu_cpf || null, // Se não enviar o CPF, mantém como null
        usu_id,
      ];

      const atualizaDados = await db.query(sql, values);

      return response.status(200).json({
        sucesso: true,
        mensagem: `Usuário ${usu_id} atualizado com sucesso!`,
        dados: atualizaDados[0].affectedRows,
      });
    } catch (error) {
      console.error("Erro na requisição:", error);
      return response.status(500).json({
        sucesso: false,
        mensagem: "Erro na requisição.",
        dados: error.message,
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

  async loginUsuario(request, response) {
    const { usu_email, usu_senha } = request.body;

    

    try {
      // Instruções SQL para verificar se o usuário existe e as credenciais estão corretas
      const sql = `
            SELECT 
                usu_id, usu_nome, usu_email, usu_senha, usu_perfil_foto, tus_cod, usu_senha_provisoria
            FROM 
                usuarios
            WHERE 
                usu_email = $1  AND usu_ativo = 1
        `;

      // Executa a query com os parâmetros fornecidos
      const usuario = await db.query(sql, [usu_email]);

     

      // Verifica se um usuário foi encontrado
      if (usuario.rows.length > 0) {  
        const usuarioEncontrado = usuario.rows[0];

       

        const senhaProvisoria = usuarioEncontrado.usu_senha_provisoria === 1;

        const senhaProvisoriaCorreta =
          usuarioEncontrado.usu_senha === usu_senha;

        if (senhaProvisoria && senhaProvisoriaCorreta) {
          return response.status(200).json({
            sucesso: true,
            mensagem: "Login efetuado com sucesso.",
            dados: {
              usu_id: usuarioEncontrado.usu_id,
              usu_nome: usuarioEncontrado.usu_nome,
              usu_email: usuarioEncontrado.usu_email,
              usu_perfil_foto: usuarioEncontrado.usu_perfil_foto,
              tus_cod: usuarioEncontrado.tus_cod,
              senhaProvisoria: senhaProvisoria,
            },
          });
        }

        const senhaValida = await bcrypt.compare(
          usu_senha,
          usuarioEncontrado.usu_senha
        );

       

        if (!senhaValida) {
          return response.status(401).json({
            sucesso: false,
            mensagem: "Email ou senha inválidos",  
          });
        }

        return response.status(200).json({
          sucesso: true,
          mensagem: "Login efetuado com sucesso.",
          dados: {
            usu_id: usuarioEncontrado.usu_id,
            usu_nome: usuarioEncontrado.usu_nome,
            usu_email: usuarioEncontrado.usu_email,
            usu_perfil_foto: usuarioEncontrado.usu_perfil_foto,
            tus_cod: usuarioEncontrado.tus_cod,
            senhaProvisoria: senhaProvisoria,
          },
        });
      } else {
        return response.status(401).json({
          sucesso: false,
          mensagem: "Email ou senha incorretos.",
        });
      }
    } catch (error) {
      console.log('Erro na requisição:', error);  // Log do erro
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
