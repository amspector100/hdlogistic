## Imports
library(cubature)

## Integration
integrate2_normal <- function(f, ...){
  integrand <- function(x) f(x) * dnorm(x[1]) * dnorm(x[2])
  
  hcubature(integrand, lowerLimit = c(-8,-8), upperLimit = c(8,8),
            fDim = 1, maxEval = 0, tol = 1e-4,  ...)$integral
}

## kapp
solve_kappa <- function(rho_prime, beta0, gamma0){
  h <- function(t){
    print("Starting cubature...")
    f1 <- function(x) hinge(t[1] + t[2] * x[1] - x[2])^2 * rho_prime(beta0 + gamma0 * x[1])
    f2 <- function(x) hinge(-t[1] - t[2] * x[1] - x[2])^2 * (1 - rho_prime(beta0 + gamma0 * x[1]))
    integrate2_normal(f1) + integrate2_normal(f2)
  }
  optim(par=c(0, 0), h, method='L-BFGS-B')$val
}

# Thing

hinge <- function(t) max(t, 0)
rho_prime_logistic <- function(x) {1 / (1 + exp(-x))}