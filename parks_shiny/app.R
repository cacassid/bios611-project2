#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Biodiversity in National Parks App"),
    
    p("Number of types of species"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("display_var",
                         "Which variable to display",
                         choices = c("Mammal" = "Mammal",
                                     "Bird" = "Bird",
                                     "Reptile" = "Reptile", 
                                     "Fish" = "Fish", 
                                     "Amphibian" = "Amphibian",
                                     "Insect" = "Insect",
                                     "Fungi" = "Fungi",
                                     "Vascular Plants" = "Vascular Plants",
                                     "Nonvascular Plants" = "Nonvascular Plants"),
                         selected = "Mammal"
            ),
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

# Define server logic 
server <- function(input, output) {
    
    output$distPlot <- renderPlot({
        # set x-axis label depending on the value of display_var
        if (input$display_var == "Mammal") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = Mammal)) + 
                geom_bar(stat = "identity", fill = "#4A5C93") +
                xlab("Latitude") + ylab("Number of Mammal Species")
        } else if (input$display_var == "Bird") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = Bird)) + 
                geom_bar(stat = "identity", fill = "#3A9999") +
                xlab("Latitude") + ylab("Number of Bird Species")
        } else if (input$display_var == "Reptile") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = Reptile)) + 
                geom_bar(stat = "identity", fill = "#86C14C") +
                xlab("Latitude") + ylab("Number of Reptile Species")
        } else if (input$display_var == "Fish") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = Fish)) + 
                geom_bar(stat = "identity", fill = "#1E81CA") +
                xlab("Latitude") + ylab("Number of Fish Species")
        } else if (input$display_var == "Amphibian") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = Amphibian)) + 
                geom_bar(stat = "identity", fill = "#CA6F1E") +
                xlab("Latitude") + ylab("Number of Amphibian Species")
        } else if (input$display_var == "Insect") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = Insect)) + 
                geom_bar(stat = "identity", fill = "#CA381E") +
                xlab("Latitude") + ylab("Number of Insect Species")
        } else if (input$display_var == "Fungi") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = Fungi)) + 
                geom_bar(stat = "identity", fill = "#976F44") +
                xlab("Latitude") + ylab("Number of Fungi Species")
        } 
        else if (input$display_var == "Vascular Plants") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = `Vascular Plant`)) + 
                geom_bar(stat = "identity", fill = "#03783D") +
                xlab("Latitude") + ylab("Number of Vascular Plant Species")
        } 
        else if (input$display_var == "Nonvascular Plants") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = `Nonvascular Plant`)) + 
                geom_bar(stat = "identity", fill = "#6A934A") +
                xlab("Latitude") + ylab("Number of Nonvascular Plant Species")
        } 
        
    })
}


# Run the application
shinyApp(ui = ui, server = server)
