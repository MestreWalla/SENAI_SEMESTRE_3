<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Pedidos</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>

<body>

    <?php
include 'functions.php';
$pdo = pdo_connect_pgsql();
$msg = '';
$error = '';

// Obter dados das tabelas relacionadas
$pizzas = $pdo->query('SELECT id_pizza, nome FROM pizzas')->fetchAll(PDO::FETCH_ASSOC);
$bebidas = $pdo->query('SELECT id_bebidas, nome FROM bebidas')->fetchAll(PDO::FETCH_ASSOC);
$funcionarios = $pdo->query('SELECT id_funcionario, nome FROM funcionarios')->fetchAll(PDO::FETCH_ASSOC);
$entregas = $pdo->query('SELECT id_entregas, nome FROM entregas')->fetchAll(PDO::FETCH_ASSOC);

// Verifica se os dados POST não estão vazios
if (!empty($_POST)) {
    $id_contato = isset($_POST['id_contato']) && !empty($_POST['id_contato']) && $_POST['id_contato'] != 'auto' ? $_POST['id_contato'] : NULL;
    $id_entregas = isset($_POST['id_entregas']) ? $_POST['id_entregas'] : NULL;
    $id_pizza = isset($_POST['id_pizza']) ? $_POST['id_pizza'] : NULL;
    $id_bebidas = isset($_POST['id_bebidas']) ? $_POST['id_bebidas'] : NULL;
    $id_funcionario = isset($_POST['id_funcionario']) ? $_POST['id_funcionario'] : NULL;
    $cadastro = isset($_POST['cadastro']) ? $_POST['cadastro'] : date('Y-m-d H:i:s');

    // Verifica se todos os campos obrigatórios foram preenchidos
    if ($id_contato && $id_entregas && $id_pizza && $id_bebidas && $id_funcionario) {
        $stmt = $pdo->prepare('INSERT INTO pedido (id_contato, id_entregas, id_pizza, id_bebidas, id_funcionario, data_pedido) VALUES (?, ?, ?, ?, ?, ?)');
        $stmt->execute([$id_contato, $id_entregas, $id_pizza, $id_bebidas, $id_funcionario, $cadastro]);
        $msg = 'Pedido Realizado com Sucesso!';
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
        padding-bottomer: 10px;
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

    /* Responsividade */
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

    <?=template_header('Cadastro de Pedidos')?>


    <div class="content update">
        <h2>Registrar Pedido</h2>
        <form action="create.php" method="post">
            <label for="id_contato"><i class="fas fa-id-card"></i> Cliente</label>
            <select name="id_entregas" id="id_entregas">
                <option value="">Selecione o cliente</option>
                <?php foreach ($entregas as $entrega): ?>
                <option value="<?=$entrega['id_entregas']?>"><?=$entrega['nome']?></option>
                <?php endforeach; ?>
            </select>

            <label for="id_entregas"><i class="fas fa-truck"></i> Entrega</label>
            <select name="id_funcionario" id="id_funcionario">
                <option value="">Selecione o Funcionário</option>
                <?php foreach ($funcionarios as $funcionario): ?>
                <option value="<?=$funcionario['id_funcionario']?>"><?=$funcionario['nome']?></option>
                <?php endforeach; ?>
            </select>

            <label for="id_pizza"><i class="fas fa-pizza-slice"></i> Pizza</label>
            <select name="id_pizza" id="id_pizza">
                <option value="">Selecione a Pizza</option>
                <?php foreach ($pizzas as $pizza): ?>
                <option value="<?=$pizza['id_pizza']?>"><?=$pizza['nome']?></option>
                <?php endforeach; ?>
            </select>

            <label for="id_bebidas"><i class="fas fa-glass-martini-alt"></i> Bebida</label>
            <select name="id_bebidas" id="id_bebidas">
                <option value="">Selecione a Bebida</option>
                <?php foreach ($bebidas as $bebida): ?>
                <option value="<?=$bebida['id_bebidas']?>"><?=$bebida['nome']?></option>
                <?php endforeach; ?>
            </select>

            <label for="id_funcionario"><i class="fas fa-user-tie"></i> Funcionário</label>
            <select name="id_funcionario" id="id_funcionario">
                <option value="">Selecione o Funcionário</option>
                <?php foreach ($funcionarios as $funcionario): ?>
                <option value="<?=$funcionario['id_funcionario']?>"><?=$funcionario['nome']?></option>
                <?php endforeach; ?>
            </select>

            <label for="observacao"><i class="fas fa-sticky-note"></i> Observação</label>
            <textarea name="observacao" id="observacao" rows="5" placeholder="Observações sobre o pedido"></textarea>

            <input type="submit" name="cadastrar" value="Cadastrar">
        </form>

        <?php if(isset($_GET['mensagem'])): ?>
        <div class="msg">
            <?php if($_GET['mensagem'] == 'sucesso'): ?>
            <i class="fas fa-check"></i> Pedido registrado com sucesso!
            <?php elseif($_GET['mensagem'] == 'erro'): ?>
            <i class="fas fa-times"></i> Erro ao registrar o pedido. Tente novamente.
            <?php endif; ?>
        </div>
        <?php endif; ?>
    </div>