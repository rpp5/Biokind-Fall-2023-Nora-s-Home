getwd()
setwd()

install.packages("ggplot2")
library(ggplot2)

# data
Age <- data.frame(
  Age_Group = c("0-17 Years", "18-24 Years", "25-60 Years", "61 Years and Over"),
  Count = c(101, 45, 846, 725)
)

# bar chart
ggplot(Age, aes(x = Age_Group, y = Count, fill = Age_Group)) +
  geom_bar(stat = "identity") +
  labs(x = "Age", y = "Number of Guests", title = "Total Age Demographics (2015-2023)") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 20, hjust = 1)) + 
  guides(fill = FALSE) +
  xlab("") +
  theme(plot.title = element_text(size = 25))


# pie chart
Age$Percentage <- (Age$Count / sum(Age$Count)) * 100

legend_data <- data.frame(
  Age_Group = Age$Age_Group,
  Percentage = scales::percent(Age$Percentage)
)

ggplot(Age, aes(x = "", y = Count, fill = Age_Group)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Age Demographics (2015-2023)") +
  theme_void() +
  theme(legend.position = "right") +
  geom_text(aes(label = scales::percent(Count/sum(Count), accuracy = 0.1),x = 1.25), 
            position = position_stack(vjust = 0.5), size = 4) +
  labs(fill = "Age") +
  theme(plot.title = element_text(margin = margin(b = -30))) +
  theme(plot.title = element_text(size = 25))


# trendline graph w estimated 2023
Age_Change <- data.frame(
  Year = rep(c(2020, 2021, 2022, 2023), each = 4),
  Age_Group = rep(c("0-17 Years", "18-24 Years", "25-60 Years", "61 Years and Over"), times = 4),
  # calculated percentages in Excel
  Percentage = c(
    7, 2, 52, 39, 6, 1, 56, 37, 7, 2, 48, 43, 7, 2, 47, 44
  )
)

ggplot(Age_Change, aes(x = Year, y = Percentage, color = Age_Group)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(title = "Age Demographic Changes Over Time", x = "Year", y = "Percentage of Patient Population") +
  theme(legend.title = element_blank()) +
  theme(plot.title = element_text(size = 25))


# trendline graph 2020-2022
Age_Change <- data.frame(
  Year = rep(c(2020, 2021, 2022), each = 4),
  Age_Group = rep(c("0-17 Years", "18-24 Years", "25-60 Years", "61 Years and Over"), times = 3),
  # calculated percentages in Excel
  Percentage = c(
    7, 2, 52, 39, 6, 1, 56, 37, 7, 2, 48, 43
  )
)

ggplot(Age_Change, aes(x = Year, y = Percentage, color = Age_Group)) +
  geom_line(linewidth = 1) +
  geom_point(size = 1.5) +
  labs(title = "Age Demographic Changes Over Time", x = "Year", y = "Percentage of Patient Population") +
  scale_x_continuous(breaks = c(2020, 2021, 2022),
                     labels = c("2020", "2021", "2022")) +
  theme(legend.title = element_blank()) +
  theme(plot.title = element_text(size = 25))
