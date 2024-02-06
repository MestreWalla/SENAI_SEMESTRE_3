<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Banco de Dados</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
        }

        p {
            text-align: center;
            margin-top: 20px;
        }

        .success {
            color: #4caf50;
        }

        .error {
            color: #f00;
        }

        button {
            display: block;
            margin: 20px auto;
            padding: 10px 20px;
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
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
            die("<p class='error'>Conexão falhou: " . $conn->connect_error . "</p>");
        }

        // Criar banco de dados
        $sql = "CREATE DATABASE IF NOT EXISTS $dbname";
        if ($conn->query($sql) === TRUE) {
            echo "<p class='success'>Banco de dados criado com sucesso!</p>";
        } else {
            echo "<p class='error'>Erro ao criar banco de dados: " . $conn->error . "</p>";
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
            echo "<p class='success'>Tabela de tarefas criada com sucesso!</p>";
        } else {
            echo "<p class='error'>Erro ao criar tabela de tarefas: " . $conn->error . "</p>";
        }

        // Fechar conexão com o banco de dados
        $conn->close();
        ?>

        <button onclick="window.history.back()">Voltar</button>
    </div>
</body>
</html>
