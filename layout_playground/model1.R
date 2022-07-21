library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  
  includeCSS(path = here::here("www/dark_mode1.css")),
  
  fluidRow(h1("This is the title")),
  
  fluidRow(
    column(width = 8,h2("col big"),
           plotOutput("BigGraph")),
    column(width = 4,
           fluidRow(
      box( title = "Inputs", solidHeader = TRUE,
           "Box content here", br(), "More box content",
           sliderInput("slider", "Slider input:", 1, 100, 50),
           textInput("text", "Text input:"),background = "purple")
    ),
    fluidRow(
      valueBox(value = "75%",subtitle = "Aprovam","red",width = 12,
               icon = icon("thumbs-up",lib = "glyphicon")))
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
      theme(text = element_text(family = "serif"),
            plot.background = element_blank(),
            panel.background = element_blank(),
            axis.title = element_text(size = 25)) +
      viridis::scale_color_viridis(discrete = T)
  })
}

shinyApp(ui, server)