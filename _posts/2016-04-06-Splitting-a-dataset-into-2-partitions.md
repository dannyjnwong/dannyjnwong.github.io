---
title: "Splitting a dataset into 2 partitions"
author: "Danny Wong"
date: "06 April, 2016"
layout: post
blog: true
tag:
- R
- coding
---

We may sometimes need to split a dataset into 2 partitions, for example to create a training and testing dataset to fit a regression model and then perform internal validation.


{% highlight r %}
#Create simulated data
set.seed(10)
dat <- data.frame(col1 = rnorm(n = 100, mean = 1, sd = 1), col2 = runif(n = 100, min = 0, max = 1))

#Create partitions
set.seed(20)
x <- sample(length(dat$col1), size = length(dat$col1)/3)  
testing <- dat[x, ]
training <- dat[-x, ]

nrow(training)
{% endhighlight %}



{% highlight text %}
## [1] 67
{% endhighlight %}



{% highlight r %}
nrow(testing)
{% endhighlight %}



{% highlight text %}
## [1] 33
{% endhighlight %}



{% highlight r %}
head(training)
{% endhighlight %}



{% highlight text %}
##         col1      col2
## 2  0.8157475 0.5358950
## 4  0.4008323 0.8480705
## 8  0.6363240 0.9986345
## 11 2.1017795 0.7133420
## 12 1.7557815 0.6706220
## 13 0.7617664 0.7456896
{% endhighlight %}



{% highlight r %}
head(testing)
{% endhighlight %}



{% highlight text %}
##          col1      col2
## 88  3.2205197 0.5554849
## 77 -0.4798270 0.7477093
## 28  0.1278412 0.8037932
## 52  0.6654434 0.8751127
## 93  1.0695448 0.7021693
## 94  2.1553483 0.9937923
{% endhighlight %}

