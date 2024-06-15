-- CRIAR BANCO DE DADOS
Create Database pizzaria;

-- CRIAR TABELAS
CREATE TABLE IF NOT EXISTS contatos (
    id_contato INT NOT NULL PRIMARY KEY,
    nome VARCHAR(225) NOT NULL,
    email VARCHAR(225) NOT NULL,
    cell VARCHAR(225) NOT NULL,
    cadastro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS status_pizzas (
    id_status INT NOT NULL PRIMARY KEY,
    id_contato INT NOT NULL,
    status_producao VARCHAR(100) NOT NULL,
    status_entrega VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_contato) REFERENCES contatos(id_contato)
);

CREATE TABLE IF NOT EXISTS ENTREGAS (
    ID_ENTREGAS INT NOT NULL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    CEL VARCHAR(255) NOT NULL,
    PIZZA VARCHAR(255) NOT NULL,
    CADASTRO DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ENTREGA VARCHAR(255) NOT NULL CHECK (ENTREGA IN ('Em Andamento', 'Finalizada')) 
);

CREATE TABLE IF NOT EXISTS promocoes (
    id_promocao SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS pizzas (
    id_pizza SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tamanho VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    ingredientes TEXT NOT NULL,
    id_promocao INT,
    status VARCHAR(255) NOT NULL CHECK (status IN ('Disponivel', 'Indisponivel', 'Promocao')),
    FOREIGN KEY (id_promocao) REFERENCES promocoes (id_promocao)
);

CREATE TABLE IF NOT EXISTS funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cargo VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL
);

ALTER TABLE funcionarios ALTER COLUMN id_funcionario TYPE SERIAL;

CREATE TABLE IF NOT EXISTS bebidas (
    id_bebidas SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_entregas INT NOT NULL,
    id_contato INT NOT NULL,
    id_pizza INT NOT NULL,
    id_bebidas INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_pedido DATE NOT NULL,
    CONSTRAINT fk_id_entregas FOREIGN KEY (id_entregas) REFERENCES entregas (id_entregas),
    CONSTRAINT fk_id_contato FOREIGN KEY (id_contato) REFERENCES contatos (id_contato),
    CONSTRAINT fk_id_pizza FOREIGN KEY (id_pizza) REFERENCES pizzas (id_pizza),
    CONSTRAINT fk_id_bebidas FOREIGN KEY (id_bebidas) REFERENCES bebidas (id_bebidas),
    CONSTRAINT fk_id_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionarios (id_funcionario)
);
ALTER TABLE pedido ADD COLUMN observacao TEXT;


CREATE TABLE IF NOT EXISTS horario_funcionamento (
    id_horario SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    horario_abertura TIME NOT NULL,
    horario_fechamento TIME NOT NULL,
    horario_abertura_feriado TIME,
    horario_fechamento_feriado TIME,
    feriado BOOLEAN NOT NULL DEFAULT FALSE
);

-- APAGAR TABELAS
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS pizzas;
DROP TABLE IF EXISTS bebidas;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS status_pizzas;
DROP TABLE IF EXISTS entregas;
DROP TABLE IF EXISTS contatos;
DROP TABLE IF EXISTS funcionarios;
DROP TABLE IF EXISTS horario_funcionamento;








-- OUTROS
INSERT INTO contatos (id_contato, nome, email, cell, pizza, cadastro) VALUES

SELECT * from contatos

SELECT * FROM contatos ORDER BY id_contato OFFSET :offset 1 :1

SELECT COUNT(*) FROM contatos

alter TABLE contatos
COLUMN id_contato rename to id

SELECT * FROM contatos WHERE id_contato = ?

SELECT 
    p.id_pedido,
    p.data_pedido,
    sp.status_producao,
    sp.status_entrega,
    f.nome AS nome_funcionario,
    f.cargo AS cargo_funcionario
FROM 
    pedido p
JOIN 
    status_pizzas sp ON p.id_pedido = sp.id_pedido
JOIN 
    funcionarios f ON p.id_contato = f.id_funcionario;
