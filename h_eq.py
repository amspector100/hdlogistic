""" This code is adapted from the R package https://github.com/zq00/glmhd, 
developed by Qian Zhao at Stanford."""
import numpy as np
import scipy
from scipy.optimize import minimize
from scipy.stats import norm
from cubature import cubature
import time

def hinge(t):
    return np.maximum(t,0)

def integrate2_normal(f):
    """
    Integrates f, which takes two inputs and one output,
    times the normal PDF applied to both of f's inputs. 
    """
    def integrand(x):
        return f(x)*norm.pdf(x[0])*norm.pdf(x[1])
    return cubature(
        func=integrand, 
        ndim=2,
        fdim=1,
        xmin=np.array([-8, -8]),
        xmax=np.array([8, 8]),
        maxEval=0,
        relerr=1e-4,
    )

def rho_prime(t):
    return(1/(1+np.exp(-t)))

def solve_kappa(beta0, gamma0):
    # h is the function to minimize
    def h(t):
        # Define functions for input 
        def f1(x):
            hinge_output = hinge(t[0] + t[1] * x[0] - x[1])**2 
            return hinge_output * rho_prime(beta0 + gamma0 * x[0])
        def f2(x):
            hinge_output = hinge(-t[0] - t[1] * x[0] - x[1])**2
            return hinge_output * (1 - rho_prime(beta0 + gamma0 * x[0]))
        # Normal integrations
        time0 = time.time()
        val1, _ = integrate2_normal(f1)
        val2, _ = integrate2_normal(f2)
        return val1 + val2

    # Minimize 
    scipy_obj = minimize(
        fun=h,
        x0=[0,0],
        method='L-BFGS-B',
        options={'maxiter':10}
    )
    return(h(scipy_obj.x))