<?php
include 'functions.php';
// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();
// Obter a página via solicitação GET (parâmetro URL: page), se não existir, defina a página como 1 por padrão
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
// Número de registros para mostrar em cada página
$records_per_page = 5;

// Preparar a instrução SQL e obter registros da tabela funcionarios, LIMIT irá determinar a página
$stmt = $pdo->prepare('SELECT * FROM funcionarios ORDER BY id_funcionario OFFSET :offset LIMIT :limit');
$stmt->bindValue(':offset', ($page - 1) * $records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':limit', $records_per_page, PDO::PARAM_INT);
$stmt->execute();
// Buscar os registros para exibi-los em nosso modelo.
$funcionarios = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Obter o número total de funcionarios, isso é para determinar se deve haver um botão de próxima e anterior
$num_funcionarios = $pdo->query('SELECT COUNT(*) FROM funcionarios')->fetchColumn();
?>


<?=template_header('Visualizar Funcionários')?>

<div class="content read">
    <h2>Visualizar Funcionários</h2>
    <a href="create.php" class="create-contact"><i class="fas fa-plus"></i> Adicionar Funcionário</a>
    <table>
        <thead>
            <tr>
                <td><i class="fas fa-id-badge"></i> ID</td>
                <td><i class="fas fa-user"></i> Nome</td>
                <td><i class="fas fa-briefcase"></i> Cargo</td>
                <td><i class="fas fa-toggle-on"></i> Status</td>
                <td><i class="fas fa-cogs"></i> Ações</td>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($funcionarios as $funcionario): ?>
            <tr>
                <td><?=$funcionario['id_funcionario']?></td>
                <td><?=$funcionario['nome']?></td>
                <td><?=$funcionario['cargo']?></td>
                <td><?=$funcionario['status']?></td>
                <td class="actions">
                    <a href="update.php?id=<?=$funcionario['id_funcionario']?>" class="edit"><i
                            class="fas fa-edit fa-xs"></i></a>
                    <a href="delete.php?id=<?=$funcionario['id_funcionario']?>" class="trash"><i
                            class="fas fa-trash fa-xs"></i></a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <div class="pagination">
        <?php if ($page > 1): ?>
        <a href="workers.php?page=<?=$page-1?>"><i class="fas fa-angle-double-left fa-sm"></i></a>
        <?php endif; ?>
        <?php if ($page*$records_per_page < $num_funcionarios): ?>
        <a href="workers.php?page=<?=$page+1?>"><i class="fas fa-angle-double-right fa-sm"></i></a>
        <?php endif; ?>
    </div>
</div>

<?=template_footer()?>
