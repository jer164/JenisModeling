#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Waffle Pars Calculator"),

    # Sidebar with a slider input for number of bins 
    fluidRow(
      column(3,
                    selectInput("select", h3("Day of Week"), 
                                choices = list("Monday" = 1, "Tuesday" = 2,
                                               "Wednesday" = 3, "Thursday" = 4,
                                               "Friday" = 5, "Saturday" = 6,
                                               "Sunday" = 7), selected = 1)),
    
      column(3, 
             selectInput("select", h3("Season"), 
                         choices = list("Winter" = 1, "Spring" = 2,
                                        "Summer" = 3, "Fall" = 4)
                                       , selected = 1)),
    
      column(3, 
            selectInput("select", h3("OSU in Session"), 
                   choices = list("No" = 1, "Yes" = 2)
                   , selected = 1)),
      
      column(3,
             selectInput("select", h3("Forecast"), 
                         choices = list("Chilly" = 1, "Drizzling" = 2,
                                        "Overcast" = 3, "Snow" = 4,
                                        "Stormy" = 5, "Sunny" = 6), selected = 1)),
      
      column(3,
             selectInput("select", h3("Special Event?"), 
                         choices = list("No" = 1, "Yes" = 2
                                        ), selected = 1)),
      
       )
    
)
        

# Define server logic required to draw a histogram
server <- function(input, output) {}

# Run the application 
shinyApp(ui = ui, server = server)
