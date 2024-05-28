<?php
// Incluir o arquivo de funções
include 'functions.php';

// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();

// Função para listar todos os pedidos com detalhes do cliente
function listAllOrdersWithClientDetails($pdo) {
    $sql = '
        SELECT pedido.id_pedido, contatos.nome AS nome_contato, contatos.email, contatos.cell
        FROM pedido
        INNER JOIN contatos ON pedido.id_contato = contatos.id_contato
    ';
    $stmt = $pdo->query($sql);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Função para listar todos os itens de pedidos com detalhes da pizza
function listAllOrderItemsWithPizzaDetails($pdo) {
    $sql = '
        SELECT pedido.id_pedido, pizzas.nome AS nome_pizza, pizzas.tamanho, pizzas.preco, pizzas.ingredientes
        FROM pedido
        INNER JOIN pizzas ON pedido.id_pizza = pizzas.id_pizza
    ';
    $stmt = $pdo->query($sql);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Função para listar todos os funcionários com suas respectivas atribuições
function listAllEmployeesWithRoles($pdo) {
    $sql = '
        SELECT funcionarios.nome AS nome_funcionario, funcionarios.cargo
        FROM funcionarios
    ';
    $stmt = $pdo->query($sql);
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

// Exibir a tabela de pedidos com detalhes do cliente
$ordersWithClientDetails = listAllOrdersWithClientDetails($pdo);

// Exibir a tabela de itens de pedidos com detalhes da pizza
$orderItemsWithPizzaDetails = listAllOrderItemsWithPizzaDetails($pdo);

// Exibir a tabela de funcionários com suas respectivas atribuições
$employeesWithRoles = listAllEmployeesWithRoles($pdo);
?>

<!-- Exibir cabeçalho da página -->
<?=template_header('Detalhes dos Pedidos')?>

<div class="content read">
    <h2>Listagem de Pedidos com Detalhes do Cliente</h2>
    <table>
        <!-- cabeçalho da tabela -->
        <thead>
            <tr>
                <td>ID Pedido</td>
                <td>Nome Contato</td>
                <td>Email</td>
                <td>Celular</td>
            </tr>
        </thead>
        <!-- corpo da tabela -->
        <tbody>
            <?php foreach ($ordersWithClientDetails as $order): ?>
                <tr>
                    <td><?= $order['id_pedido'] ?></td>
                    <td><?= $order['nome_contato'] ?></td>
                    <td><?= $order['email'] ?></td>
                    <td><?= $order['cell'] ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<div class="content read">
    <h2>Listagem de Itens de Pedidos com Detalhes da Pizza</h2>
    <table>
        <!-- cabeçalho da tabela -->
        <thead>
            <tr>
                <td>ID Pedido</td>
                <td>Nome Pizza</td>
                <td>Tamanho</td>
                <td>Preço</td>
                <td>Ingredientes</td> <!-- Adicionando a coluna para os ingredientes -->
            </tr>
        </thead>
        <!-- corpo da tabela -->
        <tbody>
            <?php foreach ($orderItemsWithPizzaDetails as $item): ?>
                <tr>
                    <td><?= $item['id_pedido'] ?></td>
                    <td><?= $item['nome_pizza'] ?></td>
                    <td><?= $item['tamanho'] ?></td>
                    <td><?= $item['preco'] ?></td>
                    <td><?= $item['ingredientes'] ?></td> <!-- Exibindo os ingredientes -->
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<div class="content read">
    <h2>Listagem de Funcionários com suas Respectivas Atribuições</h2>
    <table>
        <!-- cabeçalho da tabela -->
        <thead>
            <tr>
                <td>Nome Funcionário</td>
                <td>Cargo</td>
            </tr>
        </thead>
        <!-- corpo da tabela -->
        <tbody>
            <?php foreach ($employeesWithRoles as $employee): ?>
                <tr>
                    <td><?= $employee['nome_funcionario'] ?></td>
                    <td><?= $employee['cargo'] ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
</div>

<?=template_footer()?>
