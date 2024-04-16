-- DROP DATABASE SA5_MAYCON_VITOR_CORREA;
-- CRIAÇÃO DO BANCO DE DADOS
-- CREATE DATABASE SA5_MAYCON_VITOR_CORREA;

-- 01 TABELA CLIENTES Campos: ID (chave primária), Nome, Sobrenome, Email.
-- Restrições: Garantir que o campo "Email" seja único.
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);
-- 02 TABELA PEDIDOS Campos: ID (chave primária), ID_Cliente (chave estrangeira referenciando a tabela "Clientes"), Data_Pedido, Total.
-- Restrições: Definir uma restrição de chave estrangeira na tabela "Pedidos" para garantir integridade referencial com a tabela "Clientes".
CREATE TABLE Pedidos (
    ID INT PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);
-- 03 TABELAS PRODUTOS Campos: ID (chave primária), Nome, Descrição, Preço.
-- Restrições: Adicionar uma restrição para garantir que o campo "Preço" seja positivo.
CREATE TABLE Produtos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100),
    Descricao VARCHAR(255) NOT NULL,
    Preço DECIMAL(10, 2) CHECK (Preço >= 0)
);
-- 04 TABELA CATEGORIAS Campos: ID (chave primária), Nome.
CREATE TABLE Categorias (
    ID INT PRIMARY KEY,
    Nome VARCHAR(100)
);
-- 05 TABELA PRODUTOS Campos: ID_Pedido (chave estrangeira referenciando a tabela "Pedidos"), ID_Produto (chave estrangeira referenciando a tabela "Produtos").
-- Restrições: Definir uma restrição de chave composta utilizando os campos "ID_Pedido" e "ID_Produto".
CREATE TABLE Pedidos_Produtos (
    ID_Pedido INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID)
);
-- 06 TABELA PRODUTOS CATEGORIAS Campos: ID_Produto (chave estrangeira referenciando a tabela "Produtos"), ID_Categoria (chave estrangeira referenciando a tabela "Categorias").
-- Restrições: mesma
CREATE TABLE Produtos_Categorias (
    ID_Produto INT,
    ID_Categoria INT,
    PRIMARY KEY (ID_Produto, ID_Categoria),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID)
);
-- 07 TABELA EMPREGADOS Campos: ID (chave primária), Nome, Sobrenome, Cargo.
-- Restrições: Adicionar uma restrição de verificação para garantir que o campo "Cargo" contenha apenas valores válidos (por exemplo, "Gerente", "Vendedor", "Atendente").
CREATE TABLE Empregados (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Cargo VARCHAR(50) CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'))
);
-- 08 TABELA VENDAS Campos: ID (chave primária), ID_Produto (chave estrangeira referenciando a tabela "Produtos"), ID_Cliente (chave estrangeira referenciando a tabela "Clientes"), Data_Venda, Quantidade.
-- Restrições: Definir restrições de chave estrangeira para garantir integridade referencial com as tabelas "Produtos" e "Clientes".
CREATE TABLE Vendas (
    ID INT PRIMARY KEY,
    ID_Produto INT,
    ID_Cliente INT,
    Data_Venda DATE,
    Quantidade INT,
    -- PRIMARY KEY (ID_Produto, ID_Cliente), --NÃO PERMITIDO MULTIPLAS CHAVES PRIMARIAS
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);
-- 09 ALTERAÇÃO DAS TABELAS
-- Adicione uma coluna chamada "Telefone" à tabela "Clientes" para armazenar o número de telefone dos clientes.
ALTER TABLE Clientes ADD Telefone VARCHAR(15);
-- Modifique a coluna "Descrição" da tabela "Produtos" para permitir valores nulos.
ALTER TABLE Produtos ALTER COLUMN Descricao TYPE VARCHAR(255);
-- Remova a restrição de chave estrangeira que referencia a tabela "Clientes" na tabela "Pedidos".
ALTER TABLE Pedidos alter COLUMN ID_Cliente TYPE INT;
-- Renomeie a tabela "Empregados" para "Funcionários".
ALTER TABLE Empregados RENAME TO Funcionarios;

-- DML (DATA MANIPULATION LANGUAGE)
-- 01 Insira cinco novos clientes na tabela "Clientes".
INSERT INTO Clientes (ID, Nome, Sobrenome, Email, Telefone)
VALUES
--ID|NOME|SOBRENOME|EMAIL|TELEFONE
(1, 'João', 'Silva', 'joao@gmail.com', '12341231'),
(2, 'Maria', 'Santos', 'maria@gmail.com', '12341232'),
(3, 'Pedro', 'Almeida', 'pedro@gmail.com', '12341233'),
(4, 'Ana', 'Souza', 'ana@gmail.com', '712341234'),
(5, 'Luiza', 'Oliveira', 'luiza@gmail.com', '12341235');

-- 02 Insira dez novos registros de pedidos na tabela "Pedidos", associando-os a diferentes clientes.
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total)
VALUES
--ID|ID_CLI|DATA_PED|TOTAL
(1, 1, '2024-04-15', 50.00),
(2, 2, '2024-04-14', 100.00),
(3, 3, '2024-04-13', 75.00),
(4, 4, '2024-04-12', 30.00),
(5, 5, '2024-04-11', 45.00),
(6, 1, '2024-04-10', 60.00),
(7, 2, '2024-04-09', 80.00),
(8, 3, '2024-04-08', 25.00),
(9, 4, '2024-04-07', 70.00),
(10, 5, '2024-04-06', 55.00);

-- 03 Insira quinze novos produtos na tabela "Produtos".
INSERT INTO Produtos (ID, Nome, Descricao, Preço)
VALUES
--ID|NOME|DESCRIÇÃO|PREÇO
(1, 'Produto A', 'Descrição A', 10.00),
(2, 'Produto B', 'Descrição B', 20.00),
(3, 'Produto C', 'Descrição C', 15.00),
(4, 'Produto D', NULL, 25.00),
(5, 'Produto E', 'Descrição E', 30.00),
(6, 'Produto F', 'Descrição F', 40.00),
(7, 'Produto G', 'Descrição G', 35.00),
(8, 'Produto H', 'Descrição H', 45.00),
(9, 'Produto I', 'Descrição I', 50.00),
(10, 'Produto J', NULL, 60.00),
(11, 'Produto K', 'Descrição K', 70.00),
(12, 'Produto L', 'Descrição L', 55.00),
(13, 'Produto M', 'Descrição M', 80.00),
(14, 'Produto N', 'Descrição N', 90.00),
(15, 'Produto O', 'Descrição O', 65.00);

-- 03,5 Insira tres novas categorias na tabela "Categorias".
INSERT INTO Categorias (ID, Nome)
VALUES
--ID|NOME
(1, 'Categoria A'),
(2, 'Categoria B'),
(3, 'Categoria C');

-- 04 Associe 3 produtos aos pedidos na tabela "Pedidos_Produtos".
INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto)
VALUES
-- ID_PED|ID_PROD
(1, 1),
(1, 2),
(1, 3);

-- 05 Associe 3 produtos às categorias na tabela "Produtos_Categorias".
INSERT INTO Produtos_Categorias (ID_Produto, ID_Categoria)
VALUES
-- ID_PROD|ID_CATEG
(1, 1),
(2, 2),
(3, 3);

-- 06 Insira cinco registros de funcionários na tabela "Funcionários".
INSERT INTO Funcionarios (ID, Nome, Sobrenome, Cargo)
VALUES
--ID|NOME|SOBRENOME|CARGO
(1, 'Carlos', 'Silva', 'Gerente'),
(2, 'Fernanda', 'Santos', 'Vendedor'),
(3, 'Roberto', 'Almeida', 'Atendente'),
(4, 'Amanda', 'Souza', 'Atendente'),
(5, 'Felipe', 'Oliveira', 'Vendedor');

-- 07 Registre algumas vendas na tabela "Vendas", associando produtos a clientes.
INSERT INTO Vendas (ID, ID_Produto, ID_Cliente, Data_Venda, Quantidade)
VALUES
--ID|ID_PROD|ID_CLI|DATA_VENDA|QTD
(1, 1, 1, '2024-04-15', 2),
(2, 2, 2, '2024-04-14', 1),
(3, 3, 3, '2024-04-13', 3),
(4, 4, 4, '2024-04-12', 1),
(5, 5, 5, '2024-04-11', 2);

-- 08 Atualize o preço de um produto específico na tabela "Produtos".
UPDATE Produtos SET Preço = 12.00 WHERE ID = 1;

-- 09 Atualize o cargo de um funcionário na tabela "Funcionários".
UPDATE Funcionarios SET Cargo = 'Gerente' WHERE ID = 2;

-- 10 Exclua um cliente da tabela "Clientes" e seus respectivos pedidos na tabela "Pedidos".
DELETE FROM Pedidos_Produtos WHERE ID_Pedido IN (SELECT ID FROM Pedidos WHERE ID_Cliente = 1);
DELETE FROM Pedidos WHERE ID_Cliente = 1;
DELETE FROM Vendas WHERE ID_Cliente = 1;
DELETE FROM Clientes WHERE ID = 1;

-- 11 Exclua um produto da tabela "Produtos" e seus registros correspondentes na tabela "Pedidos_Produtos".
DELETE FROM Pedidos_Produtos WHERE ID_Produto = 1;

-- 12 Verificar se existem registros na tabela "Pedidos_Produtos" referentes ao produto que você deseja excluir
DELETE FROM Produtos_Categorias WHERE ID_Produto = 1;
DELETE FROM Produtos WHERE ID = 1;

-- 12 Exclua um funcionário da tabela "Funcionários".
DELETE FROM Funcionarios WHERE ID = 1;

-- 13 Selecione todos os pedidos com status "Em andamento" na tabela "Pedidos".
-- Adicione a coluna "Status" à tabela "Pedidos"
ALTER TABLE Pedidos ADD Status VARCHAR(20);
-- Atualize os registros existentes com um status específico, por exemplo, 'Em andamento'
UPDATE Pedidos SET Status = 'Em andamento' WHERE ID IN (1, 2, 3);
-- Executar sua consulta para selecionar os pedidos com o status 'Em andamento'
SELECT * FROM Pedidos WHERE Status = 'Em andamento';

-- 14 Liste o nome do cliente, a data do pedido e o total de cada pedido feito nos últimos 30 dias na tabela "Pedidos".(não precisa usar Join)
SELECT c.Nome, p.Data_Pedido, p.Total 
FROM Clientes c 
JOIN Pedidos p ON c.ID = p.ID_Cliente 
WHERE p.Data_Pedido >= (CURRENT_DATE - INTERVAL '30' DAY);

-- 15 Liste todos os produtos de uma categoria específica na tabela "Produtos_Categorias".(não precisa usar join)
SELECT p.Nome, p.Descricao, p.Preço 
FROM Produtos p 
JOIN Produtos_Categorias pc ON p.ID = pc.ID_Produto 
WHERE pc.ID_Categoria = 1;
