import numpy as np
import scipy
from scipy.optimize import minimize
from scipy.stats import norm

def hinge(t):
    return max(t,0)

def integrate2_normal(f,x):
    integrand = f(x)*norm.pdf(x[0])*norm.pdf(x[1])
    cubature(integrand)

def f1(t,x,b0,g0):
    return(hinge(t[0]+t[1]*x[0]-x[1])^2*rho_prime(b0+g0+x[0]))

def f2(t,x,b0,g0):
    return(hinge(-t[0]-t[1]*x[0]-x[1])^2*(1-rho_prime(b0+g0*x[0])))

def rho_prime(t):
    return(1/(1+np.exp(-t)))


def solve_kappa(beta0, gamma0):
    def h(t):
        def integrand1(x):
            f1(x)*norm.pdf(x[0])*norm.pdf(x[1])
        def integrand2(x):
            f2(x)*norm.pdf(x[0])*norm.pdf(x[1])
        return cubature(integrand1)+cubature(integrand2)
    return(minimize(fun = h, x0=[0,0], method = 'L-BFGS-B'))

print(solve_kappa(0,0))