<?php
$servername = "localhost";
$username = "root";
$password = "";

$conn = new mysqli($servername, $username, $password);

if ($conn->connect_error) {
    die("Conexão falhou: " . $conn->connect_error);
}

$sql = "DROP DATABASE IF EXISTS cadastro_usuarios";

if ($conn->query($sql) === TRUE) {
    echo "Banco de dados apagado com sucesso!";
} else {
    echo "Erro ao apagar banco de dados: " . $conn->error;
}

$conn->close();
?>
