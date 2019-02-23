---
title: "Sharing data alongside code"
author: "Danny Wong"
date: "23 February, 2019"
layout: post
blog: true
tag:
- R
- coding
- R Markdown
- Perioperative Medicine
---

Earlier this month the second paper from [SNAP-2: EPICCS](http://dannyjnwong.github.io/SNAP-2-EPICCS/) was published [online in the BJA](https://bjanaesthesia.org/article/S0007-0912(19)30011-X/fulltext), looking at the postoperative critical are capacities in the UK, Australia and New Zealand[^reference]. The paper highlights the differences in available critical care resources in the three countries as well as differences in staffing levels in general surgical wards, and the presence of high-acuity care areas outside of ICUs and HDUs where higher risk patients get sent to for postoperative recovery. 

[^reference]: Wong DJN, Popham S, Wilson AM, Barneto LM, Lindsay HA, Farmer L, et al. Postoperative critical care and high-acuity care provision in the United Kingdom, Australia, and New Zealand. British Journal of Anaesthesia. 2019; Available from: http://www.sciencedirect.com/science/article/pii/S000709121930011X

As I [have done](http://dannyjnwong.github.io/Sharing-code-whats-the-point/) [in the past](https://github.com/dannyjnwong/SNAP2_Cancellations), I've again shared the code for this latest paper in a [GitHub repository](https://github.com/dannyjnwong/SNAP2_Org_Survey) for the sake of reproducibility. However on this occasion, I have gone one step further and shared the data that was used in the analyses in the repository alongside the code, which allows the entire manuscript and analyses to be reproduced in full. Previously this has been difficult to achieve because of patient-level identifiable information contained within the datasets used in previous papers.

This time, as the data analysed pertained to individual hospital responses to an organisational survey, the confidentiality issues are much less of a concern. I have still anonymised the dataset such that hospital names, individual critical care and high-acuity care unit names have been replaced by ID codes. If anyone should want to reuse the data for analysis, it could be done as-is, or if they wish to link the organisational data to other datasets, I could provide the de-anonymised dataset on request.

In the future, I hope to be able to provide even patient-level data for re-analysis, and may use packages such as [`encryptr`](https://github.com/SurgicalInformatics/encryptr) which [Ewen Harrison](https://twitter.com/ewenharrison?lang=en) and co from the [Surgical Informatics](https://github.com/SurgicalInformatics) group at the University of Edinburgh have created, which allows authors to encrypt specific variables/columns which are deemed to be directly identifiable. This approach however does not solve the issue of indirect re-identification by inference.

Other solutions for sharing data which also look promising go down another route of actually creating simulated datasets based on the covariance structure of the original dataset (an approach I mentioned very briefly in the closing paragraph of [my previous post](http://dannyjnwong.github.io/Sharing-code-whats-the-point/)), and there seem to be packages that do this including [`simstudy`](https://www.rdatagen.net/page/simstudy/), and [`synthpop`](https://cran.r-project.org/web/packages/synthpop/index.html). 

I personally feel that journals would do well to provide some guidance as to which approach towards datasharing would be best going into the future. The benefits of sharing both the data and code behind academic papers in medicine would be huge: at the very least it would 1) help to identify fraudulent research of the sort [recently uncovered by Paul Myles et al](https://onlinelibrary.wiley.com/doi/10.1111/anae.14584), and [John Carlisle](https://onlinelibrary.wiley.com/doi/full/10.1111/anae.13938) in recent years; 2) encourage post-publication review and study replication; and 3) provide education for future researchers planning on utilising similar research methods.


{% highlight r %}
sessionInfo()
{% endhighlight %}



{% highlight text %}
## R version 3.5.2 (2018-12-20)
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
## [1] knitr_1.20
## 
## loaded via a namespace (and not attached):
## [1] compiler_3.5.2 magrittr_1.5   tools_3.5.2    yaml_2.2.0    
## [5] stringi_1.1.7  stringr_1.3.1  evaluate_0.11
{% endhighlight %}
