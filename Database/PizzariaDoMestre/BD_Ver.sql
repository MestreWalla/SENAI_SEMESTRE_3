-- Listar todos os pedidos com detalhes do cliente:
SELECT pedido.id_pedido, contatos.nome AS nome_cliente, contatos.email AS email_cliente, contatos.cell AS celular_cliente
FROM pedido
INNER JOIN contatos ON pedido.id_contato = contatos.id_contato;

-- Listar todos os itens de pedidos com detalhes da pizza:
SELECT pedido.id_pedido, pizzas.nome AS nome_pizza, pizzas.tamanho, pizzas.preco
FROM pedido
INNER JOIN pizzas ON pedido.id_pizza = pizzas.id_pizza;

-- Listar todos os funcionários com suas respectivas atribuições:
SELECT funcionarios.nome AS nome_funcionario, funcionarios.cargo
FROM funcionarios;

-- Listar todos os pedidos com status e funcionários responsáveis:
SELECT p.id_pedido, e.entrega, sp.status_producao, sp.status_entrega, f.nome AS nome_funcionario
FROM pedido p
INNER JOIN entregas e ON p.id_entregas = e.ID_ENTREGAS
INNER JOIN status_pizzas sp ON p.id_contato = sp.id_contato
INNER JOIN funcionarios f ON p.id_funcionario = f.id_funcionario;

-- Listar todos os clientes com seus pedidos realizados:
SELECT c.nome AS nome_cliente, p.id_pedido, pi.nome AS nome_pizza, b.nome AS nome_bebida
FROM contatos c
INNER JOIN pedido p ON c.id_contato = p.id_contato
LEFT JOIN pizzas pi ON p.id_pizza = pi.id_pizza
LEFT JOIN bebidas b ON p.id_bebidas = b.id_bebidas;

-- Listar todas as pizzas disponíveis com seus respectivos ingredientes:
SELECT pizzas.nome AS nome_pizza, pizzas.ingredientes
FROM pizzas
WHERE pizzas.status = 'Disponivel';

-- Listar todos os pedidos com detalhes de entrega:
SELECT pedido.id_pedido, entregas.nome AS nome_cliente, entregas.email, entregas.cel AS celular, entregas.pizza, entregas.ENTREGA
FROM pedido
INNER JOIN entregas ON pedido.id_entregas = entregas.ID_ENTREGAS;

-- >>>>>>>>>>>>>>>>> IMPLEMENTAR Listar todos os funcionários com seus respectivos supervisores:

-- Listar todos os itens de pedidos com seus respectivos tamanhos:
SELECT p.id_pedido, pi.tamanho AS tamanho_pizza, pi.nome AS nome_pizza, b.nome AS nome_bebida
FROM pedido p
LEFT JOIN pizzas pi ON p.id_pizza = pi.id_pizza
LEFT JOIN bebidas b ON p.id_bebidas = b.id_bebidas;

-- >>>>>>>>>>>>>>>>> EM ANDAMENTO Listar todas as pizzas com suas respectivas promoções:
SELECT pizzas.nome AS nome_pizza, promocoes.descricao
FROM pizzas
LEFT JOIN promocoes ON pizzas.id_promocao = promocoes.id_promocao;

-- PARTE 2

-- Listar todos os clientes cadastrados:
SELECT *
FROM contatos;

-- Listar todos os pedidos realizados em um determinado período:
SELECT *
FROM pedido
WHERE data_pedido BETWEEN '2024-01-01' AND '2024-12-31';

-- Listar os itens de um pedido específico:
SELECT *
FROM pedido
WHERE id_pedido = 5;

-- Calcular o total gasto por um cliente:
SELECT contatos.nome AS nome_cliente, SUM(pizzas.preco) AS total_gasto
FROM contatos
INNER JOIN pedido ON contatos.id_contato = pedido.id_contato
INNER JOIN pizzas ON pedido.id_pizza = pizzas.id_pizza
GROUP BY contatos.nome;

-- Listar os sabores de pizza mais populares:
SELECT pizzas.nome AS sabor_pizza, COUNT(*) AS total_pedidos
FROM pedido
INNER JOIN pizzas ON pedido.id_pizza = pizzas.id_pizza
GROUP BY pizzas.nome
ORDER BY COUNT(*) DESC;

-- Verificar a disponibilidade de um determinado sabor de pizza:
SELECT *
FROM pizzas
WHERE nome = 'Quatro Queijos' AND status = 'Disponivel';

-- Listar todos os funcionários:
SELECT *
FROM funcionarios;

-- Verificar o horário de funcionamento da pizzaria:
SELECT *
FROM horario_funcionamento;

-- Listar os pedidos em andamento:
SELECT c.nome AS nome_cliente, sp.status_producao, sp.status_entrega
FROM status_pizzas sp
INNER JOIN contatos c ON sp.id_contato = c.id_contato
WHERE sp.status_producao = 'Em andamento' AND sp.status_entrega = 'Em andamento';

-- >>>>>>>>>>>>>>>>> ERRO - Calcular o tempo médio de espera dos pedidos:
SELECT AVG(EXTRACT(EPOCH FROM (e.CADASTRO - p.data_pedido))) AS tempo_medio_espera
FROM pedido p
INNER JOIN ENTREGAS e ON p.id_entregas = e.ID_ENTREGAS
WHERE p.status = 'Finalizado';