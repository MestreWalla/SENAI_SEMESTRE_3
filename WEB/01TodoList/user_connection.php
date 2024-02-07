<?php
include 'user_connection.php';

// Verificar se o formulário de cadastro foi submetido
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Consulta SQL para verificar se o usuário já existe
    $sql = "SELECT * FROM usuarios WHERE email='$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        echo "Este email já está cadastrado. Por favor, escolha outro.";
    } else {
        // Hash da senha antes de inserir no banco de dados
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Consulta SQL para inserir o novo usuário
        $sql = "INSERT INTO usuarios (nome, email, senha) VALUES ('$username', '$email', '$hashed_password')";
        if ($conn->query($sql) === TRUE) {
            echo "Novo usuário cadastrado com sucesso!";
        } else {
            echo "Erro ao cadastrar novo usuário: " . $conn->error;
        }
    }
}