--------------------------------------------------------------------------------------
-- EJEMPLO1DAW DE EXAMEN SQL: UD3 y UD6: DDL y DML  - DATOS MARZO 2023 (LECTORES)
--------------------------------------------------------------------------------------

-- Nombre: Pon_aquí_tu_nombre     
-- Fecha: Pon aquí la fecha de este examen.

Con este examen se evaluan los siguientes Resultado de Aprendizaje del Modulo de Base de datos:

RA2. Crea bases de datos definiendo su estructura y las características de sus elementos
según el modelo relaciona.

Criterios de evaluación:
a) Se ha analizado el formato de almacenamiento de la información.
b) Se han creado las tablas y las relaciones entre ellas.
c) Se han seleccionado los tipos de datos adecuados.
d) Se han definido los campos clave en las tablas.
e) Se han implantado las restricciones reflejadas en el diseño lógico.


RA4. Modifica la información almacenada en la base de datos utilizando asistentes,
herramientas gráficas y el lenguaje de manipulación de datos.
Criterios de evaluación:
a) Se han identificado las herramientas y sentencias para modificar el contenido de la base
de datos.
b) Se han insertado, borrado y actualizado datos en las tablas.
c) Se ha incluido en una tabla la información resultante de la ejecución de una consulta.
d) Se han diseñado guiones de sentencias para llevar a cabo tareas complejas.
e) Se ha reconocido el funcionamiento de las transacciones.
f) Se han anulado parcial o totalmente los cambios producidos por una transacción.
g) Se han identificado los efectos de las distintas políticas de bloqueo de registros.
h) Se han adoptado medidas para mantener la integridad y consistencia de la
información.

--------------------------------------------------------------------------------------
-- INSTRUCCIONES
--------------------------------------------------------------------------------------

- Pon arriba tu nombre y la fecha, y lee atentamente todas las preguntas.

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\Examen\ " (posteriormente deberas cargarlo en la tarea de Moodle antes de la hora limite):
	Ejemplo:	Tomas Coronado Garcia
			    00TCG.sql
El numero que pones delante de tus iniciales debe ser el que aparece 
a continuación:



- Entra en la consola de línea de comandos SQL con el usuario EXAMEN (u otro que tengas disponible). 

- Sigue las instrucciones de los ejercicios:

- Donde ponga "SQL>", copiarás las sentencias SQL que has utilizado.

- Donde ponga "Resultado:" copiarás el resultado que SQL te devuelve.

- RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. 
Es lo que voy a evaluar, si lo pierdes, lo siento.

-Las sentencias con fallos de sintáxis tendrán una puntuación de 0.

*************************************************************************************************
	Descripción de las tablas:
	==========================

TABLA LECTORES  

# COD_LE		NUMBER(6)		Código del lector
  APELLIDOS_LE	VARCHAR2(30)	Apellidos del lector
  NOMBRE_LE		VARCHAR2(15)	Nombre del lector
  TIPO_LE		CHAR(10) 		Tipo de lector
  MOROSO_LE		DATE			Fecha de fin de la sanción
  SANCIONES_LE	NUMBER(2)		Numero de sanciones

TABLA AUTORES

# COD_AU		NUMBER(6)		Código del autor
  NOMBRE_AU		VARCHAR2(30)	Nombre del autor

TABLA EDITORIALES

# COD_ED		NUMBER(6)		Código de la editorial
  NOMBRE_ED		VARCHAR2(30)	Nombre de la editorial

TABLA LIBROS

# COD_LI		NUMBER(6)		Código del libro
* AUTOR_LI		NUMBER(6)		Código del autor del libro
  TITULO_LI		VARCHAR2(50)	Título del libro
* EDITORIAL_LI	NUMBER(6)		Código de la editorial del libro
  ESTADO_LI		NUMBER(2)		Estado del libro
  PRESTADO_LI	CHAR(1)			Prestado (S/N)

TABLA PRESTAMOS

#*CODLEC_PR		NUMBER(6)	Código del lector
#*CODLIB_PR		NUMBER(6)	Código del libro
# FECHA_PR		DATE		Fecha del préstamo
  DEVOL_PR		DATE		Fecha de devolución

Nota: 
	# Clave primaria
	* Clave ajena


***************************************************************************************************************
 1.- Crea las tablas anteriores con los nombres
 y tipos de campos suministrados sin ninguna restricción. 
(1punto)

 SQL> 
DROP TABLE LECTORES CASCADE CONSTRAINTS;
DROP TABLE AUTORES CASCADE CONSTRAINTS;
DROP TABLE EDITORIALES CASCADE CONSTRAINTS;
DROP TABLE LIBROS CASCADE CONSTRAINTS;
DROP TABLE PRESTAMOS CASCADE CONSTRAINTS;


Tras crear las tablas carga el script "DatosMarzo2023.sql".  

 SQL>
 CREATE TABLE LECTORES(
	COD_LE		NUMBER(6),
	APELLIDOS_LE	VARCHAR2(30),
	NOMBRE_LE		VARCHAR2(15),
	TIPO_LE		CHAR(10),
	MOROSO_LE		DATE,
	SANCIONES_LE	NUMBER(2)
);
 CREATE TABLE AUTORES(
	COD_AU		NUMBER(6),
	NOMBRE_AU		VARCHAR2(30)
);
 CREATE TABLE EDITORIALES(
	COD_ED		NUMBER(6),
	NOMBRE_ED		VARCHAR2(30)
);
 CREATE TABLE LIBROS(
	COD_LI		NUMBER(6),
	AUTOR_LI		NUMBER(6),
	TITULO_LI		VARCHAR2(50),
	EDITORIAL_LI	NUMBER(6),
	ESTADO_LI		NUMBER(2),
	PRESTADO_LI	CHAR(1)
);
 CREATE TABLE PRESTAMOS(
	CODLEC_PR		NUMBER(6),
	CODLIB_PR		NUMBER(6),
	FECHA_PR		DATE,
	DEVOL_PR		DATE
);

ALTER TABLE LIBROS ADD CONSTRAINT CK_PRESTADO_LI CHECK(PRESTADO_LI = 'S' OR PRESTADO_LI = 'N');

*************************************************************************************************
 2.- Añade la columna SEXO_LE a la tabla LECTORES de tipo CHAR(1). 
 Este campo será obligatorio y sólo podrá tener los valores: 'H' o 'M', 
 según sea hombre o mujer. El valor por defecto será 'M'. 
 (1punto)
 
SQL>
ALTER TABLE LECTORES ADD (SEXO_LE CHAR(1) DEFAULT 'M' NOT NULL);
ALTER TABLE LECTORES ADD CONSTRAINT CK_SEXO_LE CHECK(SEXO_LE = 'H' OR SEXO_LE = 'M');

***************************************************************************************************************
 3.- Modifica el campo SEXO_LE sabiendo que 
 los lectores 7, 12, 16, 17 y 18 son mujeres, el resto, hombres. 
 (1punto)
 
SQL>
UPDATE LECTORES
SET SEXO_LE = 'H'
WHERE COD_LE != 7 AND COD_LE != 12 AND COD_LE != 16 AND COD_LE != 17 AND COD_LE != 18;

***************************************************************************************************************
 4.- Añade las restricciones de clave primaria y ajena a todas las tablas. 
 (1punto)
 
SQL>
ALTER TABLE LECTORES ADD CONSTRAINT PK_LECT PRIMARY KEY(COD_LE);
ALTER TABLE AUTORES ADD CONSTRAINT PK_AUT PRIMARY KEY(COD_AU);
ALTER TABLE EDITORIALES ADD CONSTRAINT PK_EDIT PRIMARY KEY(COD_ED);
ALTER TABLE LIBROS ADD CONSTRAINT PK_LIBR PRIMARY KEY(COD_LI);
ALTER TABLE PRESTAMOS ADD CONSTRAINT PK_PRELEC PRIMARY KEY(CODLEC_PR);
ALTER TABLE PRESTAMOS ADD CONSTRAINT PK_PRELIB PRIMARY KEY(CODLIB_PR);
ALTER TABLE PRESTAMOS ADD CONSTRAINT PK_FECHA PRIMARY KEY(FECHA_PR);
ALTER TABLE LIBROS ADD CONSTRAINT FK_LIBR_AUT FOREIGN KEY(AUTOR_LI)REFERENCES AUTORES(COD_AU) ON DELETE CASCADE;
ALTER TABLE LIBROS ADD CONSTRAINT FK_LIBR_EDIT FOREIGN KEY(EDITORIAL_LI)REFERENCES EDITORIALES(COD_ED) ON DELETE CASCADE;
ALTER TABLE PRESTAMOS ADD CONSTRAINT FK_PRE_LEC FOREIGN KEY(CODLEC_PR)REFERENCES LECTORES(COD_LE) ON DELETE CASCADE;
ALTER TABLE PRESTAMOS ADD CONSTRAINT FK_PRE_LIB FOREIGN KEY(CODLIB_PR)REFERENCES LIBROS(COD_LI) ON DELETE CASCADE;

***************************************************************************************************************
 5.- Añade una restricción a la tabla PRESTAMOS para que 
 la fecha DEVOL_PR sea posterior a la fecha FECHA_PR. 
 (0,5 puntos)
 
SQL>
ALTER TABLE PRESTAMOS ADD CONSTRAINT CK_FECHA CHECK(DEVOL_PR > FECHA_PR);

***************************************************************************************************************
 6.- Presta el libro "ARCHIPIELAGO GULAG" a la lectora que se llama "RAQUEL". 
 Para ello tendrás que:
		a) Insertar un registro en la tabla PRESTAMOS, con los códigos del lector 
		y del libro, el campo FECHA_PR, con la fecha de hoy, y el campo DEVOL_PR, vacío. 
		b) Modificar el campo PRESTADO_LI del registro correspondiente de la tabla LIBROS 
		al valor 'S'.
 (1 punto)
 
 SQL> 
 INSERT INTO PRESTAMOS
	SELECT CODLEC_PR, CODLIB_PR, SYSDATE
	FROM LECTORES, LIBROS
	WHERE CODLEC_PR = (SELECT COD_LE
						FROM LECTORES
						WHERE UPPER(NOMBRE_LE) LIKE '%RAQUEL%') AND CODLIB_PR = (SELECT COD_LI
																					FROM LIBROS
																					WHERE UPPER(TITULO_LI) LIKE '%ARCHIPIELAGO GULAG%');

UPDATE LIBROS
SET PRESTADO_LI = 'S'
WHERE UPPER(TITULO_LI) LIKE '%ARCHIPIELAGO GULAG%';

***************************************************************************************************************
 7.- Devuelve el libro "TONTOS DE CAPIROTE". Para ello tendrás que: 
		a) Modificar en la tabla LIBROS, el campo PRESTADO_LI de ese libro al valor 'N'.
		b) Poner la fecha de hoy en el campo DEVOL_PR del registro correpondiente 
		de la tabla PRESTAMOS. 
		c) Si desde que se prestó el libro, FECHA_PR, hasta hoy han pasado más de 15 días, 
		tendrás que sancionar al correpondiente lector:
			- Modificando en su registro de la tabla LECTORES, 
			el campo MOROSO_LE a la fecha de hoy mas un mes.
			- Y el campo SANCIONES_LE incrementándole en una unidad. 
(1,5 puntos)
		
 SQL>

***************************************************************************************************************
 8.- Crea la vista LISTADO, que contendrá por cada libro prestado 
 (aquellos que no han sido devueltos): 
		- Fecha del préstamo
		- Título del libro
		- Nombre del autor
		- Nombre y apellidos del lector que lo tiene
		- Nombre de la editorial del libro
		
	Estos campos se llamarán FECHA, TITULO, AUTOR, LECTOR y EDITORIAL.
(1 punto)
		
 SQL>

***************************************************************************************************************
9.- Crea la vista MOROSOS, que mostrará la información de los lectores  
que están actualmente sancionados (la fecha MOROSO_LE posterior a la actual): 
		- Fecha del fin de la sanción
		- Nombre y apellidos del lector moroso
		- Nº de sanciones que tiene
		- Título del libro que originó la sanción (último libro que se llevó)
		
	Estos campos se llamarán FECHA, MOROSO, SANCIONES y LIBRO.
(1 punto)
		
 SQL>

