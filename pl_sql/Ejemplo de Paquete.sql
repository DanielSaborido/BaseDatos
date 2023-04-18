-- Especificación de un paquete
CREATE OR REPLACE PACKAGE pk_Prueba AS
	CURSOR c_emple IS 
		SELECT APELLIDO, FECHA_ALT
		FROM EMPLE
		ORDER BY APELLIDO;
	v_apellido VARCHAR2(10);
	v_fecha DATE;
	PROCEDURE ver_emple1;
	FUNCTION anios_dif (fecha1 DATE,fecha2 DATE) RETURN NUMBER;
END pk_Prueba;
/
-- Cuerpo de un paquete
CREATE OR REPLACE PACKAGE BODY pk_Prueba AS
	-- Procedimiento ver_emple1
	PROCEDURE ver_emple1 AS
	BEGIN
		OPEN c_emple;
		FETCH c_emple into v_apellido, v_fecha;
		WHILE c_emple%FOUND LOOP
			DBMS_OUTPUT.PUT_LINE( v_apellido||' * '||v_fecha);
			FETCH c_emple into v_apellido,v_fecha; 
		END LOOP;
		CLOSE c_emple;
	END ver_emple1;
	-- Funcion anios_dif
	FUNCTION anios_dif (
		fecha1 DATE,
		fecha2 DATE)
		RETURN NUMBER
	AS
		v_anios_dif NUMBER(6);
	BEGIN
		v_anios_dif := ABS(TRUNC(MONTHS_BETWEEN(fecha2,fecha1)
	 / 12));
		RETURN v_anios_dif;
	END anios_dif;
END pk_Prueba;
/
-- Uso de un cursor definido en un paquete
BEGIN
	FOR REG IN pk_Prueba.c_emple LOOP
		DBMS_OUTPUT.PUT_LINE( REG.APELLIDO||' * '||REG.FECHA_ALT);
	END LOOP;
END;
/
-- Uso de un procedimiento definido en un paquete
BEGIN
	pk_Prueba.ver_emple1;
END;
/
-- Uso de una función definida en un paquete
SELECT NOMB_EM, pk_Prueba.anios_dif(FECNAC_EM, SYSDATE) EDAD FROM EMPLEADOS;