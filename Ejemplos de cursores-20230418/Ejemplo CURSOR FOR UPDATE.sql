---------------------------------------------------------
-- En este caso, el cursor C_PRUEBA será FOR UPDATE
-- con lo que bloqueamos el acceso a los campos 
-- especificados, COMISION y SALARIO en este caso,
-- para que ningún usuario pueda modificarlos mientras
-- dure la transacción
---------------------------------------------------------
DECLARE
	CURSOR C_PRUEBA IS
		SELECT NVL(COMISION,0) V_COM, SALARIO
		FROM EMPLE
		FOR UPDATE OF COMISION, SALARIO;
BEGIN 
	FOR REG IN C_PRUEBA LOOP
		IF REG.V_COM < REG.SALARIO /10 THEN
			UPDATE EMPLE SET COMISION = SALARIO/10
				WHERE CURRENT OF C_PRUEBA;
	-- Con la cláusula WHERE CURRENT OF <nombre_de_cursor>
	-- indicamos que se modifique sólo el registro que estamos
	-- actualmente procesando del cursor, es decir, el de 
	-- la última instrucción FETCH
		END IF;
	END LOOP;
	COMMIT; -- Valida la transacción y libera los bloqueos
END;
/
----------------------------------------
-- Mismo ejemplo sin cursor FOR UPDATE
----------------------------------------
DECLARE
	CURSOR C_PRUEBA IS
		SELECT NVL(COMISION,0) V_COM, SALARIO, EMP_NO
		FROM EMPLE;
BEGIN 
	FOR REG IN C_PRUEBA LOOP
		IF REG.V_COM < REG.SALARIO/10 THEN
			UPDATE EMPLE SET COMISION = SALARIO/10
				WHERE REG.EMP_NO = EMP_NO;
		END IF;
	END LOOP;
	COMMIT;
END;
/