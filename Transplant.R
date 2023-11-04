getwd()
setwd()

install.packages("ggplot2")
library(ggplot2)

# data
Transplant <- data.frame(
  Transplant_Group = c("Heart Pre-Op","Heart Post-Op",
"Kidney Pre-Op",
"Kidney Post-Op",
"Kidney/Pancreas Pre-Op",
"Kidney/Pancreas Post-Op",
"Liver Pre-Op",
"Liver Post-Op",
"Living Donor-Testing-PostOp",
"Lung Pre-Op",
"Lung Post-Op",
"LVAD Bridge to Heart",
"Pancreas Pre-Op",
"Pancreas Post-Op"),
  Count = c(196,
            136,
            230,
            167,
            19,
            17,
            124,
            158,
            31,
            314,
            183,
            119,
            8,
            69)
)

# bar chart
ggplot(Transplant, aes(x = Transplant_Group, y = Count, fill = Transplant_Group)) +
  geom_bar(stat = "identity") +
  labs(x = "Transplant", y = "Number of Guests", title = "Total Transplant Type Demographics (2015-2023)") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 30, hjust = 1)) + 
  guides(fill = FALSE) +
  xlab("") +
  theme(plot.title = element_text(size = 25)) +
  theme(plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"))

# pie chart
Transplant$Percentage <- (Transplant$Count / sum(Transplant$Count)) * 100

legend_data <- data.frame(
  Transplant_Group = Transplant$Transplant_Group,
  Percentage = scales::percent(Transplant$Percentage)
)

ggplot(Transplant, aes(x = "", y = Count, fill = Transplant_Group)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Transplant Type Demographics (2015-2023)") +
  theme_void() +
  theme(legend.position = "right") +
  geom_text(aes(label = scales::percent(Count/sum(Count), accuracy = 0.1),x = 1.25), 
            position = position_stack(vjust = 0.5), size = 4) +
  labs(fill = "Transplant Type") +
  theme(plot.title = element_text(margin = margin(b = -30))) +
  theme(plot.title = element_text(size = 25))


