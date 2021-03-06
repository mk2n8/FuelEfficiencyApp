---
title       : MPG Calculator
subtitle    : Shiny App Using Vehicle Weight as Predictor of Fuel Efficiency
author      : MK
job         : 
framework   : io2012   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Background

1. Data from mtcars show that vehicle weight is the number 1 predictor of fuel efficiency.


2. Compared to all other potential predictors, the correlation between 'wt' and 'mpg' is the strongest at -0.86: 

```
##         wt        cyl       disp         hp       carb       qsec 
## -0.8676594 -0.8521620 -0.8475514 -0.7761684 -0.5509251  0.4186840 
##       gear         am         vs       drat        mpg 
##  0.4802848  0.5998324  0.6640389  0.6811719  1.0000000
```

3. A more detailed analysis is available on [RPubs](http://rpubs.com/mk2n8/fuel).

4. The [Shiny App](https://mk2n8.shinyapps.io/estimateMPG/) presented here uses a linear regression model to predict MPG based on vehicle weight.

--- 

## Building a Linear Regression Model

Assuming a linear relationship between the dependent variable 'mpg' and the independent variable 'wt,' a  simple regression function would allow plugging in weight in tons to calculate a predicted mpg for a given vehicle:


```r
mpgPredict <- function(weight) {
        mtcarsWeight<-mtcars$wt
        mtcarsMPG<-mtcars$mpg
        lm1<-lm(mtcarsMPG ~ mtcarsWeight)
        coeffs = coefficients(lm1); coeffs
        estimateMPG = coeffs[1] + coeffs[2]*weight
        names(estimateMPG) <- "Miles Per Gallon"
        round(estimateMPG, digits = 1)
}
```

--- 

## Building the Shiny App: ui.R

The file ui.R creates: 

1. Basic page with the app title

2. Space for entering a vehicle's weight in tons between 1 and 6 tons at 0.1 increments

3. Space where the calculated mpg estimate is shown rounded to the nearest 0.1.


```r
mpgPredict <- function(weight) {
        mtcarsWeight<-mtcars$wt
        mtcarsMPG<-mtcars$mpg
        lm1<-lm(mtcarsMPG ~ mtcarsWeight)
        coeffs = coefficients(lm1); coeffs
        estimateMPG = coeffs[1] + coeffs[2]*weight
        names(estimateMPG) <- "Miles Per Gallon"
        round(estimateMPG, digits = 1)
}
```

--- 

## Building the Shiny App: server.r

The file server.r contains the function used to predict mpg based on weight and rendering instructions for the information on the web page:


```r
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
```
