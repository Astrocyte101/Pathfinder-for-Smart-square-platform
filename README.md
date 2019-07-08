# Pathfinder

Jason Snyder Lab Watermaze Search strategy and entropy analysis.
Created by **Matthew Cooke** at **The University of British Columbia**, **Jason Snyder Lab**
Visit us at [https://matthewbcooke.github.io/Pathfinder/]()

## Synopsis

The Pathfinder package is a animal search strategy analysis tool for the Morris Water Maze. The program analyses X-Y coordinate data exported from tracking software (currently supports Ethovision, Anymazy, WaterMaze, and ezTrack). We then calculate the best-fit search strategy for the trial. We analyse the data and fit it into one of 9 search strategies: Direct Swim, Directed Search, Focal Search, Spatial indirect, Chaining, Scanning, Thigmotaxis, and Random Search.

## Usage Example

1. The program can be opened by calling `pathfinder` if installed through PyPi or by navigating to your install location and calling `python pathfinder.py` in a terminal window. See [**Installation**](https://github.com/MatthewBCooke/Pathfinder/blob/master/README.md#installation) for install instructions.

2. This will open up the GUI window.

![Window Preview](https://live.staticflickr.com/65535/48062456503_3479c0c828_b.jpg)

3. You can then select an inividual file or a directory containing files from the **File** dropdown menu. These files must be Excel files if you are using Ethovision tracking software, and CSV files if you are using Anymaze or Watermaze software. *Note: For directory selection, you must enter **into** the directory and not just highlight it for it to be selected*

4. From here you can choose to either [(**A**)](https://github.com/MatthewBCooke/Pathfinder/blob/master/README.md#a-generating-heatmaps) generate heatmaps for the chosen trials, or to [(**B**)](https://github.com/MatthewBCooke/Pathfinder/blob/master/README.md#b-search-strategy-analysis) calculate search strategies.

### (A) Generating Heatmaps

The Pathfinder package allows for the efficient generation of heatmaps. To do so, follow these steps.

1. Click on **File** -> **Generate Heatmaps**

2. A parameters panel will appear:

![Heatmap parameters](https://live.staticflickr.com/65535/48062527642_e4e0830e3c_b.jpg)

3. The parameters panel lets you tailor the output to your needs:

    1. Grid size. This roughly translates into how many bins to put the data in. For more information on grid size see matplotlib documentation: http://matplotlib.org/devdocs/api/_as_gen/matplotlib.axes.Axes.hexbin.html

    2. Maximum Value. This will allow you to change at which value the points in the heatmap will become their most saturated (dark red). Setting 'Auto' will dynamically assign the maximum value to be equal to the value of the maximum grid.

4. You can then click generate, and our software will plot a heatmap of your trial data.

![heatmap display](https://live.staticflickr.com/65535/48062509737_a63f9288bf_b.jpg)

### (B) Search Strategy Analysis

1. For search strategy analysis we have multiple options. To set your own strategy parameters, click custom.

2. (Custom) The custom button will spawn a parameters panel

![custom parameters](https://live.staticflickr.com/65535/48062538147_b7ac36a6bd_b.jpg)

3. In the custom parameters pane, you can select and deselect any of the search strategies. Deselecting Strategies will remove them from consideration. You can also define the cutoff values for each strategy. For definitions of these values see Cooke et al., 2019, in preparation.

4. Once you have chosen your parameters, be sure to select your tracking software. Ethovision, Anymaze, and Watermaze are currently supported. (*Note: Anymaze and Watermaze are currently in beta -- not all features are available*)

5. You may then alter the main values to suit your data. Platform position, pool centre, and pool diameter can be automatically calculated for groups of non-probe trials tracked in Ethovision. For all other data you must manually define these values (Example: `Platform Position (x,y) | 6.53,-17.3`). Old platform position is only used when Perseverance is chosen in the Custom parameters pane. For more in-depth explanations of these values, see Cooke et al., 2019, in preparation.

6. There are 3 checkboxes above the **Calculate** button. The first, *Scale Values* is used to automatically scale the default values in an attempt to better match your data. This uses the Pixels/cm and the pool diameter to determine a constant C with which to multiply some parameters. (*Note: If you are using custom values, it is best to disable scaling*) The two other checkboxes enable manual categorization. Manual categorization can be used for trials in which our algorithm was unable to make a determination (**Manual categorization for uncategorized trials**) or for all trials (**Manual categorization for all trials**). 

![manual categorization](https://live.staticflickr.com/65535/48062408796_8190298e51_b.jpg)

7. Once you are satisfied with your parameters, click calculate. This will begin the process of determining search strategies for the trials. Once calculation is complete you will be shown a display of the results.

![display](https://live.staticflickr.com/65535/48062411576_4dc5da9198_b.jpg)

8. Your results will be saved as a `.csv` file with whatever name was chosen in the *Output File* field. You will also receive a log file of the excecution, and any generated paths saved in your present working directory. The CSV file will automatically open with whatever default CSV software you use.


## Motivation

This program was developed in order to simplify as well as remove inconsistencies in Morris Water Maze search strategy analysis. 

## Installation

Installing the program is easy for both macOS and Windows users.

Pathfinder requires you to have Python 3.6 or later. We highly recommend installing Conda for python via the Anaconda 🐍 package https://www.anaconda.com/distribution/. Once installed, the installation of Pathfinder is easy.

For the most recent stable version, cloning the GitHub repository or installing via PyPi is possible. For the most recent beta version of the software, the develop branch of the GitHub repository will host version currently being worked on.

Installation Instructions:

Windows:

Installing from the Python Package Index:
Launch a CMD window by launching `run` from the start menu, and typing `CMD` in Run.

Once the CMD shell has opened, type `pip install jsl-pathfinder`

Press enter

Installing from GitHub

Download and install Git here: https://git-scm.com

Open Git Bash.

Change the current working directory to the location where you want the cloned directory to be made.

Type `git clone https://github.com/MatthewBCooke/Pathfinder`

Press enter

***

Mac:

Installing from the Python Package Index:

Open a terminal window (located in your utilities folder under the Applications directory.

Type `pip install jsl-pathfinder`

Press return

Installing from GitHub

Open a terminal window Navigate to the folder you wish to install Pathfinder into

Type `git clone https://github.com/MatthewBCooke/Pathfinder/`

press return


## License

GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.
