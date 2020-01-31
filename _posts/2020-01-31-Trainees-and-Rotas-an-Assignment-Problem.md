---
title: "Trainees and Rotas: an Assignment Problem"
author: "Danny Wong"
date: "31 January 2020"
layout: post
blog: true
tag:
- coding
- R
---

I saw this tweet last night on Twitter:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">The worst solution is:<br><br>Line A - Person 1<br> B - 2<br> C - 8<br> D - 6<br> E - 4<br> F - 3<br> G - 7<br> H - 5<br><br>This has a mean choice of 6.5 out of 8. <br><br>What&#39;s the best combination? <a href="https://t.co/HKPrn5MizT">https://t.co/HKPrn5MizT</a> <a href="https://t.co/ZeWnCVmHhC">pic.twitter.com/ZeWnCVmHhC</a></p>&mdash; Graham McCracken (@grahamccracken) <a href="https://twitter.com/grahamccracken/status/1222933576347504642?ref_src=twsrc%5Etfw">January 30, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[Graham McCracken](https://twitter.com/grahamccracken) raised a problem that is frequently encountered by hospital consultants and junior doctors who are in charge of the rota: fairly assigning rota slots to trainees according to their preferences. Of course this is essentially an example of the [Assignment Problem](https://en.wikipedia.org/wiki/Assignment_problem).

So I decided to have a go at solving this problem using the `lpSolve` package in `R`.


{% highlight r %}
# Load library
library(lpSolve)

# Set up the Trainees' preferences
prefT <- matrix(c(1, 1, 1, 1, 1, 1, 1, 1,
                  2, 6, 2, 2, 2, 2, 2, 2,
                  3, 8, 8, 6, 5, 6, 7, 8,
                  4, 5, 7, 3, 7, 8, 6, 3,
                  5, 4, 3, 7, 3, 4, 5, 6,
                  6, 3, 6, 5, 4, 3, 4, 5,
                  7, 2, 4, 8, 6, 5, 8, 7,
                  8, 7, 5, 4, 8, 7, 3, 4),
                nrow = 8, ncol = 8, byrow = TRUE,
                dimnames = list(LETTERS[1:8],
                                1:8))
prefT
{% endhighlight %}



{% highlight text %}
##   1 2 3 4 5 6 7 8
## A 1 1 1 1 1 1 1 1
## B 2 6 2 2 2 2 2 2
## C 3 8 8 6 5 6 7 8
## D 4 5 7 3 7 8 6 3
## E 5 4 3 7 3 4 5 6
## F 6 3 6 5 4 3 4 5
## G 7 2 4 8 6 5 8 7
## H 8 7 5 4 8 7 3 4
{% endhighlight %}

After loading up the `lpSolve` package, we set up the Trainee's (numbered 1 to 8) preferences (`prefT`) for particular rota lines (A to H) in a matrix. After we have set up the preferences, we can use the `lp.assign()` function to perform the match.


{% highlight r %}
# Run the assignment
matching <- lp.assign(prefT)
matching$solution
{% endhighlight %}



{% highlight text %}
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
## [1,]    0    0    0    0    0    0    0    1
## [2,]    0    0    0    0    1    0    0    0
## [3,]    1    0    0    0    0    0    0    0
## [4,]    0    0    0    1    0    0    0    0
## [5,]    0    0    1    0    0    0    0    0
## [6,]    0    0    0    0    0    1    0    0
## [7,]    0    1    0    0    0    0    0    0
## [8,]    0    0    0    0    0    0    1    0
{% endhighlight %}

The `lp.assign()` returns the solution of the match is a matrix. There should be more than 1 permutation of the solution available but in this instance, the function only returns one permutation. We can then view the result.


{% highlight r %}
# Make a dataframe of the results in a human interpretable format
Rota <- rownames(prefT)
ix <- round(matching$solution %*% seq_len(ncol(prefT)))
Trainee <- colnames(prefT)[ifelse(ix == 0, NA, ix)]
results <- data.frame(Rota, Trainee)

# Print the results dataframe
knitr::kable(results)
{% endhighlight %}



|Rota |Trainee |
|:----|:-------|
|A    |8       |
|B    |5       |
|C    |1       |
|D    |4       |
|E    |3       |
|F    |6       |
|G    |2       |
|H    |7       |

In this example we have 8 trainees for 8 rota lines, but we could presumably also reformulate it for fewer trainees if there are rota gaps.


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
## [1] knitr_1.25     lpSolve_5.6.15
## 
## loaded via a namespace (and not attached):
##  [1] compiler_3.5.2  magrittr_1.5    htmltools_0.3.6 tools_3.5.2    
##  [5] Rcpp_1.0.1      pander_0.6.2    stringi_1.1.7   rmarkdown_1.16 
##  [9] highr_0.7       stringr_1.3.1   xfun_0.10       digest_0.6.16  
## [13] packrat_0.4.9-3 evaluate_0.14
{% endhighlight %}
