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
		EXIT WHEN C_SALARIO%ROWCOUNT = 6 OR C_SALARIO%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('El empleado ' || apellido || ' recibe un salario de ' || salario);
	END LOOP;
	CLOSE C_SALARIO;
END PR_SALARIO_EMPLE;
/

EXEC PR_SALARIO_EMPLE;

--5. Codificar un programa que visualice los dos empleados que ganan menos de cada oficio.
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE PR_SALARIO_EMPLE_OFICIO
IS
    CURSOR C_SALARIO_OFICIO IS
        SELECT OFICIO, APELLIDO, SALARIO
        FROM EMPLE
        ORDER BY OFICIO, SALARIO ASC;
    oficio EMPLE.OFICIO%TYPE;
    apellido EMPLE.APELLIDO%TYPE;
    salario EMPLE.SALARIO%TYPE;     
    empleados_por_oficio NUMBER := 0;
    oficio_anterior EMPLE.OFICIO%TYPE;
BEGIN
    OPEN C_SALARIO_OFICIO;
    LOOP
        FETCH C_SALARIO_OFICIO INTO oficio, apellido, salario;
        EXIT WHEN C_SALARIO_OFICIO%NOTFOUND;
        IF empleados_por_oficio < 2 OR oficio != oficio_anterior THEN
            DBMS_OUTPUT.PUT_LINE('El empleado ' || apellido || ' del oficio ' || oficio || ' recibe un salario de ' || salario);
		ELSE
			empleados_por_oficio := 0;
        END IF;
		empleados_por_oficio := empleados_por_oficio + 1;
        oficio_anterior := oficio;
    END LOOP;
    CLOSE C_SALARIO_OFICIO;
END PR_SALARIO_EMPLE_OFICIO;
/

EXEC PR_SALARIO_EMPLE_OFICIO;

--6. Escribir un programa que muestre los siguientes datos:
SET SERVEROUTPUT ON
    --A. Para cada empleado: apellido y salario.
    --B. Para cada departamento: Número de empleados y suma de los salarios del departamento.
    --C. Al final del listado: Número total de empleados y suma de todos los salarios.
CREATE OR REPLACE PROCEDURE PR_MOSTRAR_INFORMACION
IS
    CURSOR C_SALARIO IS
		SELECT APELLIDO, SALARIO
		FROM EMPLE
		ORDER BY SALARIO DESC;
	CURSOR C_CONT_EMPLE IS
		SELECT DNOMBRE, COUNT(APELLIDO), SUM(SALARIO)
		FROM DEPART D, EMPLE E
		WHERE D.DEPT_NO = E.DEPT_NO
		GROUP BY DNOMBRE;
	departamento DEPART.DNOMBRE%TYPE;
	apellido EMPLE.APELLIDO%TYPE;
	salario EMPLE.SALARIO%TYPE;
    emple_total NUMBER := 0;
    salario_total NUMBER := 0;
BEGIN
    OPEN C_SALARIO;
	LOOP
		FETCH C_SALARIO INTO apellido, salario;
		EXIT WHEN C_SALARIO%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Empleado: ' || apellido || ' |Salario: ' || salario);
	END LOOP;
	CLOSE C_SALARIO;
	OPEN C_CONT_EMPLE;
	LOOP
		FETCH C_CONT_EMPLE INTO departamento, apellido, salario;
		EXIT WHEN C_CONT_EMPLE%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('Departamento: ' || departamento || ' Cantidad trabajadores: ' || apellido || ' Suma de sus salarios: ' || salario);
		emple_total := emple_total + apellido;
		salario_total := salario_total + salario;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Total de empleados: ' || emple_total || ' Total salario: ' || salario_total);
	CLOSE C_CONT_EMPLE;
END PR_MOSTRAR_INFORMACION;
/

EXEC PR_MOSTRAR_INFORMACION;

--7. Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
SET SERVEROUTPUT ON
    --A. Se pasará al procedimiento el nombre del departamento y la localidad.
    --B. El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la tabla.
    --C. Se incluirá gestión de posibles errores.
CREATE OR REPLACE PROCEDURE PR_INSERT_DEPART(nombre_dep VARCHAR2, loc VARCHAR2)
AS
	CURSOR C_DEP IS 
		SELECT DNOMBRE
		FROM DEPART WHERE DNOMBRE = nombre_dep;
	comprobacion DEPART.DNOMBRE%TYPE DEFAULT NULL;
	ultimo_num DEPART.DEPT_NO%TYPE;
	nombre_duplicado EXCEPTION;
BEGIN
	OPEN C_DEP;
		FETCH C_DEP INTO comprobacion;
	CLOSE C_DEP;
	IF comprobacion IS NOT NULL THEN
		RAISE nombre_duplicado;
	END IF;
	SELECT MAX(DEPT_NO) INTO ultimo_num FROM depart; 
	INSERT INTO depart VALUES ((TRUNC(ultimo_num, -1)+10), nombre_dep, loc);
EXCEPTION
	WHEN nombre_duplicado THEN
		DBMS_OUTPUT.PUT_LINE('[ERROR] Este departamento ya existe.');
END PR_INSERT_DEPART;
/

EXEC PR_INSERT_DEPART('INVESTIGACION', 'MADRID');

--8. Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, gestionando posibles errores:
SET SERVEROUTPUT ON
    --A. No existe el departamento.
    --B. No existe el empleado jefe.
	--C. Si ya existía el empleado.
CREATE OR REPLACE PROCEDURE PR_ALTA_EMPLE(num_emple EMPLE.EMP_NO%TYPE, apellidos EMPLE.APELLIDO%TYPE, oficio EMPLE.OFICIO%TYPE, jefe_depart EMPLE.DIR%TYPE, fecha_alt EMPLE.FECHA_ALT%TYPE, salario EMPLE.SALARIO%TYPE, comision EMPLE.COMISION%TYPE DEFAULT NULL, departamento EMPLE.DEPT_NO%TYPE)
AS
	comprobacion_jefe EMPLE.DIR%TYPE DEFAULT NULL;
	comprobacion_depart DEPART.DEPT_NO%TYPE DEFAULT NULL;
BEGIN
	COMMIT;
	SELECT DEPT_NO INTO comprobacion_depart
	FROM DEPART WHERE DEPT_NO = departamento;
	
	SELECT EMP_NO INTO comprobacion_jefe 
	FROM EMPLE WHERE EMP_NO = jefe_depart;
	
	INSERT INTO EMPLE VALUES (num_emple, apellidos, oficio, jefe_depart, fecha_alt, salario, comision, departamento);
	COMMIT;
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		IF comprobacion_depart IS NULL THEN
		RAISE_APPLICATION_ERROR(-20005, '[ERROR] Departamento inexistente.');
		ELSIF comprobacion_jefe IS NULL THEN
		RAISE_APPLICATION_ERROR(-20005,	'[ERROR] No existe el jefe.');
		ELSE
		RAISE_APPLICATION_ERROR(-20005,	'[ERROR] Datos no encontrados.');
		END IF;
	WHEN DUP_VAL_ON_INDEX THEN
		DBMS_OUTPUT.PUT_LINE('[ERROR] Numero de empleado duplicado.');
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('[ERROR] Surgio un error inesperado.');
	ROLLBACK;
END PR_ALTA_EMPLE;
/

EXEC PR_ALTA_EMPLE(9999, 'lucia','profesora',7698,'20/02/1980', 208000,39000,30);

--9. Codificar un procedimiento reciba como parámetros un numero de departamento, un importe y un porcentaje; 
--y suba el salario a todos los empleados del departamento indicado en la llamada. La subida será el porcentaje o el importe indicado en la llamada (el que sea más beneficioso para el empleado en cada caso empleado).
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE PR_SUBIDA_SALARIO(num_depar EMPLE.DEPT_NO%TYPE, importe NUMBER, porcentaje NUMBER)
AS
	CURSOR C_SAL IS SELECT SALARIO,ROWID
	FROM EMPLE WHERE DEPT_NO = num_depar;
	v_salario C_SAL%ROWTYPE;
	import_pct NUMBER(10);
BEGIN
	OPEN C_SAL;
	FETCH C_SAL INTO v_salario;
	WHILE C_SAL%FOUND LOOP
		import_pct := GREATEST(v_salario.SALARIO*(porcentaje/100), importe);
		UPDATE EMPLE SET SALARIO=SALARIO + import_pct
		WHERE ROWID = v_salario.rowid;
		FETCH C_SAL INTO v_salario; 
	END LOOP; 
	CLOSE C_SAL; 
EXCEPTION 
	WHEN NO_DATA_FOUND THEN 
		DBMS_OUTPUT.PUT_LINE('[ERROR] Ninguna fila actualizada.');
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('[ERROR] Surgio un error inesperado.');
	ROLLBACK;
END PR_SUBIDA_SALARIO;
/

EXEC PR_SUBIDA_SALARIO(20, 390, 30);


--10. Escribir un procedimiento que suba el sueldo de todos los empleados que ganen menos que el salario medio de su oficio. La subida será de el 50% de la diferencia entre el salario del empleado y la media de su oficio. Se deberá asegurar que la transacción no se quede a medias, y se gestionarán los posibles errores.
SET SERVEROUTPUT ON
