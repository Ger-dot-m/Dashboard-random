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

size <- as.integer(runif(1, 5, 11))
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
    size <- as.integer(runif(1, 4, 11))
    aux <- producto[sample(nrow(producto), size), ]
    cantidad <- as.integer(runif(nrow(aux), 1, 6))
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

View(ventas)

dbDisconnect(con)