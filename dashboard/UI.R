ui <- navbarPage(
    "Bicicletas",
    tabPanel(
        "Ventas",
        fluidRow(
            box(
                width = 12,
                title = NULL,
                status = "primary",
                solidHeader = FALSE,
                collapsible = FALSE,
                valueBoxOutput("usuarios", width = 3),
                valueBoxOutput("tickets", width = 3),
                valueBoxOutput("total", width = 3),
                valueBoxOutput("cpromedio", width = 3)
            ),
            box(
                width = 12,
                title = "Productos Más y Menos Vendidos",
                status = "primary",
                solidHeader = FALSE,
                collapsible = FALSE,
                plotlyOutput("productos_mas_menos_vendidos")
            ),
            box(
                width = 6,
                title = "Filtros",
                status = "primary",
                solidHeader = FALSE,
                collapsible = FALSE,
                selectInput("producto", "Seleccionar Producto:",
                            choices = unique(ventas$producto)),
                plotlyOutput("importes")
            ),
            box(
                width = 6,
                title = "Gráficos",
                status = "primary",
                solidHeader = FALSE,
                collapsible = FALSE,
                dateRangeInput("dateRange", "Seleccionar Rango de Fechas:",
                               start = min(ventas$fecha), end = max(ventas$fecha)),
                plotlyOutput("cantidad")
            )
        )
    ),
    tags$head(
        tags$link(
            rel = "stylesheet",
            type = "text/css",
            href = "custom.css"
        )
    ),
)
