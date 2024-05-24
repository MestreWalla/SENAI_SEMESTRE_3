-- Inserir registros fictícios na tabela contatos
INSERT INTO contatos (id_contato, nome, email, cell) VALUES
(1, 'João Silva', 'joao@example.com', '(11) 99999-1111'),
(2, 'Maria Oliveira', 'maria@example.com', '(22) 88888-2222'),
(3, 'Carlos Santos', 'carlos@example.com', '(33) 77777-3333'),
(4, 'Ana Souza', 'ana@example.com', '(44) 66666-4444'),
(5, 'Pedro Pereira', 'pedro@example.com', '(55) 55555-5555');

-- Inserir registros fictícios na tabela status_pizzas
INSERT INTO status_pizzas (id_status, id_contato, status_producao, status_entrega) VALUES
(1, 1, 'Em preparação', 'Aguardando entrega'),
(2, 2, 'Pronta', 'Saiu para entrega'),
(3, 3, 'Em preparação', 'Aguardando retirada'),
(4, 4, 'Pronta', 'Entrega finalizada'),
(5, 5, 'Em preparação', 'Aguardando entrega');

-- Inserir registros fictícios na tabela ENTREGAS
INSERT INTO entregas (ID_ENTREGAS, NOME, EMAIL, CEL, PIZZA, ENTREGA) VALUES
(1, 'João Silva', 'joao@example.com', '(11) 99999-1111', 'Pizza de Calabresa', 'Finalizada'),
(2, 'Maria Oliveira', 'maria@example.com', '(22) 88888-2222', 'Pizza de Frango com Catupiry', 'Finalizada'),
(3, 'Carlos Santos', 'carlos@example.com', '(33) 77777-3333', 'Pizza de Margherita', 'Em Andamento'),
(4, 'Ana Souza', 'ana@example.com', '(44) 66666-4444', 'Pizza de Pepperoni', 'Em Andamento'),
(5, 'Pedro Pereira', 'pedro@example.com', '(55) 55555-5555', 'Pizza de Quatro Queijos', 'Finalizada');

-- Inserir registros fictícios na tabela pizzas
INSERT INTO pizzas (nome, tamanho, preco, ingredientes) VALUES
('Pizza de Calabresa', 'Grande', 30.00, 'Calabresa, cebola, mussarela, molho de tomate'),
('Pizza de Frango com Catupiry', 'Média', 25.00, 'Frango desfiado, Catupiry, mussarela, molho de tomate'),
('Pizza de Margherita', 'Grande', 30.00, 'Mussarela, tomate, manjericão, molho de tomate'),
('Pizza de Pepperoni', 'Pequena', 20.00, 'Pepperoni, mussarela, molho de tomate'),
('Pizza de Quatro Queijos', 'Média', 25.00, 'Mussarela, provolone, gorgonzola, parmesão, molho de tomate');

-- Inserir registros fictícios na tabela pedido
INSERT INTO pedido (id_entregas, id_contato, id_pizza, data_pedido) VALUES
(1, 1, 1, CURRENT_DATE),
(2, 2, 2, CURRENT_DATE),
(3, 3, 3, CURRENT_DATE),
(4, 4, 4, CURRENT_DATE),
(5, 5, 5, CURRENT_DATE);
