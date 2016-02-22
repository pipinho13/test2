timeprediction <- function(T1,D1,D2) T1*(D2/D1)*1.06

shinyServer(
  function(input, output) {
    output$inputValue1 <- renderPrint({input$T1})
    output$inputValue2 <- renderPrint({input$D1})
    output$inputValue3 <- renderPrint({input$D2})
    output$prediction <- renderPrint({timeprediction(input$T1, input$D1, input$D2 )})
  }
)

