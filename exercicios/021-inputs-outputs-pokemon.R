# Explorando inputs
# 
# Utilizando a base de pokemon, faça um Shiny app que permite escolher
# um tipo (tipo_1) e uma geração e faça um gráfico de dispersão do ataque 
# vs defesa para os pokemon com essas características.

library(shiny)
library(ggplot2)
library(dplyr)

pokemon <- readr::read_rds(file = here::here("dados/pkmn.rds"))

ui <- fluidPage(
  selectInput(inputId = "tipo",
              label = "Tipo do Pokemon",
              choices = unique(pull(pokemon,tipo_1))),
  plotOutput(outputId = "grafico")
)

server <- function(input, output, session) {
  
  
  output$grafico <- renderPlot({
    
    pokemon %>% 
      filter(tipo_1 == !!input$tipo) %>% 
      ggplot(aes(x = defesa, y = ataque)) +
      geom_point()
    
  })
  
}

shinyApp(ui, server)