---
title: "Mapping UK Traffic Accidents"
author: "Danny Wong"
date: "02 September, 2016"
layout: post
blog: true
tag:
- R
- coding
- mapping
---

I saw a [post on Lucas Puente's blog](http://lucaspuente.github.io/notes/2016/09/01/Mapping_Traffic_Fatalities) today which mapped US traffic fatalities in 2015 using an open dataset released by the US National Highway Traffic Safety Administration and was inspired to do similar using UK data. 

Fortunately the UK has been releasing public data of this information for some time and [data from 1979 onwards is available](https://data.gov.uk/dataset/road-accidents-safety-data)! I decided to use [2015 data](http://data.dft.gov.uk/road-accidents-safety-data/DfTRoadSafety_2015.zip) to try and apply Lucas' method. This data shows "personal injury accidents on public roads that are reported to the police, and subsequently recorded, using the STATS19 accident reporting form" according to the metadata.


{% highlight r %}
library(ggplot2)

accidents <- read.csv("../data/DfTRoadSafety_Accidents_2015.csv")

#Load the map data for the UK
UK_map_data <- map_data("world", c('UK', 'Isle of Man','Isle of Wight', 'Wales:Anglesey'))

#Start plotting
map <- ggplot() + 
  geom_polygon(data=UK_map_data, aes(x=long,y=lat,group=group), colour = alpha("black", 1/4), fill = NA) +
  #Add points (one per fatality):
  geom_point(data=accidents, aes(x=Longitude, y=Latitude), alpha=0.05, size=0.2, col="red") +
  #Add a title:
  ggtitle("Traffic Accidents in 2015") +
  #Adjust the map projection
  coord_map("albers", lat0=49.84, lat1=60.85) +
  #Adjust the theme:
  theme_classic() +
  theme(panel.border = element_blank(),
        axis.text = element_blank(),
        line = element_blank(),
        axis.title = element_blank(),
        plot.title = element_text(size=40, face="bold"))

map
{% endhighlight %}

![center](/figures/2016-09-02-Mapping-UK-Traffic-Accidents/unnamed-chunk-1-1.png)

Thanks to Lucas for sharing his method! 
