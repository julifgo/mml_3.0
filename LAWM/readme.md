# LAWM Model Errors and Debugging Issue
## Introduction
Our Latin America World Model is created to produce results for world regions (Latin America, Developed Countries, Africa, Asia) year by year between 1960 - 2050.
Right now, we are facing issues running for __Latin America and Developed__ regions. At different points in time, the model crashes. The output error is not giving us enough information to know where the problem is.
So our goal is being able to debug it putting breakpoints and visualizing current state of every variable to trace the issue.

## Running Scenarios
In the main package, under *Scenarios* Package, there's a list of models to simulate. *StandardRun* runs the simulation for every region. The rest of them is specific for each region.

![Alt text](images/scenarios_tree.jpg?raw=true "Scenarios Tree")

Currently, to make them fail, we need to simulate *StandardRunLAM* or *StandardDeveloped* from 1960 to 2020 (Developed Model will crash in 2001, LAM Model will crash in 2013). All values for simulation setup are default as we can see next.

![Alt text](images/simulation_setup.jpg?raw=true "Simulation Setup")

In this example we can see the output error for LAM in 2013.

![Alt text](images/simulation_finish_error.jpg?raw=true "Simulation Setup")

## Debugging
Changing the simulation setup to enable algoritmic debugger and adding two breakpoints what we get is that the model stops at first breakpoint (in line 82), but it never stops in breakpoint at line 87, which is inside a *when loop*. That loop is crucial because it updates variables values year by year.
The file I'm showing is located in *Regions/Base/Region*

![Alt text](images/breakpoints.jpg?raw=true "Breakpoints")

When model is paused at line 83, the only thing I can do that generates some response from the debugger is to touch the Resume button of the Stack Frame Browser (green triangle at the top left).
Doing that, it brakes the model at another point that had no breakpoint and then it brakes again at line 83, and so on.

Beyond the fact that it never brakes in the breakpoint inside the loop, another important problem that I have been having is that I cannot see in any way the value that the variables take, in the example of the capture, neither the previous value of year_counter, nor the value of discreteTime, as you can see in below image in *Locals Browser* section.

## Interactive Simulation
We also try with Interactive simulation to manually go year by year and observe the variables value. Nevertheless it doesn't always work, and when it does it gets really dificult to stop in the year we wish and further, most of the times, OMEdit crashes and it closes.
