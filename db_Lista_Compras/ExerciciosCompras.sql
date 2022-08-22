CREATE TABLE compras(
id 			INT 			AUTO_INCREMENT 	PRIMARY KEY		,
valor 		DECIMAL	(18,2)	NOT NULL						,
data		DATE			NOT NULL						,
observacoes	VARCHAR	(255)	NOT NULL						,
recebida	TINYINT											
);



-- =========================================================================== --
-- =========================================================================== --

-- =============================== EXERCICIOS ================================ --
-- ============================== DATABASE SQL =============================== --

-- =========================================================================== --
-- =========================================================================== --





-- ---------------------------------------------------------------------------- +


																				
	-- EXERCICIOS CAPITULO 01 ------------------------------------------------- +



SELECT * FROM compras															;


	-- 01: Selecionando Valor e Observações com data > 01/12/2012 ------------- +

SELECT valor, observacoes FROM compras WHERE data >= '2012-12-01'

	-- 02: O Comando de junção é AND. ----------------------------------------- +

SELECT * FROM compras WHERE valor > 1000 AND valor < 5000						; 

	-- 03: Sim, é possivel substituir aspas simples '' por aspas duplas " ".	+

UPDATE compras SET
observacoes = "Play Center" WHERE observacoes  = 'Hopi Hari'					;

	-- 04: Selecionando Maior ou igual que, e menor ou igual que. ------------- +

SELECT * FROM compras WHERE data >= '2012-12-15' AND data <= '2014-12-15'		;

	-- 05: Selecionando VARCHAR + Intervalo de DECIMAL ------------------------ +

SELECT * FROM compras WHERE observacoes = 'Lanchonete' 
	AND valor > 15 AND valor < 35												;

	-- 06: Selecionando compras recebidas ------------------------------------- +

SELECT * FROM compras WHERE recebida = 1										;

	-- 06: Selecionando compras não recebidas --------------------------------- +

SELECT * FROM compras WHERE recebida = 0 										;

	-- 07: TINYINT, aceita tanto 0 e 1, quanto TRUE ou FALSE. ----------------- +

INSERT INTO compras (valor, data, observacoes, recebida)						;
VALUES	(100.00, '2015-09-08', 'Comida', TRUE)

SELECT * FROM compras WHERE recebida = TRUE										;

	-- 08: Selecionando DECIMAL OR TINYINT TRUE ------------------------------- +

SELECT * FROM compras WHERE recebida = TRUE OR valor > 5000						;

	-- 08: Selecionando intervalo DECIMAL OR MAIOR QUE ------------------------ +

SELECT * FROM compras WHERE valor > 1000 AND valor < 3000 OR valor > 5000		;



-- ------------------------------------------------------------------------------


	-- EXERCICIOS CAPITULO 02 ------------------------------------------------- +


	-- 01: Buscando compras efetuadas na data 20/12/2014 ---------------------- +

SELECT observacoes, valor, id  FROM compras WHERE data = '2014-12-20'			; 

	-- 01: Alterando / Atualizando Observações de Compras --------------------- +

UPDATE compras SET observacoes = 'Preparando o Natal' WHERE id = 32				;
	
	-- 02: Buscando compras efetuadas anteriormente a data 20/12/2014 --------- +

SELECT valor, observacoes, id FROM compras WHERE data < '2013-06-01'			;
		
	-- 02: Atualizando Valores em + R$ 10,00 em datas anteriores a 20/12/2014 - +

UPDATE compras SET valor = valor + 10.00 WHERE data < '2013-06-01'				;

	-- 03: Buscando compras entre datas. -------------------------------------- +

SELECT observacoes, recebida, data, id FROM compras 
WHERE data BETWEEN '2013-07-01' AND '2014-07-01'								;

	-- 03: Atualizar observações entre datas ---------------------------------- +

UPDATE compras SET observacoes = 'Entregue antes de 2014' WHERE id = 12 		;
	
	-- 03: Atualizar observações entre datas ---------------------------------- +
	-- (RESOLVER DEPOIS COM CONCATENAÇÃO DE VARCHAR) -------------------------- +

UPDATE compras SET observacoes = observacoes 
	+ 'Entregue antes de 2014'	WHERE recbidas = FALSE  						;

	-- 04: Operador que indica Valor minimo ( < "Menor que ) e ( > "Maior que")	+
	-- 05: Operador que remove linhhas em uma tabela ( DELETE ) --------------- +

	-- 06: Excluindo linhas entre datas. -------------------------------------- +

SELECT * FROM compras WHERE data BETWEEN '2013-03-05' AND '2013-03-20'			;
DELETE FROM compras WHERE data BETWEEN '2013-03-05' AND '2013-03-20'			;
	
	-- 07: Selecionando Valores diferentes do informado (OPERADOR DE NEGAÇÃO)	+
SELECT * FROM compras c WHERE NOT valor = 210.00								; 


-- ----------------------------------------------------------------------------	+


	-- EXERCICIOS CAPITULO 03 ------------------------------------------------- +


	DESC compras 																;
	
	-- 01: Alterando coluna recebida para DEFAULT ----------------------------- +

ALTER TABLE compras MODIFY COLUMN recebida TINYINT(1) DEFAULT 0					;
	
	-- 02: Alterando coluna observacoes para NOT NULL ------------------------- +

ALTER TABLE compras MODIFY COLUMN observacoes VARCHAR(255) NOT NULL				;
	

	-- 03: Análise de DEFAULT: ------------------------------------------------ +

-- Devido a maior parte da tabela de compras serem compras presenciais, 		+
-- faria uma alteração na tabela recebidos para DEFAULT 1						+

	-- 04: Criando nova tabela com DEFAULT e Constraints NOT NULL ------------- +

	DESC Financeiro																;

CREATE TABLE IF NOT EXISTS 	Financeiro											(					
id 			INT 			AUTO_INCREMENT 	PRIMARY KEY							,
receita		DECIMAL	(18,2)	NOT NULL		DEFAULT	0							,
despesas	DECIMAL	(18,2)	NOT NULL		DEFAULT 0)							;
	
	DROP TABLE Financeiro 														;
	SELECT * FROM Financeiro													;
	ALTER TABLE Financeiro ADD descricao VARCHAR(255) NOT NULL					;
	
	-- 05: Rescrevendo Valores da coluna recebida e observacoes DEFAULT/NULL -- +

ALTER TABLE compras MODIFY COLUMN recebida TINYINT(1) DEFAULT 1					;
ALTER TABLE compras MODIFY COLUMN observacoes VARCHAR(255) NULL					;


-- ----------------------------------------------------------------------------	+


	-- EXERCICIOS CAPITULO 04 ------------------------------------------------- +


	-- 01: Media de todas as compras com datas inferiores a 12/05/2013 -------- +

SELECT 	AVG(valor) AS valor,	data FROM compras c
WHERE 	data < '2013-05-12' 	GROUP BY data  								
ORDER 	BY data 																;

	-- 02: Media de compras com datas inferiores a 12/05/2013 ----------------- +

SELECT 	SUM(id) AS qtd,			data FROM compras c
WHERE 	data < '2013-05-12' 	GROUP BY data  								
ORDER 	BY id  																	;

	-- 03: Soma de todas as compras agrupadas se recebida ou nao -------------- +

SELECT 	SUM(valor) AS soma, recebida	FROM compras
WHERE recebida = 0 OR recebida = 1 		GROUP BY recebida 						;


-- ----------------------------------------------------------------------------	+


	-- EXERCICIOS CAPITULO 05													+


-- 01: Criando uma tabela com id, nome, endereço e telefone ------------------- +

CREATE TABLE compradores (
id			INT				PRIMARY KEY 	AUTO_INCREMENT						,
nome		VARCHAR(255)	NOT NULL											,
endereco	VARCHAR(255)	NOT NULL											,
telefone	VARCHAR(30)		NOT NULL
);

-- 02: Inserindo nomes na tabela ---------------------------------------------- +

INSERT INTO compradores (nome)
VALUES ('Guilherme')															;

INSERT INTO compradores (nome)
VALUES ('João da Silva')														;

-- 03: Adicionando coluna id_compradores, definindo FK FOREIGN KEY ------------ +
	-- (Chave Estrangeira) referenciando tabela compradores ------------------- +

ALTER TABLE compras ADD COLUMN id_compradores INT								;

ALTER TABLE compras ADD CONSTRAINT fk_compradores 
FOREIGN KEY (id_compradores) REFERENCES compradores (id)						;

-- 04: Inserindo ID dos compradores na coluna id_compradores ------------------ +

UPDATE compras SET id_compradores = 1 WHERE id < 22								;

-- 05: Exibindo NOME do comprador e o valor de compras anteriores a 09/08/2014	+

SELECT nome, valor FROM compras JOIN compradores 
ON compras.id_compradores = compradores.id WHERE data < '2014-08-09'			;

-- 06: Exibindo compras com id igual a 2 -------------------------------------- +

SELECT * FROM compras JOIN compradores 
ON compras.id_compradores = compradores.id WHERE compradores.id = 2				;

-- 07: Compras sem dados do comprador, com nome que começe com Joven ---------- +

SELECT compras.* FROM compras JOIN compradores 
ON compras.id_compradores = compradores.id
WHERE compradores.nome LIKE 'Joven%'											;

-- 08: Exibindo nome do comprador e a soma de todas as compras ---------------- +

SELECT nome, SUM(valor) FROM compras JOIN compradores 
ON compras.id_compradores = compradores.id WHERE nome = 'Jo Ventino'			;

-- 09: Sim, é possivel relacionar tabelas somente com JOIN -------------------- +

-- 10: A Vantagem de uma FK é poder referenciar outra tabela atraves de um id,
-- não tendo a necessidade de criar uma unica tabela extensa contendo diversos
-- tipos de dados não necessários para a tabela principal. -------------------- +


-- 11: Criando uma Coluna Forma de Pagamento do Tipo ENUM com valores --------- +

INSERT TABLE compras ADD COLUMN forma_pagto ENUM('BOLETO', 'CREDITO')			;


-- ---------------------------------------------------------------------------- +

-- 12: Ativando Strict Mode na Sessão ----------------------------------------- +

SET SESSION sql_mode = 'STRICT_ALL_TABLES'										;

SELECT @SESSION.sql_mode														;

-- ---------------------------------------------------------------------------- +

-- 13: Inserindo informações diferente de CREDITO ou BOLETO, vereficando recusa	+

INSERT INTO compras (valor, data, observacoes, id_compradores, forma_pagto)
VALUES (999, '2016-01-07', 'Bola de Futebol', 2, 'DINHEIRO')					;

-- ---------------------------------------------------------------------------- +

-- 14: Atualizando forma de pagamento de todas as compras UPDATE -------------- +

UPDATE compras SET forma_pagto = 'CREDITO' 										;
SELECT * FROM compras WHERE forma_pagto 										;

-- ---------------------------------------------------------------------------- +

-- 15: Setando configuração GLOBAL no Strict Mode ----------------------------- +

SET SESSION sql_mode = 'STRICT_ALL_TABLES'										;


-- ---------------------------------------------------------------------------- +