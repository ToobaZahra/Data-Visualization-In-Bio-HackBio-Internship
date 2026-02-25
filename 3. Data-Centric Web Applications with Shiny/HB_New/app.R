library(shiny)


bacteria_data <- read.csv(file = 'E:/Data-Visualization-In-Bio-HackBio-Internship/2. Data Visualisation with R/bacteria.csv', header = T)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Simple Bacteria Data"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      selectInput(inputId = "x_axis",
                  label = "Select X axis: ",
                  choices = colnames(bacteria_data),
                  selected = 'C1' ),
      
      selectInput(inputId = "y_axis",
                  label = "Select Y axis: ",
                  choices = colnames(bacteria_data),
                  selected = 'C2' ),
      
      selectInput(inputId = "isolation_Source",
                  label = "Select Isolation Source",
                  choices = unique(bacteria_data$Isolation.origin),
                  selected = 'species' ),
      
      selectInput(inputId = "color",
                  label = "Select Color: ",
                  choices = colnames(bacteria_data),
                  selected = 'labels' )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("scatter_plot"),
      plotOutput("scatter_plot_2")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  data_to_plot <- reactive({
    subset(bacteria_data, Isolation.origin == input$isolation_Source)
  })
  
  output$scatter_plot <- renderPlot({
    plot(x = data_to_plot()[[input$x_axis]], 
         y = data_to_plot()[[input$y_axis]],
         col = as.factor(data_to_plot()[[input$color]]),
         pch = 19,
         cex = 1.5,
         ylab = input$y_axis,
         xlab = input$x_axis)
  })
  
  output$scatter_plot_2 <- renderPlot({
    plot(x = data_to_plot()[[input$y_axis]], 
         y = data_to_plot()[[input$x_axis]],
         col = as.factor(data_to_plot()[[input$color]]),
         pch = 19,
         cex = 1.5,
         ylab = input$y_axis,
         xlab = input$x_axis)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)