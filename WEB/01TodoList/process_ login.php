<?php
session_start();

// Incluir o arquivo de conexão com o banco de dados
include 'user_connection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Receber os dados do formulário
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $password = $_POST['password'];

    // Consulta SQL para selecionar o usuário com o nome de usuário fornecido
    $sql = "SELECT * FROM usuarios WHERE username = '$username'";
    $result = $conn->query($sql);

    if ($result->num_rows == 1) {
        // Se o usuário existir, verificar a senha
        $row = $result->fetch_assoc();
        if (password_verify($password, $row['password'])) {
            // Senha correta, iniciar a sessão do usuário
            $_SESSION['user_id'] = $row['id'];
            $_SESSION['username'] = $row['username'];
            header("Location: index.php"); // Redirecionar para a página principal após o login
            exit();
        } else {
            // Senha incorreta
            echo "Senha incorreta.";
        }
    } else {
        // Usuário não encontrado
        echo "Usuário não encontrado.";
    }
}