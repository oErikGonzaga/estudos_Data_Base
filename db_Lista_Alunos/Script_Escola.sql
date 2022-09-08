CREATE DATABASE ESCOLA										;
USE ESCOLA													;

CREATE TABLE aluno (
  id 		int 			NOT NULL AUTO_INCREMENT			,
  nome 		varchar(255) 	NOT NULL DEFAULT ''				,
  email 	varchar(255) 	NOT NULL DEFAULT ''				,
  PRIMARY KEY (id)
)															;

-- --------------------------------------------------------	+

	-- Mostrando uma tabela. 								+ SHOW TABLE

SHOW TABLES													;

-- --------------------------------------------------------	+

	-- DESCREVENDO uma tabela. 								+ DESC nome_tabela

DESC aluno 													;
DESC curso 													;
DESC matricula 												;

-- --------------------------------------------------------	+

	-- Apelidando tabelas									+

SELECT aluno.nome FROM aluno
JOIN matricula m ON aluno_id = aluno.id 					;

-- ou														+

SELECT a.nome FROM aluno a
JOIN matricula m ON aluno_id = a.id 						;

-- Mesmo o alias sendo aplicado após (FROM aluno a),		+
-- ele é reconhecido anteriormente (SELECT a.nome) 			+

-- --------------------------------------------------------	+

	-- Apelidando mais de uma tabela						+

SELECT a.nome, c.nome FROM aluno a
JOIN matricula m ON m.aluno_id = a.id
JOIN curso c ON m.curso_id = c.id							;

-- --------------------------------------------------------	+

	-- Verificando quantidade de alunos(registros)			+ COUNT

SELECT COUNT(*) FROM aluno a								;

-- --------------------------------------------------------	+

-- ######################################################## +

-- SUBQUERIES

-- ######################################################## +

	--  Verificando registros existente						+ EXISTS

SELECT a.nome FROM aluno a WHERE EXISTS 
(SELECT m.id FROM matricula m WHERE m.aluno_id = a.id)		;

-- --------------------------------------------------------	+

	-- Verificando registros vinculados a 
	-- registros não existentes		 						+ NOT EXISTS

SELECT a.nome FROM aluno a WHERE NOT EXISTS 
(SELECT m.id FROM matricula m WHERE m.aluno_id = a.id)		;

-- --------------------------------------------------------	+

DESC exercicio 												;
DESC resposta 												;

-- --------------------------------------------------------	+

	-- Selecionando, vinculando, todos campos existentes	+
	-- de registros desejados

SELECT * FROM exercicio e WHERE NOT EXISTS
(SELECT r.id FROM resposta r WHERE r.exercicio_id = e.id)	;

	-- Selecionando, vinculando, campos desejados			+
	-- de registros desejados

SELECT e.id, e.pergunta FROM exercicio e WHERE NOT EXISTS
(SELECT r.id FROM resposta r WHERE r.exercicio_id = e.id)	;

-- --------------------------------------------------------	+

	-- Retornando cursos que não possuem matricula			+

SELECT c.nome FROM curso c WHERE NOT EXISTS 
(SELECT m.id FROM matricula m WHERE m.curso_id = c.id)		;	

-- --------------------------------------------------------	+

	-- Verificando alunos que nao responderam exercicios	;

SELECT a.nome, c.nome FROM aluno a 
JOIN matricula m ON m.aluno_id = a.id 
JOIN curso c ON m.curso_id = c.id
WHERE NOT EXISTS (SELECT r.aluno_id
FROM resposta r WHERE r.aluno_id = a.id)					;

-- --------------------------------------------------------	+

	-- Verificando alunos matriculados que responderem exer +

SELECT r.id, a.nome FROM aluno a 
JOIN resposta r ON r.aluno_id = a.id 
WHERE EXISTS (SELECT m.aluno_id 
FROM matricula m WHERE m.aluno_id = a.id)					;

	-- Verificando se alunos matriculados responderem exer  +


SELECT r.id, a.nome FROM aluno a 
JOIN resposta r ON r.aluno_id = a.id 
WHERE NOT EXISTS (SELECT m.aluno_id 
FROM matricula m WHERE m.aluno_id = a.id)					;

-- --------------------------------------------------------	+

	-- AGRUPANDO DADOS COM GROUP BY

--  Table CURSO, possue um id, 
-- table SECAO tem relação com table CURSO através de CURSO_ID, 
-- table EXERCICIO, tem relação com SECAO através de SECAO_ID,
-- table RESPOSTA, tem relação com EXERCICIO por EXERCICIO_ID,
-- E NOTA, tem relação com RESPOSTA atraves de RESPOSTA_ID.

-- --------------------------------------------------------	+

	-- Montando nossa query por partes

SELECT n.nota FROM NOTA n 									;

SELECT n.nota FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 					;

SELECT n.nota FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 					;

SELECT n.nota FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = n.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s on e.SECAO_ID = s.ID 							;


SELECT n.nota FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID
JOIN SECAO s ON e.SECAO_ID = s.ID
JOIN CURSO c ON s.CURSO_ID = c.ID 							;

-- --------------------------------------------------------	+

	-- Obtendo a média das NOTAS							+

SELECT AVG(n.nota) FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID 							;

	-- Agrupando a Média de uma COLUNA						+

SELECT c.NOME, AVG(n.nota) FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID
GROUP BY c.NOME 											;

	-- Verificando Exercicios existentes no Banco ( COUNT ) +

SELECT COUNT(*) FROM EXERCICIO e 							; 

SELECT c.NOME, COUNT(*) FROM EXERCICIO e 
JOIN SECAO s ON e.SECAO_ID = s.ID 							
JOIN CURSO c ON s.CURSO_ID = c.ID 							
GROUP BY c.NOME 											;

	-- Obs.: Caso não coloque o GROUP BY, CONSTA ERRO...

SELECT c.nome, COUNT(*) AS Contagem FROM EXERCICIO e
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID 
GROUP BY c.nome												;

-- --------------------------------------------------------	+


SELECT c.nome FROM CURSO c 
JOIN MATRICULA m ON m.CURSO_ID = c.ID 
JOIN ALUNO a ON m.ALUNO_ID = a.ID 							;

SELECT c.nome, COUNT(a.ID) AS Quantidade 
FROM CURSO c JOIN MATRICULA m
ON m.CURSO_ID = c.ID JOIN ALUNO a 
ON m.ALUNO_ID = a.ID 
GROUP BY c.NOME 											;

-- --------------------------------------------------------	+

-- Montando boletins (buscando informações p/ query)		+

SELECT n.nota FROM NOTA n 

-- Associando respostas as notas;							+

SELECT n.nota FROM NOTA n 
JOIN RESPOSTA r ON r.ID = RESPOSTA_ID 						;

-- Associando exercicios com respostas.						+

SELECT n.NOTA FROM NOTA n 
JOIN RESPOSTA r ON r.ID = n.RESPOSTA_ID 
JOIN EXERCICIO e ON e.ID - r.EXERCICIO_ID					;

-- Associando seção com os exercicios						+

SELECT n.NOTA FROM NOTA n 
JOIN RESPOSTA r ON r.id = n.RESPOSTA_ID 
JOIN EXERCICIO e ON e.ID = r.EXERCICIO_ID 
JOIN SECAO s ON s.ID = e.SECAO_ID 							;

-- Associando curso com seção								+

SELECT n.NOTA FROM NOTA n 
JOIN RESPOSTA r ON r.id = n.RESPOSTA_ID  
JOIN EXERCICIO e ON e.ID = r.EXERCICIO_ID  
JOIN SECAO s ON s.ID = e.SECAO_ID  
JOIN CURSO c ON c.ID = s.CURSO_ID 							;

-- Associando resposta com Aluno							+

SELECT n.NOTA FROM NOTA n 
JOIN RESPOSTA r on r.ID = n.RESPOSTA_ID 
JOIN EXERCICIO e ON e.ID = r.EXERCICIO_ID 
JOIN SECAO s ON s.ID = e.SECAO_ID 
JOIN CURSO c ON c.ID = s.CURSO_ID 
JOIN ALUNO a ON a.ID = r.ALUNO_ID 							;

--  Tirando média das notas									+

SELECT AVG(n.NOTA) AS Nota FROM NOTA n 
JOIN RESPOSTA r ON r.ID = n.RESPOSTA_ID 
JOIN EXERCICIO e ON e.ID = r.EXERCICIO_ID 
JOIN SECAO s ON s.ID = e.SECAO_ID 
JOIN CURSO c ON c.ID = s.CURSO_ID 
JOIN ALUNO a ON a.ID = r.ALUNO_ID 							;

-- Media, Alunos e cursos (Sem o Group by, apresenta erro)	+

SELECT a.NOME, c.NOME, AVG(n.nota) AS Nota FROM NOTA n 
JOIN RESPOSTA r ON r.ID = n.RESPOSTA_ID 
JOIN EXERCICIO e ON e.ID = r.EXERCICIO_ID 
JOIN SECAO s ON s.ID = e.SECAO_ID 
JOIN CURSO c ON c.ID = s.CURSO_ID 
JOIN ALUNO a ON a.ID = r.ALUNO_ID
GROUP BY  a.NOME, c.NOME 									;


-- CONDIÇOES COM HAVING ----------------------------------- +

--  Buscando a média menor que 5

SELECT a.NOME, c.NOME, AVG(n.NOTA) AS Nota FROM NOTA n 
JOIN RESPOSTA r ON r.ID = n.RESPOSTA_ID 
JOIN EXERCICIO e ON e.ID = r.EXERCICIO_ID 
JOIN SECAO s ON s.ID = e.SECAO_ID 
JOIN CURSO c ON c.ID = s.CURSO_ID 
JOIN ALUNO a ON a.ID = r.ALUNO_ID 
GROUP BY a.NOME, c.NOME
HAVING AVG(n.NOTA) < 5										;

--  Buscando a média maior ou igual a 5						+

SELECT a.NOME, c.NOME, AVG(n.NOTA) AS Nota FROM NOTA n 
JOIN RESPOSTA r ON r.ID = n.RESPOSTA_ID 
JOIN EXERCICIO e ON e.ID = r.EXERCICIO_ID 
JOIN SECAO s ON s.ID = e.SECAO_ID 
JOIN CURSO c ON c.ID = s.CURSO_ID 
JOIN ALUNO a ON a.ID = r.ALUNO_ID 
GROUP BY a.NOME, c.NOME 
HAVING AVG(n.NOTA) >= 5										; 


-- Buscando Cursos com poucos alunos						+

SELECT c.NOME FROM CURSO c 
JOIN MATRICULA m ON m.CURSO_ID = c.ID 
JOIN ALUNO a ON m.ALUNO_ID = a.ID ;

-- Contando quantidades de alunos COUNT						+

SELECT c.NOME, COUNT(a.ID) FROM CURSO c
JOIN MATRICULA m ON m.CURSO_ID = c.ID 
JOIN ALUNO a ON m.ALUNO_ID = a.ID  							
GROUP BY c.NOME												;

-- Cursos com menos de 10 alunos

SELECT c.NOME, COUNT(a.ID) AS QTD FROM CURSO c
JOIN MATRICULA m ON m.CURSO_ID = c.ID 
JOIN ALUNO a ON m.ALUNO_ID = a.ID  							
GROUP BY c.NOME												
HAVING COUNT(a.ID) < 10 									;


-- --------------------------------------------------------	+

-- MULTIPLOS VALORES NA CONDIÇÃO E O IN 					+


-- Verificando formas de pagamento cadastradas no banco

DESC MATRICULA 												;

SELECT m.TIPO FROM MATRICULA m								; 

-- Selecionando valores distintos da tabela Matricula		+ DISTINCT

SELECT DISTINCT m.TIPO FROM MATRICULA m 					;

-- Contagem das Matriculas									+

SELECT COUNT(m.ID) AS Qtd_Matriculas FROM MATRICULA m 		; 

-- Contagem + Nome do Curso									+

SELECT COUNT(m.ID) AS Qtd_Mtr, c.NOME, m.TIPO
FROM MATRICULA m JOIN CURSO c ON c.ID = m.CURSO_ID
GROUP BY c.NOME, m.TIPO 									;

-- Contagem + Nome do Curso + Filtro						+


SELECT COUNT(m.ID) AS Qtd_Mtr, c.NOME, m.TIPO 
FROM MATRICULA m JOIN CURSO c ON c.ID = m.CURSO_ID
WHERE m.TIPO = 'PAGA_PJ' 
GROUP BY c.NOME, m.TIPO  									;


-- --------------------------------------------------------	+

-- FILTROS UTILIZANDO O IN 									+

-- Filtrando Pagamentos PF e PJ								+

SELECT COUNT(m.ID) AS Qtd_Mtr, c.NOME, m.TIPO 
FROM MATRICULA m JOIN CURSO c ON c.ID = m.CURSO_ID
WHERE m.TIPO = 'PAGA_PJ' OR m.TIPO = 'PAGA_PF'
GROUP BY c.NOME, m.TIPO  									;


-- Utilizando IN invés a OR									+ IN 

SELECT COUNT(m.ID) AS Qtd_Mtr, c.NOME, m.TIPO 
FROM MATRICULA m JOIN CURSO c ON c.ID = m.CURSO_ID
WHERE m.TIPO 
IN ('PAGA_PF', 'PAGA_PJ','PAGA_CHEQUE', 'PAGA_BOLETO')
GROUP BY c.NOME, m.TIPO 									;

-- Selecionando melhores alunos								+
-- Buscando ID do Aluno										+

SELECT * FROM ALUNO a 										;

-- Retornando e Ordenando os Alunos ao mesmo tempo 			+

SELECT c.NOME, a.NOME FROM CURSO c 
JOIN MATRICULA m ON m.CURSO_ID = c.ID 
JOIN ALUNO a ON a.ID = m.ALUNO_ID
WHERE a.ID IN (1,3,4)										
ORDER BY a.NOME												;

-- Buscando ex-alunos matriculados em SQL e C#				+

SELECT * FROM CURSO c 										;

SELECT a.NOME FROM ALUNO a 									;

SELECT a.NOME, c.NOME FROM ALUNO a
JOIN MATRICULA m ON m.ALUNO_ID = a.ID 
JOIN CURSO c ON c.ID = m.CURSO_ID 
WHERE c.ID IN (1,4)
ORDER BY a.NOME												;

-- --------------------------------------------------------	+

-- SUB-QUERIES 												+

-- Buscando Nome do Aluno e Curso, média do aluno e diferença
-- da média geral do curso.									+

-- Montando o SELECT 										+

SELECT a.NOME, c.NOME, n.NOTA FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID
JOIN ALUNO a ON r.ALUNO_ID = a.ID 							;

-- Buscando a média da NOTA									+

SELECT a.NOME, c.NOME, AVG(n.NOTA) 
AS Media_Aluno FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID
JOIN ALUNO a ON r.ALUNO_ID = a.ID 							
GROUP BY a.NOME, c.NOME 									;

-- Sub-Query												+
-- Subtraindo a Média do Aluno da Média Geral				+

SELECT a.NOME, c.NOME, AVG(n.NOTA) AS Media_Aluno,
(SELECT AVG(n.NOTA) FROM NOTA n) AS Média_Geral,
AVG(n.NOTA) - (SELECT AVG(n.NOTA) FROM NOTA n) AS Diferenca
FROM NOTA n
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID 
JOIN ALUNO a ON r.ALUNO_ID = a.ID 
GROUP BY a.NOME, c.NOME										; 

-- Buscando qtd de respostas de cada aluno individualmente	+
-- Buscando Alunos

SELECT a.NOME FROM ALUNO a 									;

-- Buscando quantidade de Respostas							+

SELECT COUNT(r.ID) FROM RESPOSTA r 							;

-- Subquery de Alunos e Respostas							+

SELECT a.NOME, (SELECT COUNT(r.ID) FROM RESPOSTA r)
AS Qtd_Respostas FROM ALUNO a 								;

-- Filtrando Respostas										+

SELECT a.NOME, (SELECT COUNT(r.ID) FROM RESPOSTA r 
WHERE r.ALUNO_ID = a.ID) AS QTD_RESPOSTAS FROM ALUNO a 		;

-- Filtrando Matriculas										+

SELECT a.NOME, (SELECT COUNT(m.ID) FROM MATRICULA m
WHERE m.ALUNO_ID = a.ID) AS QTD_MATRICULAS FROM ALUNO a 	;

-- Alunos, qtd Respostas e qtd Matriculas					+

SELECT a.NOME, (SELECT COUNT(r.ID) FROM RESPOSTA r 
WHERE r.ALUNO_ID = a.ID) AS QTD_RESPOSTAS,
(SELECT COUNT(m.ID) FROM MATRICULA m 
WHERE m.ALUNO_ID = a.ID) AS QTD_MATRICULA
FROM ALUNO a 												;


-- --------------------------------------------------------	+

-- ENTENDENDO LEFT JOIN										+

-- Contando resposta dos alunos e agrupando					+

SELECT a.NOME, COUNT(r.ID) FROM RESPOSTA r 
JOIN ALUNO a ON r.ALUNO_ID = a.ID 
GROUP BY a.NOME 											;

-- Verificando alunos Existentes							+

SELECT COUNT(a.ID) FROM ALUNO a 							;

-- Selecionando aluno que não respondeu						+

SELECT r.ID FROM RESPOSTA r WHERE r.ALUNO_ID = 5			;

--  Selecionando alunos sem que não responderam				+

SELECT a.NOME FROM ALUNO a WHERE NOT EXISTS
(SELECT r.ID FROM RESPOSTA r WHERE r.ALUNO_ID = a.ID)		;

-- Retornando Aluno e resposta dada							+

SELECT a.ID, a.NOME, r.ALUNO_ID, r.RESPOSTA_DADA FROM ALUNO a 
JOIN RESPOSTA r ON r.ALUNO_ID = a.ID 						;

-- Trazendo registros da tabela da esquerda					+ LEFT JOIN

SELECT a.ID, a.NOME, r.ALUNO_ID, r.RESPOSTA_DADA FROM ALUNO a 
LEFT JOIN RESPOSTA r ON r.ALUNO_ID = a.ID 					;

-- Agrupando pelo NOME

SELECT a.NOME, COUNT(r.ID)  FROM ALUNO a 
LEFT JOIN RESPOSTA r ON r.ALUNO_ID = a.ID 					
GROUP BY a.NOME 											;

-- Retornando respostas respondidas e não respondidas		+

SELECT r.ID FROM RESPOSTA r 
WHERE r.ALUNO_ID IS NULL									; 

-- Inserindo uma resposta sem associar um aluno				+ RIGHT JOIN

INSERT INTO RESPOSTA (RESPOSTA_DADA) VALUES ('X VALE 15')	;

SELECT a.NOME, r.RESPOSTA_DADA FROM ALUNO a 
RIGHT JOIN RESPOSTA r ON r.ALUNO_ID = a.ID 					;

-- Utilizando o INNER JOIN									+ INNER JOIN

SELECT a.NOME, COUNT(r.ID) AS Respostas FROM ALUNO a 
INNER JOIN RESPOSTA r ON r.ALUNO_ID = a.ID
GROUP BY a.NOME 											;

-- JOIN ao invés de SUBQUERY								+

-- Selecionando Alunos Matriculados							+

SELECT a.NOME, COUNT(m.ID) AS Qtd_Matricula FROM ALUNO a 
JOIN MATRICULA m ON m.ALUNO_ID = a.ID 
GROUP BY a.NOME 											;

-- Selecionando Alunos Matriculados e Não Matriculados		+

SELECT a.NOME, COUNT(m.ID) AS Qtd_Matricula FROM ALUNO a 
LEFT JOIN MATRICULA m ON m.ALUNO_ID = a.ID 
GROUP BY a.NOME 											;

-- Subquery no lugar do JOIN								+

SELECT a.NOME, 
(SELECT COUNT(m.ID) FROM MATRICULA m WHERE m.ALUNO_ID = a.ID) 
AS Respostas FROM ALUNO a  									;

-- Juntando Queries respostas e matriculas					+

SELECT a.NOME,
(SELECT COUNT(r.ID) FROM RESPOSTA r WHERE r.ALUNO_ID = a.ID)
AS Qtd_RESPOSTA 
FROM ALUNO a 												;

SELECT a.NOME,
(SELECT COUNT(r.ID) FROM RESPOSTA r WHERE r.ALUNO_ID = a.ID)
AS Qtd_Resposta,
(SELECT COUNT(m.ID) FROM MATRICULA m WHERE m.ALUNO_ID = a.ID)
AS Qtd_Matricula
FROM ALUNO a												;

-- Buscando o mesmo resultado com LEFT JOIN					+

SELECT a.NOME, r.ID AS Qtd_Respostas, m.ID AS Qtd_Matriculas
FROM ALUNO a 
LEFT JOIN RESPOSTA r ON r.ALUNO_ID = a.ID
LEFT JOIN MATRICULA m ON m.ALUNO_ID = a.ID 					;

-- adicionando o DISTINCT para Filtrar o resultado			+

SELECT a.NOME, 
COUNT(DISTINCT r.ID) AS Qtd_Respostas, 
COUNT(DISTINCT m.id) AS Qtd_Matriculas
FROM ALUNO a 
LEFT JOIN RESPOSTA r ON r.ALUNO_ID = a.ID 
LEFT JOIN MATRICULA m ON m.ALUNO_ID = a.ID
GROUP BY a.NOME 											;

-- --------------------------------------------------------	+


-- MUITOS ALUNOS E O LIMIT

-- Selecionando alunos e ordenando por nome.				+

SELECT a.NOME FROM ALUNO a 									;

SELECT a.NOME FROM ALUNO a ORDER BY a.NOME 					;

-- Verificando Alunos cadastrados							;

SELECT COUNT(*) AS QTD_ALUNO FROM ALUNO a 					; 

-- Limitando a quantidade de registros a aparecer			+

SELECT a.NOME FROM ALUNO a 
ORDER BY a.NOME 
LIMIT 5														;

-- Limitando a partir de uma determinada posição			+

SELECT a.NOME FROM ALUNO a 
ORDER BY a.NOME
LIMIT 5,5													;

/* A seleção é feita a partir do 5 registro no caso do		+
 * 6 até o 10 registro */

SELECT a.NOME FROM ALUNO a 
ORDER BY a.NOME
LIMIT 0,5													;

/* Neste caso do 1 até o 5 Registro, sendo que o primeiro
 * valor se refere a primeira posição a começar a contagem
 * e o segundo a quantidade a retornar */

-- Os Dois exemplos a baixo retorna a mesmo resultado		+

SELECT a.NOME FROM ALUNO a 
ORDER BY a.NOME 
LIMIT 10													;

SELECT a.NOME FROM ALUNO a 
ORDER BY a.NOME
LIMIT 0,10													;

-- --------------------------------------------------------	+





