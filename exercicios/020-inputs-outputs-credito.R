# Explorando inputs
# 
# Utilizando a base de crédito, faça um Shiny app que permite escolher
# o estado civil, tipo de moradia e/ou trabalho e mostra uma visualização
# representando a proporção de clientes "bons" e "ruins" da base.

library(shiny)
library(dplyr)
library(ggplot2)

dado <- readr::read_rds(file = here::here("dados/credito.rds"))

ui <- fluidPage(
  selectInput(inputId = "estCivil",
              label = "Estado civil",
              choices = unique(pull(dado,estado_civil))),
  selectInput(inputId = "moradia",
              label = "Moradia",
              choices = unique(pull(dado,moradia))),
  selectInput(inputId = "trabalho",
              label = "Trabalho",
              choices = unique(pull(dado,trabalho))),
  plotOutput(outputId = "grafico")
)

server <- function(input, output, session) {
  
  output$grafico <- renderPlot({
    dado %>% 
      ggplot(aes(x = ,y = , fill = status))
  })
}

shinyApp(ui, server)