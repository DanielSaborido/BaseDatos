EJEMPLO de Tarea Entrable y examen - TIPO A

Nombre: <Saborido Torres, Daniel>

************************************************************************
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\Ejemplo_Tarea_Entregable\ ":
	Ejemplo:	Si tu nombre es             Tomas Coronado Garcia
			    el fichero debe llamarse:   00TCG_Ej.sql
El numero que pones delante de tus iniciales debe ser el que aparece a continuación:

01	Acedo Castrillón, Javier	
02	Arrieta Soto, Ángel	
03	Baro López, Juan Ramón	
04	Bulpe Martínez, Sara	
05	Cabrera Perejón, Rafael Pedro	
06	Cortés Bernal, Natalia
07	Darner, Maurice Alejandro
08	Escobar Vidal, Manuel Ángel	
09	Fernandez Garrido, Adrián	
10	Flor Barrios, Jesús	
11	Fornell Periñan, Pablo	
12	Jiménez Cerpa, Ignacio	
13	López Jiménez, Erik	
14	Medina Rivero, Débora
15  Piñero Labrador, Alberto
16  Rodriguez Benítez, Guillermo
17  Saborido Torres, Daniel
18  Salado Morán, Luis
19  Salazar Ramos, Jose Alfonso
20  Sanchez Gonzalez, Juan José
21  Vela Chávez, Carlos	
 
-Pon tu nombre al ejercicio en la parte de arriba de este documento
- y lee atentamente todas las preguntas.

-Entra en "SQL Plus" con cualquier usuario. 

-Carga el script para el examen desde el fichero "Datos_Ejemplo_TE_Ex17.sql".

-Donde ponga "SQL>", copiarás las sentencias SQL que has utilizado.

-Donde ponga "Resultado:" copiarás el resultado que la consola SQL*Plus te devuelve.

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperación tendrás otra oportunidad.

-PUNTUACIÓN:  	0,625 puntos cada pregunta


************************************************************************
	Descripción de las tablas:
	==========================

CREATE TABLE PROFESORES(
  COD_PR			NUMBER(2)		PRIMARY KEY,
  DNI_PR			CHAR(9)			UNIQUE,
  NOMBRE_PR			VARCHAR2(25)	NOT NULL,
  ESPECIALIDAD_PR	VARCHAR2(15)	NOT NULL
);
CREATE TABLE CLASES(
  PROFESOR_CL		NUMBER(2),
  ASIGNATURA_CL		NUMBER(3),
  AULA_CL			NUMBER(2), 
  HORASSEM_CL		NUMBER(2), 
  PRIMARY KEY (PROFESOR_CL, ASIGNATURA_CL)
);
CREATE TABLE ASIGNATURAS(
  COD_AS		NUMBER(3)		PRIMARY KEY,
  NOMBRE_AS		VARCHAR2(35)	NOT NULL,
  HORAS_AS		NUMBER(3)		NOT NULL
);
CREATE TABLE ALUMNOS(
  COD_AL		NUMBER(2)	PRIMARY KEY,
  FECINC_AL		DATE,
  FECNAC_AL		DATE,
  DNI_AL		CHAR(9)			UNIQUE,
  NOMBRE_AL		VARCHAR2(25) 	NOT NULL,
  CIUDAD_AL		VARCHAR2(10) 	NOT NULL,
  TUTOR_AL		NUMBER(2),
  DELEGADO_AL	NUMBER(2)
  );
CREATE TABLE NOTAS(
  ALUMNO_NO		NUMBER(2),
  ASIGNATURA_NO	NUMBER(3),
  FECHA_NO		DATE,
  NOTA_NO		NUMBER(4,2),
  PRIMARY KEY (ALUMNO_NO, ASIGNATURA_NO, FECHA_NO)
  );

***************************************************************************************************************
 1.- Mostrar de cada alumno su nombre y apellidos (tal como están almacenados), 
 DNI y la edad que tenían cuando ingresaron.

 SQL>SELECT NOMBRE_AL, DNI_AL, TRUNC(MONTHS_BETWEEN( FECINC_AL, FECNAC_AL)/12)
	FROM ALUMNOS;

Resultado:

NOMBRE_AL                 DNI_AL    TRUNC(MONTHS_BETWEEN(FECINC_AL,FECNAC_AL)/12)
------------------------- --------- ---------------------------------------------
Arias Grillo, Jairo       55645991T                                            23
Arnaldos Valle, Javier    54652636D                                            34
Avila Ferrete, Raquel     71106202D                                            27
Cabrera Alava, Kilian     56646516D                                            24
Pires Barranco, Amador    51506642K                                            25
Calvo Jimenez, Alberto    55980648H                                            26
Camacho Lindsey, Daniel   64555339D                                            24
Pozo Martin, Ismael       37839343D                                            26
Rolo Vera, Luis Miguel    76138301V                                            30
Mendizabal Romero, Luis   67918627L                                            33
Gallego Carvajal, Juan    63453550T                                            42
Reina Ramirez, Joaquin    90676183D                                            27
Gata Masero, Carlos       22563618D                                            25

13 filas seleccionadas.

***************************************************************************************************************
 2.- Mostrar de cada profesor su nombre y apellidos en mayúsculas, 
 junto con la letra de su DNI.

 SQL>SELECT UPPER(NOMBRE_PR),SUBSTR(DNI_PR,9)
	FROM PROFESORES;

Resultado:

UPPER(NOMBRE_PR)          SUBS
------------------------- ----
DEL JUNCO SUAREZ, MALVINA D
MATITO LOZANO, CARMEN     D
TOSCANO FERNANDEZ, JUAN   D
VALVERDE GALLEGO, ENRIQUE K

***************************************************************************************************************
 3.- Mostrar nombre y apellidos de cada alumnos 
 junto con el nombre (SIN LOS APELLIDOS) de su tutor.
 
SQL>SELECT NOMBRE_AL,SUBSTR(NOMBRE_PR,INSTR(NOMBRE_PR,', ')+1)
	FROM ALUMNOS LEFT JOIN PROFESORES
	ON TUTOR_AL=COD_PR;

Resultado:

***************************************************************************************************************
 4.- Mostrar la nota media (CON DOS DECIMALES) 
 de la asignatura BASES DE DATOS.
 
SQL>SELECT TO_CHAR(AVG( NVL(NOTA_NO,0)), '99D99')
	FROM NOTAS, ASIGNATURAS
	WHERE COD_AS = ASIGNATURA_NO
		AND UPPER(NOMBRE_AS) LIKE 'BASES DE DATOS';

Resultado:

NOMBRE_AL                 SUBSTR(NOMBRE_PR,INSTR(NOMBRE_PR,',')+1)
------------------------- ------------------------------------------
Calvo Jimenez, Alberto     Malvina
Pires Barranco, Amador     Malvina
Cabrera Alava, Kilian      Malvina
Avila Ferrete, Raquel      Malvina
Arnaldos Valle, Javier     Malvina
Arias Grillo, Jairo        Malvina
Gata Masero, Carlos        Carmen
Reina Ramirez, Joaquin     Carmen
Gallego Carvajal, Juan     Carmen
Mendizabal Romero, Luis    Carmen
Rolo Vera, Luis Miguel     Carmen
Pozo Martin, Ismael        Carmen
Camacho Lindsey, Daniel    Carmen

13 filas seleccionadas.

***************************************************************************************************************
 5.- Mostrar código, nombre y apellido, 
 y DNI de los alumnos que han aprobado algún examen de LENGUAJE DE MARCAS.
 
SQL>SELECT COD_AL,NOMBRE_AL, DNI_AL
	FROM ALUMNOS
	WHERE COD_AL IN (SELECT ALUMNO_NO
						FROM NOTAS, ASIGNATURAS
						WHERE NOTA_NO >= 5
							AND ASIGNATURA_NO = COD_AS
							AND UPPER(NOMBRE_AS) LIKE 'LENGUAJES DE MARCAS');

Resultado:

    COD_AL NOMBRE_AL                 DNI_AL
---------- ------------------------- ---------
        10 Arias Grillo, Jairo       55645991T
        11 Arnaldos Valle, Javier    54652636D
        12 Avila Ferrete, Raquel     71106202D
        13 Cabrera Alava, Kilian     56646516D

***************************************************************************************************************
 6.- Mostrar las horas que da clase a la semana cada profesor.
 
SQL>SELECT NOMBRE_PR, SUM( HORASSEM_CL)
	FROM CLASES, PROFESORES
	WHERE COD_PR = PROFESOR_CL
	GROUP BY NOMBRE_PR;

Resultado:

NOMBRE_PR                 SUM(HORASSEM_CL)
------------------------- ----------------
Valverde Gallego, Enrique                3
Matito Lozano, Carmen                    6
Del Junco Suarez, Malvina               10
Toscano Fernandez, Juan                 11

***************************************************************************************************************
 7.- Mostrar de cada alumno su código y sus apellidos (SIN EL NOMBRE) 
 junto con el nombre y apellidos de su delegado.
 
SQL>SELECT A.COD_AL, SUBSTR(A.NOMBRE_AL,1,INSTR(A.NOMBRE_AL,',')-1),B.NOMBRE_AL
	FROM ALUMNOS A, ALUMNOS B
	WHERE A.DELEGADO_AL = B.COD_AL
	ORDER BY COD_AL;

Resultado:

    COD_AL SUBSTR(A.NOMBRE_AL,1,INSTR(A.NOMBRE_AL,',')-1)                                                       NOMBRE_AL
---------- ---------------------------------------------------------------------------------------------------- -------------------------
        10 Arias Grillo                                                                                         Arias Grillo, Jairo
        11 Arnaldos Valle                                                                                       Gallego Carvajal, Juan
        12 Avila Ferrete                                                                                        Gallego Carvajal, Juan
        13 Cabrera Alava                                                                                        Arias Grillo, Jairo
        14 Pires Barranco                                                                                       Arias Grillo, Jairo
        15 Calvo Jimenez                                                                                        Arias Grillo, Jairo
        16 Camacho Lindsey                                                                                      Arias Grillo, Jairo
        17 Pozo Martin                                                                                          Gallego Carvajal, Juan
        18 Rolo Vera                                                                                            Gallego Carvajal, Juan
        19 Mendizabal Romero                                                                                    Gallego Carvajal, Juan
        20 Gallego Carvajal                                                                                     Gallego Carvajal, Juan
        21 Reina Ramirez                                                                                        Arias Grillo, Jairo
        22 Gata Masero                                                                                          Arias Grillo, Jairo

13 filas seleccionadas.

***************************************************************************************************************
 8.- Mostrar los profesores que le han dado clase a JAIRO (Serán aquellos que imparten la asignatura en la que tiene nota).
 
SQL>SELECT DISTINCT NOMBRE_PR
	FROM PROFESORES, CLASES
	WHERE COD_PR = PROFESOR_CL
		AND ASIGNATURA_CL IN (SELECT ASIGNATURA_NO
								FROM NOTAS, ALUMNOS
								WHERE COD_AL = ALUMNO_NO
									AND UPPER(NOMBRE_AL) LIKE '%JAIRO%');
Resultado:

NOMBRE_PR
-------------------------
Del Junco Suarez, Malvina
Toscano Fernandez, Juan

***************************************************************************************************************
 9.- Mostrar, de cada asignatura, su nombre y la nota media (CON DOS DECIMALES).
 
SQL>SELECT NOMBRE_AS, TO_CHAR(AVG(NVL(NOTA_NO, 0)), '999D99')
	FROM NOTAS, ASIGNATURAS
	WHERE COD_AS = ASIGNATURA_NO
	GROUP BY NOMBRE_AS;
	
Resultado:

NOMBRE_AS                           TO_CHAR
----------------------------------- -------
Formacion y orientacion laboral        8,83
Entornos de desarrollo                 4,61
Lenguajes de marcas                    5,54
Bases de datos                         6,14

***************************************************************************************************************
10.- (OUTER JOIN, hay asignaturas que no tienen notas) Mostrar, de cada asignatura, su nombre y la nota media (CON DOS DECIMALES).
 
SQL>SELECT NOMBRE_AS, TO_CHAR(AVG(NVL(NOTA_NO, 0)),'999D99')
	FROM NOTAS, ASIGNATURAS
	WHERE COD_AS = ASIGNATURA_NO(+)
	GROUP BY NOMBRE_AS;

Resultado:

NOMBRE_AS                           TO_CHA
----------------------------------- ------
Formacion y orientacion laboral       8,83
Sistemas informaticos                  ,00
Programacion                           ,00
Entornos de desarrollo                4,61
Lenguajes de marcas                   5,54
Bases de datos                        6,14

6 filas seleccionadas.

***************************************************************************************************************
11.- Mostrar el nombre de la asignatura con la nota media más alta.
 
SQL>SELECT NOMBRE_AS, AVG(NVL(NOTA_NO, 0))
	FROM NOTAS, ASIGNATURAS
	WHERE COD_AS = ASIGNATURA_NO
	GROUP BY NOMBRE_AS
	HAVING AVG(NVL(NOTA_NO, 0)) = (SELECT MAX(AVG(NVL(NOTA_NO, 0)))
									FROM NOTAS
									GROUP BY ASIGNATURA_NO);
Resultado:

NOMBRE_AS                           AVG(NVL(NOTA_NO,0))
----------------------------------- -------------------
Formacion y orientacion laboral              8,83333333

***************************************************************************************************************
12.- Mostrar la nota media (CON DOS DECIMALES) de cada alumno en cada asignatura (nombre y apellidos junto con el nombre de la asignatura) para los alumnos de BADAJOZ.
 
SQL>SELECT NOMBRE_AL, NOMBRE_AS, TO_CHAR(AVG(NVL(NOTA_NO,0)),'99D99')
	FROM ALUMNOS, NOTAS, ASIGNATURAS
	WHERE COD_AL = ALUMNO_NO
		AND COD_AS = ASIGNATURA_NO
		AND UPPER(CIUDAD_AL) LIKE 'BADAJOZ'
	GROUP BY NOMBRE_AL, NOMBRE_AS;

Resultado:

NOMBRE_AL                 NOMBRE_AS                           MEDIA
------------------------- ----------------------------------- ------
Gata Masero, Carlos       Bases de datos                        5,50
Gata Masero, Carlos       Formacion y orientacion laboral       8,83
Mendizabal Romero, Luis   Bases de datos                        1,17
Cabrera Alava, Kilian     Lenguajes de marcas                   5,00
Rolo Vera, Luis Miguel    Bases de datos                        5,83

***************************************************************************************************************
13.- Mostrar el nombre y apellidos de los alumnos que sacaron en algún examen, la misma nota que la máxima nota que sacó JAIRO en LENGUAJE DE MARCAS.
 
SQL>SELECT DISTINCT NOMBRE_AL
	FROM ALUMNOS, NOTAS
	WHERE COD_AL = ALUMNO_NO
		AND NOTA_NO = (SELECT MAX(NOTA_NO)
						FROM NOTAS, ALUMNOS, ASIGNATURAS
						WHERE COD_AL = ALUMNO_NO
							AND COD_AS = ASIGNATURA_NO
							AND UPPER(NOMBRE_AL) LIKE '%JAIRO%'
							AND UPPER(NOMBRE_AS) LIKE 'LENGUAJES DE MARCAS');

Resultado:

NOMBRE_AL
------------------------
Arias Grillo, Jairo
Rolo Vera, Luis Miguel
Gata Masero, Carlos

***************************************************************************************************************
14.- Mostrar el nombre y apellidos del profesor que ha puesto la nota más alta.
 
SQL>SELECT NOMBRE_PR
	FROM PROFESORES, CLASES
	WHERE COD_PR = PROFESOR_CL
		AND ASIGNATURA_CL = (SELECT ASIGNATURA_NO
								FROM NOTAS
								WHERE NOTA_NO = (SELECT MAX(NOTA_NO)
													FROM NOTAS));
		
Resultado:

NOMBRE_PR
-------------------------
Del Junco Suarez, Malvina

***************************************************************************************************************
15.- Mostrar la fecha en la que se hizo el primer examen con el siguiente formato: 'Jueves 12 de diciembre de 2017 '.
 
SQL>SELECT TO_CHAR(MIN(FECHA_NO), 'Day dd "de" month "de" yyyy')
	FROM NOTAS;
	
Resultado:


FECHA
---------------------------------------
Jueves    19 de octubre    de 2017

***************************************************************************************************************
16.- Mostrar cuantos examenes ha hecho cada alumno en BASES DE DATOS.
 
SQL>SELECT NOMBRE_AL, COUNT(NOTA_NO)
	FROM NOTAS, ALUMNOS, ASIGNATURAS
	WHERE COD_AL = ALUMNO_NO
		AND COD_AS = ASIGNATURA_NO
		AND UPPER(NOMBRE_AS) LIKE 'BASES DE DATOS'
	GROUP BY NOMBRE_AL;

Resultado:
 
NOMBRE_AL                   EXAMENES
------------------------- ----------
Gallego Carvajal, Juan             3
Arias Grillo, Jairo                3
Rolo Vera, Luis Miguel             3
Reina Ramirez, Joaquin             3
Gata Masero, Carlos                3
Mendizabal Romero, Luis            1