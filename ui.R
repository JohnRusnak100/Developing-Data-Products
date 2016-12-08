

library(shiny)
library(plotly)
shinyUI(fluidPage(
        
        
        titlePanel(
                h2("Percent High School vs. College Education Levels in the Midwest")),
        
        sidebarLayout(
                sidebarPanel(
                        h4("This application looks at the % of high school vs college education levels in the midwest using the midwest data set included in r"),
                        selectInput("state","Select one state",
                                    choices=c("Illinois"='IL',
                                              "Indiana"='IN',
                                              "Michigan"='MI',
                                              "Ohio"='OH',
                                              "Wisconsin"='WI'
                                              )),
                        
                        selectInput("sort","Select default variable to sort by. You can re-sort in table output",
                                    choices=c("High School"='HighSchool',
                                              "College"='College',
                                              "Population"='Population'
                                    )),
                        
                        actionButton("Submit","Submit",icon("refresh"))
                       
                ),
                
                mainPanel(
                        h3("Scatterplot"),
                        plotlyOutput("mymap"),
                        h3("Table of Results"),
                        tableOutput("table"))
        )
))