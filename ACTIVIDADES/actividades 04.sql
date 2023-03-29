--Tablas PROFESORES, PERSONAL y CENTROS--
--1 A partir de las tablas PROFESORES y CENTROS, realizar una consulta en la que aparezcan por cada centro
--y cada especialidad el nº de profesores que hay. Si el centro no tiene profesores debe aparecer un 0
--en la columna nº de profesores (OUTER JOIN).
SELECT NOMBRE, ESPECIALIDAD, COUNT(DNI)
	FROM PROFESORES, CENTROS
	WHERE PROFESORES.COD_CENTRO(+)=CENTROS.COD_CENTRO
	GROUP BY NOMBRE, ESPECIALIDAD;
	
SELECT NOMBRE, ESPECIALIDAD, COUNT(DNI)
	FROM PROFESORES FULL JOIN CENTROS
	ON PROFESORES.COD_CENTRO=CENTROS.COD_CENTRO
	GROUP BY NOMBRE, ESPECIALIDAD;

--2 A partir de las tablas PERSONAL y CENTROS,obtener por cada centro el código, nombre y nº de empleados.
--Si el centro carece de empleados, igual que en la consulta anterior (OUTER JOIN).
SELECT COD_CENTRO, NOMBRE, COUNT(DNI)
	FROM PERSONAL, CENTROS
	WHERE PERSONAL.COD_CENTRO(+)=CENTROS.COD_CENTRO
	GROUP BY NOMBRE;
	
SELECT COD_CENTRO, NOMBRE, COUNT(DNI)
	FROM PERSONAL FULL JOIN CENTROS
	ON PERSONAL.COD_CENTRO=CENTROS.COD_CENTRO
	GROUP BY NOMBRE;

--3 A partir de la tabla PROFESORES, obtener la especialidad con menos profesores.
SELECT ESPECIALIDAD, COUNT(*) NUM_PROFESORES
	FROM PROFESORES
	GROUP BY ESPECIALIDAD
	HAVING COUNT(ESPECIALIDAD)=(SELECT MIN(COUNT(ESPECIALIDAD))
									FROM PROFESORES
									GROUP BY ESPECIALIDAD);

--4 A partir de la tabla PERSONAL, obtener por cada función el nº de empleados.
SELECT FUNCION, COUNT(APELLIDOS)
	FROM PERSONAL
	GROUP BY FUNCION;

--Tablas ALUM, ANTIGUOS y NUEVOS--
--5 Visualizar los nombres de los alumnos de la tabla ALUM que aparezcan en alguna de estas tablas: ANTIGUOS y NUEVOS.
SELECT NOMBRE 
	FROM ALUM
	INTERSECT
	(SELECT NOMBRE 
	  FROM ANTIGUOS
	  UNION
	  SELECT NOMBRE 
	  FROM NUEVOS);

--6 Realizar la consulta anterior de otras maneras.
SELECT ALUM.NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE 
						FROM ANTIGUOS) OR NOMBRE IN (SELECT NOMBRE 
														FROM NUEVOS);

--7 Visualizar los nombres de los alumnos de la tabla ALUM que aparezcan en la tabla ANTIGUOS y en la tabla NUEVOS.
SELECT ALUM.NOMBRE
	FROM ALUM
	INNER JOIN ANTIGUOS ON ALUM.NOMBRE = ANTIGUOS.NOMBRE
	INNER JOIN NUEVOS ON ALUM.NOMBRE = NUEVOS.NOMBRE;

--8 Realizar la consulta anterior de otras maneras.
SELECT NOMBRE
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE 
						FROM ANTIGUOS) AND NOMBRE IN (SELECT NOMBRE 
														FROM NUEVOS);

--9 Visualizar los nombres de los alumnos de la tabla ALUM que no estén en la tabla ANTIGUOS ni en la tabla NUEVOS.
SELECT NOMBRE 
	FROM ALUM
	MINUS
	(SELECT NOMBRE 
	  FROM ANTIGUOS
	  UNION
	  SELECT NOMBRE 
	  FROM NUEVOS);