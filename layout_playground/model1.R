library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  
  includeCSS(path = here::here("www/dark_mode1.css")),
  
  fluidRow(h1("This is the title")),
  
  fluidRow(
    column(width = 8,h2("col big"),
           plotOutput("BigGraph")),
    column(width = 4,fluidRow(
      h2("col small1")
    ),
    fluidRow(
      h2("col small2")
    )
    )
  ),
  fluidRow(
    column(width = 4,h2("col1")),
    column(width = 4,h2("col2")),
    column(width = 4,h2("col3"))
  )
)

server <- function(input, output, session) {
  output$BigGraph <- renderPlot({
    mtcars %>% 
      ggplot(aes(x = disp, y = hp, col = factor( cyl))) +
      geom_point(size = 5) +
      theme(rect = element_rect(),
            plot.background = element_rect(fill = NULL))
  })
}

shinyApp(ui, server)