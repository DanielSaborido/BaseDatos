---------------------------------------------------------------------------------------------------
----------------------- SQL (Structured Query Language) CON ORACLE  --------------------------------
----------------------------------------------------------------------------------------------------

-- Estos ejemplos estan hechos usando el usuario: scott y la contraseña:tiger
-- En moodle teneis como conectaros con este usuario y como cargar las tablas correspondiente

SET LINESIZE 220
SET PAGESIZE 60

----------------------- A. SENTENCIA    SELECT  ----------------------------------------------------------------------------------------------

SELECT [DISTINCT | ALL] {* | <expr1>[, <expr2>] ...}
FROM <tabla1>[, <tabla2>, ...]
[WHERE <condicion_where>]
[GROUP BY <group_expr1>[, <group_expr2>, ...]
[HAVING <condicion_having>]
[ORDER BY <expr_orderby1 [ASC | DESC]>[, ...]]

-- donde expr1 puede ser una columna de una tabla, una constante, una expresion aritmetica una funcion o varias funciones anidadas.

----------------------- B. CLAUSULAS DE SELECT  ----------------------------------------------------------------------------------------------
-- La unica clausula obligatoria de la sentencia SELECT es la clausula FROM, el resto son opcionales
--**** FROM: FROM [nombre_tabla1, nombre_tabla2, ...  nombre_tablan]   (Especifica la tabla o lista de tablas  de las que se recuperarán los datos.

--Antes de nada vemos que tablas tenemos cargadas viendo el catalogo (CAT), es decir la tabla de tablas:
SELECT * 
  FROM CAT;

-- Vamos a trabajar con la tabla EMP, veamos que campos tiene con DESC o DESCRIBE:
DESC emp;

--1.– Obtener todos los datos de la tabla de empleados:
SET LINESIZE 220
SET PAGESIZE 60
SELECT *
  FROM emp;
  
--1B.– Obtener los codigos, nombres y departamentos de todos los empleados
SELECT empno, ename, deptno
  FROM emp;
  


--**** WHERE [ WHERE Condicion]
--2.– Obtener los codigos y nombres de los empleados que trabajan en el departamento 30:
SELECT empno, ename
  FROM emp
 WHERE deptno = 30;
 
     EMPNO ENAME
---------- ----------
      7499 ALLEN
      7521 WARD
      7654 MARTIN
      7698 BLAKE
      7844 TURNER
      7900 JAMES

-- Se pueden construir CONDICIONES MULTIPLES utilizando los operadores logicos Booleanos estandares (OR, AND y NOT)
--2B.– Obtener los codigos y nombres de los empleados que trabajan en el departamento 30 Y el Job es "Salesman" (Comerciales)

SELECT empno, ename
  FROM emp
 WHERE deptno = 30
   AND job ='SALESMAN';
   

     EMPNO ENAME
---------- ----------
      7499 ALLEN
      7521 WARD
      7654 MARTIN
      7844 TURNER
	 
-- Se pueden construir CONDICIONES MULTIPLES utilizando los operadores logicos Booleanos estandares (OR, AND y NOT)
--2C.– Obtener los codigos y nombres de los empleados donde o bien el campo comision es nulo, o bien el nombre del empleado es ALLEN

SELECT empno, ename
  FROM emp
 WHERE comm is NULL
    OR ename ='ALLEN';


-- Se le puede poner un nuevo nombre a la tabla mediante ALIAS.

SELECT A.empno, A.ename
  FROM emp A
 WHERE A.deptno = 10;
 
-- Obtener los datos de los emplados ordenados por el trabajo

 SELECT *
  FROM emp
 ORDER BY job; -- nombre o ubicacion de la columna, en este caso seria job o 3

 -- Veamos ahora la tabla DEPT
 SET LINESIZE 100
 DESC dept;
 
 --Vemos todos sus datos
 
 SELECT *
   FROM dept;
 
 ----DEPTNO DNAME LOC
------ -------------- ---------
--10 ACCOUNTING NEW YORK
--40 OPERATIONS BOSTON
--20 RESEARCH DALLAS
--30 SALES CHICAGO

 --Ordenamos todos los datos de la tabla DEPT por el numero de deptno:
   SELECT *
     FROM dept
 ORDER BY deptno;
 
--     DEPTNO DNAME          LOC
---------- -------------- -------------
--        10 ACCOUNTING     NEW YORK
--        20 RESEARCH       DALLAS
--        30 SALES          CHICAGO
--        40 OPERATIONS     BOSTON
 

--3.– Seleccionar todos los datos del departamento 40:
-- (para ello vamos a la tabla DEPT y ponemos al condicion con WHERE)
SELECT *
  FROM dept
 WHERE deptno = 40;
 
--DEPTNO DNAME LOC
-------- -------------- -------------
--40 OPERATIONS BOSTON



--4.– Seleccionar todos los datos de los empleados del departamento 40:
-- (para ello vamos a la tabla EMP y ponemos al condicion con WHERE)
SELECT *
FROM emp
WHERE deptno = 40;




--**** [ORDER BY expre_columna [DESC/ASC], ... [,expre_columna [DESC/ASC]] 
------  Sirve para ordernar los resultados, si no se pone DESC o ASC, por defecto es Ascendente
-- 5.– Obtener los datos de los departamentos ordenados por el nombre del departamento:
   SELECT * 
     FROM dept 
 ORDER BY dname;
 
 -- O lo que es equivalente :
 
   SELECT *
     FROM dept
 ORDER BY 2;
 
 --- Se puede ordernar por varios campos el que está mas a la izquierda es el principal
 --  Por ejemplo, en la tabla empleados ordenamos por el tipo de trabajo (job) de manera ascendente, y luego por el salario de manera descendente
 SELECT *
  FROM emp
 ORDER BY job ASC, SAL DESC;
 

--**** ALL/DISTINCT. 
---Con la clausula ALL recuperamos todas las filas. 
---Con la clausula DISTINCT se eliminan las repetidas, es decir se muestran solo las distintas


-- Por ejemplo, si en la tabla empleados seleccionamos el tipo de trabajo (job).

-- Podemos hacerlo, mostrando el resultado sin ordenar:
 SELECT job
   FROM emp;
   
-- O bien ordenado por el campo job: 
   SELECT job
     FROM emp
 ORDER BY job;


-- (en ambos casos se ve que tenemos filas repetidas

-- Si queremos mostrar solo los distintos tipos de trabajos, haremos lo siguiente:

-- Mostrando el resultado desordenado
 SELECT DISTINCT job
   FROM emp;
   
-- o bien mostrando el resultado ordenado utilizando el ORDER BY 
    SELECT 
  DISTINCT job
      FROM emp
  ORDER BY job;
  
-- (SELECT DISTINCT elimina las filas duplicadas)

--- Se pueden asignar nombres a las columnas poniendo AS y despues el nombre que queremos darle a la columna  o bien sin AS, solamente poniendo a la derecha
-- el nombre que queramos asignarle con o sin comillas. En la siguiente consulta se muestran las tres opciones para asignar nombres a columnas.
--Ejemplo:
--6.– Obtener la comisión, departamento y nombre de los empleados cuyo salario sea inferior a 1.900, ordenándolos por departamento en orden creciente, y por comisión en orden
--decreciente dentro de cada departamento:
  SELECT comm AS "COMISION", deptno AS DEPARTAMENTO, ename NOMBRE
    FROM emp
   WHERE sal < 1900
ORDER BY deptno, comm DESC;

--COMISION DEPARTAMENTO NOMBRE
---------- ------------ ----------
--10 MILLER
--20 SMITH
--20 ADAMS
--30 JAMES
--1400 30 MARTIN
--500 30 WARD
--300 30 ALLEN
--0 30 TURNER

--Elementos de interés:
--Diversos criterios jerarquizados de ordenación.
--Asignación de nombres a las columnas del resultado.


----------------------- c. Seleccion de COLUMNAS  (proyeccion)  ----------------------------------------------------------------------------------------------
-- Se hace poniendo el nombre de las columnas, las que necesitemos mostrar, o bien poniendo el simbolo asterisco * para que muestre todas las columnas

----------------------- D. Seleccion de FILAS (seleccion) ----------------------------------------------------------------------------------------------
-- Se hace poniendo la clausula WHERE y la condicion con la que vayamos a filtrar.

--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------     -------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------       -------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------


--- Operadores Aritmeticos ( +, -, * , /)
--- Mostrar el grado del empleado, y el salario medio para cada uno de los grados:

--Sin renombrar nueva columna:
SELECT  GRADE, (LOSAL+HISAL)/2 
  FROM  SALGRADE;

--Renombrando nueva columna (hay 3 formas de hacerlo): 
SELECT  GRADE, (LOSAL+HISAL)/2 AS AVERAGE_SALARY
  FROM  SALGRADE;
  
SELECT  GRADE, (LOSAL+HISAL)/2 AS "AVERAGE_SALARY"
  FROM  SALGRADE;
  
SELECT  GRADE, (LOSAL+HISAL)/2 AVERAGE_SALARY
  FROM  SALGRADE;
  
--- Los operadores aritmeticos se ponen tanto en expresiones para select
--- como en condiciones en el where
-- Ejemplo: 
--- Mostrar el grado del empleado, y el salario medio 
--para cada uno de los grados en los cuales el salario medio sea mayor a 1000.
SELECT  GRADE, (LOSAL+HISAL)/2 AS AVERAGE_SALARY
  FROM  SALGRADE
 WHERE  ((LOSAL+HISAL)/2) > 1000;
  

--- Operadores de Comparacion (=,<,<=,>,>=, !=, <>)  
--- y Logicos (AND, OR, NOT)

 
 --- Mostrar el grado del empleado, y el salario medio para cada uno de los grados 
-- en los cuales el salario medio sea mayor a 1000 y el grado menor que 4
SELECT  GRADE, (LOSAL+HISAL)/2 AS AVERAGE_SALARY
  FROM  SALGRADE
 WHERE  ((LOSAL+HISAL)/2) > 1000
   AND  GRADE < 4;
   
   
--- Operadores de Comparacion de Caracteres  
--- (Comodin: % , Marcador de posicion: _ )  LIKE

SELECT EMPNO,ENAME
FROM EMP;

-- Listar el nombre de todos los empleados que empizan por A:
SELECT EMPNO,ENAME
FROM EMP
WHERE ENAME LIKE 'A%';

-- Listar el nombre de todos los empleados 
--cuyo nombre contiene una A:
SELECT EMPNO,ENAME
FROM EMP
WHERE ENAME LIKE '%A%';

-- Listar el nombre de todos los empleados 
--cuyo nombre tiene una A en la segunda letra de su nombre:
SELECT EMPNO,ENAME
FROM EMP
WHERE ENAME LIKE '_A%';

---  IS NULL     IS NOT NULL

SELECT EMPNO,ENAME,COMM
  FROM EMP;
-- WHERE COMM IS NULL;
 
SELECT EMPNO,ENAME,COMM
  FROM EMP
 WHERE COMM IS NULL;
 
 SELECT EMPNO,ENAME,COMM
  FROM EMP
 WHERE COMM IS NOT NULL;
 
SELECT EMPNO,ENAME,COMM
  FROM EMP
 WHERE COMM IS NOT NULL
   AND COMM <> 0;
   
SELECT EMPNO,ENAME,COMM
  FROM EMP
 WHERE COMM IS NOT NULL
   AND COMM != 0;
   
--Hasta ahora todas las comprobaciones logicas que hemos visto
-- comparaban una columna o expresion con un valor
-- por ejemplo JOB= 'MANAGER'
--Pero tambien podemos comparar una columna o una expresión
-- con una lista de valores utilizando los comparadores IN y BETWEEN
   
-- Comprobacion de conjunto de valores
-- Operador IN
-- expresion [NOT] IN (lista de valores separados por comas)
SELECT * 
  FROM EMP
 WHERE DEPTNO IN (20,30);
 
 SELECT * 
  FROM EMP
 WHERE DEPTNO NOT IN (20,30);

-- Comprobacion de conjunto de valores
-- Operador BETWEEN
-- expresion [NOT] BETWEEN valor_inicial AND valor_final

SELECT * 
  FROM EMP;

SELECT * 
  FROM EMP
 WHERE SAL BETWEEN 1000 AND 2000;


-- Combinacion de operadores AND y OR
---- !!! Mucho cuidado con el orden!!!
-- El orden de prioridad de los operadores es:
--- Primero NOT, luego AND y finalmente el OR
--- Para alterar este orden hay que poner parentesis.

 SELECT ENAME, JOB, SAL, DEPTNO 
  FROM EMP
 WHERE SAL > 2000 AND (DEPTNO=10 OR DEPTNO=20);
 

--- Si no le ponemos los parentesis el resultado sera distinto
SELECT ENAME, JOB, SAL, DEPTNO 
  FROM EMP
 WHERE SAL > 2000 AND DEPTNO=10 OR DEPTNO=20;

--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------    -------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------    -------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------

-- SUBCONSULTAS
-- A veces para realizar alguna operacion de consulta, 
-- necesitamos los datos devueltos por otra consulta; 
-- así, si queremos obterner los datos de los empleados 
-- que tienen el mismo oficio (JOB) que JONES,
-- hemos de averiguar el oficio de JONES, primera consulta, consulta hijo o consulta interna (se suele nombrar de cualquiera de esas tres formas).
-- Una vez conocido ese dato podemos averiguar los datos 
-- de los empleados que tienen ese oficio (JOB), segunda consulta, consulta padre, o consulta externa (se suele nombrar de cualquiera de esas tres formas).
-- Esto se puede resolver con una subconsulta (una SELECT dentro de una SELECT)
-- Una subconsulta consitira en incluir 
-- una declaracion SELECT como parte de una clausula WHERE

 SELECT ... 
   FROM ...
  WHERE columna    operador_comparativo   ( SELECT ...
											  FROM ...
											 WHERE ...);
											 

-----
SELECT * 
  FROM EMP;
----


-- Ejemplo: Para calcular los empleados que tienen el mismo trabajo que JONES
-- Opcion A (necesitamos dos consultas)
SELECT JOB
  FROM EMP
 WHERE ENAME = 'JONES';
 
SELECT ENAME
  FROM EMP
 WHERE JOB = 'MANAGER';

-- Opcion B (utilizando subconsultas) 
SELECT ENAME
  FROM EMP
 WHERE JOB    =   ( SELECT JOB
					  FROM EMP
					 WHERE ENAME = 'JONES');
--  
-- Condiciones de busqueda en subconsulta
--* Test de comparacion en subconsultas  ( <, >, <>, <=, >=, = )
-- Compara el valor de una expresion con un valor unico producido por una subconsulta.
-- Ejemplo: Obtener el nombre y el salario de aquellos 
-- empleados que tienen un sueldo mayor que JONES
SELECT ENAME, SAL 
  FROM EMP
 WHERE SAL    >   ( SELECT SAL
					  FROM EMP
					 WHERE ENAME = 'JONES');

--* Test de pertenencia a un conjunto devuelto por una subconsulta (IN)
-- Comprueba si el valor de una expresion coincide con uno del conjunto de valores 
-- producido por la subconsulta.
-- Ejemplo: Obterner el nombre de los empleados, cuyo oficio (JOB) 
-- sea alguno de los oficios que hay en el departamento 30

SELECT ENAME, DEPTNO,JOB 
  FROM EMP
 WHERE JOB    IN   ( SELECT JOB
					  FROM EMP
					 WHERE DEPTNO = 30);

--* Test de existencia (EXIST, NOT EXISTS)
-- Examina si una consulta produce alguna fila de reslutados. 
-- El test es TRUE si devuelve filas, si no es FALSE.
-- Ejemplo: Listar los departamentos que tengan empleados

SELECT * 
  FROM DEPT
 WHERE EXISTS  ( SELECT *
					      FROM EMP
					     WHERE EMP.DEPTNO = DEPT.DEPTNO);
					   
SELECT DEPTNO, DNAME 
  FROM DEPT;
  
SELECT ENAME, DEPTNO 
  FROM EMP;
  
-- Ejemplo: Listar los departamentos que NO tengan empleados

SELECT * 
  FROM DEPT
 WHERE NOT EXISTS  ( SELECT *
					      FROM EMP
					     WHERE EMP.DEPTNO = DEPT.DEPTNO);


--* Test de comparacion cuantificada ( ANY and ALL)
-- Se usan en conjuncion con los operadores de comparacion ( <, >, <>, <=, >=, = )

-- ANY compara el valor de una expresion con cada uno del conjunto de valores
-- producido en la subconsulta, si ALGUNA de las comparaciones individuales 
-- da como resultado TRUE, si la subconsulta no devuelva nada devolverá FALSE
-- Ejemplo: Obtener los datos de los empleados cuyo salario sea mayor 
-- a ALGUN salario de los empleados del departamento 30

SELECT ENAME, SAL, DEPTNO 
  FROM EMP
 WHERE SAL    > ANY   ( SELECT SAL
					      FROM EMP
					     WHERE DEPTNO = 30);

SELECT ENAME, SAL, DEPTNO 
  FROM EMP
 WHERE SAL    >    ( SELECT MIN(SAL)
					      FROM EMP
					     WHERE DEPTNO = 30);
						 
SELECT ENAME, SAL, DEPTNO 
  FROM EMP
 WHERE DEPTNO = 30;
						 
-- ALL compara el valor de una expresion con cada uno del conjunto de valores
-- producido en la subconsulta, si TODAS de las comparaciones individuales 
-- da como resultado TRUE, si la subconsulta no devuelva nada devolverá FALSE
-- Ejemplo: Obtener los datos de los empleados cuyo salario sea mayor 
-- a TODOS los salarios de los empleados del departamento 30

SELECT ENAME, SAL, DEPTNO 
  FROM EMP
 WHERE SAL    > ALL   ( SELECT SAL
					      FROM EMP
					     WHERE DEPTNO = 30);
						 
SELECT ENAME, SAL, DEPTNO 
  FROM EMP
 WHERE SAL    >    ( SELECT MAX(SAL)
					      FROM EMP
					     WHERE DEPTNO = 30);
						 											 

-- Subconsultas que generan valores simples:
-- Se trata de aquellas subconsultas que devuelven una fila o un valor simple,
-- en estas se utilizan los operadores de comparacion ( <, >, <>, <=, >=, = ).
-- Si la consulta devuelve más de una fila, se produce mensaje de error.
-- Ejemplo: Con la siguiente consulta se pretende obtener los nombres 
-- de los empleados cuyo oficio coincida con algun oficio del departamento 30 

SELECT ENAME, DEPTNO,JOB 
  FROM EMP
 WHERE JOB    =   ( SELECT JOB
					  FROM EMP
					 WHERE DEPTNO = 30);
					 
-- En el departamento 30 hay varios oficios (JOB), 
-- por tanto la subconsulta devuelve varias filas.
-- Por ello, cuando una subconsluta devueve más de una fila 
-- no se puede recurrir a los operadores de comparación.



-- Subconsultas que generan listas de valores
-- Son aquellas subconsultas que devuelven más de una fila
-- o más de un valor, usaremos el operador IN en la clausula WHERE.
-- La soulucion al ejmeplo anterio sería la siguiente.

SELECT ENAME, DEPTNO,JOB 
  FROM EMP
 WHERE JOB    IN   ( SELECT JOB
					  FROM EMP
					 WHERE DEPTNO = 30);
					 
-- El tipo de dato de la expresión situada después del WHERE 
-- debe coincidir con el tipo de dato devuelto por la subconsulta


-- Subconsultas correlacionadas
-- Una subconsulta correlacionada es aquella que hace referencia a una columna 
-- o varias de la consulta más externa. A veces la consulta hace uso
-- de columnas que tienen el mismo nombre que las coulmunas de las tablas 
-- de la consulta más externa. Si la subconsulta necesita acceder a esas coulumnas
-- deberá definirse un alias en la tabla más externa.
-- Ejemplo: Deseamos obtener los datos de los empleados 
-- cuyo salario sea el máximo de su departamento


SELECT *
  FROM EMP  E
 WHERE SAL    =   ( SELECT MAX (SAL)
					  FROM EMP
					 WHERE DEPTNO = E.DEPTNO);

SELECT ENAME, SAL, DEPTNO
  FROM EMP  E
 WHERE SAL    =   ( SELECT MAX (SAL)
					  FROM EMP
					 WHERE DEPTNO = E.DEPTNO);
					 
-- La subconsulta anterior devuelve, para cada fila que se recupere de la consulta mas externa,
-- el salario del departamento que se está recuperando en la consulta externa;
-- para referenciar a dicho departamenteo se necesita el alias E usado la tabla de la consulta externa
--Hemos utilizado tambien la funcion MAXIMO: MAX.

-- Sin utilizar la subconsulta anterior, 
-- huubieramos necesitado todas las consultas siguientes para obtener la misma informacion

SELECT ENAME, SAL, DETPNO
  FROM EMP
 WHERE DEPTNO = 10;	
 
 
SELECT MAX (SAL)
  FROM EMP
 WHERE DEPTNO = 10;	
 
SELECT ENAME, SAL, DETPNO
  FROM EMP
 WHERE DEPTNO = 20;	
 
SELECT ENAME, DEPTNO, MAX (SAL)
  FROM EMP
 WHERE DEPTNO = 20; 

 
SELECT ENAME, SAL, DETPNO
  FROM EMP
 WHERE DEPTNO = 30;	
 
SELECT ENAME, DEPTNO, MAX (SAL)
  FROM EMP
 WHERE DEPTNO = 30;


SELECT ENAME, SAL, DETPNO
  FROM EMP
 WHERE DEPTNO = 40;	 
 
SELECT ENAME, DEPTNO, MAX (SAL)
  FROM EMP
 WHERE DEPTNO = 40; 
					 

--- COMBINACION DE TABLAS (o CONSULTA MULTITABLA)
-- Sintaxis general:

SELECT columnas de las tablas citadas en la clausula "from"
  FROM TABLA1, TABLA2, ...
 WHERE TABLA1.COLUMNA = TABLA2=COLUMNA;
 
-- Hay veces que la consulta neceista columnas de varias tablas.
-- En este caso, a la derecha del FROM pondriamos todas las tablas que necesitaramos

-- Reglas:
-- Podemos unir tantas tablas como queramos
-- En la clausula SELECT se pueden citar coulmnas de todas las tablas.
-- Si hay columnas con el mismo nombre en las distintas tablas
-- de la clausula FROM, se deben identificar, especificando NombreTabla.NombreColumna

-- Si el nombre de una columna exite solo en una tabla, no será necesario
-- especificarla como NombreTabla.NombreColumna. Sin embargao, hacerlo mejoraria
-- la legilibilidad de la sentencia SELECT

-- El criterio que se siga para combinar las tablas ha de especificarse 
-- en la clausula WHERE. Si se omite esta clausula, que especifica la condicion de cominacion,
-- el resultado sera un PRODUCTO CARTESIANO, que emparejará todas las filas de una tabla
-- con cada fila de la otra.

SELECT * 
 FROM EMP;
 
SELECT *
  FROM DEPT;
  
-- Ejemplo: Queremos sacar en una consulta tanto el numero de empleado (EMPNO), nombre(ENAME), oficio(JOB), 
-- numero departamento (DETPNO), como el nombre del departamento (DNAME) y localidad del departamento (LOC) 
SELECT EMPNO, ENAME, JOB, DEPTNO 
  FROM EMP;
  
SELECT DEPTNO, DNAME, LOC 
  FROM DEPT;
  
-- En lugar de hacer dos consultas para cada una de las tablas, hacemos una COMBINACION DE TABLAS  

SELECT EMPNO, ENAME, JOB, DEPTNO, DNAME, LOC 
  FROM EMP, DEPT;
  
-- Esto nos daria error, pues DEPTNO pertenece a dos tabla.

-- Para solucionarlo hay que especificar el nombre de la tabla 
-- junto al nombre de la columna ambigua (la que esta en ambas tablas)
-- Ademas ponemos la clausula WHERE con la columna/s que tienen en comun las tablas
-- y por las que vamos a hacer la condicion

SELECT EMPNO, ENAME, JOB, EMP.DEPTNO, DNAME, LOC 
  FROM EMP, DEPT
 WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- Se ve mas claro poniendo ALIAS a las tablas

SELECT ALIAS_A.EMPNO, ALIAS_A.ENAME, ALIAS_A.JOB, ALIAS_A.DEPTNO, ALIAS_B.DNAME, ALIAS_B.LOC 
  FROM EMP  ALIAS_A, DEPT ALIAS_B
 WHERE ALIAS_A.DEPTNO = ALIAS_B.DEPTNO;
 
SELECT A.EMPNO, A.ENAME, A.JOB, A.DEPTNO, B.DNAME, B.LOC 
  FROM EMP  A, DEPT B
 WHERE A.DEPTNO = B.DEPTNO;

-- Si se omite esta clausula WHERE, que especifica la condicion de combinacion,
-- el resultado sera un PRODUCTO CARTESIANO, que emparejará todas las filas de una tabla
-- con cada fila de la otra

SELECT EMPNO, ENAME, JOB, EMP.DEPTNO, DNAME, LOC 
  FROM EMP, DEPT;
  
-- Esto de mas arriba nos saca el producto cartesiano y no es lo que queriamos en la consulta.
-- por eso en la COMBINACION DE TABLAS necesitamos la clausula WHERE formada correctamente
-- para obtener el resultado esperado.


--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------    -------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- ATENCION: A partir de aqui utilizamos el usuario alumno/alumno
--            Para los ejemplos debemos tener cargadas las tablas correspondientes.

------ LAS FUNCIONES  ------
-- Las funciones se usan dentro de expresiones y actuan con los valores de las columnas,
-- variables o constantes. Generalmente producen dos tipos diferentes de resultados:
-- unas producen una modificación de la información original (por ejemplo, poner en minuscula
-- una cadena que está en mayuscula); 
-- el resultado de otras indica alguna cosa sobre la información,
-- (por ejemplo, el numero de caracteres, que tiene una cadena). 
-- Las funciones se utilizan en las clausulas SELECT, WHERE y ORDER BY.
-- Es posible el anidamiento de funciones.
-- Existen 5 tipos de funciones:
-- a) Funciones Arimeticas
-- b) Funciones de Caracteres
-- c) Funciones de manejo de Fechas
-- d) Funciones de Conversion
-- e) Otras Funciones

------ FUNCIONES ARITMETICAS   ------
-- Las funciones aritmeticas trabajan con datos de tipo numerico NUMBER.
-- Este tipo incluye los digitos 0 a 9, el punto decimal y signo menos, si es necesario.
-- Los literales numericos no se encierran entre comillas. Ejemplo: -123.32

-- Podemos dividir las funciones Aritmeticas en tres grupos:

-- Funciones de valores simples
-- Funciones de grupos de valores
-- Funciones de listas

--FUNCIONES DE VALORES SIMPLES
--Son funciones sencillas que trabajan con valores simples.
-- Un valor simple es: un numero (6522,90), una variable  o una columna de una tabla
--Funcion ABS: Devuelve el valor absoluto de 'n'. El valor absoluto es siempre un numero positivo.
-- Ejemplo: Obten el valor Absoluto del salario - 200000

SELECT APELLIDO, SALARIO, SALARIO - 200000, ABS (SALARIO - 200000)
  FROM EMPLE;

--(vamos a utilizar la tabla DUAL, que solo tiene una tabla dummy para hacer los siguientes ejemplos)
--Funcion CEIL (n). Obtiene el valor entero inmediatamente superior o igual a 'n'
-- Ejemplo: Probamos con numeros positivos y negativos

SELECT CEIL(20.3), CEIL(16), CEIL(-20.3), CEIL(-16)
  FROM DUAL;

--Funcion FLOOR (n). Es lo opuesto a CEIL, devuelve el valor entero inmediatamente inferior o igual a 'n'
-- Ejemplo: Probamos con numeros positivos y negativos

SELECT FLOOR(20.3), FLOOR(16), FLOOR(-20.3), FLOOR(-16)
  FROM DUAL;

--Funcion MOD (m,n). Devuelve el resto resultante de dividir m entre n

SELECT MOD (11,4), MOD (10,-15), MOD (-10,-3), MOD (10.4,4.5)
  FROM DUAL;


--Funcion NVL (valor, expresion). Esta funcion se utiliza para sustituir un valor nulo
-- por otro valor. Si 'valor' es NULL, es sustituido por la 'expresion'; si no lo es,
-- la funcion devuelve 'valor' NVL se puede usar con cualquier tipo de datos: numerico,
-- caracter, tipo fecha, pero 'valor' y 'expresion' deben ser del mismo tipo.
-- Ejemplo:  A partir de la tabla EMPLE obtenemos el SALARIO, la COMISION y la suma de ambos

SELECT SALARIO, COMISION, SALARIO + COMISION
  FROM EMPLE;

-- Como vemos tenemos nulos en comision, podriamos aplicar la funcion NVL y el resultado seria:

SELECT SALARIO, COMISION, SALARIO + NVL(COMISION,0)
  FROM EMPLE;
  
-- En este otro ejemplo de arriba, al aplicar a la comision la funcion NVL en la columna
-- SALARIO+COMISION, no resultan valores nulos.
  
 --Funcion POWER(n, exponente). Calcula la potencia de un numero
 -- Calcula el valor de n elevado a un exponente.
 

SELECT POWER (2,4), POWER (2,-4), POWER(4.5,2)
  FROM DUAL; 
  
  
 --Funcion ROUND(numero [,m]): Devuelve el valor del numero redondeado a m decimales.
 --Si m es negativo, el redondeo de digitos se lleva a cabo a la izquierda del punto decimal
 
 SELECT ROUND (1.56, 1), ROUND (1.56), ROUND(1.2234, 2), ROUND(1.2676, 3), ROUND (1.55, 1),ROUND (1.56)
  FROM DUAL; 


 --Funcion SIGN(valor): Indica el signo del valor
 
 SELECT SIGN (-5), SIGN (3), SIGN (0)
  FROM DUAL; 
  

 --Funcion SQRT(n): Raiz cuadrada de n.  (n no puede ser negativo)
 
 SELECT SQRT(25)
  FROM DUAL; 
    
  
  --Funcion TRUNC(numero [,m]: 
  -- Trunca los numeros para que tengan un cierto numero de digitos de precision

  
  SELECT TRUNC(123.1234567, 4)
  FROM DUAL;  
  
  
 --FUNCIONES DE GRUPO DE VALORES
-- Hay funciones estadisticas como SUM, AVG, COUNT que actuan sobre un grupo de filas
-- 
--Funcion AVG: Calcula el valor medio (media aritmetica) ignorando los valores nulos

SELECT APELLIDO, COMISION
  FROM EMPLE
 WHERE DEPT_NO=30;



SELECT AVG (COMISION), NVL (COMISION,0)
  FROM EMPLE
 WHERE DEPT_NO=30;
  
--Funcion COUNT (expresion | * ): Cuenta el numero de veces que la expresion
-- evalua algun dato con valor no nulo. Con la opcion * cuenta el numero de filas


SELECT * 
 FROM EMPLE;
  
SELECT COUNT (*) 
 FROM EMPLE;
 
SELECT COUNT (COMISION) 
 FROM EMPLE;
  
 --Funcion MAX(expresion): Calcula el maximo de la expresion
SELECT MAX (SALARIO)
 FROM EMPLE;
 
 SELECT MAX (APELLIDO)
 FROM EMPLE;
 
SELECT MIN (APELLIDO)
 FROM EMPLE;
 
 --Obtener el apellido que tiene el maximo salario
 SELECT APELLIDO, SALARIO
 FROM EMPLE
 WHERE SALARIO = (SELECT MAX (SALARIO)
                    FROM EMPLE);
			
SELECT *
 FROM EMPLE
ORDER BY SALARIO DESC;
  
 --Funcion MIN: 
SELECT MIN (SALARIO)
 FROM EMPLE;
 
 SELECT MIN (APELLIDO)
 FROM EMPLE; 
 
 
--Obtener el apellido que tiene el minimo salario
 SELECT APELLIDO, SALARIO
 FROM EMPLE
 WHERE SALARIO = (SELECT MIN (SALARIO)
                    FROM EMPLE);
 

--Funcion SUM: Obtiene la suma de valores de la expresion distintos de nulos
 SELECT SUM (SALARIO)
 FROM EMPLE;

--Funcion VARIANCE: Obtiene la varianza de la expresion distintos de nulos
 SELECT VARIANCE (SALARIO)
 FROM EMPLE; 



-- DISTINCT en funciones de grupo
-- En todas las funciones de grupo , al indicar los argumentos se pueden emplear
-- las clausulas DISTINCT y ALL, aunque no se suelen utilizar en las funciones
-- AVG, SUM, MAX ni MIN. Sí es muy normal su uso en COUNT.
-- Recordemos que DISTINCT realiza una seleccion de filas cuyos valores en la 
-- columna especificada no están duplicados. 
-- La clausula ALL recoge todas las filas aunque sus valores esten duplicados
-- El formato de COUNT incluyendo DISTINCT y ALL es este:
-- COUNT( * | [DISTINCT|ALL] expresion )
--  Si COUNT recibe como argumento una expresion o columna esta podrá ser precedia 
-- por DISTINCT O ALL
-- 

SELECT *
  FROM EMPLE;
  
SELECT COUNT (OFICIO) 
  FROM EMPLE;

SELECT COUNT (DISTINCT OFICIO)
  FROM EMPLE;

SELECT DISTINCT OFICIO
  FROM EMPLE;

--FUNCIONES DE LISTAS
-- Trabajan sobre un grupo de columnas dentro de una misma fila.
-- Comparan los valores de cada una de las columnas en el interior
-- de una fila para obtener el mayor o menor valor de la lista.
-- Funcion GREATEST(valor1, valor2,...)
-- Funcion LEAST (valor1, valor2,...)
DESC NOTAS_ALUMNOS;

SELECT * 
  FROM NOTAS_ALUMNOS;

-- Obtener por cada alumno, la mayor nota y la menor nota de las tres que tiene.


 SELECT NOMBRE_ALUMNO, GREATEST (NOTA1, NOTA2, NOTA3),  LEAST (NOTA1, NOTA2, NOTA3)  
   FROM NOTAS_ALUMNOS;
   

--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------    -------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------  
------ FUNCIONES DE CADENAS DE CARACTERES   ------
-- Trabajan con datos de tipo CHAR o VARCHAR2.
-- Estos datos incluyen cualquier caracter alfanumerico:
-- letras, numeros, y caracteres especiales. Los caracteres
-- se deben encerrar entre comillas simples. Ejemplo 'El Quijote'
-- Las funciones de cadenas permiten manipular cadenas de letras
-- u otros caracteres.
-- Estas funciones pueden calcular el numero de caracteres de una cadena,
-- convertir una cadena a mayusculas o minusculas, suprimir o añadir
-- caracteres a la izquierda o la derecha.

-- Funciones que DEVUELVEN VALORES CARACTER

-- Funcion CHR(n): Devuelve el caracter cuyo valor en binario es equivalente a 'n'.
SELECT CHR(75), CHR(65)
  FROM DUAL; 

SELECT CHR('75'), CHR('65')
  FROM DUAL;    

  
-- Funcion CONCAT(cad1, cad2): Devuelve 'cad1' concatenada con 'cad2'. Es equivalente  al operador ||
 SELECT CONCAT ('El apellido es: ', APELLIDO)
   FROM EMPLE;  
   
-- La siguiente sentencia es equivalente y de hecho se suele utilizar mas:
 SELECT 'El apellido es: ' || APELLIDO
   FROM EMPLE;  


-- Funcion LOWER(cad): Devuelve 'cad' con todas sus letras en minusculas
 SELECT LOWER ('oRACle Y sqL') "minuscula"
   FROM DUAL;  
   
    SELECT LOWER (apellido) "minuscula"
   FROM emple; 
   
-- Funcion UPPER(cad): Devuelve 'cad' con todas sus letras en mayusculas
 SELECT UPPER ('oRACle Y sqL') "MAYUSCULA"
   FROM DUAL;  


-- Funcion INITCAP(cad): Devuelve la cadena 'cad' a tipo titulo,
-- la primera letra en Mayuscula y el resto en minusculas.
 SELECT INITCAP ('oRACle Y sqL') "Tipo Titulo"
   FROM DUAL;  

-- Funcion LPAD (cad1, n [,cad2]): Añade caracteres a la izquierda de cad1
-- hasta que alcance una cierta longitud n; cad2 es la cadena con que se rellena por la izquierda.
-- cad1 puede ser una columna de una tabla o cualquier literal. 
-- Si cad2 se suprime, asume como caracter de relleno el blanco.
 
 SELECT NOMBRE_ALUMNO
   FROM NOTAS_ALUMNOS;
 
 SELECT LPAD (NOMBRE_ALUMNO, 30,'.') "Rellena por izquierda"
   FROM NOTAS_ALUMNOS; 

 SELECT LPAD (NOMBRE_ALUMNO, 30) "Rellena por izquierda"
   FROM NOTAS_ALUMNOS;     

-- Funcion RPAD (cad1, n [,cad2]): Añade caracteres a la derecha de cad1
-- hasta que alcance una cierta longitud n; cad2 es la cadena con que se rellena por la derecha.
-- cad1 puede ser una columna de una tabla o cualquier literal. 
-- Si cad2 se suprime, asume como caracter de relleno el blanco.
-- Padding=rellenar

 SELECT RPAD (NOMBRE_ALUMNO, 30,'.') "Rellena por derecha"
  FROM NOTAS_ALUMNOS;  
  
-- Funcion LTRIM (cad [,set]): Suprime un conjunto de caracteres a la izquierda de cad
-- set es el conjunto de caracteres a suprimir por la izquierda.
-- Si set se omite, devuelve la misma cadena.
-- Por defecto, si la cadena contiene blancos a la izquierda y se omite el segundo parametro (set)
-- la funcion devuelve la cadena sin blancos a la izquierda.
-- Trim=podar

SELECT LTRIM ('hola', 'ho')
  FROM DUAL;

 SELECT LTRIM ('                hola')
  FROM DUAL;
  

-- Funcion RTRIM (cad [,set]): Suprime un conjunto de caracteres a la derecha de cad
-- set es el conjunto de caracteres a suprimir por la derecha.
-- Si set se omite, devuelve la misma cadena.
-- Por defecto, si la cadena contiene blancos a la derecha y se omite el segundo parametro (set)
-- la funcion devuelve la cadena sin blancos a la derecha.

  SELECT RTRIM ('adios', 'os')
  FROM DUAL;
  
 SELECT RTRIM ('adios', 'id')
  FROM DUAL;
 
 SELECT RTRIM ('adios                            ')
  FROM DUAL;
  
  
-- Funcion REPLACE(cad, cadena_busqueda [,cadena_sustitucion]): 
-- Sustituye un caracter con 0  o varios caracteres
-- Devuelve cad con cada ocurrencia de cadena_busqueda
-- sustituida por cadena_sustitucion
--Ejemplo: Sustituimos 'O' por 'AS' en la cadena 'BLANCO Y NEGRO'
 SELECT REPLACE ('BLANCO Y NEGRO', 'O', 'AS')
  FROM DUAL;

-- Si no ponemos la dadena de sustitucion, simplemente elimina ese caracter
  SELECT REPLACE ('BLANCO Y NEGRO', 'O')
  FROM DUAL;
  
  SELECT REPLACE ('BLANCO Y NEGRO', 'L')
  FROM DUAL;
  
-- Funcion SUBSTR(cad, m [,n]): 
-- Obtiene parte de una cadena.
-- Devuelve la subcadena de 'cad', que abarca desde la posicion indicada en m
-- hasta tantos caracteres como indique el numero 'n'. 
-- Si se omite 'n', devuelve la cadena desde la posición especificada por m.
-- El valor de n no puede ser inferior a 1. 
-- El valor de m puede ser negativo, en ese caso, devuelve la cadena empezando
-- por el final, y avanzando de derecha a izquierda.

--Ejemmplo: Partiendo de la cadena 'ABCDEFG' otenemos en una columna dos caracteres,
-- a partir de la tercera posicion.
SELECT SUBSTR ('ABCDEFG', 3,2)
  FROM DUAL;

--Ejemmplo: Partiendo de la cadena 'ABCDEFG' otenemos en una columna dos caracteres,
-- a partir de la tercera posicion (empezando a contar por el final).
SELECT SUBSTR ('ABCDEFG', -3,2)
  FROM DUAL;
  
--Ejemmplo: Partiendo de la cadena 'ABCDEFG' otenemos 
--los caracteres a partir de la posicion 4
SELECT SUBSTR ('ABCDEFG', 4)
  FROM DUAL;

-- Ejemplo: Visualiza el apellido y su primera letra de los empleados del departamento 10

 SELECT APELLIDO, SUBSTR (APELLIDO, 1,1)
   FROM EMPLE
  WHERE DEPT_NO=10;   
 
-- Ejemplo: Mostrar nombre y apellidos de cada alumnos junto con el nombre (SIN LOS APELLIDOS) de su tutor.
 
 SELECT NOMBRE_AL, SUBSTR( NOMBRE_PR,INSTR(NOMBRE_PR, ',')+2) TUTOR
	FROM ALUMNOS, PROFESORES
	WHERE COD_PR = TUTOR_AL; 
	
-- Ejemplo: Mostrar de cada alumno su código y sus apellidos (SIN EL NOMBRE) junto con el nombre y apellidos de su delegado.
 
 SELECT A.COD_AL, SUBSTR(A.NOMBRE_AL,1,INSTR(A.NOMBRE_AL,',')-1),B.NOMBRE_AL
	FROM ALUMNOS A, ALUMNOS B
	WHERE A.DELEGADO_AL = B.COD_AL
	ORDER BY COD_AL;

-- Funcion TRANSLATE(cad1, cad2, cad3): 
-- Convierte caracteres de una cadena en caracteres diferentes,
-- según un plan de sustitución marcadao por el usuari.
-- Devuelve 'cad1' con los caracteres encontrados en 'cad2' y sustituidos de 'cad3'
-- Cualquier caracter que  no esté en la cadea 'cad2' permanece como estaba.

-- Ejemplo:  A partir de la cadena 'LOS PILARES DE LA TIERRA', sustituye la 'A' por la 'a'
-- la 'E' por la 'e', la 'I' por la 'i', la 'O' por la 'o', la 'U' por la 'u'

SELECT TRANSLATE ('LOS PILARES DE LA TIERRA', 'AEIOU', 'aeiou')
 FROM DUAL;
 
-- En este ejemplo sustituimos la L por la l y las vocales por nada.
SELECT TRANSLATE ('LOS PILARES DE LA TIERRA', 'LAEIOU', 'l')
 FROM DUAL;
 
 SELECT TRANSLATE ('LOS PILARES DE LA TIERRA', 'O', 'oooo')
 FROM DUAL;

-- Funciones que devuelven valores numericos
-- Funicion ASCII(cad): Devuelve el valor ASCI de la primera letra de la cadena 'cad'
SELECT ASCII ('A') 
  FROM DUAL;
  
SELECT ASCII ('Andaluz') 
  FROM DUAL;
  
SELECT ASCII ('andaluz') 
  FROM DUAL;
  
SELECT ASCII ('a') 
  FROM DUAL;

--Funcion INSTR (cad1,cad2 [comienzo, [,m]])
-- Esta funcion busca un conjunto de caracteres en una cadena.
-- Devuelve la posicion de la 'm_ésima' ocurrencia de cad2 en cad1,
-- empezando la busqueda en la posicion comienzo.
-- Por omision empieza en la posicion 1.

-- Ejemplo: A partir de la cadena 'II VUELTA CICLISTA A TALAVERA'
-- encuentra la segunda ocurrencia de 'TA' desde la posicion 3.

SELECT INSTR ('II VUELTA CICLISTA A TALAVERA', 'TA', 3, 2)
  FROM DUAL;
-- (en este ejemplo, empezando por la posicion 3, 
--   devuelve la posicion de la segunda vez que aparece la cadena 'TA'

-- En el siguiente caso devuelve la posicion de la primera vez que aparce 'TA'  
SELECT INSTR ('II VUELTA CICLISTA A TALAVERA', 'TA')
  FROM DUAL;
  
-- Cuando comienzo es negativo (-1), se comienza en la posicion final y se va
-- y se va de derecha a izquierda en la cadena.
-- En este ejemplo nos devolverá la posicion, contando desde la izquierda,
-- de la primera A que se encuentra desde la primera posicion empezando desde el final.
SELECT INSTR ('II VUELTA CICLISTA A TALAVERA', 'A', -1)
  FROM DUAL;


--Funcion LENGTH(cad): Devuelve el numero de caracteres de la cadena cad
-- Ejemplo: Devuelve el numero de caracteres de los apellidos de la table Empleados:
 SELECT APELLIDO, LENGTH (APELLIDO)
   FROM EMPLE;

-------------------------------------------------------
------ FUNCIONES DE CADENAS DE MANEJO DE FECHAS  ------
-------------------------------------------------------

-- Oracle puede almacenar datos de tipo fecha (DATE) y posee una interesante utilidad
-- para formatear las fechas de cualquier manera que se pueda concebir.
-- Tiene un formato por omision 'DD/MM/YY', pero con TO_CHAR es posible mostrar las fechas
-- de cualquier modo. Los literales de fecha deben encerrarse entre comillas simples
-- Ejemplo: '17/12/20'
-- Recordad que el tipo de datos DATE se almacena en un formato especial que incluye:
-- Siglo/Año/Mes/Día/Hora/Minutos/Segundos

-- Funcion SYSDATE: Devuelve la fecha del sistema
SELECT SYSDATE
  FROM DUAL;
 
SELECT SYSDATE, SYSDATE+69
  FROM DUAL;

-- Funcion ADD_MONTHS(fecha, n) : Devuelve la fecha incrementada n meses)
SELECT FECHA_ALT, ADD_MONTHS(FECHA_ALT, 6)
  FROM EMPLE;

-- Funcion LAST_DAY(fecha): Devuelve la fecha del ultimo dia del mes que contiene fecha.
SELECT FECHA_ALT, LAST_DAY(FECHA_ALT)
  FROM EMPLE;
  
  
-- Funcion MONTHS_BETWEEN(fecha1,fecha2): Devuelve la diferencia en meses 
-- entre las fechas 'fecha1' y 'fecha2'
SELECT MONTHS_BETWEEN (SYSDATE, FECHA_ALT)
  FROM EMPLE;

-- Antiguedad de años en la empresa:
SELECT (MONTHS_BETWEEN (SYSDATE, FECHA_ALT)/12)
  FROM EMPLE;
  
-- Calculo de la edad, para alguien que nació el 11/08/1995:
SELECT TRUNC (MONTHS_BETWEEN (SYSDATE, '11/08/1998')/12) "Edad Actual"
  FROM DUAL;
  
-- Funcion NEXT_DAY(fecha, cad): Devuelve la fecha del primer dia 
-- de la semana indicado por cad despues de la fecha indicada por fecha.
-- El dia de la semana en cad se indica por su nombre (lunes, martes...)

-- Ejemplo: Si hoy es jueves 17 de Diciembre de 2020 ( fecha del sistema <<sysdate>>) , ¿que fecha será el proximo jueves?

SELECT NEXT_DAY(SYSDATE, 'JUEVES')
  FROM DUAL;

-------------------------------------------------------
------ FUNCIONES DE CONVERSION  ------
-------------------------------------------------------
-- Transforman los objetos de un tipo a otro.

-- Funcion TO_CHAR (fecha,  'formato'): Convierte una fecha de tipo DATE
-- a tipo VARCHAR2.  
-- El formato es una cadena de caracteres que puede incluir 
-- las mascaras definidas en oracle.
-- En estas mascaras es posible incluir literales definidos
-- por el usuario encerrados en comillas dobles.
-- (para detalle: buscar mascaras de control de formato de fechas en ORACLE).
SELECT FECHA_ALT,   TO_CHAR(FECHA_ALT, 'month DD, YYYY') 
 FROM EMPLE;
 
-- Por defecto el formato para la fecha viene definido por el parametro NLS_TERRITORY,
-- que especifica el idioma para le formato de fecha, los separadores de miles,
-- el signo decimal y el simbolo moneda. Este paramatro se inicializa al arrancar ORACLE
-- Para el idioma español, el valor de este parametro es: NLS_TERRITROY=SPAIN
-- Podemos cambiar el valor por omision para la fecha con el parametro NLS_DATE_FORMAT,
-- usando la orden ALTER SESSION.
-- Tambien podemos cambiar el lenguaje utilizado para nombrar los meses y los dias
-- con el parametro NLS_DATE_LANGUAGE
 
-- Funcion TO_CHAR (numero,  'formato'): Convierte un numero de tipo NUMBER
-- a tipo VARCHAR2.
-- (para detalle: buscar mascaras de control de formato numereicos en ORACLE).  
-- Por ejemplo para mostrar una cantidad con los separadores de miles 
-- y los decimales podemos usar la mascara 9G999G999D99
-- Ejemplo: Veamos. para el departamento 10, 
-- el salario medio con dos decimales y el maximo salario sin decimales
-- (ambos con las marcas de miles de separadores)
-- Antes veamos que tenmos en salario para ese departamento:

SELECT  SALARIO
	FROM EMPLE
	WHERE DEPT_NO = 10;

SELECT  TO_CHAR(AVG(SALARIO),'9G999G999D99'),
		TO_CHAR(MAX(SALARIO),'9G999G999')
	FROM EMPLE
	WHERE DEPT_NO = 10;



-- Funcion TO_DATE (cad,  'formato'): Convierte una cadena tipo VARCHAR2 o CHAR
-- a tipo DATE 
SELECT TO_DATE ('17122018')
FROM DUAL;

SELECT TO_DATE ('17012018')
FROM DUAL;

SELECT TO_DATE ('1712018')
FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';


-- Funcion TO_NUMBER (cadena,  [,'formato')]: Convierte la cadena al tipo NUMBER.
-- La cadena ha de contener numeros, el caracter decimal o el singo menos a la izquierda.
-- No puede haber espacios entre los numeros , ni otros caracteres.
SELECT TO_NUMBER ('-123456')
FROM DUAL;

SELECT TO_NUMBER ('-123,45','999D99')
FROM DUAL;


-------------------------------------------------------
------ OTRAS FUNCIONES  ------
-------------------------------------------------------

-- Funcion DECODE(var1,val1,cod1,val2,cod2..., valor_por_defecto)
-- Esta funcion sustituye un valor por otro.
-- Si var es igual a cualquier valor de  la lista val1,val2
-- devuelve el correspondiente codigo cod1,cod2

-- Ejemplo. En la tabla EMPLE, seleccionar todas las filas y codificar el OFICIO.
-- Si el oficio es PRESIDENTE, codificar con un 1, si es empleado con un 2,
-- en cualquier otro caso codificar con un 5.
SELECT APELLIDO, OFICIO
 FROM EMPLE;

SELECT APELLIDO, OFICIO, DECODE (UPPER(OFICIO), 'PRESIDENTE',1  ,'EMPLEADO',2,  5)
 FROM EMPLE;
 
Otras funciones:
VSIZE
DUMP
USER
UID

/*
--------------------------------------------------------------------------------------------------------------------------------------------------------
----------------               -------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------  
-----------------------------------------------
------ CLAUSULAS DE SELECCION AVANZADA   ------
-----------------------------------------------
Vamos a continuar  haciendo consultas a la base de datos.
Veremos nuevas clausulas, que acompañan a la sentencia SELECT
y que nos permiten hacer consultas más complejas.
Veremos  las ordenes que nos permiten agrupar filas de una
tabla segun alguna condicion, o sin ninguna condición, para
obterner algun resultado referente a ese grupo de filas agrupadas.
Un ejemplo sería averiguar la suma de salarios por cada departamento
de la tabla EMPLE
*/
/*
------ AGRUPACION DE ELEMENTOS: GROUP BY Y HAVING   ------
Hasta ahora hemos ultilizado la orden SELECT para recuperar filas
y la clausula WHERE para seleccionar el numero de filas que se recuperan.
También hemos empleado funciones de grupo para trabajar con conjuntos de filas.
Se puede pensar en estos conjuntos como si fueran un grupo, asi por ejemplo calculamos
el salario medio de todos los emplados: SELECT AVG (SALARIO ) FROM EMPLE
o la suma de todos los salarios: SELECT SUM (SALARIO) FROM EMPLE.

Pero a veces, nos interesa consultar los datos segun determinados grupos,
así para saber cual es el salario medio de cada departamento de la tabla EMPLE,
las clausulas que conocemos hasta ahora no son suficientes. Necesitamos agrupar
por departamento. Para ello utilizaremos la clausula GROUP BY.
*/

SELECT DEPT_NO, AVG(SALARIO)
FROM EMPLE
GROUP BY DEPT_NO;

-- Veamos que salario tienen en los distintos departamentos
-- para comprobar la media y la agrupacion que nos ha devuelto
-- la consulta anterior
SELECT DEPT_NO, SALARIO
FROM EMPLE
ORDER BY DEPT_NO DESC;

/* La sentencia SELECT posibilita agrupar uno o mas conjuntos de filas.
El agrupamiento se lleva a cabo medieante la clausula GROUP BY, por
las columnas especificadas y en el orden especificado. Este es su formato:
SELECT...
FROM...
GROUP BY columna1, columna2, columna3,...
HAVING condición
ORDER BY...

Los datos seleccionados en las sentencia SELECT que lleva el GROUP BY deben ser:
una constante, una funcion de grupo (SUM, COUNT, AVG, ...), una columna expresada
en el GROUP BY

La clausula GROUP BY sirve para calcular propiedades de uno o mas conjuntos de filas.
Ademas, si se selecciona mas de un conjunto de filas, GROUP BY controla que las filas 
de la tabla original sean agrupadas en una temporal.
Del mismo modoque existe la condicion de busqueda WHERE para filas individuales, 
tambien hay una condicion de busqueda para grupos de filas: HAVING.
La clausula HAVING se emplea para controlar cula de los conjuntos de filas
se visualiza. Se evalua sobra la tabla que devuelve el GROUP BY.
HAVING no puede existir sin GROUP BY.
*/
-- Ejemplo: 
-- Visaulziar a partir de la tabla EMPLE, el numero de empleados
-- de cada departamento.

SELECT DEPT_NO, COUNT(*)
FROM EMPLE
GROUP BY DEPT_NO;

-- Si en la consulta anterior solo queremos visualizar los departamentos
-- con mas de 4 empleados, tendriamos que utilizar la clausula HAVING-

SELECT DEPT_NO, COUNT(*)
FROM EMPLE
GROUP BY DEPT_NO
HAVING COUNT(*) > 4;

/* La clausula HAVING es similar a la clausula WHERE,
pero HAVING trabaja con grupos de filas, pregunta por
una caracteristica del grupo, es decir, pregunta por el resultado
de las funciones de grupo, lo cual WHERE no puede hacer.
En el ejemplo anterior, se visualizan las filas cuyo numero 
de empleados sea mayor a 4 (HAVING COUNT(*) >4).
*/
-- Si queremos ordenar el resultado, recuerda que se utiliza
-- la clausula ORDER BY

SELECT DEPT_NO, COUNT(*)
FROM EMPLE
GROUP BY DEPT_NO
HAVING COUNT(*) > 4
ORDER BY COUNT(*) ASC;

/* Cuando usamos la clausula ORDER BY con columnas Y funciones de grupo,
hemos de tener en cuena que ésta se ejecuta detrás de las cláusulas WHERE,
GROUP BY y HAVING. En ORDER BY podemos especificar funciones de grupo,
columnas de GROUP BY o su combinación.

La evaluación de las clausulas en tiempo de ejecución se efectua
en el siguiente orden:
WHERE   Seleccion de filas
GROUP BY Agrupa estas filas
HAVING Filtra los grupos. Selecciona y elimina grupos.
ORDER BY Clasifica las salida. Ordena los grupos
*/

--Ejemplo:
-- Obtén la suma de salarios, el saliro máximo y el salario mínimo
-- por cada departamento;


SELECT   DEPT_NO, 
         SUM(SALARIO) "Suma",
         MAX(SALARIO) "Maximo",
         MIN(SALARIO) "Minimo"
    FROM EMPLE
GROUP BY DEPT_NO;


-- Lo normal es que nos pidan que la SALIDA esté FORMATEADA, 
-- para ello: 
SELECT   DEPT_NO, 
         TO_CHAR (SUM(SALARIO), '999G999D99') "Suma",
         TO_CHAR (MAX(SALARIO), '999G999D99') "Maximo",
	     TO_CHAR (MIN(SALARIO), '999G999D99') "Minimo"
	FROM EMPLE
GROUP BY DEPT_NO;


-- La suma no coge por lo que tenemos que darle más digitos en el formateo:
SELECT   DEPT_NO, 
         TO_CHAR (SUM(SALARIO), '99G999G999D99') "Suma",
         TO_CHAR (MAX(SALARIO), '999G999D99') "Maximo",
	     TO_CHAR (MIN(SALARIO), '999G999D99') "Minimo"
	FROM EMPLE
GROUP BY DEPT_NO;

-- Otro Ejemplo:
-- Calcula el numero de empleados que realizan cada OFICIO en cada DEPARTAMENTO
-- Los datos que se visualizan son departamento, oficio y numero de empleados.
--

SELECT   DEPT_NO, OFICIO, COUNT (*) 
    FROM EMPLE
GROUP BY DEPT_NO, OFICIO;

-- Si queremos ordenarlo por Departamento:
SELECT   DEPT_NO, OFICIO, COUNT (*) 
    FROM EMPLE
GROUP BY DEPT_NO, OFICIO
ORDER BY DEPT_NO;

-- Otro Ejemplo:
-- Busca el numero máximo de empleados que hay en algún departamento

SELECT  MAX(COUNT(*)) "Num_Maximo_Empleados_en_Dpto"        
    FROM EMPLE
GROUP BY DEPT_NO;

--Vemos que realmente es asi:
SELECT   DEPT_NO, COUNT (*) 
    FROM EMPLE
GROUP BY DEPT_NO;


/*
------ Combinación externa (OUTER JOIN)   ------
Ya hemos tratado el concepto de combinacion de tablas.
Existe una variedad de combinacion de tablas que 
se llama OUTER JOIN, y que nos permite seleccionar algunas filas
de una tabla aunque éstas no tengan correspondencia con las filas
de otra tabla con la que combina. El formato es el siguiente:

SELECT tabla1.columna1, tabla1.columna2, tabla2.columna1
  FROM tabla1, tabla2
 WHERE tabla1.colum1 = tabla2.column1 (+) 
 
Esta SELECT seleccionará todas las filas de la tabla tabla1,
aunque no tengan correspondencia de la fila de la tabla2;
se denota con el simbolo (+) detrás de la columna de la tabla2
(que es la tabla donde no se encuentran las filas) en la clausula WHERE.
Se obtendrá una fila con las columnas del la tabla1 y elr esto de columnas
de la tabla2 se rellena con NULL
*/
 
 
-- Un ejemplo:
-- Aunque antes veamos el contenido de las tablas EMPLE y DEPART:
SELECT  *
  FROM EMPLE;
  
  SELECT *
    FROM DEPART
ORDER BY DEPT_NO;

-- Si nos fijamos vemos que en la tabla EMPLE, 
-- vemos que el departamento 40 no existe,
-- sin embargo en DEPART sí qu existe.

-- Queremos hacer una consulta donde se visualice  el numero de departamento,
-- el nombre y el numero de empleados que tiene. 
-- Para hacer esta consulta combinamos las dos tablas.

  SELECT D.DEPT_NO, DNOMBRE, COUNT (E.EMP_NO)
    FROM EMPLE E, DEPART D
   WHERE E.DEPT_NO = D.DEPT_NO 
GROUP BY D.DEPT_NO, DNOMBRE;

   DEPT_NO DNOMBRE        COUNT(E.EMP_NO)
---------- -------------- ---------------
        30 VENTAS                       6
        10 CONTABILIDAD                 3
        20 INVESTIGACION                5

-- Observamos que con esta sentencia solo aparecen los departamentos
-- que tienen empleados. El departamento 40 se pierde. 
-- Para que aparezca este departamento, que no corresponde con ninguna
-- fila en la tabla EMPLE, usamos la combinacion externa (OUTER JOIN),
-- para lo cual especificamos un (+) a continuacion del nombre de la columna
-- de la tabla en la que no aparece el departamento (la tabla EMPLE).

  SELECT D.DEPT_NO, DNOMBRE, COUNT (E.EMP_NO)
    FROM EMPLE E, DEPART D
   WHERE E.DEPT_NO (+) = D.DEPT_NO 
GROUP BY D.DEPT_NO, DNOMBRE;

   DEPT_NO DNOMBRE        COUNT(E.EMP_NO)
---------- -------------- ---------------
        30 VENTAS                       6
        10 CONTABILIDAD                 3
        40 PRODUCCION                   0
        20 INVESTIGACION                5

-- Analiza que ocurre si en lugar de poner COUNT(E.EMP_NO) ponemos COUNT(*)

  SELECT D.DEPT_NO, DNOMBRE, COUNT (*)
    FROM EMPLE E, DEPART D
   WHERE E.DEPT_NO (+) = D.DEPT_NO 
GROUP BY D.DEPT_NO, DNOMBRE;

-- Con COUNT(*) contaria las filas, en este caso contaría una fila.
-- Con COUNT(E.EMP_NO) cuenta valoes de EMP_NO distintos de nulo,
-- y si es nulo devuelve cero.

-- Analiza que ocurre si a la derecha de SELECT 
-- ponemos E.DEPT_NO en lugar de D.DEPT_NO

  SELECT E.DEPT_NO, DNOMBRE, COUNT (E.EMP_NO)
    FROM EMPLE E, DEPART D
   WHERE E.DEPT_NO (+) = D.DEPT_NO 
GROUP BY D.DEPT_NO, DNOMBRE;

-- Si colocamos E.DEPT_NO en lugar de D.DEPT_NO en la sentencia SELECT
-- la clausula GROUP BY tambien habría que cambiarla.
-- En este caso no se visualizaría numer de departamento 40 pues no existe
-- la tabla EMPLE
  SELECT E.DEPT_NO, DNOMBRE, COUNT (E.EMP_NO)
    FROM EMPLE E, DEPART D
   WHERE E.DEPT_NO (+) = D.DEPT_NO 
GROUP BY E.DEPT_NO, DNOMBRE;

/*
------ Operadores UNION, INTERSECT y MINUS   ------------
                  (union, interseccion y resta)
Los Operadores UNION, INTERSECT y MINUS son operadores de conjuntos.
Los conjuntos son las filas resultantes de cualquier sentencia SELECT valida
que permiten combinar los resultados de varias SELECT para obtener un unico resultado.

Supongamos que tenemos dos listas de centros de enseñanza de una ciudad y que
queremos enviar a esos centros una serie de paquetes de libros

Dependiendo de ciertas caracteristicas de los centros, podemos enviar libros a todos
los centros de ambas listas (UNION), 
a los centros que esten en las dos listas (INTERSECT)
o a los que están en una lista y no en otra lista (MINUS)

El formato de SELECT con estos operadores es el siguiente:
SELECT ... FROM ... WHERE ...
Operador_de_conjunto
SELECT ... FROM ... WHERE ...
*/

/*
------ Operador UNION --------------------------------
El Operador UNION combina los resultados de dos consultas.
Las filas duplicadas que aparecen se reducen a una fila única. 
Este es su formato; 

SELECT COL1,COL2,... FROM TABLA1 WHERE CONDICION
UNION
SELECT COL1,COL2,... FROM TABLA2 WHERE CONDICION
*/

-- Ejemplo: Dadas 3 tablas diferentes ALUM, NUEVOS y ANTIGUOS, 
-- ALUM:     nombres de los alumnos matriculados este curso
-- NUEVOS:   nombres de los que han reservado plaza para ser alumnos el siguiente curso
-- ANTIGUOS: nombres de los antiguos alumnos del centro escolar.

--Veamos que contienen cada una:

SELECT * 
  FROM ALUM;

NOMBRE                     EDAD LOCALIDAD
-------------------- ---------- ---------------
JUAN                         18 COSLADA
PEDRO                        19 COSLADA
ANA                          17 ALCALA
LUISA                        18 TORREJON
MARIA                        20 MADRID
ERNESTO                      21 MADRID
RAQUEL                       19 TOLEDO

7 filas seleccionadas.
  
SELECT * 
  FROM NUEVOS;

NOMBRE                     EDAD LOCALIDAD
-------------------- ---------- ---------------
JUAN                         18 COSLADA
MAITE                        15 ALCALA
SOFIA                        14 ALCALA
ANA                          17 ALCALA
ERNESTO                      21 MADRID  
  
  
SELECT * 
  FROM ANTIGUOS;
  
NOMBRE                     EDAD LOCALIDAD
-------------------- ---------- ---------------
MARIA                        20 MADRID
ERNESTO                      21 MADRID
ANDRES                       26 LAS ROZAS
IRENE                        24 LAS ROZAS

--Visualizar los nombres de los alumnos actuales y de los futuros alumnos.
--Para ello obtenemos utilizando UNION los nombres que aparezcan en ALUM y NUEVOS

SELECT NOMBRE 
  FROM ALUM
UNION 
SELECT NOMBRE 
  FROM NUEVOS;
  
NOMBRE
--------------------
ANA
ERNESTO
JUAN
LUISA
MAITE
MARIA
PEDRO
RAQUEL
SOFIA

9 filas seleccionadas.

-- Como vemos elimina duplicados


/*
------ Operador UNION ALL -------------------------------
El Operador UNION ALL combina los resultados de dos consultas.
cualquier duplicacion de filas aparecerá en la consulta

SELECT COL1,COL2,... FROM TABLA1 WHERE CONDICION
UNION ALL
SELECT COL1,COL2,... FROM TABLA2 WHERE CONDICION
*/

--Ejemplo:

SELECT NOMBRE 
  FROM ALUM
UNION ALL
SELECT NOMBRE 
  FROM NUEVOS;

NOMBRE
--------------------
JUAN
PEDRO
ANA
LUISA
MARIA
ERNESTO
RAQUEL
JUAN
MAITE
SOFIA
ANA
ERNESTO

12 filas seleccionadas.


/*
------ Operador INTERSECT --------------------------------
El Operador INTERSECT devuelve las filas que son iguales en ambas consultas.
Las filas duplicadas serán eliminadas antes de la generación del resultado final.  
Este es su formato; 

SELECT COL1,COL2,... FROM TABLA1 WHERE CONDICION
INTERSECT
SELECT COL1,COL2,... FROM TABLA2 WHERE CONDICION
*/

--Ejemplo:
-- Obtener los nombres de los alumnos que están actualmente en el centro y que
-- también estuvieron en el centro hace ya un tiempo.

SELECT NOMBRE 
  FROM ALUM
INTERSECT
(SELECT NOMBRE 
  FROM ANTIGUOS
  UNION
  SELECT NOMBRE 
  FROM NUEVOS);

NOMBRE
--------------------
ERNESTO
MARIA
  
-- Nota: Esta misma consulta tambien se puede hacer utilizando el operador IN:






SELECT NOMBRE 
  FROM ALUM
WHERE  NOMBRE IN (SELECT NOMBRE       
                    FROM ANTIGUOS);



/*
------ Operador MINUS --------------------------------------
El Operador MINUS devuelve las filas que están en la primera SELECT
y no en la segunda SELECT.
Las filas duplicadas del primer conjunto se reducirán a una unica fila
antes de que empiece la comparacion con el otro conjunto.
Este es su formato; 

SELECT COL1,COL2,... FROM TABLA1 WHERE CONDICION
MINUS
SELECT COL1,COL2,... FROM TABLA2 WHERE CONDICION
*/

-- Ejemplo: Obtener los alumnos y la localidad de los alumnos
-- que están actualmente en el centro pero que nunca estuvieron anteriormente en él.

SELECT NOMBRE,LOCALIDAD
  FROM ALUM
MINUS
SELECT NOMBRE,LOCALIDAD 
  FROM ANTIGUOS;
  
NOMBRE               LOCALIDAD
-------------------- ---------------
ANA                  ALCALA
JUAN                 COSLADA
LUISA                TORREJON
PEDRO                COSLADA
RAQUEL               TOLEDO

-- Nota: Esta misma consulta tambien se puede hacer utilizando el operador NOT IN:




SELECT NOMBRE,LOCALIDAD 
  FROM ALUM
WHERE  NOMBRE NOT IN (SELECT NOMBRE       
                        FROM ANTIGUOS);
						
--Mas ejemplos de operadores UNION, INTERSECT y MINUS

-- Seleccionamos los nombres de la tabla ALUM que estan en NUEVOS y no en ANTIGUOS.
SELECT NOMBRE
  FROM ALUM
INTERSECT
SELECT NOMBRE
  FROM NUEVOS
MINUS 
SELECT NOMBRE
  FROM ANTIGUOS;
  
NOMBRE
--------------------
ANA
JUAN

-- Nota: Esta misma consulta tambien se puede hacer utilizando el operador IN:						
SELECT NOMBRE
  FROM ALUM
WHERE  NOMBRE IN (SELECT NOMBRE       
                    FROM NUEVOS
				  MINUS
				  SELECT NOMBRE
                    FROM ANTIGUOS);
						
NOMBRE
--------------------
JUAN
ANA
						
-- Que tambien es equivalente a:

SELECT NOMBRE
  FROM ALUM
WHERE  NOMBRE IN (SELECT NOMBRE       
                    FROM NUEVOS
				  WHERE NOMBRE NOT IN (SELECT NOMBRE
                                         FROM ANTIGUOS));

NOMBRE
--------------------
JUAN
ANA


--Otro ejemplo:

-- Seleccionamos los nombres de la tabla ALUM que estan en NUEVOS o en ANTIGUOS.


SELECT NOMBRE 
  FROM ALUM
WHERE  NOMBRE IN (SELECT NOMBRE   
                    FROM NUEVOS    
				  UNION
				  SELECT NOMBRE
                    FROM ANTIGUOS);
NOMBRE
--------------------
JUAN
ANA
MARIA
ERNESTO


-- Nota: Esta misma consulta tambien se puede hacer sin usar el operador UNION,
-- recurriendo al operador OR. 

SELECT NOMBRE 
  FROM ALUM
 WHERE  NOMBRE IN (SELECT NOMBRE   
                    FROM NUEVOS)    
    OR  NOMBRE IN (SELECT NOMBRE  
                    FROM ANTIGUOS);
					
NOMBRE
--------------------
JUAN
ANA
MARIA
ERNESTO

-- Hemos de tener en cuenta que el uso de operadores de conjunto 
-- en lugar de IN, NOT IN, AND, OR  es decision del programador.

/*
------ Reglas para la utilizacion de operadores de conjuntos ----------------
Los operadores de conjuntos pueden encadenarse. 
Los conjuntos se evaluan de izquierda a derecha; para forzar precedencia se pueden
utilizar parentesis.

Estos operadores se pueden manejar con consultas de diferentes tablas, 
siempre que se apliquen las siguientes reglas:

-Las columnas de las dos consultas se relacionan en orden, de izquierda a derecha
-Los nombres de columna de la primera sentencia SELECT no tienen por qué ser 
los mismos que los nombres de la columna de la segunda 
-Las select necesitan tener el mismo numero de columnas
-Los tipos de datos deben coincidir, aunque la longitud no tiene que ser la misma.

*/