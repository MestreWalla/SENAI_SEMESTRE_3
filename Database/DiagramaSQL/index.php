<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Diagrama do Banco de Dados</title>
    <!-- Adicione o script do Mermaid.js -->
    <script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
</head>
<body>
    <h1>Diagrama do Banco de Dados</h1>
    <!-- Container para o diagrama -->
    <div id="diagrama"></div>

    <?php
    // Conexão com o banco de dados PostgreSQL
    $dsn = "pgsql:host=localhost;dbname=SA5_Maycon_VITOR_CORREA;port=5432";
    $usuario = "postgres";
    $senha = "postgres";

    try {
        $conexao = new PDO($dsn, $usuario, $senha);

        // Consulta para obter informações sobre as tabelas e os relacionamentos
        $consulta = "SELECT
                        tc.table_name AS origem,
                        kcu.column_name AS origem_coluna,
                        ccu.table_name AS destino,
                        ccu.column_name AS destino_coluna
                    FROM
                        information_schema.table_constraints AS tc
                        JOIN information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
                        JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
                    WHERE
                        constraint_type = 'FOREIGN KEY'";
        $resultado = $conexao->query($consulta);

        // Gerar o código Mermaid.js
        $codigoMermaid = "graph TD;\n";

        while ($linha = $resultado->fetch(PDO::FETCH_ASSOC)) {
            $origem = $linha['origem'];
            $destino = $linha['destino'];
            $origem_coluna = $linha['origem_coluna'];
            $destino_coluna = $linha['destino_coluna'];

            $codigoMermaid .= "    $origem -->| $origem_coluna | $destino\n";
        }

        // Renderiza o diagrama usando Mermaid.js
        echo "<script>mermaid.initialize({ startOnLoad: true });</script>";
        echo "<script>mermaid.render('diagrama', '" . addslashes($codigoMermaid) . "', function (svg) {
                document.getElementById('diagrama').innerHTML = svg;
            });</script>";

    } catch (PDOException $e) {
        echo "Erro ao conectar ao banco de dados: " . $e->getMessage();
    }
    ?>

</body>
</html>
