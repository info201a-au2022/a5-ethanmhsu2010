# server.R
library(dplyr)
library(ggplot2)
library(plotly)

# Data
co2_data <- read.csv("https://raw.githubusercontent.com/info201a-au2022/a5-ethanmhsu2010/main/owid-co2-data.csv")

# Country with the highest CO2 emissions per capita in 2021
highest_co2_capita_country <- co2_data %>%
  filter(year == 2021) %>% 
  select(co2_per_capita, country) %>% 
  filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% 
  pull(country)

# Highest CO2 emissions per capita in 2021
highest_co2_per_capita_value <- co2_data %>%
  filter(year == 2021) %>% 
  select(co2_per_capita, country) %>% 
  filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% 
  pull(co2_per_capita)


# Country with the highest CO2 growth percentage in 2021
highest_co2_growth_country <- co2_data %>% 
  filter(year == 2021) %>% 
  select(co2_growth_prct, country) %>% 
  filter(co2_growth_prct == max(co2_growth_prct, na.rm = TRUE)) %>% 
  pull(country)

# Highest CO2 growth percentage in 2021
highest_co2_growth_percentage <- co2_data %>% 
  filter(year == 2021) %>% 
  select(co2_growth_prct, country) %>% 
  filter(co2_growth_prct == max(co2_growth_prct, na.rm = TRUE)) %>% 
  pull(co2_growth_prct)


# U.S. CO2 emissions in 2011
us_2011_c02 <- co2_data %>% 
  filter(year == 2011) %>% 
  select(country, co2) %>% 
  filter(country == "United States") %>% 
  pull(co2)

# U.S. CO2 emissions in 2021
us_2021_c02 <- co2_data %>% 
  filter(year == 2021) %>% 
  select(country, co2) %>% 
  filter(country == "United States") %>% 
  pull(co2)

# Change in U.S. CO2 emissions from 2011 to 2021
us_co2_change <- us_2021_c02 - us_2011_c02


# 2021 Data
data_2021 <- co2_data %>% 
  filter(year == 2021)

# Build Function
build_chart <- function(xaxis, source) {
  
  # filter by country
  data_2021 <- data_2021 %>% 
    filter(country %in% xaxis)
  
  test <- ggplot(data_2021, aes_string(x = "country", y = source)) +
    geom_col(fill = "light blue") +
    ggtitle("CO2 Emissions Per Capita By Country") +
    labs(x = "Country",
         y = "Tonnes of CO2 Emitted")
  
  return(ggplotly(test))
}


testfunction <- data_2021 %>% 
  filter(country %in% c("United States","China"))

tester <- ggplot(testfunction, aes(x = country, y = cement_co2_per_capita)) +
  geom_col(fill = "light blue")

ggplotly(tester)

# Test Function
#build_chart("oil_co2_per_capita", "United States")

# Server
server <- function(input, output) {
  
  output$chart <- renderPlotly({
    
    return(build_chart(input$xaxis, input$source))
      
  })
  
}
