TAREA ENTREGABLE 2023 (EX2017. EJ1, EJE4, EJE5)

Nombre: <daniel saborido torres>

Fecha: <9/5/2023>


------------------------------------------------------------------------
	INSTRUCCIONES:
	==============
-Salva este fichero con las iniciales de tu nombre y apellidos
	Ejemplo:	Tomas Coronado García
			TCG.sql
			
-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. 
Es lo que voy a evaluar, si lo pierdes o no entregas el fichero correcto, 
es tu responsabilidad.

- No está permitido el uso de internet, se puede utilizar, exclusivamente
y como referencia, la teoria hecha en clase.

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Entra en la consola del Oracle 10g EX "SQL Plus" con tu usuario y contraseña

-Carga el script para el examen desde el fichero "Empresa.sql".



	PUNTUACIÓN
	==========

- Se considerará para la evaluación:
	- Que funcione resolviendo el problema solicitado
	- Estilo de programación 
	- Tratamiento de excepciones
	- Control del bloqueo de la tabla/columna en caso de actualizaciones
	- Gestión de transacciones
	- Código reutilizable y paramétrico
	- Uso de comentarios
	- Limpieza de codigo, bien identado y legible
	- Nomenclatura correcta

------------------------------------------------------------------------

	Descripción de las tablas:
	==========================

CENTROS
-------
# COD_CE		NUMBER(2)		Código del Centro
* DIRECTOR_CE	NUMBER(6)		Director del Centro
  NOMB_CE		VARCHAR2(30)	Nombre del Centro (O)
  DIRECC_CE		VARCHAR2(50)	Dirección del Centro (O)
  POBLAC_CE		VARCHAR2(15)	Población del Centro (O)

DEPARTAMENTOS
-------------
# COD_DE		NUMBER(3)		Código del Departamento
* DIRECTOR_DE	NUMBER(6)		Director del Departamento
* DEPTJEFE_DE	NUMBER(3)		Departamento del que depende
* CENTRO_DE		NUMBER(2)		Centro trabajo (O)
  NOMB_DE		VARCHAR2(40)	Nombre del Departamento (O)
  PRESUP_DE		NUMBER(11)		Presupuesto del Departamento (O)
  TIPODIR_DE	CHAR(1)			Tipo de Director del Departamento (O)

EMPLEADOSADOS
---------
# COD_EM		NUMBER(6)		Código del EMPLEADOSado
* DEPT_EM		NUMBER(3)		Departamento del EMPLEADOSado (O)
  EXTTEL_EM		CHAR(9)			Extensión telefónica
  FECINC_EM		DATE			Fecha de incorporación del EMPLEADOSado (O)
  FECNAC_EM		DATE			Fecha de nacimiento del EMPLEADOSado (O)
  DNI_EM		VARCHAR2(9)		DNI del EMPLEADOSado (U)
  NOMB_EM		VARCHAR2(40)	Nombre del EMPLEADOSado (O)
  NUMHIJ_EM		NUMBER(2)		Número de hijos del EMPLEADOSado (O)
  SALARIO_EM	NUMBER(9)		Salario Anual del EMPLEADOSado (O)
  COMISION_EM	NUMBER(9)		Comisión del EMPLEADOSado

HIJOS
-----
#*PADRE_HI		NUMBER(6)		Código del EMPLEADOSado
# NUMHIJ_HI		NUMBER(2)		Número del hijo del EMPLEADOSado
  FECNAC_HI		DATE			Fecha de nacimiento del Hijo (O)
  NOMB_HI		VARCHAR2(40)	Nombre del Hijo (O)



Nota: 
	# PRIMARY KEY
	* FOREIGN KEY
	(O) Obligatorio
	(U) Único
	
------------------------------------------------------------------------
(4 PUNTOS)
1.- Diseña el procedimiento "PR_ModComision" que establezca la comisión de los EMPLEADOSados 
que trabajan en los centros de:
	- "Madrid", el 10% de su salario.
	- "Sevilla", el 15%. 
	- "Huelva", un 20%. 
	Todos EMPLEADOSados tendrán un incremento de 100 euros en la comisión 
	por cada año de antigüedad en la empresa.
	
Código:

CREATE OR REPLACE PROCEDURE PR_ModComision
AS
	CURSOR C_COM_MA IS 
	SELECT COMISION_EM
		FROM EMPLEADOS WHERE DEPT_EM = (SELECT COD_DE 
											FROM DEPARTAMENTOS 
											WHERE CENTRO_DE = (SELECT COD_CE 
																FROM CENTROS 
																WHERE UPPER(POBLAC_CE) LIKE 'MADRID'));
		
	CURSOR C_COM_SE IS 
	SELECT COMISION_EM
		FROM EMPLEADOS WHERE DEPT_EM = (SELECT COD_DE 
											FROM DEPARTAMENTOS 
											WHERE CENTRO_DE = (SELECT COD_CE 
																FROM CENTROS 
																WHERE UPPER(POBLAC_CE) LIKE 'SEVILLA'));
		
	CURSOR C_COM_HU IS 
	SELECT COMISION_EM
		FROM EMPLEADOS WHERE DEPT_EM = (SELECT COD_DE 
											FROM DEPARTAMENTOS 
											WHERE CENTRO_DE = (SELECT COD_CE 
																FROM CENTROS 
																WHERE UPPER(POBLAC_CE) LIKE 'HUELVA'));
	
	comision EMPLEADOSADOS.COMISION_EM%TYPE;
BEGIN
	--calcular las comisiones de los trabajadores en madrid
	OPEN C_COM_MA;
	FETCH C_COM_MA INTO comision;
	WHILE C_COM_MA%FOUND LOOP
		UPDATE EMPLEADOS SET COMISION_EM = SALARIO * 0.1;
	END LOOP; 
	CLOSE C_COM_MA; 
	COMMIT;
	--calcular las comisiones de los trabajadores en sevilla
	OPEN C_COM_SE;
	FETCH C_COM_SE INTO comision;
	WHILE C_COM_SE%FOUND LOOP
		UPDATE EMPLEADOS SET COMISION_EM = SALARIO * 0.15;
	END LOOP; 
	CLOSE C_COM_SE; 
	COMMIT;
	--calcular las comisiones de los trabajadores en huelva
	OPEN C_COM_HU;
	FETCH C_COM_HU INTO comision;
	WHILE C_COM_HU%FOUND LOOP
		UPDATE EMPLEADOS SET COMISION_EM = SALARIO * 0.2;
	END LOOP; 
	CLOSE C_COM_HU; 
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('[ERROR] Surgio un error inesperado.');
	ROLLBACK;
END PR_ModComision;
/

Resultado:


------------------------------------------------------------------------------------------------------------------------------------------------
(3 PUNTOS)
4.- Crea la función "FN_Aniversario" que se le pase como parámetro una fecha 
y que devuelva TRUE o FALSE si hoy fuera el aniversario algo que ocurrió en esa fecha.

Código:

CREATE OR REPLACE PROCEDURE FN_Aniversario(fecha DATE)
AS
	CURSOR C_FECHA IS 
	SELECT COUNT(COD_EM)
		FROM EMPLEADOS WHERE FECINC_EM LIKE '%'||TO_CHAR(fecha,'DD/MM')||'%';
	
	cod_em EMPLEADOS.COD_EM%TYPE;
BEGIN
	OPEN C_FECHA;
	LOOP
		FETCH C_FECHA INTO cod_em;
		EXIT WHEN C_FECHA%NOTFOUND;
	END LOOP;
	IF cod_em != 0 THEN
		DBMS_OUTPUT.PUT_LINE('Hoy es el aniversario de ' || cod_em || ' trabajadores.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Hoy no hay aniversario.');
	END IF;
	CLOSE C_FECHA;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('[ERROR] Surgio un error inesperado.');
	ROLLBACK;
END FN_Aniversario;
/

Resultado:

EXEC FN_Aniversario(SYSDATE);
Hoy es el aniversario de 1 trabajadores.

EXEC FN_Aniversario('20/12/2000');
Hoy no hay aniversario.

------------------------------------------------------------------------------------------------------------------------------------------------
(3 PUNTOS)
5.- Diseña el procedimiento "PR_ListarAniversario" que genere un listado 
en el que se vea cada EMPLEADOSado con su fecha de incorporación 
a la empresa indicando "Aniversario" a aquellos EMPLEADOSados  
que hoy sea el aniversario de su incorporación a la empresa, 
indicando el total de personas que lo cumplen.

	Ejemplo.:
		Segura Viudas, Santiago	04/05/90		Aniversario 	
		Rivera Calvete, José Mª	02/06/95
		Conan Bárbaro, Mari		12/06/99
		Martinez, Rompetechos	04/05/07		Aniversario 

		Total Aniversario: 2
		
Código:

CREATE OR REPLACE PROCEDURE PR_ListarAniversario(fecha DATE)
AS
	CURSOR C_FECHA IS 
	SELECT FECINC_EM, NOMB_EM
		FROM EMPLEADOS;
	
	fecinc_em EMPLEADOS.FECINC_EM%TYPE;
    nomb_em EMPLEADOS.NOMB_EM%TYPE;
    aniversario NUMBER := 0;
BEGIN
	OPEN C_FECHA;
	LOOP
		FETCH C_FECHA INTO fecinc_em, nomb_em;
		EXIT WHEN C_FECHA%NOTFOUND;
		IF fecinc_em LIKE '%'||TO_CHAR(fecha,'DD/MM')||'%' THEN
			DBMS_OUTPUT.PUT_LINE(nomb_em || ' ' || fecinc_em || ' Aniversario');
			aniversario := aniversario + 1;
		ELSE
			DBMS_OUTPUT.PUT_LINE(nomb_em || ' ' || fecinc_em);
		END IF;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Hoy se celebran ' || aniversario || ' aniversarios');
	CLOSE C_FECHA;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('[ERROR] Surgio un error inesperado.');
	ROLLBACK;
END PR_ListarAniversario;
/

Resultado:

EXEC PR_ListarAniversario(SYSDATE);

Arias Grillo, Jairo                 24/02/2022
Arnaldos Valle, Javier              14/12/2022
Avila Ferrete, Raquel Maria         21/05/2022
Cabrera Alava, Kilian               19/07/2022
Calderon Diaz, Daniel               20/06/2022
Calvo Jimenez, Alberto              09/11/2020
Camacho Lindsey, Daniel             15/11/2022
Conde Alvarez, Jose Antonio         28/10/2021
Del Junco Suarez, Malvina           09/05/2023 Aniversario
Fernandez Benito, Javier            21/05/2022
Gallego Carvajal, Juan              31/07/2021
Garcia Vazquez, Jose Manuel         19/07/2022
Gata Masero, Carlos                 28/10/2021
Gil Campos, David                   07/01/2021
Gomez Alba, Gonzalo                 13/01/2023
Jimenez Campos, Alejandro           27/11/2021
Jimenez Garcia, Jose Manuel         10/04/2023
Leon Vazquez, Rafael                28/10/2021
Marquez Funes, Marcos               08/03/2021
Matito Lozano, Carmen               18/08/2022
Menacho Cabo, Pedro Jose            25/01/2022
Mendizabal Romero, Luis             13/01/2023
Montane Rodriguez, Francisco Javier 02/06/2021
Montes Rodriguez, Victor            15/11/2022
Perez Alvarez, Javier               09/12/2020
Pineda Santos, Jose Manuel          28/10/2021
Pires Barranco, Amador Claudio      16/10/2022
Pozo Martin, Ismael                 15/11/2022
Punta Perez, Gonzalo                04/05/2021
Reina Ramirez, Joaquin Javier       28/10/2021
Rivas Barba, Miguel                 07/01/2021
Rolo Vera, Luis Miguel              22/04/2022
Rufo Rodriguez, Alejandro           09/11/2020
Toscano Fernandez, Juan             07/01/2021
Valverde Gallego, Enrique           02/07/2021
Hoy se celebran 1 aniversarios