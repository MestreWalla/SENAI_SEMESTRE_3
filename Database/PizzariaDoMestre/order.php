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

// Inicializar as variáveis de data
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : null;
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : null;

// Preparar a instrução SQL para obter os registros de pedidos com todos os detalhes
$sql = '
    SELECT p.id_pedido, c.nome AS nome_contato, c.email, c.cell, pi.nome AS nome_pizza, pi.tamanho, pi.preco, 
           e.nome AS nome_entrega, e.entrega, p.data_pedido
    FROM pedido p
    JOIN contatos c ON p.id_contato = c.id_contato
    JOIN pizzas pi ON p.id_pizza = pi.id_pizza
    JOIN entregas e ON p.id_entregas = e.id_entregas
';

// Adicionar a cláusula WHERE se a pesquisa estiver presente
if (!empty($search)) {
    // Adicionar a condição de pesquisa
    $sql .= ' WHERE lower(c.nome) LIKE lower(:search)
              OR lower(c.email) LIKE lower(:search)
              OR lower(c.cell) LIKE lower(:search)
              OR lower(pi.nome) LIKE lower(:search)
              OR lower(pi.tamanho) LIKE lower(:search)
              OR lower(e.nome) LIKE lower(:search)
    ';
}

// Adicionar a cláusula WHERE para o intervalo de datas, se necessário
// Executar a consulta SQL
if (!empty($search) || (!empty($start_date) && !empty($end_date))) {
    $stmt_count->execute();
    $num_pedidos = $stmt_count->fetchColumn();
} else {
    // Contar o número total de registros
    $num_pedidos = $pdo->query('SELECT COUNT(*) FROM pedido')->fetchColumn();
}


// Adicionar a cláusula ORDER BY, OFFSET e LIMIT
$sql .= ' ORDER BY p.id_pedido
          OFFSET :offset 
          LIMIT :limit';

// Preparar e executar a consulta SQL
$stmt = $pdo->prepare($sql);

// Adicionar o parâmetro de pesquisa, se necessário
if (!empty($search)) {
    $stmt->bindValue(':search', '%' . $search . '%', PDO::PARAM_STR);
}

// Adicionar os parâmetros de data, se necessário
if (!empty($start_date) && !empty($end_date)) {
    $stmt->bindValue(':start_date', $start_date, PDO::PARAM_STR);
    $stmt->bindValue(':end_date', $end_date, PDO::PARAM_STR);
}

$stmt->bindValue(':offset', ($page - 1) * $records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':limit', $records_per_page, PDO::PARAM_INT);
$stmt->execute();

// Buscar os registros para exibi-los em nosso modelo.
$pedidos = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Obter o número total de pedidos para a paginação
if (!empty($search) || (!empty($start_date) && !empty($end_date))) {
    // Contar o número de registros filtrados pela pesquisa ou intervalo de datas
    $stmt_count = $pdo->prepare('
        SELECT COUNT(*) 
        FROM pedido p
        JOIN contatos c ON p.id_contato = c.id_contato
        JOIN pizzas pi ON p.id_pizza = pi.id_pizza
        JOIN entregas e ON p.id_entregas = e.id_entregas
        WHERE lower(c.nome) LIKE lower(:search)
              OR lower(c.email) LIKE lower(:search)
              OR lower(c.cell) LIKE lower(:search)
              OR lower(pi.nome) LIKE lower(:search)
              OR lower(pi.tamanho) LIKE lower(:search)
              OR lower(e.nome) LIKE lower(:search)
        AND p.data_pedido BETWEEN :start_date AND :end_date
    ');
    if (!empty($search)) {
        $stmt_count->bindValue(':search', '%' . $search . '%', PDO::PARAM_STR);
    }
    if (!empty($start_date) && !empty($end_date)) {
        $stmt_count->bindValue(':start_date', $start_date, PDO::PARAM_STR);
        $stmt_count->bindValue(':end_date', $end_date, PDO::PARAM_STR);
    }
    // Verificação para debug
    var_dump($search);
    var_dump($start_date);
    var_dump($end_date);

    // Executar a consulta SQL
    $stmt_count->execute();

    $num_pedidos = $stmt_count->fetchColumn();
} else {
    // Contar o número total de registros
    $num_pedidos = $pdo->query('SELECT COUNT(*) FROM pedido')->fetchColumn();
}
?>

<?=template_header('Detalhes dos Pedidos')?>

<div class="content read">
    <h2>Detalhes dos Pedidos</h2>

    <!-- Formulário de pesquisa -->
    <form action="order.php" method="get">
        <input type="text" name="search" placeholder="Buscar..." value="<?=$search?>">
        <button type="submit"><i class="fas fa-search"></i></button>
    </form>
    <form action="order.php" method="get">
        <label for="start_date">Data Inicial:</label>
        <input type="date" id="start_date" name="start_date"
            value="<?= isset($_GET['start_date']) ? $_GET['start_date'] : '' ?>">
        <label for="end_date">Data Final:</label>
        <input type="date" id="end_date" name="end_date"
            value="<?= isset($_GET['end_date']) ? $_GET['end_date'] : '' ?>">
        <button type="submit"><i class="fas fa-search"></i> Buscar</button>
    </form>


    <a href="orderCreate.php" class="create-contact"><i class="fas fa-cart-plus"></i> Realizar Pedido</a>
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
                    <a href="orderUpdate.php?id=<?=$pedido['id_pedido']?>" class="edit"><i
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
        <a href="order.php?page=<?=$page-1?>&search=<?=$search?>&start_date=<?=$start_date?>&end_date=<?=$end_date?>"><i
                class="fas fa-angle-double-left fa-sm"></i></a>
        <?php endif; ?>
        <?php if ($page * $records_per_page < $num_pedidos): ?>
        <a href="order.php?page=<?=$page+1?>&search=<?=$search?>&start_date=<?=$start_date?>&end_date=<?=$end_date?>"><i
                class="fas fa-angle-double-right fa-sm"></i></a>
        <?php endif; ?>
    </div>
</div>

<?=template_footer()?>