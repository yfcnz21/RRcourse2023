### installing packages and loading libraries
setwd("/Users/nastya/Desktop/RRcourse2023/RRcourse2023/RRcourse2023/13. Metaanalysis/data")
install.packages("readxl")
install.packages(c('lhs', 'plyr', 'BBmisc', 'ParamHelpers', 'BatchJobs', 'BatchExperiments', 'ggplot2', 'metafor'))
install.packages("/Users/nastya/Downloads/metagen_1.0.tar", repos = NULL, type = "source")
install.packages("metagen")
install.packages("meta")
library(metafor)
library(dplyr)
library(readxl)
install.packages("magrittr")
library(magrittr)
library(meta)
library("metagen")


### importing the data
metaanalysis_data <- read_xlsx("metaanalysis_data.xlsx")
metaanalysis_data


### combine the effects
meta_boys <- metacont(n.e = N_boys,
                      mean.e = Mean_boys_play_male,
                      sd.e = SD_boys_play_male,
                      n.c = N_boys,
                      mean.c = Mean_boys_play_female,
                      sd.c = SD_boys_play_female,
                      data = metaanalysis_data,
                      comb.fixed = TRUE,
                      comb.random = TRUE)

meta_girls <- metacont(n.e = N_girls,
                       mean.e = Mean_girls_play_male,
                       sd.e = SD_girls_play_male,
                       n.c = N_girls,
                       mean.c = Mean_girls_play_female,
                       sd.c = SD_girls_play_female,
                       data = metaanalysis_data)

meta_boys %>% forest(sortvar = TE)
meta_girls %>% forest(sortvar = TE)


### create a funnel plot
meta_boys %>% funnel()

contour_levels <- c(0.90, 0.95, 0.99)
contour_colors <- c("red", "orange", "lightblue")
funnel(meta_boys, contour = contour_levels, col.contour = contour_colors)
legend("bottomright", c("p < 0.10", "p < 0.05", "p < 0.01"), bty = "n", fill = contour_colors)

### Baesed on p-vale the gender does not affect on the results.
