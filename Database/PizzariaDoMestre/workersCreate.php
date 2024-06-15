<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Funcionários</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body>
    <?php
    include 'functions.php';
    $pdo = pdo_connect_pgsql();
    $msg = '';
    $error = '';

    // Verifica se os dados POST não estão vazios
    if (!empty($_POST)) {
        $nome = isset($_POST['nome']) ? $_POST['nome'] : '';
        $cargo = isset($_POST['cargo']) ? $_POST['cargo'] : '';
        $status = isset($_POST['status']) ? $_POST['status'] : '';

        // Verifica se todos os campos obrigatórios foram preenchidos
        if ($nome && $cargo && $status) {
            try {
                // Verifica se o funcionário já está cadastrado
                $stmt = $pdo->prepare('SELECT COUNT(*) FROM funcionarios WHERE nome = ? AND cargo = ? AND status = ?');
                $stmt->execute([$nome, $cargo, $status]);
                $funcionarioExistente = $stmt->fetchColumn();

                if ($funcionarioExistente == 0) {
                    // Insere o novo funcionário
                    $stmt = $pdo->prepare('INSERT INTO funcionarios (nome, cargo, status) VALUES (?, ?, ?)');
                    $stmt->execute([$nome, $cargo, $status]);
                    $msg = 'Funcionário cadastrado com sucesso!';
                } else {
                    $error = 'Funcionário já está cadastrado!';
                }
            } catch (PDOException $e) {
                $error = 'Erro ao cadastrar funcionário: ' . $e->getMessage();
            }
        } else {
            $error = 'Por favor, preencha todos os campos obrigatórios!';
        }
    }
    ?>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f0f0f0;
    }
    .header {
        background-color: #333;
        color: #fff;
        padding: 10px;
        text-align: center;
    }
    .content.update {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f9f9f9;
        border: 1px solid #ccc;
        border-radius: 10px;
    }
    .content.update h2 {
        margin: 0 0 20px 0;
        padding-bottom: 10px;
        border-bottom: 1px solid #e0e0e0;
    }
    .content.update form {
        display: flex;
        flex-direction: column;
    }
    .content.update label {
        margin-top: 10px;
        font-weight: bold;
    }
    .content.update input,
    .content.update select {
        padding: 10px;
        margin-top: 5px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .content.update input[type="submit"] {
        margin-top: 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }
    .content.update input[type="submit"]:hover {
        background-color: #45a049;
    }
    .content.update .msg {
        margin-top: 15px;
        font-size: 16px;
        color: green;
    }
    .content.update .error {
        margin-top: 15px;
        font-size: 16px;
        color: red;
    }
    @media (max-width: 600px) {
        .content.update {
            padding: 15px;
        }
        .content.update input,
        .content.update select {
            width: 100%;
            box-sizing: border-box;
        }
    }
    </style>
    <div class="content update">
        <h2>Cadastro de Funcionário</h2>
        <form action="" method="post">
            <label for="nome"><i class="fas fa-user"></i> Nome</label>
            <input type="text" name="nome" id="nome" required>

            <label for="cargo"><i class="fas fa-briefcase"></i> Cargo</label>
            <input type="text" name="cargo" id="cargo" required>

            <label for="status"><i class="fas fa-info-circle"></i> Status</label>
            <select name="status" id="status" required>
                <option value="">Selecione o status</option>
                <option value="Ativo">Ativo</option>
                <option value="Inativo">Inativo</option>
            </select>

            <input type="submit" value="Cadastrar">
        </form>
        <?php if ($msg): ?>
            <div class="msg"><?= $msg ?></div>
        <?php endif; ?>
        <?php if ($error): ?>
            <div class="error"><?= $error ?></div>
        <?php endif; ?>
    </div>
</body>
</html>
