rm(list = ls())
pacman::p_load(tidyverse, DBI, RMySQL)

marca <- c("Canodale", "CUBE", "Brompton", "Specia ilized", "Merida", "Giant", "Scott", "SantaCruz", NA)
linea <- c("Montaña", "Ruta", "Urbana", "Plegable", "Paseo", "Hibrida", "BMX", "Electrica", NA)
rodada <- c(12, 14, 16, 18, 20, 22, 26)

bicicletas <- crossing(
    rodada = rodada, linea = linea,
    marca = marca
)

bicicletas$precio1 <- 1200 + runif(nrow(bicicletas), -500, 2000)
bicicletas$precio2 <- bicicletas$precio1 + runif(nrow(bicicletas), -200, 100)
bicicletas$costo <- bicicletas$precio1 - runif(nrow(bicicletas), 300, 800)
bicicletas$descripcion <- paste("Bicicleta", bicicletas$linea, "marca", bicicletas$marca)


accesorios <- crossing(
    linea = c("Proteccion", "Ropa", "Herramienta"),
    marca = marca
)

accesorios$precio1 <- 300 + runif(nrow(accesorios), -100, 800)
accesorios$precio2 <- accesorios$precio1 + runif(nrow(accesorios), -80, 100)
accesorios$costo <- accesorios$precio1 - runif(nrow(accesorios), 100, 200)
accesorios$descripcion <- paste("Accesorio para bicicleta: ", accesorios$linea, "marca", accesorios$marca)
accesorios$rodada <- 0


productos <- rbind(bicicletas, accesorios)
productos <- productos %>%
    mutate(
        sku = paste0(
            toupper(substr(marca, 1, 2)),
            toupper(substr(linea, 1, 2)),
            rodada
        ),
        existencia = as.integer(
            runif(nrow(productos), 2, 20)
        )
    )

con <- dbConnect(RMySQL::MySQL(),
    user = "master", password = "1234",
    dbname = "tienda", host = "localhost"
)

dbListTables(con)

tablasql <- dbReadTable(con, "producto")
cols <- names(tablasql)

nueva <- productos %>% select(cols)

dbWriteTable(con, "producto", nueva, append = TRUE, row.names = FALSE)
dbDisconnect(con)