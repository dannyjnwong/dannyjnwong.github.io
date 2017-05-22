---
title: "Research tools and collaboration"
author: "Danny Wong"
date: "22 May, 2017"
layout: post
blog: true
tag:
- thoughts
---

There are a lot of different ways of conducting research and probably an infinite variety of tools to do so. From the tools used to acquire, clean and analyse data, to the tools used to write and publish manuscripts. I am currently in the process of moving from being a project manager for the [SNAP-2: EpiCCS study](http://www.niaa-hsrc.org.uk/SNAP-2-EpiCCS), to sitting down and analysing the data. 

I have previously described my [workflow for doing everything in R Markdown](http://dannyjnwong.github.io/Producing-a-manuscript-for-journal-publication-in-R-Markdown/), and yes, even my current [blog workflow](http://dannyjnwong.github.io/Blog-Setup/) involves using R Markdown, including this post. However, I found that this workflow only really works for people who are at least as computer literate as I am. Many of my colleagues actually work with a different set of tools to me, but are equally productive (perhaps even more so!) than I am. For example, the Microsoft Excel -> Point-and-click statistical package -> Microsoft Word pathway has probably produced a good majority of scientific literature out there. In fact, this is exactly the workflow my primary PhD supervisor has, and the rest of my research group have, been working in for years. As a result, my R Markdown workflow is alien to many of them.

In order to facilitate collaboration, I write many of my thoughts down in R Markdown, `knit` into `.docx` and email the resultant files to colleagues for them to use track changes and commenting in Microsoft Word, then bring the changes back into R Markdown manually. This method is tedious and sometimes you lose the context of the discussion when making changes and tracking changes involves the use of `Git` for version control. This is all well and good for the later stages of crafting a manuscript, but becomes quite unwieldy for very early stages of putting down nascent ideas onto the page.

Enter [Evernote](https://evernote.com/).

I have discovered the beauty of working with just ideas on Evernote, which allows for sharing very early stage documents with people, in the same application as one that allows for clipping ideas directly from web pages. All contained within a searchable database, with the ability to group ideas into notebooks and tags, or not at all, because of the ability for inline text searching. This allows for the early exploratory idea-building that is necessary before committing to the ideas R Markdown. It also allows for drafting emails and other throwaway notes that do not necessarily require me to build/maintain a file and directory structure. Cutting and pasting attachments into the document is also easy, allowing me to quickly refer to the source material without having to fiddle with `.bib` files for referencing, which can always be done later.

I don't know if in the long run this would lock me into a proprietary piece of software. We can only really find out in the future I guess, and nobody has a crystal ball.

The [Software Sustainability Institute](http://www.software.ac.uk), which I am a fellow of, recommends that Software itself should be considered a legitimate research output. I also agree that it should be considered an essential component of Reproducible Research. However, we cannot always engineer our own software solutions from scratch, and I think using tools like Evernote isn't diametrically opposed to the ethos of the Institute, after all, I'd argue that many commercial/proprietary software solutions are way more "sustainable" than small software projects maintained by a few Research Software Engineers coding in an obscure language (which may itself go in and out of fashion, Fortran legacy code anyone?). 


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
## [1] magrittr_1.5  formatR_1.4   tools_3.3.3   stringi_1.1.1 stringr_1.0.0
## [6] evaluate_0.9
{% endhighlight %}
