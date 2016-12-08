
library(shiny)
library(plotly)
library(dplyr)
library(googleVis)
options(digits=2)
plot<-midwest[,c(2,3,5,18,19)]
plot$perchsd<-round(plot$perchsd,1)
plot$percollege<-round(plot$percollege,1)
names(plot)<-c('County','State','Population','HighSchool','College')
shinyServer(function(input, output,session) {
        
        observeEvent(input$Submit, {
                state=input$state
                sort=as.character(input$sort)
                plot<-plot[plot$State==state & plot$Population > 100000,]
        
                output$mymap = renderPlotly({
                        plot_ly(data=plot,type='scatter',x=plot$HighSchool,y=plot$College,mode="markers",color=as.factor(plot$County)) %>%                            #   layout(title = paste("% HS vs College Degrees by County(pop > 100k)<br>from midwest dataset,state=",input$state,sep="),
                                 layout(title = paste("% HS vs College Degrees by County(pop > 100k),state:",input$state,sep=""),
                                       yaxis = list(title=" % College Degrees"),
                                       xaxis = list(title=" % High School Degrees"))       
                        
                })
              
                plot<-eval(substitute(arrange(plot,desc(sort)), list(sort=as.name(sort)))) %>% mutate(Rank=rownames(plot)) %>% select(Rank,State,County,Population,HighSchool,College)
                rownames(plot)<-NULL
                
                output$table <- renderGvis({
                        plot$HighSchool<-plot$HighSchool/100
                        plot$College<-plot$College/100
                        gvisTable(plot,formats=list(HighSchool='##.#%',College='##.#%'),options=list(page='enable',title="x"))
                                 
                })                
        })
        
})

