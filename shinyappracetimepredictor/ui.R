shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Race Time Predictor"),
    
    sidebarPanel(
      numericInput('T1', 'Time in minutes of a recent race', 1, min = 1, max = 360, step = 1),
      numericInput('D1', 'Distance in KM of your recent race ', 1, min = 1, max = 50, step = 1),
      numericInput('D2', 'Distance in KM of your planning race ', 1, min = 1, max = 50, step = 1),
      submitButton('Submit')
    ),
    mainPanel(
      tabsetPanel(type = "tabs", 
                  tabPanel("Prediction", h3('Results of prediction in minutes'), h4('Which resulted in a prediction of '), 
                           verbatimTextOutput("prediction") ),
                                     
                                    
                  
                  tabPanel("Documentation", h3('This is an explanation of the formula'),
                           p('This calculator lets you input an actual race time to see what you should be capable of at another distance. It is adjusted for distance (ie its 10K prediction is not just double your 5K time), but there are three caveats.
                            It assumes you have done appropriate training for the distance. Doing a 22-minute 5K today does not mean you can do a sub-4 marathon tomorrow. Obvious, really.
                           It assumes you do not have a natural significant bias towards either speed or endurance. Some people, no matter how much training they do, will always over-achieve at one end of the scale.
                           The calculations become less accurate for times under three and a half minutes and over four hours.'), 
                           p('The formula was originally devised by Pete Riegel, a research engineer and marathoner, and published in Runners World many moons ago by Owen Anderson in 1997. It has stood the test of time since then and has been widely used.'),
                           p('The formula is T2 = T1 x (D2/D1)1.06 where T1 is the given time, D1 is the given distance, D2 is the distance to predict a time for, and T2 is the calculated time for D2.'))
                  
      )
    )
    
  )
)




# 
# shinyUI(
#   pageWithSidebar(
#     # Application title
#     headerPanel("Race Time Predictor"),
#     
#     sidebarPanel(
#       numericInput('T1', 'Time in minutes of a recent race', 1, min = 1, max = 360, step = 1),
#       numericInput('D1', 'Distance in KM of your recent race ', 1, min = 1, max = 50, step = 1),
#       numericInput('D2', 'Distance in KM of your planning race ', 1, min = 1, max = 50, step = 1),
#       submitButton('Submit')
#     ),
#     mainPanel(
#       h3('Results of prediction in minutes'),
#       h4('Which resulted in a prediction of '),
#       verbatimTextOutput("prediction")
#     )
#   )
# )

