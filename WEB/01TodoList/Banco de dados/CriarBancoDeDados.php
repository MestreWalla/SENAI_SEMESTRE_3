<?php
// Configurações do banco de dados
$servername = "localhost";
$username = "seu_usuario";
$password = "sua_senha";
$dbname = "nome_do_banco_de_dados";

// Criar conexão com o banco de dados
$conn = new mysqli($servername, $username, $password);

// Verificar a conexão
if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

// Criar banco de dados
$sql = "CREATE DATABASE IF NOT EXISTS $dbname";
if ($conn->query($sql) === TRUE) {
    echo "Banco de dados criado com sucesso!";
} else {
    echo "Erro ao criar banco de dados: " . $conn->error;
}

// Selecionar o banco de dados
$conn->select_db($dbname);

// Criar tabela de tarefas
$sql = "CREATE TABLE IF NOT EXISTS tarefas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    data_conclusao DATE,
    status ENUM('pendente', 'concluida', 'cancelado') DEFAULT 'pendente',
    favorito BOOLEAN DEFAULT FALSE,
    tags VARCHAR(255)
)";

if ($conn->query($sql) === TRUE) {
    echo "Tabela de tarefas criada com sucesso!";
} else {
    echo "Erro ao criar tabela de tarefas: " . $conn->error;
}

// Fechar conexão com o banco de dados
$conn->close();
?>
