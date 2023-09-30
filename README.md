# Tienda de bicicletas
Dashboard básico de datos ficticios de productos relacionados a las bicicletas.

**Contiene**
- Codigo para crear una base de datos relacional de ventas semi aleatorias de bicicletas con MySQL y R
- Dashboard.

![Figura 1.](https://raw.githubusercontent.com/Ger-dot-m/Dashboard-random/main/assets/figura1.PNG)

![Figura 2.](https://raw.githubusercontent.com/Ger-dot-m/Dashboard-random/main/assets/figura2.PNG)

# Funcionamiento
## Generación de los datos
### Creación del modelo
Para establecer la base de datos, se debe ejecutar el query que se encuentra en la carpeta <em>sql</em>.

### Carga de datos
En la carpeta <em>load</em> se encuentran los archivos R que cargan los datos en la base de datos creada.

Se pueden ejecutar en cualquier orden los archivos siempre y cuando <em>tabla_venta.R</em> se ejecute al final.

## Base de Datos de la Tienda

### Tabla: producto
- **sku** (VARCHAR(20)) - Clave única del producto (Clave Primaria)
- **descripcion** (VARCHAR(255)) - Descripción del producto (No Nulo)
- **precio1** (DOUBLE) - Precio del producto (No Nulo)
- **precio2** (DOUBLE) - Segundo precio del producto
- **costo** (DOUBLE) - Costo del producto
- **rodada** (INT) - Rodada del producto
- **existencia** (INT) - Cantidad en existencia del producto
- **linea** (VARCHAR(255)) - Línea del producto (No Nulo)
- **marca** (VARCHAR(255)) - Marca del producto (No Nulo)

### Tabla: vendedor
- **pdv** (VARCHAR(20)) - Punto de venta del vendedor
- **vendedor_id** (INT) - Identificación única del vendedor (Clave Primaria)
- **nombre** (VARCHAR(255)) - Nombre del vendedor (No Nulo)
- **celular** (VARCHAR(20)) - Número de celular del vendedor
- **sueldo** (DOUBLE) - Sueldo del vendedor

### Tabla: cliente
- **cliente_id** (INT) - Identificación única del cliente (Clave Primaria)
- **nombre** (VARCHAR(255)) - Nombre del cliente (No Nulo)
- **celular** (VARCHAR(20)) - Número de celular del cliente

### Tabla: venta
- **pdv** (VARCHAR(20)) - Punto de venta de la venta (No Nulo)
- **fecha** (DATE) - Fecha de la venta (No Nulo)
- **folio** (VARCHAR(20)) - Folio de la venta
- **producto** (VARCHAR(20)) - SKU del producto vendido
- **cliente** (INT) - Identificación única del cliente relacionado
- **vendedor** (INT) - Identificación única del vendedor relacionado
- **cantidad** (INT) - Cantidad de productos vendidos
- **tipoPago** (VARCHAR(20)) - Tipo de pago de la venta
- **precio1** (DOUBLE) - Precio unitario del producto vendido
- **importe** (DOUBLE) - Importe total de la venta

### Restricciones:
- La clave primaria de la tabla "producto" es "sku".
- La clave primaria de la tabla "vendedor" es "vendedor_id".
- La clave primaria de la tabla "cliente" es "cliente_id".
- La tabla "venta" tiene tres llaves foráneas: "producto" hace referencia a "sku" en "producto", "cliente" hace referencia a "cliente_id" en "cliente", y "vendedor" hace referencia a "vendedor_id" en "vendedor".


## Dashboard
### Ejecución
Se utiliza la libreria <em>shiny</em> para crear el dashboard. El proyecto en sí se encuentra en la carpeta <em>dashboard</em> y para correrlo en forma local se debe ejcutar el siguiente código.

<code>shiny::runApp("<ruta de la carpeta>/basedatos/bici-datos/dashboard")</code>
