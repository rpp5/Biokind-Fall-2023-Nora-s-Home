setwd("/Users/rahulprakash/Desktop/Biokind")

# Load the readxl package
install.packages("readxl")
library(readxl)
install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
library(tidyverse)

# Specify the path to your Excel file
excel_file <- "Cleaned data.xlsx"

# Get the list of sheet names from the Excel file
sheet_names <- excel_sheets(excel_file)

# Create an empty list to store the data frames
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

ggplot(Hospital_update, aes(x = factor(Year), y = Value, color = Hospital)) +
  geom_point(position = position_dodge(width = 0.2), size = 3) +
  geom_line(aes(group = Hospital), position = position_dodge(width = 0.2), size = 1) +
  xlab("Year") +
  ylab("Value") +
  ggtitle("Hospitals Data since 2013") +
  theme_minimal() +
  theme(plot.margin = margin(b = 60)) +
  facet_wrap(~Category, scales = "free_y", ncol = 1)

#------Monthly Data---------------#

Monthly_data$...1 
names(Monthly_data)[names(Monthly_data) == "Data"] <- "Distance"
Monthly_data <- subset(Monthly_data, select = -c(`Jan, 2018`, `Feb, 2018`, `Mar, 2018`))
dist_data <- Monthly_data[!(Monthly_data$Distance %in% c("Total Occ %", "New Guests", "Sun-Thur Occ%", "* ADR", "TT Rm Rev")), , drop = FALSE]
dist_data[is.na(dist_data)] <- 0

dist_data <- dist_data %>%
  gather(key = "Month_Year", value = "Number_of_People", -Distance) %>%
  separate(Month_Year, into = c("Month", "Year"), sep = ",")

#By Season
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

ggplot(season_data, aes(x = as.factor(season), y = Number_of_People, fill = Distance)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_grid(. ~ Year) +
  xlab("Year") +
  ylab("Number of People") +
  ggtitle("Number of People by Season and Year") +
  scale_fill_brewer(palette = "Set3") +
  theme_minimal()+
  theme(plot.margin = margin(b = 20))+
  theme(axis.text.x = element_text(size = 6))

#By Month

#By Year
  




