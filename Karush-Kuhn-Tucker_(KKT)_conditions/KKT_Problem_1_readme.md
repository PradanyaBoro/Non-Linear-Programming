# Optimization Problem with KKT Conditions

## Overview
This folder contains the solution to an optimization problem using KKT conditions. The problem involves maximizing a linear objective function subject to linear constraints.

## Problem Statement
The objective function is given by:
$7x_1^2+6x_2+5x_2^2$

Subject to the following constraints:
$x_1 + 2x_2 \leq 10 \,
x_1 - 3x_2 \leq 9 \,
x_1 \, x_2 \geq 0$

Additionally, Kuhn-Tucker conditions are applied to find the optimal solution considering different cases.

## Kuhn-Tucker Conditions
The Kuhn-Tucker conditions are applied to the optimization problem with the following cases:
1. $\lambda_1 = 0, \lambda_2 = 0$
2. $\lambda_1 = 0, \lambda_2 \neq 0$
3. $\lambda_1 \neq 0, \lambda_2 = 0$
4. $\lambda_1 \neq 0, \lambda_2 \neq 0$

Each case explores the conditions for optimality, feasibility and complementary slackness.

Feel free to explore the code and adapt it to similar optimization problems.
