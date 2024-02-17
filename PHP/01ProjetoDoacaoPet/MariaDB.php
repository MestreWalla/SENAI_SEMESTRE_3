<?php
$servername = "localhost";
$username = "root";
$password = "";

// Conexão com o servidor MySQL
$conn = new mysqli($servername, $username, $password);

// Verificar a conexão
if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

// Consulta SQL para obter todos os bancos de dados, excluindo 'mysql', 'information_schema', 'phpmyadmin' e 'performance_schema'
$sql_databases = "SHOW DATABASES WHERE `Database` NOT IN ('mysql', 'information_schema', 'phpmyadmin', 'performance_schema')";
$result_databases = $conn->query($sql_databases);

if ($result_databases->num_rows > 0) {
    // Iterar sobre cada banco de dados
    while ($row_database = $result_databases->fetch_assoc()) {
        $database_name = $row_database["Database"];
        echo "<h2>Banco de Dados: $database_name</h2>";

        // Conectar ao banco de dados atual
        $conn->select_db($database_name);

        // Consulta SQL para obter todas as tabelas do banco de dados atual
        $sql_tables = "SHOW TABLES";
        $result_tables = $conn->query($sql_tables);

        if ($result_tables->num_rows > 0) {
            // Exibir todas as tabelas do banco de dados atual
            while ($row_table = $result_tables->fetch_row()) {
                $table_name = $row_table[0];
                echo "<h3>Tabela: $table_name</h3>";

                // Consulta SQL para obter todos os registros da tabela atual
                $sql_records = "SELECT * FROM $table_name";
                $result_records = $conn->query($sql_records);

                if ($result_records->num_rows > 0) {
                    // Exibir os itens cadastrados na tabela em uma tabela HTML com estilo
                    echo "<div style='overflow-x:auto;'>";
                    echo "<table border='1' style='border-collapse: collapse; width: 100%;'>";
                    echo "<tr style='background-color: #f2f2f2;'>";
                    // Cabeçalhos da tabela
                    while ($row_record = $result_records->fetch_assoc()) {
                        foreach ($row_record as $key => $value) {
                            echo "<th style='padding: 8px; text-align: left;'>$key</th>";
                        }
                        break; // Somente pegue o cabeçalho da primeira linha
                    }
                    echo "</tr>";
                    // Linhas de dados da tabela
                    $result_records->data_seek(0); // Voltar ao início do conjunto de resultados
                    while ($row_record = $result_records->fetch_assoc()) {
                        echo "<tr>";
                        foreach ($row_record as $key => $value) {
                            echo "<td style='padding: 8px; border: 1px solid #dddddd;'>$value</td>";
                        }
                        echo "</tr>";
                    }
                    echo "</table>";
                    echo "</div>";
                } else {
                    echo "<p>Nenhum registro encontrado nesta tabela.</p>";
                }
            }
        } else {
            echo "<p>Nenhuma tabela encontrada neste banco de dados.</p>";
        }
    }
} else {
    echo "Nenhum banco de dados encontrado.";
}

// Fechar conexão com o servidor MySQL
$conn->close();