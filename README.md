# Aviation-Route-Planning-Problem-Based-on-Improved-Floyd-s-Algorithm
Author: Wenjie Lan (leader); Zhixi Li; Xudong Yin  
A solution for Aviation-Route-Planning-Problem which won 1st place in 2022 SWUFE Mathematical Modelling Competition.
# Improved Floyd Algorithm Implementation

This repository contains an implementation of an improved Floyd-Warshall algorithm to analyze flight networks. The code includes features such as calculating shortest paths, identifying routes within a time constraint, and analyzing transfer times and frequencies.

## Files in the Repository

- `improved_floyed.m`: The main MATLAB script containing the implementation of the improved Floyd algorithm and analysis of flight routes.

---

## Overview of the Code

### Input Data

The code operates on three adjacency matrices derived from flight data:
1. **Flight Time Matrix (`A`)**: Represents flight times between cities.
2. **Departure Time Matrix (`A1`)**: Represents flight departure times.
3. **Arrival Time Matrix (`A2`)**: Represents flight arrival times.

Each matrix is populated using datasets `LL`, `LL2`, and `LL3`, respectively.

### Key Features

1. **Flight Analysis within Time Constraints**:
   - Determines the number of routes accessible within 6 hours.

2. **Analysis of Transfer Flights**:
   - Identifies routes with the maximum number of transfers.
   - Calculates the maximum number of transfers across all routes.

3. **Longest Travel Path**:
   - Finds the longest route in terms of travel time and prints its path.

4. **Improved Floyd-Warshall Algorithm**:
   - Incorporates transfer wait time into the distance calculation.
   - Handles constraints such as minimum waiting times between transfers.

---

## Functions

### Main Functions

1. **`floyd(a, A1, A2)`**
   - Inputs:
     - `a`: Adjacency matrix of flight times.
     - `A1`: Adjacency matrix of departure times.
     - `A2`: Adjacency matrix of arrival times.
   - Outputs:
     - `D`: Updated shortest distance matrix.
     - `path`: Matrix to reconstruct paths.
     - `P`: Matrix tracking the number of transfers.

2. **`road(path, v1, v2)`**
   - Inputs:
     - `path`: Matrix containing shortest path information.
     - `v1`, `v2`: Indices of the source and destination cities.
   - Output:
     - `pathway`: The reconstructed route between `v1` and `v2`.

---

## Data Structure

- **Adjacency Matrices**:
  - `A`: Flight times (in minutes).
  - `A1`: Departure times (in HHMM format).
  - `A2`: Arrival times (in HHMM format).
  - Zero entries are replaced with `inf` to signify no direct connection.
  - Diagonal entries are set to `0` for self-loops.

- **Path Matrix (`path`)**:
  - Tracks the next step in the shortest path between any two nodes.

- **Transfer Count Matrix (`P`)**:
  - Tracks the number of transfers required between any two nodes.

---

## How to Run

1. Prepare the input matrices `LL`, `LL2`, and `LL3` with flight time, departure time, and arrival time data.
2. Load the matrices into the MATLAB workspace.
3. Run the script `improved_floyed.m`.

---

## Outputs

1. **Flight Analysis**:
   - Number of routes reachable within 6 hours.
   - Maximum number of transfers required for a route.
   - Longest travel path and its duration.

2. **Path Reconstruction**:
   - The function `road` reconstructs the path for the specified source and destination nodes.

---

## Key Considerations

- **Time Format**:
  - Departure and arrival times are handled in HHMM format.
  - Conversion between time formats may be required for analysis.

- **Constraints**:
  - A minimum waiting time of 60 minutes is enforced for transfers.
  - Flights departing more than 24 hours after arrival are adjusted for an additional day's wait.
