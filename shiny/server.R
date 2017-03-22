#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

all_crime <- read_csv("../results/clean_crime.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$tsPlot <- renderPlot({

      sub_data <- all_crime %>%
        select(STATISTIC, Year, REGION, `POLICING JURISDICTION`, Value) %>% 
        filter(STATISTIC == input$stat_chosen) %>%
        filter(Year >= as.integer(input$year_chosen[1]) & 
                 Year <= as.integer(input$year_chosen[2]) &
                 REGION == input$region_selection &
                 `POLICING JURISDICTION`  %in% input$jurisdictions) %>% 
        group_by(`POLICING JURISDICTION`, Year) %>% 
        summarize(Value=sum(Value))
      
      print(sub_data$Value)
    
    (ggplot(sub_data, aes(x=Year, y=Value, colour=`POLICING JURISDICTION`)) + 
        geom_line() + geom_point() + 
        guides(colour = guide_legend(title = "Jurisdiction")) + 
        xlab("Year") + ylab(input$stat_chosen) + ggtitle("Time Series"))
    
  })
  
  # filter department by selected state
  output$jurisdictionControls <- renderUI({
    sub_jurisdictions <- all_crime %>% 
      filter(REGION == input$region_selection) %>% 
      select(`POLICING JURISDICTION`) %>%
      .$`POLICING JURISDICTION` %>% 
      unique()
    checkboxGroupInput("jurisdictions", "Choose Jurisdictions", sub_jurisdictions)
  })
  
})
