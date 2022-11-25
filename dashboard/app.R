install.shinydashboard <- !("shinydashboard" %in% installed.packages()[, "Package"])
if (install.shinydashboard) install.packages("shinydashboard")
library(shinydashboard, warn.conflicts = FALSE)

install.DT <- !("DT" %in% installed.packages()[, "Package"])
if (install.DT) install.packages("DT")
library(DT, warn.conflicts = FALSE)

install.dplyr <- !("dplyr" %in% installed.packages()[, "Package"])
if (install.dplyr) install.packages("dplyr")
library(dplyr, warn.conflicts = FALSE)
options(dplyr.summarise.inform = FALSE)

install.tidyr <- !("tidyr" %in% installed.packages()[, "Package"])
if (install.tidyr) install.packages("tidyr")
library(tidyr, warn.conflicts = FALSE)

install.lubridate <- !("lubridate" %in% installed.packages()[, "Package"])
if (install.lubridate) install.packages("lubridate")
library(lubridate, warn.conflicts = FALSE)

install.plotly <- !("plotly" %in% installed.packages()[, "Package"])
if (install.plotly) install.packages("plotly")
library(plotly, warn.conflicts = FALSE)

install.scales <- !("scales" %in% installed.packages()[, "Package"])
if (install.scales) install.packages("scales")
library(scales, warn.conflicts = FALSE)

install.shinyWidgets <- !("shinyWidgets" %in% installed.packages()[, "Package"])
if (install.shinyWidgets) install.packages("shinyWidgets")
library(shinyWidgets, warn.conflicts = FALSE)

install.networkD3 <- !("networkD3" %in% installed.packages()[, "Package"])
if (install.networkD3) install.packages("networkD3")
library(networkD3, warn.conflicts = FALSE)

install.janitor <- !("janitor" %in% installed.packages()[, "Package"])
if (install.janitor) install.packages("janitor")
library(janitor, warn.conflicts = FALSE)

con <- DBI::dbConnect(RMySQL::MySQL(),
    user = "master", password = "1234",
    dbname = "tienda", host = "localhost"
)
ventas <- DBI::dbReadTable(con, "venta")
DBI::dbDisconnect(con)

data <- ventas %>%
    group_by(fecha) %>%
    summarise(
        cantidad = sum(cantidad),
        importe = sum(importe)
    )

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
                valueBoxOutput("usuarios"),
                valueBoxOutput("tickets"),
                valueBoxOutput("cpromedio")
            ),
            box(
                width = 12,
                title = NULL,
                status = "primary",
                solidHeader = FALSE,
                collapsible = FALSE,
                column(6,
                    plotlyOutput("importes")
                ),
                column(6,
                    plotlyOutput("importes")
                )
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


server <- function(input, output) {
    output$usuarios <- renderValueBox({
        a <- ventas$cliente %>%
            unique() %>%
            length()
        valueBox("Clientes", a)
    })

    output$tickets <- renderValueBox({
        a <- ventas$folio %>%
            unique() %>%
            length()
        valueBox("Tickets", a)
    })

    output$cpromedio <- renderValueBox({
        x <- ventas$cliente %>%
            unique() %>%
            length()
        valueBox(
            "Compra por cliente",
            paste0(
                round(100 / x, 2), "%"
            )
        )
    })

    output$importes <- renderPlotly({
        data %>%
            plot_ly(
                type = "scatter", mode = "lines", fill = "tozeroy"
            ) %>%
            add_trace(x = ~fecha, y = ~importe, name = "Importe") %>%
            layout(showlegend = FALSE)
    })
}

shinyApp(ui, server)


# library(shiny)
# runApp("C:/Users/Germain/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/basedatos/bici-datos/dashboard")
