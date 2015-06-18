# This is the user-interface definition of a Shiny web application
# created for the peer assessment of the Developing Data Products
# Coursera module.
#
# https://www.coursera.org/course/devdataprod
#
# Data source: http://data.london.gov.uk/dataset/london-borough-profiles
#


library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("London Boroughs Happiness"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("var", 
                  label = "Choose a variable",
                  choices = list("Population density",
                                 "Average age",
                                 "Unemployment rate",
                                 "Gross annual pay",
                                 "Crime rate"),
                  selected = "Population density"),
      textInput("text", label = h3("Your borough's value"), 
                value = "0")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      pre(includeText("documentation.txt")),
      br(),
      plotOutput("distPlot"),
      textOutput("prediction")
    )
  )
))
