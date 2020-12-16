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

# # randomly samples 100 indices 
# glmhd <- function(){
#   index <- sample(474, 100, replace = FALSE, prob = NULL)
#   dt <- secomX[,index]
#   df <- data.frame(y = Y, x = secomX)
#   fit <- glm(Y~.+0, data = dt, family = binomial, x = TRUE, y = TRUE)
#   fit2 <- adjust_glm(fit, verbose = FALSE, echo = TRUE)
  
#   if(exists("fit2")){
#     s1 <- summary(fit)
#     s2 <- summary(fit2)
#     # 
#     # print(s2$coefficients[1:100])
#     # print(s1$coefficients[1:100])
#     # plot(seq(1,100), s2$coefficients[301:400], col = "red")
#     # points(seq(1,100),s1$coefficients[301:400],col = "green")
#     # 
#     # hist(s1$coefficients[301:400])
#     # hist(s2$coefficients[301:400])
#     # 
#     bfit1 <- s1$coefficients[1:100]
#     bfit2<- s2$coefficients[1:100]
    
#     inf <- s1$coefficients[1:100]/s2$coefficients[1:100]
    
#     # print(inf)
#     # bfit1_processed <- Trim(bfit1,0.1)
#     # bfit2_processed <- Trim(bfit2,0.1)
#     # 
#     # #dfrm <- s1$coefficients
#     # #write.csv(dfrm,"glm.csv")
#     # #dfrm <- s2$coefficients
#     # #write.csv(dfrm,"glm_adj.csv")
#     # 
#     # plot(bfit1, bfit2)
#     # #plot(bfit1_processed,bfit2_processed)
#     # abline(a = 0, b = 1)
    
#     retlist <- list("inf" = inf[1])
#     return(retlist)
#   }
#   return("N/A")
# }

# vec <- c()
# for(i in 1:50){
#   a <- glmhd()
#   print(a$inf)
#   vec<- c(vec, a$inf)
# }
