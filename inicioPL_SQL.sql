SET SERVEROUTPUT ON
...
END;

SHOW ERROR

--bucle for para mostrar los numeros pares
BEGIN
    FOR vn_numero IN 1..20 LOOP
        IF MOD(vn_numero, 2) = 0 THEN
        	DBMS_OUTPUT.PUT_LINE(vn_numero);
        END IF;
    END LOOP;
END;
/
--bucle WHILE para mostrar los numeros pares
DECLARE
	vn_numero NUMBER(2) := 1;
BEGIN                                              
    WHILE vn_numero <= 20 LOOP                     
            IF MOD(vn_numero, 2) = 0 THEN          
            	DBMS_OUTPUT.PUT_LINE(vn_numero);   
            END IF;                                
        vn_numero := vn_numero + 1;                
    END LOOP;                                      
END;                                               
/                                                  
--bucle LOOP para mostrar los numeros pares        
DECLARE                                            
	vn_numero NUMBER(2) := 1;
BEGIN
    LOOP
        IF vn_numero > 20 THEN
        	EXIT; -- Condición de salida
        END IF;
        IF MOD(vn_numero, 2) = 0 THEN
        	DBMS_OUTPUT.PUT_LINE(vn_numero);
        END IF;
        vn_numero := vn_numero + 1;
    END LOOP;
END;
/

--RELACION 1:
--1. Escribir un procedimiento que reciba dos números y visualice su suma.
CREATE OR REPLACE PROCEDURE suma_num(vn_numero1 IN NUMBER,
    				  				vn_numero2 IN NUMBER)
IS
	suma NUMBER(10);
BEGIN
	suma := vn_numero1 + vn_numero2;
    DBMS_OUTPUT.PUT_LINE('El resultado de la suma entre ' || vn_numero1 || ' y ' || vn_numero2 || ' es : ' || suma);
END suma_num;
/

EXEC suma_num(10,5);

--2. Codificar un procedimiento que reciba una cadena y la visualice al revés.
CREATE OR REPLACE PROCEDURE pr_inversion(vv_texto IN VARCHAR2)
IS
	vv_revertido VARCHAR2(50);
BEGIN
    FOR letra IN REVERSE 1..LENGTH(vv_texto) LOOP
		vv_revertido:= vv_revertido || SUBSTR(vv_texto, letra, 1);
	END LOOP;
    DBMS_OUTPUT.PUT_LINE('La inversion del texto ' || vv_texto || ' es : ' || vv_revertido);
END pr_inversion;
/

EXEC pr_inversion ('?satse lat euQ¿ ,samoT aloH');

--3. Reescribir el código de los ejercicios anteriores convirtiéndolos en funciones.
CREATE OR REPLACE FUNCTION suma_numero(n_numero1 IN NUMBER,
    				  				   n_numero2 IN NUMBER)
RETURN NUMBER
IS
	suma NUMBER(10);
BEGIN
	suma := vn_numero1 + vn_numero2;
    RETURN suma;
END suma_numero;
/

SELECT suma_numero(8, 5) FROM DUAL;

CREATE OR REPLACE FUNCTION invertir(texto IN VARCHAR)
RETURN VARCHAR
IS
    revertido VARCHAR(50);
BEGIN
    FOR letra IN REVERSE 1..LENGTH(texto) LOOP
        revertido := revertido || SUBSTR(texto, letra, 1);
    END LOOP;
    RETURN revertido;
END invertir;
/

SELECT invertir('?satse lat euQ¿ ,samoT aloH') FROM DUAL;

--4. Escribir una función que reciba una fecha y devuelva el año, en número, correspondiente a esa fecha.
CREATE OR REPLACE FUNCTION obtener_anio(fecha IN DATE)
RETURN NUMBER
IS
BEGIN
    RETURN EXTRACT(YEAR FROM fecha);
END obtener_anio;
/

SELECT obtener_anio('04/05/2023') FROM DUAL;

--5. Escribir un bloque PL/SQL que haga uso de la función anterior.
DECLARE
    fecha_ingreso DATE := TO_DATE('2023/05/04', 'YYYY/MM/DD');
    anio NUMBER;
BEGIN
    anio := obtener_anio(fecha_ingreso);
    DBMS_OUTPUT.PUT_LINE('El año correspondiente a la fecha ' || fecha_ingreso || ' es: ' || anio);
END;
/

--6. Desarrollar una función que devuelva el número de años completos que hay entre dos fechas que se pasan como argumentos.
CREATE OR REPLACE FUNCTION obtener_anios_completos(fecha_inicio DATE, fecha_fin DATE)
RETURN NUMBER
IS
    anios NUMBER;
BEGIN
    anios := EXTRACT(YEAR FROM fecha_fin) - EXTRACT(YEAR FROM fecha_inicio);
    IF fecha_inicio > ADD_MONTHS(TRUNC(fecha_fin, 'YYYY'), 12) - 1 THEN
        anios := anios - 1;
    END IF;
    RETURN anios;
END obtener_anios_completos;
/

DECLARE
    fecha_inicio DATE := TO_DATE('01/01/2000', 'DD/MM/YYYY');
    fecha_fin DATE := TO_DATE('31/12/2022', 'DD/MM/YYYY');
    anios NUMBER;
BEGIN
    anios := obtener_anios_completos(fecha_inicio, fecha_fin);
    DBMS_OUTPUT.PUT_LINE('El número de años completos entre ' || fecha_inicio  || ' y ' || fecha_fin  || ' es: ' || anios);
END;
/

--7. Escribir una función que, haciendo uso de la función anterior devuelva los trienios que hay entre dos fechas. (Un trienio son tres años completos).
CREATE OR REPLACE FUNCTION obtener_trienios(fecha_inicio DATE, fecha_fin DATE)
RETURN NUMBER
IS
    anios NUMBER;
    trienios NUMBER;
BEGIN
    anios := obtener_anios_completos(fecha_inicio, fecha_fin);
    trienios := FLOOR(anios / 3);
    RETURN trienios;
END obtener_trienios;
/

DECLARE
    fecha_inicio DATE := TO_DATE('01/01/2000', 'DD/MM/YYYY');
    fecha_fin DATE := TO_DATE('31/12/2022', 'DD/MM/YYYY');
    trienios NUMBER;
BEGIN
    trienios := obtener_trienios(fecha_inicio, fecha_fin);
    DBMS_OUTPUT.PUT_LINE('El número de trienios entre ' || fecha_inicio  || ' y ' || fecha_fin  || ' es: ' || trienios);
END;
/

--8. Dado el siguiente procedimiento:
--		CREATE OR REPLACE PROCEDURE crear_depart (
--  		v_num_dept	depart.dept_no%TYPE, 
--  		v_dnombre	depart.dnombre%TYPE DEFAULT 'PROVISIONAL',
--  		v_loc		depart.loc%TYPE DEFAULT ‘PROVISIONAL’)
--		IS
--		BEGIN
--  		INSERT INTO depart
--  	  	VALUES (v_num_dept, v_dnombre, v_loc);
--		END crear_depart;
--	Indicar cuáles de las siguientes llamadas son correctas y cuáles incorrectas, en este último caso escribir la llamada correcta usando la notación posicional (en los casos que se pueda):
--		crear_depart;					
		1º Incorrecta: como minimo debe ser, --crear_depart(numero).
--		crear_depart(50);				
		2º Correcta.
--		crear_depart('COMPRAS');			
		3º Incorrecta: con el orden en la creacion primero debe ponerse v_num_dept, 
						--crear_depart(50,'COMPRAS').
--		crear_depart(50,'COMPRAS');			
		4º Correcta.
--		crear_depart('COMPRAS', 50);			
		5º Incorrecta: en esta parte, VALUES (v_num_dept, v_dnombre, v_loc), se indica que primero va un valor de caracter numerico, 
						--crear_depart(50,'COMPRAS').
--		crear_depart('COMPRAS', 'VALENCIA');		
		6º Incorrecta: no esta entroducido el valor numerico que va al principio, 
						--crear_depart(50, 'COMPRAS', 'VALENCIA').
--		crear_depart(50, 'COMPRAS', 'VALENCIA');	
		7º Correcta.
--		crear_depart('COMPRAS', 50, 'VALENCIA');	
		8º Incorrecta: en esta parte, VALUES (v_num_dept, v_dnombre, v_loc), se indica que primero va un valor de caracter numerico, 
					   --crear_depart(50, 'COMPRAS', 'VALENCIA').
		
--9. Codificar un procedimiento que reciba una lista de hasta 5 números y visualice su suma.
CREATE OR REPLACE PROCEDURE sumar_numeros (
    num1 IN NUMBER,
    num2 IN NUMBER DEFAULT 0,
    num3 IN NUMBER DEFAULT 0,
    num4 IN NUMBER DEFAULT 0,
    num5 IN NUMBER DEFAULT 0)
IS
    total NUMBER;
BEGIN
    total := num1 + num2 + num3 + num4 + num5;
    DBMS_OUTPUT.PUT_LINE('La suma de los números ' || num1 || ', ' || num2 || ', ' || num3 || ', ' || num4 || ', ' || num5 || ' es: ' || total);
END sumar_numeros;
/

EXEC sumar_numeros (1,8,15,2,4);

--10. Implementar un procedimiento que reciba un importe y visualice el desglose del cambio en unidades monetarias de 1, 2, 5, 10, 20, 50, 100, 200 y 500 € en orden inverso al que aparecen aquí enumeradas.
CREATE OR REPLACE PROCEDURE desglose_cambio(pn_importe NUMBER) AS
    vn_cambio NUMBER := pn_importe;
    vn_unidades INTEGER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Desglose del cambio:');
    WHILE vn_cambio > 0 LOOP
		IF vn_cambio >= 500 THEN
			vn_unidades := TRUNC(vn_cambio / 500);
			vn_cambio := MOD(vn_cambio, 500);
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' billete(s) de 500€');
		ELSIF vn_cambio >= 200 THEN
			vn_unidades := TRUNC(vn_cambio / 200);
			vn_cambio := MOD(vn_cambio, 200);
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' billete(s) de 200€');
		ELSIF vn_cambio >= 100 THEN
			vn_unidades := TRUNC(vn_cambio / 100);
			vn_cambio := MOD(vn_cambio, 100);
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' billete(s) de 100€');
		ELSIF vn_cambio >= 50 THEN
			vn_unidades := TRUNC(vn_cambio / 50);
			vn_cambio := MOD(vn_cambio, 50);
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' billete(s) de 50€');
		ELSIF vn_cambio >= 20 THEN
			vn_unidades := TRUNC(vn_cambio / 20);
			vn_cambio := MOD(vn_cambio, 20);
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' billete(s) de 20€');
		ELSIF vn_cambio >= 10 THEN
			vn_unidades := TRUNC(vn_cambio / 10);
			vn_cambio := MOD(vn_cambio, 10);
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' moneda(s) de 10€');
		ELSIF vn_cambio >= 5 THEN
			vn_unidades := TRUNC(vn_cambio / 5);
			vn_cambio := MOD(vn_cambio, 5);
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' moneda(s) de 5€');
		ELSIF vn_cambio >= 2 THEN
			vn_unidades := TRUNC(vn_cambio / 2);
			vn_cambio := MOD(vn_cambio, 2);
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' moneda(s) de 2€');
		ELSE
			vn_unidades := vn_cambio;
			vn_cambio := 0;
			DBMS_OUTPUT.PUT_LINE(vn_unidades || ' moneda(s) de 1€');
		END IF;
    END LOOP;
END;
/

EXEC desglose_cambio(883);

--11. Codificar un procedimiento que permita borrar un empleado cuyo código se pasará en la llamada.

--12. Escribir un procedimiento que modifique la localidad de un departamento. El procedimiento recibirá como parámetros el número del departamento y la localidad nueva.

--13. Visualizar todos los procedimientos y funciones del usuario almacenados en la base de datos y su situación (valid o invalid).
