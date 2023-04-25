SET SERVEROUTPUT ON
...
END;

SHOW ERROR

--1. Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.

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


--3. Escribir un procedimiento que reciba una cadena y visualice el apellido y el número de empleado de todos los empleados cuyo apellido contenga la cadena especificada. Al finalizar visualizar el número de empleados mostrados.


--4. Escribir un programa que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.


--5. Codificar un programa que visualice los dos empleados que ganan menos de cada oficio.


--6. Escribir un programa que muestre los siguientes datos:


    --A. Para cada empleado: apellido y salario.


    --B. Para cada departamento: Número de empleados y suma de los salarios del departamento.


    --C. Al final del listado: Número total de empleados y suma de todos los salarios.


--7. Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:


    --A. Se pasará al procedimiento el nombre del departamento y la localidad.


    --B. El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la tabla.


    --C. Se incluirá gestión de posibles errores.


--8. Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, gestionando posibles errores:


    --A. No existe el departamento.


    --B. No existe el empleado jefe.


    --C. Si ya existía el empleado.


--9. Codificar un procedimiento reciba como parámetros un numero de departamento, un importe y un porcentaje; y suba el salario a todos los empleados del departamento indicado en la llamada. La subida será el porcentaje o el importe indicado en la llamada (el que sea más beneficioso para el empleado en cada caso empleado).


--10. Escribir un procedimiento que suba el sueldo de todos los empleados que ganen menos que el salario medio de su oficio. La subida será de el 50% de la diferencia entre el salario del empleado y la media de su oficio. Se deberá asegurar que la transacción no se quede a medias, y se gestionarán los posibles errores.