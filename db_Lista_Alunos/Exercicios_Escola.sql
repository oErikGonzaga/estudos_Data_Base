CREATE DATABASE ESCOLA										;
USE ESCOLA													;

SHOW TABLES													;

SELECT * FROM ALUNO a 										;
SELECT * FROM CURSO c  										;
SELECT * FROM MATRICULA m									;
SELECT * FROM SECAO s  										;
SELECT * FROM EXERCICIO e									;
SELECT * FROM RESPOSTA r									;
SELECT * FROM NOTA n  										;

-- Retornando cursos que não possuem matricula				+

SELECT c.NOME FROM CURSO c 
WHERE NOT EXISTS (SELECT m.ID 
FROM MATRICULA m  WHERE m.CURSO_ID = c.ID)					;	

-- Verificando Alunos não matriculados.						+

SELECT a.NOME, c.NOME FROM ALUNO a 
JOIN CURSO c  ON c.ID = a.id
WHERE NOT EXISTS (SELECT m.ALUNO_ID
FROM MATRICULA m  WHERE m.ALUNO_ID = a.ID)					;

-- Buscando Alunos que não tiveram 							+
-- matriculas no 45 ultimos dias							+

SELECT DAY(DATA) AS DIA, MONTH(DATA) AS MES, YEAR(DATA) 
AS ANO FROM MATRICULA m WHERE TIPO LIKE 'PAGA%' 
ORDER BY ANO, MES, DIA										;

SELECT a.NOME, c.NOME FROM ALUNO a
JOIN CURSO c  ON c.ID = a.ID
WHERE EXISTS (SELECT * FROM MATRICULA m2
WHERE DATA BETWEEN '2015-06-16' AND '2015-07-21')			;

-- Exibindo a média das notas por curso						+

SELECT c.NOME, AVG(n.nota) FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID
GROUP BY c.NOME 											;

SELECT c.NOME, AVG(n.nota) AS Nota FROM NOTA n 
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID
JOIN ALUNO a ON a.NOME LIKE '%SILVA' OR  
a.NOME LIKE '%SANTOS'
GROUP BY c.NOME 											;

SELECT a.nome FROM ALUNO a WHERE 
a.NOME LIKE '%SILVA' AND 
a.NOME LIKE '%SANTOS';


SELECT COUNT(*) AS Contagem, e.PERGUNTA 
FROM RESPOSTA r 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
GROUP BY r.EXERCICIO_ID
ORDER BY COUNT(r.EXERCICIO_ID)  							;


-- --------------------------------------------------------	+


-- 1 - Diferença entre o HAVING e WHERE SQL

	-- WHERE adiciona filtros as colunas					+
	-- HAVING adiciona filtros para funções de agregação	+


-- 2 - Devolvendo média de alunos dos cursos, 

SELECT c.NOME, a.NOME, AVG(n.NOTA) AS Média FROM NOTA n 	
JOIN RESPOSTA r 	ON r.ID = n.RESPOSTA_ID 
JOIN EXERCICIO e 	ON e.ID  = r.EXERCICIO_ID 
JOIN SECAO s 		ON s.ID = e.SECAO_ID 
JOIN CURSO c 		ON c.ID = s.CURSO_ID 
JOIN ALUNO a 		ON a.ID = r.ALUNO_ID 
GROUP BY a.NOME, c.NOME 
HAVING AVG(n.NOTA) < 5										; 

-- 3 - Exibindo Cursos e qtd de matriculas maiores que 1 	+

SELECT COUNT(m.ID) 	AS Qtd, c.NOME FROM MATRICULA m  
JOIN CURSO c 		ON c.ID = m.CURSO_ID 
JOIN ALUNO a 		ON a.ID = c.ID 
GROUP BY c.NOME 
HAVING COUNT(m.ID) > 1										; 

-- 4 - Exibindo o nome do curso e seções maiores que 3		+

SELECT COUNT(s.ID) 	AS Qtd, c.NOME 	FROM SECAO s  
JOIN CURSO c 		ON c.ID = s.CURSO_ID
GROUP BY c.NOME
HAVING COUNT(s.ID)	> 3										; 



-- --------------------------------------------------------	+

-- 1 - Destinguindo CURSOS para que não repetição			+

SELECT DISTINCT c.NOME FROM CURSO c 						;


-- 2 - Qtd. de Matriculas de Cursos, FIltrados por PF e PJ	+

SELECT COUNT(m.ID) AS Qtd, c.NOME FROM MATRICULA m
JOIN CURSO c ON c.ID = m.CURSO_ID 
JOIN ALUNO a ON a.ID = c.ID
WHERE m.TIPO IN ('PAGA_PF','PAGA_PJ')
GROUP BY c.NOME 											;


-- 3 - Perguntas e Qtd.de Resposta de cursos com ID 1 e 3	+

SELECT COUNT(r.ID) AS QTD_R, e.PERGUNTA FROM RESPOSTA r 
JOIN EXERCICIO e ON e.ID = r.EXERCICIO_ID 
JOIN SECAO s ON s.ID = e.SECAO_ID 
JOIN CURSO c ON c.ID = s.CURSO_ID
WHERE c.ID IN (1,3) GROUP BY e.PERGUNTA 					;


-- --------------------------------------------------------	+


-- 1 - Notas por Aluno com Md.Aluno, Md.Geral e Diferença 	+

SELECT a.NOME, c.NOME, AVG(n.NOTA) AS Media_Alunos,
(SELECT AVG(n.NOTA) FROM NOTA n) AS Média_Geral,
AVG(n.NOTA) - (SELECT AVG(n.NOTA) FROM NOTA n) AS Diferença
FROM NOTA n  
JOIN RESPOSTA r ON n.RESPOSTA_ID = r.ID 
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN SECAO s ON e.SECAO_ID = s.ID 
JOIN CURSO c ON s.CURSO_ID = c.ID 
JOIN ALUNO a ON r.ALUNO_ID = a.ID 
GROUP BY a.NOME, c.NOME 									;

/* 2 - Qual problema de Subqueries?							+
Ao operações aritiméticas em uma subquery só podemos 
faze-lo em uma linha */										

-- 3 - Qtd. de Matriculas por Curso

SELECT c.NOME, COUNT(m.ID) AS MATRICULAS_CURSO, 
(SELECT COUNT(m.ID) FROM MATRICULA m) AS MATRICULAS_TOTAIS,
COUNT(m.ID) / (SELECT COUNT(m.ID) FROM MATRICULA m)
AS DIVISAO FROM MATRICULA m JOIN CURSO c 
ON m.CURSO_ID = c.ID GROUP BY c.NOME 						;


-- --------------------------------------------------------	+


/* 1 - Exibindo alunos e respostas, mesmo que não tenham 	+
 * repondido */

SELECT a.NOME, r.RESPOSTA_DADA  FROM ALUNO a 
LEFT JOIN RESPOSTA r ON r.ALUNO_ID = a.ID
GROUP BY a.NOME, r.RESPOSTA_DADA  							;


SELECT a.NOME, r.RESPOSTA_DADA, e.PERGUNTA 
FROM ALUNO a 
LEFT JOIN RESPOSTA r ON r.ALUNO_ID = a.ID
LEFT JOIN EXERCICIO e ON e.ID = 1
GROUP BY a.NOME, r.RESPOSTA_DADA, e.PERGUNTA  				;


SELECT COUNT(a.ID), a.NOME, r.RESPOSTA_DADA 
FROM RESPOSTA r
JOIN EXERCICIO e ON r.EXERCICIO_ID = e.ID 
JOIN ALUNO a ON r.ALUNO_ID = a.ID
WHERE e.ID = 1
GROUP BY a.NOME, r.RESPOSTA_DADA 							;

/* 3- Diferença de JOIN para INNER JOIN?
 * Join faz um filtro exibindo somente registros que 
 * estão associados.
 * LEFT JOIN retorna registros da tabela a esquerda.		+
 */


-- --------------------------------------------------------	+


-- 1 - Retornando os 2 primeiros alunos da tabela			+

SELECT a.NOME FROM ALUNO a 
ORDER BY a.NOME 
LIMIT 2														;

-- OU 														+

SELECT a.NOME FROM ALUNO a 
ORDER BY a.NOME 
LIMIT 0,2													;

/* 2 - Devolvendo os 3 primeiros alunos com email que
 * terminal com ".com" 										+
 * 3 - Ordene por nome */

SELECT a.NOME, a.EMAIL FROM ALUNO a 
WHERE a.EMAIL LIKE '%.COM'
LIMIT 3														;

SELECT a.NOME, a.EMAIL FROM ALUNO a 
WHERE a.EMAIL LIKE '%.COM'
GROUP BY a.NOME, a.EMAIL 
LIMIT 0,2													;

-- Alunos com silva no nome									+

SELECT a.NOME FROM ALUNO a 
WHERE a.NOME LIKE '%SILVA%'
ORDER BY a.NOME 											;

-- --------------------------------------------------------	+



