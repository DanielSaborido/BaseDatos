--Tablas EMPLE y DEPART
--1 Seleccionar de la tabla EMPLE, aquellas filas cuyo APELLIDO empiece por "A" y el OFICIO 
--tenga una "E" en cualquier posición.
SELECT *
 FROM EMPLE
 WHERE APELLIDO LIKE 'A%' AND OFICIO LIKE '%E%';

--2 Seleccionar el APELLIDO, OFICIO y LOCALIDAD de los empleados que son ANALISTAS.
SELECT APELLIDO,OFICIO,LOC
 FROM EMPLE, DEPART
 WHERE (EMPLE.DEPT_NO = DEPART.DEPT_NO) AND (OFICIO = 'ANALISTA');

--3 Mostrar los empleados (nombre, oficio, salario y fecha de alta) que desempeñen 
--el mismo oficio que "JIMENEZ" o que tengan un salario mayor o igual que "FERNANDEZ".
SELECT APELLIDO AS NOMBRE, OFICIO, SALARIO, FECHA_ALT
 FROM EMPLE
 WHERE OFICIO = (SELECT OFICIO
				  FROM EMPLE
				  WHERE APELLIDO = 'JIMENEZ') OR SALARIO >= (SELECT SALARIO
															  FROM EMPLE
															  WHERE APELLIDO = 'FERNANDEZ');

--4 Mostrar en pantalla el nombre, oficio y salario de los empleados del departamento 
--de "FERNANDEZ" que tengan su mismo salario.
SELECT APELLIDO AS NOMBRE, OFICIO
 FROM EMPLE
 WHERE DEPT_NO = (SELECT DEPT_NO
				  FROM EMPLE
				  WHERE APELLIDO = 'FERNANDEZ') AND SALARIO = (SELECT SALARIO
															    FROM EMPLE
															    WHERE APELLIDO = 'FERNANDEZ');
'MANERA ALTERNATIVA'
SELECT APELLIDO AS NOMBRE, OFICIO
 FROM EMPLE
 WHERE (DEPT_NO,SALARIO) = (SELECT DEPT_NO,SALARIO
							  FROM EMPLE
							  WHERE APELLIDO = 'FERNANDEZ');

--5 Mostrar los nombres y oficios de los empleados que tienen el mismo trabajo que "JIMENEZ".
SELECT APELLIDO AS NOMBRE, OFICIO, SALARIO
 FROM EMPLE
 WHERE OFICIO = (SELECT OFICIO
				  FROM EMPLE
				  WHERE APELLIDO = 'JIMENEZ');

--Tabla LIBRERIA
--1 Visualizar el tema, estante y ejemplares de las filas de LIBRERIA con ejemplares comprendidos entre 8 y 15
SELECT *
  FROM LIBRERIA
  WHERE EJEMPLARES BETWEEN 8 AND 15;

--2 Visualizar las columnas tema, estante y ejemplares de las filas cuyo ESTANTE no esté comprendido entre la "B" y la "D"
SELECT *
  FROM LIBRERIA
  WHERE ESTANTE NOT BETWEEN 'B' AND 'D';

--3 Visualizar con una única orden SELECT (subconsulta) todos los temas de LIBRERIA cuyo 
--numero de ejemplares sea inferior a los que hay en "Medicina".
SELECT TEMA
 FROM LIBRERIA
 WHERE EJEMPLARES < (SELECT EJEMPLARES
                      FROM LIBRERIA
					  WHERE TEMA = 'Medicina');

--4 Visualizar los temas de LIBRERIA cuyo número de ejemplares no esté entre 15 y 20, ambos incluidos.
SELECT TEMA
 FROM LIBRERIA
 WHERE EJEMPLARES NOT BETWEEN 15 AND 20;

--Tablas ALUMNOS, ASIGNATURAS, y NOTAS
--1 Visualizar todas las ASIGNATURAS que contengan tres letras "o" en su nombre y tengan alumnos matriculados en "Madrid".
SELECT NOMBRE AS ASIGNATURAS
 FROM ALUMNOS,ASIGNATURAS,NOTAS
 WHERE (NOMBRE LIKE '%o%o%o%') AND (ALUMNOS.DNI = NOTAS.DNI) AND (NOTAS.COD = ASIGNATURAS.COD) AND (POBLA = 'Madrid');
 
--2 Visualizar los nombres de los alumnos que tengan una nota entre 7 y 8 en la asignatura "FOL".
SELECT APENOM AS ALUMNO
 FROM ALUMNOS,ASIGNATURAS,NOTAS
 WHERE (ALUMNOS.DNI = NOTAS.DNI) AND (NOTAS.COD = ASIGNATURAS.COD) AND (NOTA BETWEEN 7 AND 8) AND (NOMBRE = 'FOL');

--3 Mostrar los nombres de los alumnos de Madrid que tengan alguna asignatura suspendida.
SELECT APENOM AS ALUMNO
 FROM ALUMNOS,NOTAS
 WHERE (ALUMNOS.DNI = NOTAS.DNI) AND (POBLA = 'Madrid') AND (NOTA < 5);

--4 Mostrar los nombres de las asignaturas que no tengan suspensos.
SELECT DISTINCT NOMBRE AS ASIGNATURAS_SIN_SUSPENSOS
 FROM ASIGNATURAS
 WHERE NOT EXISTS (SELECT *
					FROM NOTAS
					WHERE ASIGNATURAS.COD = NOTAS.COD AND NOTAS.NOTA < 5);

--5 Mostrar los nombres de los alumnos que tengan la misma nota que tiene "Diaz Fernandez, Maria" 
--en "FOL" en alguna asignatura
SELECT DISTINCT APENOM AS ALUMNO
 FROM ALUMNOS,ASIGNATURAS,NOTAS
 WHERE (ALUMNOS.DNI = NOTAS.DNI) AND (NOTAS.COD = ASIGNATURAS.COD) AND (NOTA = (SELECT NOTA
																				  FROM ALUMNOS,ASIGNATURAS,NOTAS
																				  WHERE (ALUMNOS.DNI = NOTAS.DNI) AND 
																				        (NOTAS.COD = ASIGNATURAS.COD) AND 
																						(APENOM = 'Diaz Fernandez, Maria') AND 
																						(NOMBRE = 'FOL')));

----------------------------------------------[ FIN DE LAS ACTIVIDADES DATOS 1 ]----------------------------------------------