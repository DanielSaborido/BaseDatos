--1 Cambiar la fecha de ingreso de Amador al día de hoy.

UPDATE ALUMNOS
SET FECINC_AL = SYSDATE
WHERE UPPER(NOMBRE_AL) LIKE '%AMADOR%';

--2 Poner la fecha de ingreso y la ciudad de Carlos a los alumnos de Sevilla.

UPDATE ALUMNOS
SET (FECINC_AL, CIUDAD_AL) = (SELECT FECINC_AL, CIUDAD_AL
								FROM ALUMNOS
								WHERE UPPER(NOMBRE_AL) LIKE '%CARLOS%')
WHERE UPPER(CIUDAD_AL) LIKE '%SEVILLA%';

--3 Poner a Ismael: la fecha de ingreso de Javier y el delegado de Daniel.

UPDATE ALUMNOS
SET FECINC_AL = (SELECT FECINC_AL
					FROM ALUMNOS
					WHERE UPPER(NOMBRE_AL) LIKE '%JAVIER%'), 
	DELEGADO_AL = (SELECT DELEGADO_AL
					FROM ALUMNOS
					WHERE UPPER(NOMBRE_AL) LIKE '%DANIEL%')
WHERE UPPER(NOMBRE_AL) LIKE '%ISMAEL%';