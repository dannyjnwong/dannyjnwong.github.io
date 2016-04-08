---
title: "Webscraping NBA data: 2015-16 Golden State Warriors vs 1995-96 Chicago Bulls"
author: "Danny Wong"
date: "08 April, 2016"
layout: post
blog: true
tag:
- R
- coding
---

The 2015-16 Golden State Warriors are on the verge of either equalling or beating the 1995-96 Chicago Bulls' record of 72 wins in the NBA regular season. Let's use `r` to scrape some data from NBA.com to graph the Warriors' progress over the season in comparison to the Bull's record-setting season.

We will use the `rvest` [package](http://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/) to do so.


{% highlight r %}
library(rvest)
library(tidyr)

nba <- html("http://www.nba.com/news/2015-16-golden-state-warriors-chase-1995-96-chicago-bulls-all-time-wins-record/")
{% endhighlight %}



{% highlight text %}
## Warning: 'html' is deprecated.
## Use 'read_html' instead.
## See help("Deprecated")
{% endhighlight %}



{% highlight r %}
data <- nba %>% html_nodes("table") %>% html_table(header = TRUE, fill = TRUE)

summary(data)
{% endhighlight %}



{% highlight text %}
##      Length Class      Mode
## [1,] 416    data.frame list
## [2,]   5    data.frame list
{% endhighlight %}



{% highlight r %}
data <- data[[2]]

data
{% endhighlight %}



{% highlight text %}
##                    Warriors result Record Game Number
## 1            111-95 W vs. Pelicans    1-0           1
## 2             112-92 W vs. Rockets    2-0           2
## 3             134-120 W @ Pelicans    3-0           3
## 4           119-69 W vs. Grizzlies    4-0           4
## 5           112-108 W vs. Clippers    5-0           5
## 6            119-104 W vs. Nuggets    6-0           6
## 7                 103-94 W @ Kings    7-0           7
## 8             109-95 W vs. Pistons    8-0           8
## 9             100-84 W @ Grizzlies    9-0           9
## 10        129-116 W @ Timberwolves   10-0          10
## 11          107-99 W vs. Nets (OT)   11-0          11
## 12           115-110 W vs. Raptors   12-0          12
## 13            124-117 W @ Clippers   13-0          13
## 14              106-94 W vs. Bulls   14-0          14
## 15             118-105 W @ Nuggets   15-0          15
## 16             111-77 W vs. Lakers   16-0          16
## 17                135-116 W @ Suns   17-0          17
## 18             120-101 W vs. Kings   18-0          18
## 19                106-103 W @ Jazz   19-0          19
## 20              116-99 W @ Hornets   20-0          20
## 21             112-109 W @ Raptors   21-0          21
## 22                 114-98 W @ Nets   22-0          22
## 23              131-123 W @ Pacers   23-0          23
## 24      124-119 W @ Celtics (2 OT)   24-0          24
## 25                108-95 L @ Bucks   24-1          25
## 26              128-103 W vs. Suns   25-1          26
## 27              121-112 W vs.Bucks   26-1          27
## 28               103-85 W vs. Jazz   27-1          28
## 29                89-83 W vs. Cavs   28-1          29
## 30             122-103 W vs. Kings   29-1          30
## 31            114-91 L @ Mavericks   29-2          31
## 32             114-110 W @ Rockets   30-2          32
## 33      111-108 W vs. Nuggets (OT)   31-2          33
## 34           111-101 W vs. Hornets   32-2          34
## 35               109-88 W @ Lakers   33-2          35
## 36             128-108 W @ Blazers   34-2          36
## 37               128-116 W @ Kings   35-2          37
## 38              111-103 W vs. Heat   36-2          38
## 39             112-110 L @ Nuggets   36-3          39
## 40             116-98 W vs. Lakers   37-3          40
## 41              113-95 L @ Pistons   37-4          41
## 42            132-98 W @ Cavaliers   38-4          42
## 43                125-94 W @ Bulls   39-4          43
## 44            122-110 W vs. Pacers   40-4          44
## 45              120-90 W vs. Spurs   41-4          45
## 46         127-107 W vs. Mavericks   42-4          46
## 47              108-105 W @ Sixers   43-4          47
## 48               116-95 W @ Knicks   44-4          48
## 49             134-121 W @ Wizards   45-4          49
## 50           116-108 W vs. Thunder   46-4          50
## 51           123-110 W vs. Rockets   47-4          51
## 52                112-104 W @ Suns   48-4          52
## 53             137-105 L @ Blazers   48-5          53
## 54            115-112 W @ Clippers   49-5          54
## 55                102-92 W @ Hawks   50-5          55
## 56                118-112 W @ Heat   51-5          56
## 57               130-114 W @ Magic   52-5          57
## 58        121-118 W @ Thunder (OT)   53-5          58
## 59        109-105 W vs. Hawks (OT)   54-5          59
## 60          121-106 W. vs. Thunder   55-5          60
## 61               112-95 L @ Lakers   55-6          61
## 62             119-113 W vs. Magic   56-6          62
## 63               115-94 W vs. Jazz   57-6          63
## 64           128-112 W vs. Blazers   58-6          64
## 65              123-116 W vs. Suns   59-6          65
## 66          125-107 W vs. Pelicans   60-6          66
## 67             121-85 W vs. Knicks   61-6          67
## 68           130-112 W @ Mavericks   62-6          68
## 69                 87-79 L @ Spurs   62-7          69
## 70        109-104 W @ Timberwolves   63-7          70
## 71           114-98 W vs. Clippers   64-7          71
## 72         128-120 W vs. Mavericks   65-7          72
## 73            117-105 W vs. Sixers   66-7          73
## 74            102-94 W vs. Wizards   67-7          74
## 75            103-96 W @ Jazz (OT)   68-7          75
## 76           109-106 L vs. Celtics   68-8          76
## 77           136-111 W vs. Blazers   69-8          77
## 78 124-117 L vs. Timberwolves (OT)   69-9          78
## 79             112-101 W vs. Spurs   70-9          79
## 80           @ Grizzlies (April 9)                 80
## 81              @ Spurs (April 10)                 81
## 82        vs. Grizzlies (April 13)                 82
##                  Bulls result Record
## 1        105-91 W vs. Hornets    1-0
## 2        107-85 W vs. Celtics    2-0
## 3       117-108 W vs. Raptors    3-0
## 4             106-88 W @ Cavs    4-0
## 5       110-106 W vs. Blazers    5-0
## 6             94-88 L @ Magic    5-1
## 7           113-94 W vs. Cavs    6-1
## 8           109-94 W vs. Nets    7-1
## 9  108-102 W @ Mavericks (OT)    8-1
## 10           103-94 W @ Spurs    9-1
## 11             90-85 W @ Jazz   10-1
## 12           97-92 L @ Sonics   10-2
## 13        107-104 W @ Blazers   11-2
## 14        94-88 W @ Grizzlies   12-2
## 15        104-98 W @ Clippers   13-2
## 16        101-94 W vs. Knicks   14-2
## 17         106-87 W vs. Spurs   15-2
## 18          118-106 W @ Bucks   16-2
## 19        112-103 W vs. Magic   17-2
## 20          127-108 W @ Hawks   18-2
## 21        108-88 W vs. Lakers   19-2
## 22        123-114 W @ Celtics   20-2
## 23    114-101 W vs. Mavericks   21-2
## 24      113-104 W vs. Raptors   22-2
## 25          100-86 W vs. Jazz   23-2
## 26          103-97 L @ Pacers   23-3
## 27        120-93 W vs. Pacers   24-3
## 28          95-93 W vs. Hawks   25-3
## 29       100-86 W vs. Rockets   26-3
## 30         117-93 W @ Hornets   27-3
## 31         113-84 W vs. Bucks   28-3
## 32        113-87 W vs. Sonics   29-3
## 33          120-93 W @ Sixers   30-3
## 34        116-109 W @ Bullets   31-3
## 35       116-104 W vs. Sixers   32-3
## 36          92-89 W @ Raptors   33-3
## 37         111-96 W @ Pistons   34-3
## 38           99-79 W @ Knicks   35-3
## 39     104-84 W vs. Grizzlies   36-3
## 40          102-80 W vs. Heat   37-3
## 41           93-82 W vs. Suns   38-3
## 42          98-87 W @ Rockets   39-3
## 43           105-85 W @ Kings   40-3
## 44           99-84 W @ Lakers   41-3
## 45         105-99 L @ Nuggets   41-4
## 46            106-96 L @ Suns   41-5
## 47         99-95 W @ Warriors   42-5
## 48       111-98 W vs. Bullets   43-5
## 49   112-109 W @ Pistons (OT)   44-5
## 50   103-100 W @ Timberwolves   45-5
## 51         110-102 W @ Pacers   46-5
## 52          106-72 W vs. Cavs   47-5
## 53            96-91 W @ Hawks   48-5
## 54           113-104 L @ Heat   48-6
## 55         111-91 W vs. Magic   49-6
## 56  120-99 W vs. Timberwolves   50-6
## 57      110-87 W vs. Warriors   51-6
## 58       107-75 W vs. Celtics   52-6
## 59        115-106 W vs. Bucks   53-6
## 60       102-81 W vs. Pistons   54-6
## 61          104-72 L @ Knicks   54-7
## 62       103-86 W vs. Bullets   55-7
## 63       108-87 W vs. Nuggets   56-7
## 64             97-93 W @ Nets   57-7
## 65           98-94 W @ Sixers   58-7
## 66          89-67 W vs. Kings   59-7
## 67        107-86 W vs. Knicks   60-7
## 68        109-108 L @ Raptors   60-8
## 69         111-80 W vs. Hawks   61-8
## 70      106-85 W vs. Clippers   62-8
## 71            110-92 W @ Heat   63-8
## 72          100-92 W vs. Heat   64-8
## 73         126-92 W @ Hornets   65-8
## 74            90-86 W @ Magic   66-8
## 75        98-97 L vs. Hornets   66-9
## 76           113-100 W @ Nets   67-9
## 77        112-82 W vs. Sixers   68-9
## 78             98-72 W @ Cavs   69-9
## 79            86-80 W @ Bucks   70-9
## 80       110-79 W vs. Pistons   71-9
## 81        100-99 L vs. Pacers  71-10
## 82       103-93 W vs. Bullets  72-10
{% endhighlight %}



{% highlight r %}
#split the dataframes into seperate Warriors and Bulls dataframes 
colnames(data)[3] <- "Game" #To remove the space between Game Number

warriors <- cbind(data[3], data[2])
bulls <- cbind(data[3], data[5])

#Separate the wins and losses into 2 columns
warriors <- warriors %>% separate(col = Record, into = c("W", "L"), sep = "-")
{% endhighlight %}



{% highlight text %}
## Warning: Too few values at 3 locations: 80, 81, 82
{% endhighlight %}



{% highlight r %}
bulls <- bulls %>% separate(col = Record, into = c("W", "L"), sep = "-")

#Plot with base graphics
plot(W ~ Game, type="l", col="red", data = bulls)
points(W ~ Game, type="l", col="green", data = warriors)
{% endhighlight %}

![center](/figures/2016-04-08-Webscraping-NBA-data-2015-16-Golden-State-Warriors-vs-1995-96-Chicago-Bulls/unnamed-chunk-1-1.png) 

The plot in base graphics doesn't look that nice. Let's fire up `ggplot2`.


{% highlight r %}
library(ggplot2)

#The dataframes need to be merged into a long format to plot it using gpglot2
warriors$team <- "2015-16 Warriors"
bulls$team <- "1995-96 Bulls"

data <- rbind(warriors, bulls)

#Change characters to factors and numbers
data$team <- as.factor(data$team)
data$W <- as.numeric(data$W)
data$Game <- as.numeric(data$Game)

#Now we can plot
ggplot(data = data, aes(x = Game, y = W, group = team, colour = team)) +
  geom_line()
{% endhighlight %}



{% highlight text %}
## Warning: Removed 3 rows containing missing values (geom_path).
{% endhighlight %}

![center](/figures/2016-04-08-Webscraping-NBA-data-2015-16-Golden-State-Warriors-vs-1995-96-Chicago-Bulls/unnamed-chunk-2-1.png) 

