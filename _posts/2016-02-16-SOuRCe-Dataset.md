---
title: "SOuRCe Dataset"
author: "Danny Wong"
date: "16 February 2016"
layout: post
blog: false
projects: true
hidden: true # don't count this post in blog pagination
description: "This is a project page for the studies related to the SOuRCe Dataset"
category: project
tag:
- "Projects"
---

The Surgical Outcomes Research Centre (SOuRCe) collected perioperative data on almost 2,000 patients undergoing high-risk surgery. I used this to construct a [new model](http://dannyjnwong.github.io/Predicting-Postop-Morbidity-Elective-Surgical-Patients-using-SORT/) to predict postoperative morbidity as defined by the Post-Operative Morbidity Survey (POMS), based on the [Surgical Outcome Risk Tool](http://www.sortsurgery.com/).

This has now been [published](https://doi.org/10.1093/bja/aex117) and I provide an online tool to calculate morbidity risks [here](https://dannyjnwong.shinyapps.io/SORTMorbidityWebCalc/).

Further work on the dataset is currently being undertaken to share it as anonymised open data in order to facilitate reproducible research and answer other research questions.


{% highlight r %}
sessionInfo()
{% endhighlight %}



{% highlight text %}
## R version 3.3.3 (2017-03-06)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows >= 8 x64 (build 9200)
## 
## locale:
## [1] LC_COLLATE=English_United Kingdom.1252 
## [2] LC_CTYPE=English_United Kingdom.1252   
## [3] LC_MONETARY=English_United Kingdom.1252
## [4] LC_NUMERIC=C                           
## [5] LC_TIME=English_United Kingdom.1252    
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.14
## 
## loaded via a namespace (and not attached):
## [1] magrittr_1.5  tools_3.3.3   stringi_1.1.1 stringr_1.2.0 evaluate_0.9
{% endhighlight %}
