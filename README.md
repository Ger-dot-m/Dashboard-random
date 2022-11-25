# Bici - datos
Dashboard de datos ficticios de productos relacionados a las bicicletas.

**Contiene**
- Codigo para crear una base de datos relacional de ventas semi aleatorias de bicicletas con MySQL y R
- Dashboard.

# Funcionamiento
## Generación de los datos
### Creación del modelo
Para establecer la base de datos, se debe ejecutar el query que se encuentra en la carpeta <em>sql</em>.

### Carga de datos
En la carpeta <em>load</em> se encuentran los archivos R que cargan los datos en la base de datos creada.

Se pueden ejecutar en cualquier orden los archivos siempre y cuando <em>tabla_venta.R</em> se ejecute al final.

## Dashboard
### Ejecución
Se utiliza la libreria <em>shiny</em> para crear el dashboard. El proyecto en sí se encuentra en la carpeta <em>dashboard</em> y para correrlo en forma local se debe ejcutar el siguiente código.

<code>shiny::runApp("<ruta de la carpeta>/basedatos/bici-datos/dashboard")</code>
