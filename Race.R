getwd()
setwd()

install.packages("ggplot2")
library(ggplot2)

# data
Race <- data.frame(
  Racial_Group = c("Black", "Hispanic", "White", "Native Hawaiian or other Pacific Islander", "Native American or Native Alaskan","Middle Eastern or North African","Asian"),
  Count = c(262,462,964,2,3,1,33)
)

# bar chart
ggplot(Race, aes(x = Racial_Group, y = Count, fill = Racial_Group)) +
  geom_bar(stat = "identity") +
  labs(x = "Racial Group", y = "Number of Guests", title = "Total Racial Demographics (2015-2023)") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 20, hjust = 1)) + 
  guides(fill = FALSE) +
  xlab("") +
  theme(plot.title = element_text(size = 25))

# pie chart
Race$Percentage <- (Race$Count / sum(Race$Count)) * 100

legend_data <- data.frame(
  Racial_Group = Race$Racial_Group,
  Percentage = scales::percent(Race$Percentage)
)

ggplot(Race, aes(x = "", y = Count, fill = Racial_Group)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Racial Demographics (2015-2023)") +
  theme_void() +
  theme(legend.position = "right") +
  geom_text(aes(label = scales::percent(Count/sum(Count), accuracy = 1),x = 1.4), 
            position = position_stack(vjust = 0.55), size = 4) +
  labs(fill = "Racial Group") +
  theme(plot.title = element_text(size = 25))

# trendline graph w estimated 2023
Race_Change <- data.frame(
  Year = rep(c(2020, 2021, 2022, 2023), each = 7),
  Racial_Group = rep(c("Black", "Hispanic", "White", "Native Hawaiian or Pacific Islander", "Native American or Alaskan", "Middle Eastern or North African", "Asian"), times = 4),
  Percentage = c(
    21, 22, 57, 0, 0, 0, 0, 18, 39, 42, 0, 0, 0, 0, 14, 31, 52, 1, 2, 0, 2, 14, 22, 60, 0, 1, 0, 2
  )
)

ggplot(Race_Change, aes(x = Year, y = Percentage, color = Racial_Group)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(title = "Racial Demographic Changes Over Time", x = "Year", y = "Percentage of Patient Population") +
  theme(legend.title = element_blank()) +
  theme(plot.title = element_text(size = 25))


# trendline graph 2020-2022
Race_Change <- data.frame(
  Year = rep(c(2020, 2021, 2022), each = 7),
  Racial_Group = rep(c("Black", "Hispanic", "White", "Native Hawaiian or Pacific Islander", "Native American or Alaskan", "Middle Eastern or North African", "Asian"), times = 3),
  Percentage = c(
    21, 22, 57, 0, 0, 0, 0, 18, 39, 42, 0, 0, 0, 0, 14, 31, 52, 1, 2, 0, 2
  )
)

ggplot(Race_Change, aes(x = Year, y = Percentage, color = Racial_Group)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(title = "Racial Demographic Changes Over Time", x = "Year", y = "Percentage of Patient Population") +
  scale_x_continuous(breaks = c(2020, 2021, 2022),
                     labels = c("2020", "2021", "2022")) +
  theme(legend.title = element_blank()) +
  theme(plot.title = element_text(size = 25))
