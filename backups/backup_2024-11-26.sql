CREATE TABLE `api_keys` (
  `api_key_id` int NOT NULL AUTO_INCREMENT,
  `api_key_descricao` varchar(255) DEFAULT NULL,
  `api_key_chave` varchar(255) DEFAULT NULL,
  `api_key_dt_criacao` date DEFAULT NULL,
  PRIMARY KEY (`api_key_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `backup` (
  `backup_id` int NOT NULL AUTO_INCREMENT,
  `backup_data_hora` datetime DEFAULT NULL,
  `backup_tipo` varchar(50) DEFAULT NULL,
  `backup_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`backup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;

INSERT INTO backup (`backup_id`, `backup_data_hora`, `backup_tipo`, `backup_status`) VALUES
(1, '2024-11-26 00:55:03.000', 'Automático', 'Sucesso'),
(2, '2024-11-26 04:06:15.000', 'Automático', 'Sucesso'),
(3, '2024-11-26 04:09:51.000', 'Automático', 'Sucesso'),
(4, '2024-11-26 01:33:26.000', 'Automático', 'Sucesso'),
(5, '2024-11-26 01:37:47.000', 'Automático', 'Sucesso'),
(6, '2024-11-26 01:40:50.000', 'Automático', 'Sucesso'),
(7, '2024-11-26 01:47:38.000', 'Automático', 'Sucesso'),
(8, '2024-11-26 01:52:37.000', 'Automático', 'Sucesso'),
(9, '2024-11-26 01:55:08.000', 'Automático', 'Sucesso'),
(10, '2024-11-26 01:56:15.000', 'Automático', 'Sucesso'),
(11, '2024-11-26 02:00:32.000', 'Automático', 'Sucesso'),
(12, '2024-11-26 02:07:03.000', 'Automático', 'Sucesso'),
(13, '2024-11-26 02:15:18.000', 'Automático', 'Sucesso'),
(14, '2024-11-26 02:20:40.000', 'Automático', 'Sucesso'),
(15, '2024-11-26 02:25:48.000', 'Automático', 'Sucesso'),
(16, '2024-11-26 02:35:15.000', 'Automático', 'Sucesso'),
(17, '2024-11-26 02:35:43.000', 'Automático', 'Sucesso'),
(18, '2024-11-26 02:40:24.000', 'Automático', 'Sucesso'),
(19, '2024-11-26 02:42:27.000', 'Automático', 'Sucesso'),
(20, '2024-11-26 02:43:32.000', 'Automático', 'Sucesso'),
(21, '2024-11-26 02:47:42.000', 'Automático', 'Sucesso'),
(22, '2024-11-26 06:17:48.000', 'Automático', 'Sucesso'),
(23, '2024-11-26 07:02:33.000', 'Automático', 'Sucesso'),
(24, '2024-11-26 08:44:24.000', 'Automático', 'Sucesso'),
(25, '2024-11-26 20:10:53.000', 'Automático', 'Sucesso'),
(26, '2024-11-26 17:12:07.000', 'Automático', 'Sucesso'),
(27, '2024-11-26 17:13:06.000', 'Automático', 'Sucesso');

CREATE TABLE `categorias` (
  `cate_id` int NOT NULL AUTO_INCREMENT,
  `cate_nome` varchar(255) DEFAULT NULL,
  `cate_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `compras` (
  `comp_id` int NOT NULL AUTO_INCREMENT,
  `comp_data` date DEFAULT NULL,
  `forn_id` int DEFAULT NULL,
  `comp_nota` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`comp_id`),
  KEY `forn_id` (`forn_id`),
  CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`forn_id`) REFERENCES `fornecedores` (`forn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

INSERT INTO compras (`comp_id`, `comp_data`, `forn_id`, `comp_nota`) VALUES
(1, '2024-05-02 00:00:00.000', 1, 'sdsadf'),
(2, '2024-10-10 00:00:00.000', 1, 'ALEXAS'),
(3, '2024-06-14 00:00:00.000', 1, 'ROBO ASPIRADOR- LAMPADA INTELIGENTE '),
(5, '2024-05-02 00:00:00.000', 1, 'TESTEDPFERIAS');

CREATE TABLE `contatos_usu` (
  `id_cont_usu` int NOT NULL,
  `tipo` int NOT NULL,
  `num_endereco` varchar(255) NOT NULL DEFAULT '10',
  `principal` bit(1) NOT NULL,
  `id_usu` int NOT NULL,
  `email_usu` varchar(100) NOT NULL,
  `telefone_usu` varchar(15) NOT NULL,
  `id_end` int NOT NULL,
  PRIMARY KEY (`id_cont_usu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `devolucoes` (
  `devo_id` int NOT NULL AUTO_INCREMENT,
  `venda_prod_id` int DEFAULT NULL,
  `devo_qtd` int DEFAULT NULL,
  `devo_motivo` varchar(255) DEFAULT NULL,
  `devo_data` date DEFAULT NULL,
  PRIMARY KEY (`devo_id`),
  KEY `venda_prod_id` (`venda_prod_id`),
  CONSTRAINT `devolucoes_ibfk_1` FOREIGN KEY (`venda_prod_id`) REFERENCES `venda_produto` (`venda_prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `enderecos` (
  `end_id` int NOT NULL AUTO_INCREMENT,
  `end_logradouro` varchar(255) DEFAULT NULL,
  `end_bairro` varchar(255) DEFAULT NULL,
  `end_cidade` varchar(255) DEFAULT NULL,
  `end_estado` varchar(255) DEFAULT NULL,
  `end_cep` char(8) DEFAULT NULL,
  PRIMARY KEY (`end_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb3;

INSERT INTO enderecos (`end_id`, `end_logradouro`, `end_bairro`, `end_cidade`, `end_estado`, `end_cep`) VALUES
(1, 'Cainguangues 1809', 'Tupã Mirim', 'Tupã', 'SP', '17603010'),
(2, 'Cainguangues 1809', 'Tupã Mirim', 'Tupã', 'SP', '17603010'),
(3, NULL, NULL, 'São Paulo', 'SP', '01234567'),
(4, NULL, NULL, 'Tupã', 'SP', '17603010'),
(5, NULL, NULL, 'Tupã', 'SP', '17603010'),
(6, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(7, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(8, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(9, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(10, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(11, 'Rua Exemplo', NULL, 'São Paulo', 'SP', '01234567'),
(12, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(13, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(14, 'Rua Suiça', NULL, 'Tupã', 'SP', '17623010'),
(15, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(16, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(17, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(18, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(19, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(20, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(21, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(22, 'Rua Suiça', NULL, 'Tupã', 'SP', '17623010'),
(23, 'Rua Suiça', NULL, 'Tupã', 'SP', '17623010'),
(24, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(25, 'Rua Manoel Ferreira Damião', NULL, 'Tupã', 'SP', '17601380'),
(26, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(27, 'Rua dos Testes, 123', NULL, 'São Paulo', 'SP', '01001000'),
(28, 'Rua Exemplo, 123', NULL, 'São Paulo', 'SP', '01001000'),
(29, 'Av. Brasil, 456', NULL, 'Rio de Janeiro', 'RJ', '20031000'),
(30, 'Rua da Liberdade, 789', NULL, 'Belo Horizonte', 'MG', '30120010'),
(31, 'Rua XV de Novembro, 111', NULL, 'Curitiba', 'PR', '80020100'),
(32, 'Rua das Flores, 222', NULL, 'Florianópolis', 'SC', '88010100'),
(33, 'Av. Bento Gonçalves, 333', NULL, 'Porto Alegre', 'RS', '90050100'),
(34, 'Rua do Carmo, 444', NULL, 'Salvador', 'BA', '40020010'),
(35, 'Av. Conde da Boa Vista, 555', NULL, 'Recife', 'PE', '50060100'),
(36, 'Rua Dragão do Mar, 666', NULL, 'Fortaleza', 'CE', '60010100'),
(37, 'Esplanada dos Ministérios, Bloco A', NULL, 'Brasília', 'DF', '70040900'),
(38, 'Rua Exemplo, 123', NULL, 'São Paulo', 'SP', '01001000'),
(39, 'Rua dos Testes, 123', NULL, 'São Paulo', 'SP', '01001000'),
(40, 'Av. Brasil, 456', NULL, 'Rio de Janeiro', 'RJ', '20031000'),
(41, 'Rua da Liberdade, 789', NULL, 'Belo Horizonte', 'MG', '30120010'),
(42, 'Rua XV de Novembro, 111', NULL, 'Curitiba', 'PR', '80020100'),
(43, 'Rua das Flores, 222', NULL, 'Florianópolis', 'SC', '88010100'),
(44, 'Av. Bento Gonçalves, 333', NULL, 'Porto Alegre', 'RS', '90050100'),
(45, 'Rua do Carmo, 444', NULL, 'Salvador', 'BA', '40020010'),
(46, 'Av. Conde da Boa Vista, 555', NULL, 'Recife', 'PE', '50060100'),
(47, 'Rua Dragão do Mar, 666', NULL, 'Fortaleza', 'CE', '60010100'),
(48, 'Esplanada dos Ministérios, Bloco A', NULL, 'Brasília', 'DF', '70040900'),
(49, 'Av. Paulista, 1000', NULL, 'São Paulo', 'SP', '70040900'),
(50, 'Rua Exemplo, 123', NULL, 'São Paulo', 'SP', '01001000'),
(51, 'Rua Exemplo, 456', NULL, 'São Paulo', 'SP', '01002000'),
(52, 'Av. Paulista, 789', NULL, 'São Paulo', 'SP', '01311000'),
(53, 'Rua Augusta, 101', NULL, 'São Paulo', 'SP', '01413000'),
(54, 'Rua da Consolação, 222', NULL, 'São Paulo', 'SP', '01302000'),
(55, 'Av. Rebouças, 333', NULL, 'São Paulo', 'SP', '05402000'),
(56, 'Rua Oscar Freire, 444', NULL, 'São Paulo', 'SP', '05409010'),
(57, 'Av. Ipiranga, 555', NULL, 'São Paulo', 'SP', '01046000'),
(58, 'Rua Boa Vista, 666', NULL, 'São Paulo', 'SP', '01014000'),
(59, 'Av. Brigadeiro Luis Antônio, 777', NULL, 'São Paulo', 'SP', '01318000'),
(60, 'Rua da Mooca, 888', NULL, 'São Paulo', 'SP', '03104000'),
(61, 'Rua Vergueiro, 999', NULL, 'São Paulo', 'SP', '01504000'),
(62, 'Rua Caingangs', NULL, 'Tupã', 'SP', '17603010'),
(63, 'Rua Suiça', NULL, 'Tupã', 'SP', '17623010'),
(64, 'Rua Suiça', NULL, 'Tupã', 'SP', '17623010'),
(65, 'Rua Rubens Moreira', NULL, 'Tupã', 'SP', '17610535'),
(66, 'Rubens Moreira, 1030', NULL, 'Tupã', 'SP', '17610535');

CREATE TABLE `entrada_produto` (
  `ent_prod_id` int NOT NULL AUTO_INCREMENT,
  `comp_id` int DEFAULT NULL,
  `ent_prod_qtd` int DEFAULT NULL,
  `ent_prod_preco` int DEFAULT NULL,
  `prod_id` int DEFAULT NULL,
  PRIMARY KEY (`ent_prod_id`),
  KEY `comp_id` (`comp_id`),
  KEY `prod_id` (`prod_id`),
  CONSTRAINT `entrada_produto_ibfk_1` FOREIGN KEY (`comp_id`) REFERENCES `compras` (`comp_id`),
  CONSTRAINT `entrada_produto_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `fornecedores` (
  `forn_id` int NOT NULL AUTO_INCREMENT,
  `forn_nome` varchar(50) DEFAULT NULL,
  `forn_vendedor` varchar(50) DEFAULT NULL,
  `forn_telefone` varchar(13) DEFAULT NULL,
  `forn_celular` varchar(15) DEFAULT NULL,
  `forn_email` varchar(255) DEFAULT NULL,
  `forn_cnpj` varchar(17) DEFAULT NULL,
  `forn_cpf` varchar(14) DEFAULT NULL,
  `forn_site` varchar(20) DEFAULT NULL,
  `forn_tipo` varchar(20) DEFAULT NULL,
  `forn_ativo` tinyint DEFAULT NULL,
  PRIMARY KEY (`forn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

INSERT INTO fornecedores (`forn_id`, `forn_nome`, `forn_vendedor`, `forn_telefone`, `forn_celular`, `forn_email`, `forn_cnpj`, `forn_cpf`, `forn_site`, `forn_tipo`, `forn_ativo`) VALUES
(1, 'Samsung', 'Luis Gustavo', NULL, '(14) 99754-735', 'samsung@gmail.com', '32539738000118', NULL, NULL, 'juridica', 0),
(2, 'Roberto', 'Roberto', NULL, '(14) 99573-3722', 'Roberto@gmail.com', NULL, '60849814022', NULL, 'fisica', 1),
(3, 'Lenovo', 'Carlos', NULL, '(11) 99838-4788', 'Lenovo@gmail.com', '19024658000161', NULL, NULL, 'juridica', 1),
(4, 'Daniele', 'Daniele', NULL, '(14) 88982-9219', 'Daniele@gmail.com', NULL, '86546648008', NULL, 'fisica', 1),
(5, 'Vivo', 'Pedro', NULL, '(14) 99754-7353', 'Vivo@gmail.com', '86456237000105', NULL, NULL, 'juridica', 1),
(6, 'Yago', 'Yago', NULL, '(14) 99827-4957', 'Yago@gmail.com', NULL, '79249631030', NULL, 'fisica', 1),
(7, 'SmartComponents LTDA', 'Renata Lopes', NULL, '(21) 99988-7766', 'renata.lopes@smartcomponents.com', '04252011000110', NULL, NULL, 'juridica', 1),
(8, 'FastTech', 'Eduardo Mendes', NULL, '(31) 98765-4321', 'eduardo.mendes@fasttech.com.br', '12345678000195', NULL, NULL, 'juridica', 1),
(9, 'BitTech Comércio e Serviços', 'Fernando Martins', NULL, '(51) 99887-6655', 'fernando.martins@bittech.com.br', '37424999000106', NULL, NULL, 'juridica', 1),
(10, 'TechCom Distribuidora', 'Lucas Almeida', NULL, '(11) 98876-5432', 'lucas.almeida@techcom.com.br', '86109133000116', NULL, NULL, 'juridica', 1),
(11, 'PrimeNet Distribuidora', 'João Carlos ', NULL, '(61) 98877-3344', 'joao.carlos@primenet.com.br', '54686257000178', NULL, NULL, 'juridica', 1),
(12, 'Carlos Henrique da Silva', 'Carlos Henrique', NULL, '(11) 97788-6655', 'carlos.h.silva@gmail.com', NULL, '85362161822', NULL, 'fisica', 1),
(13, 'Juliana Ferreira Costa', 'Juliana Costa', NULL, '(21) 99922-3344', 'juliana.fcosta@hotmail.com', NULL, '59522151815', NULL, 'fisica', 1),
(14, 'Marcos Vinícius Santos', 'Ana Oliveira', NULL, '(31) 98777-6655', 'ana.oliveira@outlook.com', NULL, '70971746842', NULL, 'fisica', 1),
(15, 'Felipe Augusto Rocha', 'Felipe Rocha', NULL, '(51) 99888-5544', 'felipe.rocha@yahoo.com', NULL, '79725876806', NULL, 'fisica', 1),
(16, 'Fernanda Souza Lima', 'Fernanda Lima', NULL, '(11) 98877-1122', 'fernanda.souza@outlook.com', NULL, '10572441800', NULL, 'fisica', 1);

CREATE TABLE `historico_login` (
  `login_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `login_data_hora` datetime DEFAULT NULL,
  `login_sucesso` bit(1) DEFAULT NULL,
  `login_ip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `historico_login_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `holerites` (
  `holerite_id` int NOT NULL AUTO_INCREMENT,
  `holerite_salario_bruto` int DEFAULT NULL,
  `holerite_data_emissao` date DEFAULT NULL,
  `holerite_descontos` int DEFAULT NULL,
  `holerite_salario_liquido` int DEFAULT NULL,
  `usu_id` int DEFAULT NULL,
  PRIMARY KEY (`holerite_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `holerites_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `inventarios` (
  `inv_id` int NOT NULL AUTO_INCREMENT,
  `inv_data` date DEFAULT NULL,
  `inv_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`inv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `notificacoes` (
  `noti_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `noti_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`noti_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `notificacoes_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `pagamentos_compras` (
  `pag_comp_id` int NOT NULL AUTO_INCREMENT,
  `comp_id` int DEFAULT NULL,
  `pag_comp_valor` int DEFAULT NULL,
  `tpa_cod` int DEFAULT NULL,
  PRIMARY KEY (`pag_comp_id`),
  KEY `comp_id` (`comp_id`),
  KEY `tpa_cod` (`tpa_cod`),
  CONSTRAINT `pagamentos_compras_ibfk_1` FOREIGN KEY (`comp_id`) REFERENCES `compras` (`comp_id`),
  CONSTRAINT `pagamentos_compras_ibfk_2` FOREIGN KEY (`tpa_cod`) REFERENCES `tipo_pagamento_compra` (`tpa_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

INSERT INTO pagamentos_compras (`pag_comp_id`, `comp_id`, `pag_comp_valor`, `tpa_cod`) VALUES
(1, 1, 150, 1),
(2, 1, 100, 1);

CREATE TABLE `pagamentos_vendas` (
  `pag_venda_id` int NOT NULL AUTO_INCREMENT,
  `venda_id` int DEFAULT NULL,
  `pag_venda_valor` int DEFAULT NULL,
  `pag_venda_data` date DEFAULT NULL,
  `pag_venda_metodo` int DEFAULT NULL,
  `pag_venda_metodo_descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pag_venda_id`),
  KEY `venda_id` (`venda_id`),
  CONSTRAINT `pagamentos_vendas_ibfk_1` FOREIGN KEY (`venda_id`) REFERENCES `vendas` (`venda_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

INSERT INTO pagamentos_vendas (`pag_venda_id`, `venda_id`, `pag_venda_valor`, `pag_venda_data`, `pag_venda_metodo`, `pag_venda_metodo_descricao`) VALUES
(1, 1, 3000, '2024-11-23 00:00:00.000', 2, 'Outro'),
(2, 2, 2399, '2024-11-23 00:00:00.000', 1, 'Outro'),
(3, 3, 499, '2024-11-23 00:00:00.000', 1, 'Outro'),
(4, 4, 3799, '2024-11-23 00:00:00.000', 1, 'Outro'),
(5, 5, 129, '2024-11-23 00:00:00.000', 1, 'Outro'),
(6, 6, 798, '2024-11-25 00:00:00.000', 1, 'Outro'),
(7, 7, 399, '2024-11-25 00:00:00.000', 1, 'Outro');

CREATE TABLE `permissoes` (
  `perm_id` int NOT NULL AUTO_INCREMENT,
  `perm_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `produto` (
  `prod_id` int NOT NULL AUTO_INCREMENT,
  `prod_nome` varchar(100) DEFAULT NULL,
  `prod_preco` decimal(10,2) DEFAULT NULL,
  `prod_marca` varchar(50) DEFAULT NULL,
  `prod_descricao` varchar(150) DEFAULT NULL,
  `prod_codigo_barras` varchar(50) DEFAULT NULL,
  `prod_peso` decimal(10,3) DEFAULT NULL,
  `prod_volume` varchar(10) DEFAULT NULL,
  `prod_estoque_total` int DEFAULT NULL,
  `prod_data_criacao` datetime DEFAULT NULL,
  `prod_ativo` tinyint DEFAULT NULL,
  `prod_categoria` varchar(50) DEFAULT NULL,
  `prod_medida` varchar(50) DEFAULT NULL,
  `prod_cor` varchar(150) DEFAULT NULL,
  `forn_id` int DEFAULT NULL,
  PRIMARY KEY (`prod_id`),
  KEY `fk_produto_fornecedor` (`forn_id`),
  CONSTRAINT `fk_produto_fornecedor` FOREIGN KEY (`forn_id`) REFERENCES `fornecedores` (`forn_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

INSERT INTO produto (`prod_id`, `prod_nome`, `prod_preco`, `prod_marca`, `prod_descricao`, `prod_codigo_barras`, `prod_peso`, `prod_volume`, `prod_estoque_total`, `prod_data_criacao`, `prod_ativo`, `prod_categoria`, `prod_medida`, `prod_cor`, `forn_id`) VALUES
(1, 'Celular S24 ultra', '3000.00', 'Samsung', 'Novo celular S24 ultra o melhor do mercado', 'PROD-1732335880259', '399.000', 'G', 29, '2024-11-23 04:24:40.000', 0, 'ELETRONICO', '10x20', 'Preto', 1),
(2, 'Galaxy S23', '4999.00', 'Samsung', 'Smartphone com tela de 6,1 polegadas, câmera de 50MP, processador Snapdragon 8 Gen 2. 128GB', 'PROD-1732337677679', '300.000', 'G', 50, '2024-11-23 04:54:37.000', 1, 'Smartphones', '15 x 7,5 x 0,8 cm', 'Preto', 1),
(3, 'Lenovo ThinkPad X1 Carbon', '7999.00', 'Lenovo', 'Notebook ultrafino com tela de 14\", processador Intel i7 de 13ª geração e excelente performance. 16GB RAM, 512GB SSD', 'PROD-1732337762135', '1.120', 'KG', 30, '2024-11-23 04:56:02.000', 1, 'Laptops', ' 32 x 22 x 1,5 cm', 'Preto', 3),
(4, 'Vivo V21 5G', '2399.00', 'Vivo', 'Smartphone com tela de 6,44 polegadas AMOLED, câmera de 44MP e suporte 5G.128GB', 'PROD-1732337831509', '176.000', 'G', 79, '2024-11-23 04:57:11.000', 1, 'Smartphones', '16,3 x 7,5 x 0,7 cm', 'Azul', 5),
(5, 'Mouse Gamer X-Force', '149.00', 'X-Force', 'Mouse gamer com 7 botões programáveis, RGB e sensor de 3200 DPI.', 'PROD-1732337883798', '100.000', 'G', 200, '2024-11-23 04:58:03.000', 1, 'Periféricos de Informática', '12 x 7 x 4 cm', 'Preto e Verde', 8),
(6, 'SSD Kingston A2000 1TB', '399.00', 'Kingston', 'SSD NVMe com alta velocidade de leitura e gravação, ideal para gamers e profissionais. 1TB', 'PROD-1732337936220', '60.000', 'G', 150, '2024-11-23 04:58:56.000', 1, 'Armazenamento', '10 x 7 x 0,7 cm', 'Preto', 9),
(7, 'Fone de Ouvido Bluetooth Pro', '299.00', 'Sony', ' Fone de ouvido Bluetooth com cancelamento de ruído, bateria de longa duração e conforto excepcional.', 'PROD-1732338131850', '180.000', 'G', 100, '2024-11-23 05:02:11.000', 1, 'Acessórios', '20 x 18 x 5 cm', 'Preto', 2),
(8, 'Carregador Rápido 30W', '99.00', 'Anker', 'Carregador rápido USB-C com tecnologia de carga rápida para dispositivos compatíveis.', 'PROD-1732338204061', '100.000', 'G', 150, '2024-11-23 05:03:24.000', 1, 'Acessórios', '6 x 6 x 2 cm', 'Branco', 2),
(9, 'Lenovo IdeaPad 3i', '2499.00', 'Lenovo', 'Laptop acessível com processador Intel i5 de 12ª geração, 15,6\" Full HD e 256GB de SSD e 8GB RAM.', 'PROD-1732338608125', '1.400', 'KG', 30, '2024-11-23 05:10:08.000', 1, 'Laptops', '36 x 24 x 2 cm', 'Prata', 3),
(10, 'Teclado Mecânico RGB', '399.00', 'Corsair', 'Teclado mecânico com switches mecânicos, iluminação RGB personalizável e design ergonômico.', 'PROD-1732338722026', '800.000', 'G', 50, '2024-11-23 05:12:02.000', 1, 'Periféricos de Informática', '44 x 14 x 4 cm', 'Preto', 6),
(11, 'Headset Gamer YH100', '199.00', 'Logitech', 'Headset gamer com microfone ajustável, som surround 7.1 e conforto para longas sessões de jogo.', 'PROD-1732338966581', '350.000', 'G', 60, '2024-11-23 05:16:06.000', 1, 'Periféricos de Informática', '18 x 9 x 21 cm', 'Preto com detalhes vermelhos', 6),
(12, ' Power Bank 10.000mAh', '159.00', 'Xiaomi', 'Power bank portátil com capacidade de 10.000mAh, ideal para carregar smartphones e outros dispositivos.', 'PROD-1732339030351', '220.000', 'G', 80, '2024-11-23 05:17:10.000', 1, 'Acessórios', '9 x 6 x 2,5 cm', 'Preto', 4),
(13, 'Cabo USB-C para Lightning', '49.00', 'Belkin', 'Cabo de 1 metro para carregamento rápido e transferência de dados entre dispositivos USB-C e Lightning.', 'PROD-1732339143714', '50.000', 'G', 200, '2024-11-23 05:19:03.000', 1, 'Acessórios', '2 x 2 x 0,3 cm', 'Branco', 4),
(14, 'Vivo TWS Neo', '349.00', 'Vivo', 'Fones de ouvido TWS com áudio de alta qualidade, até 22 horas de reprodução e resistência à água.', 'PROD-1732339209202', '45.000', 'G', 150, '2024-11-23 05:20:09.000', 1, 'Acessórios', '5,5 x 4,5 x 2,5 cm', 'Branco', 5),
(15, ' Placa de Vídeo RTX 3080', '7999.00', 'NVIDIA', 'Placa de vídeo GeForce RTX 3080 com 10GB de GDDR6X, ideal para jogos e criação de conteúdo.', 'PROD-1732339327749', '2.100', 'KG', 20, '2024-11-23 05:22:07.000', 1, 'Placas de Vídeo', '31 x 14 x 5 cm', 'Preto com detalhes em verde', 7),
(16, 'Fonte 750W 80 Plus Gold', '699.00', 'Corsair', 'Fonte de alimentação de 750W com certificação 80 Plus Gold e proteção contra sobrecarga.', 'PROD-1732339389000', '1.500', 'KG', 30, '2024-11-23 05:23:09.000', 1, 'Fontes de Alimentação', '15 x 15 x 8 cm', 'Preto', 7),
(17, 'Roteador Wi-Fi 6', '349.00', 'TP-Link', ' Roteador Wi-Fi 6 com suporte a velocidades de até 5.4Gbps, ideal para ambientes de alta demanda.', 'PROD-1732339473403', '300.000', 'G', 100, '2024-11-23 05:24:33.000', 1, 'Roteadores', ' 22 x 15 x 5 cm', 'Preto', 8),
(18, 'SSD NVMe 1TB', '499.00', 'Kingston', 'SSD NVMe M.2 de 1TB, ideal para aumentar a velocidade de leitura e gravação em computadores e consoles.', 'PROD-1732339549780', '100.000', 'G', 59, '2024-11-23 05:25:49.000', 1, 'Armazenamento', '8 x 2,5 x 0,3 cm', 'Preto', 9),
(19, 'Notebook Dell Inspiron 15', '3799.00', 'Dell', 'Notebook com processador Intel i7 de 11ª geração, tela de 15,6\" Full HD, 512GB de SSD e 8GB RAM.', 'PROD-1732339631986', '1.800', 'KG', 39, '2024-11-23 05:27:11.000', 1, 'Laptops', '36 x 25 x 2 cm', 'Prata', 10),
(20, 'Mouse Gamer RGB', '129.00', 'Logitech', 'Mouse gamer com 6 botões programáveis, iluminação RGB e sensor de 12.000 DPI.', 'PROD-1732339827903', '120.000', 'G', 79, '2024-11-23 05:30:27.000', 1, 'Periféricos', '13 x 7 x 4 cm', 'Preto com iluminação RGB', 10);

CREATE TABLE `produto_categoria` (
  `pca_id` int NOT NULL AUTO_INCREMENT,
  `prod_id` int DEFAULT NULL,
  `cate_id` int DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`pca_id`),
  KEY `prod_id` (`prod_id`),
  KEY `cate_id` (`cate_id`),
  CONSTRAINT `produto_categoria_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`),
  CONSTRAINT `produto_categoria_ibfk_2` FOREIGN KEY (`cate_id`) REFERENCES `categorias` (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `produto_lote` (
  `prod_lote_id` int NOT NULL AUTO_INCREMENT,
  `prod_id` int DEFAULT NULL,
  `lote_codigo` varchar(100) DEFAULT NULL,
  `prod_lote_quantidade` int DEFAULT NULL,
  `prod_lote_data_fabricacao` date DEFAULT NULL,
  `prod_lote_data_validade` date DEFAULT NULL,
  `prod_lote_data_entrada` datetime DEFAULT NULL,
  `prod_lote_preco` decimal(10,2) DEFAULT NULL,
  `forn_id` int DEFAULT NULL,
  PRIMARY KEY (`prod_lote_id`),
  KEY `prod_id` (`prod_id`),
  KEY `ent_prod_id` (`lote_codigo`),
  KEY `fk_fornecedores` (`forn_id`),
  CONSTRAINT `fk_fornecedores` FOREIGN KEY (`forn_id`) REFERENCES `fornecedores` (`forn_id`),
  CONSTRAINT `produto_lote_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

INSERT INTO produto_lote (`prod_lote_id`, `prod_id`, `lote_codigo`, `prod_lote_quantidade`, `prod_lote_data_fabricacao`, `prod_lote_data_validade`, `prod_lote_data_entrada`, `prod_lote_preco`, `forn_id`) VALUES
(1, 1, 'LOTE-1732335880242', 30, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 04:24:40.000', NULL, 1),
(2, 2, 'LOTE-1732337677665', 50, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 04:54:38.000', NULL, 1),
(3, 3, 'LOTE-1732337762120', 30, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 04:56:02.000', NULL, 3),
(4, 4, 'LOTE-1732337831493', 80, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 04:57:11.000', NULL, 5),
(5, 5, 'LOTE-1732337883776', 200, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 04:58:04.000', NULL, 8),
(6, 6, 'LOTE-1732337936160', 150, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 04:58:56.000', NULL, 9),
(7, 7, 'LOTE-1732338131739', 100, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:02:12.000', NULL, 2),
(8, 8, 'LOTE-1732338204044', 150, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:03:24.000', NULL, 2),
(9, 9, 'LOTE-1732338608079', 30, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:10:08.000', NULL, 3),
(10, 10, 'LOTE-1732338722005', 50, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:12:02.000', NULL, 6),
(11, 11, 'LOTE-1732338966564', 60, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:16:07.000', NULL, 6),
(12, 12, 'LOTE-1732339030291', 80, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:17:10.000', NULL, 4),
(13, 13, 'LOTE-1732339143698', 200, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:19:04.000', NULL, 4),
(14, 14, 'LOTE-1732339209187', 150, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:20:09.000', NULL, 5),
(15, 15, 'LOTE-1732339327734', 20, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:22:08.000', NULL, 7),
(16, 16, 'LOTE-1732339388954', 30, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:23:09.000', NULL, 7),
(17, 17, 'LOTE-1732339473388', 100, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:24:33.000', NULL, 8),
(18, 18, 'LOTE-1732339549766', 60, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:25:50.000', NULL, 9),
(19, 19, 'LOTE-1732339631970', 40, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:27:12.000', NULL, 10),
(20, 20, 'LOTE-1732339827853', 80, '2024-11-23 00:00:00.000', '2025-11-23 00:00:00.000', '2024-11-23 05:30:28.000', NULL, 10);

CREATE TABLE `produto_promocao` (
  `prod_prom_id` int NOT NULL AUTO_INCREMENT,
  `prod_id` int DEFAULT NULL,
  `prom_id` int DEFAULT NULL,
  PRIMARY KEY (`prod_prom_id`),
  KEY `prod_id` (`prod_id`),
  KEY `prom_id` (`prom_id`),
  CONSTRAINT `produto_promocao_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`),
  CONSTRAINT `produto_promocao_ibfk_2` FOREIGN KEY (`prom_id`) REFERENCES `promocoes` (`prom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `promocoes` (
  `prom_id` int NOT NULL AUTO_INCREMENT,
  `prom_descricao` varchar(255) DEFAULT NULL,
  `prom_desconto` int DEFAULT NULL,
  `prom_data_inicio` date DEFAULT NULL,
  `prom_data_fim` date DEFAULT NULL,
  PRIMARY KEY (`prom_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

INSERT INTO promocoes (`prom_id`, `prom_descricao`, `prom_desconto`, `prom_data_inicio`, `prom_data_fim`) VALUES
(1, 'Alexa', 50, '2024-06-06 00:00:00.000', '2024-07-06 00:00:00.000'),
(3, 'Xiaomi poco x6', 20, '2024-05-03 00:00:00.000', '2024-05-05 00:00:00.000'),
(4, 'Xiaomi poco x6', 20, '2024-05-03 00:00:00.000', '2024-05-05 00:00:00.000');

CREATE TABLE `qtd_produtos` (
  `qtd_prod_id` int NOT NULL AUTO_INCREMENT,
  `prod_id` int DEFAULT NULL,
  `qtd_prod_saldo` int DEFAULT NULL,
  `qtd_prod_data_saldo` datetime DEFAULT NULL,
  `venda_prod_id` int DEFAULT NULL,
  `ent_prod_id` int DEFAULT NULL,
  `prod_ativo` tinyint DEFAULT NULL,
  PRIMARY KEY (`qtd_prod_id`),
  KEY `prod_id` (`prod_id`),
  KEY `venda_prod_id` (`venda_prod_id`),
  KEY `ent_prod_id` (`ent_prod_id`),
  CONSTRAINT `qtd_produtos_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`),
  CONSTRAINT `qtd_produtos_ibfk_2` FOREIGN KEY (`venda_prod_id`) REFERENCES `venda_produto` (`venda_prod_id`),
  CONSTRAINT `qtd_produtos_ibfk_3` FOREIGN KEY (`ent_prod_id`) REFERENCES `entrada_produto` (`ent_prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `recuperacao_de_dados` (
  `rec_dados_id` int NOT NULL AUTO_INCREMENT,
  `rec_dados_data_hora` datetime DEFAULT NULL,
  `rec_dados_tipo` int DEFAULT NULL,
  `rec_dados_status` int DEFAULT NULL,
  PRIMARY KEY (`rec_dados_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `relatorios` (
  `relat_id` int NOT NULL AUTO_INCREMENT,
  `relat_tipo` varchar(255) DEFAULT NULL,
  `relat_data_geracao` date DEFAULT NULL,
  `relat_descricao` varchar(255) DEFAULT NULL,
  `relat_caminho_arquivo` varchar(255) DEFAULT NULL,
  `usu_id` int DEFAULT NULL,
  PRIMARY KEY (`relat_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `relatorios_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `salario` (
  `sal_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `sal_valor` int DEFAULT NULL,
  `sal_hr_extra` int DEFAULT NULL,
  `sal_banco_hr` int DEFAULT NULL,
  PRIMARY KEY (`sal_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `salario_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `telefones` (
  `tel_id` int NOT NULL AUTO_INCREMENT,
  `tel_primario` varchar(15) DEFAULT NULL,
  `usu_id` int DEFAULT NULL,
  `tel_whatsapp` varchar(15) DEFAULT NULL,
  `tel_principal` bit(1) DEFAULT NULL,
  `tel_secundario` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`tel_id`),
  KEY `usu_id` (`usu_id`),
  CONSTRAINT `telefones_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3;

INSERT INTO telefones (`tel_id`, `tel_primario`, `usu_id`, `tel_whatsapp`, `tel_principal`, `tel_secundario`) VALUES
(1, '14 996253475', 1, '14 996253475', X'01', '14 996253475'),
(2, '14 996253475', 2, '14 996253475', X'00', '14 996253488'),
(3, NULL, 84, NULL, NULL, NULL),
(4, '(14) 99709-2617', 85, NULL, NULL, NULL),
(5, '(14) 99709-2617', 86, NULL, NULL, NULL),
(6, '(14) 99709-2617', 87, NULL, NULL, NULL),
(8, '(14) 99754-7353', 88, NULL, NULL, NULL),
(9, '(14) 99709-2617', 89, NULL, NULL, NULL),
(10, '(14) 99636-1097', 90, NULL, NULL, NULL),
(11, '14 996361097', 91, NULL, NULL, NULL),
(12, '(14) 99754-7353', 92, NULL, NULL, NULL),
(13, '(14) 99766-7772', 93, NULL, NULL, NULL),
(14, '(14) 99754-7353', 94, NULL, NULL, NULL),
(15, '(11) 91234-5678', 95, NULL, NULL, NULL),
(16, '(11) 91234-5678', 96, NULL, NULL, NULL),
(17, '(21) 92345-6789', 97, NULL, NULL, NULL),
(18, '(31) 91234-5678', 98, NULL, NULL, NULL),
(19, '(41) 93456-7890', 99, NULL, NULL, NULL),
(20, '(48) 94567-8901', 100, NULL, NULL, NULL),
(21, '(51) 95678-9012', 101, NULL, NULL, NULL),
(22, '(71) 96789-0123', 102, NULL, NULL, NULL),
(23, '(81) 97890-1234', 103, NULL, NULL, NULL),
(24, '(85) 98901-2345', 104, NULL, NULL, NULL),
(25, '(61) 99012-3456', 105, NULL, NULL, NULL),
(26, '(11) 91234-5678', 1, NULL, NULL, NULL),
(27, '(11) 91234-5678', 2, NULL, NULL, NULL),
(28, '(21) 92345-6789', 3, NULL, NULL, NULL),
(29, '(31) 91234-5678', 4, NULL, NULL, NULL),
(30, '(41) 93456-7890', 5, NULL, NULL, NULL),
(31, '(48) 94567-8901', 6, NULL, NULL, NULL),
(32, '(51) 95678-9012', 7, NULL, NULL, NULL),
(33, '(71) 96789-0123', 8, NULL, NULL, NULL),
(34, '(81) 97890-1234', 9, NULL, NULL, NULL),
(35, '(85) 98901-2345', 10, NULL, NULL, NULL),
(36, '(61) 99012-3456', 11, NULL, NULL, NULL),
(37, '(61) 99012-3456', 12, NULL, NULL, NULL),
(38, '(11) 91234-5678', 13, NULL, NULL, NULL),
(39, '(11) 92345-6789', 14, NULL, NULL, NULL),
(40, '(11) 93456-7890', 15, NULL, NULL, NULL),
(41, '(11) 94567-8901', 16, NULL, NULL, NULL),
(42, '(11) 95678-9012', 17, NULL, NULL, NULL),
(43, '(11) 96789-0123', 18, NULL, NULL, NULL),
(44, '(11) 97890-1234', 19, NULL, NULL, NULL),
(45, '(11) 98901-2345', 20, NULL, NULL, NULL),
(46, '(11) 99012-3456', 21, NULL, NULL, NULL),
(47, '(11) 90123-4567', 22, NULL, NULL, NULL),
(48, '(11) 91234-5670', 23, NULL, NULL, NULL),
(49, '(11) 92345-6781', 24, NULL, NULL, NULL),
(50, '(14) 99754-7353', 25, NULL, NULL, NULL),
(51, '(14) 99639-4507', 26, NULL, NULL, NULL),
(52, '(14) 99636-1097', 27, NULL, NULL, NULL),
(53, '(14) 99889-9391', 28, NULL, NULL, NULL),
(54, '(14) 99612-8668', 29, NULL, NULL, NULL);

CREATE TABLE `tipo_endereco` (
  `ten_cod` int NOT NULL AUTO_INCREMENT,
  `ten_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ten_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

INSERT INTO tipo_endereco (`ten_cod`, `ten_descricao`) VALUES
(1, 'PRINCIPAL'),
(2, 'SECUNDARIO'),
(3, 'PRINCIPAL E SECUNDARIO');

CREATE TABLE `tipo_pagamento_compra` (
  `tpa_cod` int NOT NULL AUTO_INCREMENT,
  `tpa_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tpa_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

INSERT INTO tipo_pagamento_compra (`tpa_cod`, `tpa_descricao`) VALUES
(1, 'Pix');

CREATE TABLE `tipo_usuario` (
  `tus_cod` int NOT NULL AUTO_INCREMENT,
  `tus_descricao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tus_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

INSERT INTO tipo_usuario (`tus_cod`, `tus_descricao`) VALUES
(1, 'Administrador'),
(2, 'Cliente'),
(3, 'Funcionário'),
(4, 'banca'),
(5, 'Funcionario Gestão');

CREATE TABLE `transporte` (
  `transp_id` int NOT NULL AUTO_INCREMENT,
  `venda_prod_id` int DEFAULT NULL,
  `transp_tipo` int DEFAULT NULL,
  `transp_data_envio` date DEFAULT NULL,
  `transp_data_entrega_prevista` date DEFAULT NULL,
  PRIMARY KEY (`transp_id`),
  KEY `venda_prod_id` (`venda_prod_id`),
  CONSTRAINT `transporte_ibfk_1` FOREIGN KEY (`venda_prod_id`) REFERENCES `venda_produto` (`venda_prod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `usuario_endereco` (
  `uen_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `end_id` int DEFAULT NULL,
  `uen_secundario` bit(1) DEFAULT NULL,
  `uen_complemento` varchar(255) DEFAULT NULL,
  `uen_principal` bit(1) DEFAULT NULL,
  `ten_cod` int DEFAULT NULL,
  PRIMARY KEY (`uen_id`),
  KEY `usu_id` (`usu_id`),
  KEY `end_id` (`end_id`),
  KEY `ten_cod` (`ten_cod`),
  CONSTRAINT `usuario_endereco_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`),
  CONSTRAINT `usuario_endereco_ibfk_2` FOREIGN KEY (`end_id`) REFERENCES `enderecos` (`end_id`),
  CONSTRAINT `usuario_endereco_ibfk_3` FOREIGN KEY (`ten_cod`) REFERENCES `tipo_endereco` (`ten_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

INSERT INTO usuario_endereco (`uen_id`, `usu_id`, `end_id`, `uen_secundario`, `uen_complemento`, `uen_principal`, `ten_cod`) VALUES
(1, 1, 1, X'00', 'USANDO SOMENTO ENDERECO PRINCIPAL', X'01', 1),
(2, 9, 2, X'01', 'USANDO ENDERECO PRINCIPAL E SECUNDARIO', X'01', 3);

CREATE TABLE `usuarios` (
  `usu_id` int NOT NULL AUTO_INCREMENT,
  `usu_documento` varchar(255) DEFAULT NULL,
  `usu_nome` varchar(255) DEFAULT NULL,
  `usu_sexo` varchar(255) DEFAULT NULL,
  `usu_data_nascimento` date DEFAULT NULL,
  `usu_email` varchar(100) DEFAULT NULL,
  `usu_senha` varchar(255) DEFAULT NULL,
  `tus_cod` int DEFAULT NULL,
  `usu_data_cadastro` date DEFAULT NULL,
  `usu_data_bloqueio` date DEFAULT NULL,
  `usu_cpf` varchar(14) DEFAULT NULL,
  `usu_perfil_foto` varchar(255) DEFAULT NULL,
  `usu_ativo` tinyint DEFAULT NULL,
  `end_id` int DEFAULT NULL,
  `tel_id` int DEFAULT NULL,
  `usu_senha_provisoria` tinyint DEFAULT NULL,
  PRIMARY KEY (`usu_id`),
  KEY `tus_cod` (`tus_cod`),
  KEY `fk_enderecos` (`end_id`),
  KEY `tel_id` (`tel_id`),
  CONSTRAINT `fk_enderecos` FOREIGN KEY (`end_id`) REFERENCES `enderecos` (`end_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`tus_cod`) REFERENCES `tipo_usuario` (`tus_cod`),
  CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`tel_id`) REFERENCES `telefones` (`tel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;

INSERT INTO usuarios (`usu_id`, `usu_documento`, `usu_nome`, `usu_sexo`, `usu_data_nascimento`, `usu_email`, `usu_senha`, `tus_cod`, `usu_data_cadastro`, `usu_data_bloqueio`, `usu_cpf`, `usu_perfil_foto`, `usu_ativo`, `end_id`, `tel_id`, `usu_senha_provisoria`) VALUES
(1, NULL, 'ADM', 'Masculino', '1990-05-13 00:00:00.000', 'admin@gmail.com', 'adm', 1, '2024-11-12 00:00:00.000', NULL, NULL, 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1732641479/teste/cdkfpvynfjgcclacpkno.jpg', 1, 38, 26, 0),
(2, NULL, 'João Silva', 'Masculino', '1985-04-12 00:00:00.000', 'joao.silva@example.com', 'NG*NQp>b', 2, '2024-11-14 00:00:00.000', NULL, '12345678901', NULL, 0, 39, 27, 1),
(3, NULL, 'Maria Oliveira', 'Feminino', '1992-06-08 00:00:00.000', 'maria.oliveira@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '23456789012', NULL, 0, 40, 28, 0),
(4, NULL, 'Carlos Andrade', 'Masculino', '1980-02-20 00:00:00.000', 'carlos.andrade@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '34567890123', NULL, 0, 41, 29, 0),
(5, NULL, 'Ana Santos', 'Feminino', '1995-12-15 00:00:00.000', 'ana.santos@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '45678901234', NULL, 1, 42, 30, 0),
(6, NULL, 'Paulo Mendes', 'Masculino', '1978-11-23 00:00:00.000', 'paulo.mendes@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '56789012345', NULL, 1, 43, 31, 0),
(7, NULL, 'Fernanda Dias', 'Feminino', '1987-07-30 00:00:00.000', 'fernanda.dias@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '67890123456', NULL, 1, 44, 32, 0),
(8, NULL, 'Ricardo Teixeira', 'Masculino', '1991-09-11 00:00:00.000', 'ricardo.teixeira@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '78901234567', NULL, 1, 45, 33, 0),
(9, NULL, 'Juliana Costa', 'Feminino', '1983-05-18 00:00:00.000', 'juliana.costa@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '89012345678', NULL, 1, 46, 34, 0),
(10, NULL, 'Rodrigo Nunes', 'Masculino', '1994-03-05 00:00:00.000', 'rodrigo.nunes@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '90123456789', NULL, 1, 47, 35, 0),
(11, NULL, 'Bianca Martins', 'Feminino', '1999-10-01 00:00:00.000', 'bianca.martins@example.com', NULL, 2, '2024-11-14 00:00:00.000', NULL, '01234567890', NULL, 1, 48, 36, 0),
(12, NULL, 'Eduarda', 'Feminino', '1999-10-01 00:00:00.000', 'eduarda@example.com', 'JD&Qjw58', 2, '2024-11-14 00:00:00.000', NULL, '01234567890', NULL, 0, 49, 37, 1),
(13, NULL, 'João Pereira', 'Masculino', '1990-05-15 00:00:00.000', 'joao.pereira@example.com', 'Gu2(09b9', NULL, '2024-11-14 00:00:00.000', NULL, '12345678909', NULL, 1, 50, 38, 1),
(14, NULL, 'João Costa', 'Masculino', '1989-07-22 00:00:00.000', 'joao.costa@example.com', 'Mn1!de5b', 3, '2024-11-14 00:00:00.000', NULL, '23456789012', NULL, 0, 51, 39, 1),
(15, NULL, 'João Souza', 'Masculino', '1988-03-14 00:00:00.000', 'joao.souza@example.com', 'Bonfim10@', 3, '2024-11-14 00:00:00.000', NULL, '34567890123', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1732410666/teste/svc79lt5b3av2flebzja.png', 0, 52, 40, 0),
(16, NULL, 'João Almeida', 'Masculino', '1992-11-30 00:00:00.000', 'joao.almeida@example.com', 'Kz7*f5f9', 3, '2024-11-14 00:00:00.000', NULL, '45678901234', NULL, 1, 53, 41, 1),
(17, NULL, 'João Fernandes', 'Masculino', '1987-10-05 00:00:00.000', 'joao.fernandes@example.com', 'Jf9@a920', 3, '2024-11-14 00:00:00.000', NULL, '56789012345', NULL, 1, 54, 42, 1),
(18, NULL, 'João Lima', 'Masculino', '1991-08-19 00:00:00.000', 'joao.lima@example.com', 'Sc2@6a48', 3, '2024-11-14 00:00:00.000', NULL, '67890123456', NULL, 1, 55, 43, 1),
(19, NULL, 'João Mendes', 'Masculino', '1993-01-12 00:00:00.000', 'joao.mendes@example.com', 'Ij9%8673', 3, '2024-11-14 00:00:00.000', NULL, '78901234567', NULL, 1, 56, 44, 1),
(20, NULL, 'João Batista', 'Masculino', '1986-04-09 00:00:00.000', 'joao.batista@example.com', 'Hx6^7b15', 3, '2024-11-14 00:00:00.000', NULL, '89012345678', NULL, 1, 57, 45, 1),
(21, NULL, 'João Nunes', 'Masculino', '1994-06-27 00:00:00.000', 'joao.nunes@example.com', 'Yn7#2896', 3, '2024-11-14 00:00:00.000', NULL, '90123456789', NULL, 1, 58, 46, 1),
(22, NULL, 'João Carvalho', 'Masculino', '1983-02-18 00:00:00.000', 'joao.carvalho@example.com', 'Xv3@980c', 3, '2024-11-14 00:00:00.000', NULL, '01234567890', NULL, 1, 59, 47, 1),
(23, NULL, 'João Martins', 'Masculino', '1982-09-13 00:00:00.000', 'joao.martins@example.com', 'Ks2$6782', 3, '2024-11-14 00:00:00.000', NULL, '09876543210', NULL, 1, 60, 48, 1),
(24, NULL, 'João Rodrigues', 'Masculino', '1981-12-25 00:00:00.000', 'joao.rodrigues@example.com', 'Ek5$4f52', 3, '2024-11-14 00:00:00.000', NULL, '12345098765', NULL, 1, 61, 49, 1),
(25, NULL, 'Luis Gustavo', 'Masculino', '2007-04-03 00:00:00.000', 'luisgustavobonfim996@gmail.com', 'Bonfim10@', 1, '2024-11-23 00:00:00.000', NULL, '55922689800', NULL, 1, 62, 50, 0),
(26, NULL, 'Tcc Usuarios', 'Masculino', '2003-01-07 00:00:00.000', 'tccusuario@gmail.com', 'tccusuario', 4, '2024-11-22 00:00:00.000', NULL, NULL, 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1732568151/teste/jjondgip9riqxqyxtjh5.jpg', 1, NULL, NULL, 0),
(27, NULL, 'Vynicios', 'Masculino', '2002-12-11 00:00:00.000', 'vinnyrafael015@hotmail.com', '@Vyn2962', 1, '2024-11-19 00:00:00.000', NULL, '52023477824', 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1732417029/teste/xwpa3fyc5givuk0nmjoj.png', 1, 64, 52, 0),
(28, NULL, 'Maycon', 'Masculino', '2002-04-12 00:00:00.000', 'fmaycon630@gmail.com', '1Hi_Skto', 3, '2024-11-21 00:00:00.000', NULL, NULL, 'https://res.cloudinary.com/dkmn1nbet/image/upload/v1732388769/teste/e7pl8vty8hyruvuqser7.png', 0, 65, 53, 1),
(29, NULL, 'Teste', 'Masculino', '1999-09-09 00:00:00.000', 'recuperar97@outlook.com.br', NULL, 2, '2024-11-23 00:00:00.000', NULL, '49616328050', NULL, 1, 66, 54, 0);

CREATE TABLE `usuarios_permissoes` (
  `usu_perm_id` int NOT NULL AUTO_INCREMENT,
  `usu_id` int DEFAULT NULL,
  `perm_id` int DEFAULT NULL,
  PRIMARY KEY (`usu_perm_id`),
  KEY `usu_id` (`usu_id`),
  KEY `perm_id` (`perm_id`),
  CONSTRAINT `usuarios_permissoes_ibfk_1` FOREIGN KEY (`usu_id`) REFERENCES `usuarios` (`usu_id`),
  CONSTRAINT `usuarios_permissoes_ibfk_2` FOREIGN KEY (`perm_id`) REFERENCES `permissoes` (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

CREATE TABLE `venda_produto` (
  `venda_prod_id` int NOT NULL AUTO_INCREMENT,
  `venda_id` int DEFAULT NULL,
  `prod_id` int DEFAULT NULL,
  `venda_prod_qtd` int DEFAULT NULL,
  `venda_prod_preco` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`venda_prod_id`),
  KEY `venda_id` (`venda_id`),
  KEY `prod_id` (`prod_id`),
  CONSTRAINT `venda_produto_ibfk_1` FOREIGN KEY (`venda_id`) REFERENCES `vendas` (`venda_id`),
  CONSTRAINT `venda_produto_ibfk_2` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

INSERT INTO venda_produto (`venda_prod_id`, `venda_id`, `prod_id`, `venda_prod_qtd`, `venda_prod_preco`) VALUES
(1, 1, 1, 1, '3000.00'),
(2, 2, 4, 1, '2399.00'),
(3, 3, 18, 1, '499.00'),
(4, 4, 19, 1, '3799.00'),
(5, 5, 20, 1, '129.00'),
(6, 6, 6, 2, '399.00'),
(7, 7, 6, 1, '399.00');

CREATE TABLE `vendas` (
  `venda_id` int NOT NULL AUTO_INCREMENT,
  `cli_id` int DEFAULT NULL,
  `fun_id` int DEFAULT NULL,
  `venda_data` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `venda_valor_total` double DEFAULT NULL,
  `venda_tipo_rec` int DEFAULT NULL,
  `prod_id` int DEFAULT NULL,
  `prod_lote_id` int DEFAULT NULL,
  PRIMARY KEY (`venda_id`),
  KEY `cli_id` (`cli_id`),
  KEY `fun_id` (`fun_id`),
  KEY `prod_id` (`prod_id`),
  KEY `fk_prod_lote` (`prod_lote_id`),
  CONSTRAINT `fk_prod_lote` FOREIGN KEY (`prod_lote_id`) REFERENCES `produto_lote` (`prod_lote_id`),
  CONSTRAINT `prod_id` FOREIGN KEY (`prod_id`) REFERENCES `produto` (`prod_id`),
  CONSTRAINT `vendas_ibfk_1` FOREIGN KEY (`cli_id`) REFERENCES `usuarios` (`usu_id`),
  CONSTRAINT `vendas_ibfk_2` FOREIGN KEY (`fun_id`) REFERENCES `usuarios` (`usu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

INSERT INTO vendas (`venda_id`, `cli_id`, `fun_id`, `venda_data`, `venda_valor_total`, `venda_tipo_rec`, `prod_id`, `prod_lote_id`) VALUES
(1, 3, 18, '2024-11-23 04:25:38.000', 3000, 2, NULL, NULL),
(2, 3, 18, '2024-11-23 05:33:22.000', 2399, 1, NULL, NULL),
(3, 2, 14, '2024-11-23 06:00:29.000', 499, 1, NULL, NULL),
(4, 5, 25, '2024-11-23 06:03:52.000', 3799, 1, NULL, NULL),
(5, 29, 28, '2024-11-23 18:42:39.000', 129, 1, NULL, NULL),
(6, 6, 19, '2024-11-25 19:24:01.000', 798, 1, NULL, NULL),
(7, 6, 20, '2024-11-25 19:24:52.000', 399, 1, NULL, NULL);

