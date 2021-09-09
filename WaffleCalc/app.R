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
    headerPanel("Waffle Pars Calculator"),

      sidebarPanel(
      selectInput("day", h3("Day of Week"), choices = list("Monday" = 1, "Tuesday" = 2,
                                               "Wednesday" = 3, "Thursday" = 4,
                                               "Friday" = 5, "Saturday" = 6,
                                               "Sunday" = 7), selected = 1),
    
       numericInput("precip", 
                          h3("Expected Rainfall"), 
                          value = 1),
      
       numericInput("temp", 
                          h3("Temperature(F)"), 
                          value = 70),
    
       selectInput("snow", h3("Snowing?"), 
                   choices = list("No" = 1, "Yes" = 2)
                   , selected = 1),
      
       selectInput("stormy", h3("Stormy?"), 
                         choices = list("No" = 1, "Yes" = 2), 
                         selected = 1),
    
      mainPanel(
        h3(verbatimTextOutput("pasted")),
        
      )
    )
  )

waffle_totals_daily <- read.xlsx("/Users/jacksonrudoff/Documents/Data Projects/Waffle Project/waffle_totals.xlsx") %>% as_tibble()

library(readr)
weather_data <- read_csv("/Users/jacksonrudoff/Documents/Data Projects/Waffle Project/weather data.csv") %>% as_tibble()

dailytemp <- weather_data$TAVG[214:366]
dailyprecip <- weather_data$PRCP[214:366]
snow <- weather_data$SNOW[214:366]
thunder <- weather_data$WT03[214:366] %>% 
  replace_na(0) %>% as.factor()

cones_real <- waffle_totals_daily$Cones[1:153]
bowls_real <- waffle_totals_daily$Bowls[1:153]
days_real <- waffle_totals_daily$Day[1:153] %>% as_factor()


firstmodel <- tibble(days_real,cones_real,bowls_real,dailytemp,dailyprecip,snow,thunder)

cone_model <- lm(formula = 
                   cones_real ~ days_real + dailyprecip + dailytemp + snow + thunder, data = firstmodel)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  waffle_text <- reactive({
    predict(cone_model, 
                  data.frame(
                    days_real = input$day, 
                    dailyprecip = input$precip,
                    dailytemp = input$temp, 
                    snow = input$snow, 
                    thunder = input$stormy))})
  
  
  output$pasted <- renderPrint({waffle_text})
  
}
  

  

# Run the application 
shinyApp(ui = ui, server = server)
