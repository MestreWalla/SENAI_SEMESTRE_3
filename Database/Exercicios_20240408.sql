-- Exercício 1:
-- DDL - Data Definition Language:

-- Criar tabela Clientes
CREATE TABLE Clientes (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- Criar tabela Pedidos
CREATE TABLE Pedidos (
    ID INT PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    Total DECIMAL(10,2),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);

-- Adicionar coluna Status na tabela Pedidos
ALTER TABLE Pedidos
ADD Status VARCHAR(20);

-- DML Data Manipulation Language:

-- Inserir três novos clientes
INSERT INTO Clientes (ID, Nome, Sobrenome, Email) VALUES
(1, 'João', 'Silva', 'joao@example.com'),
(2, 'Maria', 'Santos', 'maria@example.com'),
(3, 'Pedro', 'Souza', 'pedro@example.com');

-- Inserir cinco novos registros de pedidos
INSERT INTO Pedidos (ID, ID_Cliente, Data_Pedido, Total, Status) VALUES
(1, 1, '2024-04-01', 50.00, 'Finalizado'),
(2, 2, '2024-04-02', 75.00, 'Em andamento'),
(3, 1, '2024-04-03', 120.00, 'Finalizado'),
(4, 3, '2024-04-04', 35.00, 'Cancelado'),
(5, 2, '2024-04-05', 90.00, 'Em andamento');

-- Atualizar o campo Total de um pedido específico
UPDATE Pedidos SET Total = 100.00 WHERE ID = 2;

-- Excluir pedidos associados ao cliente ID 3
DELETE FROM Pedidos WHERE ID_Cliente = 3;

-- Excluir um cliente e seus pedidos
DELETE FROM Clientes WHERE ID = 3;

-- Selecionar todos os pedidos com status Em andamento
SELECT * FROM Pedidos WHERE Status = 'Em andamento';

-- Listar o nome do cliente, a data do pedido e o total de cada pedido feito nos últimos 30 dias
SELECT c.Nome, p.Data_Pedido, p.Total
FROM Clientes c
INNER JOIN Pedidos p ON c.ID = p.ID_Cliente
WHERE p.Data_Pedido >= (CURRENT_DATE - INTERVAL '30' DAY);

-- Exercício 2:
-- DDL Data Definition Language:

-- Criar tabela Produtos
CREATE TABLE Produtos (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Descricao VARCHAR(255),
    Preco DECIMAL(10,2) CHECK (Preco > 0)
);

-- Criar tabela Pedidos_Produtos
CREATE TABLE Pedidos_Produtos (
    ID_Pedido INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID)
);

-- Adicionar índice na coluna Nome da tabela Produtos
CREATE INDEX idx_nome ON Produtos (Nome);

-- Criar tabela Categorias
CREATE TABLE Categorias (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50)
);

-- Criar tabela de junção Produtos_Categorias
CREATE TABLE Produtos_Categorias (
    ID_Produto INT,
    ID_Categoria INT,
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID)
);

-- Criar tabela Funcionários
CREATE TABLE Funcionarios (
    ID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Cargo VARCHAR(50),
    CONSTRAINT chk_cargo CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'))
);

-- DML Data Manipulation Language:

-- Inserir cinco novos produtos
INSERT INTO Produtos (ID, Nome, Descricao, Preco) VALUES
(1, 'Celular', 'Smartphone moderno', 900.00),
(2, 'Notebook', 'Laptop com alta performance', 1500.00),
(3, 'Mouse', 'Mouse óptico sem fio', 30.00),
(4, 'Teclado', 'Teclado mecânico RGB', 100.00),
(5, 'Fone de Ouvido', 'Fone de ouvido Bluetooth', 50.00);

-- Associar alguns produtos aos pedidos
INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 5);

-- Atualizar o preço de um produto específico
UPDATE Produtos SET Preco = 950.00 WHERE ID = 1;

-- Excluir registros relacionados na tabela "Pedidos_Produtos"
DELETE FROM Pedidos_Produtos WHERE ID_Produto = 5;

-- Excluir um produto e seus registros correspondentes
DELETE FROM Produtos WHERE ID = 5;


-- Selecionar todos os produtos de uma categoria específica
SELECT * FROM Produtos p
INNER JOIN Produtos_Categorias pc ON p.ID = pc.ID_Produto
INNER JOIN Categorias c ON pc.ID_Categoria = c.ID
WHERE c.Nome = 'Eletrônicos';

-- Listar todos os funcionários e seus cargos
SELECT Nome, Sobrenome, Cargo FROM Funcionarios;

-- Atualizar o cargo de um funcionário
UPDATE Funcionarios SET Cargo = 'Gerente' WHERE ID = 3;

-- Excluir um funcionário
DELETE FROM Funcionarios WHERE ID = 1;

-- Selecionar todos os pedidos
SELECT * FROM Pedidos;

-- Listar os cinco produtos mais caros
SELECT * FROM Produtos ORDER BY Preco DESC LIMIT 5;

-- Calcular o valor total de todos os pedidos
SELECT SUM(Total) AS Valor_Total FROM Pedidos;

-- Listar todos os clientes que fizeram pelo menos um pedido cancelado
SELECT c.*
FROM Clientes c
INNER JOIN Pedidos p ON c.ID = p.ID_Cliente
WHERE p.Status = 'Cancelado';

-- Atualizar o status de todos os pedidos para Finalizado onde a data do pedido for anterior a uma determinada data
UPDATE Pedidos SET Status = 'Finalizado' WHERE Data_Pedido < '2024-04-01';

-- Excluir todos os pedidos finalizados há mais de um ano
DELETE FROM Pedidos WHERE Status = 'Finalizado' AND Data_Pedido < CURRENT_DATE - INTERVAL '1' YEAR;

-- Selecionar os clientes que fizeram mais de dois pedidos nos últimos três meses
SELECT c.*
FROM Clientes c
INNER JOIN Pedidos p ON c.ID = p.ID_Cliente
WHERE p.Data_Pedido >= CURRENT_DATE - INTERVAL '3' MONTH
GROUP BY c.ID
HAVING COUNT(p.ID) > 2;



-- Listar os pedidos agrupados por status e ordená-los pela data do pedido
SELECT * FROM Pedidos ORDER BY Status, Data_Pedido;

-- Atualizar o status de todos os pedidos com mais de 30 dias para "Atrasado"
UPDATE Pedidos SET Status = 'Atrasado' WHERE Data_Pedido < CURRENT_DATE - INTERVAL '30' DAY;

-- Calcular o total de vendas por categoria de produto
SELECT c.Nome AS Categoria, SUM(p.Preco) AS Total_Vendas
FROM Produtos p
INNER JOIN Produtos_Categorias pc ON p.ID = pc.ID_Produto
INNER JOIN Categorias c ON pc.ID_Categoria = c.ID
GROUP BY c.Nome;

-- Listar os produtos que nunca foram associados a nenhum pedido
SELECT p.*
FROM Produtos p
LEFT JOIN Pedidos_Produtos pp ON p.ID = pp.ID_Produto
WHERE pp.ID_Produto IS NULL;
