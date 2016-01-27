---
title: "Looking at Specialty Training Competition Ratios"
author: "Danny Wong"
date: "27 January, 2016"
layout: post
---

Health Education England's Medical and Dental Recruitment and Selection [website](http://specialtytraining.hee.nhs.uk/) publishes the numbers of applicants and available spaces, and hence the competition ratios for each of the Specialties for the last few years of recruitment.

We will try to extract the data and make some inferences. I have borrowed [Hadley Wickham's approach](http://www.r-bloggers.com/rvest-easy-web-scraping-with-r/) in scraping data from html files.


{% highlight r %}
#Load the required packages
require(rvest) #This package allows us to scrape data from html into R
require(dplyr) #To wrangle data

#The data for each year is laid out in its own separate page
x2015 <- read_html("http://specialtytraining.hee.nhs.uk/specialty-recruitment/competition-ratios/2015-competition-ratios/") %>%
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table()
x2014 <- read_html("http://specialtytraining.hee.nhs.uk/specialty-recruitment/competition-ratios/2014-competition-ratios/") %>%
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table() %>%
  select(-X3, -X5) #To remove the 2 columns with empty data
x2013 <- read_html("http://specialtytraining.hee.nhs.uk/specialty-recruitment/competition-ratios/2013-competition-ratios/") %>%
  html_nodes("table") %>% 
  .[[1]] %>% 
  html_table() %>%
  select(-X3, -X6, -X7)
{% endhighlight %}

There are some inconsistencies in the reporting of some of the Specialties between the different years. For example Medical Microbiology is not reported in 2015, but is reported in 2013 and 2014. Similarly Community Sexual and Reproductive Health is reported in 2014 and 2015, but not in 2013. It may be because there wasn't any recruitment for some Specialties in some years. Also there is some inconsistency in the nomenclature, eg. Anaesthetics is sometimes reported as Anaesthetics (including ACCS Anaesthetics). Let's join the data into a big table and clean it a little bit.


{% highlight r %}
x2015[2,1] <- "ACCS EM"
x2014[2,1] <- "ACCS EM"
x2013[2,1] <- "ACCS EM"

x2015[3,1] <- "Anaesthetics"
x2014[3,1] <- "Anaesthetics"
x2013[3,1] <- "Anaesthetics"

x2015[4,1] <- "Broad-Based Training"
x2014[4,1] <- "Broad-Based Training"
x2013[4,1] <- "Broad-Based Training"

x2015[8,1] <- "Core Medical Training"
x2014[8,1] <- "Core Medical Training"
x2013[7,1] <- "Core Medical Training"

x2013[8,1] <- "Core Psychiatry Training"

x2014[18,1] <- "Paediatrics"
x2013[16,1] <- "Paediatrics"

#Join up the data into one dataframe
x <- inner_join(x2015, x2014, by = "X1") %>% inner_join(x2013, by = "X1")

#Rename the columns correctly
colnames(x)[1] <- "Specialty"
colnames(x)[2] <- "Apps2015"
colnames(x)[3] <- "Posts2015"
colnames(x)[4] <- "Ratio2015"
colnames(x)[5] <- "Apps2014"
colnames(x)[6] <- "Posts2014"
colnames(x)[7] <- "Ratio2014"
colnames(x)[8] <- "Apps2013"
colnames(x)[9] <- "Posts2013"
colnames(x)[10] <- "Ratio2013"
#Remove the 1st row
x <- x[-1, ]
row.names(x) <- 1:nrow(x)
{% endhighlight %}

Let's see what we are left with.


{% highlight r %}
require(knitr)
kable(x)
{% endhighlight %}



Specialty                  |Apps2015 |Posts2015 |Ratio2015 |Apps2014 |Posts2014 |Ratio2014 |Apps2013 |Posts2013 |Ratio2013 
:--------------------------|:--------|:---------|:---------|:--------|:---------|:---------|:--------|:---------|:---------
ACCS EM                    |881      |363       |2.43      |759      |363       |2.1       |534      |203       |2.6       
Anaesthetics               |1294     |629       |2.06      |1262     |595       |2.1       |1189     |478       |2.5       
Broad-Based Training       |363      |83        |4.37      |258      |42        |6.1       |429      |52        |8.3       
Clinical Radiology         |917      |247       |3.71      |798      |227       |3.5       |751      |185       |4.1       
Core Medical Training      |2632     |1550      |1.7       |3065     |1468      |2.1       |3088     |1209      |2.6       
Core Psychiatry Training   |662      |466       |1.42      |643      |497       |1.3       |650      |437       |1.5       
Core Surgical Training     |1396     |604       |2.31      |1370     |625       |2.2       |1296     |676       |1.9       
General Practice           |5112     |3612      |1.42      |5477     |3391      |1.6       |6447     |2787      |2.3       
Histopathology             |189      |79        |2.39      |165      |93        |1.8       |154      |120       |1.3       
Neurosurgery               |169      |30        |5.63      |159      |24        |6.6       |183      |37        |4.9       
Obstetrics and Gynaecology |599      |238       |2.52      |583      |240       |2.4       |591      |204       |2.9       
Ophthalmology              |374      |95        |3.94      |353      |82        |4.3       |323      |71        |4.5       
Paediatrics                |801      |446       |1.8       |814      |435       |1.9       |793      |360       |2.2       
Public Health              |724      |88        |8.23      |686      |78        |8.8       |602      |70        |8.6       

Now we can start doing something with the data. 
