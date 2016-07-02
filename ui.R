shinyUI(
        pageWithSidebar(
                # Application title
                headerPanel("Fuel Efficiency Prediction Based On Vehicle Weight"),
                
                sidebarPanel(
                        numericInput('weight', 'Weight in tons', 3, min = 1, max = 6, step = .1),
                        submitButton('Submit')
                ),
                mainPanel(
                        h3('Results of prediction'),
                        h4('You entered'),
                        verbatimTextOutput("inputValue"),
                        h4('Which resulted in a prediction of '),
                        verbatimTextOutput("prediction")
                )
        )
)