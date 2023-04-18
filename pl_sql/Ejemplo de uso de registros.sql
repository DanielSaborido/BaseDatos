DECLARE 
	TYPE TEmple IS RECORD (
		FECHA	DATE,
		NOMBRE	EMPLEADOS.Nombre_em%TYPE
	);
	vEmple1	TEmple;	
	vEmple2	EMPLEADOS%ROWTYPE;
	FECHA	DATE;
	NOMBRE	VARCHAR2(30);
	codigo  EMPLEADOS.cod_em%TYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('-   Con las variables NOMBRE y DNI');
	codigo := 900;
	SELECT Nombre_em, FechaNac_em INTO NOMBRE, FECHA
	FROM EMPLEADOS
	WHERE COD_EM = codigo;
	DBMS_OUTPUT.PUT_LINE(NOMBRE);
	DBMS_OUTPUT.PUT_LINE(FECHA);
	DBMS_OUTPUT.PUT_LINE('-   Con la variable vEmple1 del tipo registro definido TEmple');
	SELECT FechaNac_em, Nombre_em INTO vEmple1
	FROM EMPLEADOS;
	DBMS_OUTPUT.PUT_LINE(vEmple1.NOMBRE);
	DBMS_OUTPUT.PUT_LINE(vEmple1.FECHA);
	DBMS_OUTPUT.PUT_LINE('-   Con la variable vEmple2 del tipo registro de la tabla');
	codigo := 300;
	SELECT FechaNac_em, Nombre_em INTO vEmple2.FechaNac_em, vEmple2.Nombre_em
	FROM EMPLEADOS
	WHERE COD_EM = codigo;
	DBMS_OUTPUT.PUT_LINE(vEmple2.FechaNac_em);
	DBMS_OUTPUT.PUT_LINE(vEmple2.Nombre_em);
	DBMS_OUTPUT.PUT_LINE('-   Con la variable vEmple2 del tipo registro de la tabla');
	codigo := 400;
	SELECT * INTO vEmple2
	FROM EMPLEADOS
	WHERE COD_EM = codigo;
	DBMS_OUTPUT.PUT_LINE(vEmple2.Nombre_em);
	DBMS_OUTPUT.PUT_LINE(vEmple2.FechaNac_em);
	DBMS_OUTPUT.PUT_LINE(vEmple2.FechaIng_em);
	DBMS_OUTPUT.PUT_LINE(vEmple2.Salario_em);
	DBMS_OUTPUT.PUT_LINE(vEmple2.Apellidos_em);
	DBMS_OUTPUT.PUT_LINE('Te da cuen');
	
EXCEPTION
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('Devuelve mas de una fila');
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No existe el codigo '||codigo);
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('no Te da cuen');
END;
/