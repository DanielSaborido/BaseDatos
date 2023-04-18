---------------------------------------------------------------------------
SET SERVEROUTPUT ON
---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE LISTADO
IS
	CURSOR c_centros IS	
		SELECT *
		FROM CENTROS;
	CURSOR c_departamentos (cod CENTROS.COD_CE%TYPE) IS
		SELECT COD_DE, NOMBRE_DE, PRESUPUESTO_DE, NOMBRE_EM
		FROM DEPARTAMENTOS, EMPLEADOS
		WHERE DIRECTOR_DE = COD_EM
			AND Centro_de = cod;
	CURSOR c_empleados(cod DEPARTAMENTOS.COD_DE%TYPE) IS
		SELECT COD_EM, NOMBRE_EM, APELLIDOS_EM, Numhijos_em, SALARIO_EM
		FROM EMPLEADOS
		WHERE DPTO_EM = cod;
BEGIN
	FOR r1 IN c_centros LOOP
		DBMS_OUTPUT.PUT_LINE('Centro: '||r1.Nombre_ce||' ('||r1.Dir_ce);
		FOR r2 IN c_departamentos(r1.COD_CE) LOOP
			DBMS_OUTPUT.PUT_LINE('.   Departamento: '||r2.Cod_de||': '||r2.Nombre_de||' ('||r2.Presupuesto_de||') Director: '||r2.Nombre_em);
			FOR r3 IN c_empleados(r2.COD_de) LOOP
				DBMS_OUTPUT.PUT_LINE('.        '||r3.Cod_em||' '||r3.Nombre_em||' '||r3.Apellidos_em||' '||r3.Numhijos_em||' '||r3.Salario_em);
			END LOOP;
		END LOOP;
	END LOOP;

--EXCEPTION

END LISTADO;
/