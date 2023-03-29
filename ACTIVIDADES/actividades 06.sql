Tablas ARTICULOS, FABRICANTES, TIENDAS, PEDIDOS y VENTAS
(para realizar esta relación de ejercicios debes cagar el script datos06.sql)

Un almacén de distribución de artículos desea mantener la información sobre las ventas de artículos hechas por las tiendas que compran artículos al almacén. Dispone de las siguientes tablas para mantener la información:

ARTICULOS: Almacena cada uno de los artículos que el almacén puede suministrar a las tiendas.
Nombre                  Nulo?    Tipo
----------------------- -------- -------------
ARTICULO                NOT NULL VARCHAR2(20)
COD_FABRICANTE          NOT NULL NUMBER(3)
PESO                    NOT NULL NUMBER(3)
CATEGORIA               NOT NULL VARCHAR2(10)
PRECIO_VENTA                     NUMBER(4)
PRECIO_COSTO                     NUMBER(4)
EXISTENCIAS                      NUMBER(5)
Cada artículo viene determinado por las columnas ARTICULO, COD_FABRICANTE, PESO y CATEGORIA. La CATEGORIA puede ser 'Primera', 'Segunda' o 'Tercera'.

FABRICANTES: Contiene los países de origen de los fabricantes de artículos. Cada COD_FABRICANTE tiene su país.
 Nombre                  Nulo?    Tipo
 ----------------------- -------- ------------
 COD_FABRICANTE          NOT NULL NUMBER(3)
 NOMBRE                           VARCHAR2(15)
 PAIS                             VARCHAR2(15)
TIENDAS: Almacena los datos de las tiendas que venden artículos. Cada tienda se identifica por su NIF.
Nombre                  Nulo?    Tipo
----------------------- -------- ------------
NIF                     NOT NULL VARCHAR2(10)
NOMBRE                           VARCHAR2(20)
DIRECCION                        VARCHAR2(20)
POBLACION                        VARCHAR2(20)
PROVINCIA                        VARCHAR2(20)
CODPOSTAL                        NUMBER(5)
PEDIDOS: Son los pedidos que realizan las tiendas al almacén.
Nombre                  Nulo?    Tipo
----------------------- -------- ------------
NIF                     NOT NULL VARCHAR2(10)
ARTICULO                NOT NULL VARCHAR2(20)
COD_FABRICANTE          NOT NULL NUMBER(3)
PESO                    NOT NULL NUMBER(3)
CATEGORIA               NOT NULL VARCHAR2(10)
FECHA_PEDIDO            NOT NULL DATE
UNIDADES_PEDIDAS                 NUMBER(4)
Cada pedido se identifica por NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA y FECHA_PEDIDO. Cada fila de la tabla representa un pedido.

VENTAS: Almacena las ventas de artículos que hace cada una de las tiendas.
Nombre                  Nulo?    Tipo
----------------------- -------- --------------
NIF                     NOT NULL VARCHAR2(10)
ARTICULO                NOT NULL VARCHAR2(20)
COD_FABRICANTE          NOT NULL NUMBER(3)
PESO                    NOT NULL NUMBER(3)
CATEGORIA               NOT NULL VARCHAR2(10)
FECHA_VENTA             NOT NULL DATE
UNIDADES_VENDIDAS                NUMBER(4)
Cada venta se identifica por: NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA y FECHA_VENTA. Cada fila de la tabla representa una venta.
Se pide:

1. Dar de alta un nuevo artículo de 'Primera' categoría para los fabricantes de 'FRANCIA' y abastecer con cinco unidades
de ese artículo a todas las tiendas y en la fecha de hoy.

INSERT INTO ARTICULOS (ARTICULO, CATEGORIA, PESO, COD_FABRICANTE)
VALUES ('BAGUETTE', 'PRIMERA', 3, (SELECT COD_FABRICANTE 
									FROM FABRICANTES 
									WHERE UPPER(PAIS) = 'FRANCIA'));

INSERT INTO PEDIDOS (NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, FECHA_PEDIDO, UNIDADES_PEDIDAS)
SELECT NIF, 'BAGUETTE', (SELECT COD_FABRICANTE 
							FROM FABRICANTES 
							WHERE UPPER(PAIS) = 'FRANCIA'), 3, 'PRIMERA', SYSDATE, 5
FROM TIENDAS;

2. Insertar un pedido de 20 unidades en la tienda '1111-A' con el artículo que mayor número de ventas haya realizado.

INSERT INTO PEDIDOS(NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, FECHA_PEDIDO, UNIDADES_PEDIDAS)
SELECT '1111-A', ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, SYSDATE, 20
	FROM VENTAS 
	WHERE UNIDADES_VENDIDAS = (SELECT MAX(UNIDADES_VENDIDAS)
								FROM VENTAS);

3. Dar de alta una tienda en la provincia de 'MADRID' y abastecerla con 20 unidades de cada uno de los artículos existentes.

INSERT INTO TIENDAS (NIF, NOMBRE, DIRECCION, POBLACION, PROVINCIA, CODPOSTAL)
VALUES ('6969-X', 'MERCADONA', 'C/FALSA', 'Ajalvir','MADRID', 28765);

INSERT INTO PEDIDOS (NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, FECHA_PEDIDO, UNIDADES_PEDIDAS)
SELECT '6969-X', ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, SYSDATE, 20
FROM ARTICULOS;

4. Dar de alta dos tiendas en la provincia de 'SEVILLA' y abastecerlas con 20 unidades de artículos del fabricante 'GALLO'.

INSERT INTO TIENDAS (NIF, NOMBRE, DIRECCION, POBLACION, PROVINCIA, CODPOSTAL)
VALUES ('6666-Z', 'MERCADONA', 'C/IMAGINARIA', 'Alanis','SEVILLA', 41380);
INSERT INTO TIENDAS (NIF, NOMBRE, DIRECCION, POBLACION, PROVINCIA, CODPOSTAL)
VALUES ('0420-A', 'ALDI', 'C/INVENTADA', 'Aguadulce','SEVILLA', 41550);

INSERT INTO PEDIDOS (NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, FECHA_PEDIDO, UNIDADES_PEDIDAS)
SELECT '6666-Z', ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, SYSDATE, 20
FROM ARTICULOS
WHERE COD_FABRICANTE = (SELECT COD_FABRICANTE
							FROM FABRICANTES
							WHERE UPPER(NOMBRE) LIKE '%GALLO%');
INSERT INTO PEDIDOS (NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, FECHA_PEDIDO, UNIDADES_PEDIDAS)
SELECT '0420-A', ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, SYSDATE, 20
FROM ARTICULOS
WHERE COD_FABRICANTE = (SELECT COD_FABRICANTE
							FROM FABRICANTES
							WHERE UPPER(NOMBRE) LIKE '%GALLO%');

5. Realizar una venta para todas las tiendas de 'TOLEDO' de 10 unidades de los artículos de 'Primera' categoría.

INSERT INTO VENTAS (NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, FECHA_VENTA, UNIDADES_VENDIDAS)
SELECT NIF, ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, SYSDATE, 10
FROM ARTICULOS
WHERE NIF = (SELECT NIF
				FROM FABRICANTES
				WHERE UPPER(PROVINCIA) LIKE '%TOLEDO%');

6. Para aquellos artículos de los que se hayan vendido más de 30 unidades, realizar 
un pedido de 10 unidades para la tienda con NIF '5555-B' con la fecha actual.



7. Cambiar los datos de la tienda con NIF '1111-A' igualándolos a los de la tienda con NIF '2222-A'.

UPDATE TIENDAS
SET (NOMBRE, DIRECCION, POBLACION, PROVINCIA, CODPOSTAL) = (SELECT NOMBRE, DIRECCION, POBLACION, PROVINCIA, CODPOSTAL 
																FROM TIENDAS 
																WHERE UPPER(NIF) LIKE '%2222-A%')
WHERE UPPER(NIF) LIKE '%1111-A%';

8. Cambiar todos los artículos de 'Primera' categoría a 'Segunda' categoría del país 'ITALIA'.

UPDATE ARTICULOS
SET CATEGORIA = 'PRIMERA'
WHERE UPPER(CATEGORIA) LIKE '%SEGUNDA%' AND COD_FABRICANTE = (SELECT COD_FABRICANTE
																FROM FABRICANTES
																WHERE UPPER(PAIS) LIKE '%ITALIA%');

9. Modificar aquellos pedidos en los que la cantidad pedida sea superior a las existencias del artículo,
asignando el 20% de las existencias a la cantidad que se ha pedido.

UPDATE PEDIDOS P
SET UNIDADES_PEDIDAS=(SELECT EXISTENCIAS*0.2
						FROM ARTICULOS
						WHERE ARTICULO=P.ARTICULO
						AND COD_FABRICANTE=P.COD_FABRICANTE
						AND PESO=P.PESO
						AND CATEGORIA=P.CATEGORIA
						AND FECHA_PEDIDO=P.FECHA_PEDIDO
						AND UNIDADES_PEDIDAS=P.UNIDADES_PEDIDAS)
WHERE UNIDADES_PEDIDAS > (SELECT EXISTENCIAS
							FROM ARTICULOS
							WHERE ARTICULO=P.ARTICULO
							AND COD_FABRICANTE=P.COD_FABRICANTE
							AND PESO=P.PESO
							AND CATEGORIA=P.CATEGORIA
							AND FECHA_PEDIDO=P.FECHA_PEDIDO
							AND UNIDADES_PEDIDAS=P.UNIDADES_PEDIDAS);

10. Eliminar aquellas tiendas que no han realizado ventas.



11. Eliminar los artículos que no hayan tenido ni compras ni ventas.



12. Borrar los pedidos de 'Primera' categoría cuyo país de procedencia sea 'BELGICA'.



13. Borrar los pedidos que no tengan tienda.



14. Restar uno a las unidades de los últimos pedidos de la tienda con NIF '5555-B'.


