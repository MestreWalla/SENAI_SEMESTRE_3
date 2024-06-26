<?php
function pdo_connect_pgsql() {
    $DATABASE_HOST = 'localhost';
    $DATABASE_PORT = '5432';
    $DATABASE_USER = 'postgres';
    $DATABASE_PASS = 'postgres';
    $DATABASE_NAME = 'pizzaria';
    try {
        $pdo = new PDO('pgsql:host=' . $DATABASE_HOST . ';port=' . $DATABASE_PORT . ';dbname=' . $DATABASE_NAME . ';user=' . $DATABASE_USER . ';password=' . $DATABASE_PASS);
        // Define o modo de erro para Exception para que os erros sejam lançados e possam ser capturados.
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $pdo;
    } catch (PDOException $exception) {
        // Log do erro ou exibição de mensagem mais detalhada.
        $errorDetails = 'Error details: ' . $exception->getMessage() . ' Code: ' . $exception->getCode();
        error_log('Failed to connect to database: ' . $errorDetails);
        exit('Failed to connect to database. Check error log for details. Debug: ' . $errorDetails);
    }
}

function template_header($title) {
echo <<<EOT
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>$title</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.1/css/all.css">
	</head>
	<body>
    <nav class="navtop">
    	<div>
    		<h1> Pizzaria do Mestre </h1>
            <a href="index.php"><i class="fas fa-home"></i>Inicio</a>
            <a href="dashboard.php"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
    		<a href="contacts.php"><i class="fas fa-shopping-basket"></i>contatos</a>
            <a href="workers.php"><i class="fas fa-shopping-basket"></i>funcionarios</a>
            <a href="order.php"><i class="fas fa-shopping-basket"></i>pedidos</a>
            <a href="status.php"><i class="fas fa-list"></i> Status dos pedidos</a>
    	</div>
    </nav>
EOT;
}
function template_footer() {
    echo <<<EOT
    </div> <!-- fecha a div container -->
    <footer>
        <div class="container">
            <p>&copy; 2024 Pizzaria do Mestre. Todos os direitos reservados.</p>
            <p>Desenvolvido por: Maycon Correa</p>
        </div>
    </footer>
    </body>
    </html>
EOT;
}
?>