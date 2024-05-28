<?php
include 'functions.php';

// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();

// Obter a página via solicitação GET (parâmetro URL: page), se não existir, defina a página como 1 por padrão
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;

// Número de registros para mostrar em cada página
$records_per_page = 5;

// Inicializar a variável de pesquisa
$search = isset($_GET['search']) ? $_GET['search'] : '';

// Preparar a parte principal da consulta SQL sem a cláusula WHERE
$sql = 'SELECT contatos.*, status_pizzas.status_producao, status_pizzas.status_entrega 
        FROM contatos 
        LEFT JOIN status_pizzas ON contatos.id_contato = status_pizzas.id_contato ';

// Adicionar a cláusula WHERE se a pesquisa estiver presente
if (!empty($search)) {
    // Usar ILIKE para busca de texto insensível a maiúsculas e minúsculas
    $sql .= 'WHERE lower(contatos.nome) LIKE lower(:search) ';
}

// Adicionar a cláusula ORDER BY, OFFSET e LIMIT
$sql .= 'ORDER BY contatos.id_contato 
         OFFSET :offset 
         LIMIT :limit';

// Preparar e executar a consulta SQL
$stmt = $pdo->prepare($sql);

// Adicionar o parâmetro de pesquisa, se necessário
if (!empty($search)) {
    $stmt->bindValue(':search', '%' . $search . '%', PDO::PARAM_STR);
}

$stmt->bindValue(':offset', ($page - 1) * $records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':limit', $records_per_page, PDO::PARAM_INT);
$stmt->execute();

// Buscar os registros para exibi-los em nosso modelo.
$contacts = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Obter o número total de contatos, isso é para determinar se deve haver um botão de próxima e anterior
if (!empty($search)) {
    $stmt_count = $pdo->prepare('SELECT COUNT(*) FROM contatos WHERE lower(nome) LIKE lower(:search)');
    $stmt_count->bindValue(':search', '%' . $search . '%', PDO::PARAM_STR);
} else {
    $stmt_count = $pdo->query('SELECT COUNT(*) FROM contatos');
}

$num_contacts = $stmt_count->fetchColumn();
?>


<?=template_header('Visualizar Pedidos')?>

<div class="content read">
    <h2>Visualizar Pedidos</h2>
    <a href="create.php" class="create-contact"><i class="fas fa-cart-plus"></i> Realizar Pedido</a>

    <!-- Formulário de pesquisa -->
    <form action="" method="get">
        <input type="text" name="search" placeholder="Pesquisar por nome..." value="<?=htmlspecialchars($search, ENT_QUOTES)?>">
        <button type="submit"><i class="fas fa-search"></i></button>
    </form>

    <table>
        <thead>
            <tr>
                <td><i class="fas fa-id-badge"></i> ID</td>
                <td><i class="fas fa-user"></i> Nome</td>
                <td><i class="fas fa-cogs"></i> Status Produção</td>
                <td><i class="fas fa-cogs"></i> Status Entrega</td>
                <td><i class="far fa-calendar-alt"></i> Data do Pedido</td>
                <td><i class="fas fa-cogs"></i> Ações</td>
            </tr>
        </thead>
        <tbody>
        <?php foreach ($contacts as $contact): ?>
<tr>
    <td><?=$contact['id_contato']?></td>
    <td><?=$contact['nome']?></td>
    <td><?=$contact['status_producao']?></td>
    <td><?=$contact['status_entrega']?></td>
    <td><?=$contact['cadastro']?></td>
    <td class="actions">
        <a href="update.php?id=<?=$contact['id_contato']?>" class="edit"><i class="fas fa-edit fa-xs"></i></a>
        <a href="delete.php?id=<?=$contact['id_contato']?>" class="trash"><i class="fas fa-trash fa-xs"></i></a>
    </td>
</tr>
<?php endforeach; ?>

        </tbody>
    </table>
    <div class="pagination">
        <?php if ($page > 1): ?>
        <a href="status.php?page=<?=$page-1?>&search=<?=$search?>"><i class="fas fa-angle-double-left fa-sm"></i></a>
        <?php endif; ?>
        <?php if ($page*$records_per_page < $num_contacts): ?>
        <a href="status.php?page=<?=$page+1?>&search=<?=$search?>"><i class="fas fa-angle-double-right fa-sm"></i></a>
        <?php endif; ?>
    </div>
</div>

<?=template_footer()?>
