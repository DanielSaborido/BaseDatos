DROP TABLE CENTROS CASCADE CONSTRAINTS;
CREATE TABLE CENTROS(
  Cod_ce	NUMBER(2)	PRIMARY KEY,
  Nombre_ce	VARCHAR2(30),
  Dir_ce	VARCHAR2(35)
);

DROP TABLE DEPARTAMENTOS CASCADE CONSTRAINTS;
CREATE TABLE DEPARTAMENTOS(
  Cod_de		NUMBER(3)	PRIMARY KEY,
  Centro_de		NUMBER(2),
  Director_de	NUMBER(4),
  TipoDir_de	CHAR(1),
  Presupuesto_de	NUMBER(6),
  Dptojefe_de	NUMBER(3),
  Nombre_de		VARCHAR2(30)
);

DROP TABLE EMPLEADOS CASCADE CONSTRAINTS;
CREATE TABLE EMPLEADOS(
  Cod_em		NUMBER(4)	PRIMARY KEY,
  Dpto_em		NUMBER(3),
  ExtTel_em		NUMBER(3),
  FechaNac_em	DATE,
  FechaIng_em	DATE,
  Salario_em	NUMBER(5),
  Comision_em	NUMBER(5),
  Numhijos_em	NUMBER(2),
  Apellidos_em	VARCHAR2(30),
  Nombre_em		VARCHAR2(15)
);

-- Inserci�n de valores en la tabla CENTROS:
insert into CENTROS values (10,  'SEDE CENTRAL', 'C/ JABUGO 20, SEVILLA');
insert into CENTROS values (20,  'SEDE ORIENTAL', 'AVDA. DE ANDALUCIA S/N, JAEN');
insert into CENTROS values (30,  'PRODUCCION', 'C/ LARIOS 10, MALAGA');

-- Inserci�n de valores en la tabla DEPARTAMENTOS:
insert into DEPARTAMENTOS values (100, 10, 260, 'P', 12000, null, 'DIRECCION GENERAL');
insert into DEPARTAMENTOS values (110, 20, 180, 'P', 15000, 100, 'DIRECC. COMERCIAL');
insert into DEPARTAMENTOS values (111, 30, 180, 'F', 11000, 110, 'SECTOR INDUSTRIAL');
insert into DEPARTAMENTOS values (112, 20, 270, 'P', 9000, 100, 'SECTOR SERVICIOS');
insert into DEPARTAMENTOS values (120, 10, 150, 'F', 3000, 100, 'ORGANIZACION');
insert into DEPARTAMENTOS values (121, 30, 150, 'P', 2000, 120, 'PERSONAL');
insert into DEPARTAMENTOS values (122, 30, 350, 'P', 6000, 120, 'PROCESO DE DATOS');
insert into DEPARTAMENTOS values (130, 10, 310, 'P', 2000, 100, 'FINANZAS');

-- Inserci�n de valores en la tabla EMPLEADOS:
insert into EMPLEADOS values (110, 121, 350, '10/11/1929', '10/02/1950', 2310, null, 3, 'RIVERA CALVETE', 'JOSE MARIA');
insert into EMPLEADOS values (120, 112, 840, '09/06/1935', '01/10/1968', 1350, 110, 1, 'ALONSO SORIANO', 'ANTONIO');
insert into EMPLEADOS values (130, 112, 810, '09/11/1945', '01/02/1969', 1290, 110, 2, 'CANO GALVEZ', 'JOSE MANUEL');
insert into EMPLEADOS values (150, 121, 340, '10/08/1930', '15/01/1948', 1440, null, 0, 'DOMINGUEZ PACHECO', 'DANIEL');
insert into EMPLEADOS values (160, 111, 740, '09/07/1939', '11/11/1968', 1310, 110, 2, 'FERNANDEZ MONTES', 'JAVIER');
insert into EMPLEADOS values (180, 110, 508, '18/10/1934', '18/03/1956', 1480, 50,  2,'GANDUL ROMERO', 'PABLO');
insert into EMPLEADOS values (190, 121, 350, '12/05/1932', '11/02/1962', 1300, null, 4, 'GARCIA PEREZ', 'SONIA');
insert into EMPLEADOS values (210, 100, 200, '28/09/1940', '22/01/1959', 1380, null, 2, 'MANCHE�O CAMACHO', 'JESUS');
insert into EMPLEADOS values (240, 111, 760, '26/02/1942', '24/02/1966', 1280, 100, 3, 'MAQUEDA GARCIA', 'JULIO');
insert into EMPLEADOS values (250, 100, 250, '27/10/1946', '01/03/1967', 1450, null, 0, 'MORENO GOMEZ', 'JOSE ANTONIO');
insert into EMPLEADOS values (260, 100, 220, '03/12/1943', '12/07/1968', 1720, null, 6, 'RUIZ DE LOPERA', 'MANUEL');
insert into EMPLEADOS values (270, 112, 800, '21/05/1945', '10/09/1966', 1380, 80, 3, 'MARIN SALAS', 'ISAAC');
insert into EMPLEADOS values (280, 130, 410, '11/01/1948', '08/10/1971', 1290, null, 5, 'OCA�A TINEO', 'CONCEPCION');
insert into EMPLEADOS values (285, 122, 620, '25/10/1949', '15/02/1968', 1380, null, 0, 'PANIAGUA VELA', 'ENRIQUE');
insert into EMPLEADOS values (290, 120, 910, '30/11/1947', '14/02/1968', 1270, null, 3, 'RODRIGUEZ AGUAYO', 'JOSE');
insert into EMPLEADOS values (310, 130, 480, '21/11/1946', '15/01/1971', 1420, null, 0, 'RODRIGUEZ MORALES', 'ANTONIO');
insert into EMPLEADOS values (320, 122, 620, '25/12/1957', '05/02/1978', 1405, null, 2, 'ROMERO CAMPILLEJO', 'ROSA MARIA');
insert into EMPLEADOS values (330, 112, 850, '19/08/1948', '01/03/1972', 1280, 90, 0, 'ROMERO FERNANDEZ', 'MARIA PIEDAD');
insert into EMPLEADOS values (350, 122, 610, '13/04/1949', '10/09/1984', 1450, null, 1, 'RUIZ FERNANDEZ', 'RAQUEL');
insert into EMPLEADOS values (360, 111, 750, '29/10/1958', '10/10/1968', 1250, 100, 2, 'SALGADO PEREZ', 'JOSE');
insert into EMPLEADOS values (370, 121, 360, '22/06/1967', '20/01/1987', 1190, null, 1, 'SERRANO LUQUE', 'EDUARDO');
insert into EMPLEADOS values (380, 112, 880, '30/03/1968', '01/01/1988', 1180, null, 0, 'SORIANO GONZALEZ', 'SERGIO');
insert into EMPLEADOS values (390, 110, 500, '19/02/1966', '08/10/1986', 1215, null, 1, 'TORO RAMIREZ', 'SERGIO');
insert into EMPLEADOS values (400, 111, 780, '18/08/1969', '01/11/1987', 1185, null, 0, 'SALAS LARA', 'LUCRECIA');
insert into EMPLEADOS values (410, 122, 660, '14/07/1968', '13/10/1988', 1175, null, 0, 'MU�OZ GONZALEZ', 'AZUCENA');
insert into EMPLEADOS values (420, 130, 450, '22/10/1966', '19/11/1988', 1400, null, 0, 'FIERRO GARCIA', 'CLAUDIA');
insert into EMPLEADOS values (430, 122, 650, '26/10/1967', '19/11/1988', 1210, null, 1, 'MORA PEREZ', 'VALERIA');
insert into EMPLEADOS values (440, 111, 760, '27/09/1966', '28/02/1986', 1210, 100, 0, 'DURAN DELGADO', 'LIVIA');
insert into EMPLEADOS values (450, 112, 880, '21/10/1966', '28/02/1986', 1210, 100, 0, 'PEREZ RAMOS', 'CARMEN');
insert into EMPLEADOS values (480, 111, 760, '04/04/1965', '28/02/1986', 1210, 100, 1, 'PINO BUSTOS', 'DIANA');
insert into EMPLEADOS values (490, 112, 880, '06/06/1964', '01/01/1988', 1180, 100, 0, 'TORRES VELA', 'EUGENIA');
insert into EMPLEADOS values (500, 111, 750, '08/10/1965', '01/01/1987', 1200, 100, 0, 'VAZQUEZ LOPEZ', 'VICTORIA');
insert into EMPLEADOS values (510, 110, 550, '04/05/1966', '01/11/1986', 1200, null, 1, 'CAMPOS SORIA', 'ROMULO');
insert into EMPLEADOS values (550, 111, 780, '10/01/1970', '21/01/1988', 1100, 120, 0, 'SANTOS BONILLA', 'SANCHO');

-- Actualizaci�n de fechas
update EMPLEADOS set FechaNac_em = add_months(FechaNac_em, 12*15), FechaIng_em = add_months(FechaIng_em, 12*15);

PURGE recyclebin;
COMMIT;
set linesize 120
set pagesize 40