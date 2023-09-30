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


source("server.R", local = TRUE)
source("UI.R", local = TRUE)

shinyApp(ui, server)


# library(shiny)
# runApp("dashboard/")
