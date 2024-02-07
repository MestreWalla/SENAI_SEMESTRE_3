<?php
// Incluir o arquivo de conexão com o banco de dados
include 'db_connection.php';

// Verificar se o formulário foi submetido
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Receber os dados do formulário e sanitizá-los
    $nome = mysqli_real_escape_string($conn, $_POST['nome']);
    $descricao = mysqli_real_escape_string($conn, $_POST['descricao']);
    $data_conclusao = $_POST['data_conclusao'];
    $tags = mysqli_real_escape_string($conn, $_POST['etiqueta']); // Corrigido para 'etiqueta'

    // Preparar e executar a consulta SQL para inserir os dados na tabela de tarefas
    $stmt = $conn->prepare("INSERT INTO tarefas (nome, descricao, data_conclusao, tags) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $nome, $descricao, $data_conclusao, $tags);

    if ($stmt->execute()) {
        echo "Nova tarefa criada com sucesso!";
    } else {
        echo "Erro ao criar nova tarefa: " . $conn->error;
    }

    $stmt->close(); // Fechar a declaração
}
?>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <title>To-do-list</title>
</head>

<body>
    <header>
        <div class="user">
            <a href="login.php" id="loginLink">
                <span class="material-symbols-outlined">account_circle</span>
                <?php
                session_start();

                if (isset($_SESSION['user_id'])) {
                    // Se o usuário estiver logado, exibir seu nome
                    echo '<p class="userContent">' . $_SESSION['username'] . '</p>';
                } else {
                    // Se o usuário não estiver logado, exibir o texto "Logar"
                    echo '<p class="userContent">Logar</p>';
                }
                ?>
            </a>

            <a href="logout.php" class="userContent logout"><span class="material-symbols-outlined">logout</span></a>
        </div>
        <!-- Links do menu -->
        <a href="#">
            <span class="material-symbols-outlined">today</span>
            <p>Meu dia</p>
        </a>
        <a href="#">
            <span class="material-symbols-outlined">priority_high</span>
            <p>Importante</p>
        </a>
        <a href="#">
            <span class="material-symbols-outlined">event_note</span>
            <p>Planejado</p>
        </a>
        <a href="#">
            <span class="material-symbols-outlined">done</span>
            <p>Concluídos</p>
        </a>
        <a href="#">
            <span class="material-symbols-outlined">contract_delete</span>
            <p>Cancelados</p>
        </a>
        <a href="#">
            <span class="material-symbols-outlined">favorite</span>
            <p>Favoritos</p>
        </a>
        <hr>
        <!-- Exibir as tags existentes no banco de dados -->
        <?php
        // Consulta SQL para selecionar todas as tags distintas da tabela de tarefas que não são vazias
        $sql_tags = "SELECT DISTINCT tags FROM tarefas WHERE tags <> ''";

        $result_tags = $conn->query($sql_tags);

        // Verificar se há resultados da consulta
        if ($result_tags->num_rows > 0) {
            // Exibir as tags em uma lista no menu lateral
            while ($row_tags = $result_tags->fetch_assoc()) {
                echo '<a href="#" class="labels">';
                echo '<span class="material-symbols-outlined">label</span>';
                echo '<p>' . $row_tags['tags'] . '</p>';
                echo '</a>';
            }
        } else {
            echo '<p>Nenhuma tag encontrada.</p>';
        }
        ?>
    </header>
    <main>
        <div class="mayDay">
            <div class="title">
                <h1>Meu Dia</h1>
                <div id="current_date">
                    <script>
                        var currentDate = new Date();
                        var daysOfWeek = ['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'];
                        var months = ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];

                        var dayOfWeek = daysOfWeek[currentDate.getDay()];
                        var dayOfMonth = currentDate.getDate();
                        var month = months[currentDate.getMonth()];
                        var year = currentDate.getFullYear();

                        var formattedDate = dayOfWeek + ', ' + dayOfMonth + ' de ' + month + ' de ' + year;

                        document.getElementById("current_date").innerHTML = formattedDate;
                    </script>
                </div>
            </div>
            <div class="myDayContent">
                <form method="POST" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>">
                    <div class="input">
                        <input type="text" name="nome" placeholder="Nome" id="nome">
                        <input type="text" name="descricao" placeholder="Descrição" id="descricao">
                        <input type="text" name="etiqueta" placeholder="Etiqueta" id="etiqueta">
                        <input type="date" name="data_conclusao" placeholder="Data para conclusão" id="data">
                        <button type="submit">
                            <span class="material-symbols-outlined">add</span>
                            <p>Adicionar tarefa</p>
                        </button>
                    </div>
                </form>
                <?php
                // Consulta SQL para selecionar todas as tarefas da tabela
                $sql = "SELECT * FROM tarefas";
                $result = $conn->query($sql);

                // Verificar se há resultados da consulta
                if ($result->num_rows > 0) {
                    // Exibir as tarefas em uma lista não ordenada
                    while ($row = $result->fetch_assoc()) {
                        echo '<div class="task">';
                        echo '<input class="checkbox" type="checkbox" id="' . $row['id'] . '" name="' . $row['id'] . '" value="' . $row['nome'] . '">';
                        echo '<label for="' . $row['id'] . '"></label>';
                        echo '<p>' . $row['nome'] . '</p>';
                        echo '<p>' . $row['descricao'] . '</p>';
                        echo '<p>' . $row['tags'] . '</p>';
                        echo '<p>' . $row['data_conclusao'] . '</p>';
                        echo '<div class="opcoesTarefa">';
                        echo '<span class="material-symbols-outlined">more_horiz</span>';
                        echo '<div class="opcoesTarefaButtons">';
                        echo '<div>';
                        echo '<span class="material-symbols-outlined">task_alt</span>';
                        echo '<p>Completar Tarefa</p>';
                        echo '</div>';
                        echo '<div>';
                        echo '<span class="material-symbols-outlined">delete</span>';
                        echo '<p>Apagar Tarefa</p>';
                        echo '</div>';
                        echo '</div>';
                        echo '</div>';
                        echo '</div>';
                    }
                } else {
                    echo 'Nenhuma tarefa encontrada.';
                }
                ?>
            </div>
            <input type="color" name="" id="">
        </div>
    </main>
</body>

</html>