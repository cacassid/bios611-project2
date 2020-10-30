#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


#idea for new figure:
#leaflet map where size of bubbles correspond to how many endangered, extinct, etc

#install.packages("leaflet")
#install.packages("leaflet.extras")
library(shiny)
library(ggplot2)
library(tidyverse)
library(leaflet)
library(leaflet.extras)

args <- commandArgs(trailingOnly = T)

port <- as.numeric(args[[1]])

#read in data
counts_area_sl <- read_csv("derived_data/counts_area_sl.csv")

conservation_park_info <- read_csv("derived_data/conservation_park_info.csv")

# Define UI for application
ui <- navbarPage("Biodiversity in National Parks App",
                 tabPanel("Species by Latitude",
                          sidebarLayout(
                              sidebarPanel(
                                  radioButtons("display_var",
                                               "Choose a variable to display:",
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
                                  )
                              ),
                              mainPanel(
                                  plotOutput("distPlot")
                              )
                          )
                 ),
                 tabPanel("Conservation Map",
                          sidebarLayout(
                              sidebarPanel(
                                  radioButtons("display_var2",
                                               "Choose a variable to display:",
                                               choices = c("Endangered" = "Endangered",
                                                           "Threatened" = "Threatened",
                                                           "Species of Concern" = "Species of Concern",
                                                           "No Concern" = "No Concern"),
                                               selected = "Endangered"
                                  ),
                                  includeMarkdown("conservation_text.md")
                              ),
                              mainPanel(
                                  leafletOutput(outputId = "mymap")
                                  
                              )
                          )
                 )
)



# Define server logic 
server <- function(input, output) {
    
    #define the color pallate for the magnitude of the earthquake
    #pal <- colorNumeric(
     #   palette = c('gold', 'orange', 'dark orange'),
      #  domain = data$mag)
    
    #create the map
    output$mymap <- renderLeaflet({
        if(input$display_var2 == "Endangered") {
        leaflet(data) %>% 
            setView(lng = -99, lat = 45, zoom = 3)  %>% #setting the view over ~ center of North America
            addTiles() %>% 
            addCircles(data = conservation_park_info, lat = ~ Latitude, lng = ~ Longitude, 
                       weight = 1, 
                       radius = ~Endangered*10000, 
                       popup = ~as.character(paste(Park.Name, "<br>",
                                                   "# of Endangered Species: ", Endangered)), 
                       color = "#EB8811", 
                       fillOpacity = 0.5)
        }
        else if(input$display_var2 == "Species of Concern") {
            leaflet(data) %>% 
                setView(lng = -99, lat = 45, zoom = 3)  %>% #setting the view over ~ center of North America
                addTiles() %>% 
                addCircles(data = conservation_park_info, lat = ~ Latitude, lng = ~ Longitude, 
                           weight = 1, 
                           radius = ~`Species of Concern`*1000, 
                           popup = ~as.character(paste(Park.Name, "<br>",
                                                       "# of Species of Concern: ", 
                                                       `Species of Concern`)), 
                           color = "#32920F", 
                           fillOpacity = 0.5)
        }
        else if(input$display_var2 == "Threatened") {
            leaflet(data) %>% 
                setView(lng = -99, lat = 45, zoom = 3)  %>% #setting the view over ~ center of North America
                addTiles() %>% 
                addCircles(data = conservation_park_info, lat = ~ Latitude, lng = ~ Longitude, 
                           weight = 1, 
                           radius = ~Threatened*10000, 
                           popup = ~as.character(paste(Park.Name, "<br>",
                                                       "# of Threatened Species: ", 
                                                       `Species of Concern`)), 
                           color = "#0F4F92", 
                           fillOpacity = 0.5)
        }
        else if(input$display_var2 == "No Concern") {
            leaflet(data) %>% 
                setView(lng = -99, lat = 45, zoom = 3)  %>% #setting the view over ~ center of North America
                addTiles() %>% 
                addCircles(data = conservation_park_info, lat = ~ Latitude, lng = ~ Longitude, 
                           weight = 1, 
                           radius = ~`No Concern`*50, 
                           popup = ~as.character(paste(Park.Name, "<br>",
                                                       "# of Species of No Concern: ", 
                                                       `No Concern`)), 
                           color = "#572BB7", 
                           fillOpacity = 0.5)
        }
    })
    
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
            ggplot(counts_area_sl, aes(x=LatCat2, y = Vascular.Plant)) + 
                geom_bar(stat = "identity", fill = "#03783D") +
                xlab("Latitude") + ylab("Number of Vascular Plant Species")
        } 
        else if (input$display_var == "Nonvascular Plants") {
            ggplot(counts_area_sl, aes(x=LatCat2, y = Nonvascular.Plant)) + 
                geom_bar(stat = "identity", fill = "#6A934A") +
                xlab("Latitude") + ylab("Number of Nonvascular Plant Species")
        } 
        
    })
}


#Run the application
print(sprintf("Starting shiny on port %d", port))

shinyApp(ui = ui, server = server, options = list(port=port, host = "0.0.0.0"))
