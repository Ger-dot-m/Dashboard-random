install.scales <- !("scales" %in% installed.packages()[, "Package"])
if (install.scales) install.packages("scales")
library(scales, warn.conflicts = FALSE)


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

    output$total <- renderValueBox({
        a <- ventas$importe %>%
            sum() %>%
            dollar(prefix = "$", accuracy = 0.01)
        valueBox("Importe", a)
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

    output$cantidad <- renderPlotly({
        data %>%
            plot_ly(
                type = "bar"
            ) %>%
            add_trace(x = ~fecha, y = ~cantidad, name = "Cantidad de Ventas") %>%
            layout(showlegend = FALSE)
    })

    output$importes <- renderPlotly({
        filtered_data <- ventas %>%
            filter(producto == input$producto)
        p <- plot_ly(data = filtered_data, x = ~fecha, y = ~importe, type = "scatter", mode = "lines", fill = "tozeroy")
        p
    })

    output$cantidad <- renderPlotly({
        filtered_data <- ventas %>%
            filter(fecha >= input$dateRange[1] & fecha <= input$dateRange[2])
        p <- plot_ly(data = filtered_data, x = ~fecha, y = ~cantidad, type = "bar")
        p
    })

    output$productos_mas_menos_vendidos <- renderPlotly({
        # Calcular la cantidad de ventas por producto
        ventas_por_producto <- ventas %>%
            group_by(producto) %>%
            summarise(total_ventas = sum(cantidad)) %>%
            arrange(desc(total_ventas)) # Ordenar por cantidad de ventas de mayor a menor

        # Tomar los 5 productos más vendidos y los 5 menos vendidos
        productos_top_bottom <- rbind(head(ventas_por_producto, 10), tail(ventas_por_producto, 10))

        # Crear un gráfico de barras con Plotly
        plot_ly(data = productos_top_bottom, x = ~producto, y = ~total_ventas, type = "bar", marker = list(color = "steelblue")) %>%
            layout(xaxis = list(tickangle = 45, title = "Producto"), yaxis = list(title = "Cantidad de Ventas")) %>%
            add_trace(text = ~total_ventas, textposition = "outside", hoverinfo = "text") # Muestra el valor encima de las barras
    })
}
