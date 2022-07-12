# Gráfico de dispersão da base mtcars
#
# Faça um Shiny app para mostrar um gráfico de dispersão (pontos)
# das variáveis da base mtcars.
#
# O seu app deve:
#
#   - Ter dois inputs: a variável a ser colocada no eixo e a variável
#     a ser colocada no eixo y
#
#   - Um output: um gráfico de dispersão
library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  varSelectInput(inputId = "var_x",label = "Variavel X",data = select(mtcars,where(is.numeric))),
  varSelectInput(inputId = "var_y",label = "Variavel Y",data = select(mtcars,where(is.numeric))),
  plotOutput(outputId = "grafico")
)

server <- function(input, output, session) {
  
  output$grafico <- renderPlot({
    
    mtcars %>% 
      ggplot(aes(x = !!input$var_x,y = !!input$var_y)) +
      geom_point(size = 2)
    
  })
  
}

shinyApp(ui, server)