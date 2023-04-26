SET SERVEROUTPUT ON
...
END;

SHOW ERROR

--1. Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.
SET SERVEROUTPUT ON

DECLARE
	CURSOR LISTADO_EMPLE IS
		SELECT APELLIDO, FECHA_ALT FROM EMPLE ORDER BY APELLIDO;
		apellido EMPLE.APELLIDO%TYPE;
		fecha EMPLE.FECHA_ALT%TYPE;
BEGIN
	OPEN LISTADO_EMPLE;
	LOOP
		FETCH LISTADO_EMPLE INTO apellido, fecha;
		EXIT WHEN LISTADO_EMPLE%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(TO_CHAR(LISTADO_EMPLE%ROWCOUNT,'99.') || ' ' || apellido || ' ' || fecha);
	END LOOP;
	CLOSE LISTADO_EMPLE;
END;
/

--2. Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE PR_CONT_EMPLE
IS
	CURSOR C_CONT_EMPLE IS
		SELECT DNOMBRE, COUNT(APELLIDO)
		FROM DEPART D, EMPLE E
		WHERE D.DEPT_NO = E.DEPT_NO(+)
		GROUP BY DNOMBRE;
		departamento DEPART.DNOMBRE%TYPE;
		apellido EMPLE.APELLIDO%TYPE;
BEGIN
	OPEN C_CONT_EMPLE;
	LOOP
		FETCH C_CONT_EMPLE INTO departamento, apellido;
		EXIT WHEN C_CONT_EMPLE%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('En el departamento de ' || departamento || ' trabajan ' || apellido || ' trabajadores.');
	END LOOP;
	CLOSE C_CONT_EMPLE;
END PR_CONT_EMPLE;
/

EXEC PR_CONT_EMPLE;

--3. Escribir un procedimiento que reciba una cadena y visualice el apellido y el número de empleado de todos los empleados
--cuyo apellido contenga la cadena especificada. Al finalizar visualizar el número de empleados mostrados.
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE PR_VISTA_APELL(cadena VARCHAR2)
IS
	CURSOR C_VISTA_APELL IS
		SELECT APELLIDO, EMP_NO
		FROM EMPLE
		WHERE UPPER(APELLIDO) LIKE UPPER('%'||cadena||'%');
		apellido EMPLE.APELLIDO%TYPE;
		numero EMPLE.EMP_NO%TYPE;
BEGIN
	OPEN C_VISTA_APELL;
	LOOP
		FETCH C_VISTA_APELL INTO apellido, numero;
		EXIT WHEN C_VISTA_APELL%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('El empleado ' || apellido || ' tiene por numero de empleado: ' || numero);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Cantidad de empleados con la cadena introducida: ' || C_VISTA_APELL%ROWCOUNT);
	CLOSE C_VISTA_APELL;
END PR_VISTA_APELL;
/

EXEC PR_VISTA_APELL('o');

--4. Escribir un programa que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE PR_SALARIO_EMPLE
IS
	CURSOR C_SALARIO IS
		SELECT APELLIDO, SALARIO
		FROM EMPLE
		ORDER BY SALARIO DESC;
		apellido EMPLE.APELLIDO%TYPE;
		salario EMPLE.SALARIO%TYPE;
BEGIN
	OPEN C_SALARIO;
	LOOP
		FETCH C_SALARIO INTO apellido, salario;
		EXIT WHEN C_SALARIO%ROWCOUNT=6 OR C_SALARIO%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('El empleado ' || apellido || ' recibe un salario de ' || salario);
	END LOOP;
	CLOSE C_SALARIO;
END PR_SALARIO_EMPLE;
/

EXEC PR_SALARIO_EMPLE;

--5. Codificar un programa que visualice los dos empleados que ganan menos de cada oficio.
SET SERVEROUTPUT ON

--6. Escribir un programa que muestre los siguientes datos:
SET SERVEROUTPUT ON
    --A. Para cada empleado: apellido y salario.
    --B. Para cada departamento: Número de empleados y suma de los salarios del departamento.
    --C. Al final del listado: Número total de empleados y suma de todos los salarios.
--7. Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
SET SERVEROUTPUT ON
    --A. Se pasará al procedimiento el nombre del departamento y la localidad.
    --B. El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la tabla.
    --C. Se incluirá gestión de posibles errores.
--8. Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, gestionando posibles errores:
SET SERVEROUTPUT ON
    --A. No existe el departamento.
    --B. No existe el empleado jefe.
	--C. Si ya existía el empleado.
--9. Codificar un procedimiento reciba como parámetros un numero de departamento, un importe y un porcentaje; y suba el salario a todos los empleados del departamento indicado en la llamada. La subida será el porcentaje o el importe indicado en la llamada (el que sea más beneficioso para el empleado en cada caso empleado).
SET SERVEROUTPUT ON

--10. Escribir un procedimiento que suba el sueldo de todos los empleados que ganen menos que el salario medio de su oficio. La subida será de el 50% de la diferencia entre el salario del empleado y la media de su oficio. Se deberá asegurar que la transacción no se quede a medias, y se gestionarán los posibles errores.
SET SERVEROUTPUT ON
