-- Controle de Gastos (Estudo Banco de Dados - SQL) -----------------------	+



	-- Criando uma tabela. 													+ CREATE TABLE

CREATE TABLE compras (
id				INT				AUTO_INCREMENT	PRIMARY KEY					,
valor			DECIMAL(18,2)	 				DEFAULT 0					,
data			DATE					 									,
observacoes		VARCHAR(255)	NOT NULL									,
recebidas		TINYINT(1)		NOT NULL		DEFAULT 1					
);

-- ------------------------------------------------------------------------	+

	-- Criando uma tabela SE ELA NAO EXISTA 								+ IF NOT EXISTS

CREATE TABLE IF NOT EXISTS financeiro (
id				INT				AUTO_INCREMENT	PRIMARY KEY					,
receita			DECIMAL(18,2)	NOT NULL		DEFAULT 0					,
despesas		DECIMAL(18,2)	NOT NULL		DEFAULT 0					
);

-- ------------------------------------------------------------------------	+

	-- Descrevendo uma tabela. 												+ DESC

DESC compras																;

-- ------------------------------------------------------------------------	+

	-- Deletando uma tabela. 												+ DROP

DROP TABLE compras 															;

-- ------------------------------------------------------------------------	+

	-- Visualizando TODOS registros na tabela (adicionando um alias)		+ SELECT * FROM

SELECT * FROM compras c 													;

	-- Visualizando uma ou mais colunas de registros na tabela 				+

SELECT observacoes 			FROM compras c 									;
SELECT observacoes, valor 	FROM compras c 									;

-- ------------------------------------------------------------------------	+

	-- Inserindo um / varios registro em uma tabela							+ INSERT INTO - VALUES

INSERT INTO compras (valor, data, observacoes, recebidas)
VALUES (20,'2016-01-05', 'Lanchonete', 1)									;
VALUES (25,'2016-01-06', 'Assai', 1)										;

-- ------------------------------------------------------------------------	+

	-- Adicionando um filtro na selecão / visualização da Tabela 			+ ( >  <  >=  <=  =  <>)
	
	-- Operadores de comparacao: 											+ WHERE

	-- Maior, Menor, Maior que, Menor que, Igual e Diferente de				+
	
SELECT * FROM compras c WHERE valor > 500									;
SELECT * FROM compras c WHERE valor < 500									;
SELECT * FROM compras c WHERE valor >= 500									;
SELECT * FROM compras c WHERE valor <= 500									;
SELECT * FROM compras c WHERE recebida = 0									;
SELECT * FROM compras c WHERE recebida <> 0									;


-- ------------------------------------------------------------------------	+


	-- Filtrando mais de um valor na Tabela 								+ ( AND - OR - NOT )
	
	-- Operadores Lógicos:													+

	-- AND, OR e NOT														+


SELECT * FROM compras c WHERE valor > 500 AND recebida = 0					;
SELECT * FROM compras c WHERE valor < 500 OR recebida = 0					;
SELECT * FROM compras c WHERE NOT valor < 500 AND recebida = 0				;


-- ------------------------------------------------------------------------	+


	-- Buscando registros por um trecho 				 					+ LIKE

	-- Que começa com 'palavra%', termina com '%palavra', entre '%palavra%'	+

SELECT * FROM compras c WHERE observacoes LIKE 'Parcela%'					;
SELECT * FROM compras c WHERE observacoes LIKE '%natal'						;
SELECT * FROM compras c WHERE observacoes LIKE '%de%'						;


-- ------------------------------------------------------------------------	+


	-- Visualizando um ou mais registros ENTRE valores 						+ BETWEEN

SELECT 	observacoes, valor FROM compras c
WHERE 	valor BETWEEN 1000 AND 2000											;

SELECT 	observacoes, valor FROM compras c
WHERE 	valor BETWEEN 1000 AND 2000
AND 	data BETWEEN '2013-01-01' AND '2013-12-31'							;


-- ------------------------------------------------------------------------	+


	-- Atualizando e Indicando valores em uma tabela 						+ UPDATE - SET

UPDATE compras SET valor = 200 WHERE id = 1									;
UPDATE compras SET observacoes = 'Reformas de quartos' WHERE id = 11		;


-- ------------------------------------------------------------------------	+


	-- Atualizando varias colunas ao mesmo tempo							+

UPDATE compras SET valor = 1500, observacoes = 'Reformas de quartos' 
WHERE id = 7																;


-- ------------------------------------------------------------------------	+


	-- Atualizando valores em varias colunas								+

	-- Operadores Aritiméticos												+ ( +  -  *  / )

	-- Somar, Subtrair, Multiplicar, Dividir								+

UPDATE compras SET valor = valor + 10 WHERE id >= 01 AND id <= 10			;
UPDATE compras SET valor = valor - 15 WHERE id >= 11 AND id <= 20			;
UPDATE compras SET valor = valor * 03 WHERE id >= 21 AND id <= 30			;
UPDATE compras SET valor = valor / 02 WHERE id >= 31 AND id <= 40			;

	-- Utilizando porcentagem (neste caso 15%)

UPDATE compras SET valor = valor * 1.15 WHERE id >= 31 AND id <= 40			;


-- ------------------------------------------------------------------------	+

	-- Deletando um registro de uma tabela [-----ATENÇAO-------]			+ DELETE

DELETE FROM compras WHERE id = 11											;

	-- Sempre começe com a especificação WHERE depois insira o DELETE 		+
	-- Não corra o risco de apagar toda tabela.								+


-- ------------------------------------------------------------------------	+

	-- Alterando a Tabela													+ ALTER TABLE

	-- Modificando a Coluna													+ MODIFY COLUMN

	-- Adicionando Constraints 												+ NOT NULL

ALTER TABLE compras MODIFY COLUMN valor DECIMAL(18,2) NOT NULL				;

	
-- ------------------------------------------------------------------------	+


	-- Valores DEFAULT														+ DEFAULT

ALTER TABLE compras MODIFY COLUMN recebida TINYINT(1) DEFAULT 0 			;


-- ------------------------------------------------------------------------	+


	-- Somando valores de uma coluna										+ SUM

SELECT SUM(valor) FROM compras c 											;
SELECT SUM(valor) FROM compras c WHERE recebida = 1							;


-- ------------------------------------------------------------------------	+

	-- Contando valores de uma coluna										+ COUNT

SELECT COUNT(*) FROM compras c WHERE recebida = 1							;


-- ------------------------------------------------------------------------	+


	-- Somando valores e exibindo colunas referentes (Alias na Coluna)		+ AS

SELECT recebida, SUM(valor) AS soma FROM compras GROUP BY recebida 			;

	-- Agragando valores													+ GROUP BY

SELECT 		recebida, SUM(valor) AS soma FROM compras 
WHERE 		valor < 1000 GROUP BY recebida									;


-- ------------------------------------------------------------------------	+

	-- Agrupando por data													+ MONTH - YEAR

SELECT MONTH(data) AS mes, YEAR(data) AS ano, recebida, 
SUM(valor) AS soma FROM compras 
WHERE recebida = 0 GROUP BY recebida, mes, ano 								;

-- ------------------------------------------------------------------------	+

	-- Ordenando os Resultado												+ ORDER BY

SELECT MONTH(data) AS mes, YEAR(data) AS ano, recebida, 
SUM(valor) AS soma FROM compras 
WHERE recebida = 0 GROUP BY recebida, mes, ano
ORDER BY mes, ano															;

-- ------------------------------------------------------------------------	+

	-- Recebendo a MEDIA da Coluna											+ AVG

SELECT MONTH(data) AS mes, YEAR(data) AS ano, recebida, 
AVG(valor) AS soma FROM compras 
WHERE recebida = 0 GROUP BY recebida, mes, ano
ORDER BY mes, ano															;

-- ------------------------------------------------------------------------	+

	-- Adicionando uma Coluna												+ ADD COLUMN

ALTER TABLE compras ADD COLUMN comprador VARCHAR(255)						;

-- ------------------------------------------------------------------------	+

	-- Atualizando registro compradores na tabela							+

UPDATE compras SET comprador = 'Jo Ventino' WHERE id = 1					;
UPDATE compras SET comprador = 'Joven Tino' WHERE id = 2					;
UPDATE compras SET comprador = 'Zele Oncio' WHERE id = 3					;
UPDATE compras SET comprador = 'Jo Ventino' WHERE id = 4					;
UPDATE compras SET comprador = 'Joven Tino' WHERE id = 5					;

-- ------------------------------------------------------------------------	+

	-- Limitando a quantidade de resultados na pesquisa						+ LIMIT

SELECT * FROM compras c LIMIT 5												;

-- ------------------------------------------------------------------------	+

	-- Atualizando registro com indicacao do local do valor					+

UPDATE compras SET comprador = 'Ze Leoncio' WHERE id = 5					;

-- ------------------------------------------------------------------------	+

	-- Adicionando mais uma coluna a tabela									+

ALTER TABLE compras ADD COLUMN telefone VARCHAR(30)							;

-- ------------------------------------------------------------------------	+

	-- Atualizando registro de telefones									+

UPDATE compras SET telefone = '(11) 2256-3138' WHERE comprador = 'Jo Ventino';
UPDATE compras SET telefone = '(11) 2315-5468' WHERE comprador = 'Joven Tino';
UPDATE compras SET telefone = '(11) 2498-8925' WHERE comprador = 'Zele Oncio';
UPDATE compras SET telefone = '(11) 2894-6584' WHERE comprador = 'Ze Leoncio';

-- ------------------------------------------------------------------------	+

	-- Criando uma nova tabela COMPRADORES e Inserindo Valores				+

CREATE TABLE compradores(
id			INT				PRIMARY KEY 	AUTO_INCREMENT					,
nome		VARCHAR(100)													,
endereco	VARCHAR(255)													,
telefone	VARCHAR(30))													;

SELECT * FROM compradores													;
DESC compradores															;

INSERT INTO compradores (nome, endereco, telefone)
VALUES ('Jo Ventino', 'Viela da Tapera', '(11) 2256-3138')					;

INSERT INTO compradores (nome, endereco, telefone)
VALUES ('Joven Tino', 'Riacho do Su Cu Ri', '(11) 2315-5468')				;

INSERT INTO compradores (nome, endereco, telefone)
VALUES ('Zele Oncio', 'Lagoa do Pant Anal', '(11) 2498-8925')				;

INSERT INTO compradores (nome, endereco, telefone)
VALUES ('Ze Leoncio', 'Vizinho do Tenorio', '(11) 2894-6584')				;

-- ------------------------------------------------------------------------	+

	-- Deletando uma Coluna													+ DROP COLUMN

ALTER TABLE compras DROP COLUMN comprador									;
ALTER TABLE compras DROP COLUMN telefone									;

-- ------------------------------------------------------------------------	+

	-- Criando e atualizando uma coluna id_compradores						+ LIGACAO UM PARA MUITOS

ALTER TABLE compras ADD COLUMN id_compradores INT							;
UPDATE compras SET id_compradores = 1 WHERE id < 22							;
UPDATE compras SET id_compradores = 2 WHERE id > 21							;

SELECT * FROM compras c 													;

-- ------------------------------------------------------------------------	+

	-- Selecionando mais de uma tabela com FROM								+ FROM em 2 TABLE

SELECT * FROM compras, compradores c 										;


	-- Juntando tabelas atraves de chave estrangeira e primaria				+ JOIN

SELECT * FROM compras JOIN compradores 
ON compras.id_compradores = compradores.id									;

	-- Obs.: Quando adicionamos um alias a uma tabela, obrigatoriamente,	+
-- temos que usar o alias. Exemplo:											+

-- compradores c (alias)   compras.id_compradores = c.id					+

-- ------------------------------------------------------------------------	+

	-- Restringindo uma chave estrangeira									+ FOREING KEY

ALTER TABLE compras ADD CONSTRAINT fk_compradores 
FOREIGN KEY (id_compradores) REFERENCES compradores (id)					;


-- ------------------------------------------------------------------------	+

	-- Adicionando registros a uma tabela com FK							+

INSERT INTO compras (valor, data, observacoes, id_compradores)
VALUES (1500, '2016-01-05', 'Playstation 4', 1)								;

SELECT * FROM compras WHERE observacoes = 'Playstation 4'					;

-- ------------------------------------------------------------------------	+

	-- Adicionando uma coluna ENUM na tabela								+ ENUM

ALTER TABLE compras ADD COLUMN forma_pagto ENUM ('BOLETO', 'CREDITO')		;

-- ------------------------------------------------------------------------	+
	
	-- Inserindo resgistros na tabela com ENUM								+

INSERT INTO compras (valor, data, observacoes, id_compradores, forma_pagto)	
VALUES (400, '2016-01-06', 'SSD 128GB', 1,'BOLETO') 						;

-- ------------------------------------------------------------------------	+

	-- Habilitando SQL Modes (SESSAO RECORRENTE) Strict Mode				+ STRICT_ALL_TABLES

SET SESSION sql_mode = 'STRICT_ALL_TABLES'									;

-- ------------------------------------------------------------------------	+

	-- Verificando se SQL MODE está ativo									+ @@SESSION

SELECT @@SESSION.sql_mode													;

-- ------------------------------------------------------------------------	+

	-- Inserindo registro em uma tabela com com STRICT MODE					+

INSERT INTO compras (valor, data, observacoes, id_compradores, forma_pagto)
VALUES (80, '2016-01-07', 'Bola de Futebol', 2, 'DINHEIRO')					;

-- ------------------------------------------------------------------------	+

	-- Habilitando SQL Modes (MODO DEFINITIVO) Strict Mode					+ GLOBAL MODE STRICT_ALL_TABLES

SET GLOBAL sql_mode = 'STRICT_ALL_TABLES'									;


-- ------------------------------------------------------------------------	+

	-- Verificando se SQL MODE está ativo definitivamente					+ @@GLOBAL

SELECT @@GLOBAL.sql_mode													;


-- ------------------------------------------------------------------------	+
