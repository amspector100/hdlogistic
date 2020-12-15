library(glmhd)
library(DescTools)
Y <- secomy$V2


show_condition <- function(code){
  tryCatch(code,
           error = function(c) "error",
           warning = function(c) "warning",
           message = function(c)"message"
  )
}

glmhd <- function(){
  # randomly samples 100 indices 
  index <- sample(474, 100, replace = FALSE, prob = NULL)
  dt <- secomX[,index]
  fit <- glm(Y~.+0, data = dt, family = binomial, x = TRUE, y = TRUE)
  fit2 <- show_condition(adjust_glm(fit, verbose = FALSE, echo = TRUE))
  if(fit2!="error"){
    print('hello there')
    s1 <- summary(fit)
    s2 <- summary(fit2)
    
    # 
    # print(s2$coefficients[1:100])
    # print(s1$coefficients[1:100])
    # plot(seq(1,100), s2$coefficients[301:400], col = "red")
    # points(seq(1,100),s1$coefficients[301:400],col = "green")
    # 
    # hist(s1$coefficients[301:400])
    # hist(s2$coefficients[301:400])
    # 
    bfit1 <- s1$coefficients[1:100]
    bfit2<- s2$coefficients[1:100]
    
    inf <- s1$coefficients[1:100]/s2$coefficients[1:100]
    
    # print(inf)
    # bfit1_processed <- Trim(bfit1,0.1)
    # bfit2_processed <- Trim(bfit2,0.1)
    # 
    # #dfrm <- s1$coefficients
    # #write.csv(dfrm,"glm.csv")
    # #dfrm <- s2$coefficients
    # #write.csv(dfrm,"glm_adj.csv")
    # 
    # plot(bfit1, bfit2)
    # #plot(bfit1_processed,bfit2_processed)
    # abline(a = 0, b = 1)
    
    retlist <- list("inf" = inf[1])
    return(retlist)
  }
  else{
    print('no MLE')
    retlist <- list("inf" = "N/A")
    return(retlist)
  }
}

vec <- c()
for(i in 1:50){
  a <- glmhd()
  print(a$inf)
  vec<- c(vec, a$inf)
}
print(a)
print(vec)



