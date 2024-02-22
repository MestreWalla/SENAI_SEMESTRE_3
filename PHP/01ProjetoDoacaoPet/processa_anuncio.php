<?php
require_once 'conectaBD.php';
session_start();

// Verifica se o usuário está autenticado
if (empty($_SESSION)) {
    // Se não estiver autenticado, redireciona para a página de login
    header("Location: index.php?msgErro=Você precisa se autenticar no sistema.");
    die();
}

// Verifica se o formulário foi enviado
if (!empty($_POST)) {
    // Verifica se o formulário foi enviado para cadastro de anúncio
    if ($_POST['enviarDados'] == 'CAD') {
        // Verifica se foi enviado um arquivo de imagem
        if (!empty($_FILES['imagem']['tmp_name'])) {
            // Obtém o nome do arquivo e o caminho temporário no servidor
            $nomeArquivo = $_FILES['imagem']['name'];
            $caminhoTemporario = $_FILES['imagem']['tmp_name'];
            $caminhoDestino = 'img/' . $nomeArquivo;
            if (!move_uploaded_file($caminhoTemporario, $caminhoDestino)) {
                // Se houver um erro ao mover o arquivo, redireciona com uma mensagem de erro
                header("Location: index_logado.php?msgErro=Erro ao enviar arquivo de imagem.");
                exit();
            }
        } else {
            // Caso não tenha sido enviado um arquivo de imagem
            $caminhoDestino = '';
        }

        try {
            $sql = "INSERT INTO anuncio
                    (fase, tipo, porte, sexo, pelagem_cor, raca, observacao, email_usuario, imagem)
                    VALUES
                    (:fase, :tipo, :porte, :sexo, :pelagem_cor, :raca, :observacao, :email_usuario, :imagem)";
            $stmt = $pdo->prepare($sql);
            $dados = array(
                ':fase' => $_POST['fase'],
                ':tipo' => $_POST['tipo'],
                ':porte' => $_POST['porte'],
                ':sexo' => $_POST['sexo'],
                ':pelagem_cor' => $_POST['pelagemCor'],
                ':raca' => $_POST['raca'],
                ':observacao' => $_POST['observacao'],
                ':email_usuario' => $_SESSION['email'],
                ':imagem' => $caminhoDestino
            );
            if ($stmt->execute($dados)) {
                // Redireciona para a página de sucesso
                header("Location: index_logado.php?msgSucesso=Anúncio cadastrado com sucesso!");
                exit(); // Encerra o script após redirecionar
            }
        } catch (PDOException $e) {
            // Em caso de erro, redireciona para a página de erro
            header("Location: index_logado.php?msgErro=Falha ao cadastrar anúncio.");
            exit(); // Encerra o script após redirecionar
        }
    } else {
        // Se a operação não estiver definida, redireciona com uma mensagem de erro
        header("Location: index_logado.php?msgErro=Erro de acesso (Operação não definida).");
        exit(); // Encerra o script após redirecionar
    }
} else {
    // Se não houver dados no POST, redireciona com uma mensagem de erro
    header("Location: index_logado.php?msgErro=Erro de acesso.");
    exit(); // Encerra o script após redirecionar
}