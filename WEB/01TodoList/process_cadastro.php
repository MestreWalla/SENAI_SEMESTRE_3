<?php
// Incluir o arquivo de conexão com o banco de dados
include 'user_connection.php';
// Incluir o arquivo de conexão com o banco de dados
include 'user_connection.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Receber os dados do formulário
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['pass'];

    // Verificar se o nome de usuário ou o email já estão em uso
    $stmt = $conn->prepare("SELECT id FROM usuarios WHERE username = ? OR email = ?");
    $stmt->bind_param("ss", $username, $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        // Nome de usuário ou email já em uso
        echo "Nome de usuário ou email já está em uso.";
    } else {
        // Hash da senha
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Inserir o novo usuário no banco de dados
        $stmt = $conn->prepare("INSERT INTO usuarios (username, email, pass) VALUES (?, ?, ?)");
        $stmt->bind_param("sss", $username, $email, $hashed_password);

        if ($stmt->execute()) {
            header("Location: login.php"); // Redirecionar para a página principal após o login
            // echo "Usuário cadastrado com sucesso.";
        } else {
            echo "Erro ao cadastrar usuário: " . $conn->error;
        }
    }

    // Fechar as instruções preparadas
    $stmt->close();
}
?>
