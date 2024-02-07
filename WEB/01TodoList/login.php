<?php
// Incluir o arquivo de conexão com o banco de dados
include 'db_connection.php';
include 'user_connection.php';
?>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="stylesheet" href="formularios.css">
    <title>Login e Cadastro</title>
    
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
    <div class="login-container">
        <h2>Login ou Cadastro</h2>
        <div id="loginForm">
            <h3>Login</h3>
            <form action="process_login.php" method="POST">
                <input type="text" name="username" placeholder="Nome de usuário" required>
                <input type="password" name="password" placeholder="Senha" required>
                <button type="submit">Entrar</button>
            </form>
            <p>Ainda não tem uma conta? <a href="javascript:void(0);" onclick="toggleForm()">Cadastre-se</a></p>
        </div>
        <div id="cadastroForm" style="display: none;">
            <h3>Cadastro</h3>
            <form action="process_cadastro.php" method="POST">
                <input type="text" name="username" placeholder="Nome de usuário" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="password" name="password" placeholder="Senha" required>
                <button type="submit">Cadastrar</button>
            </form>
            <p>Já possui uma conta? <a href="javascript:void(0);" onclick="toggleForm()">Faça login</a></p>
        </div>
    </div>

    <script>
        function toggleForm() {
            var loginForm = document.getElementById('loginForm');
            var cadastroForm = document.getElementById('cadastroForm');

            if (loginForm.style.display === 'none') {
                loginForm.style.display = 'block';
                cadastroForm.style.display = 'none';
            } else {
                loginForm.style.display = 'none';
                cadastroForm.style.display = 'block';
            }
        }
    </script>
</body>

</html>
