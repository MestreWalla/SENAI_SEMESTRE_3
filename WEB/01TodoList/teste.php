<?php
// Incluir o arquivo de conexão com o banco de dados
include 'db_connection.php';

// Verificar se o formulário foi submetido
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Receber os dados do formulário
    $nome = $_POST['nome'];
    $descricao = $_POST['descricao'];
    $data_conclusao = $_POST['data_conclusao'];

    // Preparar e executar a consulta SQL para inserir os dados na tabela de tarefas
    $sql = "INSERT INTO tarefas (nome, descricao, data_conclusao) VALUES ('$nome', '$descricao', '$data_conclusao')";
    if ($conn->query($sql) === TRUE) {
        echo "Nova tarefa criada com sucesso!";
    } else {
        echo "Erro ao criar nova tarefa: " . $conn->error;
    }
}

// Fechar a conexão com o banco de dados (opcional, pois a conexão será fechada automaticamente no final do script)
$conn->close();
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
            <a href="#">
                <span class="material-symbols-outlined">account_circle</span>
                <p class="userContent">Maycon</p>
            </a>
            <a href="" class="userContent logout"><span class="material-symbols-outlined">logout</span></a>
        </div>
        <a href="">
            <span class="material-symbols-outlined">
                today
            </span>
            <p>Meu dia</p>
        </a>
        <a href="">
            <span class="material-symbols-outlined">
                priority_high
            </span>
            <p>Importante</p>
        </a>
        <a href="">
            <span class="material-symbols-outlined">
                event_note
            </span>
            <p>Planejado</p>
        </a>
        <a href="">
            <span class="material-symbols-outlined">
                done
            </span>
            <p>Finalizado</p>
        </a>
        <a href="">
            <span class="material-symbols-outlined">
                contract_delete
            </span>
            <p>Cancelado</p>
        </a>
        <a href="">
            <span class="material-symbols-outlined">
                favorite
            </span>
            <p>Favoritos</p>
        </a>
        <hr>
        <a href="#" id="labels" class="labels">
            <span class="material-symbols-outlined">
                label
            </span>
            <p>Label 01</p>
        </a>
        <a href="#" id="labels" class="labels">
            <span class="material-symbols-outlined">
                label
            </span>
            <p>Label 02</p>
        </a>
        <a href="#" id="labels" class="labels">
            <span class="material-symbols-outlined">
                label
            </span>
            <p>Label 03</p>
        </a>
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
                        <input type="text" name="nome" placeholder="nome" id="nome">
                        <button type="submit">
                            <span class="material-symbols-outlined">
                                add
                            </span>
                            <p>Adicionar tarefa</p>
                        </button>
                    </div>
                    <div class="input">
                        <input type="text" name="descricao" placeholder="descrição" id="descricao">
                        <input type="date" name="data_conclusao" placeholder="data para conclusão" id="data">
                    </div>
                </form>
                <?php
// Incluir o arquivo de conexão com o banco de dados
include 'db_connection.php';

// Consulta SQL para selecionar todas as tarefas da tabela
$sql = "SELECT * FROM tarefas";
$result = $conn->query($sql);

// Verificar se há resultados da consulta
if ($result->num_rows > 0) {
    // Exibir as tarefas em uma lista não ordenada
    echo '<ul>';
    while ($row = $result->fetch_assoc()) {
        echo '<li>';
        echo '<input class="checkbox" type="checkbox" id="' . $row['id'] . '" name="' . $row['id'] . '" value="' . $row['nome'] . '">';
        echo '<label for="' . $row['id'] . '"></label>';
        echo '<p>' . $row['nome'] . '</p>';
        echo '</li>';
    }
    echo '</ul>';
} else {
    echo 'Nenhuma tarefa encontrada.';
}

// Fechar a conexão com o banco de dados
$conn->close();
?>

            </div>
            <input type="color" name="" id="">
        </div>
    </main>
</body>

</html>
