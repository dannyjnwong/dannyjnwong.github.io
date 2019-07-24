---
title: "Data Science for Doctors Abbreviated 1-Day Course"
author: "Danny Wong"
date: "24 July, 2019"
layout: post
blog: true
tag:
- R
- coding
---

It's been a while since I've blogged. Life has become a little bit more hectic as I've returned to clinical training from my 3-year period Out-of-Programme doing Research... As some people might know, through my involvement with the [Data Science Breakfast Club](http://dannyjnwong.github.io/Data-Science-Breakfast-Club/), I've been [teaching the basics of coding in R](http://datascibc.org/Data-Science-for-Docs/) to novice researchers, concentrating on an audience of clinicians with expertise in various specialties (primarily anaesthetists) but with little or no experience in coding or data analysis. 

To date, we have run the course about 6 times, and usually the course has been conducted over 2 days. The course has been immensely popular, the last couple of times we ran it, it sold out within a week of advertising (20 attendees usually).

The course has also since been ported across to the [UCL Clinician Coders](https://www.ucl.ac.uk/school-life-medical-sciences/about-slms/office-vice-provost-health/academic-careers-office/career-schemes/clinician-coders) scheme, and there's also talk about making it a formal training programme for other organisations looking to increase the research capacity in the UK for healthcare data.

As part of the evolution of these courses, we delivered a one-day version at Guy's Hospital to a group of 15 anaesthetists, who were really interested in picking up some data analysis basics, but weren't able to find the time to commit to 2 days away from clinical practice. Many thanks to [Arun Sahni](https://twitter.com/DrArunSahni) and [James Bedford](https://twitter.com/jbedford84) for helping me to run this version of the course &mdash; without the high ratio of faculty to students, this course would never be able to run!

I think it is important to open up participation to a wider audience, and some people might be interested enough to get a taste of coding but can only find time in their busy schedules for one full day. So I ported the presentations into a seried of 6 lectures. Heavily borrowing from the material that my friends and I in the Data Science Breakfast Club created over the last 3 or 4 years. Special thanks to [Steve Harris](https://twitter.com/drstevok), [Ed Palmer](https://twitter.com/DocEd), [Ahmed Al-Hindawi](https://twitter.com/aalhindawi), [Finn Catling](https://twitter.com/FinnCatling), and [Paolo Perella](https://twitter.com/irish_italiano), who have all contributed to the development of the 2-day course material over this period.

In the spirit of open collaboration, I feel that this abbreviated 1-day course could easily be taught in other hospitals and therefore I want to share the content with anybody who might be interested.

The course agenda is below, and links to the slides are included, each lesson is 1 hour long, and there's an hour-long break for lunch built in:

1. [Basics of R](https://dannyjnwong.github.io/assets/others/datascibc_slides/01-lesson-01-r-for-newbies_slide.html)	(09:00-10:00)
2. [Spreadsheet tips](https://dannyjnwong.github.io/assets/others/datascibc_slides/02-lesson-02-excel-hell-slide.html)	(10:00-11:00)
3. [Getting data into R](https://dannyjnwong.github.io/assets/others/datascibc_slides/03-lesson-03-getting-data-into-r-slides.html)	(11:00-12:00)
4. *Lunch break!	(12:00-13:00)*
5. [Basic data wrangling](https://dannyjnwong.github.io/assets/others/datascibc_slides/04-lesson-04-data-wrangling_slide.html)	(13:00-14:00)
6. [Real simple stats](https://dannyjnwong.github.io/assets/others/datascibc_slides/05-lesson-05-just-enough-statistics-slides.html)	(14:00-15:00)
7. [Data visualisation with ggplot2](https://dannyjnwong.github.io/assets/others/datascibc_slides/06-lesson-06-ggplot2.html)	(15:00-16:00)

When and if I get the time, I'll put this all on a Github repo with the data files and `.Rmd` files used to make the slides.


{% highlight r %}
sessionInfo()
{% endhighlight %}



{% highlight text %}
## R version 3.5.2 (2018-12-20)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows 10 x64 (build 17763)
## 
## Matrix products: default
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
## [1] knitr_1.20
## 
## loaded via a namespace (and not attached):
## [1] compiler_3.5.2  magrittr_1.5    tools_3.5.2     stringi_1.1.7  
## [5] stringr_1.3.1   packrat_0.4.9-3 evaluate_0.11
{% endhighlight %}
