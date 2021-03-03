#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb  8 15:00:34 2021

@author: elisekarinshak
"""


#CSCI 4360 - Data Science 2
#Tool Talk 2: Modeling Packages in Python
#Lauren Wilkes, Raj Patel, and Elise Karinshak

#Part 1:
#Introduction to python packages
#understanding numpy and pandas

#Python packages:
#collection of "modules" (can be imported and used)
#consist of existing code
#aids with providing functionality

#to use a package, you must import it:
import numpy as np
import pandas as pd
#by writing "as", you can provide a shorted set of characters to refer to the package
#commonly used packages such as numpy and pandas are conventionally shortened to
#np and pd (respectively)

#if you would like to import a specific function from a package: from ___ import ___
from sklearn import linear_model #we will address how to use this later


#ABOUT NUMPY
#the numpy package facilitates operations with arrays and matrices
#it is useful for using modeling packages
#allows for efficiency of arrays and matrices
#used for numerical data

#np array generation:
#one-dimensional numpy array
one_dim_arr = np.array([1, 2, 3, 4, 5])
#two-dimensional numpy array
two_dim_arr = np.array([[1, 2, 3], [4, 5, 6]]) #note syntax of nested brackets
#np.arrange: generate an array with given params
#np.arrange(start (inclusive), stop (exclusive), step)
aranged_arr = np.arange(0,10,2) #0, 2, 4, 6, 8

#array characteristics:
two_dim_arr.ndim #number of dimensions (2)
two_dim_arr.size #number of elements (6)
two_dim_arr.shape #number of elements per dimension (2 dimensions, 3 elems each)

#there are many more capabilities with the numpy package (splicing, reshaping, operations, etc.)
#not adressing to ensure time for statistical modeling
#read more: https://numpy.org/doc/stable/user/absolute_beginners.html


#ABOUT PANDAS
#used for data in tables (tabular data)
#terminology:
    #series: single list (similar to a 1D array)
    #datasets: collection of series: multiple lists (similar to 2D array)

#use pandas to read dataset from a csv file
data = pd.read_csv("~/Desktop/Involvement/CodeHub/datasets/titanic/train.csv")

#read more: https://pandas.pydata.org/pandas-docs/stable/user_guide/10min.html


#SUMMARY
#these packages assist programmers in creating and/or structuring their data
#they provide the foundation for statistical modeling (next)
