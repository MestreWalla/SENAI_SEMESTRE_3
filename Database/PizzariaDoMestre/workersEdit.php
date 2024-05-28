<?php
include 'functions.php';
$pdo = pdo_connect_pgsql();
$msg = '';

// Verifica se o ID do funcionário existe, por exemplo, update_worker.php?id=1 irá obter o funcionário com o id 1
if (isset($_GET['id'])) {
    if (!empty($_POST)) {
        // Esta parte é semelhante ao create.php, mas aqui estamos atualizando um registro e não inserindo
        $id_funcionario = isset($_POST['id']) ? $_POST['id'] : NULL;
        $nome = isset($_POST['nome']) ? $_POST['nome'] : '';
        $cargo = isset($_POST['cargo']) ? $_POST['cargo'] : '';
        $status = isset($_POST['status']) ? $_POST['status'] : '';

        // Atualiza o registro
        $stmt = $pdo->prepare('UPDATE funcionarios SET nome = ?, cargo = ?, status = ? WHERE id_funcionario = ?');
        $stmt->execute([$nome, $cargo, $status, $_GET['id']]);
        $msg = 'Atualização Realizada com Sucesso!';
    }

    // Obter o funcionário da tabela funcionarios
    $stmt = $pdo->prepare('SELECT * FROM funcionarios WHERE id_funcionario = ?');
    $stmt->execute([$_GET['id']]);
    $funcionario = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$funcionario) {
        exit('Funcionário Não Localizado!');
    }
} else {
    exit('Nenhum Funcionário Especificado!');
}
?>

<?=template_header('Atualizar/Alterar Funcionário')?>

<div class="content update">
    <h2><i class="fas fa-edit"></i> Atualizar Funcionário <?=$funcionario['nome']?></h2>
    <form action="update_worker.php?id=<?=$funcionario['id_funcionario']?>" method="post">
        <label for="id_funcionario">ID</label>
        <label for="nome">Nome</label>
        <input type="text" name="id" placeholder="" value="<?=$funcionario['id_funcionario']?>" id="id_funcionario" readonly>
        <input type="text" name="nome" placeholder="Nome do Funcionário" value="<?=$funcionario['nome']?>" id="nome">
        <label for="cargo">Cargo</label>
        <label for="status">Status</label>
        <input type="text" name="cargo" placeholder="Cargo do Funcionário" value="<?=$funcionario['cargo']?>" id="cargo">
        <input type="text" name="status" placeholder="Status do Funcionário" value="<?=$funcionario['status']?>" id="status">
        <input type="submit" value="Atualizar">
    </form>
    <?php if ($msg): ?>
        <p><?=$msg?></p>
    <?php endif; ?>
</div>

<?=template_footer()?>
