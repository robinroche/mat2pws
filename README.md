# mat2pws

An interface script between Matlab and PowerWorld Simulator.

### Licence

None. Feel free to use it as you wish.

### Context

Developing smart control strategies for power systems requires testing their behavior and performance, at first in simulation, as shown in a recent [paper](http://dx.doi.org/10.1109/DEXA.2012.9). To do that, you need a simulation tool capable of advanced analysis (e.g., power flow) and of advanced and customizable control algorithms. 

As we could not find any satisfactory existing solution, we developed an interface between two/three software to achieve it: [JADE](http://jade.tilab.com/) / [Matlab](http://www.mathworks.com/products/matlab/) / [PowerWorld Simulator](http://www.powerworld.com/).

This interface was developed in collaboration with Colorado State University's [Dr. Suryanarayanan](http://www.engr.colostate.edu/~ssuryana).

![Interface between JADE, Matlab and PowerWorld Simulator](http://robinroche.com/webpage/images/Jadepw.png)

mat2pws is only a portion of the whole interface, as it only concerns the interface between Matlab and PowerWorld Simulator. See [mat2jade](https://github.com/robinroche/mat2jade) and [jade2pws](https://github.com/robinroche/jade2pws) for the other parts of the whole interface.

### Interface concept

This script is a basic interface between Matlab and PowerWorld Simulator with SimAuto. It is based on the documentation of PowerWorld Simulator, and extends the examples provided. It can be easily tested and modified.

### Code structure

- main.m: The test file for Matlab.
- ieee14.PWB: A test case (the IEEE 14 bus system) created in PowerWorld Simulator. 

### Using the code

Matlab (tested with R2011b), as well as PowerWorld Simulator with the SimAuto add-on, that provides COM connectivity (tested with version 16) are required for using mat2pws. 

Code use instructions are as follows:
1. Get the mat2pws files.
2. Run the main.m file.
3. The communication should then be established and data should be exchanged. You should see things displaying in the console. If not, well, there is a problem somewhere.

Please cite one of my papers if you use it, especially for research: http://dx.doi.org/10.1109/DEXA.2012.9

### Limitations 

- No extensive testing has been done, so use it at your own risk. 
- If you find bugs, errors, etc., or want to contribute, please let me know.
- Also refer to PowerWorld's user manual for information on how data is structured.
 
### Contact

Robin Roche - robinroche.com
