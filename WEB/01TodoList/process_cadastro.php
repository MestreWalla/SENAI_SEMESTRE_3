<?php
// Incluir o arquivo de conexão com o banco de dados
include 'user_connection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Receber os dados do formulário
    $username = mysqli_real_escape_string($conn, $_POST['username']);
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = $_POST['password'];

    // Hash da senha
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Consulta SQL para verificar se o nome de usuário ou o email já estão em uso
    $sql = "SELECT * FROM usuarios WHERE username = '$username' OR email = '$email'";
    $result = $conn->query($sql);

    if ($result->num_rows == 0) {
        // Se o nome de usuário e o email não estiverem em uso, criar o novo usuário
        $sql = "INSERT INTO usuarios (username, email, password) VALUES ('$username', '$email', '$hashed_password')";
        if ($conn->query($sql) === TRUE) {
            echo "Usuário cadastrado com sucesso.";
        } else {
            echo "Erro ao cadastrar usuário: " . $conn->error;
        }
    } else {
        // Nome de usuário ou email já em uso
        echo "Nome de usuário ou email já está em uso.";
    }
}