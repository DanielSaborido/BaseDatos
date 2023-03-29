------------------------------------
-- TABLAS ALUM, NUEVOS y ANTIGUOS --
------------------------------------
-- 1.- Dadas las tablas ALUM y NUEVOS, 
--insertar en la tabla ALUM los alumnos nuevos. 
SQL> 
INSERT INTO ALUM
	(SELECT * FROM NUEVOS  
	  MINUS 
	 SELECT * FROM ALUM);

2 filas creadas.


-------------------------------
-- 2.- Borrar de la tabla ALUM los alumnos de la tabla ANTIGUOS.
SQL> 
DELETE FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);

2 filas borradas.
---------------------------
-- TABLAS EMPLE y DEPART --
---------------------------
-- 3.- Insertar un empleado de apellido 'SAAVEDRA' con n�mero 2000. 
-- La fecha de alta ser� la actual del sistema, 
-- el SALARIO el mismo del empleado 'SALA' m�s el 20% 
-- y el resto de datos igual que 'SALA'.

SQL> 
INSERT INTO EMPLE 
	SELECT 2000, 'SAAVEDRA', OFICIO, DIR, SYSDATE, 
	SALARIO+SALARIO*0.2,COMISION, DEPT_NO
	FROM EMPLE
	WHERE APELLIDO='SALA';

1 fila creada.


-------------------------------
-- 4.- Modificar el n�mero de departamento de 'SAAVEDRA'. 
--El nuevo departamento ser� aquel donde hay m�s empleados 
--cuyo OFICIO se 'EMPLEADO'. 

SQL> 
UPDATE EMPLE
	SET DEPT_NO= (SELECT DEPT_NO 
					FROM EMPLE 
					WHERE OFICIO='EMPLEADO'
					GROUP BY DEPT_NO
					HAVING COUNT(*) = (SELECT MAX(COUNT(*)) 
										FROM EMPLE
										WHERE OFICIO='EMPLEADO'
										GROUP BY DEPT_NO))
	WHERE APELLIDO ='SAAVEDRA';

1 fila actualizada.


SELECT DEPT_NO,COUNT(*)
  FROM EMPLE
 WHERE OFICIO='EMPLEADO'
GROUP BY DEPT_NO;

SELECT MAX(COUNT(*))
  FROM EMPLE
 WHERE OFICIO='EMPLEADO'
GROUP BY DEPT_NO;

-------------------------------
-- 5.- Borrar todos los departamentos de la tabla DEPART 
--para los cuales no existan empleados en EMPLE. 

 
SQL>  
DELETE FROM DEPART
	WHERE DEPT_NO IN (SELECT DEPT_NO FROM DEPART
						MINUS
						SELECT DEPT_NO FROM EMPLE);
-- De otra manera:						
DELETE FROM DEPART
	WHERE DEPT_NO NOT IN (SELECT DEPT_NO FROM EMPLE);						

1 fila borrada.
-------------------------------------------
-- TABLAS PERSONAL, PROFESORES y CENTROS --
-------------------------------------------
-- 6.- Modificar el n� de plazas de la tabla CENTROS 
-- con un valor igual a la mitad en aquellos centros 
-- con menos de dos profesores.











SQL> 
UPDATE CENTROS
	SET NUM_PLAZAS=NUM_PLAZAS/2
	WHERE COD_CENTRO IN (SELECT COD_CENTRO 
							FROM PROFESORES 
							GROUP BY COD_CENTRO
							HAVING COUNT(*) < 2);

--Esta solucion al jercicio no tiene en cuenta los centros que 
-- no tienen profesores (cod_centro= 50).

-- Para solucionar eso podemos hacer un outer join tal y como se muestra:

UPDATE CENTROS
	SET NUM_PLAZAS=NUM_PLAZAS/2
	WHERE COD_CENTRO IN (SELECT CENTROS.COD_CENTRO 
							FROM PROFESORES,CENTROS 
							WHERE PROFESORES.COD_CENTRO(+)= CENTROS.COD_CENTRO
							GROUP BY CENTROS.COD_CENTRO
							HAVING COUNT(*) < 2);

-- O lo que es equivalente:
UPDATE CENTROS
	SET NUM_PLAZAS=NUM_PLAZAS/2
	WHERE COD_CENTRO IN ( SELECT CENTROS.COD_CENTRO 
							FROM PROFESORES RIGHT OUTER JOIN CENTROS 
							ON PROFESORES.COD_CENTRO = CENTROS.COD_CENTRO 
							GROUP BY CENTROS.COD_CENTRO
							HAVING COUNT(*) < 2);
                     
-------------------------------------------
-- 7.- Eliminar los centros que no tengan personal.
SQL> 
DELETE CENTROS
	WHERE COD_CENTRO IN (SELECT COD_CENTRO FROM CENTROS 
							MINUS 
							SELECT COD_CENTRO FROM PERSONAL);
-- de otra manera
DELETE CENTROS
	WHERE COD_CENTRO NOT IN (SELECT COD_CENTRO FROM PERSONAL); 

1 fila borrada.

-------------------------------------------
-- 8.- Añadir un nuevo profesor en el centro 
--o en los centros cuyo nº de administrativos 
-- sea 1 en la especialidad 'IDIOMA', 
--con DNI 8790055 y de nombre 'Clara Salas'.

SQL> 
INSERT INTO PROFESORES
	SELECT DISTINCT cod_centro, 8790055,'Salas, Clara', 'IDIOMA'
		FROM PERSONAL
		WHERE COD_CENTRO IN	(SELECT COD_CENTRO 
								FROM PERSONAL 
								WHERE FUNCION='ADMINISTRATIVO' 
								GROUP BY COD_CENTRO
								HAVING COUNT(*) = 1);		

2 filas creadas.

-- El DISTINCT es necesario en este caso porque si no, en lugar
-- de insertar un unico profesor por centro que cumple esa condicion 
-- (nº de administrativos=1)
-- insertariamos tantos profesores como filas haya actualmente en 
-- la tabla personal que cumplen esa condición. 

-------------------------------------------
-- 9.- Borrar el personal que está en centros de menos de 300 plazas 
--y con menos de dos profesores.

SQL> 
DELETE PERSONAL
	WHERE COD_CENTRO IN (SELECT COD_CENTRO 
							FROM CENTROS 
							WHERE NUM_PLAZAS<300)
	AND COD_CENTRO IN (SELECT COD_CENTRO 
						FROM PROFESORES 
						GROUP BY COD_CENTRO 
						HAVING COUNT(*) < 2);

2 filas borradas.

-------------------------------------------
-- 10.- Borrar a los profesores que están en la tabla PROFESORES 
--y no están en la tabla PERSONAL.

SQL> 
DELETE PROFESORES
	WHERE DNI NOT IN (SELECT DNI FROM PERSONAL);

1 fila borrada.