library(shiny)
bacteria_data <- read.delim(file = 'E:/Data-Visualization-In-Bio-HackBio-Internship/2. Data Visualisation with R/bacteria.csv',
                            sep = ",", header = TRUE)

ui <- fluidPage(
  titlePanel("HackBio Bacteria Dataset"),
  sidebarLayout(
    sidebarPanel(
      selectInput('x_axis', 'Select X axis:',
                  choices = colnames(bacteria_data)[c(1,2,8,9,10,11,12,13)],
                  selected = 'C1'),
      selectInput('y_axis', 'Select Y axis:',
                  choices = colnames(bacteria_data)[c(1,2,8,9,10,11,12,13)],
                  selected = 'C2'),
      selectInput('color', 'Select Coloring Parameters:',
                  choices = colnames(bacteria_data)[c(3,4,5,6,7,14)],
                  selected = 'labels')
    ),
    mainPanel(
      plotOutput(outputId = 'scatter_plot'),# ✅ inside sidebarLayout
      plotOutput(outputId = 'scatter_plot_2'),
      plotOutput(outputId = 'density_plot')
    )
    
  )
)

server <- function(input, output) {
  output$scatter_plot <- renderPlot({
    x_value   <- bacteria_data[[input$x_axis]]
    y_value   <- bacteria_data[[input$y_axis]]
    col_value <- as.factor(bacteria_data[[input$color]])
    bg_colors <- palette()[as.integer(col_value)]     # ✅ valid colors
    
    plot(x = x_value, y = y_value,
         col  = 'black',
         main = paste0('Scatter Plot of ', input$x_axis, ' vs ', input$y_axis),
         bg   = bg_colors,
         pch  = 21, cex = 1.5,
         xlab = input$x_axis, ylab = input$y_axis)
  })
  
  output$scatter_plot_2 <- renderPlot({
    x_value <- bacteria_data[[input$y_axis]]
    y_value <- bacteria_data[[input$x_axis]]
    col_value <- as.factor(bacteria_data[[input$color]])
    bg_colors <- palette()[as.integer(col_value)]
    
    plot(x=x_value, y= y_value,
         col = 'black',
         main = paste0('Scatter Plot of ', input$y_axis, ' vs ', input$x_axis),         bg = bg_colors,
         pch = 21, cex = 1.5,
         xlab = input$y_axis , ylab = input$x_axis
         )
  })
  
  output$density_plot <- renderPlot({
    
    x_value <- bacteria_data[[input$x_axis]]
    y_value <- bacteria_data[[input$y_axis]]
    
    plot(density(x_value , na.rim = T))
    
  })
}

shinyApp(ui = ui, server = server)

