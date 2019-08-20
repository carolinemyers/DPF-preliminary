# DPF-preliminary
Contains code to create polar plots and other figures to visualize performance field data. 
Note all functions must be contained in same file path as main analysis script. 
Marisize: makes figures more appealing, adapted from Pascal Wallisch's 'Movshonize' function. 
setText: assigns and displays accuracy values within polar plot figure 
myPlot: creates a simple scatterplot with predetermined specs

Use: replace 'improot' block of DPFAnalysisScriptCM with imported data file as a matlab table. Run program.
Output: 2 polar plots (all ages, segmented by age brackets) 2 scatterplot figures containing subplots for performance X age and height, respectively, in both V and N conditions, age vs. height plot

To recreate age-bracketed polar plots based on height, run DPFAnalysisScriptCM and then run height.m

