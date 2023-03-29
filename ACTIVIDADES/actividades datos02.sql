--Ejercicios-SQL 02
--1 ¿Cuál sería la salida al ejecutar estas funciones?
	SELECT ABS(146),ABS(-30)
	FROM DUAL;
	-- 146, 30

	SELECT CEIL(2),CEIL(1.3),CEIL(-2.3),CEIL(-2)
	FROM DUAL;
	-- 2 , 2, -2, -2

	SELECT FLOOR(-2),FLOOR(-2.3),FLOOR(2),FLOOR(1.3)
	FROM DUAL;
	-- -2, -3 , 2, 1

	SELECT MOD(22,23),MOD(10,3)
	FROM DUAL;
	-- 22, 1

	SELECT POWER(10,0),POWER(3,2),POWER(3,-1)
	FROM DUAL;
	-- 1, 9, 0.3333333333

	SELECT ROUND(33.67),ROUND(-33.67,2),ROUND(-33.67,-2),ROUND(-33.27,1),ROUND(-33.27,-1)
	FROM DUAL;
	-- 34, -33.67, 0, -33.3, -30

	SELECT TRUNC(67.232),TRUNC(67.232,-2),TRUNC(67.232,2),TRUNC(67.58,1)
	FROM DUAL;
	-- 67, 0, 67.23, 67.5

--2 A partir de la tabla EMPLE, visualizar cuantos apellidos de empleados empiezan por la letra 'A'.
	SELECT APELLIDO, COUNT (APELLIDO)
	FROM EMPLE
	WHERE UPPER(APELLIDO) LIKE 'A%';

--3 Dada la tabla EMPLE, obtén el sueldo medio, el nº de comisiones no nulas, el máximo sueldo y el mínimo
-- sueldo de los empleados del departamento 30. Emplear el formato adecuado para la salida de las cantidades numéricas.
	SELECT TO_CHAR(TRUNC((AVG (SALARIO)),2),'999G999D99'),COUNT(COMISION),TO_CHAR(MAX(SALARIO),'999G999D99'),TO_CHAR(MIN(SALARIO),'999G999D99')
	FROM EMPLE
	WHERE DEPT_NO=30;

--4 Contar los temas de LIBRERIA cuyo tema tenga, por lo menos una 'a'.
	SELECT COUNT (TEMA)
	FROM LIBRERIA
	WHERE LOWER (TEMA) LIKE '%a%';

--5 Visualiza los temas con mayor número de ejemplares de la tabla LIBRERIA y que tengan, al menos,
-- una 'e' (pueden ser un tema o varios).
	SELECT TEMA
	FROM LIBRERIA
	WHERE LOWER(TEMA) LIKE '%e%' AND (EJEMPLARES = (SELECT MAX(EJEMPLARES)
														FROM LIBRERIA
														WHERE LOWER(TEMA) LIKE '%e%'));

--6 Visualiza el nº de estantes diferentes que hay en la tabla LIBRERIA.
	SELECT COUNT (DISTINCT ESTANTE)
	FROM LIBRERIA;

--7 Visualiza el nº de estantes distintos que hay en la tabla LIBRERIA de aquellos temas que contienen, al menos, una 'e'.
	SELECT COUNT (DISTINCT ESTANTE)
	FROM LIBRERIA
	WHERE LOWER(TEMA) LIKE '%e%';

--8 Dada la tabla MISTEXTOS, ¿qué sentencia SELECT se debe ejecutar para tener este resultado?
'RESULTADO
----------------------------------------
METODOLOGÍA DE LA PROGRAMACIÓN-^-^-^-^-^
INFORMÁTICA BÁSICA-^-^-^-^-^-^-^-^-^-^-^
SISTEMAS OPERATIVOS-^-^-^-^-^-^-^-^-^-^-
SISTEMAS DIGITALES-^-^-^-^-^-^-^-^-^-^-^
MANUAL DE C-^-^-^-^-^-^-^-^-^-^-^-^-^-^-'

	SELECT RPAD((REPLACE(REPLACE(TITULO,'"'),'.')),40,'-^') AS RESULTADO
	FROM MISTEXTOS;

--9 Visualiza los títulos de la tabla MISTEXTOS sin los caracteres punto y comillas, y en minúsculas
	SELECT REPLACE(REPLACE(LOWER(TITULO),'"'),'.')
	FROM MISTEXTOS;
	
	SELECT LTRIM(RTRIM(LOWER(TITULO),'."'),'"')
	FROM MISTEXTOS;

--10 Dada la tabla LIBROS, escribe la sentencia SELECT que visualice dos columnas, una con el AUTOR y 
--otra con el apellido del autor.
	SELECT AUTOR, SUBSTR(AUTOR,1,INSTR(AUTOR,',')-1)
	FROM LIBROS;

--11 Escribe la sentencia SELECT que visualice dos columnas, una con el AUTOR y otra columna con el nombre del autor 
--(sin el apellido) de la tabla LIBROS.
	SELECT AUTOR, SUBSTR(AUTOR,(INSTR(AUTOR,', ')+2))
	FROM LIBROS;

--12 A partir de la tabla LIBROS, realiza una consulta que visualice en una columna, primero el nombre del autor y,
-- luego, el apellido.
	SELECT (SUBSTR(AUTOR,(INSTR(AUTOR,', ')+2)||' '||SUBSTR(AUTOR,1,INSTR(AUTOR,',')-1))) AS NOMBRE
	FROM LIBROS;

--13 A partir de la tabla LIBROS, realiza una consulta que aparezcan los títulos ordenados por su nº de caracteres.
	SELECT TITULO
	FROM LIBROS
	ORDER BY LENGTH(TITULO);

--14 A partir de la tabla NACIMIENTOS, realiza una consulta que obtenga las columnas NOMBRE, FECHANAC, 
--FECHA_FORMATEADA donde FECHA_FORMATEADA tiene el siguiente formato: "Nació el 12 de mayo de 1982".
	SELECT NOMBRE, FECHANAC, TO_CHAR(FECHANAC, '"Nacio el "DD" de "month" de "YYYY') AS FECHA_FORMATEADA
	FROM NACIMIENTOS;

--15 Dada la tabla LIBRERIA, haz una consulta que visualice el tema, el último carácter del tema 
--que no sea blanco y el nº de caracteres de tema (sin contar los blancos de la derecha) ordenados por tema.
	SELECT TEMA, SUBSTR(RTRIM(TEMA),-1), LENGTH(RTRIM(TEMA))
	FROM LIBRERIA
	ORDER BY TEMA;
