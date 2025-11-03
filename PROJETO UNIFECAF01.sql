-- ************************************************************
-- CONFIGURAÇÃO E ESTRUTURA INICIAL
-- ************************************************************

-- Comando inicial para criar e usar o banco de dados do projeto
CREATE DATABASE IF NOT EXISTS teste002;
USE teste002;

-- Comentário: A estrutura das tabelas está organizada em 'Mãe' (entidades independentes) e 'Filhas' (que dependem de outras).

-- ************************************************************
-- 1. CRIAÇÃO DAS TABELAS MÃE (ENTIDADES INDEPENDENTES)
-- ************************************************************

-- 1.1. MARCA (Ex: Nestlé, Arcor)
CREATE TABLE tbl_marca (
	id_marca INT AUTO_INCREMENT PRIMARY KEY,
	nome_marca VARCHAR(100) NOT NULL UNIQUE
);
-- INSERTS DE MARCA
INSERT INTO tbl_marca (nome_marca) VALUES ('Nestlé');
SET @ID_NESTLE = LAST_INSERT_ID();
INSERT INTO tbl_marca (nome_marca) VALUES ('Arcor');
SET @ID_ARCOR = LAST_INSERT_ID();
INSERT INTO tbl_marca (nome_marca) VALUES ('FriBoi');
SET @ID_FRIBOI = LAST_INSERT_ID();


-- 1.2. CATEGORIA (Ex: Limpeza, Chocolate)
CREATE TABLE tbl_categoria (
	id_categoria INT AUTO_INCREMENT PRIMARY KEY,
	nome_categoria VARCHAR(100) NOT NULL UNIQUE
);
-- INSERTS DE CATEGORIA
INSERT INTO tbl_categoria (nome_categoria) VALUES ('Limpeza');
SET @ID_LIMPEZA = LAST_INSERT_ID();
INSERT INTO tbl_categoria (nome_categoria) VALUES ('Chocolate');
SET @ID_CHOCOLATE = LAST_INSERT_ID();
INSERT INTO tbl_categoria (nome_categoria) VALUES ('Picanha');
SET @ID_PICANHA = LAST_INSERT_ID();
INSERT INTO tbl_categoria (nome_categoria) VALUES ('Bebidas');
SET @ID_BEBIDAS = LAST_INSERT_ID();


-- 1.3. FORNECEDOR (Empresas que fornecem os produtos)
CREATE TABLE tbl_fornecedor (
	id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
	cnpj_fornecedor VARCHAR (14) NOT NULL UNIQUE,
	nome_fornecedor VARCHAR (255) NOT NULL,
	razao_social VARCHAR (255) NOT NULL
);
-- INSERTS DE FORNECEDOR
INSERT INTO tbl_fornecedor (cnpj_fornecedor, nome_fornecedor, razao_social)
VALUES ('12345678000195', 'Padaria do Zé', 'Zé da Padoca Comércio de Pães LTDA');
SET @ID_FORNECEDOR_ZE = LAST_INSERT_ID();
INSERT INTO tbl_fornecedor (cnpj_fornecedor, nome_fornecedor, razao_social)
VALUES ('98765432000100', 'Química Limpa', 'Química Limpa Indústria LTDA');
SET @ID_FORNECEDOR_QUIMICA = LAST_INSERT_ID();
INSERT INTO tbl_fornecedor (cnpj_fornecedor, nome_fornecedor, razao_social)
VALUES ('55544433000111', 'Distribuidora Fria', 'Distribuidora Fria Bebidas LTDA');
SET @ID_FORNECEDOR_BEBIDAS = LAST_INSERT_ID();


-- 1.4. CATEGORIA DE ESTOQUE (Localização física: Seco, Refrigerado)
CREATE TABLE tbl_categoria_estoque (
	id_categoria_estoque INT AUTO_INCREMENT PRIMARY KEY,
	nome_categoria_estoque VARCHAR(100) NOT NULL
);
-- INSERTS DE CATEGORIA ESTOQUE
INSERT INTO tbl_categoria_estoque (nome_categoria_estoque)
VALUES ('Seco Padaria');
SET @ID_ESTOQUE_SECO = LAST_INSERT_ID();
INSERT INTO tbl_categoria_estoque (nome_categoria_estoque)
VALUES ('Refrigerado');
SET @ID_ESTOQUE_REFRIG = LAST_INSERT_ID();


-- 1.5. COLABORADOR (Funcionários do mercado)
CREATE TABLE tbl_colaborador (
	id_colaborador INT PRIMARY KEY AUTO_INCREMENT,
	cpf_colaborador VARCHAR(11) UNIQUE,
	nome_colaborador VARCHAR(255) NOT NULL,
	cargo_colaborador VARCHAR(50),
	setor_colaborador VARCHAR(50),
	data_admissao DATE NOT NULL,
	telefone_colaborador VARCHAR(14)
);
-- INSERTS DE COLABORADOR
INSERT INTO tbl_colaborador (cpf_colaborador, nome_colaborador, cargo_colaborador, setor_colaborador, data_admissao)
VALUES ('32437125322', 'Irineu', 'Manobrista', 'Garagem', '2023-01-15');
SET @ID_COLABORADOR_IRINEU = LAST_INSERT_ID();
INSERT INTO tbl_colaborador (cpf_colaborador, nome_colaborador, cargo_colaborador, setor_colaborador, data_admissao)
VALUES ('11122233344', 'Joana Silva', 'Caixa Principal', 'Frente de Loja', '2022-05-20');
SET @ID_COLABORADOR_JOANA = LAST_INSERT_ID();


-- 1.6. CLIENTE (Clientes cadastrados no sistema)
CREATE TABLE tbl_cliente (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
	cpf_cliente VARCHAR(11) UNIQUE,
	nome_cliente VARCHAR(255) NOT NULL,
	data_cadastro DATE NOT NULL,
	telefone_cliente VARCHAR(14)
);
-- INSERTS DE CLIENTE
INSERT INTO tbl_cliente (cpf_cliente, nome_cliente, data_cadastro, telefone_cliente)
VALUES ('55566677788', 'Ana Maria Braga', '2024-03-10', '11987654321');
SET @ID_CLIENTE_ANA = LAST_INSERT_ID();


-- 1.7. CLIENTE NÃO CADASTRADO (Para vendas sem identificação)
CREATE TABLE tbl_cliente_nc (
	id_cliente_nc INT AUTO_INCREMENT PRIMARY KEY,
	nome_cliente_nao_cadastrado VARCHAR(100)
);
-- INSERTS DE CLIENTE NÃO CADASTRADO
INSERT INTO tbl_cliente_nc (nome_cliente_nao_cadastrado) VALUES ('CLIENTE NÃO CADASTRADO');
SET @CLIENTE_NC = LAST_INSERT_ID();


-- 1.8. FORMA DE PAGAMENTO (Ex: PIX, Crédito, Dinheiro)
CREATE TABLE tbl_forma_pagamento (
	id_forma_pagamento INT AUTO_INCREMENT PRIMARY KEY,
	nome_forma_pagamento VARCHAR(100) NOT NULL UNIQUE
);
-- INSERTS DE FORMA DE PAGAMENTO
INSERT INTO tbl_forma_pagamento (nome_forma_pagamento) VALUES ('VALE_REFEICAO');
SET @VALE_REFEICAO = LAST_INSERT_ID();
INSERT INTO tbl_forma_pagamento (nome_forma_pagamento) VALUES ('VALE_ALIMENTACAO');
SET @VALE_ALIMENTACAO = LAST_INSERT_ID();
INSERT INTO tbl_forma_pagamento (nome_forma_pagamento) VALUES ('CREDITO');
SET @CREDITO = LAST_INSERT_ID();
INSERT INTO tbl_forma_pagamento (nome_forma_pagamento) VALUES ('DÉBITO');
SET @DEBITO = LAST_INSERT_ID();
INSERT INTO tbl_forma_pagamento (nome_forma_pagamento) VALUES ('DINHEIRO');
SET @DINHEIRO = LAST_INSERT_ID();
INSERT INTO tbl_forma_pagamento (nome_forma_pagamento) VALUES ('PIX');
SET @PIX = LAST_INSERT_ID();


-- ************************************************************
-- 2. CRIAÇÃO DAS TABELAS FILHAS E DE RELACIONAMENTO
-- ************************************************************

-- 2.1. ENDEREÇO FORNECEDOR (Depende de tbl_fornecedor)
CREATE TABLE tbl_endereco_fornecedor (
	id_endereco_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
	id_fornecedor INT NOT NULL UNIQUE,
	cep_endereco_fornecedor CHAR(8) NOT NULL,
	pais_endereco_fornecedor VARCHAR(50) NOT NULL,
	estado_endereco_fornecedor CHAR(2) NOT NULL,
	cidade_endereco_fornecedor VARCHAR(100) NOT NULL,
	rua_endereco_fornecedor VARCHAR(255) NOT NULL,
	numero_endereco_fornecedor VARCHAR(10) NOT NULL,
	andar_endereco_fornecedor VARCHAR(50) NULL,
	numero_apto_fornecedor VARCHAR(50) NULL,
FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedor(id_fornecedor)
);
-- INSERTS DE ENDEREÇO FORNECEDOR (Um para o Fornecedor Padaria do Zé)
INSERT INTO tbl_endereco_fornecedor (id_fornecedor, cep_endereco_fornecedor, pais_endereco_fornecedor, estado_endereco_fornecedor, cidade_endereco_fornecedor, rua_endereco_fornecedor, numero_endereco_fornecedor)
VALUES (@ID_FORNECEDOR_ZE, '05407000', 'Brasil', 'SP', 'São Paulo', 'Rua Butantã', '123');


-- 2.2. ENDEREÇO COLABORADOR (Depende de tbl_colaborador)
CREATE TABLE tbl_endereco_colaborador (
	id_colaborador_endereco INT PRIMARY KEY AUTO_INCREMENT,
	id_colaborador INT NOT NULL UNIQUE,
	cep_endereco_colaborador CHAR(8) NOT NULL,
	pais_endereco_colaborador VARCHAR(50) NOT NULL,
	estado_endereco_colaborador CHAR(2) NOT NULL,
	cidade_endereco_colaborador VARCHAR(100) NOT NULL,
	rua_endereco_colaborador VARCHAR(255) NOT NULL,
	numero_endereco_colaborador VARCHAR(10) NOT NULL,
	andar_endereco_colaborador VARCHAR(50) NULL,
	numero_apto_colaborador VARCHAR(50) NULL,
	FOREIGN KEY (id_colaborador) REFERENCES tbl_colaborador(id_colaborador)
);
-- INSERTS DE ENDEREÇO COLABORADOR (Um para Irineu)
INSERT INTO tbl_endereco_colaborador (id_colaborador, cep_endereco_colaborador, pais_endereco_colaborador, estado_endereco_colaborador, cidade_endereco_colaborador, rua_endereco_colaborador, numero_endereco_colaborador)
VALUES (@ID_COLABORADOR_IRINEU, '06764000', 'Brasil', 'SP', 'Taboão da Serra', 'Rua dos Pinheiros', '45');


-- 2.3. ENDEREÇO CLIENTE (Depende de tbl_cliente - o cliente cadastrado)
CREATE TABLE tbl_endereco_cliente (
	id_cliente_endereco INT PRIMARY KEY AUTO_INCREMENT,
	id_cliente INT NOT NULL UNIQUE,
	cep_endereco_cliente CHAR(8) NOT NULL,
	pais_endereco_cliente VARCHAR(50) NOT NULL,
	estado_endereco_cliente CHAR(2) NOT NULL,
	cidade_endereco_cliente VARCHAR(100) NOT NULL,
	rua_endereco_cliente VARCHAR(255) NOT NULL,
	numero_endereco_cliente VARCHAR(10) NOT NULL,
	data_cadastro DATE NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente)
);
-- INSERTS DE ENDEREÇO CLIENTE (Um para Ana Maria Braga)
INSERT INTO tbl_endereco_cliente (id_cliente, cep_endereco_cliente, pais_endereco_cliente, estado_endereco_cliente, cidade_endereco_cliente, rua_endereco_cliente, numero_endereco_cliente, data_cadastro)
VALUES (@ID_CLIENTE_ANA, '01000000', 'Brasil', 'SP', 'São Paulo', 'Avenida Paulista', '1000', NOW());


-- 2.4. PRODUTO (Núcleo do sistema, liga Marca, Categoria e Fornecedor)
CREATE TABLE tbl_produto (
	id_produto INT AUTO_INCREMENT PRIMARY KEY,
	cod_barras_produto VARCHAR(20) NOT NULL UNIQUE,
	nome_produto VARCHAR(255) NOT NULL,
	descricao_produto TEXT,
	preco_venda DECIMAL(10, 2) NOT NULL,
	estoque INT NOT NULL DEFAULT 0, -- Estoque total refletido

	id_fornecedor INT NOT NULL,
	id_categoria INT NOT NULL,
	id_marca INT NOT NULL,

	FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedor(id_fornecedor),
	FOREIGN KEY (id_categoria) REFERENCES tbl_categoria(id_categoria),
	FOREIGN KEY (id_marca) REFERENCES tbl_marca(id_marca)
);
-- INSERTS DE PRODUTO
INSERT INTO tbl_produto (cod_barras_produto, nome_produto, descricao_produto, preco_venda, id_fornecedor, id_categoria, id_marca, estoque)
VALUES ('7891234567885', 'Chocolate ao Leite Arcor', 'Chocolate em barra Arcor ao leite.', 20.50, @ID_FORNECEDOR_ZE, @ID_CHOCOLATE, @ID_ARCOR, 0);
SET @ID_PRODUTO_CHOCO = LAST_INSERT_ID();

INSERT INTO tbl_produto (cod_barras_produto, nome_produto, descricao_produto, preco_venda, id_fornecedor, id_categoria, id_marca, estoque)
VALUES ('9998887776665', 'Picanha Bovina Resfriada 1,5Kg', 'Picanha Bovina embalada a vácuo, de primeira qualidade da marca FriBoi.', 65.90, @ID_FORNECEDOR_QUIMICA, @ID_PICANHA, @ID_FRIBOI, 0);
SET @ID_PRODUTO_PICANHA = LAST_INSERT_ID();

INSERT INTO tbl_produto (cod_barras_produto, nome_produto, descricao_produto, preco_venda, id_fornecedor, id_categoria, id_marca, estoque)
VALUES ('5454332211009', 'Refrigerante Cola 2L', 'Refrigerante sabor cola da marca Nestlé.', 7.99, @ID_FORNECEDOR_BEBIDAS, @ID_BEBIDAS, @ID_NESTLE, 0);
SET @ID_PRODUTO_REFRIGERANTE = LAST_INSERT_ID();


-- ************************************************************
-- MÓDULO DE ENTRADA/COMPRA (NOTAS FISCAIS)
-- ************************************************************

-- 2.5. ENTRADA (Cabeçalho da Nota Fiscal de Compra)
CREATE TABLE tbl_entrada (
	id_entrada INT AUTO_INCREMENT PRIMARY KEY,
	nota_fiscal VARCHAR(50) NOT NULL UNIQUE,
	data_entrada DATETIME NOT NULL,
	id_fornecedor INT NOT NULL,
FOREIGN KEY (id_fornecedor) REFERENCES tbl_fornecedor(id_fornecedor)
);
-- INSERTS DE ENTRADA (Duas Notas Fiscais)
-- NF 1: Picanha
INSERT INTO tbl_entrada (nota_fiscal, data_entrada, id_fornecedor)
VALUES ('NF-45678', '2025-10-25 10:00:00', @ID_FORNECEDOR_QUIMICA);
SET @ID_ENTRADA_PICANHA = LAST_INSERT_ID();

-- NF 2: Refrigerante
INSERT INTO tbl_entrada (nota_fiscal, data_entrada, id_fornecedor)
VALUES ('NF-88899', '2025-10-26 14:30:00', @ID_FORNECEDOR_BEBIDAS);
SET @ID_ENTRADA_REFRIGERANTE = LAST_INSERT_ID();


-- 2.6. ITENS DA ENTRADA (Detalhes dos produtos comprados na NF)
CREATE TABLE tbl_entrada_item (
	id_entrada_item INT AUTO_INCREMENT PRIMARY KEY,
	id_entrada INT NOT NULL,
	id_produto INT NOT NULL,
	qtdes_entrada INT NOT NULL,
	preco_custo DECIMAL(10, 2) NOT NULL,
FOREIGN KEY (id_entrada) REFERENCES tbl_entrada(id_entrada),
FOREIGN KEY (id_produto) REFERENCES tbl_produto(id_produto)
);
-- INSERTS DE ITENS DA ENTRADA
-- Itens da NF 1 (Picanha)
INSERT INTO tbl_entrada_item (id_entrada, id_produto, qtdes_entrada, preco_custo)
VALUES (@ID_ENTRADA_PICANHA, @ID_PRODUTO_PICANHA, 50, 45.00);

-- Itens da NF 2 (Refrigerante)
INSERT INTO tbl_entrada_item (id_entrada, id_produto, qtdes_entrada, preco_custo)
VALUES (@ID_ENTRADA_REFRIGERANTE, @ID_PRODUTO_REFRIGERANTE, 100, 4.50);


-- 2.7. CONFIRMAÇÃO DE ENTRADA (Quem e quando confirmou a chegada da mercadoria)
CREATE TABLE tbl_confirmacao_entrada (
	id_confirmacao_entrada INT PRIMARY KEY AUTO_INCREMENT,
	data_confirmacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status_confirmacao VARCHAR(10) NOT NULL,
	id_entrada INT NOT NULL UNIQUE,
	id_colaborador INT,
FOREIGN KEY (id_entrada) REFERENCES tbl_entrada(id_entrada),
FOREIGN KEY (id_colaborador) REFERENCES tbl_colaborador(id_colaborador)
);
-- INSERTS DE CONFIRMAÇÃO DE ENTRADA
INSERT INTO tbl_confirmacao_entrada (id_entrada, status_confirmacao, id_colaborador)
VALUES (@ID_ENTRADA_PICANHA, 'CONFIRMADO', @ID_COLABORADOR_IRINEU);
INSERT INTO tbl_confirmacao_entrada (id_entrada, status_confirmacao, id_colaborador)
VALUES (@ID_ENTRADA_REFRIGERANTE, 'CONFIRMADO', @ID_COLABORADOR_JOANA);


-- ************************************************************
-- MÓDULO DE ESTOQUE (LOCALIZAÇÃO)
-- ************************************************************

-- 2.8. ESTOQUE PALETE (Estoque de Reserva/Depósito)
CREATE TABLE tbl_estoque_palete (
	id_estoque_palete INT AUTO_INCREMENT PRIMARY KEY,
	id_produto INT NOT NULL UNIQUE,
	id_categoria_estoque INT,
	quantidade_atual INT NOT NULL,
	FOREIGN KEY (id_produto) REFERENCES tbl_produto(id_produto),
	FOREIGN KEY (id_categoria_estoque) REFERENCES tbl_categoria_estoque(id_categoria_estoque)
);
-- INSERTS DE ESTOQUE PALETE (O estoque de reserva recebe o saldo da compra)
INSERT INTO tbl_estoque_palete (id_produto, id_categoria_estoque, quantidade_atual)
VALUES (@ID_PRODUTO_PICANHA, @ID_ESTOQUE_REFRIG, 50);
INSERT INTO tbl_estoque_palete (id_produto, id_categoria_estoque, quantidade_atual)
VALUES (@ID_PRODUTO_REFRIGERANTE, @ID_ESTOQUE_SECO, 100);

-- 2.9. ESTOQUE GÔNDOLA (Estoque de Venda/Prateleira)
CREATE TABLE tbl_estoque_gondola (
	id_estoque_gondola INT AUTO_INCREMENT PRIMARY KEY,
	id_produto INT NOT NULL UNIQUE,
	quantidade_atual INT NOT NULL,
	id_categoria_estoque INT,
	FOREIGN KEY (id_produto) REFERENCES tbl_produto(id_produto),
	FOREIGN KEY (id_categoria_estoque) REFERENCES tbl_categoria_estoque(id_categoria_estoque)
);
-- INSERTS DE ESTOQUE GÔNDOLA (Simulação da primeira reposição)
INSERT INTO tbl_estoque_gondola (id_produto, quantidade_atual, id_categoria_estoque)
VALUES (@ID_PRODUTO_PICANHA, 10, @ID_ESTOQUE_REFRIG);
INSERT INTO tbl_estoque_gondola (id_produto, quantidade_atual, id_categoria_estoque)
VALUES (@ID_PRODUTO_REFRIGERANTE, 20, @ID_ESTOQUE_SECO);

-- ATUALIZAÇÃO DO ESTOQUE TOTAL NA TABELA PRODUTO
-- Reflete o saldo total no depósito e na gôndola
UPDATE tbl_produto SET estoque = 50 + 10 WHERE id_produto = @ID_PRODUTO_PICANHA;
UPDATE tbl_produto SET estoque = 100 + 20 WHERE id_produto = @ID_PRODUTO_REFRIGERANTE;


-- ************************************************************
-- MÓDULO DE VENDA (CAIXA)
-- ************************************************************

-- 2.10. VENDA (CABEÇALHO DA VENDA - O Cupom Fiscal)
CREATE TABLE tbl_venda (
	id_venda INT AUTO_INCREMENT PRIMARY KEY,
	data_venda DATETIME NOT NULL,
	valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
	id_colaborador INT NOT NULL,
	id_cliente INT NULL,
	id_cliente_nc INT NULL,
	FOREIGN KEY (id_colaborador) REFERENCES tbl_colaborador(id_colaborador),
	FOREIGN KEY (id_cliente) REFERENCES tbl_cliente(id_cliente),
	FOREIGN KEY (id_cliente_nc) REFERENCES tbl_cliente_nc(id_cliente_nc)
);


-- 2.11. ITEM DA VENDA (DETALHE - Quais produtos e quantidades foram vendidos)
CREATE TABLE tbl_item_venda (
	id_item_venda INT AUTO_INCREMENT PRIMARY KEY,
	id_venda INT NOT NULL,
	id_produto INT NOT NULL,
	qtd_vendida INT NOT NULL,
	preco_unitario_venda DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (id_venda) REFERENCES tbl_venda(id_venda),	
    FOREIGN KEY (id_produto) REFERENCES tbl_produto(id_produto)
);


-- 2.12. PAGAMENTO (Registro das formas de pagamento usadas na venda)
CREATE TABLE tbl_pagamento (
	id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
	id_venda INT NOT NULL,
	id_forma_pagamento INT NOT NULL,
	valor_pago DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (id_venda) REFERENCES tbl_venda(id_venda),
	FOREIGN KEY (id_forma_pagamento) REFERENCES tbl_forma_pagamento(id_forma_pagamento)
);


-- ************************************************************
-- 3. SIMULAÇÃO DE VENDA (FLUXO COMPLETO DE CAIXA)
-- ************************************************************

-- VENDA 1: Cliente Não Cadastrado, paga com PIX (Picanha + Chocolate)

START TRANSACTION;

SET @VENDEDOR = @ID_COLABORADOR_JOANA;
SET @QTD_CHOCO = 2;
SET @QTD_PICANHA = 1;

-- 1. REGISTRA O CABEÇALHO DA VENDA
INSERT INTO tbl_venda (data_venda, id_colaborador, id_cliente_nc)
VALUES (NOW(), @VENDEDOR, @CLIENTE_NC);
SET @ID_VENDA_1 = LAST_INSERT_ID();

-- 2. REGISTRA OS ITENS VENDIDOS
INSERT INTO tbl_item_venda (id_venda, id_produto, qtd_vendida, preco_unitario_venda)
VALUES 
    (@ID_VENDA_1, @ID_PRODUTO_CHOCO, @QTD_CHOCO, 20.50),
    (@ID_VENDA_1, @ID_PRODUTO_PICANHA, @QTD_PICANHA, 65.90);

-- 3. CALCULA O VALOR TOTAL DA VENDA (Resultado: 106.90)
SET @TOTAL_VENDA_1 = (
    SELECT SUM(qtd_vendida * preco_unitario_venda) FROM tbl_item_venda WHERE id_venda = @ID_VENDA_1
);

-- 4. ATUALIZA CABEÇALHO E REGISTRA PAGAMENTO
UPDATE tbl_venda SET valor_total = @TOTAL_VENDA_1 WHERE id_venda = @ID_VENDA_1;
INSERT INTO tbl_pagamento (id_venda, id_forma_pagamento, valor_pago)
VALUES (@ID_VENDA_1, @PIX, @TOTAL_VENDA_1);

-- 5. BAIXA NO ESTOQUE GÔNDOLA E PRODUTO
UPDATE tbl_estoque_gondola SET quantidade_atual = quantidade_atual - @QTD_CHOCO WHERE id_produto = @ID_PRODUTO_CHOCO;
UPDATE tbl_estoque_gondola SET quantidade_atual = quantidade_atual - @QTD_PICANHA WHERE id_produto = @ID_PRODUTO_PICANHA;
UPDATE tbl_produto SET estoque = estoque - (@QTD_CHOCO + @QTD_PICANHA) WHERE id_produto IN (@ID_PRODUTO_CHOCO, @ID_PRODUTO_PICANHA);

COMMIT;

-- ************************************************************
-- 4. VERIFICAÇÃO FINAL
-- ************************************************************

-- Mostra os detalhes da Venda 1
SELECT 
    T1.id_venda, T1.valor_total, T3.nome_forma_pagamento, T4.nome_colaborador
FROM tbl_venda T1
JOIN tbl_pagamento T2 ON T1.id_venda = T2.id_venda
JOIN tbl_forma_pagamento T3 ON T2.id_forma_pagamento = T3.id_forma_pagamento
JOIN tbl_colaborador T4 ON T1.id_colaborador = T4.id_colaborador
WHERE T1.id_venda = @ID_VENDA_1;

-- Mostra os estoques após a venda
SELECT
    T1.nome_produto,
    T1.estoque AS 'Estoque_Total',
    T2.quantidade_atual AS 'Estoque_Palete_Atual',
    T3.quantidade_atual AS 'Estoque_Gôndola_Atual'
FROM tbl_produto T1
LEFT JOIN tbl_estoque_palete T2 ON T1.id_produto = T2.id_produto
LEFT JOIN tbl_estoque_gondola T3 ON T1.id_produto = T3.id_produto
WHERE T1.id_produto IN (@ID_PRODUTO_PICANHA, @ID_PRODUTO_REFRIGERANTE);

SELECT
    V.id_venda AS 'ID da Venda',
    V.data_venda AS 'Data da Venda',
    P.nome_produto AS 'Produto Vendido',
    IV.qtd_vendida AS 'Quantidade',
    IV.preco_unitario_venda AS 'Preço Unitário (R$)',
    (IV.qtd_vendida * IV.preco_unitario_venda) AS 'Subtotal do Item (R$)'
FROM 
    tbl_venda V
JOIN 
    tbl_item_venda IV ON V.id_venda = IV.id_venda -- Liga o cabeçalho ao detalhe
JOIN 
    tbl_produto P ON IV.id_produto = P.id_produto -- Liga o detalhe ao nome do produto
ORDER BY 
    V.data_venda DESC; -- Mais recente primeiro

SELECT
    P.nome_produto AS 'Produto',
    SUM(IV.qtd_vendida) AS 'Total de Unidades Vendidas',
    SUM(IV.qtd_vendida * IV.preco_unitario_venda) AS 'Total de Receita Gerada (R$)'
FROM
    tbl_item_venda IV
JOIN
    tbl_produto P ON IV.id_produto = P.id_produto
GROUP BY
    P.nome_produto -- Agrupa por nome para consolidar os totais
ORDER BY
    'Total de Unidades Vendidas' DESC; -- Os mais vendidos no topo

SELECT
    FP.nome_forma_pagamento AS 'Forma de Pagamento',
    COUNT(T1.id_venda) AS 'Quantidade de Vendas',
    SUM(T1.valor_total) AS 'Total Arrecadado (R$)'
FROM
    tbl_venda T1
JOIN
    tbl_pagamento T2 ON T1.id_venda = T2.id_venda
JOIN
    tbl_forma_pagamento FP ON T2.id_forma_pagamento = FP.id_forma_pagamento
GROUP BY
    FP.nome_forma_pagamento
ORDER BY
    'Total Arrecadado (R$)' DESC;

-- DROP DATABASE IF EXISTS teste002; -- Comando para limpar tudo