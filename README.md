# Inference for High Dimensional Logistic Regression
Python and R implementation of inference for logistic regression in high dimensions. This repo includes a significant number of files, as we first execute the glmhd package (described below) in R before conducting data analysis in Python.


### Prerequisites

- R package for [glmhd](https://github.com/zq00/glmhd). This is the R package from ["The Asymptotic Distribution of the MLE in High-dimensional
Logistic Models: Arbitrary Covariance"](https://arxiv.org/pdf/2001.09351.pdf).

### Data
- `figures`: Includes figure results for simulations, following the procedure proposed in Section 4.
- `glmoutput`: Includes the results of `244_secom.R`, including the estimates, standard error, z-values, and p-values for the standard GLM and the adjusted GLM on 100 randomly sampled covariates of the SECOM dataset, as well as the ratios of the estimates for 50 trials of random sampling.
- `processed`: Includes scaled data, deletes all-null features.
- `raw`: Raw SECOM data

### Algorithm Implementation

The `dpCode` directory contains the implementation code of various differentially private mean estimation algorithms.

- `244.ipynb`: Data analysis on the output of `244_secom.R`, provides the bulk of the code needed to reproduce Appendix D.
- `244_secom.R`: Provides the code to run any number of trials of glmhd on the SECOM dataset, following the procedure in Section 5. Currently runs 50 trials, sampling 100 covariates.
- `Python Plots.ipynb`: Data analysis on the output of `Stat244_Final_Project_Simulations`: Provides the code needed to reproduce Appendices A and C, as well as Figure 6 in Appendix D.  
- `SECOM_analysis.R`: Runs the GLM on the processed SECOM data.
- `Stat244_Final_Project_Simulations.R`: Includes all R code used to generate data in simulations. Plots kappa, gamma, and h_mle to produce the data needed to reproduce Appendix A. Also writes a general function for sampling covariates and a binary response and then fitting a logistic regression model, following the simulation process in Section 4. Output is analyzed in `Python Plots.ipynb`
- `h_eq.py`: Python version of [h_eq.R](https://github.com/zq00/glmhd/blob/master/R/h_eq.R) from the original authors. Code combines several R files and executes solve_kappa accurately. 
- `r_test.R`: Rewriting some of the [h_eq.R](https://github.com/zq00/glmhd/blob/master/R/h_eq.R) file in R.
- `stat230.ipynb`: Accidentally uploaded to the repo by Aditya

### Reproducibility

`Stat244_Final_Project_Simulations.R` contains all evaluation code for reproducing simulations. `Python Plots.ipynb` reproduces the figures associated with simulations, and the results table (Figure 6) for the SECOM dataset, shown at the top of Appendix D. `244_secom.R` contains all evaluation code for evaluating the SECOM dataset. `244.ipynb` contains all remaining evaluation code for the figures in the SECOM dataset.
