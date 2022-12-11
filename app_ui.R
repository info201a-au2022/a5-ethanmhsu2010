# ui.R
library(shiny)
library(shinythemes)

# Writing for introduction tab
intro_writing <- p(style = "font-size:20px", paste0("
                                      Global warming is perhaps the greatest threat to humanity as we know it. As countries
                                      around the world develop rapdily, CO2 emissions continue to rise. This increase in CO2
                                      levels, along with the release of other greenhouse gases into the atmosphere, contribute 
                                      to rising global temperatures. Ultimately, these increasing temperatures cause sea levels
                                      to rise and create natural disasters that are both more frequent and intense."))

# Writing to introduce application for introduction tab
intro_side_panel <- sidebarPanel(p(style = "font-size:20px", strong("Application Function")),p(style = "font-size:20px", 
                                      paste0("In this application, we will explore how CO2 is emitted in various ways across the planet.
                                      For example, the application will have the ability to display data on how given country(s)
                                      emit CO2 from cement production. Other variables include coal production, gas production, and oil production. 
                                      To ensure these variables are scaled to population, each
                                      of them will be measured in tonnes per person.")))

# Automatically generated values for introduction tab
intro_main_panel <- mainPanel(p(style = "font-size:20px", strong("Key Statistics:")),p(style = "font-size:20px", 
                              paste0("Highest 2021 CO2 Emissions Per Capita: ", highest_co2_capita_country, ": ",
                              highest_co2_per_capita_value, " Tonnes")), paste0("Qatar's high CO2 rates are mainly 
                                                                                attributed to the nation's high reliance on gas and oil in production."),
                              
                              p(""),
                              
                              p(style = "font-size:20px", paste0("Highest 2021 CO2 Emissions Growth Percentage: ", highest_co2_growth_country, ": ",
                                                                 highest_co2_growth_percentage, "% Increase")),
                              paste0("Libya's increase in CO2 emissions is due to rapidly developing infastrucutre and emphasis on oil production."),

                              p(""),
                              
                              p(style = "font-size:20px", paste0("Change in U.S. CO2 Emissions From 2011-2021: ", us_co2_change, " Million Tonnes")),
                                                                
                              paste0("The United States' decrease in CO2 emissions the last 10 years can be mainly attributed to the replacement of coal power.")
                              )

# Tab panel for introduction
intro_page <- tabPanel(
  "Introduction",
  titlePanel(strong("An Ever Changing Climate Problem")),
             intro_writing,
              
             sidebarLayout(
             intro_side_panel,
             intro_main_panel
             )
)

# Side panel for interactive page
interactive_side_panel <- sidebarPanel(
  # Y Axis
  selectInput(
    "source",
    label = h3("Production Source"),
    choices = list("Cement" = "cement_co2_per_capita",
                   "Coal" = "coal_co2_per_capita",
                   "Gas" = "gas_co2_per_capita",
                   "Oil" = "oil_co2_per_capita"),
    selected = "cement_co2_per_capita"
  ),
  
  # Text Input for Countries
  selectizeInput(
    "country",
    label = h3("Select Country(s)"),
    choices = data_2021$country,
    selected = "United States",
    multiple = TRUE
  )
)
  
# Main panel for interactive page
interactive_main_panel <- p("Graph Coming")

# Tab panel for interactive page
interactive_page <- tabPanel(
  "CO2 Production",
  titlePanel(strong("CO2 Emission Analysis")),
  
  sidebarLayout(
    interactive_side_panel,
    interactive_main_panel
  )
)



# Navigation Bar
ui <- navbarPage(
  "CO2 Emissions",
  intro_page,
  interactive_page,
  theme = shinytheme("superhero")
)