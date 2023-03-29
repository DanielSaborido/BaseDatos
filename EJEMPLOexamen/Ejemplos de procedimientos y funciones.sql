**********************************************************************************
Procedimiento que muestra los n primeros nº pares
*/
CREATE OR REPLACE PROCEDURE MOSTRAR_N
	(num IN NUMBER) 
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Los 10 primeros pares:');
	FOR i IN 1..num LOOP
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END MOSTRAR_N;
/-- Para la compilación del bloque

----------------------------------------------
-- Para probarlo
----------------------------------------------
EXEC MOSTRAR_N(7);

/**********************************************************************************
Crear un procedimiento que reciba como parámetro un código de empleado y nos muestre por pantalla el nombre, apellidos, salario y nombre del departamento donde trabaja, si existe un empleado con dicho código. En caso contrario, un mensaje de error que indique que el empleado con ese código no existe.
*/
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE ListaEmple(
	p_cod	IN	Empleados.Cod_em%TYPE )
 IS
	salario			Empleados.Salario_em%TYPE;
	apellido		Empleados.Apellidos_em%TYPE;
	nombre			Empleados.Nombre_em%TYPE;
	departamento	Departamentos.Nombre_de%TYPE;
BEGIN
	SELECT  salario_em, apellidos_em, nombre_em, nombre_de
	INTO salario, apellido, nombre, departamento
	FROM Empleados, Departamentos
	WHERE Dpto_em = cod_de
		AND cod_em = p_cod;
	DBMS_OUTPUT.PUT_LINE(salario||' '||apellido||', '||nombre||' '||departamento);
EXCEPTION
	WHEN NO_DATA_FOUND THEN 
	DBMS_OUTPUT.PUT_LINE('No existe el empleado: '||p_cod);
END ListaEmple;
/

/**********************************************************************************
Crear una función que reciba como parámetros dos fechas y devuelva el número de años transcurridos entre ambos. Nota: El orden de los dos parámetros DATE debe ser irrelevante.
*/
----------------------------------------------
-- Sin variables locales
----------------------------------------------
CREATE OR REPLACE FUNCTION EDAD
	(f1 IN DATE, f2 IN DATE) 
	RETURN NUMBER
IS
BEGIN
	RETURN ABS(TRUNC(MONTHS_BETWEEN(f1,f2)/12));
END EDAD;
/
----------------------------------------------
-- Con variables locales
----------------------------------------------
CREATE OR REPLACE FUNCTION EDAD(
	fecha1 DATE, fecha2 DATE) 
	RETURN NUMBER
 IS
	nYear	NUMBER;
BEGIN
    nYear := months_between(fecha1, fecha2)/12;
	nYear := TRUNC(nYear);
	
	RETURN ABS(nYear);
END EDAD;
/
----------------------------------------------
-- Para probarlo
----------------------------------------------
SELECT NOMBRE_AL, EDAD(FECNAC_AL, SYSDATE) EDAD
 FROM ALUMNOS;
 