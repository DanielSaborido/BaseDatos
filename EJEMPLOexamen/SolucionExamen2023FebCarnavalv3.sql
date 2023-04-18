--------------------------------------------------------------------------------------
-- SOLUCION EXAMEN SQL SELECT DE FEBRERO 2023 - TABLAS CARNAVAL
--------------------------------------------------------------------------------------
start C:\Users\tomas\Downloads\Datos2023Febv3

--------------------------------------------------------------------------------------
-- EXAMEN SQL SELECT DE FEBRERO 2023 v3 - TABLAS CARNAVAL 
--------------------------------------------------------------------------------------

-- Nombre: Pon_aquí_tu_nombre

Con este examen se evalua el Resultado de Aprendizaje 3 del Modulo de Base de datos,
con los criterios de evaluación a), b), c), d), e), f). 

RA3. Consulta la información almacenada en una base de datos empleando asistentes,
herramientas gráficas y el lenguaje de manipulación de datos.
Criterios de evaluación:
a) Se han identificado las herramientas y sentencias para realizar consultas.
b) Se han realizado consultas simples sobre una tabla.
c) Se han realizado consultas sobre el contenido de varias tablas mediante composiciones
internas.
d) Se han realizado consultas sobre el contenido de varias tablas mediante composiciones
externas.
e) Se han realizado consultas resumen.
f) Se han realizado consultas con subconsultas.


--------------------------------------------------------------------------------------
-- INSTRUCCIONES
--------------------------------------------------------------------------------------

- Pon tu nombre arriba y lee atentamente todas las preguntas.

-Salva este fichero con los dos digitos que te corresponden segun la lista
y  las iniciales de tu nombre y apellidos 
	Ejemplo:	Tomas Coronado Garcia
			    00TCG.sql
El numero que pones delante de tus iniciales debe ser el que aparece 
a continuación:

01	Acedo Castrillón, Javier	
02	Arrieta Soto, Ángel	
03	Baro López, Juan Ramón	
04	Bulpe Martínez, Sara	
05	Cabrera Perejón, Rafael Pedro	
06	Cortés Bernal, Natalia
07	Darner, Maurice Alejandro
08	Escobar Vidal, Manuel Ángel	
09	Fernandez Garrido, Adrián	
10	Flor Barrios, Jesús	
11	Fornell Periñan, Pablo	
12	Jiménez Cerpa, Ignacio	
13	López Jiménez, Erik	
14	Medina Rivero, Débora
15  Piñero Labrador, Alberto
16  Rodriguez Benítez, Guillermo
17  Saborido Torres, Daniel
18  Salado Morán, Luis
19  Salazar Ramos, Jose Alfonso
20  Sanchez Gonzalez, Juan José
21  Vela Chávez, Carlos	

- Entra en la consola de línea de comandos SQL con el usuario EXAMEN (u otro que tengas disponible). 

- Carga el script para el examen desde el fichero "Datos2023Feb.sql".

- Donde ponga "SQL>", copiarás las sentencias SQL que has utilizado.

- Donde ponga "Resultado:" copiarás el resultado que SQL te devuelve.

- RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. 
Es lo que voy a evaluar, si lo pierdes, lo siento.
--------------------------------------------------------------------------------------
-- PUNTUACIÓN
--------------------------------------------------------------------------------------

- Preguntas: 0,625 puntos cada respuesta correcta

--------------------------------------------------------------------------------------
-- CRITERIOS
--------------------------------------------------------------------------------------

- Las consultas deben poder ejecutarse (sin errores de sintaxis) 

- Deben mostrar la información pedida.

--------------------------------------------------------------------------------------
-- TABLAS	
--------------------------------------------------------------------------------------
	
CREATE TABLE MIEMBROS(
  COD_MI		NUMBER(3)		PRIMARY KEY,
  NOMBRE_MI		VARCHAR2(30) 	NOT NULL,
  GRUPO_MI		NUMBER(2)		REFERENCES GRUPOS,
  FECNAC_MI		DATE
);
  
CREATE TABLE GRUPOS(
  COD_GR		NUMBER(2)		PRIMARY KEY,
  NOMBRE_GR		VARCHAR2(20),
  LETRISTA_GR	NUMBER(3)		REFERENCES MIEMBROS,
  TIPO_GR		NUMBER(1)		REFERENCES TIPO_GRUPO
);
 
CREATE TABLE TIPO_GRUPO(
  COD_TP		NUMBER(1)		PRIMARY KEY,
  NOMBRE_TP		VARCHAR2(10)
);

CREATE TABLE JURADOS(
  COD_JU		NUMBER(1)		PRIMARY KEY,
  NOMBRE_JU		VARCHAR2(12)
);
 
CREATE TABLE VOTOS(
  GRUPO_VO		NUMBER(2)		REFERENCES GRUPOS,
  JURADO_VO		NUMBER(1)		REFERENCES JURADOS,
  PUNTOS_VO		NUMBER(2), 
  PRIMARY KEY (GRUPO_VO, JURADO_VO)
);


--------------------------------------------------------------------------------------
-- Pregunta 1
--------------------------------------------------------------------------------------
1.- Mostrar el nombre y apellido, en este orden, 
del miembro con el nombre más corto (longitud de apellidos y nombre).

SQL>
SELECT SUBSTR(NOMBRE_MI, INSTR(NOMBRE_MI,',')+2)   ||  
       SUBSTR(NOMBRE_MI, 1, INSTR(NOMBRE_MI,',')-1) NOMBRE_Y_APELLIDO
	FROM MIEMBROS
	WHERE LENGTH(RTRIM(NOMBRE_MI)) = ( SELECT MIN(LENGTH(RTRIM(NOMBRE_MI)))
										FROM MIEMBROS);
Resultado:
NOMBRE_Y_APELLIDO
------------------------------------------------------
Paco                    Alba

--------------------------------------------------------------------------------------
-- Pregunta 2
--------------------------------------------------------------------------------------
2.- Para cada tipo de agrupación, mostrar su nombre 
y cuantos grupos se han presentado.


SQL>
SELECT NOMBRE_TP, COUNT(*) "N Grupos"
	FROM GRUPOS, TIPO_GRUPO
	WHERE TIPO_GR = COD_TP
	GROUP BY NOMBRE_TP;
	
NOMBRE_TP    N Grupos
---------- ----------
CHIRIGOTA           3
CUARTETO            3
CORO                4
ROMANCERO           4
CALLEJERA           4
COMPARSA            4

6 filas seleccionadas.

--------------------------------------------------------------------------------------
-- Pregunta 3 
--------------------------------------------------------------------------------------
3.- Mostrar el apellido (sin el nombre) 
del miembro más mayor de 'GLADIADORES DEL POPULO'.

SQL>
SELECT SUBSTR(NOMBRE_MI,1,INSTR(NOMBRE_MI,',')-1) APELLIDO	
	FROM MIEMBROS, GRUPOS
	WHERE GRUPO_MI = COD_GR
		AND UPPER(NOMBRE_GR) = 'GLADIADORES DEL POPULO'
		AND FECNAC_MI = (SELECT MIN(FECNAC_MI)
							FROM MIEMBROS, GRUPOS
							WHERE GRUPO_MI = COD_GR
								AND UPPER(NOMBRE_GR) = 'GLADIADORES DEL POPULO');
										
	
Resultado:
APELLIDO
----------------------------------------------------------------------------------------------------------------------------------
Gago



--------------------------------------------------------------------------------------
-- Pregunta 4
--------------------------------------------------------------------------------------
4.- Mostrar para cada 'CORO', 
su nombre en mayúsculas y el número de total de puntos obtenidos, 
ordenados por número de puntos. 
Deben aparecer todos los coros, aunque no hayan tenido puntuación también.


SQL>
SELECT UPPER(NOMBRE_GR) NOMBRE, SUM(PUNTOS_VO) Puntos
	FROM GRUPOS, VOTOS, TIPO_GRUPO
	WHERE GRUPO_VO (+) = COD_GR 
		AND TIPO_GR = COD_TP
		AND NOMBRE_TP = UPPER('CORO')
	GROUP BY NOMBRE_GR
	ORDER BY 2;
	
Resultado:

NOMBRE                                       PUNTOS
---------------------------------------- ----------
LOS MARTINEZ                                     83
LA VOZ                                           98
EL DIA DE MANIANA                               118
AQUI NO SE RINDE NADIE

--------------------------------------------------------------------------------------
-- Pregunta 5
--------------------------------------------------------------------------------------
5.- Mostrar del grupo con más miembros, el nombre 
y el número de miembros que lo integran.

SQL>
SELECT NOMBRE_GR, COUNT(*) MIEMBROS
	FROM MIEMBROS, GRUPOS
	WHERE GRUPO_MI = COD_GR
	GROUP BY NOMBRE_GR
	HAVING COUNT(*) = (SELECT MAX(COUNT(*))
						FROM MIEMBROS
						GROUP BY GRUPO_MI);
	
Resultado:
NOMBRE_GR                                  MIEMBROS
---------------------------------------- ----------
La loca de los gatos                              8

--------------------------------------------------------------------------------------
-- Pregunta 6
--------------------------------------------------------------------------------------
6.- Mostrar, en minúscula con la primera letra en mayúsculas, 

el nombre del miembro del jurado que haya dado menos puntos en total, y los puntos que ha dado.


SQL>
SELECT INITCAP(NOMBRE_JU) JURADO, SUM(PUNTOS_VO) PUNTOS
	FROM JURADOS, VOTOS
	WHERE JURADO_VO = COD_JU
	GROUP BY NOMBRE_JU
	HAVING SUM(PUNTOS_VO) = (SELECT MIN(SUM(PUNTOS_VO))
								FROM VOTOS
								GROUP BY JURADO_VO);
	
Resultado:
JURADO           PUNTOS
------------ ----------
Jorge               254

--------------------------------------------------------------------------------------
-- Pregunta 7
--------------------------------------------------------------------------------------
7.- Mostrar el resultado de las votaciones: 
nombre del tipo de grupo, nombre del grupo y puntos obtenidos, 
ordenado por tipo de grupo.
Deben aparecer todos los grupos, aunque no hayan obtenido ningún voto también. 



SQL>
SELECT NOMBRE_TP TIPO, NOMBRE_GR GRUPO, SUM(PUNTOS_VO) PUNTOS
	FROM GRUPOS, TIPO_GRUPO, VOTOS
	WHERE TIPO_GR = COD_TP
		AND GRUPO_VO (+) = COD_GR
	GROUP BY NOMBRE_TP, NOMBRE_GR
	ORDER BY NOMBRE_TP DESC;
	
Resultado:
TIPO       GRUPO                                        PUNTOS
---------- ---------------------------------------- ----------
ROMANCERO  Esto es lo que air
ROMANCERO  Los caravinieros
ROMANCERO  La ciudad de los perros
ROMANCERO  Callehero
CUARTETO   COAC no pasamos ni una                           98
CUARTETO   Los vigilantes de la laja                       102
CUARTETO   Gladiadores del Populo                          122
CORO       Aqu├¡ no se rinde nadie
CORO       El dia de maniana                               118
CORO       La voz                                           98
CORO       Los Martinez                                     83
COMPARSA   Las Ratas de los barbaros de Vilches
COMPARSA   El embrujo de Cadiz                              78
COMPARSA   La ciudad invisible                             102
COMPARSA   Los esclavos                                     85
CHIRIGOTA  To me pasa a mi: Los desgraciatos               104
CHIRIGOTA  Los mi alma                                     111
CHIRIGOTA  Los vinianos                                     84
CALLEJERA  Amoescuchaa
CALLEJERA  Mr Wonderful
CALLEJERA  La loca de los gatos
CALLEJERA  Los vinilers

22 filas seleccionadas.

--------------------------------------------------------------------------------------
-- Pregunta 8 
--------------------------------------------------------------------------------------
8.- Mostrar el nombre del grupo 
y la suma de puntos del grupo que menos puntos ha obtenido.
(solo teniendo en cuenta aquellos que han tenido puntos)


SQL>
SELECT NOMBRE_GR, SUM(PUNTOS_VO) PUNTOS
	FROM VOTOS, GRUPOS, TIPO_GRUPO
	WHERE GRUPO_VO = COD_GR
		AND TIPO_GR = COD_TP
	GROUP BY NOMBRE_GR
	HAVING SUM(PUNTOS_VO) = (SELECT MIN(SUM(PUNTOS_VO))
								FROM VOTOS
								GROUP BY GRUPO_VO);
Resultado:

NOMBRE_GR                                    PUNTOS
---------------------------------------- ----------
El embrujo de Cadiz                              78

--------------------------------------------------------------------------------------
-- Pregunta 9
--------------------------------------------------------------------------------------
9.- Mostrar el nombre y apellido junto con el nombre de su grupo, 

del miembro más viejo de todos los participantes.


SQL>
SELECT NOMBRE_MI, NOMBRE_GR,FECNAC_MI
	FROM MIEMBROS, GRUPOS
	WHERE GRUPO_MI = COD_GR
		AND FECNAC_MI = (SELECT MIN(FECNAC_MI)
							FROM MIEMBROS);
Resultado:


NOMBRE_MI                                NOMBRE_GR                                FECNAC_MI
---------------------------------------- ---------------------------------------- ----------
Elyuyu, Jose Guerrero                    La ciudad de los perros                  02/02/1950

--------------------------------------------------------------------------------------
-- Pregunta 10 
--------------------------------------------------------------------------------------
10.- Para todos los grupos, mostrar el nombre de cada grupo, 
el nombre del tipo de agrupación y nombre (apellidos y nombre) 
del letrista del grupo. 
Deben aparecer todos los grupos.

SQL> SELECT NOMBRE_GR, NOMBRE_TP, NOMBRE_MI
		FROM GRUPOS, TIPO_GRUPO, MIEMBROS
		WHERE LETRISTA_GR  = COD_MI (+)
			AND TIPO_GR = COD_TP;
		
Resultado:
NOMBRE_GR                                NOMBRE_TP  NOMBRE_MI
---------------------------------------- ---------- ----------------------------------------
Los mi alma                              CHIRIGOTA  ElBizcocho, Antonio
To me pasa a mi: Los desgraciatos        CHIRIGOTA  Dominguez, Antonio
Los vinianos                             CHIRIGOTA  Santander, Manuel
La ciudad invisible                      COMPARSA   Martines Ares, Antonio
Los esclavos                             COMPARSA   Garcia ElChapa, Miguel Angel
El embrujo de Cadiz                      COMPARSA   Piru, Antonio Jesus
Gladiadores del Populo                   CUARTETO   Gago, Angel
Los vigilantes de la laja                CUARTETO   Peinado, Manuel
COAC no pasamos ni una                   CUARTETO   Pastrana, Fali
La voz                                   CORO       Rivas, Antonio
Los Martinez                             CORO       Pardo, Julio
El dia de maniana                        CORO       Villegas, Enrique
La loca de los gatos                     CALLEJERA  Bustelo, Daniel
Mr Wonderful                             CALLEJERA  Peralta , Miriam
Amoescuchaa                              CALLEJERA  Elcaja , Pepe
Los vinilers                             CALLEJERA  Jartible, Andrea
Esto es lo que air                       ROMANCERO  Lahierbabuena , Maria
Callehero                                ROMANCERO  Garcia Cossio , Selu
La ciudad de los perros                  ROMANCERO  Montes, Andres
Las Ratas de los barbaros de Vilches     COMPARSA   Fernandez Vilches , Juanfra
Aqui no se rinde nadie                   CORO       Miguele , Nandi
Los caravinieros                         ROMANCERO

22 filas seleccionadas.

--------------------------------------------------------------------------------------
-- Pregunta 11
--------------------------------------------------------------------------------------
11.-  De manera descendente según puntuación, mostrar los puntos que le han dado cada miembro del jurado a 
la agrupación 'Los esclavos'
Mostrar nombre del jurado y votos.

SQL>


SELECT NOMBRE_JU, PUNTOS_VO
	FROM JURADOS, VOTOS, GRUPOS
	WHERE JURADO_VO = COD_JU
		AND GRUPO_VO = COD_GR
		AND NOMBRE_GR = 'Los esclavos'
ORDER BY PUNTOS_VO DESC;

Resultado:
NOMBRE_JU     PUNTOS_VO
------------ ----------
JORGE                43
MARIA                29
JOSE MARIA           11
JUAN ANTONIO          2


--------------------------------------------------------------------------------------
-- Pregunta 12
--------------------------------------------------------------------------------------
12.- Para cada miembro que no es letrista, mostrar su nombre y apellidos 
y fecha de nacimiento con el siguiente formato:

"Emilio Gutierrez Ellibi nació el sabado 15 de noviembre de 1958"


SQL>
SELECT SUBSTR(NOMBRE_MI, INSTR(NOMBRE_MI,',')+2) ||  ' ' ||
       SUBSTR(NOMBRE_MI, 1,INSTR(NOMBRE_MI,',')-1) || 
     TO_CHAR(FECNAC_MI, '" nació el "day" "dd" de "month" de "yyyy') FORMATO
	FROM MIEMBROS
	WHERE COD_MI NOT IN (SELECT LETRISTA_GR
						FROM GRUPOS);

Resultado:
FORMATO
--------------------------------------------------------------------------
Emilio      Gutierrez ElLibi  nació el sßbado    15 de noviembre  de 1958
Manuel        Cornejo Cornejo nació el jueves    05 de agosto     de 1965
Fermin                   Coto nació el sßbado    10 de diciembre  de 1966
Jose                  ElLobe  nació el miÚrcoles 11 de enero      de 1967
Carlos                  Perez nació el viernes   06 de diciembre  de 1985
Javier               Aguilera nació el domingo   09 de mayo       de 1982
Paco                Elpellejo nació el viernes   26 de agosto     de 1977
Jose Antonio  Sanchez Soriano nació el domingo   22 de abril      de 1973
Jeronimo         Silva Mulero nació el martes    10 de febrero    de 1987
Angela       Jimenez Bautista nació el miÚrcoles 05 de noviembre  de 1986
Abraham         Lopez Delgado nació el martes    05 de agosto     de 1975
Sergio       Guillen ElTomate nació el jueves    03 de mayo       de 1990
Ramon         Diaz Elfletilla nació el domingo   09 de junio      de 1963
Miguel Angel    Martin Martin nació el martes    09 de diciembre  de 1986
Angel                 Subiela nació el miÚrcoles 01 de enero      de 1986
Miguel Angel    Movilla Aubri nació el sßbado    16 de diciembre  de 1995
Joshua                Peinado nació el sßbado    16 de diciembre  de 2000
Alejandro            Ronquete nació el lunes     16 de agosto     de 2004
Rafael          Quecuty Ponce nació el jueves    22 de febrero    de 1979
Jose Antonio     Aboza Molina nació el viernes   20 de febrero    de 1987
Paola Elsa     Mendoza Llanos nació el sßbado    22 de mayo       de 1993
Abraham      Giraldez Sanchez nació el domingo   02 de abril      de 1989
Jesus          Baglieto Bueno nació el jueves    22 de abril      de 1999
Elena          Ponce Martinez nació el viernes   02 de julio      de 1993
Juan Manuel   Braza Elsheriff nació el domingo   02 de abril      de 1989
Paco                     Alba nació el miÚrcoles 08 de mayo       de 1968
Diego                 Marinio nació el viernes   22 de abril      de 1983
Umberto       Eco de la Bahia nació el sßbado    08 de mayo       de 1982
Pascual         Jimena Hirene nació el miÚrcoles 19 de mayo       de 1982
Maite             Pozo Aguada nació el viernes   16 de agosto     de 1985
Pepe          Sevilla Alberti nació el miÚrcoles 22 de febrero    de 1989
Elena          Solari Conarte nació el martes    11 de noviembre  de 1986
Tomas               Coronado  nació el jueves    11 de agosto     de 1977
Jose Guerrero          Elyuyu nació el jueves    02 de febrero    de 1950
Antonio            Elbatitora nació el jueves    01 de julio      de 1971
Luis               Elchimenea nació el viernes   05 de septiembre de 1958

36 filas seleccionadas.



--------------------------------------------------------------------------------------
-- Pregunta 13
--------------------------------------------------------------------------------------
13.- Hallar el nombre de los grupos que tienen al menos dos 'a' en cualquier posicion
y cuyos votos totales son superiores a 100.
Mostrar tanto el nombre como los votos totales, de aquellos grupos que cumplen ambas condiciones.
				
			
SELECT NOMBRE_GR, SUM(PUNTOS_VO) PUNTOS
	FROM VOTOS, GRUPOS
	WHERE GRUPO_VO = COD_GR
	  AND UPPER(NOMBRE_GR) LIKE '%A%A%'
	GROUP BY NOMBRE_GR 
	HAVING SUM(PUNTOS_VO)>100;
	
	
	NOMBRE_GR                                    PUNTOS
---------------------------------------- ----------
Los mi alma                                     111
La ciudad invisible                             102
El dia de maniana                               118
Los vigilantes de la laja                       102
To me pasa a mi: Los desgraciatos               104
Gladiadores del Populo                          122

6 filas seleccionadas.


--------------------------------------------------------------------------------------
-- Pregunta 14
--------------------------------------------------------------------------------------
14.- Mostrar para cada grupo, su nombre 
y el número de miembros que lo forman.

SQL>
SELECT NOMBRE_GR, COUNT(NOMBRE_MI) MIEMBROS
	FROM GRUPOS, MIEMBROS
	WHERE GRUPO_MI(+) = COD_GR
	GROUP BY NOMBRE_GR;
	
Resultado:
NOMBRE_GR                                  MIEMBROS
---------------------------------------- ----------
Los mi alma                                       3
La ciudad invisible                               2
Los Martinez                                      5
Mr Wonderful                                      1
Amoescuchaa                                       1
La ciudad de los perros                           1
Callehero                                         1
El dia de maniana                                 4
COAC no pasamos ni una                            3
Las Ratas de los barbaros de Vilches              1
Los vigilantes de la laja                         3
La loca de los gatos                              8
La voz                                            4
Los esclavos                                      2
El embrujo de Cadiz                               3
Los vinilers                                      1
Los caravinieros                                  0
To me pasa a mi: Los desgraciatos                 3
Los vinianos                                      3
Esto es lo que air                                1
Gladiadores del Populo                            3

21 filas seleccionadas.

--------------------------------------------------------------------------------------
-- Pregunta 15
--------------------------------------------------------------------------------------
15.- Mostrar para cada uno de los miembros de "LOS vinianos",
apellidos y nombre, junto con la edad que tienen hoy.

SQL>
SELECT NOMBRE_MI, TRUNC(MONTHS_BETWEEN(SYSDATE,FECNAC_MI)/12) EDAD
	FROM MIEMBROS, GRUPOS
	WHERE GRUPO_MI = COD_GR
		AND UPPER(NOMBRE_GR) = 'LOS VINIANOS';
	
Resultado:

NOMBRE_MI                                      EDAD
---------------------------------------- ----------
Perez, Carlos                                    37
Santander, Manuel                                47
Aguilera, Javier                                 40

--------------------------------------------------------------------------------------
-- Pregunta 16
--------------------------------------------------------------------------------------
16.- Mostrar cuantos puntos ha obtenido el grupo "Los Martinez" 
junto con su nombre y el tipo de agrupación que es.
SQL>
SELECT NOMBRE_GR,NOMBRE_TP, SUM(PUNTOS_VO)
	FROM VOTOS, GRUPOS, TIPO_GRUPO
	WHERE GRUPO_VO = COD_GR
	   AND TIPO_GR = COD_TP
		AND NOMBRE_GR = 'Los Martinez'
    GROUP BY NOMBRE_GR,NOMBRE_TP;
	

	
Resultado:
NOMBRE_GR                                NOMBRE_TP  SUM(PUNTOS_VO)
---------------------------------------- ---------- --------------
Los martinez                             CORO                   83





