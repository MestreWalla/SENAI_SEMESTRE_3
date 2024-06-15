<?php
include 'functions.php';

// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();

// Inicializar variáveis
$msg = '';

// Verificar se o ID do funcionário foi fornecido via parâmetro GET
if (isset($_GET['id'])) {
    // Preparar e executar a consulta para selecionar o funcionário pelo ID
    $stmt = $pdo->prepare('SELECT * FROM funcionarios WHERE id_funcionario = ?');
    $stmt->execute([$_GET['id']]);
    $funcionario = $stmt->fetch(PDO::FETCH_ASSOC);

    // Verificar se o funcionário foi encontrado
    if (!$funcionario) {
        exit('Funcionário Não Localizado!');
    }

    // Verificar se houve confirmação de exclusão
    if (isset($_GET['confirm'])) {
        if ($_GET['confirm'] == 'yes') {
            // O usuário confirmou a exclusão, preparar e executar a consulta DELETE
            $stmt = $pdo->prepare('DELETE FROM funcionarios WHERE id_funcionario = ?');
            $stmt->execute([$_GET['id']]);
            $msg = 'Funcionário excluído com sucesso!';
        } else {
            // O usuário optou por não excluir, redirecionar de volta
            header('Location: workers.php');
            exit;
        }
    }
} else {
    exit('Nenhum ID de Funcionário especificado!');
}
?>

<?=template_header('Apagar Funcionário')?>

<div class="content delete">
    <h2>Apagar Funcionário - <?=htmlspecialchars($funcionario['nome'])?></h2>
    <?php if ($msg): ?>
        <p><?=$msg?></p>
    <?php else: ?>
        <p>Você tem certeza que deseja apagar o funcionário - <?=htmlspecialchars($funcionario['nome'])?>?</p>
        <div class="yesno">
            <a href="workerDelete.php?id=<?=$funcionario['id_funcionario']?>&confirm=yes">Sim</a>
            <a href="workers.php">Não</a>
        </div>
    <?php endif; ?>
</div>

<?=template_footer()?>
