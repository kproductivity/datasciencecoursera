# This is the server logic for a Shiny web application.
# created for the peer assessment of the Developing Data Products
# Coursera module.
#
# https://www.coursera.org/course/devdataprod


library(shiny)

shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
