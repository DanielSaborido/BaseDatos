--EJEMPLO1:
-- Crear un cursor explicito
-- para visualizar el nombre y la localidad de todos
-- los departamentos de la tabla DEPART

DECLARE
	CURSOR LISTADO_DEP IS
		SELECT  DNOMBRE,LOC FROM DEPART;
		nombre DEPART.DNOMBRE%TYPE;
		loc DEPART.LOC%TYPE;
BEGIN
	OPEN LISTADO_DEP;
	LOOP
		FETCH LISTADO_DEP INTO nombre, loc;
		EXIT WHEN LISTADO_DEP%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('El departamento de ' || nombre || ' esta en:' || loc);
	END LOOP;
	CLOSE LISTADO_DEP;
END;
/


--EJEMPLO2:
-- Utilizando un cursor explicito
-- visualizar los apellidos de los empleados
-- pertenecientes al departamento 20
-- numerandolos secuencialmente . pista: utilizar %ROWCOUNT

CREATE OR REPLACE PROCEDURE LISTADO_EMP( DEP NUMBER)
AS
	DEPT NUMBER(2);
	CURSOR LISTADO_EMP IS
		SELECT  APELLIDO FROM EMPLE WHERE DEPT_NO=DEPT;
		apellido EMPLE.APELLIDO%TYPE;
BEGIN
	DEPT := DEP;
	OPEN LISTADO_EMP;
	LOOP
		FETCH LISTADO_EMP INTO apellido;
		EXIT WHEN LISTADO_EMP%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(TO_CHAR(LISTADO_EMP%ROWCOUNT,'99.') || apellido);
	END LOOP;
	CLOSE LISTADO_EMP;
END;
/

EXEC LISTADO_EMP(20);

--EJEMPLO3:
-- Para cualquier departamento, visualizar los apellidos de sus empleados.
-- Utiliza un procedimiento en el que pasandole por parametro
---el departamento, lo utilize en el cursor para ir procesando los empleados
-- de dicho departamento y mostrando sus apellidos.

CREATE OR REPLACE PROCEDURE EMP_DEP( DEP NUMBER)
AS
    DEPT NUMBER(2); 
	CURSOR EMP_DEP IS
		SELECT  APELLIDO FROM EMPLE WHERE DEPT_NO=DEPT;
		apellido EMPLE.APELLIDO%TYPE;
BEGIN
    DEPT := DEP;
	OPEN EMP_DEP;
	LOOP
		FETCH EMP_DEP INTO apellido;
		EXIT WHEN EMP_DEP%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE( apellido);
	END LOOP;
	CLOSE EMP_DEP;
END;
/

EXEC EMP_DEP(30);
