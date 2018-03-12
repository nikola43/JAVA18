-- �) 
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

-- 2�)
SQL> INSERT INTO PEDIDOS
	SELECT DISTINCT '1111-A', ARTICULO, COD_FABRICANTE, PESO, CATEGORIA, SYSDATE, 20
	FROM VENTAS
	WHERE (ARTICULO, COD_FABRICANTE, PESO,CATEGORIA) IN
	(SELECT ARTICULO, COD_FABRICANTE, PESO,CATEGORIA
		FROM VENTAS
		GROUP BY ARTICULO, COD_FABRICANTE, PESO,CATEGORIA
		HAVING COUNT(*) =
		(SELECT MAX(COUNT(*)) 
			FROM VENTAS 
			GROUP BY ARTICULO, COD_FABRICANTE, PESO,CATEGORIA));

1 fila creada.

-- 3�)
SQL> INSERT INTO TIENDAS VALUES('1010-C','La Cesta', 'C/Juan Mazo 30', 'Alcal�','MADRID',28809); 

1 fila creada.

SQL> INSERT INTO PEDIDOS
		SELECT '1010-C', ARTICULO, COD_FABRICANTE, PESO, CATEGORIA,SYSDATE, 20
		FROM ARTICULOS;

32 filas creadas.

-- 4�)
SQL> INSERT INTO TIENDAS VALUES('4500-A','La Econ�mica', 'C/La Feria s/n', 'Camas','SEVILLA',44003); 

1 fila creada.

SQL> INSERT INTO TIENDAS VALUES('4501-B','Comestibles Peter','C/Sevillanas 130', 'Dos hermanas', 'SEVILLA',44009);

1 fila creada.

SQL> INSERT INTO PEDIDOS
		SELECT NIF, ARTICULO, A.COD_FABRICANTE, PESO, CATEGORIA,SYSDATE, 30
		FROM TIENDAS, ARTICULOS A, FABRICANTES F
		WHERE PROVINCIA='SEVILLA'
		AND F.NOMBRE='GALLO'
		AND A. COD_FABRICANTE=F. COD_FABRICANTE;

8 filas creadas.

-- 5�)
SQL> INSERT INTO VENTAS
		SELECT NIF,  ARTICULO, COD_FABRICANTE, PESO, CATEGORIA,SYSDATE, 10
		FROM TIENDAS, ARTICULOS 
		WHERE PROVINCIA='TOLEDO'
		AND CATEGORIA='Primera';

38 filas creadas.

-- 6�)
SQL> INSERT INTO PEDIDOS
		SELECT DISTINCT '5555-B',  ARTICULO, COD_FABRICANTE, PESO,CATEGORIA, SYSDATE, 10
		FROM VENTAS
		WHERE (ARTICULO, COD_FABRICANTE, PESO, CATEGORIA) IN
		(SELECT ARTICULO, COD_FABRICANTE, PESO, CATEGORIA
			FROM VENTAS
			GROUP BY ARTICULO, COD_FABRICANTE, PESO, CATEGORIA
			HAVING SUM(UNIDADES_VENDIDAS) >30);

3 filas creadas.

-- 7�)
SQL> UPDATE TIENDAS
		SET (NOMBRE, DIRECCI�N, POBLACI�N, PROVINCIA,CODPOSTAL) =
		(SELECT NOMBRE, DIRECCI�N, POBLACI�N, PROVINCIA,CODPOSTAL
			FROM TIENDAS 
			WHERE NIF='2222-A')
		WHERE NIF='1111-A';

1 fila actualizada.

-- 8�)
SQL> UPDATE ARTICULOS
		SET CATEGORIA='Segunda'
		WHERE CATEGORIA='Primera'
		AND COD_FABRICANTE = (SELECT COD_FABRICANTE FROM FABRICANTES 
								WHERE PAIS='ITALIA');

2 filas actualizadas.

-- 9�)
SQL> UPDATE PEDIDOS P
		SET UNIDADES_PEDIDAS=
		(SELECT EXISTENCIAS*0.2 
			FROM ARTICULOS 
			WHERE ARTICULO=P.ARTICULO 
			AND COD_FABRICANTE=P.COD_FABRICANTE 
			AND PESO=P.PESO 
			AND CATEGORIA=P.CATEGORIA )
		WHERE UNIDADES_PEDIDAS >
			(SELECT EXISTENCIAS 
			FROM ARTICULOS 
			WHERE ARTICULO=P.ARTICULO 
			AND COD_FABRICANTE=P.COD_FABRICANTE 
			AND PESO=P.PESO 
			AND CATEGORIA=P.CATEGORIA);

1 fila actualizada.

-- 10�)
SQL> DELETE TIENDAS
	WHERE  NIF NOT IN (SELECT DISTINCT NIF FROM VENTAS);

5 filas borradas.

-- 11�)
SQL> DELETE ARTICULOS
		WHERE (ARTICULO, COD_FABRICANTE, PESO, CATEGORIA)
		NOT IN (SELECT DISTINCT ARTICULO, COD_FABRICANTE, PESO, CATEGORIA FROM VENTAS)
		AND (ARTICULO, COD_FABRICANTE, PESO, CATEGORIA)
		NOT IN (SELECT DISTINCT ARTICULO, COD_FABRICANTE, PESO, CATEGORIA FROM PEDIDOS);

2 filas borradas.

-- 12�) 
SQL> DELETE PEDIDOS
	WHERE (ARTICULO, COD_FABRICANTE, PESO, CATEGORIA) IN
		(SELECT ARTICULO, COD_FABRICANTE, PESO, CATEGORIA 
		FROM ARTICULOS 
		WHERE COD_FABRICANTE=(SELECT COD_FABRICANTE 
							FROM FABRICANTES 
							WHERE PAIS ='BELGICA'))
		AND CATEGORIA='Primera';

5 filas borradas.

-- 13�) 
SQL> DELETE pedidos 
		WHERE nif NOT IN (SELECT nif FROM tiendas);

49 filas borradas.

-- 14�) 
SQL> UPDATE PEDIDOS
		SET UNIDADES_PEDIDAS=UNIDADES_PEDIDAS-1
		WHERE NIF='5555-B' 
		AND FECHA_PEDIDO=(SELECT MAX(FECHA_PEDIDO) 
					FROM PEDIDOS 
					WHERE NIF='5555-B');

3 FILAS ACTUALIZADAS.
