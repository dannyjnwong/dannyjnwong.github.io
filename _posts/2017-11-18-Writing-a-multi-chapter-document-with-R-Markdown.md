---
title: "Writing a multi-chapter document with R Markdown"
author: "Danny Wong"
date: "19 November, 2017"
layout: post
blog: true
tag:
- R
- R Markdown
- coding
---

I have previously wrote about manuscript preparation with R Markdown [here](http://dannyjnwong.github.io/Producing-a-manuscript-for-journal-publication-in-R-Markdown/), and [here](http://dannyjnwong.github.io/Producing-a-manuscript-for-journal-publication-in-R-Markdown/). These were previously single papers which were relatively simple to construct. 

However, I am now in the midst of writing my PhD Upgrade Report (to upgrade from MPhil to Phd), and need to produce a larger document that encompasses multiple chapters and will be approximately 10,000 words long. Therefore I thought I'd best adjust the workflow slightly to allow for working on separate chapters and then getting them joined together, and arrange references all at the end. I shall also adopt this workflow for my final PhD thesis, when and if I get to writing it!

So this is how I'm doing it: 

- Create an R Markdown document for each separate chapter (child documents), we can name them `01-intro.Rmd`, `02-methods.Rmd`, `03-results.Rmd` for this example.
- Create a separate R Markdown document (parent document) which will then be used to stitch them together into one output document.

The child documents can contain the usual R Markdown report components, and reference tags `[@author_title_year]` and can each be knitted into their own separate documents on their own if necessary (for sharing and review, etc.).

The parent document is then simply:

{% highlight r %}
---  
title: "My Upgrade Report"
bibliography: ../references/bib/SNAP2.bib
csl: ../references/bib/vancouver.csl
link-citations: yes
output:
  word_document:
  toc: yes
  reference_docx: styles.docx
---

```{r child = '01-intro.Rmd'}
```

```{r child = '02-methods.Rmd'}
```

```{r child = '03-results.Rmd'}
```

# References
{% endhighlight %}

Once you knit this parent document, each child will then be joined together seamlessly. I am outputting this as a `.docx` file and this will allow me to send the draft to my PhD Supervisor for review (and use track changes to provide comments, which is the workflow she is accustomed to). I can point pandoc to a `style.docx` file which contains a template of all the necessary styling in order to ensure my output document looks ok.

As usual, thanks to [StackOverflow](https://stackoverflow.com/questions/25824795/how-to-combine-two-rmarkdown-rmd-files-into-a-single-output) for helping with this code. Particular thanks to user [eric](https://stackoverflow.com/users/2577347/eric)!


{% highlight r %}
sessionInfo()
{% endhighlight %}



{% highlight text %}
## R version 3.4.2 (2017-09-28)
## Platform: x86_64-w64-mingw32/x64 (64-bit)
## Running under: Windows >= 8 x64 (build 9200)
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
## [1] knitr_1.17
## 
## loaded via a namespace (and not attached):
## [1] compiler_3.4.2  magrittr_1.5    tools_3.4.2     yaml_2.1.14    
## [5] stringi_1.1.1   stringr_1.2.0   evaluate_0.10.1
{% endhighlight %}
