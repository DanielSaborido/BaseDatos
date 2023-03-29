-----------------------------------------------------
-- Cursor implícito con variable (SELECT INTO)
-----------------------------------------------------
DECLARE
	reg		Empleados%ROWTYPE;
	i		number := 1;
BEGIN
	LOOP
		SELECT * INTO reg
		FROM Empleados
		WHERE COD_EM = i;
		DBMS_OUTPUT.PUT_LINE(reg.cod_em||' '||reg.nomb_em);
		i := i + 1;
		EXIT WHEN i > 30;
	END LOOP;
END;
/

-----------------------------------------------------
-- Cursor explícito (Definido antes del BEGIN variable)
-----------------------------------------------------
DECLARE
	codigo EMPLEADOS.cod_em%type;
	CURSOR Ejemplo IS 
		SELECT COD_EM, NOMB_EM, SALARIO_EM, NOMB_DE
		FROM EMPLEADOS, DEPARTAMENTOS
		WHERE COD_DE = DEPT_EM
			AND COD_EM < codigo;
	reg		Ejemplo%ROWTYPE;
BEGIN
	codigo := 15;
	OPEN Ejemplo;
	LOOP
		FETCH Ejemplo INTO reg;
		EXIT WHEN Ejemplo%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(reg.cod_em||' '||reg.nomb_em);
		DBMS_OUTPUT.PUT_LINE(reg.salario_em||' '||reg.nomb_de);
	END LOOP;
	CLOSE Ejemplo;
END;
/

-----------------------------------------------------
-- Bucle de CURSOR
-----------------------------------------------------
DECLARE
	codigo EMPLEADOS.cod_em%type:=15;
	CURSOR Ejemplo IS 
		SELECT COD_EM, NOMB_EM, SALARIO_EM, NOMB_DE
		FROM EMPLEADOS, DEPARTAMENTOS
		WHERE COD_DE = DEPT_EM
			AND COD_EM < codigo;
BEGIN
	FOR reg IN Ejemplo LOOP
		DBMS_OUTPUT.PUT_LINE(reg.cod_em||' '||reg.nomb_em);
		DBMS_OUTPUT.PUT_LINE(reg.salario_em||' '||reg.nomb_de);
	END LOOP;
END;
/













