/*  ==============================================================================================
               MANIPULACION DE DATOS: INSERT,  UPDATE, DELTE
/*  ==============================================================================================

/* Veremos como INSERTAR nuevas filas en una tabla,
   como  ACTUALIZAR los valores de las columnas en las filas existentes,
   y a BORRAR filas enteras de la tabla.
   
/*--------------- Insercion de datos: INSERT -------------
Siguiendo con el lenguaje de manipulacion de datos (DML)
veamos como se realiza en SQL una insercción de datos:


INSERT INTO NombreTabla [(columna [,columna] ...)]
VALUES (valor [,valor] ...);

NombreTabla es el nombre de la tabla donde se van a insertar los valores.

[(columna [,columna] ...)] representa la columna o columnas donde se van
a introducir valores. Si las columnas no se especifican en la clausula INSERT, 
se consideran, por defecto, todas las columnas de la tabla

(valor [,valor] ...) representa los valores que se van a dar a las columnas.
Éstos se deben corresponder con cada una de las columnas que aparecen;
además, deben coincidir con con el tipo de dato definido para cada columna.
Cualquier columna que no se encuentre en la lista de columnas recibirá el 
valor NULL, siempre y cuando no esté definida como NOT NULL, en cuyo caso
el INSERT fallará. Si no se da la lista de columnas, se han de introducir
valores en todas las columnas.

*/

-- nota: la tabla PROFESORES que utilizamos en el siguiente ejemplo está en datos03.sql

DESC PROFESORES;

Nombre                                    ┐Nulo?   Tipo
 ----------------------------------------- -------- ----------------------------
 COD_CENTRO                                NOT NULL NUMBER(4)
 DNI                                                NUMBER(10)
 APELLIDOS                                          VARCHAR2(30)
 ESPECIALIDAD                                       VARCHAR2(16)
 
SELECT * FROM PROFESORES;

COD_CENTRO        DNI APELLIDOS                      ESPECIALIDAD
---------- ---------- ------------------------------ ----------------
        10    1112345 Martinez Salas, Fernando       INFORMATICA
        10    4123005 Bueno Zarco, Elisa             MATEMATICAS
        10    4122025 Montes Garcia, M.Pilar         MATEMATICAS
        15    9800990 Ramos Ruiz, Luis               LENGUA
        15    1112345 Rivera Silvestre, Ana          DIBUJO
        15    8660990 De Lucas Fdez, M.Angel         LENGUA
        22    7650000 Ruiz Lafuente, Manuel          MATEMATICAS
        45   43526789 Serrano Laguia, Maria          INFORMATICA
		
		
-- Para incluir un nuevo profesor (una nueva fila) en la tabla
--  utilizamos el INSERT INTO		
INSERT INTO PROFESORES (APELLIDOS, ESPECIALIDAD, COD_CENTRO)
VALUES ('Coronado Garcia, Tomas', 'INFORMATICA', 22);








--Al ejecutar la sentencia, Oracle emite un mensaje (1 fila creada),
-- con el que se indica que la fila se ha insertado correctamente.
-- Observamos con esta sentencia:
--Las columnas a las que damos valores se identifican por su nombre
--La asociacion columna-valor es posicional
--Los valores que se dan a las columnas deben coincidir con el tipo de dato definido en la columna
--Los valores constantes de tipo caracter han de ir encerrados entre comillas simples.(' ')
--(los de tipo fecha tambien)

-- Ahora el contenido de la tabla profesores tendria una fila más:


SELECT * FROM PROFESORES;

COD_CENTRO        DNI APELLIDOS                      ESPECIALIDAD
---------- ---------- ------------------------------ ----------------
        10    1112345 Martinez Salas, Fernando       INFORMATICA
        10    4123005 Bueno Zarco, Elisa             MATEMATICAS
        10    4122025 Montes Garcia, M.Pilar         MATEMATICAS
        15    9800990 Ramos Ruiz, Luis               LENGUA
        15    1112345 Rivera Silvestre, Ana          DIBUJO
        15    8660990 De Lucas Fdez, M.Angel         LENGUA
        22    7650000 Ruiz Lafuente, Manuel          MATEMATICAS
        45   43526789 Serrano Laguia, Maria          INFORMATICA
        22            Coronado Garcia, Tomas         INFORMATICA

-- Las columnas para las que no dimos valores aparecen como nulos; en este caso, la columna DNI.

-- Si tratamos de insertar un profesor que no tiene codigo asignado, nos dará error, ya que 
-- esa columna (cod_centro) estaba definida como NOT NULL.

INSERT INTO PROFESORES (APELLIDOS, ESPECIALIDAD)
VALUES ('Torres Rodriguez, Ernesto', 'MATEMATICAS');



-- Observamos que aparece un mensaje de error que indica que no se puede insertar una columna con valor NULO
-- la tabla si en su definición se ha especificado NOT NULL (COD_CENTRO está definido como NOT NULL)

SQL> INSERT INTO PROFESORES (APELLIDOS, ESPECIALIDAD)
  2  VALUES ('Torres Rodriguez, Ernesto', 'MATEMATICAS');
 
 
INSERT INTO PROFESORES (APELLIDOS, ESPECIALIDAD)
*
ERROR en lÝnea 1:
ORA-01400: no se puede realizar una inserci¾n NULL en ("ALUMNO"."PROFESORES"."COD_CENTRO")

-- Insertamos a un profesor de apellidos y nombre 'Lopez Mera, Juan Antonio' en el codigo centro 22, con DNI 23444800
-- y de la especialidad 'HISTORIA'
INSERT INTO PROFESORES 
VALUES (22, 23444800,'Lopez Mera, Juan Antonio', 'HISTORIA');


1 fila creada.

SELECT * FROM PROFESORES;
COD_CENTRO        DNI APELLIDOS                      ESPECIALIDAD
---------- ---------- ------------------------------ ----------------
        10    1112345 Martinez Salas, Fernando       INFORMATICA
        10    4123005 Bueno Zarco, Elisa             MATEMATICAS
        10    4122025 Montes Garcia, M.Pilar         MATEMATICAS
        15    9800990 Ramos Ruiz, Luis               LENGUA
        15    1112345 Rivera Silvestre, Ana          DIBUJO
        15    8660990 De Lucas Fdez, M.Angel         LENGUA
        22    7650000 Ruiz Lafuente, Manuel          MATEMATICAS
        45   43526789 Serrano Laguia, Maria          INFORMATICA
        22            Coronado Garcia, Tomas         INFORMATICA
        22   23444800 Lopez Mera, Juan Antonio       HISTORIA


--No es necesario especificar el nombre de las columnas ya que las hemos dado un valor en la fila que insertamos.
-- Este valor ha de ir en el mismo orden en que las columnas estén definidas en la tabla.


/*--------------- Insercion de datos: INSERT con SELECT -------------
--Hasta el momento solo hemos insertado una fila, pero si añadimos 
-- a una consulta, es decir , una sentencia SELECT, se añaden tantas filas
como devuelva la consulta. El formato de INSERT con SELECT es el siguiente:
*/
INSERT INTO  NombreTabla1 [(columna [,columna] ...) ]
     SELECT {columna [,columna] ...| *}
	 FROM  NombreTabla2 [CLAUSULAS DE SELECT];
	 
-- (si las columnas no se especifican en la clausula INSERT, por defecto, 
--  se consideran todas las columnas de la tabla).

Teniamos ya la tabla EMPLE

Creamos la tabla EMPLE30 con la misma estructura de EMPLE

DROP TABLE EMPLE30 cascade constraints; 

CREATE TABLE EMPLE30 (
 EMP_NO NUMBER(4) NOT NULL,
 APELLIDO VARCHAR2(10) ,
 OFICIO VARCHAR2(10) ,
 DIR NUMBER(4) ,
 FECHA_ALT DATE ,
 SALARIO NUMBER(10),
 COMISION NUMBER(10),
 DEPT_NO NUMBER(2) NOT NULL) ;
 
 Tabla creada.

SQL> SELECT * FROM EMPLE30;

ninguna fila seleccionada
 
-- Y ahora insertamos los registros de la tabla EMPLE 
-- cuyo departamento es 30 en la tabla EMPLE30
 
 INSERT INTO  EMPLE30 (EMP_NO,APELLIDO, OFICIO, DIR, FECHA_ALT, SALARIO, COMISION, DEPT_NO)	
     SELECT EMP_NO,APELLIDO, OFICIO, DIR, FECHA_ALT, SALARIO, COMISION, DEPT_NO
	 FROM EMPLE 
	 WHERE DEPT_NO=30;
	 
INSERT INTO  EMPLE30 
     SELECT *
	 FROM EMPLE 
	 WHERE DEPT_NO=30;

6 filas creadas.

SQL> SELECT * FROM EMPLE30;

    EMP_NO APELLIDO   OFICIO            DIR FECHA_ALT     SALARIO   COMISION    DEPT_NO
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
      7499 ARROYO     VENDEDOR         7698 20/02/1980     208000      39000         30
      7521 SALA       VENDEDOR         7698 22/02/1981     162500      65000         30
      7654 MARTIN     VENDEDOR         7698 29/09/1981     162500     182000         30
      7698 NEGRO      DIRECTOR         7839 01/05/1981     370500                    30
      7844 TOVAR      VENDEDOR         7698 08/09/1981     195000          0         30
      7900 JIMENO     EMPLEADO         7698 03/12/1981     123500                    30

6 filas seleccionadas.

-- Veamos ahora un ejemplo con la tabla NOMBRES
DESC NOMBRES;
 Nombre                                                                                                            ┐Nulo?   Tipo
 ----------------------------------------------------------------------------------------------------------------- -------- ----------------------------------------------------------------------------
 NOMBRE                                                                                                                     VARCHAR2(15)
 EDAD                                                                                                                       NUMBER(2)

SELECT * FROM NOMBRES;

SQL> SELECT * FROM NOMBRES;

NOMBRE                EDAD
--------------- ----------
PEDRO                   17
JUAN                    17
MARIA                   16
CLARA                   14
                        15
                        18
JESUS

7 filas seleccionadas.

-- Insertamos en la tabla NOMBRES, en la columna NOMBRE, el APELLIDO 
-- de los empleados de la tabla EMPLE que sean del departamento 20:

INSERT INTO NOMBRES (NOMBRE)
SELECT  APELLIDO FROM EMPLE WHERE DEPT_NO=20;

5 filas creadas.

SQL> SELECT * FROM NOMBRES;

12 filas seleccionadas.

--Si al insertar los apellidos, alguno supera la longitud para la columna NOMBRE
-- de la tabla NOMBRES, no se insertará y aparecerá un error.

SQL> SELECT * FROM EMPLE;

    EMP_NO APELLIDO   OFICIO            DIR FECHA_ALT     SALARIO   COMISION    DEPT_NO
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
      7369 SANCHEZ    EMPLEADO         7902 17/12/1980     104000                    20
      7499 ARROYO     VENDEDOR         7698 20/02/1980     208000      39000         30
      7521 SALA       VENDEDOR         7698 22/02/1981     162500      65000         30
      7566 JIMENEZ    DIRECTOR         7839 02/04/1981     386750                    20
      7654 MARTIN     VENDEDOR         7698 29/09/1981     162500     182000         30
      7698 NEGRO      DIRECTOR         7839 01/05/1981     370500                    30
      7782 CEREZO     DIRECTOR         7839 09/06/1981     318500                    10
      7788 GIL        ANALISTA         7566 09/11/1981     390000                    20
      7839 REY        PRESIDENTE            17/11/1981     650000                    10
      7844 TOVAR      VENDEDOR         7698 08/09/1981     195000          0         30
      7876 ALONSO     EMPLEADO         7788 23/09/1981     143000                    20
      7900 JIMENO     EMPLEADO         7698 03/12/1981     123500                    30
      7902 FERNANDEZ  ANALISTA         7566 03/12/1981     390000                    20
      7934 MUÐOZ      EMPLEADO         7782 23/01/1982     169000                    10
	  
	  
/* Insertar un empleado de apellido 'GARCIA', con numero de empleado 1111, 
en la tabla EMPLE, en el departamento con mayor numero de empleados. 
La fecha de alta será la actual, invtentamos el resto de los valores.

En primer lugar, vamos a averiguar qué sentencia SELECT calcula el departamento con más empleados.*/

SELECT DEPT_NO 
FROM EMPLE
GROUP BY DEPT_NO
HAVING COUNT(*) = ( SELECT MAX(COUNT(*)) FROM EMPLE GROUP BY DEPT_NO);

   DEPT_NO
----------
        30


--Ahora hacemos la inserccion en la tabla EMPLE, teniendo en cuenta la SELECT anterior:

INSERT INTO EMPLE 
SELECT DISTINCT 1111,'GARCIA', 'ANALISTA', 7566, SYSDATE, 2000, 120, DEPT_NO
FROM EMPLE 
WHERE DEPT_NO = ( SELECT DEPT_NO 
                              FROM EMPLE              
							GROUP BY DEPT_NO
                           HAVING COUNT(*) = ( SELECT MAX(COUNT(*)) 
						                         FROM EMPLE 
												 GROUP BY DEPT_NO) );


1 fila creada.

-- Recordad que en clase vimos que se podia hacer de más maneras. Practicalo.

SQL> SELECT * FROM EMPLE;

    EMP_NO APELLIDO   OFICIO            DIR FECHA_ALT     SALARIO   COMISION    DEPT_NO
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
      7369 SANCHEZ    EMPLEADO         7902 17/12/1980     104000                    20
      7499 ARROYO     VENDEDOR         7698 20/02/1980     208000      39000         30
      7521 SALA       VENDEDOR         7698 22/02/1981     162500      65000         30
      7566 JIMENEZ    DIRECTOR         7839 02/04/1981     386750                    20
      7654 MARTIN     VENDEDOR         7698 29/09/1981     162500     182000         30
      7698 NEGRO      DIRECTOR         7839 01/05/1981     370500                    30
      7782 CEREZO     DIRECTOR         7839 09/06/1981     318500                    10
      7788 GIL        ANALISTA         7566 09/11/1981     390000                    20
      7839 REY        PRESIDENTE            17/11/1981     650000                    10
      7844 TOVAR      VENDEDOR         7698 08/09/1981     195000          0         30
      7876 ALONSO     EMPLEADO         7788 23/09/1981     143000                    20
      7900 JIMENO     EMPLEADO         7698 03/12/1981     123500                    30
      7902 FERNANDEZ  ANALISTA         7566 03/12/1981     390000                    20
      7934 MUÐOZ      EMPLEADO         7782 23/01/1982     169000                    10
      1111 GARCIA     ANALISTA         7566 16/02/2021       2000        120         30
	  
/* Al hacer la inserción sólo desconocemos el valor de la columna DEPT_NO, que es el que devuelve
la SELECT; el resto de valores, como APELLIDO, OFICIO y EMP_NO, los conocemos y, port tanto, los ponemos
directamente en la sentencia SELECT. La clausula DISTINCT es necesaria, ya que sin ella se insertrian tantans filas como
empleados haya en el departamento con la mayor numero de empleados. Si ejecutamos sin DISTINCT insertará más de una fila.


/* Insertar un empleado de apellido 'QUIROGA', con numero de empleado 1112, 
en la tabla EMPLE.
Los restantes datos del nuevo empleado serán los mismos que los de 'GIL' 
y la fecha de alta será la fecha actual: */


INSERT INTO EMPLE 
SELECT 1112,'QUIROGA', OFICIO, DIR, SYSDATE, SALARIO,COMISION,DEPT_NO
FROM EMPLE WHERE APELLIDO = 'GIL';

INSERT INTO EMPLE 
VALUES (
1112,
'QUIROGA', 
(SELECT OFICIO FROM EMPLE WHERE APELLIDO = 'GIL'), 
(SELECT DIR FROM EMPLE WHERE APELLIDO = 'GIL'), 
SYSDATE, 
(SELECT SALARIO FROM EMPLE WHERE APELLIDO = 'GIL'),
(SELECT COMISION FROM EMPLE WHERE APELLIDO = 'GIL'),
(SELECT DEPT_NO FROM EMPLE WHERE APELLIDO = 'GIL')
);


1 fila creada.


SQL> SELECT * FROM EMPLE;

    EMP_NO APELLIDO   OFICIO            DIR FECHA_ALT     SALARIO   COMISION    DEPT_NO
---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
      7369 SANCHEZ    EMPLEADO         7902 17/12/1980     104000                    20
      7499 ARROYO     VENDEDOR         7698 20/02/1980     208000      39000         30
      7521 SALA       VENDEDOR         7698 22/02/1981     162500      65000         30
      7566 JIMENEZ    DIRECTOR         7839 02/04/1981     386750                    20
      7654 MARTIN     VENDEDOR         7698 29/09/1981     162500     182000         30
      7698 NEGRO      DIRECTOR         7839 01/05/1981     370500                    30
      7782 CEREZO     DIRECTOR         7839 09/06/1981     318500                    10
      7788 GIL        ANALISTA         7566 09/11/1981     390000                    20
      7839 REY        PRESIDENTE            17/11/1981     650000                    10
      7844 TOVAR      VENDEDOR         7698 08/09/1981     195000          0         30
      7876 ALONSO     EMPLEADO         7788 23/09/1981     143000                    20
      7900 JIMENO     EMPLEADO         7698 03/12/1981     123500                    30
      7902 FERNANDEZ  ANALISTA         7566 03/12/1981     390000                    20
      7934 MUÐOZ      EMPLEADO         7782 23/01/1982     169000                    10
      1111 GARCIA     ANALISTA         7566 16/02/2021       2000        120         30
      1112 QUIROGA    ANALISTA         7566 16/02/2021     390000                    20

/*----------------------------------------------------------
/*--------------- Modificacion. Orden UPDATE -------------
/*----------------------------------------------------------
-- Para actualizar los valores de las columnas de una o varias filas de
una tabla utilizamos la orden UPDATE, cuyo formato es el siguiente:
*/
UPDATE NombreTabla
SET columna1=valor1, ..., columnan=valorn
WHERE condicion;

--Veamos un ejemplo, sea la tabla CENTROS:

SQL> SELECT * FROM CENTROS;

COD_CENTRO T NOMBRE                         DIRECCION                  TELEFONO   NUM_PLAZAS
---------- - ------------------------------ -------------------------- ---------- ----------
        10 S IES El Quijote                 Avda. Los Molinos 25       965-887654        538
        15 P CP Los Danzantes               C/Las Musas s/n            985-112322        250
        22 S IES Planeta Tierra             C/Mina 45                  925-443400        300
        45 P CP Manuel Hidalgo              C/Granada 5                926-202310        220
        50 S IES Anto±ete                   C/Los Toreros 21           989-406090        310

-- Queremos cambiar (actualizar) la dirección del COD_CENTRO 22 a 'C/ Pilón 13' y el numero de plazas a 295

UPDATE CENTROS 
SET DIRECCION = 'C/ Pilón 13', NUM_PLAZAS=295
WHERE COD_CENTRO=22;


1 fila actualizada.

SQL> SELECT * FROM CENTROS;

COD_CENTRO T NOMBRE                         DIRECCION                  TELEFONO   NUM_PLAZAS
---------- - ------------------------------ -------------------------- ---------- ----------
        10 S IES El Quijote                 Avda. Los Molinos 25       965-887654        538
        15 P CP Los Danzantes               C/Las Musas s/n            985-112322        250
        22 S IES Planeta Tierra             C/ Pilón 13                925-443400        295
        45 P CP Manuel Hidalgo              C/Granada 5                926-202310        220
        50 S IES Anto±ete                   C/Los Toreros 21           989-406090        310
		
--¿Que hubiese pasado si no hubiesemos puesto la clausula WHERE?
UPDATE CENTROS 
SET DIRECCION = 'C/ Pilón 13', NUM_PLAZAS=295;

5 filas actualizadas.


SQL> SELECT * FROM CENTROS;

COD_CENTRO T NOMBRE                         DIRECCION                  TELEFONO   NUM_PLAZAS
---------- - ------------------------------ -------------------------- ---------- ----------
        10 S IES El Quijote                 C/ Pilón 13                965-887654        295
        15 P CP Los Danzantes               C/ Pilón 13                985-112322        295
        22 S IES Planeta Tierra             C/ Pilón 13                925-443400        295
        45 P CP Manuel Hidalgo              C/ Pilón 13                926-202310        295
        50 S IES Anto±ete                   C/ Pilón 13                989-406090        295
		
		
-- Como se aprecia, se hubieran modificado todas las filas de la tabla CENTROS con la dirección  'C/ Pilón 13' y el numero de plazas a 295

--  xx

-- 

/*----------------------------------------------------------
/*--------------- UPDATE con SELECT -------------
-- Podemos incluir una subconsulta en una sentencia UPDATE que puede estar contenida
en la clausula WHERE o puede formar parte de SET. Cuando la subconsulta (orden SELECT)
forma parte de SET, debe seleccionar una única fila y el mimso numero de columnas
(con tipos de datos adecuados) que las que hay entre parentesis al lado SET.
Los formatos son:
*/

UPDATE NombreTabla
SET col1 = valor1, ...,coln = valorn
WHERE colx = (SELECT ...);

UPDATE NombreTabla
SET (col1, col2,...) = (SELECT columna1, columna2, ...)
WHERE condición;

UPDATE NombreTabla
SET col1 = (SELECT columna1 ...), col2 = (SELECT columna1 ...), ...
WHERE condición;

--En la tabla CENTROS la siguiente orden UPDATE igualará la dirección y el número
--de plazas del código de centro 10 a los valores de las columnas correspondientes
--que están almacenadas para el código de centro 50. Los valores actuales de estos datos son:

UPDATE CENTROS
SET (DIRECCION, NUM_PLAZAS) = 
(SELECT DIRECCION, NUM_PLAZAS FROM CENTROS WHERE COD_CENTRO=50)
WHERE COD_CENTRO=10;


--A partir de la tabla EMPLE, cambia el salario a la mitad 
--y la comision a 0, a aquellos empleados
--que pertenezcan al departamento con mayor numero de empleados.

UPDATE EMPLE
SET SALARIO = SALARIO/2,COMISION = 0 
WHERE DEPT_NO=(SELECT DEPT_NO 
                 FROM EMPLE 
			 GROUP BY DEPT_NO 
			 HAVING COUNT(*) =(SELECT MAX(COUNT(*)) 
			                     FROM EMPLE 
						     GROUP BY DEPT_NO));



-- Para todos los empleados de la tabla EMPLE 
-- y el departamento 'CONTABILIDAD', cambiamos su salario
-- a el doble del salario de 'SANCHEZ' y su apellido, a minuscula.

UPDATE EMPLE
SET APELLIDO = LOWER (APELLIDO), 
    SALARIO =(SELECT SALARIO * 2 FROM EMPLE WHERE APELLIDO='SANCHEZ') 
WHERE DEPT_NO = (SELECT DEPT_NO 
				   FROM DEPART 
				  WHERE DNOMBRE = 'CONTABILIDAD');

/*----------------------------------------------------------
/*--------------- Borrado de filas. Orden DELETE -----------
/*----------------------------------------------------------
-- Para eliminar una o varias filas de una tabla se usa la orden DELETE.
La clausula WHERE es esencial para eliminar solo aquellas filas deseadas.
Sin la clausula WHERE, DELETE borrará todas las filas de la tabla.
El espacio usado por las filas que han sido borradas no se reutiliza,
a menos que se realice un EXPORT o IMPORT. La condicion puede incluir
una subconsulta. Este es subformato:
*/

-- Borramos el COD_CENTRO 50 de la tabla centros:
DELETE FROM CENTROS WHERE COD_CENTRO=50;
--O bien:
DELETE CENTROS WHERE COD_CENTRO=50;


--Borramos todas las filas de la tabla CENTROS:
DELETE FROM CENTROS;

--O bien:

DELETE CENTROS;

-- Borramos todas las filas de la tabla LIBRERIA cuyos EJEMPLARES no superen la media de ejemplares de su ESTANTE:
DELETE FROM LIBRERIA L 
WHERE EJEMPLARES < (SELECT AVG(EJEMPLARES) 
					  FROM LIBRERIA 
					  WHERE ESTANTE =L.ESTANTE 
				   GROUP BY ESTANTE);

-- Borramos los departamentos de la tabla DPART con menos de cuatro empleados:
DELETE FROM DEPART 
WHERE DEPT_NO IN(SELECT DEPT_NO 
				   FROM EMPLE 
			   GROUP BY DEPT_NO 
				 HAVING COUNT(*) < 4);



/*--------------- ROLLBACK, COMMIT y AUTOCOMMIT -------------
Oracle permite dar marcha atras a un trabajo realizado, 
mediante la orden ROLLBACK,
siempre y cuando no hayamos validado los cambios en la base
de datos mediante la orden COMMIT.
Cuando hacemos  transacciones sobre la base de datos, es decir, 
cuando insertamos, actualizamos o eliminamos datos en las tablas,
los datos no se aplicaran a la base de datos hasta que no hagamos 
un COMMIT.
Esto significa que si durante el tiempo que hemos estado realizando
transacciones, no hemos hecho ningun COMMIT y de pronto se va la luz,
todo el trabajo se habrá perdido, y nuestras tablas estarán en la
situación de partida.

*/	 
--Para validar los cambios:
COMMIT;
--Validacion terminada

/*
Se permite validar automaticamente las transacciones sin tener que indicarlo
de forma explicita. Para eso sirve el parametro AUTOCOMMIT. El valor de este
parametro se puede mostrar con la order SHOW, de la siguiente manera:
*/
SHOW AUTOCOMMIT;
autocommit INMEDIATE

/*
OFF es el varlor por omisión, de manera que las transacciones (INSERT, UPDATE y DELETE)
no son definitivas hasta que no hagamos COMMIT. Si queremos INSERT, UPDATE y DELETE tengan
un caracter definitivo sin necesidad de realizar la validacion COMMIT, hemos de activar
el parametro AUTOCOMMIT con la orden SET.  */
SET AUTOCOMMIT ON;

SHOW AUTOCOMMIT;
autocommit ON

-- La orden ROLLBACK aborta la transacción volviendo a la situación de las tablas
-- de la base de datos desde el último COMMIT.

ROLLBACK;
--Rollback terminado

/*COMMIT IMPLICITO;
Hay varias ordenes SQL que fuerzan que se ejecute un COMMIT sin necesidad de indicarlo:
QUIT;
EXIT;
CONNECT;
DISCONNECT;
CREATE TABLE;
DROP TABLE;
CREATE VIEW;
DROP VIEW;
GRANT;
ALTER;
REVOQUE;
AUDIT;
NOAUDIT;

-- Usar cualquiera de estar ordenes es como usar COMMIT;

/*ROLLBACK automatico;
Si después de haber realizado cambios en nuestras tablas, 
se produce un fallo del sistema(por ejemplo, se va la luz) 
y no hemos validado el trabajo, Oracle hace un ROLL-BACK automatico 
sobre cualquier trabajo no validado.
Esto significa que tendremos que repetir el trabajo 
cuando pogamos en marcha la base de datos.

		 
	