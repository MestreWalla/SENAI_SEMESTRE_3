<?php
include 'functions.php';

$pdo = pdo_connect_pgsql();
$msg = '';

// Verifica se o ID do funcionário foi fornecido via parâmetro GET
if (isset($_GET['id'])) {
    // Verifica se o formulário foi enviado via POST
    if (!empty($_POST)) {
        // Captura os dados do formulário
        $id_funcionario = isset($_POST['id']) ? $_POST['id'] : NULL;
        $nome = isset($_POST['nome']) ? $_POST['nome'] : '';
        $cargo = isset($_POST['cargo']) ? $_POST['cargo'] : '';
        $status = isset($_POST['status']) ? $_POST['status'] : '';

        // Prepara e executa a declaração SQL para atualizar o funcionário
        $stmt = $pdo->prepare('UPDATE funcionarios SET nome = ?, cargo = ?, status = ? WHERE id_funcionario = ?');
        $stmt->execute([$nome, $cargo, $status, $_GET['id']]);
        $msg = 'Atualização Realizada com Sucesso!';
    }

    // Obtém os dados atuais do funcionário da tabela funcionarios
    $stmt = $pdo->prepare('SELECT * FROM funcionarios WHERE id_funcionario = ?');
    $stmt->execute([$_GET['id']]);
    $funcionario = $stmt->fetch(PDO::FETCH_ASSOC);

    // Verifica se o funcionário foi encontrado
    if (!$funcionario) {
        exit('Funcionário Não Localizado!');
    }
} else {
    exit('Nenhum Funcionário Especificado!');
}
?>

<?=template_header('Atualizar/Alterar Funcionário')?>

<div class="content update">
    <h2><i class="fas fa-edit"></i> Atualizar Funcionário <?=htmlspecialchars($funcionario['nome'])?></h2>
    <form action="workersUpdate.php?id=<?=$funcionario['id_funcionario']?>" method="post">
        <label for="id_funcionario">ID do Funcionário</label>
        <input type="text" name="id" placeholder="" value="<?=$funcionario['id_funcionario']?>" id="id_funcionario" readonly>
        
        <label for="nome">Nome</label>
        <input type="text" name="nome" placeholder="Nome do Funcionário" value="<?=$funcionario['nome']?>" id="nome">
        
        <label for="cargo">Cargo</label>
        <input type="text" name="cargo" placeholder="Cargo do Funcionário" value="<?=$funcionario['cargo']?>" id="cargo">
        
        <label for="status">Status</label>
        <select name="status" id="status" required>
            <option value="Ativo" <?=($funcionario['status'] == 'Ativo') ? 'selected' : ''?>>Ativo</option>
            <option value="Inativo" <?=($funcionario['status'] == 'Inativo') ? 'selected' : ''?>>Inativo</option>
        </select>

        <input type="submit" value="Atualizar">
    </form>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php endif; ?>
</div>

<?=template_footer()?>
