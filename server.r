mpgPredict <- function(weight) {
        mtcarsWeight<-mtcars$wt
        mtcarsMPG<-mtcars$mpg
        lm1<-lm(mtcarsMPG ~ mtcarsWeight)
        coeffs = coefficients(lm1); coeffs
        estimateMPG = coeffs[1] + coeffs[2]*weight
        names(estimateMPG) <- "Miles Per Gallon"
        round(estimateMPG, digits = 1)
}

shinyServer(
        function(input, output) {
                output$inputValue <- renderPrint({input$weight})
                output$prediction <- renderPrint({mpgPredict(input$weight)})
        }
)