# Meu primeiro shiny app
# 
# Faça um shiny app para visualizar histogramas da base diamonds 
# e o coloque no shinyapps.io.
# 
# Seu shiny deve ter um input e um output.
# 
# - Input: variáveis numéricas da base diamonds.
# - Output: histograma da variável selecionada.
# 
# Para acessar a base diamonds, carrrege o pacote ggplot2
# 
# library(ggplto2)
# 
# ou rode 
# 
# ggplot2::diamonds

library(shiny)
library(ggplot2)
library(dplyr)

#Selecionei apenas as variaveis numericas
diamonds_num <- diamonds %>%  
  dplyr::select(where(is.numeric))

#Defini uma UI simples
ui <- fluidPage(
  fluidPage(
    shiny::varSelectInput(diamonds_num,
                          inputId = "vars",
                          label = "Variavel"),
    plotOutput(outputId = "grafico")
  )
)

#Usei o ggplot para gerar o histograma
server <- function(input, output, session) {
  output$grafico <- renderPlot({
    
    diamonds_num %>% 
      ggplot(aes(x = !!input$vars)) +
      geom_histogram()
  })
}

shinyApp(ui, server)