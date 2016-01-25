#This function script converts an Rmd file into an md file for the purpose of posting onto a Jekyll blog page.
#It was adapted from http://jfisher-usgs.github.io/r/2012/07/03/knitr-jekyll/
#I only made minor changes to specify the fig.path to figures/ from the original figs/

rmd2md <- function(input, base.url = "/") {
  require(knitr)
  opts_knit$set(base.url = base.url)
  fig.path <- paste0("figures/", sub(".Rmd$", "", basename(input)), "/")
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  render_jekyll()
  knit(input, envir = parent.frame())
}