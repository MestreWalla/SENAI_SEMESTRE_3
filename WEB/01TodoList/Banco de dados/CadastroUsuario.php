<?php
// Configurações do banco de dados
$servername = "localhost";
$username = "root";
$password = ""; // Insira sua senha se houver
$dbname = "cadastro_usuarios";

// Criar conexão com o banco de dados
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar a conexão
if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

// Criação da tabela de usuários
$sql = "CREATE TABLE IF NOT EXISTS usuarios (
    id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    senha VARCHAR(255) NOT NULL
)";

if ($conn->query($sql) === TRUE) {
    echo "Tabela de usuários criada com sucesso\n";
} else {
    echo "Erro ao criar tabela de usuários: " . $conn->error;
}

// Fecha a conexão
$conn->close();
