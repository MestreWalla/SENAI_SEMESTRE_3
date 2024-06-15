<?php
include 'functions.php';
$pdo = pdo_connect_pgsql();
$msg = '';

// Verifica se o ID do pedido existe, por exemplo, update_order.php?id=1 irá obter o pedido com o id 1
if (isset($_GET['id'])) {
    if (!empty($_POST)) {
        // Esta parte é semelhante ao create.php, mas aqui estamos atualizando um registro e não inserindo
        $id_pedido = isset($_POST['id']) ? $_POST['id'] : NULL;
        $sabor = isset($_POST['sabor']) ? $_POST['sabor'] : '';
        $tamanho = isset($_POST['tamanho']) ? $_POST['tamanho'] : '';
        $valor = isset($_POST['valor']) ? $_POST['valor'] : '';
        $status = isset($_POST['status']) ? $_POST['status'] : '';

        // Atualiza o registro
        $stmt = $pdo->prepare('UPDATE pedido SET sabor = ?, tamanho = ?, valor = ?, status = ? WHERE id_pedido = ?');
        $stmt->execute([$sabor, $tamanho, $valor, $status, $_GET['id']]);
        $msg = 'Atualização Realizada com Sucesso!';
    }

    // Obter o pedido da tabela pedido
    $stmt = $pdo->prepare('SELECT * FROM pedido WHERE id_pedido = ?');
    $stmt->execute([$_GET['id']]);
    $pedido = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$pedido) {
        exit('Pedido Não Localizado!');
    }
} else {
    exit('Nenhum Pedido Especificado!');
}
?>

<?=template_header('Atualizar/Alterar Pedido')?>

<div class="content update">
    <h2><i class="fas fa-edit"></i> Atualizar Pedido <?=$pedido['id_pedido']?></h2>
    <form action="update_order.php?id=<?=$pedido['id_pedido']?>" method="post">
        <label for="id_pedido">ID do Pedido</label>
        <input type="text" name="id" placeholder="" value="<?=$pedido['id_pedido']?>" id="id_pedido" readonly>
        <label for="sabor">Sabor</label>
        <input type="text" name="sabor" placeholder="Sabor da Pizza"
            value="<?=isset($pedido['sabor']) ? $pedido['sabor'] : ''?>" id="sabor">
        <label for="tamanho">Tamanho</label>
        <input type="text" name="tamanho" placeholder="Tamanho da Pizza"
            value="<?=isset($pedido['tamanho']) ? $pedido['tamanho'] : ''?>" id="tamanho">
        <label for="valor">Valor</label>
        <input type="text" name="valor" placeholder="Valor da Pizza"
            value="<?=isset($pedido['valor']) ? $pedido['valor'] : ''?>" id="valor">
        <label for="status">Status</label>
        <input type="text" name="status" placeholder="Status do Pedido"
            value="<?=isset($pedido['status']) ? $pedido['status'] : ''?>" id="status">

        <input type="submit" value="Atualizar">
    </form>
    <?php if ($msg): ?>
    <p><?=$msg?></p>
    <?php endif; ?>
</div>

<?=template_footer()?>