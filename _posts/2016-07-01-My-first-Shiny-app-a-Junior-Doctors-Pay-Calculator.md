---
title: "My first Shiny app, a Junior Doctors' Pay Calculator"
author: "Danny Wong"
date: "01 July, 2016"
layout: post
blog: true
tag:
- R
- coding
- shiny
---

I have recently written my first [Shiny](http://shiny.rstudio.com/) app in R. It's a [pay calculator](https://dannyjnwong.shinyapps.io/JDPayCalc/), and its source is hosted on a [Github repo](https://github.com/dannyjnwong/JDPayCalc). I have also reproduced the code below.

The amazing thing is that it's written as a single R script file!


{% highlight r %}
library(shiny)
library(xtable)

# Define UI for application
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("Junior Doctors' Pay Calculator v.0.5"),
   p("Instructions: You will need to have knowledge of the rota you will likely be working on for accurate calculations. Work out the average number of hours worked per week and the average number of enhanced hours (hours between 21:00-08:00hrs) worked per week."), 
   p("This calculator at the moment does not model earnings for trainees on Less-Than-Full-Time (LTFT) training. It also does not calculate pay protection arrangements, nor income tax. If you are using this on a mobile device, the bar chart is best viewed in landscape mode."),
   a(href="https://github.com/dannyjnwong/JDPayCalc", "Click here to see the source code for this calculator."),
   p("MIT License; Copyright (c) 2016 Danny Jon Nian Wong"),
   
   # Sidebar with a number of inputs
   sidebarLayout(
      sidebarPanel(
              selectInput("grade",
                          "On the day that you start or move onto the new contract what will your training grade be?
",                     
                          choices = c("FY1", "FY2", "CT1/ST1", "CT2/ST2", "CT3/ST3", "ST4", "ST5", "ST6", "ST7", "ST8")
                          ),
              sliderInput("weeklyHours",
                          "What is the average number of hours per week you will work on your rota?",
                          min = 0,
                          max = 72,
                          value = 40, 
                          step = 0.25
                          ),
              sliderInput("enhancedHours",
                          "What is the average number of enhanced hours (hours between 21:00 and 08:00hrs) per week you will work on your rota?",
                          min = 0,
                          max = 40,
                          value = 5,
                          step = 0.25
                          ),
              selectInput("weekendFreq",
                          "What is the average frequency of weekends worked on your rota?",                     
                          choices = c("1:2", "<1:2 - 1:4", "<1:4 - 1:5", "<1:5 - 1:7", "<1:7 - 1:8", "<1:8")
                          ),
              radioButtons("NROC",
                           "Do you do Non-Resident On-Calls?",
                           choices = c("Yes", "No"),
                           selected = "No"
                           ),
              radioButtons("FPP",
                           "Are you a specialty trainee in one of the following specialties?",
                           choices = c("Emergency Medicine","GP", "Psychiatry", "Oral/Maxillofacial Surgery", "None of the above"),
                           selected = "None of the above"
                           ),
              radioButtons("acadFPP",
                           "Will you be eligible for the Academic Flexible Pay Premium (successfully completed a higher academic degree)?",
                           choices = c("Yes", "No"),
                           selected = "No"
                           )
              
      ),
      
      # Show a plot
      mainPanel(
         plotOutput("payPlot"),
         tableOutput("payTable")
      )
   )
))

# Define server logic required to draw a plot
server <- shinyServer(function(input, output) {
   
   values <- function() {
           if (input$grade=="FY1") {
                   basicPay <- 26350
                   nodalPoint <- 1
           } else if (input$grade=="FY2") {
                   basicPay <- 30500
                   nodalPoint <- 2
           } else if (input$grade=="CT1/ST1"|input$grade=="CT2/ST2") {
                   basicPay <- 36100
                   nodalPoint <- 3
           } else if (input$grade=="CT3/ST3") {
                   basicPay <- 45750
                   nodalPoint <- 4
           } else {
                   basicPay <- 45750
                   nodalPoint <- 4
           }
           
           hrlyPay <- basicPay/(365/7*40)
           
           if (input$weeklyHours>40 & input$weeklyHours<=48) {
                   addhrsPay <- (input$weeklyHours - 40) * hrlyPay * 365/7
           } else if (input$weeklyHours>48 & nodalPoint==1) {
                   addhrsPay <- (8 * hrlyPay * 365/7) + ((input$weeklyHours - 48) * 23.13 * 365/7)
           } else if (input$weeklyHours>48 & nodalPoint==2) {
                   addhrsPay <- (8 * hrlyPay * 365/7) + ((input$weeklyHours - 48) * 26.78 * 365/7)
           } else if (input$weeklyHours>48 & nodalPoint==3) {
                   addhrsPay <- (8 * hrlyPay * 365/7) + ((input$weeklyHours - 48) * 31.68 * 365/7)
           } else if (input$weeklyHours>48 & nodalPoint==4) {
                   addhrsPay <- (8 * hrlyPay * 365/7) + ((input$weeklyHours - 48) * 40.16 * 365/7)
           } else {
                   addhrsPay <- 0
           }
           
           enhrsPay <- input$enhancedHours * hrlyPay * 0.37 * 365/7
           
           if (input$weekendFreq=="1:2") {
                   weekendPay <- basicPay * 0.10
           } else if (input$weekendFreq=="<1:2 - 1:4") {
                   weekendPay <- basicPay * 0.075
           } else if (input$weekendFreq=="<1:4 - 1:5") {
                   weekendPay <- basicPay * 0.06
           } else if (input$weekendFreq=="<1:5 - 1:7") {
                   weekendPay <- basicPay * 0.04
           } else if (input$weekendFreq=="<1:7 - 1:8") {
                   weekendPay <- basicPay * 0.03
           } else {
                   weekendPay <- 0
           }
           
           if (input$NROC=="Yes") {
                   if (nodalPoint==1) {
                           NROCPay <- 2108
                   } else if (nodalPoint==2) {
                           NROCPay <- 2440
                   } else if (nodalPoint==3) {
                           NROCPay <- 2888
                   } else {
                           NROCPay <- 3660
                   }
           } else {
                   NROCPay <- 0
           }
           
           if (input$FPP=="Emergency Medicine") {
                   if (input$grade=="ST4") {
                           FPPay <- 20000/3
                   } else if (input$grade=="ST5") {
                           FPPay <- 20000/2
                   } else if (input$grade=="ST6") {
                           FPPay <- 20000
                   } else {
                           FPPay <- 0
                   }
           } else if (input$FPP=="GP" & (input$grade=="CT1/ST1" | 
                                         input$grade=="CT2/ST2" | 
                                         input$grade=="CT3/ST3" | 
                                         input$grade=="ST4" | 
                                         input$grade=="ST5" | 
                                         input$grade=="ST6" | 
                                         input$grade=="ST7"| 
                                         input$grade=="ST8")) {
                   FPPay <- 8200
           } else if (input$FPP=="Psychiatry"){
                   if (input$grade=="CT1/ST1") {
                           FPPay <- 20000/6
                   } else if (input$grade=="CT2/ST2") {
                           FPPay <- 20000/5
                   } else if (input$grade=="CT3/ST3") {
                           FPPay <- 20000/4
                   } else if (input$grade=="ST4") {
                           FPPay <- 20000/3
                   } else if (input$grade=="ST5") {
                           FPPay <- 20000/2
                   } else if (input$grade=="ST6") {
                           FPPay <- 20000
                   } else if (input$grade=="FY1" | input$grade=="FY2") {
                           FPPay <- 0
                   } else {
                           FPPay <- 20000
                   }
           } else if (input$FPP=="Oral/Maxillofacial Surgery") {
                   if (input$grade=="CT3/ST3") {
                           FPPay <- 20000/5
                   } else if (input$grade=="ST4") {
                           FPPay <- 20000/4
                   } else if (input$grade=="ST5") {
                           FPPay <- 20000/3
                   } else if (input$grade=="ST6") {
                           FPPay <- 20000/2
                   } else if (input$grade=="ST7") {
                           FPPay <- 20000
                   } else {
                           FPPay <- 0
                   }
           } else {
                   FPPay <- 0
           }
           
           if (input$acadFPP=="Yes") {
                   acadFPPay <- 4000
           } else {
                   acadFPPay <- 0
           }
           
           FPPay <- FPPay + acadFPPay
           
           basicPay <- round(basicPay, 2)
           addhrsPay <- round(addhrsPay, 2)
           enhrsPay <- round(enhrsPay, 2)
           weekendPay <- round(weekendPay, 2)
           NROCPay <- round(NROCPay, 2)
           FPPay <- round(FPPay, 2)
           
           x <- list(basicPay = basicPay, addhrsPay = addhrsPay, enhrsPay = enhrsPay, weekendPay = weekendPay, NROCPay = NROCPay, FPPay = FPPay)
           return(x)
   }
        
   output$payPlot <- renderPlot({
           
           dat <- cbind(values()$basicPay, values()$addhrsPay, values()$enhrsPay, values()$weekendPay, values()$NROCPay, values()$FPPay)
                              
           barplot(dat,
                   main=paste0("Total Annual Salary = £", format(round(sum(dat),2), nsmall = 2)),
                   col=c("skyblue"),
                   border = "white",
                   names.arg = c(paste0("Basic Pay\n£", format(values()$basicPay, nsmall = 2)),
                                 paste0("Added Hrs\n£", format(values()$addhrsPay, nsmall = 2)), 
                                 paste0("Out-of-Hrs\n£", format(values()$enhrsPay, nsmall = 2)),
                                 paste0("W/E Suppl.\n£", format(values()$weekendPay, nsmall = 2)),
                                 paste0("NROC\n£", format(values()$NROCPay, nsmall = 2)),
                                 paste0("FPP\n£", format(values()$FPPay, nsmall = 2))))
           text(4, max(dat[-1])+2000, 
                labels = paste0("Total uplift = £", format(round(sum(dat[-1]),2), nsmall = 2),
                                "\n(", format(round((sum(dat[-1])/(dat[1]))*100,2), nsmall = 2),"% of Basic Pay)"))
           if (input$weeklyHours > 48) {
                   text(4, dat[2]+6000,
                        labels = "*Penalty rates apply on\nAdded Hrs above 48hrs/wk")
           }

   output$payTable <- renderTable({
           
           tab <- data.frame(Breakdown = c("Basic salary",
                                           "Additional hours supplement (above 40hrs/week)",
                                           "Enhanced hours supplement (21:00-08:00hrs)",
                                           "Weekend frequency uplift",
                                           "NROC availability allowance",
                                           "Flexible Pay Premium",
                                           "Total"), 
                             Pay = c(paste0("£", format(values()$basicPay, nsmall = 2)), 
                                     paste0("£", format(values()$addhrsPay, nsmall = 2)), 
                                     paste0("£", format(values()$enhrsPay, nsmall = 2)), 
                                     paste0("£", format(values()$weekendPay, nsmall = 2)), 
                                     paste0("£", format(values()$NROCPay, nsmall = 2)), 
                                     paste0("£", format(values()$FPPay, nsmall = 2)),
                                     paste0("£", format(sum(unlist(values())), nsmall = 2)))
           )
           
           xtable(tab)
           
   })
                      
   })
})

# Run the application 
shinyApp(ui = ui, server = server)
{% endhighlight %}
