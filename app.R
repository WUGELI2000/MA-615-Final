library(shiny)
library(shinydashboard)
library(leaflet)
library(sf)
library(rnaturalearth)
library(ggplot2)

world <- ne_countries(scale = "medium", returnclass = "sf")
jamaica <- world[world$admin == "Jamaica", ]

ui <- dashboardPage(
  dashboardHeader(title = "Jamaica Island"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("General description", tabName = "general", icon = icon("info-circle"))
    ),
    sidebarMenu(
      menuItem("Key demographics Form", tabName = "demo", icon = icon("users"))
    ),
    sidebarMenu(
      menuItem("Comparison", tabName = "comp", icon = icon("exchange-alt"))
    ),
    sidebarMenu(
      menuItem("SWOT analysis", tabName = "SWOT", icon = icon("tasks"))
    ),
    sidebarMenu(
      menuItem("Refences", tabName = "Ref", icon = icon("tasks"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # General tab content
      tabItem(tabName = "general",
              fluidRow(
                box(title = "Map of Jamaica", status = "primary", solidHeader = TRUE,
                    leafletOutput("map_jamaica", height = "500px")),
                box(title = "Jamaica in the World", status = "primary", solidHeader = TRUE,
                    leafletOutput("map_world", height = "500px")),
                tags$p(HTML("<strong>General Description:</strong> Jamaica is an island country situated in the Caribbean Sea. 
                  It is the third-largest island of the Greater Antilles and the Caribbean, 
                  with an area of 10,990 square kilometers. It is located approximately 145 km 
                  south of Cuba and 191 km west of Hispaniola. Jamaica's official language is English, 
                  complemented by a widely spoken Jamaican Patois. Jamaica's government operates as 
                  a parliamentary democracy under a constitutional monarchy and is a Commonwealth realm. 
                  Kingston is the capital and the largest city. Notably, Jamaica is known for its vibrant 
                  culture, particularly its music genres like reggae, and for being the birthplace of the 
                  Rastafari religion. The island is also recognized for its athletic prowess, 
                  particularly in sprinting and cricket.")),
                tags$p(HTML("<strong>Key facts of Jamaica:</strong>")),
                p("Population: Jamaica has a population of approximately 2.8 million people."),
                p("Economic Dependency: The economy heavily depends on tourism and services, 
                  which account for more than 70% of GDP."),
                p("Language: English is the official language, with Jamaican Patois being widely spoken."),
                p("Political Structure: It is a parliamentary democracy with a constitutional monarchy."),
                p("Currency: The Jamaican dollar (JMD) is the official currency."),
                p("Healthcare: Current health expenditure is 6.6% of GDP, 
                  with a physicians density of 0.53 physicians/1,000 population."),
                p("Education: The literacy rate is around 88.7%, with a 6% GDP expenditure on education."),
                p("Environment: Jamaica faces environmental issues like deforestation, 
                  coastal water pollution, and air pollution in Kingston.")
              )
      ),
      tabItem(tabName = "demo",
              fluidRow(
                box(title = "Enter Demographics Data", status = "primary", solidHeader = TRUE, collapsible = TRUE,
                    textInput("country_name", "Country Name", value = "Jamaica"),
                    numericInput("population", "Population", value = 2820982),
                    numericInput("median_age", "Median Age", value = 30.5),
                    numericInput("age_014", "0-14 years(%)", value = 24.11),
                    numericInput("age_1564", "15-64 years(%)", value = 65.81),
                    numericInput("age_over65", "65 years and over(%)", value = 10.08),
                    numericInput("growth_rate", "Growth Rate(%)", value = 0.09),
                    selectInput("gender_ratio", "Gender Ratio",
                                choices = c("More females than males" = "Female > Male",
                                            "More males than females" = "Male > Female",
                                            "About equal" = "Equal")),
                    dateInput("date_collected", "Date of Data Collection", value = Sys.Date()),
                    actionButton("submit_btn", "Submit"),
                    width = 12
                )
              ),
              fluidRow(
                box(width = 12, status = "primary",
                    textOutput("confirmation_text")
                )
              )
      ),
      tabItem(tabName = "comp",
              tags$div(
                style = "background-image: 
                url('https://upload.wikimedia.org/wikipedia/commons/9/98/Caribbean_general_map.png');
                height: 730px; background-size: cover;"
              ),
              p("The Caribbean islands, each with their distinct characteristics, 
                offer a diverse landscape of demographics and economics. Jamaica, 
                nestled among the Greater Antilles, is known not just for its vibrant culture 
                but also its significant size and population. This series of comparisons highlights 
                the varying population densities, GDP per capita, and land areas, offering a window 
                into the unique socioeconomic fabrics of each island. From the dense population of 
                Puerto Rico to the sprawling landmass of Cuba and Jamaica's notable GDP and population, 
                these metrics serve as a starting point for understanding the complex interplay between 
                geography, economy, and society in the Caribbean."),
              p("
                "),
              fluidPage(
                plotOutput("areaPlot"),
                p("From the bar chart provided, we can observe that Cuba is the largest 
                  island in the Caribbean by total area, followed by Hispaniola 
                  (which comprises the Dominican Republic and Haiti), then Jamaica, 
                  Puerto Rico, and Trinidad. Cuba's area is significantly larger than the others, 
                  with Jamaica being the third largest. The chart clearly illustrates the differences 
                  in size among these islands, with the total area decreasing from left to right. 
                  Jamaica's total area is just under 11,000 square kilometers, 
                  which is less than a tenth of Cuba's size and smaller than Hispaniola but larger 
                  than Puerto Rico and Trinidad."),
                plotOutput("populationPlot"),
                p("The bar chart shows the population comparison of Caribbean islands. 
                  Hispaniola, which includes the Dominican Republic and Haiti, 
                  has the highest population, followed by Cuba. Puerto Rico and Jamaica have 
                  significantly lower populations, with Jamaica's population just over 2.8 million. 
                  Trinidad has the smallest population among the countries displayed. 
                  The chart demonstrates the substantial differences in population size 
                  between these islands."),
                plotOutput("popudenPlot"),
                p("The bar chart compares the population density of Caribbean islands, 
                  showing Puerto Rico with the highest density at 350.8 people per square kilometer, 
                  followed by Hispaniola and then Jamaica and Trinidad with equal densities. 
                  Cuba has the lowest population density among the islands shown, 
                  with 101.8 people per square kilometer. This indicates that while Cuba may be 
                  the largest island in terms of area, its population is more spread out compared 
                  to the smaller islands with higher densities."),
                plotOutput("GDPPlot"),
                p("The bar chart provides a comparison of GDP per capita among Caribbean islands. 
                  Puerto Rico leads with the highest GDP per capita, followed by the Dominican Republic, 
                  Cuba, Trinidad and Tobago, and Jamaica. Haiti has the lowest GDP per capita by a 
                  significant margin compared to the other countries listed. 
                  This data suggests economic disparities within the region, with Puerto Rico's GDP 
                  per capita being several times higher than that of Haiti.")
              )
      ),
      tabItem(tabName = "SWOT",
              tags$p(HTML("<strong>SWOT analysis of Jamaica:</strong>")),
              tags$p(HTML("<strong>S</strong>trengths:<br>
                           1. Diverse culture and strong global brand in music and athletics.<br>
                           2. Natural beauty and climate make it a popular tourist destination.<br>
                           3. English-speaking population with a strategic location near major 
                           sea lanes<br><br>
                           <strong>W</strong>eaknesses:<br>
                           1. Economic dependence on tourism and remittances makes it vulnerable 
                           to global economic shifts.<br>
                           2. High public debt constrains government spending and investment.<br>
                           3. Challenges with crime rates and corruption perceptions.<br><br>
                           <strong>O</strong>pportunities:<br>
                           1. Expansion in services such as digital and creative industries.<br>
                           2. Development of sustainable tourism and ecological preservation projects.<br>
                           3. Leveraging cultural influence to promote Jamaican products.<br><br>
                           <strong>T</strong>hreats:<br>
                           1. Susceptibility to hurricanes and other natural disasters.<br>
                           2. Global economic downturns reducing tourist numbers.<br>
                           3. Competition from other tourist destinations.<br>"))
              ),
      tabItem(tabName = "Ref",
              tags$p(HTML("<strong>References:</strong>")),
              p("https://en.wikipedia.org/wiki/Jamaica"),
              p("https://www.cia.gov/the-world-factbook/countries/jamaica/#geography"),
              )
    )
  )
)

server <- function(input, output) {
  
  Sys.setlocale("LC_TIME", "en_US.UTF-8")
 
   # Map of Jamaica
  output$map_jamaica <- renderLeaflet({
    leaflet(data = jamaica) %>%
      addProviderTiles(providers$Esri.WorldImagery) %>%
      setView(lng = -77.2975, lat = 18.1096, zoom = 8)
  })
  
  # World Map with Jamaica highlighted
  output$map_world <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addPolygons(data = world, fillColor = "white", weight = 0.5, color = "white", fillOpacity = 0.5) %>%
      addPolygons(data = jamaica, fillColor = "yellow", weight = 1, color = "yellow", fillOpacity = 0.8) %>%
      setView(lng = -77.2975, lat = 18.1096, zoom = 4.5)
  })
  
  output$confirmation_text <- renderText({
    paste0("Data for ", input$country_name, 
           " has been submitted with a population of ", input$population, 
           ", median age of ", input$median_age, 
           ", percent of age 0-14 years is ", input$age_014, "%",
           ", percent of age 15-64 years is ", input$age_1564, "%",
           ", percent of age 65 years and over is ", input$age_over65, "%",
           ", growth rate of ", input$growth_rate, "%",
           ", gender ratio of ", input$gender_ratio,
           ", and data collected on ", format(input$date_collected, "%B %d, %Y"), ".")
  })
  
  output$areaPlot <- renderPlot({
    country_areas <- data.frame(
      country = c("Cuba", "Hispaniola", "Jamaica", "Puerto Rico", "Trinidad"),
      area = c(110860,  76192,  10991, 9104, 4768)
    )
    
    country_areas <- country_areas[order(-country_areas$area),]
    
    ggplot(country_areas, aes(x = reorder(country, -area), y = area, fill = country)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = area), vjust = -0.3, color = "black") +
      theme_classic() +
      labs(title = "Comparison of Caribbean islands Areas", x = "Country", y = "Area (sq km)")
  })
  
  output$populationPlot <- renderPlot({
    country_popu <- data.frame(
      country = c("Cuba", "Hispaniola", "Jamaica", "Puerto Rico", "Trinidad"),
      population = c(10985974, 22278000, 2820982, 3221789, 1267145)
    )
    
    country_popu <- country_popu[order(-country_popu$population),]
    
    ggplot(country_popu, aes(x = reorder(country, -population), y = population, fill = country)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = population), vjust = -0.3, color = "black") +
      theme_classic() +
      labs(title = "Comparison of Caribbean islands population", x = "Country", y = "Population")
  })
  
  output$popudenPlot <- renderPlot({
    country_popuden <- data.frame(
      country = c("Cuba", "Hispaniola", "Jamaica", "Puerto Rico", "Trinidad"),
      popuden = c(101.8, 280.8, 266, 350.8, 266)
    )
    
    country_popuden <- country_popuden[order(-country_popuden$popuden),]
    
    ggplot(country_popuden, aes(x = reorder(country, -popuden), y = popuden, fill = country)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = popuden), vjust = -0.3, color = "black") +
      theme_classic() +
      labs(title = "Comparison of Caribbean islands population density", 
           x = "Country", y = "Population density(/sq km)")
  })
  
  output$GDPPlot <- renderPlot({
    country_GDP <- data.frame(
      country = c("Cuba", "Dominican Republic", "Haiti", "Jamaica", "Puerto Rico", "Trinidad and Tobago"),
      GDP = c(22237, 25523, 3185, 12994, 41682, 19621)
    )
    
    country_GDP <- country_GDP[order(-country_GDP$GDP),]
    
    ggplot(country_GDP, aes(x = reorder(country, -GDP), y = GDP, fill = country)) +
      geom_bar(stat = "identity") +
      geom_text(aes(label = GDP), vjust = -0.3, color = "black") +
      theme_classic() +
      labs(title = "Comparison of Caribbean islands GDP(per capita)", 
           x = "Country", y = "GDP($)")
  })
}

shinyApp(ui, server)
