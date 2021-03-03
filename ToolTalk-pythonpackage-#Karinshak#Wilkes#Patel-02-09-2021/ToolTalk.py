#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb  8 20:06:13 2021

@author: laurenwilkes
"""



#Example 2



	#######################################################################
	#                                                                     #
	#                                                                     #
	#                               Problem 1                             #
	#                                                                     #
	#                                                                     #
	#######################################################################
	
	#############################################################
	#                                                           #
	#             First we enter the data                       #
	#                                                           #
	#############################################################
	
    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt

    # Enter the data and add column names
    concrete = pd.read_csv("~/downloads/concrete_training.csv", header=None, names = ["cement", "BFS",
                                                                                                 "FA", "Water","Superplasticizer", "CoarseAgg",
                                                                                                 "FineAgg", "Age", "CCS"])

    print(concrete)

    
    #dataset columns: cement, Blast Furnace Slag, Fly Ash, Water, Superplasticizer, Coarse Aggregate
    #Fine Aggregate, Age, and y = Concrete Compressive Strength
    

	
	#############################################################
	#                                                           #
	#                   Now we fit the model                    #
	#                                                           #
	#############################################################
    # import required packages
    import statsmodels.formula.api as smf
    import statsmodels.api as sm


    # Fitting the model
    Formula = 'CCS~cement+ BFS+ FA+Water+Superplasticizer+ CoarseAgg+FineAgg+Age'
    g = smf.ols(formula = Formula, data =concrete).fit()
    
    
    #You can also do interaction term using colons
    Formula = 'CCS~cement:BFS+ FA+Water+Superplasticizer:CoarseAgg+FineAgg+Age'
    g = smf.ols(formula = Formula, data =concrete).fit()
    #You can do powers using I(b**2)
    Formula = 'CCS~cement:BFS+ I(FA**2)+Water+Superplasticizer:CoarseAgg+I(FineAgg**3)+Age'
    g = smf.ols(formula = Formula, data =concrete).fit()
    #us np.log to take the log
    Formula = 'np.log(CCS)~cement:BFS+ FA+Water+Superplasticizer:CoarseAgg+FineAgg+Age'
    g = smf.ols(formula = Formula, data =concrete).fit()
    
    
     # pd.Categorical is similar to Factor command in R
    concrete.cement = pd.Categorical(concrete.cement)
    Formula = 'CCS~cement+ BFS+ FA+Water+Superplasticizer+ CoarseAgg+FineAgg+Age'
    g = smf.ols(formula = Formula, data =concrete).fit()
    
    
    #summary
   print(g.summary())

	#############################################################
	#                                                           #
	#                   Create ANOVA table                    #
	#                                                           #
	#############################################################
	# print anova table
    print(sm.stats.anova_lm(g, typ=1))
    
    #############################################################
	#                                                           #
	#                   Residual plot                   #
	#                                                           #
	#############################################################

    import matplotlib.pyplot as plt
    plt.scatter(g.fittedvalues,g.resid, c = 'red')
    plt.axhline(y = 0, color ="black", linestyle ="-")
    plt.title("Concrete Residuals vs. Fitted")
    plt.ylabel("Residuals")
    plt.xlabel("$\hat{y}$")
    
      #############################################################
	#                                                           #
	#                   QQ plot                   #
	#                                                           #
	#############################################################

    from statsmodels.graphics.gofplots import ProbPlot

    QQ = ProbPlot(g.resid)
    plot = QQ.qqplot(line = 's', color = 'C0', lw = 1)
    plt.title("Normal QQPlot for Concrete Data")
    plt.show()
    
    
  
    


    
    
    
    
    
