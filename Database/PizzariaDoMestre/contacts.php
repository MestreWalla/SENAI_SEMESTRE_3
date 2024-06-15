<?php
include 'functions.php';

// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();

// Obter a página via solicitação GET (parâmetro URL: page), se não existir, defina a página como 1 por padrão
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;
// Número de registros para mostrar em cada página
$records_per_page = 5;

// Verificar se há um termo de pesquisa
$search = isset($_GET['search']) ? $_GET['search'] : '';

// Preparar a instrução SQL para obter registros da tabela contatos com filtragem e paginação
$sql = 'SELECT * FROM contatos ';
if ($search) {
    $sql .= 'WHERE nome LIKE :search OR email LIKE :search ';
}
$sql .= 'ORDER BY id_contato OFFSET :offset LIMIT :limit';

$stmt = $pdo->prepare($sql);

if ($search) {
    $stmt->bindValue(':search', '%' . $search . '%', PDO::PARAM_STR);
}
$stmt->bindValue(':offset', ($page - 1) * $records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':limit', $records_per_page, PDO::PARAM_INT);
$stmt->execute();

// Buscar os registros para exibi-los em nosso modelo.
$contacts = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Obter o número total de contatos para paginação
$sql = 'SELECT COUNT(*) FROM contatos';
if ($search) {
    $sql .= ' WHERE nome LIKE :search OR email LIKE :search';
}
$count_stmt = $pdo->prepare($sql);
if ($search) {
    $count_stmt->bindValue(':search', '%' . $search . '%', PDO::PARAM_STR);
}
$count_stmt->execute();
$num_contacts = $count_stmt->fetchColumn();
?>

<?=template_header('Visualizar Contatos')?>

<div class="content read">
    <h2>Visualizar Pedidos</h2>
    <a href="orderCreate.php" class="create-contact"><i class="fas fa-cart-plus"></i> Realizar Pedido</a>
    <form action="contacts.php" method="get">
        <input type="text" name="search" placeholder="Pesquisar contatos" value="<?=htmlspecialchars($search)?>">
        <button type="submit"><i class="fas fa-search"></i></button>
    </form>
    
    <table>
        <thead>
            <tr>
                <td><i class="fas fa-id-badge"></i> ID</td>
                <td><i class="fas fa-user"></i> Nome</td>
                <td><i class="far fa-envelope"></i> Email</td>
                <td><i class="fas fa-mobile-alt"></i> Celular</td>
                <td><i class="far fa-calendar-alt"></i> Data do Pedido</td>
                <td><i class="fas fa-cogs"></i> Ações</td>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($contacts as $contact): ?>
            <tr>
                <td><?=$contact['id_contato']?></td>
                <td><?=$contact['nome']?></td>
                <td><?=$contact['email']?></td>
                <td><?=$contact['cell']?></td>
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
        <a href="contacts.php?page=<?=$page-1?>"><i class="fas fa-angle-double-left fa-sm"></i></a>
        <?php endif; ?>
        <?php if ($page*$records_per_page < $num_contacts): ?>
        <a href="contacts.php?page=<?=$page+1?>"><i class="fas fa-angle-double-right fa-sm"></i></a>
        <?php endif; ?>
    </div>
</div>

<?=template_footer()?>
