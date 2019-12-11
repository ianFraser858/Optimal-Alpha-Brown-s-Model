# Implementation of the single-equation recursive form of Brown’s model in Python.

This implementation finds the optimal alpha using SciPy (taken here to mean the lowest Root Mean Squared Error) based on a set of values and an initial alpha value. 

The dataframe then has a prediction for each real value added to it based on the optimal alpha. Errors are then calculated. 

Available either in notebook form or as a script (they do the same thing). If setting up a new enviroment and using this in script form use `pip install -r requirements.txt` to install the needed packages. 
 
