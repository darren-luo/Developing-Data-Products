# The app shows the average price of a diamond based on data from the diamonds dataset
library(shiny)
library(tidyverse)

shinyServer(function(input, output) {
    diamonds <- diamonds
    
    diamond_count <- reactive({
        filtered_df <- filter(diamonds, carat <= input$caratslider, cut == input$cutselector, color == input$colorselector, clarity == input$clarityselector)
        ifelse(nrow(filtered_df) == 0, "There are no diamonds that match your criteria", paste("There are ", nrow(filtered_df), " diamonds in the dataset that match your criteria"))
    })
    df_avg_price <- reactive({
        filtered_df <- filter(diamonds, carat <= input$caratslider, cut == input$cutselector, color == input$colorselector, clarity == input$clarityselector)
        mean(filtered_df$price)
    })
    
    output$diamondplot <- renderPlot({
        filtered_df <- filter(diamonds, carat <= input$caratslider, cut == input$cutselector, color == input$colorselector, clarity == input$clarityselector)
        ggplot(filtered_df, aes(x=carat, y=price))+geom_point(aes(size=depth, color = table))+labs(x="Weight of diamond (Carat)", y="Price of Diamond (US$)", title="Scatter Plot of Diamond Price vs Carat")+geom_smooth(aes(y=price), color="red", lty = 2, method='lm', se=FALSE)
    })
    output$diamond_count <- renderText({diamond_count()})
    output$avg_price <- renderText({df_avg_price()})
})