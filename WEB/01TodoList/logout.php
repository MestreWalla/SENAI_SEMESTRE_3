<?php
// Inicia a sessão
session_start();

// Finaliza a sessão (limpa todas as variáveis de sessão)
session_unset();

// Destrói a sessão
session_destroy();

// Redireciona o usuário de volta para a página de login ou outra página desejada
header("Location: login.php");
exit();