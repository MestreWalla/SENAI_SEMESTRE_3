--EXERCICIO_01 - CRIAÇÃO DAS TABELAS

-- Criação do Banco de Dados
CREATE DATABASE Exercicios_Aula;

-- Utilização do Banco de Dados criado
USE exercicios_aula;

-- Criação das Tabelas
CREATE TABLE Fornecedor (
    Fcodigo INT PRIMARY KEY,
    Fnome VARCHAR(255),
    Status VARCHAR(20) DEFAULT 'Ativo',
    Cidade VARCHAR(100)
);

CREATE TABLE Peca (
    Pcodigo INT PRIMARY KEY,
    Pnome VARCHAR(255) NOT NULL,
    Cor VARCHAR(50),
    Peso INT,
    Cidade VARCHAR(100)
);

CREATE TABLE Instituicao (
    Icodigo INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE Projeto (
    PRcod INT PRIMARY KEY,
    PRnome VARCHAR(255),
    Cidade VARCHAR(100),
    Icod INT,
    FOREIGN KEY (Icod) REFERENCES Instituicao(Icodigo)
);

CREATE TABLE Fornecimento (
    Fcod INT PRIMARY KEY,
    Pcod INT,
    PRcod INT,
    Quantidade INT,
    FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcodigo),
    FOREIGN KEY (Pcod) REFERENCES Peca(Pcodigo),
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod)
);

--EXERCICIO_02 - ALTERAÇÃO DAS TABELAS

ALTER TABLE Fornecedor RENAME COLUMN Fcodigo TO Fcod;
ALTER TABLE Fornecedor ADD COLUMN Fone VARCHAR(20);
ALTER TABLE Fornecedor ADD COLUMN Ccod INT;

CREATE TABLE Cidade (
    Ccod INT PRIMARY KEY,
    Cnome VARCHAR(100),
    uf VARCHAR(2)
);

ALTER TABLE Peca RENAME COLUMN Pcodigo TO Pcod;
ALTER TABLE Peca ADD COLUMN Ccod INT;
ALTER TABLE Projeto RENAME COLUMN PRcod TO PRcod;
ALTER TABLE Projeto ADD COLUMN Ccod INT;
ALTER TABLE Fornecimento RENAME COLUMN Fcod TO Fcod;

DROP TABLE Instituicao;

--EXERCICIO_03 - INSERÇÃO DE DADOS

INSERT INTO Fornecedor (Fcod, Fnome, Status, Fone, Ccod) VALUES
(01, 'Kalunga', 'Ativo', '1930234066', 11),
(02, 'LLC Logística', 'Inativo', '1130245578', 12),
(03, 'Velho Barreiro', 'Ativo', '1930324068', 13),
(04, 'Hyundai', 'Ativo', '1930224545', 14);

INSERT INTO Cidade (Ccod, Cnome, uf) VALUES
(11, 'Limeira', 'SP'),
(12, 'São Paulo', 'SP'),
(13, 'Rio Claro', 'SP'),
(14, 'Piracicaba', 'SP');

INSERT INTO Peca (Pcod, Pnome, Cor, Peso, Ccod) VALUES
(0001, 'Processador', 'Padrão', 300, 12),
(0002, 'Lona', 'Azul', 12, 11),
(0003, 'Cachaça', 'Transparente', 11, 13),
(0004, 'Hyundai Creta', 'Prata', 1000, 14);

INSERT INTO Projeto (PRcod, PRnome, Ccod) VALUES
(01, 'Eletrônicos', 11),
(02, 'Mecânicos', 13),
(03, 'Escolas', 12);

INSERT INTO Fornecimento (Fcod, Pcod, PRcod, Quantidade) VALUES
(01, 0001, 01, 660),
(02, 0002, 03, 10),
(04, 0004, 02, 220);

--VISUALIZAR TABELAS

SELECT * FROM public.Fornecedor ORDER BY Fcod ASC
SELECT * FROM public.Cidade ORDER BY Ccod ASC
SELECT * FROM public.Peca ORDER BY Pcod ASC
SELECT * FROM public.Projeto ORDER BY PRcod ASC
SELECT * FROM public.Fornecimento ORDER BY Fcod ASC