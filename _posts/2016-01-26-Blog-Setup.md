---
title: "How I Set Up This Blog"
author: "Danny Wong"
date: "26 January, 2016"
layout: post
blog: true
---

The purpose of this blog is to share my research and R code in order to facilitate reproducibility. Therefore, I have structured this blog to allow me write using the following workflow: 

1. Write my posts as Rmarkdown files (.Rmd) saved in the _drafts/ folder 
2. Knit the file into markdown (.md) using a helper function (rmd2md.R, contained in the _drafts/ folder as well)
3. Move the resultant .md file to the _posts/ folder where Jekyll (via GitHub) can render it as .html.

The original Jekyll blog repo was forked from [Jekyll Now](https://github.com/barryclark/jekyll-now).

I have taken inspiration for this workflow from [Andy South](http://andysouth.github.io/blog-setup/), [Nicole White](http://nicolewhite.github.io/2015/02/07/r-blogging-with-rmarkdown-knitr-jekyll.html) and [Jason Fisher](http://jfisher-usgs.github.io/r/2012/07/03/knitr-jekyll/). 

Particular thanks to Jason Fisher for the rmd2md() helper function on which the following script is based.


{% highlight r %}
rmd2md <- function(input, base.url = "/") {
  require(knitr)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("figures/", sub(".Rmd$", "", basename(input)), "/")
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  render_jekyll()
  knit(input, envir = parent.frame())
}
{% endhighlight %}
