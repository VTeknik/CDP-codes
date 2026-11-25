# CDP-codes
# CDP-codes: RAPS Analysis for Magnetic Basement Imaging

MATLAB scripts for estimating the depth to the magnetic crystalline basement (DMB) and apparent crustal magnetic susceptibility (ACMS) from Total Magnetic Intensity (TMI) anomaly grids using Radially Averaged Power Spectrum (RAPS) analysis.

## Overview
These scripts accompany the manuscript *"Imaging magnetic crystalline basement of Australia"* submitted to *Journal of Geophysical Research: Solid Earth*. The workflow divides a gridded magnetic anomaly dataset into overlapping moving windows, computes the 2D Fourier transform and radially averaged power spectrum for each window, and fits spectral decay models using nonlinear least-squares optimization (`lsqcurvefit`) to determine depth to the top of magnetic sources and apparent susceptibility.

## Repository Contents
* `CDP4.m` — Master script that loads the TMI grid, defines sliding window parameters, executes spectral estimation, and outputs DMB and ACMS grids. *(Update with your exact script filenames)*


## Requirements
* **MATLAB:** Tested on MATLAB R2024a (compatible with R2020b or later).
* **Toolboxes:** 
  * Optimization Toolbox (required for `lsqcurvefit`)
  * Signal Processing Toolbox / Mapping Toolbox *(remove if not used)*

## How to Run
1. **Clone or download** this repository to your local machine:
   ```bash
   git clone [https://github.com/VTeknik/CDP-codes.git](https://github.com/VTeknik/CDP-codes.git)
