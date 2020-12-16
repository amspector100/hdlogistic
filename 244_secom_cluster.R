library(glmhd)
library(tidyverse)

# To start, load data using the "Import Dataset" feature of RStudio.
Y <- secomy$V2
df <- data.frame(x = clusteredX, y=Y)
fit <- glm(y~., data=df, family=binomial, x=TRUE, y=TRUE)

# Adjust inference 
adjusted_fit <- glmhd::adjust_glm(fit, verbose=TRUE, echo=TRUE)
cat("Adjusted parameters are", adjusted_fit$param, "!\n")

# Likelihood-ratio p-values
p = dim(clusteredX)[2]
lrt_pvals = c()
adj_lrt_pvals = c()
for (i in 1:p) {
  cat("At index", i,"\n")
  # Fit a model without this index
  inner_df = data.frame(x=clusteredX[,-i], y=Y)
  inner_fit = glm(y~., data=inner_df, family=binomial, x=TRUE, y=TRUE) 
  classic_lrt <- lmtest::lrtest(fit, inner_fit)
  lrt_fit <- glmhd::lrt_glm(list(fit, inner_fit), param=adjusted_fit$param)
  lrt_pvals = c(lrt_pvals, classic_lrt$`Pr(>Chisq)`[2])
  adj_lrt_pvals = c(adj_lrt_pvals, lrt_fit$anova.tab$p.value[2])
}

# Put all the data together and pass it back to Python
output <- data.frame(
  lrt_pval=lrt_pvals,
  adj_lrt_pvals=adj_lrt_pvals,
  coef_unadj=adjusted_fit$coef_unadj,
  std_unadj=adjusted_fit$std_unadj,
  coef_adj=adjusted_fit$coef_adj,
  std_adj=adjusted_fit$std_adj
)
write.table(output, file="cache/clusteredresults.csv", sep=',')
