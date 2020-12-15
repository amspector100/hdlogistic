library(glmhd)
Y <- secomy$V2
index <- sample(474, 100, replace = FALSE, prob = NULL)
print(index)
dt <- secomX[,index]
print(dt, max = 300)
df <- data.frame(y = Y, x = secomX)
fit <- glm(Y~.+0, data = dt, family = binomial, x = TRUE, y = TRUE)
print(fit)


fit2 <- adjust_glm(fit, verbose = FALSE, echo = TRUE)


s1 <- summary(fit)
s2 <- summary(fit2)

print(s1$coefficients, max = 10)
print(s2$coefficients, max = 10)
print(s2$coefficients[301:400])
print(s1$coefficients[301:400])

plot(seq(1,100), s2$coefficients[301:400], col = "red")
points(seq(1,100),s1$coefficients[301:400],col = "green")

hist(s2$coefficients[301:400])
hist(s1$coefficients[301:400])

plot(s1$coefficients[1:100],s2$coefficients[1:100])
abline(a = 0, b = 1)

