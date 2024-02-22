<?php
require_once 'conectaBD.php';
require_once 'anuncio_tabela.php';

session_start();
if (empty($_SESSION)) {
    // Significa que as variáveis de SESSAO não foram definidas.
    // Não pode acessar aqui. o sistema manda voltar para a pagina de login
    header("Location: index.php?msgErro=Você precisa se autenticar no sistema.");
    die();
}
?>
<style>
    body a,
    .container a {
        font-family: "Maven Pro", sans-serif;
        font-optical-sizing: auto;
        /* font-weight: <weight>; */
        font-style: normal;
    }

    .card {
        margin-top: 10px;
    }

    .header {
        background-color: #f8f9fa;
        padding: 10px 0;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .header .container {
        display: flex;
        padding: 5px;
        gap: 10px;
        align-items: center;
    }

    .header h2.title {
        margin: 0;
        font-size: 24px;
        color: #333;

    }
</style>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="utf-8">
    <title>Página Inicial - Ambiente Logado</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-
+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Maven+Pro:wght@400..900&display=swap" rel="stylesheet">
</head>

<?php
$anuncios = array();
if (!empty($_GET['meus_anuncios']) && $_GET['meus_anuncios'] == 1) {
    // Obter somente os anúncios cadastrados pelo(a) usuário(a) logado(a).
    $sql = "SELECT * FROM anuncio WHERE email_usuario = :email ORDER BY id ASC";
    $dados = array(':email' => $_SESSION['email']);
    try {
        $stmt = $pdo->prepare($sql);
        if ($stmt->execute($dados)) {
            // Execução da SQL Ok!!
            $anuncios = $stmt->fetchAll();
        } else {
            die("Falha ao executar a SQL.. #1");
        }
    } catch (PDOException $e) {
        die($e->getMessage());
    }
} else {
    $sql = "SELECT * FROM anuncio ORDER BY id ASC";
    try {
        $stmt = $pdo->prepare($sql);
        if ($stmt->execute()) {
            // Execução da SQL Ok!!
            $anuncios = $stmt->fetchAll();
        } else {
            die("Falha ao executar a SQL.. #2");
        }
    } catch (PDOException $e) {
        die($e->getMessage());
    }
}
?>

<body>
    <div class="container">
        <?php if (!empty($_GET['msgErro'])) { ?>
            <div class="alert alert-warning" role="alert">
                <?php echo $_GET['msgErro']; ?>
            </div>
        <?php } ?>
        <?php if (!empty($_GET['msgSucesso'])) { ?>
            <div class="alert alert-success" role="alert">
                <?php echo $_GET['msgSucesso']; ?>
            </div>
        <?php } ?>
    </div>
    <div class="header">
        <div class="container">
            <div class="col-md-11">

                <h2 class="title">Olá <i>
                        <?php echo ucfirst($_SESSION['nome']); ?>
                    </i>, seja bem-vindo(a) ao Cão Velho!</h2>
            </div>
        </div>
        <div class="container">
            <a href="cad_anuncio.php" class="btn btn-primary">Novo Anúncio</a>
            <a href="index_logado.php?meus_anuncios=1" class="btn btn-success">Meus Anúncios</a>
            <a href="index_logado.php?meus_anuncios=0" class="btn btn-info">Todos Anúncios</a>
            <a href="logout.php" class="btn btn-dark">Sair</a>
        </div>
    </div>

    <?php if (!empty($anuncios)) { ?>
        <!-- Relação de anúncios!! -->
        <div class="container">
            <table class="table table-striped">
                <tbody>
                    <?php foreach ($anuncios as $a) { ?>
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title">Animal</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-4">
                                        <?php
                                        // Verifica se há um caminho de imagem no registro atual
                                        if (!empty($a['imagem'])) {
                                            // Se houver, mostra a imagem do banco de dados
                                            echo '<img src="' . $a['imagem'] . '" alt="Foto" class="img-fluid">';
                                        } else {
                                            // Se não houver, mostra a imagem padrão
                                            echo '<img src="img/caoveio.png" alt="Foto Padrão" class="img-fluid">';
                                        }
                                        ?>
                                    </div>
                                    <div class="col-md-8">
                                        <ul class="list-unstyled">
                                            <li>ID:
                                                <?php echo $a['id']; ?>
                                            </li>
                                            <li>
                                                <?php echo $a['tipo'] == 'G' ? "Gato" : "Cachorro"; ?>
                                            </li>
                                            <li>Raça:
                                                <?php echo $a['raca']; ?>
                                            </li>
                                            <li>Pelagem/Cor:
                                                <?php echo $a['pelagem_cor']; ?>
                                            </li>
                                            <li>Fase:
                                                <?php echo $a['fase'] == 'A' ? "Adulto" : "Filhote"; ?>
                                            </li>
                                            <li>Sexo:
                                                <?php echo $a['sexo'] == 'M' ? "Macho" : "Fêmea"; ?>
                                            </li>
                                            <li>Observação:
                                                <?php echo $a['observacao']; ?>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <?php if ($a['email_usuario'] == $_SESSION['email']) { ?>
                                <div class="card-footer">
                                    <a href="alt_anuncio.php?id_anuncio=<?php echo $a['id']; ?>" class="btn btn-warning">Alterar</a>
                                    <a href="del_anuncio.php?id_anuncio=<?php echo $a['id']; ?>" class="btn btn-danger">Excluir</a>
                                </div>
                            <?php } ?>
                        </div>

                    <?php } ?>
                </tbody>
            </table>
        </div>
    <?php } ?>
</body>

</html>