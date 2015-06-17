# This is the server logic for a Shiny web application.
# created for the peer assessment of the Developing Data Products
# Coursera module.
#
# https://www.coursera.org/course/devdataprod
#
# Data source: http://data.london.gov.uk/dataset/london-borough-profiles
#


library(shiny)

# load the data
df <- read.csv("data/london-borough-profiles.csv")


shinyServer(function(input, output) {

  model <- reactive({
    
    df.x <- switch(input$var, 
                   "Population density" = df[ , 2],
                   "Average age" = df[ , 6],
                   "Unemployment rate" = df[ ,7],
                   "Gross annual pay" = df[ , 8],
                   "Crime rate" = df[, 9])
    
    lm(df$Happiness.score ~ df.x)
    
  })
  
  output$distPlot <- renderPlot({

    df.x <- switch(input$var, 
                   "Population density" = df[ , 2],
                   "Average age" = df[ , 6],
                   "Unemployment rate" = df[ ,7],
                   "Gross annual pay" = df[ , 8],
                   "Crime rate" = df[, 9])
      
    plot(x = df.x, y = df$Happiness.score,
         xlab = input$var,
         ylab = "Happiness index")
    
    abline(a = model()[1], b = model()[2], col = c("red"))
    
  })

  output$prediction <- renderText({
    newdata <- data.frame(df.x = as.numeric(input$text))
    paste("Your borough's predicted Happines index is ",
          round(predict(model(), newdata), 2)
          )
  })
  
})
