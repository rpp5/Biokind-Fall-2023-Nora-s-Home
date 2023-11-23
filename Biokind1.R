
setwd("/Users/rahulprakash/Desktop/Biokind")

# Load packages
install.packages("readxl")
library(readxl)
install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
library(tidyverse)
library(plotly)

#Load and clean data
excel_file <- "Cleaned data.xlsx"
sheet_names <- excel_sheets(excel_file)
data_list <- list()
Monthly_data <- read_excel(excel_file, sheet = sheet_names[1])
Patient_data <- read_excel(excel_file, sheet = sheet_names[2])
Residence_data <- read_excel(excel_file, sheet = sheet_names[3])
Hospital_data <- read_excel(excel_file, sheet = sheet_names[4])
colnames(Hospital_data) <- sub("\\.0", "", colnames(Hospital_data))
Hospital_update <- Hospital_data %>%
  gather(key = "Year", value = "Value", -Hospital, -Category) %>%
  mutate(Year = as.factor(Year)) %>%
  filter(!is.na(Value))

#-----------Plot 1 - Hospitals Data------------#
ggplot(Hospital_update, aes(x = factor(Year), y = Value, color = Hospital)) +
  geom_point(position = position_dodge(width = 0.2), size = 3) +
  geom_line(aes(group = Hospital), position = position_dodge(width = 0.2), size = 1) +
  xlab("Year") +
  ylab("Value") +
  ggtitle("Hospitals Data since 2013") +
  theme_minimal() +
  theme(plot.margin = margin(b = 60)) +
  facet_wrap(~Category, scales = "free_y", ncol = 1)

#Create UI
ui <- fluidPage(
  titlePanel("Interactive Hospitals Data"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("variable", "Choose Variable:",
                   choices = c("Adopt a Family Friend", "Total Night Stays", "Total Families Served"),
                   selected = "Adopt a Family Friend")
    ),
    
    mainPanel(
      plotOutput("my_plot")
    )
  )
)

# Define server
server <- function(input, output) {
  
  reactive_data <- reactive({
    Hospital_update <- Hospital_data %>%
      gather(key = "Year", value = "Value", -Hospital, -Category) %>%
      mutate(Year = as.factor(Year)) %>%
      filter(!is.na(Value))
    
    return(Hospital_update)
  })
  
  output$my_plot <- renderPlot({
    selected_variable <- input$variable
    filtered_data <- reactive_data() %>%
      filter(Category == selected_variable)
    ggplot(filtered_data, aes(x = factor(Year), y = Value, color = Hospital)) +
      geom_point(position = position_dodge(width = 0.2), size = 3) +
      geom_line(aes(group = Hospital), position = position_dodge(width = 0.2), size = 1) +
      xlab("Year") +
      ylab("Value") +
      ggtitle(paste("Hospitals Data for", selected_variable, "since 2013")) +
      theme_minimal() +
      theme(plot.margin = margin(b = 60)) +
      facet_wrap(~Category, scales = "free_y", ncol = 1)
  })
}

shinyApp(ui = ui, server = server)

#------End of Plot 1---------------#

#Plot 2

#Clean data
Monthly_data$...1 
names(Monthly_data)[names(Monthly_data) == "...1"] <- "Distance"
Monthly_data <- subset(Monthly_data, select = -c(`Jan, 2018`, `Feb, 2018`, `Mar, 2018`))
dist_data <- Monthly_data[!(Monthly_data$Distance %in% c("Total Occ %", "New Guests", "Sun-Thur Occ%", "* ADR", "TT Rm Rev")), , drop = FALSE]
dist_data[is.na(dist_data)] <- 0
dist_data <- dist_data %>%
  gather(key = "Month_Year", value = "Number_of_People", -Distance) %>%
  separate(Month_Year, into = c("Month", "Year"), sep = ",")
get_season <- function(month) {
  case_when(
    month %in% c("Dec", "Jan", "Feb") ~ "Winter",
    month %in% c("Mar", "Apr", "May") ~ "Spring",
    month %in% c("Jun", "Jul", "Aug") ~ "Summer",
    TRUE ~ "Fall"
  )
}
season_data <- dist_data %>%
  mutate(season = get_season(Month))
season_data$Year <- as.numeric(season_data$Year)

#2018
season_2018 <- season_data %>% filter(Year == 2018)
plot_2018 <- ggplot(season_2018, aes(x = as.factor(season), y = Number_of_People, fill = Distance)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Year") +
  ylab("Number of People") +
  ggtitle("Number of People by Season and Year") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal()+
  theme(plot.margin = margin(b = 20))+
  theme(axis.text.x = element_text(size = 6))+
  ylim(0, 50)


#2019
season_2019 <- season_data %>% filter(Year == 2019)
plot_2019 <- ggplot(season_2019, aes(x = as.factor(season), y = Number_of_People, fill = Distance)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Year") +
  ylab("Number of People") +
  ggtitle("Number of People by Season and Year") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal()+
  theme(plot.margin = margin(b = 20))+
  theme(axis.text.x = element_text(size = 6))+
  ylim(0, 50)

#2020
season_2020 <- season_data %>% filter(Year == 2020)
plot_2020 <- ggplot(season_2020, aes(x = as.factor(season), y = Number_of_People, fill = Distance)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Year") +
  ylab("Number of People") +
  ggtitle("Number of People by Season and Year") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal()+
  theme(plot.margin = margin(b = 20))+
  theme(axis.text.x = element_text(size = 6))+
  ylim(0, 50)


#2021
season_2021 <- season_data %>% filter(Year == 2021)
plot_2021 <- ggplot(season_2019, aes(x = as.factor(season), y = Number_of_People, fill = Distance)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Year") +
  ylab("Number of People") +
  ggtitle("Number of People by Season and Year") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal()+
  theme(plot.margin = margin(b = 20))+
  theme(axis.text.x = element_text(size = 6))+
  ylim(0, 50)

#2022
season_2022 <- season_data %>% filter(Year == 2022)
plot_2022 <- ggplot(season_2022, aes(x = as.factor(season), y = Number_of_People, fill = Distance)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Year") +
  ylab("Number of People") +
  ggtitle("Number of People by Season and Year") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal()+
  theme(plot.margin = margin(b = 20))+
  theme(axis.text.x = element_text(size = 6))+
  ylim(0, 50)

#2023
season_2023 <- season_data %>% filter(Year == 2023)
plot_2023 <- ggplot(season_2023, aes(x = as.factor(season), y = Number_of_People, fill = Distance)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Year") +
  ylab("Number of People") +
  ggtitle("Number of People by Season and Year") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal()+
  theme(plot.margin = margin(b = 20))+
  theme(axis.text.x = element_text(size = 6))+
  ylim(0, 50)

#create interactive plot
ui <- fluidPage(
  titlePanel("Interactive Plot with Year Slider"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("year_slider", "Select Year:", 
                  min = 2018, max = 2023,
                  value = 2018, step = 1)
    ),
    
    mainPanel(
      plotOutput("my_plot")
    )
  )
)

# Define server
server <- function(input, output) {
  
  output$my_plot <- renderPlot({
    # Conditionally render different plots based on the selected year
    if (input$year_slider == 2018) {
      plot_2018
    } 
    else if (input$year_slider == 2019) {
      plot_2019
    } 
    else if (input$year_slider == 2020) {
      plot_2020
    } 
    else if (input$year_slider == 2021) {
      plot_2021
    } 
    else if (input$year_slider == 2022) {
      plot_2022
    } 
    else if (input$year_slider == 2023) {
      plot_2023
    }
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)