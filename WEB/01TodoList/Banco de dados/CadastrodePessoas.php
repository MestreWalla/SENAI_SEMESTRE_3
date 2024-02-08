<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Banco de Dados de Usuários</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f2f2f2;
        }

        .container {
            max-width: 800px;
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th,
        td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>

<body>
    <div class="container">
        <?php
        // Configurações do banco de dados
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "usuarios";

        // Criar conexão com o banco de dados
        $conn = new mysqli($servername, $username, $password);

        // Verificar a conexão
        if ($conn->connect_error) {
            die("<p class='error'>Conexão falhou: " . $conn->connect_error . "</p>");
        }

        // Função para criar o banco de dados
        function criarBancoDeDados($conn, $dbname)
        {
            // Criar banco de dados
            $sql = "CREATE DATABASE IF NOT EXISTS $dbname";
            if ($conn->query($sql) === TRUE) {
                echo "<p class='success'>Banco de dados criado com sucesso!</p>";
            } else {
                echo "<p class='error'>Erro ao criar banco de dados: " . $conn->error . "</p>";
            }
        }

        // Função para criar a tabela de usuários
        function criarTabelaUsuarios($conn, $dbname)
        {
            // Selecionar o banco de dados
            $conn->select_db($dbname);

            // Criar tabela de usuários
            $sql = "CREATE TABLE IF NOT EXISTS usuarios (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    username VARCHAR(255) NOT NULL,
                    email VARCHAR(255) NOT NULL,
                    pass VARCHAR(255) NOT NULL
                )";

            if ($conn->query($sql) === TRUE) {
                echo "<p class='success'>Tabela de usuários criada com sucesso!</p>";
            } else {
                echo "<p class='error'>Erro ao criar tabela de usuários: " . $conn->error . "</p>";
            }
        }

        // Função para apagar o banco de dados
        function apagarBancoDeDados($conn, $dbname)
        {
            // Apagar banco de dados
            $sql = "DROP DATABASE IF EXISTS $dbname";
            if ($conn->query($sql) === TRUE) {
                echo "<p class='success'>Banco de dados apagado com sucesso!</p>";
            } else {
                echo "<p class='error'>Erro ao apagar banco de dados: " . $conn->error . "</p>";
            }
        }

        // Função para mostrar os usuários na tabela
        function mostrarUsuarios($conn, $dbname)
        {
            // Verificar se o banco de dados existe
            $result = $conn->query("SHOW DATABASES LIKE '$dbname'");
            if ($result->num_rows == 1) {
                // Selecionar o banco de dados
                $conn->select_db($dbname);

                // Consulta SQL para selecionar todos os usuários
                $sql = "SELECT * FROM usuarios";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    echo "<table>";
                    echo "<tr><th>ID</th><th>Nome de Usuário</th><th>Email</th></tr>";
                    while ($row = $result->fetch_assoc()) {
                        echo "<tr><td>{$row['id']}</td><td>{$row['username']}</td><td>{$row['email']}</td></tr>";
                    }
                    echo "</table>";
                } else {
                    echo "<p class='error'>Nenhum usuário encontrado.</p>";
                }
            } else {
                echo "<p class='error'>O banco de dados '$dbname' não existe.</p>";
            }
        }

        // Verificar se o botão de criar foi clicado
        if (isset($_POST['criar'])) {
            criarBancoDeDados($conn, $dbname);
            criarTabelaUsuarios($conn, $dbname);
        }

        // Verificar se o botão de apagar foi clicado
        if (isset($_POST['apagar'])) {
            apagarBancoDeDados($conn, $dbname);
        }

        // Mostrar os usuários
        mostrarUsuarios($conn, $dbname);

        // Fechar conexão com o banco de dados
        $conn->close();
        ?>

        <form method="post">
            <input type="submit" name="criar" value="Criar Banco de Dados">
            <input type="submit" name="apagar" value="Apagar Banco de Dados" onclick="return confirm('Tem certeza de que deseja apagar o banco de dados?');">
        </form>

        <button onclick="window.history.back()">Voltar</button>
    </div>
</body>

</html>