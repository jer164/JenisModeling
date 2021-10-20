This is a repo for my progress in creating a model that predicts daily waffle cone sales. This function will assist us with increasing waffle attachments.

At the moment, the code is based on the GLM.nb in MASS. Based on 400 observations - a number I am adding to whenever possible - of historical sales,
the model was trained to use weather, day of the week, and certain special events as a predictor of daily waffle cone sales. 

Using it is quite simple: call the cones_function(), and then fill out the prompts. *NOTE: first letter of your entries must be capitalized)* 
The code will then print its predictions, as wel as an 'Overflow' value that represents a safe upward estimate that will allow us to have leftovers the next morning.
