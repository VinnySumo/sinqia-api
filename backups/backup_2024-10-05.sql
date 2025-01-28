CREATE TABLE `api_keys` (
  `api_key_id` int(11) NOT NULL AUTO_INCREMENT,
  `api_key_descricao` varchar(255) DEFAULT NULL,
  `api_key_chave` varchar(255) DEFAULT NULL,
  `api_key_dt_criacao` date DEFAULT NULL,
  PRIMARY KEY (`api_key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `backup` (
  `backup_id` int(11) NOT NULL AUTO_INCREMENT,
  `backup_data_hora` datetime DEFAULT NULL,
  `backup_tipo` varchar(50) DEFAULT NULL,
  `backup_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`backup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

INSERT INTO backup (`backup_id`, `backup_data_hora`, `backup_tipo`, `backup_status`) VALUES
(11, '2024-09-27 19:25:40.000', 'Automático', 'Sucesso'),
(12, '2024-09-27 19:28:01.000', 'Automático', 'Sucesso'),
(13, '2024-09-27 19:29:43.000', 'Automático', 'Sucesso'),
(14, '2024-09-30 19:39:26.000', 'Automático', 'Sucesso'),
(15, '2024-09-30 19:39:26.000', 'Automático', 'Sucesso'),
(16, '2024-10-04 10:47:22.000', 'Automático', 'Sucesso'),
(17, '2024-10-04 20:07:44.000', 'Automático', 'Sucesso');

CREATE TABLE `categorias` (
  `cate_id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_nome` varchar(255) DEFAULT NULL,
  `cate_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO categorias (`cate_id`, `cate_nome`, `cate_descricao`) VALUES
(2, 'TEcnologia', ' bvsfdsdaf'),
(3, 'TEcnologia', ' Nomekds sei lá doq isso');

CREATE TABLE `compras` (
  `comp_id` int(11) NOT NULL AUTO_INCREMENT,
  `comp_data` date DEFAULT NULL,
  `forn_id` int(11) DEFAULT NULL,
  `comp_nota` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`comp_id`),
  KEY `forn_id` (`forn_id`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`forn_id`) REFERENCES `fornecedores` (`forn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO compras (`comp_id`, `comp_data`, `forn_id`, `comp_nota`) VALUES
(1, '2024-05-02 00:00:00.000', 1, 'sdsadf'),
(2, '2024-10-10 00:00:00.000', 1, 'ALEXAS'),
(3, '2024-06-14 00:00:00.000', 1, 'ROBO ASPIRADOR- LAMPADA INTELIGENTE '),
(5, '2024-05-02 00:00:00.000', 1, 'TESTEDPFERIAS');

CREATE TABLE `contatos_usu` (
  `id_cont_usu` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `num_endereco` varchar(255) NOT NULL DEFAULT '10',
  `principal` bit(1) NOT NULL,
  `id_usu` int(11) NOT NULL,
  `email_usu` varchar(100) NOT NULL,
  `telefone_usu` varchar(15) NOT NULL,
  `id_end` int(11) NOT NULL,
  PRIMARY KEY (`id_cont_usu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `devolucoes` (
  `devo_id` int(11) NOT NULL AUTO_INCREMENT,
  `venda_prod_id` int(11) DEFAULT NULL,
  `devo_qtd` int(11) DEFAULT NULL,
  `devo_motivo` varchar(255) DEFAULT NULL,
  `devo_data` date DEFAULT NULL,
  PRIMARY KEY (`devo_id`),
  KEY `venda_prod_id` (`venda_prod_id`),
  CONSTRAINT `devolucoes_ibfk_1` FOREIGN KEY (`venda_prod_id`) REFERENCES `venda_produto` (`venda_prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `enderecos` (
  `end_id` int(11) NOT NULL AUTO_INCREMENT,
  `end_logradouro` varchar(255) DEFAULT NULL,
  `end_bairro` varchar(255) DEFAULT NULL,
  `end_cidade` varchar(255) DEFAULT NULL,
  `end_estado` varchar(255) DEFAULT NULL,
  `end_cep` char(8) DEFAULT NULL,
  PRIMARY KEY (`end_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO enderecos (`end_id`, `end_logradouro`, `end_bairro`, `end_cidade`, `end_estado`, `end_cep`) VALUES
(1, 'Cainguangues 1809', 'Tupã Mirim', 'Tupã', 'SP', '17603010'),
(2, 'Cainguangues 1809', 'Tupã Mirim', 'Tupã', 'SP', '17603010');

CREATE TABLE `entrada_produto` (
  `ent_prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `comp_id` int(11) DEFAULT NULL,
  `ent_prod_qtd` int(11) DEFAULT NULL,
  `ent_prod_preco` int(11) DEFAULT NULL,
  `prod_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ent_prod_id`),
  KEY `comp_id` (`comp_id`),
  KEY `prod_id` (`prod_id`),
  CONSTRAINT `entrada_produto_ibfk_1` FOREIGN KEY (`comp_id`) REFERENCES `compras` (`comp_id`),
  CONSTRAINT `entrada_produto_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO entrada_produto (`ent_prod_id`, `comp_id`, `ent_prod_qtd`, `ent_prod_preco`, `prod_id`) VALUES
(1, 1, 1, 1, 1),
(2, 2, 10, 100, 2),
(3, NULL, 10, 90, 7),
(4, NULL, 10, 90, 8),
(5, 3, 40, 90, 9);

CREATE TABLE `fornecedores` (
  `forn_id` int(11) NOT NULL AUTO_INCREMENT,
  `forn_nome` varchar(50) DEFAULT NULL,
  `forn_vendedor` varchar(50) DEFAULT NULL,
  `forn_telefone` varchar(13) DEFAULT NULL,
  `forn_celular` varchar(15) DEFAULT NULL,
  `forn_email` varchar(255) DEFAULT NULL,
  `forn_cnpj` varchar(17) DEFAULT NULL,
  `forn_cpf` varchar(14) DEFAULT NULL,
  `forn_site` varchar(20) DEFAULT NULL,
  `forn_tipo` varchar(20) DEFAULT NULL,
  `forn_ativo` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`forn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

INSERT INTO fornecedores (`forn_id`, `forn_nome`, `forn_vendedor`, `forn_telefone`, `forn_celular`, `forn_email`, `forn_cnpj`, `forn_cpf`, `forn_site`, `forn_tipo`, `forn_ativo`) VALUES
(1, 'bla', 'blas', '14997547353', '14997547', 'luis@gmail.com', NULL, NULL, NULL, NULL, 0),
(2, 'lu', 'Luis Gustavo', '14997547353', '14997547353', 'luisgustavobonfim996@gmail.com', '12122222222222', NULL, NULL, 'juridica', 0),
(3, 'luis', 'Luis Gustavo ', '14997547353', '14997547353', 'luisgustavobonfim996@gmail.com', '12122222222222', NULL, NULL, 'juridica', 1),
(4, 'Luis Gustavo Bonfim Ciaramicoli', 'Luis Gustavo', '14997547353', '14997547353', 'luisgustavobonfim996@gmail.com', NULL, '559.226.898', NULL, 'fisica', 1),
(5, 'Luis Gustavo Bonfim Ciaramicoli', 'Luis Gustavo ', '14997547353', '14997547353', 'luisgustavobonfim996@gmail.com', NULL, '123.456.789', NULL, 'fisica', 1),
(6, 'Luis Gustavo Bonfim Ciaramicoli', 'Luis Gustavo Bonfim Ciaramicoli', '14997547353', '14997092617', 'luisgustavobonfim996@gmail.com', NULL, '123.456.781', NULL, 'fisica', 1),
(7, 'Luis Gustavo Bonfim Ciaramicoli', 'Luis Gustavo Bonfim Ciaramicoli', '14997547353', '14997547353', 'luisgustavobonfim996@gmail.com', NULL, '11111111111', NULL, 'fisica', 1),
(8, 'Luis Gustavo Bonfim Ciaramicoli', 'Luis Gustavo Bonfim Ciaramicoli', '14997547353', '14997547353', 'luisgustavobonfim996@gmail.com', NULL, '12321323432', NULL, 'fisica', 1),
(9, 'Luis Gustavo Bonfim Ciaramicoli', 'Luis Gustavo Bonfim Ciaramicoli', '14997547353', '14997547353', 'luisgustavobonfim996@gmail.com', NULL, '12321343434', NULL, 'fisica', 1),
(10, 'reynaldo', 'Luis Gustavo Bonfim Ciaramicoli', '14997547353', '22344243', 'pedro@oualoookc.com', NULL, '12332422222', NULL, 'fisica', 1),
(11, 'teste 2 fornecedor', 'fornecedor vende', '11445665454', '11445665454', 'teste@hotmail.com', NULL, '55555555555', NULL, 'fisica', 0),
(12, 'Luis Gustavo Bonfim Ciaramicoli', 'Luis Gustavo Bonfim Ciaramicoli', '14997547353', '14997547353', 'luisgustavobonfim9961@gmail.com', NULL, '55922689822', NULL, 'fisica', 0),
(13, 'Vinyyyyyyyyyyyyyy', 'eu', '14997547353', '14997547353', 'vinnyNeymarPedro@gmail.com', NULL, '55922689800', NULL, 'fisica', 0),
(14, 'pedro', 'Reinaldão Das Cria', NULL, 'Luis Gustavo', NULL, NULL, '84528792028', NULL, 'fisica', NULL),
(15, 'Luis Gustavo Bonfim Ciaramicoli', 'Reinaldão Das Cria', NULL, '(14) 99754-7353', 'luisgustavobonfim996@gmail.com', NULL, '84528792028', NULL, 'fisica', NULL),
(16, 'Luis Gustavo Bonfim Ciaramicoli', 'Reinaldão Das Cria', NULL, '(14) 99754-7353', 'luisgustavobonfim996@gmail.com', '12122222222222', NULL, NULL, 'juridica', 0),
(17, 'Luis Gustavo Bonfim Ciaramicoli', 'Reinaldão Das Cria', NULL, '(14) 99754-7353', 'luisgustavobonfim996@gmail.com', NULL, '84528792022', NULL, 'fisica', 0),
(18, 'Luis Gustavo Bonfim Ciaramicoli', 'Reinaldão Das Cria', NULL, '(14) 99754-7353', 'luisgustavobonfim996@gmail.com', NULL, '84528792028', NULL, 'fisica', 0),
(19, 'Luis Gustavo Bonfim Ciaramicoli', 'Reinaldão Das Cria', NULL, '(14) 99754-7353', 'luisgustavobonfim996@gmail.com', NULL, '84528792028', NULL, 'fisica', 0);

CREATE TABLE `historico_login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_id` int(11) DEFAULT NULL,
  `login_data_hora` datetime DEFAULT NULL,
  `login_sucesso` bit(1) DEFAULT NULL,
  `login_ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `historico_login_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `holerites` (
  `holerite_id` int(11) NOT NULL AUTO_INCREMENT,
  `holerite_salario_bruto` int(11) DEFAULT NULL,
  `holerite_data_emissao` date DEFAULT NULL,
  `holerite_descontos` int(11) DEFAULT NULL,
  `holerite_salario_liquido` int(11) DEFAULT NULL,
  `usu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`holerite_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `holerites_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `inventarios` (
  `inv_id` int(11) NOT NULL AUTO_INCREMENT,
  `inv_data` date DEFAULT NULL,
  `inv_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`inv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `notificacoes` (
  `noti_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_id` int(11) DEFAULT NULL,
  `noti_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`noti_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `notificacoes_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pagamentos_compras` (
  `pag_comp_id` int(11) NOT NULL AUTO_INCREMENT,
  `comp_id` int(11) DEFAULT NULL,
  `pag_comp_valor` int(11) DEFAULT NULL,
  `tpa_cod` int(11) DEFAULT NULL,
  PRIMARY KEY (`pag_comp_id`),
  KEY `comp_id` (`comp_id`),
  KEY `tpa_cod` (`tpa_cod`),
  CONSTRAINT `pagamentos_compras_ibfk_1` FOREIGN KEY (`comp_id`) REFERENCES `compras` (`comp_id`),
  CONSTRAINT `pagamentos_compras_ibfk_2` FOREIGN KEY (`tpa_cod`) REFERENCES `tipo_pagamento_compra` (`tpa_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO pagamentos_compras (`pag_comp_id`, `comp_id`, `pag_comp_valor`, `tpa_cod`) VALUES
(1, 1, 150, 1),
(2, 1, 100, 1);

CREATE TABLE `pagamentos_vendas` (
  `pag_venda_id` int(11) NOT NULL AUTO_INCREMENT,
  `venda_id` int(11) DEFAULT NULL,
  `pag_venda_valor` int(11) DEFAULT NULL,
  `pag_venda_data` date DEFAULT NULL,
  `pag_venda_metodo` int(11) DEFAULT NULL,
  PRIMARY KEY (`pag_venda_id`),
  KEY `venda_id` (`venda_id`),
  CONSTRAINT `pagamentos_vendas_ibfk_1` FOREIGN KEY (`venda_id`) REFERENCES `vendas` (`venda_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `permissoes` (
  `perm_id` int(11) NOT NULL AUTO_INCREMENT,
  `perm_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `produto` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_lote_id` int(11) DEFAULT NULL,
  `prod_preco` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

INSERT INTO produto (`prod_id`, `prod_lote_id`, `prod_preco`) VALUES
(1, 6, '5.00'),
(2, 2, '2.00'),
(4, 4, '2.00'),
(5, 3, '2.50'),
(6, 6, '99.00'),
(7, 1, '100.00'),
(8, 1, '100.00'),
(9, 1, '100.00'),
(10, NULL, '1.00'),
(11, 7, '20.00'),
(12, 8, '20.00'),
(13, 9, '22.00'),
(14, 10, '2222.00'),
(15, 11, '22.00'),
(16, 12, '78.00'),
(17, 13, '70.00'),
(18, 14, '22.00'),
(19, 15, '222.00'),
(20, 16, '11.00'),
(21, 17, '34.00');

CREATE TABLE `produto_categoria` (
  `pca_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` int(11) DEFAULT NULL,
  `cate_id` int(11) DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pca_id`),
  KEY `prod_id` (`prod_id`),
  KEY `cate_id` (`cate_id`),
  CONSTRAINT `produto_categoria_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`),
  CONSTRAINT `produto_categoria_ibfk_2` FOREIGN KEY (`cate_id`) REFERENCES `categorias` (`cate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO produto_categoria (`pca_id`, `prod_id`, `cate_id`, `descricao`) VALUES
(1, 7, 2, NULL),
(3, 1, 2, NULL),
(4, 13, 2, NULL),
(5, 14, 2, NULL),
(6, 15, 2, NULL),
(7, 16, 2, NULL),
(8, 17, 2, NULL),
(9, 18, 2, NULL),
(10, 19, 2, NULL),
(11, 20, 2, NULL),
(12, 21, 2, NULL);

CREATE TABLE `produto_lote` (
  `prod_lote_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` int(11) DEFAULT NULL,
  `ent_prod_id` int(11) DEFAULT NULL,
  `prod_lote_nome` varchar(255) DEFAULT NULL,
  `prod_lote_cor` varchar(255) DEFAULT NULL,
  `prod_lote_peso` varchar(255) DEFAULT NULL,
  `prod_lote_medida` varchar(255) DEFAULT NULL,
  `prod_lote_marca` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`prod_lote_id`),
  KEY `prod_id` (`prod_id`),
  KEY `ent_prod_id` (`ent_prod_id`),
  CONSTRAINT `produto_lote_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`),
  CONSTRAINT `produto_lote_ibfk_2` FOREIGN KEY (`ent_prod_id`) REFERENCES `entrada_produto` (`ent_prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

INSERT INTO produto_lote (`prod_lote_id`, `prod_id`, `ent_prod_id`, `prod_lote_nome`, `prod_lote_cor`, `prod_lote_peso`, `prod_lote_medida`, `prod_lote_marca`) VALUES
(1, 1, 1, 'Alexa', 'Preto', '3 kg', '15 CM', 'Amazon'),
(2, 2, 2, 'Fire TV Stick', 'Cinza', '40 g', '9 CM', 'Amazon'),
(3, NULL, NULL, 'Alexa', 'Preto', '3 kg', '15 CM', 'Amazon'),
(4, NULL, NULL, 'Alexa', 'Preto', '3 kg', '15 CM', 'Amazon'),
(5, NULL, NULL, 'Lampada', 'Branca', '200g', '200x20', 'LampadaLux'),
(6, NULL, NULL, 'Lampada', 'Branca', '200g', '200x20', 'LampadaLux'),
(7, NULL, NULL, 'Lampada', 'Branca', '2', 'kg', 'LampadaLux'),
(8, NULL, NULL, 'Lampada', 'Branca', '2', 'kg', 'LampadaLux'),
(9, 4, 4, 'Lampada', 'Branca', '222', 'g', 'LampadaLux'),
(10, 5, 5, 'Lampada', 'amarela', '2222', 'lb', 'LampadaLux'),
(11, NULL, NULL, 'Lampada', 'Preto', '22', 'kg', 'Ryzen'),
(12, NULL, NULL, 'mouse eletro', 'cinza', '400', 'g', 'Lenovo'),
(13, NULL, NULL, 'TV', 'Preto', '30', 'kg', 'LG'),
(14, NULL, NULL, 'google', 'Branca', '2', 'g', 'google'),
(15, NULL, NULL, 'seila', 'ss', '22', 'g', 'ww'),
(16, NULL, NULL, 'Teclado', 'Preto', '2222', 'g', 'Lenovo'),
(17, 21, NULL, 'Lampada', 'Preto', '221', 'kg', 'Ryzen');

CREATE TABLE `produto_promocao` (
  `prod_prom_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` int(11) DEFAULT NULL,
  `prom_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`prod_prom_id`),
  KEY `prod_id` (`prod_id`),
  KEY `prom_id` (`prom_id`),
  CONSTRAINT `produto_promocao_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`),
  CONSTRAINT `produto_promocao_ibfk_2` FOREIGN KEY (`prom_id`) REFERENCES `promocoes` (`prom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `promocoes` (
  `prom_id` int(11) NOT NULL AUTO_INCREMENT,
  `prom_descricao` varchar(255) DEFAULT NULL,
  `prom_desconto` int(11) DEFAULT NULL,
  `prom_data_inicio` date DEFAULT NULL,
  `prom_data_fim` date DEFAULT NULL,
  PRIMARY KEY (`prom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO promocoes (`prom_id`, `prom_descricao`, `prom_desconto`, `prom_data_inicio`, `prom_data_fim`) VALUES
(1, 'Alexa', 50, '2024-06-06 00:00:00.000', '2024-07-06 00:00:00.000'),
(3, 'Xiaomi poco x6', 20, '2024-05-03 00:00:00.000', '2024-05-05 00:00:00.000'),
(4, 'Xiaomi poco x6', 20, '2024-05-03 00:00:00.000', '2024-05-05 00:00:00.000');

CREATE TABLE `qtd_produtos` (
  `qtd_prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` int(11) DEFAULT NULL,
  `qtd_prod_saldo` int(11) DEFAULT NULL,
  `qtd_prod_data_saldo` datetime DEFAULT NULL,
  `venda_prod_id` int(11) DEFAULT NULL,
  `ent_prod_id` int(11) DEFAULT NULL,
  `prod_ativo` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`qtd_prod_id`),
  KEY `prod_id` (`prod_id`),
  KEY `venda_prod_id` (`venda_prod_id`),
  KEY `ent_prod_id` (`ent_prod_id`),
  CONSTRAINT `qtd_produtos_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`),
  CONSTRAINT `qtd_produtos_ibfk_2` FOREIGN KEY (`venda_prod_id`) REFERENCES `venda_produto` (`venda_prod_id`),
  CONSTRAINT `qtd_produtos_ibfk_3` FOREIGN KEY (`ent_prod_id`) REFERENCES `entrada_produto` (`ent_prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

INSERT INTO qtd_produtos (`qtd_prod_id`, `prod_id`, `qtd_prod_saldo`, `qtd_prod_data_saldo`, `venda_prod_id`, `ent_prod_id`, `prod_ativo`) VALUES
(1, 1, 10, NULL, NULL, 1, 1),
(2, 2, 100, NULL, NULL, 2, 1),
(5, 4, 90, '2024-10-01 00:00:00.000', NULL, NULL, 1),
(6, 13, NULL, NULL, NULL, NULL, NULL),
(7, 14, NULL, NULL, NULL, NULL, NULL),
(8, 15, 224, NULL, NULL, NULL, NULL),
(9, 16, 78, NULL, NULL, NULL, NULL),
(10, 17, 220, NULL, NULL, NULL, NULL),
(11, 18, 22, NULL, NULL, NULL, NULL),
(12, 19, 222, NULL, NULL, NULL, NULL),
(13, 20, 22, NULL, NULL, NULL, NULL),
(14, 21, 34, NULL, NULL, NULL, NULL);

CREATE TABLE `recuperacao_de_dados` (
  `rec_dados_id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_dados_data_hora` datetime DEFAULT NULL,
  `rec_dados_tipo` int(11) DEFAULT NULL,
  `rec_dados_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`rec_dados_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `relatorios` (
  `relat_id` int(11) NOT NULL AUTO_INCREMENT,
  `relat_tipo` varchar(255) DEFAULT NULL,
  `relat_data_geracao` date DEFAULT NULL,
  `relat_descricao` varchar(255) DEFAULT NULL,
  `relat_caminho_arquivo` varchar(255) DEFAULT NULL,
  `usu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`relat_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `relatorios_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `salario` (
  `sal_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_id` int(11) DEFAULT NULL,
  `sal_valor` int(11) DEFAULT NULL,
  `sal_hr_extra` int(11) DEFAULT NULL,
  `sal_banco_hr` int(11) DEFAULT NULL,
  PRIMARY KEY (`sal_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `salario_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `telefones` (
  `tel_id` int(11) NOT NULL AUTO_INCREMENT,
  `tel_primario` varchar(15) DEFAULT NULL,
  `usu_id` int(11) DEFAULT NULL,
  `tel_whatsapp` varchar(15) DEFAULT NULL,
  `tel_principal` bit(1) DEFAULT NULL,
  `tel_secundario` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`tel_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `telefones_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO telefones (`tel_id`, `tel_primario`, `usu_id`, `tel_whatsapp`, `tel_principal`, `tel_secundario`) VALUES
(1, '14 996253475', 1, '14 996253475', X'01', '14 996253475'),
(2, '14 996253475', 2, '14 996253475', X'00', '14 996253488');

CREATE TABLE `tipo_endereco` (
  `ten_cod` int(11) NOT NULL AUTO_INCREMENT,
  `ten_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ten_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

INSERT INTO tipo_endereco (`ten_cod`, `ten_descricao`) VALUES
(1, 'PRINCIPAL'),
(2, 'SECUNDARIO'),
(3, 'PRINCIPAL E SECUNDARIO');

CREATE TABLE `tipo_pagamento_compra` (
  `tpa_cod` int(11) NOT NULL AUTO_INCREMENT,
  `tpa_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tpa_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO tipo_pagamento_compra (`tpa_cod`, `tpa_descricao`) VALUES
(1, 'Pix');

CREATE TABLE `tipo_usuario` (
  `tus_cod` int(11) NOT NULL AUTO_INCREMENT,
  `tus_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tus_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

INSERT INTO tipo_usuario (`tus_cod`, `tus_descricao`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Funcionário'),
(4, 'Funcionario Financeiro'),
(5, 'Funcionario Gestão');

CREATE TABLE `transporte` (
  `transp_id` int(11) NOT NULL AUTO_INCREMENT,
  `venda_prod_id` int(11) DEFAULT NULL,
  `transp_tipo` int(11) DEFAULT NULL,
  `transp_data_envio` date DEFAULT NULL,
  `transp_data_entrega_prevista` date DEFAULT NULL,
  PRIMARY KEY (`transp_id`),
  KEY `venda_prod_id` (`venda_prod_id`),
  CONSTRAINT `transporte_ibfk_1` FOREIGN KEY (`venda_prod_id`) REFERENCES `venda_produto` (`venda_prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `usuario_endereco` (
  `uen_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_id` int(11) DEFAULT NULL,
  `end_id` int(11) DEFAULT NULL,
  `uen_secundario` bit(1) DEFAULT NULL,
  `uen_complemento` varchar(255) DEFAULT NULL,
  `uen_principal` bit(1) DEFAULT NULL,
  `ten_cod` int(11) DEFAULT NULL,
  PRIMARY KEY (`uen_id`),
  KEY `usu_id` (`usu_id`),
  KEY `end_id` (`end_id`),
  KEY `ten_cod` (`ten_cod`),
  CONSTRAINT `usuario_endereco_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`),
  CONSTRAINT `usuario_endereco_ibfk_2` FOREIGN KEY (`end_id`) REFERENCES `enderecos` (`end_id`),
  CONSTRAINT `usuario_endereco_ibfk_3` FOREIGN KEY (`ten_cod`) REFERENCES `tipo_endereco` (`ten_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

INSERT INTO usuario_endereco (`uen_id`, `usu_id`, `end_id`, `uen_secundario`, `uen_complemento`, `uen_principal`, `ten_cod`) VALUES
(1, 1, 1, X'00', 'USANDO SOMENTO ENDERECO PRINCIPAL', X'01', 1),
(2, 2, 2, X'01', 'USANDO ENDERECO PRINCIPAL E SECUNDARIO', X'01', 3);

CREATE TABLE `usuarios` (
  `usu_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_documento` varchar(255) DEFAULT NULL,
  `usu_nome` varchar(255) DEFAULT NULL,
  `usu_sexo` varchar(255) DEFAULT NULL,
  `usu_data_nascimento` date DEFAULT NULL,
  `usu_email` varchar(100) DEFAULT NULL,
  `usu_senha` varchar(255) DEFAULT NULL,
  `tus_cod` int(11) DEFAULT NULL,
  `usu_data_cadastro` date DEFAULT NULL,
  `usu_data_bloqueio` date DEFAULT NULL,
  `usu_cpf` varchar(14) DEFAULT NULL,
  `usu_perfil_foto` varchar(255) DEFAULT NULL,
  `usu_ativo` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`usu_id`),
  KEY `tus_cod` (`tus_cod`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tus_cod`) REFERENCES `tipo_usuario` (`tus_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

INSERT INTO usuarios (`usu_id`, `usu_documento`, `usu_nome`, `usu_sexo`, `usu_data_nascimento`, `usu_email`, `usu_senha`, `tus_cod`, `usu_data_cadastro`, `usu_data_bloqueio`, `usu_cpf`, `usu_perfil_foto`, `usu_ativo`) VALUES
(1, 'usu_ativo =1 (ATIVO) 2(INATIVO)', NULL, NULL, '2024-08-14 00:00:00.000', NULL, NULL, 2, '2024-06-12 00:00:00.000', NULL, NULL, NULL, 1),
(2, NULL, NULL, NULL, '2024-08-20 00:00:00.000', NULL, NULL, 3, '2024-06-12 00:00:00.000', NULL, NULL, NULL, 1),
(3, NULL, 'Luis', 'Masculino', '2007-04-03 00:00:00.000', 'luis@gmail.com', '1234', 2, '2024-06-12 00:00:00.000', NULL, NULL, NULL, 1),
(4, NULL, 'Pedro', 'Masculino', '1997-04-04 00:00:00.000', 'pedro@gmail.com', '1234', 1, '2024-06-13 00:00:00.000', NULL, NULL, NULL, 1),
(5, NULL, 'Neymar', 'Masculino', '1961-01-23 00:00:00.000', 'neymar@gmail.com', '2323', 2, '2024-06-12 00:00:00.000', NULL, NULL, NULL, 1),
(6, NULL, 'Ronaldo', 'Masculino', '1961-01-23 00:00:00.000', 'neymar@gmail.com', 'ronaldo', 2, '2024-06-12 00:00:00.000', NULL, NULL, NULL, 0),
(7, NULL, 'Lontra', 'Masculino', '1990-06-19 00:00:00.000', 'lontra@gmail.com', '@lontra253', 2, '2024-08-09 00:00:00.000', NULL, '124.545.454-54', NULL, 0),
(8, NULL, 'luis', 'masculino', '2007-04-03 00:00:00.000', 'luisgustavobonfim996@gmail.com', '123', 2, '2024-08-13 00:00:00.000', NULL, NULL, NULL, 0),
(9, NULL, 'Luis', 'masculino', '2007-04-03 00:00:00.000', 'luis.ciaramicoli@etec.sp.gov.br', 'lui4817', 1, '2024-08-14 00:00:00.000', NULL, NULL, NULL, 1),
(10, NULL, 'Luis Gustavo', 'masculino', '2024-08-21 00:00:00.000', 'luisgustavobonfim996@gmail.com', 'Bonfim10', 2, '2024-08-17 00:00:00.000', NULL, NULL, NULL, 0),
(11, NULL, 'Vynicios', 'Masculino', '2002-12-15 00:00:00.000', 'vinnyrafael015@hotmail.com', '@Vyn2962', 1, '2024-08-27 00:00:00.000', NULL, '555.555.555-55', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1728084308/teste/mvnk5bp81znjkyu6lrsi.png', 1),
(31, NULL, 'Reynaldo', 'masculino', '1961-01-23 00:00:00.000', 'reynaldodiprovet@gmail.com', 'reynaldo1234', 2, '2024-08-27 00:00:00.000', NULL, NULL, NULL, 1),
(32, NULL, NULL, NULL, '1990-05-19 00:00:00.000', NULL, NULL, 3, '2024-08-29 00:00:00.000', NULL, NULL, NULL, 1),
(33, NULL, 'Neymar Junior', 'Masculino', '2050-12-19 00:00:00.000', 'neymar@hotmail.com', '1234', 2, '2024-08-29 00:00:00.000', NULL, '454.545.454-54', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1725929065/teste/vgahws6vyu82anykpwif.webp', 1),
(34, NULL, NULL, NULL, '2007-04-03 00:00:00.000', NULL, NULL, 2, '2024-08-31 00:00:00.000', NULL, NULL, NULL, 1),
(35, NULL, NULL, NULL, '1234-03-12 00:00:00.000', NULL, NULL, 3, '2024-08-31 00:00:00.000', NULL, NULL, NULL, NULL),
(36, NULL, 'luis', 'masculino', '2007-02-12 00:00:00.000', 'luisgustavobonfim996@gmail.com', '123', 2, '2024-08-31 00:00:00.000', NULL, NULL, NULL, NULL),
(37, NULL, 'luis', 'masculino', '2007-12-12 00:00:00.000', 'luisgustavobonfim996@gmail.com', '123', 2, '2024-08-31 00:00:00.000', NULL, NULL, NULL, NULL),
(38, NULL, 'luis', 'masculino', '2007-03-12 00:00:00.000', 'luisgustavobonfim996@gmail.com', '123', 2, '2024-08-31 00:00:00.000', NULL, NULL, NULL, NULL),
(39, NULL, 'luis', 'masculino', '2007-03-12 00:00:00.000', 'luisgustavobonfim996@gmail.com', '123', 2, '2024-08-31 00:00:00.000', NULL, NULL, NULL, NULL),
(40, NULL, 'luis', 'masculino', '2007-03-12 00:00:00.000', 'luisgustavobonfi@gmail.com', '123', 2, '2024-08-31 00:00:00.000', NULL, NULL, NULL, NULL),
(41, NULL, 'Luis Gustavo', 'masculino', '2024-09-05 00:00:00.000', 'luisgustavobonfim996=@gmail.com', '123', 2, '2024-09-03 00:00:00.000', NULL, NULL, NULL, 0),
(42, NULL, 'Batman', 'Masculino', '2222-02-12 00:00:00.000', 'batman@gmail.com', '1234', 3, '2024-09-03 00:00:00.000', NULL, '111.111.111-11', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1726702456/teste/nzfvqiklvo5xr4xtypvl.jpg', 1),
(43, NULL, 'Luis Gustavo', 'Masculino', '2024-09-19 00:00:00.000', 'luisgustavobonfim9962@gmail.com', '123', 3, '2024-09-03 00:00:00.000', NULL, '222.222.222-22', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1726880249/teste/mejvkvqnlrp8jswq9buz.jpg', 1),
(44, NULL, 'Luis Gustavo', 'Masculino', '2024-09-20 00:00:00.000', 'luisgustavobonfim9965@gmail.com', '123', 3, '2024-09-03 00:00:00.000', NULL, '132.123.213-33', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1725930436/teste/xvb7u7qzwtyr5j7omptb.jpg', 0),
(45, NULL, 'teste', 'Outros', '2000-01-01 00:00:00.000', 'vinnyrafael0151@hotmail.com', '123', 3, '2024-09-05 00:00:00.000', NULL, '111.111.233-33', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1725930471/teste/sb2vw2hwwdbuwbnxpsik.jpg', 1),
(46, NULL, 'funcionario 1', 'outro', '2000-01-01 00:00:00.000', NULL, NULL, 2, '2024-09-05 00:00:00.000', NULL, NULL, NULL, 0),
(47, NULL, 'Luis Gustavo', 'Masculino', '2222-02-12 00:00:00.000', 'luisgustavobonfim9926@gmail.com', '123', 3, '2024-09-05 00:00:00.000', NULL, '222.222.222-22', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1725930500/teste/nubuqpew79cwl8kutm3a.jpg', 0),
(48, NULL, 'Luis Gustavo', 'masculino', '2007-04-03 00:00:00.000', NULL, NULL, 2, '2024-09-06 00:00:00.000', NULL, NULL, NULL, 0),
(49, NULL, 'Neymar', 'Masculino', NULL, NULL, '2323', 2, NULL, NULL, NULL, NULL, 0),
(50, NULL, 'Neymar', 'Masculino', NULL, NULL, '2323', 2, NULL, NULL, NULL, NULL, 0),
(51, NULL, 'NeymarTentativaCPF', 'Masculino', NULL, NULL, '2323', 2, NULL, NULL, NULL, NULL, 1),
(52, NULL, 'NeymarTentativaCPF', 'Masculino', NULL, NULL, '2323', 2, NULL, NULL, NULL, NULL, 1),
(53, NULL, 'NeymarTentativaCPF2', 'Masculino', NULL, NULL, '2323', 2, NULL, NULL, NULL, NULL, 1),
(54, NULL, 'NeymarTentativaCPF3', 'Masculino', NULL, NULL, '2323', 2, NULL, NULL, NULL, NULL, 1),
(55, NULL, 'NeymarTentativaCPF4', 'Masculino', NULL, NULL, '2323', 2, NULL, NULL, '111111111', NULL, 1),
(56, NULL, 'lontra', 'outro', '1980-12-18 00:00:00.000', NULL, NULL, 2, '2024-09-06 00:00:00.000', NULL, NULL, NULL, 0),
(57, NULL, 'Luis Gustavo', 'masculino', '2024-02-12 00:00:00.000', NULL, NULL, 2, '2024-09-06 00:00:00.000', NULL, '11111111111', NULL, 1),
(58, NULL, 'asdasdasddadsdsadd', 'masculino', '1990-12-15 00:00:00.000', 'vinnyrafael01588@hotmail.com', '1234', 3, '2024-09-10 00:00:00.000', NULL, NULL, NULL, 1),
(59, NULL, 'teste5', 'masculino', '1980-12-19 00:00:00.000', 'vinnyrafael0157@hotmail.com', '1234', 3, '2024-09-11 00:00:00.000', NULL, NULL, NULL, 0),
(60, NULL, 'Luis Gustavo', 'masculino', '2007-04-03 00:00:00.000', NULL, NULL, 2, '2024-09-12 00:00:00.000', NULL, '36075664882', NULL, 0),
(61, NULL, 'Vinycio Pedrão Reynaldão LuisãoDaBengala', 'Masculino', '1970-03-12 00:00:00.000', 'VinycioP@gmail.com', '123', 5, NULL, NULL, '555555555', NULL, 1),
(62, NULL, '111111', 'Masculino', '1111-11-11 00:00:00.000', 'vinnyrafael015@hotmail.com1', '@Vyn2962', 3, '2024-09-19 00:00:00.000', NULL, '111.111.111-11', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1726706158/teste/flaidnumpoukdu9aszr1.jpg', 1),
(63, NULL, '22222222', 'masculino', '2222-02-22 00:00:00.000', 'vinnyrafael015@hotmail.com2', '@Vyn2962', 3, '2024-09-19 00:00:00.000', NULL, NULL, NULL, 0),
(64, NULL, '1', 'masculino', '1500-01-01 00:00:00.000', 'vinnyr@1', '3333', 3, '2024-09-19 00:00:00.000', NULL, NULL, NULL, 0),
(65, NULL, 'adasdasdsd55', 'masculino', '1950-05-12 00:00:00.000', NULL, NULL, 2, '2024-09-19 00:00:00.000', NULL, '55555555555', NULL, 0),
(66, NULL, '111111', 'Masculino', '2002-12-15 00:00:00.000', NULL, NULL, 2, '2024-09-19 00:00:00.000', NULL, '55555555555', NULL, 0),
(67, NULL, '11111111', 'Masculino', '1980-11-11 00:00:00.000', NULL, NULL, 2, '2024-09-19 00:00:00.000', NULL, '11111111111', NULL, 0),
(68, NULL, 'Luis Gustavo', 'Masculino', '2007-02-22 00:00:00.000', 'luisgustavobonfim9969@gmail.com', '$2b$10$OjzIcbR7StXnWkk4sFG8YOP6voMlagwsigMYdT8MJuLja91swV9vm', 2, '2024-09-23 00:00:00.000', NULL, '845.287.920-28', NULL, 0),
(69, NULL, 'Luis Gustavo', 'Masculino', '2007-02-22 00:00:00.000', 'luisgustavobonfim99610@gmail.com', '$2b$10$21.IDZb5MMG4ocIlribAqOu/FcJlYCz7sfGY7R9nrU3pnLPKcsAE.', 2, '2024-09-23 00:00:00.000', NULL, '845.287.920-28', NULL, 0),
(70, NULL, 'Luis Gustavo', 'Masculino', '2007-02-22 00:00:00.000', 'luisgustavobonfim99206@gmail.com', '123', 2, '2024-09-23 00:00:00.000', NULL, '845.287.920-28', NULL, 0),
(71, NULL, 'Luis Gustavo', 'Masculino', '2007-02-22 00:00:00.000', 'luisgustavobonfim99006@gmail.com', '123', 3, '2024-09-24 00:00:00.000', NULL, '845.287.920-28', NULL, 0),
(72, NULL, 'asdasdad', 'Masculino', '2005-12-15 00:00:00.000', 'vinnyrafael01522@hotmail.com', '@Vyn2962', 3, '2024-09-24 00:00:00.000', NULL, '000.000.000-00', NULL, 0),
(73, NULL, 'Allan', 'Masculino', NULL, 'allan@gmail.com', '1234', 1, NULL, NULL, NULL, NULL, 1);

CREATE TABLE `usuarios_permissoes` (
  `usu_perm_id` int(11) NOT NULL AUTO_INCREMENT,
  `usu_id` int(11) DEFAULT NULL,
  `perm_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`usu_perm_id`),
  KEY `usu_id` (`usu_id`),
  KEY `perm_id` (`perm_id`),
  CONSTRAINT `usuarios_permissoes_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`),
  CONSTRAINT `usuarios_permissoes_ibfk_2` FOREIGN KEY (`perm_id`) REFERENCES `permissoes` (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `venda_produto` (
  `venda_prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `venda_id` int(11) DEFAULT NULL,
  `prod_id` int(11) DEFAULT NULL,
  `venda_prod_qtd` int(11) DEFAULT NULL,
  `venda_prod_preco` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`venda_prod_id`),
  KEY `venda_id` (`venda_id`),
  KEY `prod_id` (`prod_id`),
  CONSTRAINT `venda_produto_ibfk_1` FOREIGN KEY (`venda_id`) REFERENCES `vendas` (`venda_id`),
  CONSTRAINT `venda_produto_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

INSERT INTO venda_produto (`venda_prod_id`, `venda_id`, `prod_id`, `venda_prod_qtd`, `venda_prod_preco`) VALUES
(1, 1, NULL, NULL, NULL);

CREATE TABLE `vendas` (
  `venda_id` int(11) NOT NULL AUTO_INCREMENT,
  `cli_id` int(11) DEFAULT NULL,
  `fun_id` int(11) DEFAULT NULL,
  `venda_data` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `venda_valor_total` double DEFAULT NULL,
  `venda_tipo_rec` int(11) DEFAULT NULL,
  `pag_venda_id` int(11) DEFAULT NULL,
  `prod_lote_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`venda_id`),
  KEY `cli_id` (`cli_id`),
  KEY `fun_id` (`fun_id`),
  KEY `prod_lote_id` (`prod_lote_id`),
  CONSTRAINT `prod_lote_id` FOREIGN KEY (`prod_lote_id`) REFERENCES `produto_lote` (`prod_lote_id`),
  CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`cli_id`) REFERENCES `usuarios` (`usu_id`),
  CONSTRAINT `vendas_ibfk_2` FOREIGN KEY (`fun_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

INSERT INTO vendas (`venda_id`, `cli_id`, `fun_id`, `venda_data`, `venda_valor_total`, `venda_tipo_rec`, `pag_venda_id`, `prod_lote_id`) VALUES
(1, 5, 1, '2024-03-04 00:00:00.000', 15, 1, NULL, 1),
(2, 6, 2, '2004-03-04 00:00:00.000', 15, 1, NULL, 2),
(17, 1, 1, '2024-09-05 21:31:30.000', 150, NULL, 1, 2),
(18, 8, 1, '2024-09-13 20:19:43.000', 150, 1, 1, 2),
(19, 5, 2, '2024-09-20 20:32:36.000', 1500, 1, 1, 1),
(20, 31, 33, '2024-10-02 20:05:38.000', 1500, 1, 1, 2);

