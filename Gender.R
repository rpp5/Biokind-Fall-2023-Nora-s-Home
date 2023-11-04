getwd()
setwd()

install.packages("ggplot2")
library(ggplot2)

# data
Gender <- data.frame(
  Gender_Group = c("Female", "Male"),
  Count = c(684, 1043)
)

# bar chart
ggplot(Gender, aes(x = Gender_Group, y = Count, fill = Gender_Group)) +
  geom_bar(stat = "identity") +
  labs(x = "Gender", y = "Number of Guests", title = "Total Gender Demographics (2015-2023)") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 20, hjust = 1)) + 
  guides(fill = FALSE) +
  xlab("") +
  theme(plot.title = element_text(size = 25))

# pie chart
Gender$Percentage <- (Gender$Count / sum(Gender$Count)) * 100

legend_data <- data.frame(
  Gender_Group = Gender$Gender_Group,
  Percentage = scales::percent(Gender$Percentage)
)

ggplot(Gender, aes(x = "", y = Count, fill = Gender_Group)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Gender Demographics (2015-2023)") +
  theme_void() +
  theme(legend.position = "right") +
  geom_text(aes(label = scales::percent(Count/sum(Count), accuracy = 0.1),x = 1.25), 
            position = position_stack(vjust = 0.5), size = 4) +
  labs(fill = "Gender") +
  theme(plot.title = element_text(margin = margin(b = -30))) +
  theme(plot.title = element_text(size = 25))


# trendline graph w estimated 2023
Gender_Change <- data.frame(
  Year = rep(c(2020, 2021, 2022, 2023), each = 2),
  Gender_Group = rep(c("Female","Male"), times = 4),
  # calculated percentages in Excel
  Percentage = c(
    38, 62, 46, 54, 43, 57, 44, 56
  )
)

ggplot(Gender_Change, aes(x = Year, y = Percentage, color = Gender_Group)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(title = "Gender Demographic Changes Over Time", x = "Year", y = "Percentage of Patient Population") +
  theme(legend.title = element_blank()) +
  theme(plot.title = element_text(size = 25))


# trendline graph 2020-2022
Gender_Change <- data.frame(
  Year = rep(c(2020, 2021, 2022), each = 2),
  Gender_Group = rep(c("Female","Male"), times = 3),
  # calculated percentages in Excel
  Percentage = c(
    38, 62, 46, 54, 43, 57
  )
)

ggplot(Gender_Change, aes(x = Year, y = Percentage, color = Gender_Group)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(title = "Gender Demographic Changes Over Time", x = "Year", y = "Percentage of Patient Population") +
  scale_x_continuous(breaks = c(2020, 2021, 2022),
                     labels = c("2020", "2021", "2022")) +
  theme(legend.title = element_blank()) +
  theme(plot.title = element_text(size = 25))

