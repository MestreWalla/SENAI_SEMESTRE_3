<?php
include 'functions.php';

// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();

// Obter a página via solicitação GET (parâmetro URL: page), se não existir, defina a página como 1 por padrão
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;

// Número de registros para mostrar em cada página
$records_per_page = 5;

// Preparar a instrução SQL para obter os registros de pedidos com todos os detalhes
$stmt = $pdo->prepare('
    SELECT p.id_pedido, c.nome AS nome_contato, c.email, c.cell, pi.nome AS nome_pizza, pi.tamanho, pi.preco, 
           e.nome AS nome_entrega, e.entrega, p.data_pedido
    FROM pedido p
    JOIN contatos c ON p.id_contato = c.id_contato
    JOIN pizzas pi ON p.id_pizza = pi.id_pizza
    JOIN entregas e ON p.id_entregas = e.id_entregas
    ORDER BY p.id_pedido
    OFFSET :offset LIMIT :limit
');

$stmt->bindValue(':offset', ($page - 1) * $records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':limit', $records_per_page, PDO::PARAM_INT);
$stmt->execute();

// Buscar os registros para exibi-los em nosso modelo.
$pedidos = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Obter o número total de pedidos para a paginação
$num_pedidos = $pdo->query('SELECT COUNT(*) FROM pedido')->fetchColumn();
?>

<?=template_header('Detalhes dos Pedidos')?>

<div class="content read">
    <h2>Detalhes dos Pedidos</h2>
    <a href="create.php" class="create-contact"><i class="fas fa-cart-plus"></i> Realizar Pedido</a>
    <table>
        <thead>
            <tr>
                <td><i class="fas fa-id-badge"></i> ID Pedido</td>
                <td><i class="fas fa-user"></i> Nome Contato</td>
                <td><i class="far fa-envelope"></i> Email</td>
                <td><i class="fas fa-mobile-alt"></i> Celular</td>
                <td><i class="fas fa-pizza-slice"></i> Pizza</td>
                <td><i class="fas fa-info-circle"></i> Tamanho</td>
                <td><i class="fas fa-dollar-sign"></i> Preço</td>
                <td><i class="fas fa-truck"></i> Status Entrega</td>
                <td><i class="far fa-calendar-alt"></i> Data do Pedido</td>
                <td><i class="fas fa-cogs"></i> Ações</td>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($pedidos as $pedido): ?>
            <tr>
                <td><?=$pedido['id_pedido']?></td>
                <td><?=$pedido['nome_contato']?></td>
                <td><?=$pedido['email']?></td>
                <td><?=$pedido['cell']?></td>
                <td><?=$pedido['nome_pizza']?></td>
                <td><?=$pedido['tamanho']?></td>
                <td><?=$pedido['preco']?></td>
                <td><?=$pedido['entrega']?></td>
                <td><?=$pedido['data_pedido']?></td>
                <td class="actions">
                    <a href="update.php?id=<?=$pedido['id_pedido']?>" class="edit"><i
                            class="fas fa-edit fa-xs"></i></a>
                    <a href="delete.php?id=<?=$pedido['id_pedido']?>" class="trash"><i
                            class="fas fa-trash fa-xs"></i></a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <div class="pagination">
        <?php if ($page > 1): ?>
        <a href="details.php?page=<?=$page-1?>"><i class="fas fa-angle-double-left fa-sm"></i></a>
        <?php endif; ?>
        <?php if ($page * $records_per_page < $num_pedidos): ?>
        <a href="details.php?page=<?=$page+1?>"><i class="fas fa-angle-double-right fa-sm"></i></a>
        <?php endif; ?>
    </div>
</div>

<?=template_footer()?>
