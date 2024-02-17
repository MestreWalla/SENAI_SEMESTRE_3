<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Cadastrar Novo Usuário</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            max-width: 400px;
            margin-top: 50px;
        }

        .logo {
            height: 200px;
            width: 200px;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-control {
            margin-bottom: 20px;
        }

        .btn-primary {
            width: 100%;
        }

        .btn-danger {
            width: 100%;
        }

        .botoes {
            display: flex;
            gap: 15px;
            margin-bottom: 50px;
        }
    </style>
</head>

<body>
    <div class="container">
        <img src="img/caoveio.png" alt="" class="logo mx-auto d-block">
        <h1>Cadastrar Novo Usuário</h1>
        <form action="processa_usuario.php" method="post">
            <div class="mb-3">
                <label for="nome" class="form-label">Nome Completo</label>
                <input type="text" name="nome" id="nome" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="dataNascimento" class="form-label">Data de Nascimento</label>
                <input type="date" name="dataNascimento" id="dataNascimento" class="form-control" value="1980-01-01"
                    required>
            </div>
            <div class="mb-3">
                <label for="telefone" class="form-label">Telefone para Contato</label>
                <input type="tel" name="telefone" id="telefone" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">E-mail</label>
                <input type="email" name="email" id="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="senha" class="form-label">Senha</label>
                <input type="password" name="senha" id="senha" class="form-control" required>
            </div>
            <div class="botoes">
                <button type="submit" name="enviarDados" class="btn btn-primary">Cadastrar</button>
                <a href="index.php" class="btn btn-danger">Cancelar</a>
            </div>
        </form>
    </div>
</body>

</html>