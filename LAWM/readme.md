# LAWM Model Errors and Debugging Issue
## Introduction
Our Latin America World Model is created to produce results for world regions (Latin America, Developed Countries, Africa, Asia) year by year between 1960 - 2050.
Right now, we are facing issues running for Latin America and Developed countries. At different points in time, the model crashes. The output error is not giving us enough information to know where the problem is.
So our goal is being able to debug it putting breakpoints and visualizing current state of every variable to trace the issue.

## Running Scenarios
In the main package, under *Scenarios* Package, there's a list of models to simulate. *StandardRun* runs the simulation for every region. The rest of them is specific for each region.
[INSERT IMAGE HERE]
Currently, to make them fail, we need to simulate *StandardRunLAM* or *StandardDeveloped* from 1960 to 2020 (Developed Model will crash in 2001, LAM Model will crash in 2013).
[INSERT IMAGE OF SIMULATION SETUP]
