## part 1
1. Add noise to training and check uncertainty or smth
2. verify regularization. Include in report
3. validate and include polyfit
4. make a multiplot. Use cell arrays of models and and evaluate in turn. 

## part 2
1. Make plot with both linreg and knn reg in the same plot.

## part 3

1. 
    - use lindata var=1, N=[10,100,1000,10000], use linregress, 

    WANT: true vs est param, plot of model vs data, check convergence. Include MSE on validation data. 

    - same as a but with deg 5 poly. compare with linmod. 

    WANT: MSE vs N. Check overfitting vs data or whatever. 

    - alidate the expression for the parameter variance with a Monte Carlo simulation.
    You can do this, eg, by estimating linear models on different data sets with, eg, 10
    data samples in each of them. Then you make a histogram by the parameter estimates.
    The file MonteCarloExample.m illustrate how this can be done. Note the difference
    of this validation from the one you did in Problem 1.a. There you validated that you
    program gave the same variance as the theoretical expression. Here you validate that
    the estimate you obtain has the variance you validated earlier
    - ry KNN models on some of the settings above. How many neighbors is good de-
    pending on the noise level and the number of data? Don’t spend a lot on time on
    this, a very approximate answer is enough indicating how thebest number of neighbors
    change when number of data change.

2. 
    - repeat previous linfit to polydata(N,var,0). Does the parameter uncertainty go to 0? Explain how it can do that. 
    - try various degrees of polymodels, try a 10 d model on N=15. try lambda=[0.01,0.1,...,100] compare result(note to self fix multiplot and use). 
    - call polydata(N,var,1) for unsymmetrical data. Do linfit, compare to previous linfit, is it different? is that an issue?
    - Try some KNN. k dependecy on noise+N? keep it short.

## part 4
### prework
make plotfunc for 2dplots
1. 
    - use twoDimData1/2(N,var) to make noisefree data and plot the function to be fitted. 
    - generate var=1, N=100 training data plus N=1000 validation data. 
    - test linregmodel
    - test polymod d=2,...,5
    - test knn. How many neighbors is good? Is it better than poly? At which N does that change?
2. (optional)
    - how many regressors for a lin model? How many for d=3 polymodel
    - N=1000, Var=1: validation 10000
    - test linreg
    - test polymod 3 check num regressors
    - Can regul improve hte polymod
    - test KNN what num neighbors is best? Compare with poly, check if better change N to find where the switch is. 