# Explorando inputs
# 
# Utilizando a base de criminalidade, faça um Shiny app que, dado um 
# mês/ano escolhido pelo usuário, mostre uma tabela com o número de ocorrências 
# de cada tipo que aconteceram naquele mês. 
# O nível territorial (Estado, região, município ou delegacia) também pode 
# ser um filtro.
# 

library(shiny)
library(dplyr)
library(ggplot2)

crimes <- readr::read_rds(file = here::here("dados/ssp.rds"))

ui <- fluidPage(
  selectInput(inputId = "mes",
              label = "Mês",
              choices = as.character(1:12)),
  selectInput(inputId = "ano",
              label = "Ano",
              choices = seq(from = min(crimes$ano),
                            to = max(crimes$ano),
                            by = 1)),
  selectInput(inputId = "regiao",
              label = "Região",
              choices = unique(pull(crimes,regiao_nome))),
  hr(),
  tableOutput(outputId = "tabela")
)

server <- function(input, output, session) {
  
  output$tabela <- renderTable({
    crimes %>% 
      filter(ano == !!input$ano, mes == !!input$mes,regiao_nome == !!input$regiao) %>% 
      mutate(ano = as.integer(ano), mes = as.integer(mes))
  })
  
}

shinyApp(ui, server)