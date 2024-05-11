<?php
include 'functions.php';

// Conectar ao banco de dados PostgreSQL
$pdo = pdo_connect_pgsql();

// Obter a página via solicitação GET (parâmetro URL: page), se não existir, defina a página como 1 por padrão
$page = isset($_GET['page']) && is_numeric($_GET['page']) ? (int)$_GET['page'] : 1;

// Número de registros para mostrar em cada página
$records_per_page = 5;

// Preparar a instrução SQL para obter os dados da tabela contatos juntamente com os dados de status da tabela status_pizzas
$stmt = $pdo->prepare('SELECT contatos.*, status_pizzas.status_producao, status_pizzas.status_entrega 
                       FROM contatos 
                       LEFT JOIN status_pizzas ON contatos.id_contato = status_pizzas.id_contato 
                       ORDER BY contatos.id_contato 
                       OFFSET :offset 
                       LIMIT :limit');

$stmt->bindValue(':offset', ($page - 1) * $records_per_page, PDO::PARAM_INT);
$stmt->bindValue(':limit', $records_per_page, PDO::PARAM_INT);
$stmt->execute();

// Buscar os registros para exibi-los em nosso modelo.
$contacts = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Obter o número total de contatos, isso é para determinar se deve haver um botão de próxima e anterior
$num_contacts = $pdo->query('SELECT COUNT(*) FROM contatos')->fetchColumn();
?>

<?=template_header('Visualizar Pedidos')?>

<div class="content read">
    <h2>Visualizar Pedidos</h2>
    <a href="create.php" class="create-contact"><i class="fas fa-cart-plus"></i> Realizar Pedido</a>
    <table>
        <thead>
            <tr>
                <td><i class="fas fa-id-badge"></i> ID</td>
                <td><i class="fas fa-user"></i> Nome</td>
                <td><i class="far fa-envelope"></i> Email</td>
                <td><i class="fas fa-mobile-alt"></i> Celular</td>
                <td><i class="fas fa-pizza-slice"></i> Pizza</td>
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
                <td><?=$contact['email']?></td>
                <td><?=$contact['cell']?></td>
                <td><?=$contact['pizza']?></td>
                <td>
                    <select
                        class="update-pedido 
                   <?php echo ($contact['status_producao'] == 'Concluído') ? 'concluido' : (($contact['status_producao'] == 'Produzindo' || $contact['status_producao'] == 'Entregando') ? 'em-andamento' : ''); ?>"
                        onchange="updateStatus('producao', <?=$contact['id_contato']?>, this.value);">
                        <option value="" <?php echo (empty($contact['status_producao'])) ? 'selected' : ''; ?>>Alterar
                        </option>
                        <option value="Produzindo"
                            <?php echo ($contact['status_producao'] == 'Produzindo') ? 'selected' : ''; ?>>Produzindo
                        </option>
                        <option value="Entregando"
                            <?php echo ($contact['status_producao'] == 'Entregando') ? 'selected' : ''; ?>>Entregando
                        </option>
                        <option value="Concluído"
                            <?php echo ($contact['status_producao'] == 'Concluído') ? 'selected' : ''; ?>>Concluído
                        </option>
                    </select>
                </td>
                <td>
                    <select
                        class="update-pedido 
                   <?php echo ($contact['status_entrega'] == 'Concluído') ? 'concluido' : (($contact['status_entrega'] == 'Esperando') ? '' : 'em-andamento'); ?>"
                        onchange="updateStatus('entrega', <?=$contact['id_contato']?>, this.value);">
                        <option value="" <?php echo (empty($contact['status_entrega'])) ? 'selected' : ''; ?>>Alterar
                        </option>
                        <option value="Esperando"
                            <?php echo ($contact['status_entrega'] == 'Esperando') ? 'selected' : ''; ?>>Esperando
                        </option>
                        <option value="Em andamento"
                            <?php echo ($contact['status_entrega'] == 'Em andamento') ? 'selected' : ''; ?>>Em andamento
                        </option>
                        <option value="Concluído"
                            <?php echo ($contact['status_entrega'] == 'Concluído') ? 'selected' : ''; ?>>Concluído
                        </option>
                    </select>
                </td>


                <td><?=$contact['cadastro']?></td>
                <td class="actions">
                    <a href="update.php?id=<?=$contact['id_contato']?>" class="edit"><i
                            class="fas fa-edit fa-xs"></i></a>
                    <a href="delete.php?id=<?=$contact['id_contato']?>" class="trash"><i
                            class="fas fa-trash fa-xs"></i></a>
                </td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    <div class="pagination">
        <?php if ($page > 1): ?>
        <a href="read.php?page=<?=$page-1?>"><i class="fas fa-angle-double-left fa-sm"></i></a>
        <?php endif; ?>
        <?php if ($page*$records_per_page < $num_contacts): ?>
        <a href="read.php?page=<?=$page+1?>"><i class="fas fa-angle-double-right fa-sm"></i></a>
        <?php endif; ?>
    </div>
</div>

<?=template_footer()?>