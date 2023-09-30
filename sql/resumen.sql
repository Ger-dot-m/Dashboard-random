# Listar todos los productos con su descripción y precio:
SELECT sku, descripcion, precio1
FROM producto;

# Calcular el total de ventas para cada vendedor:
SELECT vendedor, SUM(importe) AS total_ventas
FROM venta
GROUP BY vendedor;

# Encontrar los productos con existencia menor a 10 unidades:
SELECT sku, descripcion, existencia
FROM producto
WHERE existencia < 10;

# Obtener el nombre de los clientes que han realizado compras por un valor superior a $500:
SELECT DISTINCT c.nombre
FROM cliente c
INNER JOIN venta v ON c.cliente_id = v.cliente
WHERE v.importe > 500;

# Calcular el promedio de sueldo de los vendedores:
SELECT AVG(sueldo) AS sueldo_promedio
FROM vendedor;