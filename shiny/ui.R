#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("BC Crime Trends 2006 - 2015"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("stat_chosen",
                  "Statistic:",c(unique(all_crime$STATISTIC))),
      
      radioButtons("stat", "Statistic:",
                   c("Total" = "total",
                     "Per 100,000 Population" = "per100")),
      
      
       sliderInput("year_chosen",
                   "Year Range:",
                   min = 2006,
                   max = 2015,
                   value = c(2006,2015),
                   step = 1,
                   sep = ""),
       
       selectInput("region_selection", "Region",unique(all_crime$REGION)),
       uiOutput("jurisdictionControls")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       #plotOutput("barPlot"),
       plotOutput("tsPlot")
    )
  )
))
