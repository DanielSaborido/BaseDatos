--EJEMPLO1:
-- Crear un cursor explicito
-- para visualizar el nombre y la localidad de todos
-- los departamentos de la tabla DEPART

DECLARE
	CURSOR CUR1 IS
		SELECT  DNOMBRE,LOC FROM DEPART;
		V_NOMBRE DEPART.DNOMBRE%TYPE;
		V_NOMBRE DEPART.DNOMBRE%TYPE;
BEGIN
	OPEN CUR1;
	LOOP
	FETCH CUR1 INTO V_NOMBRE, V_LOCALIDAD;
	 EXIT WHEN CUR1%NOTFOUND;
	 DBMS_OUTPUT.PUT_LINE(V_NOMBRE || ' está en:' || V_LOCALIDAD);
	END LOOP;
	CLOSE CUR1;
END;
/


--EJEMPLO2:
-- Utilizando un cursor explicito
-- visualizar los apellidos de los empleados
-- pertenecientes al departamento 20
-- numerandolos secuencialmente . pista: utilizar %ROWCOUNT

DECLARE
	CURSOR CUR2 IS
		SELECT  APELLIDO FROM EMPLE WHERE DEPT_NO=20;
		V_APELLIDO EMPLE.APELLIDO%TYPE;

BEGIN
	OPEN CUR2;
	LOOP
	FETCH CUR2 INTO V_APELLIDO;
	EXIT WHEN CUR2%NOTFOUND;
	 DBMS_OUTPUT.PUT_LINE(TO_CHAR(CUR2%ROWCOUNT,'99.') || V_APELLIDO);
	END LOOP;
	CLOSE CUR2;
END;
/


--EJEMPLO3:
-- Para cualquier departamento, visualizar los apellidos de sus empleados.
-- Utiliza un procedimiento en el que pasandole por parametro
---el departamento, lo utilize en el cursor para ir procesando los empleados
-- de dicho departamento y mostrando sus apellidos.

CREATE OR REPLACE PROCEDURE VER_EMPLE_POR_DEPT( DEP VARCHAR2)
AS
    V_DEPT NUMBER(2); 
	CURSOR VER_EMPLE_POR_DEPT IS
		SELECT  APELLIDO FROM EMPLE WHERE DEPT_NO=V_DEPT;
		V_APELLIDO EMPLE.APELLIDO%TYPE;

BEGIN
    V_DEPT := DEP;
	OPEN VER_EMPLE_POR_DEPT;
	LOOP
	FETCH VER_EMPLE_POR_DEPT INTO V_APELLIDO;
     EXIT WHEN VER_EMPLE_POR_DEPT%NOTFOUND;
	 DBMS_OUTPUT.PUT_LINE( V_APELLIDO);
	END LOOP;
	CLOSE VER_EMPLE_POR_DEPT;
END;
/

--Ejecutalo:
EXEC VER_EMPLE_POR_DEPT(30);

