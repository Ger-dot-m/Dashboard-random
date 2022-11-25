rm(list = ls())
pacman::p_load(tidyverse, DBI, RMySQL, readxl, lubridate)
setwd("C:/Users/Germain/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/Data_Source")
pdv <- c("a", "b", "c")
fechas <- seq(as.Date("2021/09/04"), by = "day", length.out = 364)
tipo <- c("TDC", "TDD", "Efectivo", "Credito")

con <- dbConnect(RMySQL::MySQL(),
    user = "master", password = "1234",
    dbname = "tienda", host = "localhost"
)

producto <- dbReadTable(con, "producto")
cliente <- dbReadTable(con, "cliente")
vendedor <- dbReadTable(con, "vendedor")

size <- as.integer(runif(1, 5, 15))
aux <- producto[sample(nrow(producto), size), ]
cantidad <- as.integer(runif(nrow(aux), 1, 6))
ventas <- aux %>%
    select(
        sku, precio1
    ) %>%
    mutate(
        fecha = as.Date("2021/09/03"),
        cantidad = cantidad,
        importe = precio1 * cantidad,
        precio1 = NULL
    )

for (i in 1:length(fechas)) {
    size <- as.integer(runif(1, 5, 15))
    aux <- producto[sample(nrow(producto), size), ]
    cantidad <- as.integer(runif(nrow(aux), 1, 12))
    ventas_aux <- aux %>%
        select(
            sku, precio1
        ) %>%
        mutate(
            fecha = fechas[i],
            cantidad = cantidad,
            importe = precio1 * cantidad,
            precio1 = NULL
        )
    ventas <- rbind(ventas, ventas_aux)
}

ventas <- ventas %>%
    mutate(
        folio = paste0(
            substr(ventas$sku, 1, 2),
            as.numeric(ventas$fecha)
        ),
        cliente = NA,
        vendedor = NA,
        tipoPago = NA,
        pdv = NA
    )

# De m vendedores a n clientes.
m <- length(vendedor$vendedor_id) + 1
n <- length(cliente$cliente_id) + 1

for (codigo in unique(ventas$folio)) {
    ventas <- ventas %>%
        mutate(
            cliente = replace(
                cliente,
                folio == codigo,
                as.integer(runif(1, 1, n))
            ),
            vendedor = replace(
                vendedor,
                folio == codigo,
                as.integer(runif(1, 1, n))
            ),
            tipoPago = replace(
                tipoPago,
                folio == codigo,
                tipo[
                    as.integer(runif(1, 1, length(tipo)))
                ]
            ),
            pdv = replace(
                pdv,
                folio == codigo,
                as.integer(runif(1, 1, 4))
            )
        )
}

ventas <- ventas %>% rename(producto = sku)

tablasql <- dbReadTable(con, "venta")
cols <- names(tablasql)
nueva <- ventas %>% select(cols)

dbWriteTable(con, "venta", nueva, append = TRUE, row.names = FALSE)
dbDisconnect(con)
