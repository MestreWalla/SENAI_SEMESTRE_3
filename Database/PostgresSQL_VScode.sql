CREATE DATABASE AULA_SQL;

DROP DATABASE AULA_SQL;

CREATE DATABASE DB_AULA25MAR24;

USE DATABASE DB_AULA25MAR24;

CREATE TABLE
    IF NOT EXISTS Fornecedor (
        Fcodigo VARCHAR(30) NOT NULL,
        Fnome VARCHAR(30) NOT NULL,
        Status INT,
        Cidade VARCHAR(30)
    );

SELECT * FROM Fornecedor;

CREATE TABLE IF NOT EXISTS Departamento (
    Dcodigo INT NOT NULL,
    Dnome VARCHAR(30) NOT NULL,
    Cidade VARCHAR(30),
    PRIMARY KEY(Dcodigo)
);

CREATE TABLE IF NOT EXISTS Empregado(
    Ecodigo INT NOT NULL,
    Enome VARCHAR(40) NOT NULL,
    CPF VARCHAR(15) NOT NULL,
    Salario DECIMAL(7,2),
    Dcodigo INT NOT NULL,
    PRIMARY KEY(Ecodigo,Enome),
    FOREIGN KEY(Dcodigo) REFERENCES Departamento
    );

SELECT * FROM Empregado;

-- Adicionar colunas
ALTER TABLE Empregado ADD sexo CHAR(1);
-- Remover colunas
ALTER TABLE Empregado DROP COLUMN sexo;
-- Renomear tabela
ALTER TABLE Empregado RENAME TO Funcionario;
-- Alterar o tipo de dados
ALTER TABLE Fornecedor CHANGE status ativo BOOLEAN;
ALTER TABLE Fornecedor ALTER COLUMN ativo TYPE BOOLEAN;
ALTER TABLE Empregado ALTER COLUMN salario TYPE DECIMAL(10,2);
-- Alterar a nulidade
ALTER TABLE Empregado ALTER COLUMN sexo SET NOT NULL;
-- Alterar o nome da coluna
ALTER TABLE Empregado ALTER COLUMN sexo RENAME TO genero;
