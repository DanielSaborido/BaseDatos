-- Para activar la salida por pantalla de la consola
SET SERVEROUTPUT ON
----------------------
-- Con bucle LOOP
----------------------
DECLARE 
	i BINARY_INTEGER := 1;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Los 10 primeros pares:');
	LOOP
		DBMS_OUTPUT.PUT_LINE(i*2);
		i := i + 1;
		EXIT WHEN (i > 10);
	END LOOP;
END;
/

----------------------
-- Con bucle WHILE
----------------------
DECLARE 
	i BINARY_INTEGER := 1;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Los 10 primeros pares:');
	WHILE (i <= 10) LOOP
		DBMS_OUTPUT.PUT_LINE(i*2);
		i := i + 1;
	END LOOP;
END;
/

----------------------
-- Con bucle FOR 
----------------------
BEGIN
	DBMS_OUTPUT.PUT_LINE('Los 10 primeros pares:');
	FOR i IN 1..10 LOOP
		DBMS_OUTPUT.PUT_LINE(i*2);
	END LOOP;
END;
/

BEGIN
	DBMS_OUTPUT.PUT_LINE('Los 10 primeros pares en orden inverso:');
	FOR i IN REVERSE 1..10 LOOP
		DBMS_OUTPUT.PUT_LINE(i*2);
	END LOOP;
END;
/