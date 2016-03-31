---
title: "Replacing values in a column with dplyr using logical statements"
author: "Danny Wong"
date: "31 March, 2016"
layout: post
blog: true
tag:
- R
- coding
---

If I have a dataframe (dat) with two columns, and there are NA values in one column (col1) that I want to specifically replace into zeroes (or whatever other value) but only in rows with specific values in the second column (col2) I can use `mutate`, `replace` and `which` in the following way.

{% highlight r %}
library(dplyr)

#Example dataframe
dat <- data.frame(col1 = c(1, 2, 3, NA, NA, NA, 3, 2, 1, 0), col2 = c("Tom", "Dick", "Harry", "Dick", "Tom", "Harry", "Harry", "Dick", "Tom", "Harry"))

print(dat)
{% endhighlight %}



{% highlight text %}
##    col1  col2
## 1     1   Tom
## 2     2  Dick
## 3     3 Harry
## 4    NA  Dick
## 5    NA   Tom
## 6    NA Harry
## 7     3 Harry
## 8     2  Dick
## 9     1   Tom
## 10    0 Harry
{% endhighlight %}



{% highlight r %}
dat <- dat %>% mutate(col1 = replace(col1, which(is.na(col1) & col2 == "Tom"), 0))

print(dat)
{% endhighlight %}



{% highlight text %}
##    col1  col2
## 1     1   Tom
## 2     2  Dick
## 3     3 Harry
## 4    NA  Dick
## 5     0   Tom
## 6    NA Harry
## 7     3 Harry
## 8     2  Dick
## 9     1   Tom
## 10    0 Harry
{% endhighlight %}
