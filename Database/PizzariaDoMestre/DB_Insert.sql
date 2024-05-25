-- Inserindo dados fictícios na tabela contatos
INSERT INTO contatos (id_contato, nome, email, cell) VALUES
(1, 'João', 'joao@example.com', '123456789'),
(2, 'Maria', 'maria@example.com', '987654321'),
(3, 'Carlos', 'carlos@example.com', '456123789'),
(4, 'Ana', 'ana@example.com', '789456123'),
(5, 'Paula', 'paula@example.com', '321654987');

-- Inserindo dados fictícios na tabela status_pizzas
INSERT INTO status_pizzas (id_status, id_contato, status_producao, status_entrega) VALUES
(1, 1, 'Em produção', 'Em andamento'),
(2, 2, 'Em produção', 'Finalizada'),
(3, 3, 'Pronto', 'Em andamento'),
(4, 4, 'Pronto', 'Finalizada'),
(5, 5, 'Em produção', 'Em andamento');

-- Inserindo dados fictícios na tabela ENTREGAS
INSERT INTO ENTREGAS (ID_ENTREGAS, NOME, EMAIL, CEL, PIZZA, ENTREGA) VALUES
(1, 'João', 'joao@example.com', '123456789', 'Pizza de Calabresa', 'Finalizada'),
(2, 'Maria', 'maria@example.com', '987654321', 'Pizza de Frango', 'Finalizada'),
(3, 'Carlos', 'carlos@example.com', '456123789', 'Pizza de Marguerita', 'Em Andamento'),
(4, 'Ana', 'ana@example.com', '789456123', 'Pizza de Quatro Queijos', 'Em Andamento'),
(5, 'Paula', 'paula@example.com', '321654987', 'Pizza de Pepperoni', 'Finalizada');

-- Inserindo dados fictícios na tabela promocoes
INSERT INTO promocoes (id_promocao, nome, descricao, preco, data_inicio, data_fim) VALUES
(1, 'Promoção de Verão', 'Desconto especial para pizzas de verão.', 15.99, '2024-06-01', '2024-06-30'),
(2, 'Promoção de Inverno', 'Desconto especial para pizzas de inverno.', 12.99, '2024-12-01', '2024-12-31'),
(3, 'Promoção de Natal', 'Desconto especial para pizzas de Natal.', 10.99, '2024-11-25', '2024-12-25'),
(4, 'Promoção de Ano Novo', 'Desconto especial para pizzas de Ano Novo.', 11.99, '2024-12-26', '2025-01-01'),
(5, 'Promoção de Carnaval', 'Desconto especial para pizzas de Carnaval.', 13.99, '2024-02-21', '2024-02-26');

-- Inserindo dados fictícios na tabela pizzas
INSERT INTO pizzas (id_pizza, nome, tamanho, preco, ingredientes, id_promocao, status) VALUES
(1, 'Calabresa', 'Grande', 29.99, 'Calabresa, cebola, queijo', NULL, 'Disponivel'),
(2, 'Frango', 'Média', 24.99, 'Frango, milho, catupiry', NULL, 'Disponivel'),
(3, 'Marguerita', 'Grande', 27.99, 'Molho de tomate, muçarela, manjericão', NULL, 'Disponivel'),
(4, 'Quatro Queijos', 'Grande', 31.99, 'Molho de tomate, muçarela, gorgonzola, parmesão, catupiry', NULL, 'Disponivel'),
(5, 'Pepperoni', 'Média', 26.99, 'Pepperoni, molho de tomate, muçarela', 1, 'Promocao');

-- Inserindo dados fictícios na tabela funcionarios
INSERT INTO funcionarios (id_funcionario, nome, cargo, status) VALUES
(1, 'Pedro', 'Atendente', 'Ativo'),
(2, 'Mariana', 'Cozinheira', 'Ativo'),
(3, 'Fernando', 'Entregador', 'Ativo'),
(4, 'Luana', 'Gerente', 'Ativo'),
(5, 'Rafael', 'Atendente', 'Ativo');

-- Inserindo dados fictícios na tabela bebidas
INSERT INTO bebidas (id_bebidas, nome, preco) VALUES
(1, 'Refrigerante Coca-Cola', 5.99),
(2, 'Suco de Laranja', 4.99),
(3, 'Água Mineral', 2.99),
(4, 'Cerveja Brahma', 6.99),
(5, 'Chá Gelado de Pêssego', 3.99);

-- Inserindo dados fictícios na tabela pedido
INSERT INTO pedido (id_pedido, id_entregas, id_contato, id_pizza, id_bebidas, id_funcionario, data_pedido) VALUES
(1, 1, 1, 1, 1, 1, '2024-05-01'),
(2, 2, 2, 2, 2, 2, '2024-05-02'),
(3, 3, 3, 3, 3, 3, '2024-05-03'),
(4, 4, 4, 4, 4, 4, '2024-05-04'),
(5, 5, 5, 5, 5, 5, '2024-05-05');

-- Inserindo dados fictícios na tabela horario_funcionamento
INSERT INTO horario_funcionamento (id_horario, data, horario_abertura, horario_fechamento) VALUES
(1, '2024-05-01', '09:00:00', '22:00:00'),
(2, '2024-05-02', '10:00:00', '23:00:00'),
(3, '2024-05-03', '08:00:00', '21:00:00'),
(4, '2024-05-04', '11:00:00', '20:00:00'),
(5, '2024-05-05', '10:30:00', '22:30:00');
