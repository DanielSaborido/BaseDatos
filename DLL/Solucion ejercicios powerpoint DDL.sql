-- EJERCICIOS FINALES DEL POWERPOINT DE DDL:

-- 1.- Crea la tabla departamento para que almacene la identificación del
--departamento y el nombre de cada departamento que constituyen una
--empresa.

DROP TABLE DEPARTAMENTO CASCADE CONSTRAINT;

CREATE TABLE DEPARTAMENTO
(
ID_DEPTNO     NUMBER (4),
NOMBRE_DEPTNO VARCHAR2 (50)
);

--2.- Crea la tabla empleado para que contenga información sobre el
--identificador de empleado, el nombre, los apellidos y el número de
--departamento en el que trabaja en la empresa.
DROP TABLE EMPLEADO;
CREATE TABLE EMPLEADO
(
ID_EMPNO        NUMBER (8),
NOMBRE_EMP     VARCHAR (20),
APELLIDOS_EMP  VARCHAR (30),
ID_DEPTNO       NUMBER (4)
);

-- 3.- Modifica la tabla empleado para que pueda almacenar nombres más
--largos.

ALTER TABLE EMPLEADO
MODIFY(
NOMBRE_EMP     VARCHAR (30)
);

ALTER TABLE EMPLEADO
MODIFY (
NOMBRE_EMP     VARCHAR (30),
APELLIDOS_EMP  VARCHAR (30))
;


--4.- Confirma que ambas tablas, tanto departamento como empleado, están
--almacenadas en el diccionario de datos.
--podemos mirar en la tabla de catalogo o en la de USER_TABLES o en la de ALL_TABLES
-- filtrando por nuestra tabla.

SELECT * FROM CAT
WHERE TABLE_NAME IN ('EMPLEADO', 'DEPARTAMENTO');

SELECT * FROM ALL_TABLES
WHERE TABLE_NAME IN ('EMPLEADO', 'DEPARTAMENTO');

SELECT * FROM USER_TABLES
WHERE TABLE_NAME IN ('EMPLEADO', 'DEPARTAMENTO');

SELECT * FROM DICTIONARY WHERE TABLE_NAME LIKE '%TABLE%';

-- 5.- Crea la tabla empleados2 basada en la tabla empleado, pero que solo
--contenga el número del empleado, el nombre del empleado y el
--departamento en el que trabaja.
DROP TABLE EMPLEADO2;

CREATE TABLE EMPLEADO2 
AS 
SELECT  ID_EMPNO ,NOMBRE_EMP , ID_DEPTNO
FROM EMPLEADO
;


-- 6.- Borra la tabla empleado.

DROP TABLE EMPLEADO;

DROP TABLE EMPLEADO CASCADE CONSTRAINT;


--7.- Renombra la tabla empleados2 a empleado.

RENAME EMPLEADO2 TO EMPLEADO;

--8.- Añade un comentario a ambas tablas, describiendo su contenido.

COMMENT ON TABLE EMPLEADO IS 'Contiene la informacion de los empleados de la empresa';

SELECT * FROM USER_TAB_COMMENTS
WHERE TABLE_NAME LIKE '%EMPLEADO%';



Restricciones
-- 1.- Añade a la tabla empleado la restricción PRIMARY KEY
--usando la columna de ID. La restricción debe especificarse en
--la creación de la tabla.


-- a nivel de columna:
DROP TABLE EMPLEADO;
CREATE TABLE EMPLEADO
(
ID_EMPNO        NUMBER (8) CONSTRAINT EMPLEADO_ID_PK PRIMARY KEY,
NOMBRE_EMP     VARCHAR (20),
APELLIDOS_EMP  VARCHAR (30),
ID_DEPTNO       NUMBER (4)
);

-- a nivel de tabla:
DROP TABLE EMPLEADO;
CREATE TABLE EMPLEADO
(
ID_EMPNO        NUMBER (8) ,
NOMBRE_EMP     VARCHAR (20),
APELLIDOS_EMP  VARCHAR (30),
ID_DEPTNO       NUMBER (4),
CONSTRAINT EMPLEADO_ID_PK PRIMARY KEY(ID_EMPNO)
);


--2.- Crea una restricción PRIMARY KEY en la tabla
--departamento usando el campo ID. La restricción debe
--especificarse en la creación de la tabla.

-- a nivel de columna:
DROP TABLE DEPARTAMENTO;
CREATE TABLE DEPARTAMENTO
(
ID_DEPTNO     NUMBER (4)  CONSTRAINT DPTO_ID_PK  PRIMARY KEY,
NOMBRE_DEPTNO VARCHAR (50)
);


-- a nivel de tabla:
DROP TABLE DEPARTAMENTO;
CREATE TABLE DEPARTAMENTO
(
ID_DEPTNO     NUMBER (4),
NOMBRE_DEPTNO VARCHAR (50),
CONSTRAINT DPTO_ID_PK  PRIMARY KEY(ID_DEPTNO)
);

-- 3.- Añade una clave foránea a la tabla empleado que asegure
--que los empleados no se asignan a departamentos
-- inexistentes.

-- opcion1:
DROP TABLE EMPLEADO CASCADE CONSTRAINT;
ALTER TABLE EMPLEADO
MODIFY
ID_DEPTNO     NUMBER (4) CONSTRAINT EMPLEADO_DEPTNO_FK  REFERENCES  DEPARTAMENTO(ID_DEPTNO)
;

--otra opcion:
ALTER TABLE EMPLEADO
ADD 
CONSTRAINT EMPLEADO_DEPTNO_FK 
	FOREIGN KEY(ID_DEPTNO)  
	REFERENCES  DEPARTAMENTO(ID_DEPTNO)  ON DELETE CASCADE
;

-- Nota: Se podria poner ON DELETE CASCADE o bien, ON DELETE SET NULl o bien
-- ON DELETE NO ACTION (que es el valor por defecto). Se pondrá lo que 


-- 4.- Confirma la creación de dichas restricciones consultando
--el diccionario de datos.

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE '%DEPARTAMENTO%' OR  LIKE '%EMPLEADO%'