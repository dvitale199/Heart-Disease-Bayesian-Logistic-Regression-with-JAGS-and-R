README

The code can be run in the following order:

1. preprocessing: final_EDA_and_proc.R
	this script takes in data/heart.csv does some EDA and preprocessing and outputs cleanData.csv

2. Running bayesian logistic regression: Driver.R, which calls on Jags-Ydich-XmetMulti-Mlogistic.R as well as DBDA2E-utilities.R from Doing Bayesian Data Analysis scripts to run the analysis. This outputs TEMPmodel.txt which performs MCMC with logistic regression and outputs MCMC diagnostic figures for Betas and zBetas, as well as posterior diagrams for Betas and zBetas. Along with this, the Heart-Disease-SummaryInfo.csv is output and contains information on coefficients from logistic regression

All code is run from the base directory with the original data, heart.csv in data/heart.csv and results output to output/ directory

Jags-Ydich-XmetMulti-Mlogistic.R 
Accompanies the book:
Kruschke, J. K. (2015). Doing Bayesian Data Analysis, Second Edition: 
A Tutorial with R, JAGS, and Stan. Academic Press / Elsevier.