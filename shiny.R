library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Airline Passenger Satisfaction Data Visualization"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("plotType", "Select Plot Type:",
                   choices = c("Bar Plot", "Scatter Plot"),
                   selected = "Bar Plot"),
      selectInput("xVariable", "X-Axis Variable:",
                  choices = c("Gender", "Class", "Age")),
      selectInput("yVariable", "Y-Axis Variable:",
                  choices = c("Online boarding", "Seat comfort", 
                              "Inflight service", "Cleanliness"))
    ),
    
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  
  data <- read.csv("D:\\project\\Airline passenger satisfaction train latest.csv")
  output$plot <- renderPlot({
    if (input$plotType == "Bar Plot") {
      ggplot(data, aes(x = get(input$xVariable), y = get(input$yVariable))) +
        geom_bar(stat = "identity", position = "dodge") +
        labs(x = input$xVariable, y = input$yVariable, title = "Bar Plot")
    } else {
      ggplot(data, aes(x = get(input$xVariable), y = get(input$yVariable))) +
        geom_point() +
        labs(x = input$xVariable, y = input$yVariable, title = "Scatter Plot")
    }
  })
}

shinyApp(ui = ui, server = server)
