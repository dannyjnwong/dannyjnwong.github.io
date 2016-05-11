---
title: "Using sessionInfo() for better reproducibility"
author: "Danny Wong"
date: "11 May, 2016"
layout: post
blog: true
tag:
- r
- coding
---

I've recently had some trouble with re-running some old code. It turns out that the error was that the package `ggplot2` had recently released a new version and that I had upgraded it without realising that it would alter how my old code functioned.

As a result, I will now include `sessionInfo()` at the end of every piece of work I do, so that when I compile my `.Rmd` file, I will know in the future what the versions of the packages I used were. This will hopefully improve the reproducibility of my code.


{% highlight r %}
sessionInfo()
{% endhighlight %}



{% highlight text %}
## R version 3.2.4 (2016-03-10)
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
## [1] knitr_1.11
## 
## loaded via a namespace (and not attached):
## [1] magrittr_1.5  formatR_1.2.1 tools_3.2.4   stringi_1.0-1 stringr_1.0.0
## [6] evaluate_0.8
{% endhighlight %}

