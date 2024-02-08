<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interface do Banco de Dados</title>
</head>
<body>
    <h1>Banco de Dados</h1>
    <button onclick="apagarBanco()">Apagar Banco de Dados</button>
    <button onclick="criarBanco()">Criar Banco de Dados</button>
    
    <h2>Tabela de Usuários</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
        </tr>
        <?php
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "cadastro_usuarios";

        $conn = new mysqli($servername, $username, $password, $dbname);

        if ($conn->connect_error) {
            die("Conexão falhou: " . $conn->connect_error);
        }

        $sql = "SELECT id, nome, email FROM usuarios";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td>" . $row["id"] . "</td>";
                echo "<td>" . $row["nome"] . "</td>";
                echo "<td>" . $row["email"] . "</td>";
                echo "</tr>";
            }
        } else {
            echo "<tr><td colspan='3'>Nenhum usuário cadastrado</td></tr>";
        }

        $conn->close();
        ?>
    </table>

    <script>
        function apagarBanco() {
            if (confirm("Tem certeza de que deseja apagar o banco de dados?")) {
                window.location.href = "apagar_banco.php";
            }
        }

        function criarBanco() {
            if (confirm("Tem certeza de que deseja criar o banco de dados?")) {
                window.location.href = "criar_banco.php";
            }
        }
    </script>
</body>
</html>
