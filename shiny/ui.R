#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

all_crime <- read_csv("clean_crime.csv")

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
  
  # google analytics
  tags$head(includeScript("google-analytics.js")),
  
  # Application title
  titlePanel("BC Crime Trends 2006 - 2015"),
  a("Data Source: Open Data BC - BC Crime Types", href="https://catalogue.data.gov.bc.ca/dataset/bc-crime-types"),
  p(""),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("stat_chosen",
                  "Statistic:",c(unique(all_crime$STATISTIC))),
      
      #radioButtons("stat", "Statistic:",
      #             c("Total" = "total",
      #               "Per 100,000 Population" = "per100")),
      
      
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
