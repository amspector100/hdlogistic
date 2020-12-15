## Load SECOM data
library(tidyverse)
X = read.csv('processed/secomX.csv')
y = read.csv(processed/secomy.csv)$V2

glm(y ~ X + 0, family=binomial, x=TRUE, y=TRUE)

