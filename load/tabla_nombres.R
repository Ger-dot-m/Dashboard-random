rm(list = ls())
pacman::p_load(tidyverse, DBI, RMySQL, readxl)
setwd("C:/Users/Germain/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/Data_Source")

data <- read_excel("nombresg.xlsx")
numeros <- c("04", "91", "57", "01", "44", "15", "66", "54", "22", "89", "77")

telefonos <- crossing(
    a = numeros, b = numeros, c = numeros, d = numeros
)

nombres <- crossing(
    nombre = data$Nombre, apellido1 = data$Apellido,
    apellido2 = data$Apellido
)

cnames <- nombres[sample(nrow(nombres), 55), ]
ctel <- telefonos[sample(nrow(telefonos), 55), ]
vnames <- nombres[sample(nrow(nombres), 10), ]
vtel <- telefonos[sample(nrow(telefonos), 10), ]


vendedores <- vnames %>% mutate(
    vendedor_id = 1:nrow(vnames),
    nombre = paste(vnames$nombre, vnames$apellido1, vnames$apellido2),
    celular = paste(55,
        paste0(vtel$a, vtel$b),
        paste0(vtel$c, vtel$d)
    ),
    apellido1 = NULL,
    apellido2 = NULL
)

vendedores$sueldo <- as.integer(
    runif(nrow(vnames), 9000, 18000)
)

vendedores$pdv <- as.integer(
    runif(nrow(vnames), 1, 4)
)


clientes <- cnames %>% mutate(
    cliente_id = 1:nrow(cnames),
    nombre = paste(cnames$nombre, cnames$apellido1, cnames$apellido2),
    celular = paste(55,
        paste0(ctel$a, ctel$b),
        paste0(ctel$c, ctel$d)
    ),
    apellido1 = NULL,
    apellido2 = NULL
)


con <- dbConnect(RMySQL::MySQL(),
    user = "master", password = "1234",
    dbname = "tienda", host = "localhost"
)

tablasql <- dbReadTable(con, "vendedor")
cols <- names(tablasql)
nueva <- vendedores %>% select(cols)
dbWriteTable(con, "vendedor", nueva, append = TRUE, row.names = FALSE)

tablasql <- dbReadTable(con, "cliente")
cols <- names(tablasql)
nueva <- clientes %>% select(cols)
dbWriteTable(con, "cliente", nueva, append = TRUE, row.names = FALSE)

dbDisconnect(con)