# Meu segundo shiny app (agora importando uma base de dados)
# 
# Escolha uma das bases da pasta dados ou use uma base própria.
# 
# - Crie um shiny app com pelo menos um input e um output 
# para visualizarmos alguma informação interessante da base.
# 
# - Suba o app para o shinyapps.io.
# 
# Observação: se você usar uma base própria, 
# não se esqueça de descrever as variáveis utilizadas na hora 
# de tirar dúvidas.
library(shiny)
library(ggplot2)
library(dplyr)
dado <- readr::read_rds(file = here::here("dados/credito.rds"))


ui <- fluidPage(
  varSelectInput(inputId = "var_num",
                 data = select(dado,where(is.numeric)),
                 label = "Numerica"),
  varSelectInput(inputId = "var_cat",
                 data = select(dado,where(is.character)),
                 label = "Categorica",selected = "status"),
  plotOutput(outputId = "grafico")
)
# A minha ideia foi produzir uma visualizção onde o usuario entrasse com uma var numerica
# sobre o crédito que seria comparada com o status da pessoa, e variaveis categoricas
# poderia ser utilizadas para colorir de modo a melhorar a visualização. Num contexto real
# a visualização deveria ser aprimorada.
server <- function(input, output, session) {
  
  output$grafico <- renderPlot({
    
    dado %>% 
      ggplot(aes(x = !!input$var_num, fill = !!input$var_cat)) +
      geom_histogram() +
      facet_wrap(~status)
    
  })
}

shinyApp(ui, server)