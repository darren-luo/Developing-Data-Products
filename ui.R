library(shiny)
library(tidyverse)

# Define UI for application calculates average diamond price based on fixed set of  inputs
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Average price of diamond given fixed inputs"),
  
  # Sidebar showing options available for selection
  sidebarLayout(
    sidebarPanel(
       sliderInput("caratslider","Select Carat Max Weight Range", min = min(diamonds$carat), max = max(diamonds$carat), value = 0.2),
       selectInput("cutselector","Select Cut", choices = as.character(unique(diamonds$cut)),multiple = FALSE),
       selectInput("colorselector","Select Color", choices = as.character(unique(diamonds$color)), multiple = FALSE),
       selectInput("clarityselector","Select Clarity", choices = as.character(unique(diamonds$clarity)), multiple = FALSE)),
    # Show a plot of the generated distribution
    mainPanel(
       h3("Plot of Diamond price vs Weight"),
       plotOutput("diamondplot"),
       textOutput("diamond_count"),
       h3("The average price of diamonds based on specified characteristics is:"),
       textOutput("avg_price")
    )
  )
))