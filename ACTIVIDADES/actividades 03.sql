--1.Visualizar los departamentos en los que el salario medio es mayor o igual que la media de todos los salarios.
SELECT DEPT_NO, AVG(SALARIO) "Sal medio"
  FROM EMPLE
GROUP BY DEPT_NO
HAVING AVG(SALARIO) >= (SELECT  AVG(SALARIO) 
						  FROM EMPLE);

--2.A partir de la tabla EMPLE, visualizar el nº de vendedores del departamento 'VENTAS'.
SELECT COUNT(*)
	FROM EMPLE
	WHERE DEPT_NO=(SELECT DEPT_NO 
					   FROM DEPART 
					  WHERE UPPER(DNOMBRE)='VENTAS')
	  AND UPPER(OFICIO)='VENDEDOR';

--3.Partiendo de la tabla EMPLE, visualizar por cada oficio de los empleados
--del departamento 'VENTAS' la suma de sus salarios.
SELECT COUNT(*)
  FROM EMPLE E, DEPART D
 WHERE E.DEPT_NO=D.DEPT_NO
   AND UPPER(DNOMBRE)='VENTAS'
   AND UPPER(OFICIO)='VENDEDOR';

--4.Seleccionar aquellos apellidos de la tabla EMPLE cuyo salario sea igual a la media de los salarios en su departamento.
SELECT OFICIO, SUM(SALARIO)
	FROM EMPLE
	WHERE DEPT_NO=(SELECT DEPT_NO 
	                   FROM DEPART
					   WHERE DNOMBRE='VENTAS')
	GROUP BY OFICIO;

--5.A partir de la tabla EMPLE, visualizar el nº de empleados de cada departamento cuyo oficio sea 'EMPLEADO'.
SELECT DEPT_NO, COUNT(EMP_NO)
	FROM EMPLE
	WHERE OFICIO='EMPLEADO'
	GROUP BY DEPT_NO;

--6.Desde la tabla EMPLE, visualizar el departamento que tenga más empleados cuyo oficio sea 'EMPLEADO'.
SELECT DEPT_NO, COUNT(*)
	FROM EMPLE
	WHERE OFICIO='EMPLEADO'
	GROUP BY DEPT_NO
	HAVING COUNT(*)=(SELECT MAX(COUNT(*))
						FROM EMPLE
						WHERE OFICIO='EMPLEADO'
						GROUP BY DEPT_NO);

--7.A partir de las tablas EMPLE y DEPART, visualizar el código y el nombre del departamento
--que tenga más empleados cuyo oficio sea 'EMPLEADO'.
SELECT DEPT_NO,DNOMBRE
	FROM DEPART
	WHERE DEPT_NO=(SELECT DEPT_NO 
					FROM EMPLE
					WHERE OFICIO='EMPLEADO'
					GROUP BY DEPT_NO
					HAVING COUNT(*)=(SELECT MAX(COUNT(*))
										FROM EMPLE
										WHERE OFICIO='EMPLEADO'
										GROUP BY DEPT_NO));

--8.Buscar los departamentos que tienen más de dos personas trabajando en el mismo oficio.
SELECT DEPT_NO,COUNT(*)
	FROM EMPLE
	GROUP BY DEPT_NO,OFICIO
	HAVING COUNT(*)>2;

--9.Dada la tabla LIBRERIA, visualizar por cada estante la suma de los ejemplares.
SELECT ESTANTE, SUM(EJEMPLARES)
	FROM LIBRERIA
	GROUP BY ESTANTE
	ORDER BY ESTANTE;

--10.Visualizar el estante con más ejemplares de la tabla LIBRERIA.
SELECT ESTANTE,SUM(EJEMPLARES)
	FROM LIBRERIA
	GROUP BY ESTANTE
	HAVING SUM(EJEMPLARES)=(SELECT MAX(SUM(EJEMPLARES))
								FROM LIBRERIA
								GROUP BY ESTANTE);

--11.Visualizar los diferentes estantes de la tabla LIBRERIA ordenados descendentemente por estante.
SELECT ESTANTE
	FROM LIBRERIA
	ORDER BY ESTANTE;

--12.Listar cuantos temas tiene cada estante.
SELECT ESTANTE,COUNT(TEMA)
	FROM LIBRERIA
	GROUP BY ESTANTE
	ORDER BY ESTANTE;

--13.Visualizar los estantes que tengan tres temas.
SELECT ESTANTE,COUNT(TEMA)
	FROM LIBRERIA
	GROUP BY ESTANTE
	HAVING COUNT(TEMA)=3
	ORDER BY ESTANTE;