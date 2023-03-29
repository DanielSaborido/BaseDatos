--------------------------------------------------------------
-- Tablas ARTICULOS, FABRICANTES, TIENDAS, PEDIDOS y VENTAS --
--------------------------------------------------------------
-- 1.- Dar de alta un nuevo art�culo de 'Primera' categor�a 
para los fabricantes de 'FRANCIA' 
y abastecer con cinco unidades de ese art�culo a todas las tiendas 
y en la fecha de hoy.
SQL>  INSERT INTO ARTICULOS 
		SELECT 'Yogur Fresa', COD_FABRICANTE, 4,'Primera',120,100,190
		FROM FABRICANTES
		WHERE PAIS='FRANCIA';
1 fila creada.


SQL> INSERT INTO PEDIDOS
		SELECT NIF, 'Yogur Fresa', COD_FABRICANTE, 4,'Primera',SYSDATE,5
		FROM TIENDAS, FABRICANTES
		WHERE PAIS='FRANCIA';

6 filas creadas.

--------------------------------------------------------------
-- 2.- Insertar un pedido de 20 unidades en la tienda '1111-A' 
-- con el art�culo que mayor n�mero de ventas haya realizado.

SQL>
INSERT INTO PEDIDOS
	SELECT '1111-A', ARTICULO, COD_FABRICANTE, PESO,CATEGORIA, SYSDATE, 20
		FROM VENTAS
		GROUP BY ARTICULO, COD_FABRICANTE, PESO,CATEGORIA
		HAVING SUM(UNIDADES_VENDIDAS) =
		(SELECT MAX(SUM(UNIDADES_VENDIDAS)) 
			FROM VENTAS 
			GROUP BY ARTICULO, COD_FABRICANTE, PESO,CATEGORIA);

--------------------------------------------------------------
-- 3.- Dar de alta una tienda en la provincia de 'MADRID' 
y abastecerla con 20 unidades de cada uno de los art�culos existentes.

SQL> INSERT INTO TIENDAS 
	VALUES('1010-C','La Cesta', 'C/Juan Mazo 30', 'Alcal�','MADRID',28809); 

1 fila creada.

SQL> INSERT INTO PEDIDOS
		SELECT '1010-C', ARTICULO, COD_FABRICANTE, PESO, CATEGORIA,SYSDATE, 20
		FROM ARTICULOS;

32 filas creadas.

--------------------------------------------------------------
-- 4.-Dar de alta dos tiendas en la provincia de 'SEVILLA' 
y abastecerlas con 30 unidades de art�culos del fabricante 'GALLO'.

SQL> INSERT INTO TIENDAS 
VALUES('4500-A','La Econ�mica', 'C/Feria 100', 'Sevilla','SEVILLA',41002); 

1 fila creada.

SQL> INSERT INTO TIENDAS 
VALUES('4501-B','La estrella','C/San Jacinto 130', 'Sevilla', 'SEVILLA',41009);

1 fila creada.

SQL> INSERT INTO PEDIDOS
		SELECT NIF, ARTICULO, A.COD_FABRICANTE, PESO, CATEGORIA,SYSDATE, 30
		FROM TIENDAS, ARTICULOS A, FABRICANTES F
		WHERE PROVINCIA='SEVILLA'
		AND F.NOMBRE='GALLO'
		AND A.COD_FABRICANTE=F.COD_FABRICANTE;

8 filas creadas.

--------------------------------------------------------------
-- 5.- Realizar una venta para todas las tiendas de 'TOLEDO' 
de 10 unidades de los art�culos de 'Primera' categor�a.
SQL> INSERT INTO VENTAS
		SELECT NIF,  ARTICULO, COD_FABRICANTE, PESO, CATEGORIA,SYSDATE, 10
		FROM TIENDAS, ARTICULOS 
		WHERE PROVINCIA='TOLEDO'
		AND CATEGORIA='Primera';

38 filas creadas.

--------------------------------------------------------------
-- 6.- Para aquellos art�culos de los que se hayan vendido m�s de 30 unidades, realizar un pedido de 10 unidades para la tienda con NIF '5555-B' con la fecha actual.

SQL>
INSERT INTO PEDIDOS
	SELECT '5555-B', ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, SYSDATE, 10
		FROM VENTAS
		GROUP BY ARTICULO, COD_FABRICANTE, PESO, CATEGORIA
		HAVING SUM(UNIDADES_VENDIDAS) > 30;

 filas creadas.

--------------------------------------------------------------
-- 7.- Cambiar los datos de la tienda con NIF '1111-A' 
igual�ndolos a los de la tienda con NIF '2222-A'.

SQL> UPDATE TIENDAS
		SET (NOMBRE, DIRECCION, POBLACION, PROVINCIA,CODPOSTAL) =
		(SELECT NOMBRE, DIRECCION, POBLACION, PROVINCIA,CODPOSTAL
			FROM TIENDAS 
			WHERE NIF='2222-A')
		WHERE NIF='1111-A';

1 fila actualizada.

--------------------------------------------------------------
-- 8.- Cambiar todos los art�culos de 'Primera' categor�a a 'Segunda' 
--categor�a del pa�s 'ITALIA'.

SQL> UPDATE ARTICULOS
		SET CATEGORIA='Segunda'
		WHERE CATEGORIA='Primera'
		AND COD_FABRICANTE IN (SELECT COD_FABRICANTE 
								FROM FABRICANTES 
								WHERE PAIS='ITALIA');

2 filas actualizadas.

--------------------------------------------------------------
-- 9.- Modificar aquellos pedidos en los que la cantidad 
--pedida sea superior a las existencias del art�culo, 
--asignando el 20% de las existencias a la cantidad que se ha pedido.

SQL> UPDATE PEDIDOS P
		SET UNIDADES_PEDIDAS = (SELECT EXISTENCIAS*0.2 
									FROM ARTICULOS 
									WHERE ARTICULO=P.ARTICULO 
									AND COD_FABRICANTE=P.COD_FABRICANTE 
									AND PESO=P.PESO 
									AND CATEGORIA=P.CATEGORIA )
		WHERE UNIDADES_PEDIDAS > (SELECT EXISTENCIAS 
									FROM ARTICULOS 
									WHERE ARTICULO=P.ARTICULO 
									AND COD_FABRICANTE=P.COD_FABRICANTE 
									AND PESO=P.PESO 
									AND CATEGORIA=P.CATEGORIA);

1 fila actualizada.

--------------------------------------------------------------
-- 10.- Eliminar aquellas tiendas que no han realizado ventas.

SQL> 
DELETE TIENDAS
	WHERE  NIF NOT IN (SELECT DISTINCT NIF FROM VENTAS);

5 filas borradas.

--------------------------------------------------------------
-- 11.- Eliminar los art�culos que no hayan tenido ni compras ni ventas.

SQL> 
DELETE ARTICULOS
	WHERE (ARTICULO, COD_FABRICANTE, PESO, CATEGORIA)
		NOT IN (SELECT DISTINCT ARTICULO, COD_FABRICANTE, PESO, CATEGORIA 
					FROM VENTAS)
	AND (ARTICULO, COD_FABRICANTE, PESO, CATEGORIA)
		NOT IN (SELECT DISTINCT ARTICULO, COD_FABRICANTE, PESO, CATEGORIA 
					FROM PEDIDOS);

2 filas borradas.

--------------------------------------------------------------
-- 12.- Borrar los pedidos de 'Primera' categor�a 
-- cuyo pa�s de procedencia sea 'BELGICA'.

SQL>
DELETE PEDIDOS
	WHERE COD_FABRICANTE=(SELECT COD_FABRICANTE 
							FROM FABRICANTES 
							WHERE PAIS ='BELGICA')
	AND CATEGORIA='Primera';		
		
5 filas borradas.

--------------------------------------------------------------
-- 13.- Borrar los pedidos que no tengan tienda.

SQL> DELETE pedidos 
		WHERE nif NOT IN (SELECT nif FROM tiendas);

49 filas borradas.

--------------------------------------------------------------
-- 14.- Restar uno a las unidades de los �ltimos pedidos de la tienda con NIF '5555-B'.

SQL> UPDATE PEDIDOS
		SET UNIDADES_PEDIDAS=UNIDADES_PEDIDAS-1
		WHERE NIF='5555-B' 
		AND FECHA_PEDIDO=(SELECT MAX(FECHA_PEDIDO) 
							FROM PEDIDOS 
							WHERE NIF='5555-B');

3 FILAS ACTUALIZADAS.