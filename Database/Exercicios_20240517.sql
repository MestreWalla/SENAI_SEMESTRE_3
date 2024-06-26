--EXERCICIO 01 - Exibir duplicatas em carteira do cliente PCTEC - MICROCOMPUTADORES S/A. Na listagem devem constar o nome do
-- cliente, número da duplicata e o valor correspondente.
SELECT cliente.NOME, venda.DUPLIC, venda.VALOR
FROM cliente INNER JOIN venda ON cliente.codcli = venda.codcli
WHERE cliente.nome LIKE 'PCTEC%';

--EXERCICIO 02 - Exibir os nomes dos clientes e a data de vencimento de todas as
-- duplicatas pendentes no mês de novembro de 2004. A listagem deve
-- ser apresentada em ordem cronológica de vencimento.

--OPÇÃO 01 - MYSQL
SELECT cliente.NOME, venda.VENCTO
FROM cliente INNER JOIN venda ON cliente.CODCLI = venda.CODCLI
WHERE YEAR(venda.VENCTO) = 2004 AND MONTH(venda.VENCTO) = 11
ORDER BY venda.VENCTO;

--OPÇÃO 02 - POSTGREE
SELECT cliente.NOME, venda.VENCTO
FROM cliente INNER JOIN venda ON cliente.CODCLI = venda.CODCLI
WHERE EXTRACT (MONTH FROM venda.VENCTO) = 11 AND EXTRACT (YEAR FROM venda.VENCTO) = 2004
ORDER BY venda.VENCTO;

--EXERCICIO 03 - Apresentar o nome dos clientes e todas as duplicatas que possuem
-- vencimento no mês de outubro de qualquer ano.
SELECT cliente.nome, venda.DUPLIC, venda.VENCTO
FROM cliente
INNER JOIN venda ON cliente.codcli = venda.codcli
WHERE EXTRACT (MONTH FROM venda.VENCTO) = 10;

--EXERCICIO 04 - Consultar o nome do cliente, a quantidade de títulos em carteira por
-- cliente e o total que cada cliente deve.
SELECT cliente.nome, COUNT(venda.DUPLIC) AS quantidade_titulos, SUM(venda.valor) AS total
FROM cliente
INNER JOIN venda ON cliente.codcli = venda.codcli
GROUP BY cliente.nome;

--EXERCICIO 05 - Apresentação da mesma consulta anterior,
-- agora definindo um apelido para a coluna onde é exibido a soma das duplicatas.
SELECT cliente.nome, COUNT(venda.duplic) AS quantidade_titulos, SUM(venda.valor) AS total_devido
FROM cliente
INNER JOIN venda ON cliente.codcli = venda.codcli
GROUP BY cliente.nome;

--EXERCICIO 06 - Apresentar uma listagem identificada pelos apelidos CLIENTE
-- (para o campo NOME) e VENCIDOS (para representar o número de duplicatas
-- vencidas existente na tabela venda que será calculada pela função COUNT)
-- de todos os clientes que possuem títulos com vencimento anterior a 31/12/2003.
SELECT c.NOME AS CLIENTE,
COUNT(v.CODCLI) AS VENCIDOS
FROM CLIENTE c
JOIN VENDA v ON c.CODCLI = v.CODCLI
WHERE v.VENCTO < '2003-12-31'
GROUP BY c.NOME;

-- EXERCICIO 07 - Consultar as duplicatas em atraso, anteriores à data de 31/12/1999,
-- em que devem ser apresentados, além do nome do cliente, o valor da duplicata,
-- o valor dos juros (10%) e o valor total a ser cobrado por título atrasado,
-- ordenados por cliente.
SELECT c.NOME AS CLIENTE, v.DUPLIC, v.VALOR AS VALOR, 
  ROUND(v.VALOR * 1.10, 2) AS VALOR_JUROS, 
  ROUND(v.VALOR + (v.VALOR * 0.10)) AS VALOR_TOTAL 
FROM CLIENTE c
JOIN VENDA v ON c.CODCLI = v.CODCLI 
WHERE v.VENCTO < '1999-12-31'
ORDER BY c.NOME;
