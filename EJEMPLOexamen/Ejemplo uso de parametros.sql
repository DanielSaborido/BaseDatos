SET SERVEROUTPUT ON
-- Procedimiento
CREATE OR REPLACE PROCEDURE Ejemplo02(
	p1	IN	NUMBER,
	p2	OUT	NUMBER,
	p3	IN OUT	NUMBER
	) AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Antes de modificar los argumentos');
	DBMS_OUTPUT.PUT_LINE('p1: '||p1);
	DBMS_OUTPUT.PUT_LINE('p2: '||p2);
	DBMS_OUTPUT.PUT_LINE('p3: '||p3);	
	--p1:= 20;
	p2:= 30;
	p3:= 40;
	DBMS_OUTPUT.PUT_LINE('Dentro del subprograma');
	DBMS_OUTPUT.PUT_LINE('p1: '||p1);
	DBMS_OUTPUT.PUT_LINE('p2: '||p2);
	DBMS_OUTPUT.PUT_LINE('p3: '||p3);	
END;
/

-- Bloque anónimo para llamar al procedimiento
DECLARE
	v1	NUMBER := 22;
	v2	NUMBER := 33;
	v3	NUMBER := 44;
BEGIN
	Ejemplo02(V1,V2,V3);
	DBMS_OUTPUT.PUT_LINE('Fuera del subprograma');
	DBMS_OUTPUT.PUT_LINE('v1: '||V1);
	DBMS_OUTPUT.PUT_LINE('v2: '||v2);
	DBMS_OUTPUT.PUT_LINE('v3: '||v3);
End;
/
	
RESULTADO:
Antes de modificar los argumentos
p1: 22
p2:
p3: 44
Dentro del subprograma
p1: 22
p2: 30
p3: 40
Fuera del subprograma
v1: 22
v2: 30
v3: 40
